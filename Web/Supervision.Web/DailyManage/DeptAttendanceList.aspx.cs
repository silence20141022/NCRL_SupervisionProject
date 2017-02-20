using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using System.Data;
using Aim;
using Aim.Portal.Model;
using Aim.Portal.Web;

namespace SP.Web.DailyManage
{
    public partial class DeptAttendanceList : System.Web.UI.Page
    {
        string sql = "";
        int start;
        int limit;
        int totalRecord;
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
            string action = Request["action"];
            DataTable dt = null;
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
                case "async":
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            string DeptName = Request["DeptName"];
            string year = Request["year"];
            string month = Request["month"];
            string where = "";
            if (!string.IsNullOrEmpty(DeptName))
            {
                where += " and  BelongDeptName like '%" + DeptName + "%' ";
            }
            if (!string.IsNullOrEmpty(year))
            {
                where += " and Year =" + year + "";
            }
            if (!string.IsNullOrEmpty(month))
            {
                where += " and Month =" + month + "";
            }
            //获取当前登录用户的部门
            SysUser suEnt = SysUser.Find(WebPortalService.CurrentUserInfo.UserID);
            //suEnt.Server_IAGUID 部门ID      suEnt.Server_Seed  部门名称 100136[杨小伟]
            if (WebPortalService.CurrentUserInfo.Name != "管理员" && WebPortalService.CurrentUserInfo.Name != "赵勤" && WebPortalService.CurrentUserInfo.Name != "王红" && suEnt.LoginName != "100136" && suEnt.LoginName != "100808" && suEnt.LoginName != "100817" && suEnt.LoginName != "104342")
            {
                where += " and BelongDeptId='" + suEnt.Server_IAGUID + "'";
            }
            sql = @"select Id,BelongDeptName,Year,Month,Status,Remark from NCRL_SP..DeptAttendance where 1=1 " + where;
            DataTable td = DataHelper.QueryDataTable(GetPageData(sql));
            string str = JsonHelper.GetJsonStringFromDataTable(td);
            string json = "{\"pageCount\":" + totalRecord + ",\"rows\":" + str + "}";
            Response.Write(json);
            Response.End();
        }
        private string GetPageData(String sql)
        {
            start = Convert.ToInt32(Request["start"]);
            limit = Convert.ToInt32(Request["limit"]);
            totalRecord = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = "BelongDeptName,year,month";
            string asc = "asc";
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