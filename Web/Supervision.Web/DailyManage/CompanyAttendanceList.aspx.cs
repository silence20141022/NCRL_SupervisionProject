using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Aim.Data;
using Aim;

namespace SP.Web.DailyManage
{
    public partial class CompanyAttendanceList : System.Web.UI.Page
    {
        string sql = "";
        int totalRecord;
        int start;
        int limit;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Aim.Portal.Web.WebPortalService.CheckLogon();
            }
            catch
            {
                Response.Write("<script> window.parent.location.href = '/Login.aspx';</script>");
                Response.End();
            }
            DataTable dt = null;
            string action = Request["action"];
            switch (action)
            {
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
                case "select":
                    string where = "";
                    if (!string.IsNullOrEmpty(Request["year"]))
                    {
                        where += "and Year =" + Request["year"] + "";
                    }
                    if (!string.IsNullOrEmpty(Request["month"]))
                    {
                        where += "and Month =" + Request["month"] + "";
                    }
                    sql = @"select * from NCRL_SP..CmpAttendance  where 1=1 " + where;
                    DataTable td = DataHelper.QueryDataTable(GetPageData(sql));
                    string str = JsonHelper.GetJsonStringFromDataTable(td);
                    string json = "{\"pageCount\":" + totalRecord + ",\"rows\":" + str + "}";
                    Response.Write(json);
                    Response.End();
                    break;
            }
        }
        private string GetPageData(String sql)
        {
            start = Convert.ToInt32(Request["start"]);
            limit = Convert.ToInt32(Request["limit"]);
            totalRecord = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = "year,month";
            string asc = "desc";
            string pageSql = @"
		    WITH OrderedOrders AS
		    (SELECT *,
		    ROW_NUMBER() OVER (order by {0} {1})as RowNumber
		    FROM ({2}) temp ) 
		    SELECT * 
		    FROM OrderedOrders 
		    WHERE RowNumber between {3} and {4}";
            pageSql = string.Format(pageSql, order, asc, sql, start + 1, limit + start);
            return pageSql;
        }
    }
}