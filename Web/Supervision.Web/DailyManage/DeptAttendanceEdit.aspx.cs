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
using Aim.Portal.Web;

namespace SP.Web.DailyManage
{
    public partial class DeptAttendanceEdit : System.Web.UI.Page
    {
        DataTable dt;
        string Year;
        string Month;
        string DeptId;
        string sql = "";
        DeptAttendance Dent = null;
        ProjectAttendanceDetail Pdent = null;
        string id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            id = Request["id"];
            if (!string.IsNullOrEmpty(id))
            {
                Dent = DeptAttendance.Find(id);
            }
            switch (action)
            {
                case "load":
                    LoadData();
                    break;
                case "update":
                    Create();
                    break;
            }
        }
        private void LoadData()
        {
            dt = new DataTable();
            DataColumn dc = new DataColumn("ProjectName");
            dt.Columns.Add(dc);
            dc = new DataColumn("UserId");
            dt.Columns.Add(dc);
            dc = new DataColumn("UserName");
            dt.Columns.Add(dc);
            DateTime dt_cur = Convert.ToDateTime(Dent.Year + "-" + Dent.Month + "-1");
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
            sql = "select UserId,Name as UserName from  NCRL_Portal..SysUser  where Server_IAGUID='{0}' and Status=1  order by UserId asc";
            sql = string.Format(sql, Dent.BelongDeptId);
            IList<EasyDictionary> dics_user = DataHelper.QueryDictList(sql);
            foreach (EasyDictionary dic_user in dics_user)
            {
                DataRow dr = dt.NewRow();
                dr["UserId"] = dic_user.Get<string>("UserId");
                dr["UserName"] = dic_user.Get<string>("UserName");
                sql = @"select top 1 ProjectAttendanceId from NCRL_SP..ProjectAttendanceDetail where UserId='{0}' and datepart(year,AttendanceDate)='{1}' and 
                                  datepart(month,AttendanceDate)='{2}'";
                sql = string.Format(sql, dic_user.Get<string>("UserId"), Dent.Year, Dent.Month);
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
                    sql = @"select AttendanceType,ProjectAttendanceId from NCRL_SP..ProjectAttendanceDetail where UserId='{0}' and datepart(year,AttendanceDate)='{1}' and 
                                datepart(month,AttendanceDate)='{2}' and datepart(day,AttendanceDate)='{3}'";
                    sql = string.Format(sql, dic_user.Get<string>("UserId"), dt_pre.Year, dt_pre.Month, i);
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
                    sql = string.Format(sql, dic_user.Get<string>("UserId"), dt_cur.Year, dt_cur.Month, i);
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
            string title = Dent.BelongDeptName + Dent.Year + "年" + Dent.Month + "月考勤表";
            Response.Write("{success:true,rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",title:'" + title + "'}");
            Response.End();
        }
        private void Create()
        {
            if (!string.IsNullOrEmpty(id))
            {
                string result = Request["SignType"];
                Dent = DeptAttendance.Find(id);
                DateTime dt_cur = Convert.ToDateTime(Dent.Year + "-" + Dent.Month + "-1");
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
                    Pdent = new ProjectAttendanceDetail();
                    Pdent.UserId = Request["userid"];
                    Pdent.UserName = Request["username"];
                    Pdent.AttendanceDate = dt_attend;
                    Pdent.AttendanceType = Request["SignType"];
                    Pdent.DoCreate();
                }
                else
                {
                    Pdent = ProjectAttendanceDetail.Find(dics_padetail[0].Get<string>("Id"));
                    if (Pdent.AttendanceType == Request["SignType"])//如果先前是正常上班 再次点击还是正常上班 就删除
                    {
                        Pdent.DoDelete();
                        result = "";
                    }
                    else
                    {
                        Pdent.AttendanceType = Request["attendanttype"];
                        Pdent.DoUpdate();
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
        }
    }
}