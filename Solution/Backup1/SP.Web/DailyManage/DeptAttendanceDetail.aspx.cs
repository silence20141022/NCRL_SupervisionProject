using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SP.Model;
using System.Data;
using Aim.Data;
using Aim;

namespace SP.Web.DailyManage
{
    public partial class DeptAttendanceDetail : System.Web.UI.Page
    {
        string DeptId = "";
        string Year = "";
        string Month = "";
        string sql = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            switch (action)
            {
                case "select":
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            DeptId = Request["DeptId"];
            Year = Request["Year"];
            Month = Request["Month"];
            DataTable dt = new DataTable();
            DataColumn dc = new DataColumn("ProjectName");
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
            dc = new DataColumn("RowNumber");
            dt.Columns.Add(dc);
            dc = new DataColumn("SumDay");
            dt.Columns.Add(dc);
            IList<ProjectAttendance> Pents = ProjectAttendance.FindAllByProperties("BelongDeptId", DeptId, "Year", Convert.ToInt32(Year), "Month", Convert.ToInt32(Month));
            foreach (ProjectAttendance Pent in Pents)
            {
                int RowNumber = 0;
                sql = "select UserId,UserName,ProjectAttendanceId from NCRL_SP..ProjectAttendanceDetail where ProjectAttendanceId='" + Pent.Id + "' group by UserName,UserId,ProjectAttendanceId ";
                DataTable count = DataHelper.QueryDataTable(sql);
                for (int i = 0; i < count.Rows.Count; i++)
                {
                    RowNumber++;
                    DataRow dr = dt.NewRow();
                    dr["RowNumber"] = RowNumber;
                    dr["UserId"] = count.Rows[i].ItemArray[0];
                    dr["UserName"] = count.Rows[i].ItemArray[1];
                    dr["ProjectName"] = Pent.ProjectName;
                    IList<ProjectAttendanceDetail> padEnts = ProjectAttendanceDetail.FindAllByProperties(ProjectAttendanceDetail.Prop_ProjectAttendanceId, Pent.Id, ProjectAttendanceDetail.Prop_UserId, count.Rows[i].ItemArray[0]);
                    int sumday = 0;
                    foreach (ProjectAttendanceDetail padEnt in padEnts)
                    {
                        string adate = "c" + padEnt.AttendanceDate.Value.Day;
                        dr[adate] = padEnt.AttendanceType;
                        // dr["Id"] = padEnt.Id;
                        sumday++;
                    }
                    dr["SumDay"] = sumday;
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