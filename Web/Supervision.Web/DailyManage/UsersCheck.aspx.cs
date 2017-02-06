using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SP.Model;
using Aim.Data;
using Aim;
using Aim.Portal.Web;
using System.Data;

namespace SP.Web.DailyManage
{
    public partial class UsersCheck : System.Web.UI.Page
    {
        ProjectAttendanceDetail Pdent = null;
        CmpAttendance Cent = null;
        string sql = "";
        IList<EasyDictionary> dics;
        IList<EasyDictionary> Cmps;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "create":
                        Create();
                        break;
                    case "SelectData":
                        SelectData();
                        break;
                    case "delete":
                        Delete();
                        break;
                }
            }
        }
        private void Delete()
        {
            string ComId = Request["ComId"];
            string ids = Request["jarray"];
            string[] IdArray = ids.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            for (int i = 0; i < IdArray.Length; i++)
            {
                sql = "delete NCRL_SP..ProjectAttendanceDetail where  UserId='" + IdArray[i] + "'and  ProjectAttendanceId ='" + ComId + "'";
                DataHelper.ExecSql(sql);
            }
        }
        private void Create()
        {
            string Year = Request["Year"];
            string Month = Request["Month"];
            string day = Request["day"];
            string UserId = Request["UserId"];
            string UserName = Request["UserName"];
            string SignType = Request["SignType"];
            sql = "select * from NCRL_SP..CmpAttendance where Year =" + Year + " and Month= " + Month;
            Cmps = DataHelper.QueryDictList(sql);
            string ComId;
            if (Cmps.Count <= 0)
            {
                Cent = new CmpAttendance();
                Cent.Year = Convert.ToInt32(Year);
                Cent.Month = Convert.ToInt32(Month);
                Cent.DoCreate();
                ComId = Cent.Id;
            }
            else
            {
                ComId = Cmps[0].Get<string>("Id");
            }
            sql = "select * from NCRL_SP..ProjectAttendanceDetail where UserId='" + UserId + "'and CONVERT(varchar(10), AttendanceDate,120)='" + Convert.ToDateTime(Year + "-" + Month + "-" + day).ToString("yyyy-MM-dd") + "' and ProjectAttendanceId='" + ComId + "'";
            IList<EasyDictionary> dicss = DataHelper.QueryDictList(sql);
            if (dicss.Count > 0)
            {
                Pdent = ProjectAttendanceDetail.Find(dicss[0].Get<string>("Id"));
                if (Pdent.AttendanceType != SignType)
                {
                    Pdent.AttendanceType = SignType;
                }
                else
                {
                    sql = "delete NCRL_SP..ProjectAttendanceDetail where  UserId='" + UserId + "'and CONVERT(varchar(10), AttendanceDate,120)='" + Convert.ToDateTime(Year + "-" + Month + "-" + day).ToString("yyyy-MM-dd") + "' and ProjectAttendanceId='" + ComId + "'";
                    DataHelper.ExecSql(sql);
                    return;
                }

                Pdent.CreateTime = System.DateTime.Now;
                Pdent.DoUpdate();
            }
            else
            {
                Pdent = new ProjectAttendanceDetail();
                Pdent.UserId = UserId;
                Pdent.UserName = UserName;
                Pdent.ProjectAttendanceId = ComId;
                Pdent.AttendanceType = SignType;
                Pdent.AttendanceDate = Convert.ToDateTime(Year + "-" + Month + "-" + day);
                Pdent.CreateId = WebPortalService.CurrentUserInfo.UserID;
                Pdent.CreateName = WebPortalService.CurrentUserInfo.Name;
                Pdent.CreateTime = DateTime.Now;
                Pdent.Description = "非项目人员考勤";
                Pdent.DoCreate();

            }
            Response.Write("{success:  true  ,ComId:'" + ComId + "'}");
            Response.End();
        }
        private void SelectData()
        {
            string Year = Request["Year"];
            string Month = Request["Month"];
            if (!string.IsNullOrEmpty(Year) && !string.IsNullOrEmpty(Month))
            {
                sql = "select UserName,UserId,ProjectAttendanceId from NCRL_SP..ProjectAttendanceDetail where ProjectAttendanceId in (select Id from NCRL_SP..CmpAttendance where Year =" + Year + " and Month= " + Month + ") group by UserName,UserId,ProjectAttendanceId";
                dics = DataHelper.QueryDictList(sql);
                if (dics.Count > 0)
                {
                    SetPageUI();
                    for (int i = 0; i < dics.Count; i++)
                    {
                        DataRow dr = dt.NewRow();
                        dr["UserId"] = dics[i].Get<string>("UserId");
                        dr["UserName"] = dics[i].Get<string>("UserName");
                        sql = "select Name from NCRL_Portal..SysGroup where GroupID in (Select GroupID from NCRL_Portal..SysUserGroup where UserID= '" + dics[i].Get<string>("UserId") + "')";
                        IList<EasyDictionary> name = DataHelper.QueryDictList(sql);
                        dr["DeptName"] = name[0].Get<string>("Name");
                        dr["ComId"] = dics[i].Get<string>("ProjectAttendanceId");
                        IList<ProjectAttendanceDetail> padEnts = ProjectAttendanceDetail.FindAllByProperties(ProjectAttendanceDetail.Prop_ProjectAttendanceId, dics[i].Get<string>("ProjectAttendanceId"), ProjectAttendanceDetail.Prop_UserId, dics[i].Get<string>("UserId"));
                        foreach (ProjectAttendanceDetail padEnt in padEnts)
                        {
                            string adate = "c" + padEnt.AttendanceDate.Value.Day;
                            dr[adate] = padEnt.AttendanceType;
                        }
                        dt.Rows.Add(dr);
                    }
                    string str = JsonHelper.GetJsonStringFromDataTable(dt);
                    string json = "{\"rows\":" + str + "}";
                    Response.Write(json);
                    Response.End();
                }
                else
                {
                    DateTime time = new DateTime(Convert.ToInt32(Year), Convert.ToInt32(Month), 1);
                    time = time.AddMonths(-1);
                    sql = "select UserName,UserId from NCRL_SP..ProjectAttendanceDetail where ProjectAttendanceId in (select Id from NCRL_SP..CmpAttendance where Year =" + time.Year.ToString() + " and Month= " + time.Month.ToString() + ") group by UserName,UserId";
                    dics = DataHelper.QueryDictList(sql);
                    if (dics.Count > 0)
                    {
                        SetPageUI();
                        for (int i = 0; i < dics.Count; i++)
                        {
                            DataRow dr = dt.NewRow();
                            dr["UserId"] = dics[i].Get<string>("UserId");
                            dr["UserName"] = dics[i].Get<string>("UserName");
                            sql = "select Name from NCRL_Portal..SysGroup where GroupID in (Select GroupID from NCRL_Portal..SysUserGroup where UserID= '" + dics[i].Get<string>("UserId") + "')";
                            IList<EasyDictionary> name = DataHelper.QueryDictList(sql);
                            dr["DeptName"] = name[0].Get<string>("Name");
                            dt.Rows.Add(dr);
                        }
                    }
                    string str = JsonHelper.GetJsonStringFromDataTable(dt);
                    string json = "{\"rows\":" + str + "}";
                    Response.Write(json);
                    Response.End();

                }
            }

        }
        private void SetPageUI()
        {

            dt = new DataTable();
            DataColumn dc = new DataColumn("UserId");
            dt.Columns.Add(dc);
            dc = new DataColumn("UserName");
            dt.Columns.Add(dc);
            dc = new DataColumn("ComId");
            dt.Columns.Add(dc);
            for (int i = 26; i < 32; i++)
            {
                dc = new DataColumn("c" + i);
                dt.Columns.Add(dc);
            }
            for (int i = 1; i < 26; i++)
            {
                dc = new DataColumn("c" + i);
                dt.Columns.Add(dc);
            }
            dc = new DataColumn("DeptName");
            dt.Columns.Add(dc);
        }
    }
}