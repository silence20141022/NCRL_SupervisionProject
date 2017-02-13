using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using System.Data;
using Aim;
using Aim.Portal.Web;
using Aim.Portal.Model;

namespace SP.Web.DailyManage
{
    public partial class ProjectAttendanceList : System.Web.UI.Page
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
                Response.Redirect("/Login.aspx");
            }
            string action = Request["action"];
            string sql = "";
            DataTable dt = null;
            string where = "";
            switch (action)
            {
                case "select":
                    if (!string.IsNullOrEmpty(Request["ProjectName"]))
                    {
                        where += " and ProjectName like '%" + Request["ProjectName"] + "%'";
                    }
                    if (!string.IsNullOrEmpty(Request["PManagerName"]))
                    {
                        where += " and PManagerName like '%" + Request["PManagerName"] + "%'";
                    }
                    //管理员 100136[杨小伟]能看到所有的项目考勤 项目总监只能看到自身的项目考勤 Aim.Portal.Web.WebPortalService.CurrentUserInfo.UserID;
                    SysUser suEnt = SysUser.Find(WebPortalService.CurrentUserInfo.UserID);
                    if (WebPortalService.CurrentUserInfo.Name == "管理员" || WebPortalService.CurrentUserInfo.Name == "赵勤" || WebPortalService.CurrentUserInfo.Name == "王红" || suEnt.LoginName == "100136" || suEnt.LoginName == "100808" || suEnt.LoginName == "100817"|| suEnt.LoginName == "104342")
                    {
                        sql = @"select * from NCRL_SP..ProjectAttendance where 1=1 " + where;
                    }
                    else
                    {
                        sql = @"select * from NCRL_SP..ProjectAttendance where (CreateName='{0}' or PManagerName='{0}') " + where;
                        sql = string.Format(sql, WebPortalService.CurrentUserInfo.Name);
                    }
                    dt = DataHelper.QueryDataTable(GetPageSql(sql));
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",total:" + totalProperty + "}");
                    Response.End();
                    break;
            }
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