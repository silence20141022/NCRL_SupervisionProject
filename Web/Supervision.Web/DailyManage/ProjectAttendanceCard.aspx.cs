using System;
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
    public partial class ProjectAttendanceCard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            string id = Request["id"];
            string userid = Request["userid"];
            string sql = "";
            DataTable dt = null;
            ProjectAttendance paEnt = null;
            ProjectAttendanceDetail padEnt = null;
            DateTime dt_cur = new DateTime();
            DateTime dt_pre = new DateTime();
            IList<EasyDictionary> dics_padetail = null;
            IList<ProjectUser> puEnts = null;
            if (!string.IsNullOrEmpty(id))
            {
                paEnt = ProjectAttendance.Find(id);
            }
            switch (action)
            {
                case "loadproject":
                    sql = @"select Id as ProjectId,PManagerId,ProjectName,PManagerName,BelongDeptId,BelongDeptName from NCRL_SP..Project";
                    dt = DataHelper.QueryDataTable(sql);
                    string data_prj = JsonHelper.GetJsonString(dt);
                    sql = "select value as year from NCRL_Portal..SysEnumeration where ParentId='058fbee9-0a9a-4b25-b343-ea8c05396632' order by SortIndex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    string data_year = JsonHelper.GetJsonString(dt);
                    sql = "select value as month from NCRL_Portal..SysEnumeration where ParentId='b25e537b-34e3-4437-87af-692e00facd73' order by SortIndex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    string data_month = JsonHelper.GetJsonString(dt);
                    Response.Write("{'rows':" + data_prj + ",year:" + data_year + ",month:" + data_month + "}");
                    Response.End();
                    break;
                //case "loadyear":
                //    sql = "select value as year from NCRL_Portal..SysEnumeration where ParentId='058fbee9-0a9a-4b25-b343-ea8c05396632' order by SortIndex asc";
                //    dt = DataHelper.QueryDataTable(sql);
                //    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                //    Response.End();
                //    break;
                //case "loadmonth":
                //    sql = "select value as month from NCRL_Portal..SysEnumeration where ParentId='b25e537b-34e3-4437-87af-692e00facd73' order by SortIndex asc";
                //    dt = DataHelper.QueryDataTable(sql);
                //    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                //    Response.End();
                //    break;
                case "create":
                    paEnt = JsonHelper.GetObject<ProjectAttendance>(Request["formdata"]);
                    paEnt.DoCreate();//创建完项目阶段考勤后 自动创建本阶段项目所属部门考勤和公司考勤
                    Project pEnt = Project.Find(paEnt.ProjectId);
                    if (pEnt.BelongDeptId != "228")//有些项目的所属部门是监理公司
                    {
                        IList<DeptAttendance> daEnts = DeptAttendance.FindAllByProperties(DeptAttendance.Prop_Year, paEnt.Year, DeptAttendance.Prop_Month, paEnt.Month, DeptAttendance.Prop_BelongDeptId, pEnt.BelongDeptId);
                        if (daEnts.Count == 0)
                        {
                            DeptAttendance daEnt = new DeptAttendance();
                            daEnt.Year = paEnt.Year;
                            daEnt.Month = paEnt.Month;
                            daEnt.BelongDeptId = pEnt.BelongDeptId;
                            daEnt.BelongDeptName = pEnt.BelongDeptName;
                            daEnt.CreateTime = DateTime.Now;
                            daEnt.DoCreate();
                        }
                    }
                    IList<CmpAttendance> caEnts = CmpAttendance.FindAllByProperties(CmpAttendance.Prop_Year, paEnt.Year, CmpAttendance.Prop_Month, paEnt.Month);
                    if (caEnts.Count == 0)
                    {
                        CmpAttendance caEnt = new CmpAttendance();
                        caEnt.Year = paEnt.Year;
                        caEnt.Month = paEnt.Month;
                        caEnt.DoCreate();
                    }
                    Response.Write("{success:true,id:'" + paEnt.Id + "'}");
                    Response.End();
                    break;
                case "update":
                    paEnt = JsonHelper.GetObject<ProjectAttendance>(Request["formdata"]);
                    ProjectAttendance originalEnt = ProjectAttendance.Find(paEnt.Id);
                    EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(Request["formdata"]);
                    originalEnt = DataHelper.MergeData<ProjectAttendance>(originalEnt, paEnt, dic.Keys);
                    originalEnt.DoUpdate();
                    Response.Write("{success:true,id:'" + paEnt.Id + "'}");
                    Response.End();
                    break;
                case "loadform":
                    paEnt = ProjectAttendance.Find(id);
                    Response.Write("{success:true,data:" + JsonHelper.GetJsonString(paEnt) + "}");
                    Response.End();
                    break;
                case "inigrid":
                    dt = new DataTable();
                    DataColumn dc = new DataColumn("UserId");
                    dt.Columns.Add(dc);
                    dc = new DataColumn("UserName");
                    dt.Columns.Add(dc);
                    dt_cur = Convert.ToDateTime(paEnt.Year + "-" + paEnt.Month + "-1");
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
                    IList<ProjectAttendanceDetail> padEnts = ProjectAttendanceDetail.FindAllByProperty(ProjectAttendanceDetail.Prop_UserName, ProjectAttendanceDetail.Prop_ProjectAttendanceId, id);
                    if (padEnts.Count > 0)
                    {
                        sql = "select distinct UserId,UserName from  NCRL_SP..ProjectAttendanceDetail  where ProjectAttendanceId='" + id + "' order by UserId asc";
                    }
                    else
                    {
                        sql = "select UserId,UserName from NCRL_SP..ProjectUser where ProjectId='" + paEnt.ProjectId + "' order by UserId asc";
                    }
                    IList<EasyDictionary> dics_user = DataHelper.QueryDictList(sql);
                    foreach (EasyDictionary dic_user in dics_user)
                    {
                        DataRow dr = dt.NewRow();
                        dr["UserId"] = dic_user.Get<string>("UserId");
                        dr["UserName"] = dic_user.Get<string>("UserName");
                        for (int i = 20; i <= days; i++)
                        {
                            sql = @"select AttendanceType from NCRL_SP..ProjectAttendanceDetail where UserId='{0}' and datepart(year,AttendanceDate)='{1}' and 
                                  datepart(month,AttendanceDate)='{2}' and datepart(day,AttendanceDate)='{3}' and ProjectAttendanceId='{4}'";
                            sql = string.Format(sql, dic_user.Get<string>("UserId"), dt_pre.Year, dt_pre.Month, i, id);
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
                                datepart(month,AttendanceDate)='{2}' and datepart(day,AttendanceDate)='{3}' and ProjectAttendanceId='{4}'";
                            sql = string.Format(sql, dic_user.Get<string>("UserId"), dt_cur.Year, dt_cur.Month, i, id);
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
                    string title = paEnt.ProjectName + paEnt.Year + "年" + paEnt.Month + "月考勤表";
                    Response.Write("{success:true,columns:" + JsonHelper.GetJsonString(dt.Columns) + ",rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",title:'" + title + "'}");
                    Response.End();
                    break;
                case "updatedetail":
                    string result = Request["SignType"];
                    paEnt = ProjectAttendance.Find(id);
                    dt_cur = Convert.ToDateTime(paEnt.Year + "-" + paEnt.Month + "-1");
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
                    puEnts = ProjectUser.FindAllByProperties(ProjectUser.Prop_UserId, userid, ProjectUser.Prop_ProjectId, paEnt.ProjectId);
                    if (puEnts.Count > 0)
                    {
                        puEnts[0].DoDelete();
                    }
                    break;
                case "updateprojectuser":
                    puEnts = ProjectUser.FindAllByProperties(ProjectUser.Prop_UserId, userid, ProjectUser.Prop_ProjectId, paEnt.ProjectId);
                    if (puEnts.Count == 0)
                    {
                        ProjectUser puEnt = new ProjectUser();
                        puEnt.UserId = userid;
                        puEnt.UserName = Request["username"];
                        puEnt.ProjectId = paEnt.ProjectId;
                        puEnt.DoCreate();
                    }
                    break;
            }
        }
    }
}