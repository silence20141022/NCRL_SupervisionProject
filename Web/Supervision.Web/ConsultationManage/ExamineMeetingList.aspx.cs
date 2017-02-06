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

namespace SP.Web.ConsultationManage
{
    public partial class ExamineMeetingList : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        string where = "";
        int totalProperty;
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            switch (action)
            {
                case "Select":
                    DoSelect();
                    break;

                case "delete":
                    Delete();
                    break;
            }
        }
        private void Delete()
        {
            string ids = Request["Jarray"];
            string[] array = ids.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            for (int i = 0; i < array.Length; i++)
            {
                ProjectUser.DeleteAll("ProjectId='" + array[i] + "'");
                sql = "delete NCRL_SP..ExamineMeeting where Id='" + array[i] + "'";
                DataHelper.ExecSql(sql);
            }
        }
        private void DoSelect()
        {
            string MeetingName = Request["MeetingName"].Trim();
            if (!string.IsNullOrEmpty(MeetingName))
            {
                where += " and MeetingName like '%" + MeetingName + "%'";
            }
            sql = "select * from NCRL_SP..ExamineMeeting where 1=1 " + where;
            dt = DataHelper.QueryDataTable(GetPageSql(sql));
            string str = JsonHelper.GetJsonString(dt);
            Response.Write("{rows:" + str + ",total:" + totalProperty + "}");
            Response.End();
        }

        private string GetPageSql(string tempsql)
        {
            int start = Convert.ToInt32(Request["start"]);
            int limit = Convert.ToInt32(Request["limit"]);
            totalProperty = DataHelper.QueryValue<int>("select count(1) from (" + tempsql + ") t");
            string order = "CREATETIME";
            string asc = " desc";
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