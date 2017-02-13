using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Aim.Data;
using Aim;
using Aim.Portal.Web;
using SP.Model;
using Newtonsoft.Json.Linq;

namespace SP.Web.DailyManage
{
    public partial class ProjectAttendanceEdit : System.Web.UI.Page
    {
        string Id = "";
        string where = "";
        string sql = "";
        DataTable dt;
        ProjectAttendance Pent = null;
        DeptAttendance dent = null;
        CmpAttendance cent = null;
        ProjectAttendanceDetail ents = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "PNameCombo":
                        PNameCombo();
                        break;
                    case "FormLoad":
                        FormLoad();
                        break;
                    case "DoGrid":
                        DoGrid();
                        break;
                    case "delete":
                        Delete();
                        break;
                    case "create":
                        Create();
                        break;
                    case "ProjectUser":
                        ProjectUser();
                        break;
                    case "SelectData":
                        SelectData();
                        break;
                    case "CheckUser":
                        CheckUser();
                        break;
                }
            }
        }
        private void CheckUser()
        {
            string ProjectId = Request["ProjectId"];
            string Month = Request["Month"];
            string Year = Request["Year"];
            sql = @"select * from NCRL_SP..ProjectAttendance where Year='" + Convert.ToInt32(Year) + "' and Month='" + Convert.ToInt32(Month) + "' and ProjectId='" + ProjectId + "'";
            DataTable dt1 = DataHelper.QueryDataTable(sql);
            if (dt1.Rows.Count > 0)
            {
                Response.Write("{success:  true  ,msg:'false'}");
                Response.End();
                return;
            }
            Response.Write("{success:  true  ,msg:'true'}");
            Response.End();
        }
        private void Delete()
        {
            DataTable row = null;
            string ProjectId = Request["ProjectId"];
            string ProjectAttendanceID = Request["Id"];
            string str = Request["jarray"];
            string[] usArrary = str.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);

            for (int i = 0; i < usArrary.Length; i++)
            {
                sql = "select * from NCRL_SP..ProjectUser where ProjectId='" + ProjectId + "' and UserId = '" + usArrary[i] + "'";
                row = DataHelper.QueryDataTable(sql);
                if (row.Rows.Count > 0)
                {
                    sql = "delete NCRL_SP..ProjectUser where ProjectId='" + ProjectId + "' and UserId = '" + usArrary[i] + "'";
                    DataHelper.ExecSql(sql);
                }
                if (!string.IsNullOrEmpty(ProjectAttendanceID))
                {
                    sql = "select * from NCRL_SP..ProjectAttendanceDetail where UserId = '" + usArrary[i] + "' and ProjectAttendanceId='" + ProjectAttendanceID + "'";
                    row = DataHelper.QueryDataTable(sql);
                    if (row.Rows.Count > 0)
                    {
                        sql = "delete NCRL_SP..ProjectAttendanceDetail where UserId = '" + usArrary[i] + "' and ProjectAttendanceId='" + ProjectAttendanceID + "'";
                        DataHelper.ExecSql(sql);
                    }
                }
            }
        }
        private void SelectData()
        {
            string ProjectId = Request["ProjectId"];
            string Month = Request["Month"];
            string Year = Request["Year"];
            sql = @"select * from NCRL_SP..ProjectAttendance where Year='" + Convert.ToInt32(Year) + "' and Month='" + Convert.ToInt32(Month) + "' and ProjectId='" + ProjectId + "'";
            DataTable dt1 = DataHelper.QueryDataTable(sql);
            if (dt1.Rows.Count > 0)
            {
                Response.Write("{success:  true  ,msg:'false'}");
                Response.End();
                return;
            }
            dt = new DataTable();
            DataColumn dc = new DataColumn("Id");
            dt.Columns.Add(dc);
            dc = new DataColumn("UserId");
            dt.Columns.Add(dc);
            dc = new DataColumn("UserName");
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
            dc = new DataColumn("SumDay");
            dt.Columns.Add(dc);
            dc = new DataColumn("monthAdd");
            dt.Columns.Add(dc);
            if (!string.IsNullOrEmpty(ProjectId))
            {
                sql = "select UserId,UserName from NCRL_SP..ProjectUser where ProjectId='" + ProjectId + "'";
                DataTable count = DataHelper.QueryDataTable(sql);
                if (count.Rows.Count > 0)
                {
                    for (int i = 0; i < count.Rows.Count; i++)
                    {
                        DataRow dr = dt.NewRow();
                        dr["UserId"] = count.Rows[i].ItemArray[0];
                        dr["UserName"] = count.Rows[i].ItemArray[1];
                        int sumday = 0;
                        dr["SumDay"] = sumday;
                        //IList<ProjectAttendanceDetail> padEnts = ProjectAttendanceDetail.FindAllByProperties(ProjectAttendanceDetail.Prop_ProjectAttendanceId, Pent.Id, ProjectAttendanceDetail.Prop_UserId, count.Rows[i].ItemArray[0]);
                        //foreach (ProjectAttendanceDetail padEnt in padEnts)
                        //{
                        //    string adate = "c" + padEnt.AttendanceDate.Value.Day;
                        //    dr[adate] = padEnt.AttendanceType;
                        //    dr["Id"] = padEnt.Id;
                        //    sumday++;
                        //}
                        dt.Rows.Add(dr);
                    }
                }
            }
            string str = JsonHelper.GetJsonStringFromDataTable(dt);
            string json = "{\"rows\":" + str + "}";
            Response.Write(json);
            Response.End();

        }
        private void ProjectUser()
        {
            ProjectUser pjent;
            string data = Request["ProjectUsers"];
            string ProjectId = Request["ProjectId"];
            sql = "select * from  NCRL_SP..ProjectUser where ProjectId = '" + ProjectId + "'";
            dt = DataHelper.QueryDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                sql = "delete NCRL_SP..ProjectUser where ProjectId = '" + ProjectId + "'";
                DataHelper.ExecSql(sql);

            }
            JArray ja = JsonHelper.GetObject<JArray>(data);
            foreach (JObject jo in ja)
            {
                pjent = JsonHelper.GetObject<ProjectUser>(jo.ToString());
                pjent.ProjectId = ProjectId;
                pjent.DoCreate();
            }
        }
        private void Create()
        {
            string Year = Request["Year"];
            string Month = Request["Month"];
            string day = Request["day"];
            string SignType = Request["SignType"];
            string ProjectId = Request["ProjectId"];
            string UserId = Request["UserId"];
            string UserName = Request["UserName"];
            string Attachment = Request["Attachment"];
            string Remark = Request["Remark"];
            string Id = Request["Id"];
            Project ProEnt = Project.Find(ProjectId);
            //查询是否存在该项目该年此月份的考勤
            sql = @"select * from NCRL_SP..ProjectAttendance where Year='" + Convert.ToInt32(Year) + "' and Month='" + Convert.ToInt32(Month) + "' and ProjectId='" + ProjectId + "'";
            DataTable dt = DataHelper.QueryDataTable(sql);
            //查询是否存在该部门本该年此月份的考勤
            sql = @"select Id from NCRL_SP..DeptAttendance where Year='" + Convert.ToInt32(Year) + "'and Month='" + Convert.ToInt32(Month) + "' and BelongDeptId ='" + ProEnt.BelongDeptId + "'";
            DataTable da = DataHelper.QueryDataTable(sql);
            //查询本公司是否存在该年此月份的考勤
            sql = @"select  * from NCRL_SP..CmpAttendance where Year='" + Convert.ToInt32(Year) + "'and Month='" + Convert.ToInt32(Month) + "'";
            DataTable ca = DataHelper.QueryDataTable(sql);

            if (string.IsNullOrEmpty(Id))
            {
                if (dt.Rows.Count > 0)
                {

                    return;
                }
                Pent = new ProjectAttendance();
                Pent.Attachment = Attachment;
                Pent.Remark = Remark;
                Pent.ProjectId = ProjectId;
                Pent.ProjectName = ProEnt.ProjectName;
                Pent.Year = Convert.ToInt32(Year);
                Pent.Month = Convert.ToInt32(Month);
                Pent.PManagerName = ProEnt.PManagerName;
                Pent.BelongDeptId = ProEnt.BelongDeptId;
                Pent.BelongDeptName = ProEnt.BelongDeptName;
                Pent.CreateId = WebPortalService.CurrentUserInfo.UserID;
                Pent.CreateName = WebPortalService.CurrentUserInfo.Name;
                Pent.CreateTime = DateTime.Now;
                Pent.DoCreate();
                if (da.Rows.Count <= 0)
                {
                    dent = new DeptAttendance();
                    dent.Year = Convert.ToInt32(Year);
                    dent.Month = Convert.ToInt32(Month);
                    dent.BelongDeptId = Pent.BelongDeptId;
                    dent.BelongDeptName = Pent.BelongDeptName;
                    dent.DoCreate();
                }
                if (ca.Rows.Count <= 0)
                {
                    cent = new CmpAttendance();
                    cent.Year = Convert.ToInt32(Year);
                    cent.Month = Convert.ToInt32(Month);
                    cent.DoCreate();
                }
            }
            else
            {
                Pent = ProjectAttendance.Find(Id);
                if (Pent.Attachment != Attachment || Pent.Remark != Remark)
                {
                    Pent.Attachment = Attachment;
                    Pent.Remark = Remark;
                    Pent.DoUpdate();
                }
            }

            sql = "select * from NCRL_SP..ProjectAttendanceDetail where UserId='" + UserId + "'and CONVERT(varchar(10), AttendanceDate,120)='" + Convert.ToDateTime(Year + "-" + Month + "-" + day).ToString("yyyy-MM-dd") + "' and ProjectAttendanceId<>'" + Id + "' or ProjectAttendanceId is null ";
            IList<EasyDictionary> dicss = DataHelper.QueryDictList(sql);
            if (dicss.Count > 0)
            {
                ents = ProjectAttendanceDetail.Find(dicss[0].Get<string>("Id"));
                ents.AttendanceType = SignType;
                if (!string.IsNullOrEmpty(Id))
                {
                    ents.ProjectAttendanceId = Id;
                }
                else
                {
                    ents.ProjectAttendanceId = Pent.Id;
                }
                ents.Description = "";
                ents.DoUpdate();

                if (!string.IsNullOrEmpty(Id))
                {
                    Response.Write("{success:  true  ,id:'" + Id + "'}");
                    Response.End();
                    return;
                }
                Response.Write("{success:  true  ,id:'" + Pent.Id + "'}");
                Response.End();
                return;
            }

            sql = "select * from NCRL_SP..ProjectAttendanceDetail where UserId='" + UserId + "'and CONVERT(varchar(10), AttendanceDate,120)='" + Convert.ToDateTime(Year + "-" + Month + "-" + day).ToString("yyyy-MM-dd") + "' and ProjectAttendanceId='" + Id + "'";
            dicss = DataHelper.QueryDictList(sql);
            if (dicss.Count > 0)
            {
                ents = ProjectAttendanceDetail.Find(dicss[0].Get<string>("Id"));
                if (ents.AttendanceType != SignType)
                {
                    ents.AttendanceType = SignType;
                }
                else
                {
                    sql = "delete NCRL_SP..ProjectAttendanceDetail where  UserId='" + UserId + "'and CONVERT(varchar(10), AttendanceDate,120)='" + Convert.ToDateTime(Year + "-" + Month + "-" + day).ToString("yyyy-MM-dd") + "' and ProjectAttendanceId='" + Id + "'";
                    DataHelper.ExecSql(sql);
                    Response.Write("{success:  true  ,id:'" + Id + "'}");
                    Response.End();
                    return;
                }
                ents.CreateTime = System.DateTime.Now;
                ents.DoUpdate();
            }
            else
            {
                ents = new ProjectAttendanceDetail();
                ents.UserId = UserId;
                ents.UserName = UserName;
                if (!string.IsNullOrEmpty(Id))
                {
                    ents.ProjectAttendanceId = Id;
                }
                else
                {
                    ents.ProjectAttendanceId = Pent.Id;
                }
                ents.AttendanceType = SignType;
                ents.AttendanceDate = Convert.ToDateTime(Year + "-" + Month + "-" + day);
                ents.CreateId = WebPortalService.CurrentUserInfo.UserID;
                ents.CreateName = WebPortalService.CurrentUserInfo.Name;
                ents.CreateTime = DateTime.Now;
                ents.DoCreate();

            }
            if (!string.IsNullOrEmpty(Id))
            {
                Response.Write("{success:  true  ,id:'" + Id + "'}");
                Response.End();
                return;
            }
            Response.Write("{success:  true  ,id:'" + Pent.Id + "'}");
            Response.End();


        }
        private void DoGrid()
        {
            Id = Request["Id"];
            if (!string.IsNullOrEmpty(Id))
            {
                Pent = ProjectAttendance.Find(Id);
                if (Pent == null)
                {
                    return;
                }
                dt = new DataTable();
                DataColumn dc = new DataColumn("Id");
                dt.Columns.Add(dc);
                dc = new DataColumn("UserId");
                dt.Columns.Add(dc);
                dc = new DataColumn("UserName");
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
                dc = new DataColumn("SumDay");
                dt.Columns.Add(dc);
                dc = new DataColumn("monthAdd");
                dt.Columns.Add(dc);

                // IList<ProjectUser> puEnts = ProjectUser.FindAllByProperty(ProjectUser.Prop_ProjectId, paEnt.ProjectId);
                sql = "select UserId,UserName from NCRL_SP..ProjectAttendanceDetail where ProjectAttendanceId='" + Pent.Id + "' group by UserName,UserId ";
                DataTable count = DataHelper.QueryDataTable(sql);
                for (int i = 0; i < count.Rows.Count; i++)
                {
                    DataRow dr = dt.NewRow();
                    dr["UserId"] = count.Rows[i].ItemArray[0];
                    dr["UserName"] = count.Rows[i].ItemArray[1];
                    IList<ProjectAttendanceDetail> padEnts = ProjectAttendanceDetail.FindAllByProperties(ProjectAttendanceDetail.Prop_ProjectAttendanceId, Pent.Id, ProjectAttendanceDetail.Prop_UserId, count.Rows[i].ItemArray[0]);
                    int sumday = 0;
                    foreach (ProjectAttendanceDetail padEnt in padEnts)
                    {
                        string adate = "c" + padEnt.AttendanceDate.Value.Day;
                        dr[adate] = padEnt.AttendanceType;
                        dr["Id"] = padEnt.Id;
                        sumday++;
                    }
                    dr["SumDay"] = sumday;

                    dt.Rows.Add(dr);

                }
                string str = JsonHelper.GetJsonStringFromDataTable(dt);
                string json = "{\"rows\":" + str + "}";
                Response.Write(json);
                Response.End();
            }

        }
        private void FormLoad()
        {
            Id = Request["Id"];
            if (!string.IsNullOrEmpty(Id))
            {
                string data = JsonHelper.GetJsonString(ProjectAttendance.Find(Id));
                string sa = "{success:  true  ,data:" + data + "}";
                Response.Write(sa);
                Response.End();
            }
        }
        private void PNameCombo()
        {
            string name = Request["name"].Replace(" ", "");
            if (!string.IsNullOrEmpty(name))
            {
                where = " and ProjectName like '%" + name + "%'  or ProjectCode like '%" + name + "%'";
            }
            string LogName = WebPortalService.CurrentUserInfo.Name;
            sql = "select '" + LogName + "' as LogName, Id as ProjectId,PManagerId,ProjectName,PManagerName,BelongDeptId,BelongDeptName from NCRL_SP..Project  where 1=1 " + where;
            dt = DataHelper.QueryDataTable(sql);
            string str = JsonHelper.GetJsonString(dt);
            string json = "{'rows':" + str + "}";
            Response.Write(json);
            Response.End();

        }
    }
}