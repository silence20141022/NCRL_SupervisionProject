﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Aim.Data;
using Aim;
using SP.Model;
using Newtonsoft.Json.Linq;

namespace SP.Web.DailyManage
{
    public partial class DeptAttendanceCard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            string id = Request["id"];
            string userid = Request["userid"];
            string sql = "";
            DataTable dt = null;
            DeptAttendance daEnt = null;
            ProjectAttendanceDetail padEnt = null;
            DateTime dt_cur = new DateTime();
            DateTime dt_pre = new DateTime();
            IList<EasyDictionary> dics_padetail = null; 
            if (!string.IsNullOrEmpty(id))
            {
                daEnt = DeptAttendance.Find(id);
            }
            switch (action)
            {
                case "loaddept":
                    sql = @"select GroupId as BelongDeptId,REPLACE(Name,'江西瑞林建设监理有限公司','') as BelongDeptName from SysGroup  where GroupId!=228 and GroupId!=267";    
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{'rows':" + JsonHelper.GetJsonString(dt) + "}");
                    Response.End();
                    break;
                case "loadyear":
                    sql = "select value as year from NCRL_Portal..SysEnumeration where ParentId='058fbee9-0a9a-4b25-b343-ea8c05396632' order by SortIndex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "loadmonth":
                    sql = "select value as month from NCRL_Portal..SysEnumeration where ParentId='b25e537b-34e3-4437-87af-692e00facd73' order by SortIndex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "create":
                    daEnt = JsonHelper.GetObject<DeptAttendance>(Request["formdata"]);
                    daEnt.CreateTime = DateTime.Now;
                    daEnt.DoCreate(); 
                    Response.Write("{success:true,id:'" + daEnt.Id + "'}");
                    Response.End();
                    break;
                case "update":
                    daEnt = JsonHelper.GetObject<DeptAttendance>(Request["formdata"]);
                    DeptAttendance originalEnt = DeptAttendance.Find(daEnt.Id);
                    EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(Request["formdata"]);
                    originalEnt = DataHelper.MergeData<DeptAttendance>(originalEnt, daEnt, dic.Keys);
                    originalEnt.DoUpdate();
                    Response.Write("{success:true,id:'" + daEnt.Id + "'}");
                    Response.End();
                    break;
                case "loadform":
                    daEnt = DeptAttendance.Find(id);
                    Response.Write("{success:true,data:" + JsonHelper.GetJsonString(daEnt) + "}");
                    Response.End();
                    break;
                case "inigrid":
                    dt = new DataTable();
                    DataColumn dc = new DataColumn("UserId");  
                    dt.Columns.Add(dc);
                    dc = new DataColumn("UserName");
                    dt.Columns.Add(dc);  
                    dc =new DataColumn("ProjectName");
                    dt.Columns.Add(dc);
                    dt_cur = Convert.ToDateTime(daEnt.Year + "-" + daEnt.Month + "-1");
                    dt_pre = dt_cur.AddMonths(-1);
                    int days = DateTime.DaysInMonth(dt_pre.Year, dt_pre.Month);
                    for (int i = 20; i <= days; i++)
                    {
                        dc = new DataColumn("C" + i);
                        dt.Columns.Add(dc);
                    }
                    for (int i = 1; i <= 19; i++)
                    {
                        dc = new DataColumn("C" + i);
                        dt.Columns.Add(dc);
                    }    
                    if(daEnt.Status=="已归档") //如果部门考勤已经存在且已归档
                    {
                        sql = "select distinct UserId,UserName from  NCRL_SP..ProjectAttendanceDetail  where ProjectAttendanceId='" + id + "' order by UserId asc";
                    }           
                    else//如果没有归档
                    {
                        sql = "select UserId,Name as UserName from  NCRL_Portal..SysUser  where Server_IAGUID='"+daEnt.BelongDeptId+"' and Status=1  order by UserId asc";
                    }
                    IList<EasyDictionary> dics_user = DataHelper.QueryDictList(sql);
                    foreach (EasyDictionary dic_user in dics_user)
                    {
                        DataRow dr = dt.NewRow();
                        dr["UserId"] = dic_user.Get<string>("UserId");
                        dr["UserName"] = dic_user.Get<string>("UserName");
                        sql = @"select top 1 ProjectAttendanceId from NCRL_SP..ProjectAttendanceDetail where UserId='{0}' and datepart(year,AttendanceDate)='{1}' and 
                              datepart(month,AttendanceDate)='{2}'";
                        sql = string.Format(sql, dic_user.Get<string>("UserId"), daEnt.Year, daEnt.Month);
                        if (!string.IsNullOrEmpty(DataHelper.QueryValue<string>(sql)))
                        {
                            ProjectAttendance paEnt = ProjectAttendance.TryFind(DataHelper.QueryValue<string>(sql));
                            if (paEnt != null)
                            {
                                dr["ProjectName"] = paEnt.ProjectName;
                            }
                        }
                        for (int i = 20; i <= days; i++)
                        {
                            sql = @"select AttendanceType from NCRL_SP..ProjectAttendanceDetail where UserId='{0}' and datepart(year,AttendanceDate)='{1}' and 
                                  datepart(month,AttendanceDate)='{2}' and datepart(day,AttendanceDate)='{3}' ";
                            sql = string.Format(sql, dic_user.Get<string>("UserId"), dt_pre.Year, dt_pre.Month, i);//and, id ProjectAttendanceId='{4}'
                            dics_padetail = DataHelper.QueryDictList(sql);
                            string attendtype = "";
                            if (dics_padetail.Count > 0)
                            {
                                switch (dics_padetail[0].Get<string>("AttendanceType"))
                                {
                                    case "正常上班":
                                        attendtype = "√";
                                        break;
                                    case "请假":
                                        attendtype = "!";
                                        break;
                                    case "其他":
                                        attendtype = "×";
                                        break;
                                }
                            }
                            dr["C" + i] = attendtype;
                        }
                        for (int i = 1; i <= 19; i++)
                        {
                            sql = @"select AttendanceType from NCRL_SP..ProjectAttendanceDetail where UserId='{0}' and datepart(year,AttendanceDate)='{1}' and 
                                datepart(month,AttendanceDate)='{2}' and datepart(day,AttendanceDate)='{3}'";
                            sql = string.Format(sql, dic_user.Get<string>("UserId"), dt_cur.Year, dt_cur.Month, i); //, idand ProjectAttendanceId='{4}'
                            dics_padetail = DataHelper.QueryDictList(sql);
                            string attendtype = "";
                            if (dics_padetail.Count > 0)
                            {
                                switch (dics_padetail[0].Get<string>("AttendanceType"))
                                {
                                    case "正常上班":
                                        attendtype = "√";
                                        break;
                                    case "请假":
                                        attendtype = "!";
                                        break;
                                    case "其他":
                                        attendtype = "×";
                                        break;
                                }
                            }
                            dr["C" + i] = attendtype;
                        }
                        dt.Rows.Add(dr);
                    }
                    string title = daEnt.BelongDeptName + daEnt.Year + "年" + daEnt.Month + "月考勤表";
                    Response.Write("{success:true,columns:" + JsonHelper.GetJsonString(dt.Columns) + ",rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",title:'" + title + "'}");
                    Response.End();
                    break;
                case "updatedetail":
                    string result = Request["SignType"];
                    daEnt = DeptAttendance.Find(id);
                    dt_cur = Convert.ToDateTime(daEnt.Year + "-" + daEnt.Month + "-1");
                    dt_pre = dt_cur.AddMonths(-1);
                    int day = Convert.ToInt32(Request["day"]);
                    sql = @"select * from NCRL_SP..ProjectAttendanceDetail where UserId='{0}' and datepart(year,AttendanceDate)='{1}' and 
                                datepart(month,AttendanceDate)='{2}' and datepart(day,AttendanceDate)='{3}'";
                    if (day > 19)
                    {
                        sql = string.Format(sql, Request["userid"], dt_pre.Year, dt_pre.Month, Request["day"]);
                    }
                    else
                    {
                        sql = string.Format(sql, Request["userid"], dt_cur.Year, dt_cur.Month, Request["day"]);
                    }
                    dics_padetail = DataHelper.QueryDictList(sql);
                    if (dics_padetail.Count == 0)
                    {
                        DateTime? dt_attend = null;
                        if (day > 19)
                        {
                            dt_attend = Convert.ToDateTime(dt_pre.Year + "-" + dt_pre.Month + "-" + Request["day"]);
                        }
                        else
                        {
                            dt_attend = Convert.ToDateTime(dt_cur.Year + "-" + dt_cur.Month + "-" + Request["day"]);
                        }
                        padEnt = new ProjectAttendanceDetail();
                        padEnt.ProjectAttendanceId = id;
                        padEnt.UserId = Request["userid"];
                        padEnt.UserName = Request["username"];
                        padEnt.AttendanceDate = dt_attend;
                        padEnt.AttendanceType = Request["SignType"];
                        padEnt.DoCreate();
                    }
                    else
                    {
                        padEnt = ProjectAttendanceDetail.Find(dics_padetail[0].Get<string>("Id"));
                        if (padEnt.AttendanceType == Request["SignType"])//如果先前是正常上班 再次点击还是正常上班 就删除
                        {
                            padEnt.DoDelete();
                            result = "";
                        }
                        else
                        {
                            padEnt.AttendanceType = Request["attendanttype"];
                            padEnt.DoUpdate();
                        }
                    }
                    switch (result)
                    {
                        case "正常上班":
                            result = "√";
                            break;
                        case "请假":
                            result = "!";
                            break;
                        case "其他":
                            result = "×";
                            break;
                    }
                    Response.Write("{success:true,result:'" + result + "'}");
                    Response.End();
                    break;
                case "delete":
                    sql = "delete NCRL_SP..ProjectAttendanceDetail where UserId='{0}' and ProjectAttendanceId='{1}' ";
                    sql = string.Format(sql, userid, id);
                    DataHelper.ExecSql(sql); 
                    break; 
            }
        }
    }
}