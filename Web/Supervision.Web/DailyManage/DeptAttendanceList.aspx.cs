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
            switch (action)
            {
                case "basedata":
                    sql = "select value as year from NCRL_Portal..SysEnumeration where ParentId='058fbee9-0a9a-4b25-b343-ea8c05396632' order by SortIndex asc";
                    DataTable dt_year = DataHelper.QueryDataTable(sql);
                    sql = "select value as month from NCRL_Portal..SysEnumeration where ParentId='b25e537b-34e3-4437-87af-692e00facd73' order by SortIndex asc";
                    DataTable dt_month = DataHelper.QueryDataTable(sql);
                    sql = "select GroupID,REPLACE (Name , '江西瑞林建设监理有限公司' , '' ) as Name from NCRL_Portal..SysGroup where ParentId='228'";
                    DataTable dt_dept = DataHelper.QueryDataTable(sql);
                    Response.Write("{year:" + JsonHelper.GetJsonStringFromDataTable(dt_year) + ",month:" + JsonHelper.GetJsonStringFromDataTable(dt_month) + ",dept:" + JsonHelper.GetJsonStringFromDataTable(dt_dept) + "}");
                    Response.End();
                    break;
                case "async":
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            string where = "";
            if (!string.IsNullOrEmpty(Request["deptid"]))
            {
                where += " and  BelongDeptId = '" + Request["deptid"] + "' ";
            }
            if (!string.IsNullOrEmpty(Request["year"]))
            {
                where += " and Year =" + Request["year"] + "";
            }
            if (!string.IsNullOrEmpty(Request["month"]))
            {
                where += " and Month =" + Request["month"] + "";
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