using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SP.Model;
using Aim;
using Aim.Data;

namespace SP.Web.DailyManage
{
    public partial class CmpAttendEdit : System.Web.UI.Page
    {
        int totalProperty = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Aim.Portal.Web.WebPortalService.CheckLogon();
            }
            catch
            {
                Response.Write("<script> window.location.href = '/Login.aspx';</script>");
                Response.End();
            }
            string action = Request["action"];
            string sql = "";
            string id = Request["id"];
            DataTable dt = null;
            CmpAttendance caEnt = null;
            string where = "";
            ProjectAttendanceDetail padEnt = null;
            switch (action)
            {
                case "loaddetail":
                    if (!string.IsNullOrEmpty(id))
                    {
                        caEnt = CmpAttendance.Find(id);
                        dt = new DataTable();
                        DataColumn dc = new DataColumn("UserId");
                        dt.Columns.Add(dc);
                        dc = new DataColumn("DeptName");
                        dt.Columns.Add(dc);
                        dc = new DataColumn("ProjectName");
                        dt.Columns.Add(dc);
                        dc = new DataColumn("UserName");
                        dt.Columns.Add(dc);
                        DateTime dt_cur = Convert.ToDateTime(caEnt.Year + "-" + caEnt.Month + "-1");
                        DateTime dt_pre = dt_cur.AddMonths(-1);
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
                        if (!string.IsNullOrEmpty(Request["SearchValue"]))//如果是查询
                        {
                            if (Request["SearchCondition"] == "UserName")
                            {
                                where += " and Name like '%" + Request["SearchValue"] + "%'";
                            }
                            if (Request["SearchCondition"] == "DeptName")
                            {
                                where += " and Server_Seed like '%" + Request["SearchValue"] + "%'";
                            }
                            if (Request["SearchCondition"] == "ProjectName")
                            {
                                where += " and a.UserId in (select c.UserId from  NCRL_SP..ProjectAttendanceDetail c left join NCRL_SP..ProjectAttendance b on c.ProjectAttendanceId=b.Id"
                                + " where datepart(yyyy,c.AttendanceDate)='" + caEnt.Year + "' and datepart(mm,c.AttendanceDate)='" + caEnt.Month + "' and b.ProjectName like '%" + Request["SearchValue"] + "%')";
                            }
                        }
                        sql = "select a.UserId,a.Name as UserName ,a.Server_Seed as DeptName,a.Server_IAGUID from SysUser a"
                              + " where a.Server_Seed like '%江西瑞林建设监理有限公司%' and a.Status=1" + where;
                        IList<EasyDictionary> dics = DataHelper.QueryDictList(GetPageSql(sql));
                        foreach (EasyDictionary dic in dics)
                        {
                            DataRow dr = dt.NewRow();
                            dr["UserId"] = dic.Get<string>("UserId");
                            dr["UserName"] = dic.Get<string>("UserName");
                            //取该人员本年度本月所在的项目 可能是多个 
                            sql = @"select distinct ProjectAttendanceId from NCRL_SP..ProjectAttendanceDetail where UserId='{0}' and datepart(yyyy,AttendanceDate)='{1}' and 
                                  datepart(mm,AttendanceDate)='{2}'";
                            sql = string.Format(sql, dic.Get<string>("UserId"), caEnt.Year, caEnt.Month);
                            IList<EasyDictionary> dics_tmp = DataHelper.QueryDictList(sql);
                            string projectNames = "";
                            foreach (EasyDictionary dic_tmp in dics_tmp)
                            {
                                ProjectAttendance paEnt = ProjectAttendance.TryFind(dic_tmp.Get<string>("ProjectAttendanceId"));
                                if (paEnt != null)
                                {
                                    projectNames += (string.IsNullOrEmpty(projectNames) ? "" : ",") + paEnt.ProjectName;
                                }
                            }
                            dr["ProjectName"] = projectNames;
                            string deptName = dic.Get<string>("DeptName") == "江西瑞林建设监理有限公司" ? "江西瑞林建设监理有限公司" : dic.Get<string>("DeptName").Replace("江西瑞林建设监理有限公司", "");
                            dr["DeptName"] = deptName;
                            for (int i = 20; i <= days; i++)
                            {
                                sql = @"select AttendanceType,ProjectAttendanceId from NCRL_SP..ProjectAttendanceDetail where UserId='{0}' and datepart(year,AttendanceDate)='{1}' and 
                                datepart(month,AttendanceDate)='{2}' and datepart(day,AttendanceDate)='{3}'";
                                sql = string.Format(sql, dic.Get<string>("UserId"), dt_pre.Year, dt_pre.Month, i);
                                IList<EasyDictionary> dics_padetail = DataHelper.QueryDictList(sql);
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
                                sql = @"select AttendanceType,ProjectAttendanceId from NCRL_SP..ProjectAttendanceDetail where UserId='{0}' and datepart(year,AttendanceDate)='{1}' and 
                                datepart(month,AttendanceDate)='{2}' and datepart(day,AttendanceDate)='{3}'";
                                sql = string.Format(sql, dic.Get<string>("UserId"), dt_cur.Year, dt_cur.Month, i);
                                IList<EasyDictionary> dics_padetail = DataHelper.QueryDictList(sql);
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
                        string title = "江西瑞林建设监理有限公司" + caEnt.Year + "年" + caEnt.Month + "月考勤表";
                        Response.Write("{success:true,total:" + totalProperty + ",rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",title:'" + title + "'}");
                        Response.End();
                    }
                    break;
                case "update":
                    if (!string.IsNullOrEmpty(id))
                    {
                        string result = Request["attendanttype"];
                        caEnt = CmpAttendance.Find(id);
                        DateTime dt_cur = Convert.ToDateTime(caEnt.Year + "-" + caEnt.Month + "-1");
                        DateTime dt_pre = dt_cur.AddMonths(-1);
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
                        IList<EasyDictionary> dics_padetail = DataHelper.QueryDictList(sql);
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
                            padEnt.UserId = Request["userid"];
                            padEnt.UserName = Request["username"];
                            padEnt.AttendanceDate = dt_attend;
                            padEnt.AttendanceType = Request["attendanttype"];
                            padEnt.DoCreate();
                        }
                        else
                        {
                            padEnt = ProjectAttendanceDetail.Find(dics_padetail[0].Get<string>("Id"));
                            if (padEnt.AttendanceType == Request["attendanttype"])//如果先前是正常上班 再次点击还是正常上班 就删除
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
                    }
                    break;
            }
        }
        private string GetPageSql(string tempsql)
        {
            int start = Convert.ToInt32(Request["start"]);
            int limit = Convert.ToInt32(Request["limit"]);
            totalProperty = DataHelper.QueryValue<int>("select count(1) from (" + tempsql + ") t");
            string order = " Server_IAGUID";
            string asc = " asc";
            string pageSql = @"
		    WITH OrderedOrders AS
		    (SELECT *,
		    ROW_NUMBER() OVER (order by {0} {1})as RowNumber
		    FROM ({2}) temp ) 
		    SELECT * 
		    FROM OrderedOrders 
		    WHERE RowNumber between {3} and {4}";
            pageSql = string.Format(pageSql, order, asc, tempsql, start + 1, limit + start);
            return pageSql;
        }
    }
}