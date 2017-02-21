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
            switch (action)
            {
                case "loaddata":
                    caEnt = CmpAttendance.Find(id);
                    sql = @"select a.*,Replace(b.Server_Seed,'江西瑞林建设监理有限公司','') as DeptName from NCRL_SP..MonAttendance a left join NCRL_Portal..SysUser b on a.UserId=b.UserId
                    where Year='{0}' and Month='{1}' order by  DeptName,ProjectNames";
                    sql = string.Format(sql, caEnt.Year, caEnt.Month);
                    dt = DataHelper.QueryDataTable(sql);
                    int runyear = 0;
                    if ((caEnt.Year % 4 == 0 && caEnt.Year % 100 != 0) || caEnt.Year % 400 == 0)
                    {
                        runyear = 1;
                    }
                    sql = "select GroupID,REPLACE (Name , '江西瑞林建设监理有限公司' , '' ) as Name from NCRL_Portal..SysGroup where ParentId='228'";
                    DataTable dt_dept = DataHelper.QueryDataTable(sql);
                    string title = "江西瑞林建设监理有限公司" + caEnt.Year + "年" + caEnt.Month + "月考勤表";
                    Response.Write("{success:true,dept:" + JsonHelper.GetJsonStringFromDataTable(dt_dept) + ",month:'" + caEnt.Month + "',runyear:" + runyear + ",rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",title:'" + title + "'}");
                    Response.End();
                    break;
                case "search":
                    caEnt = CmpAttendance.Find(id);
                    if (!string.IsNullOrEmpty(Request["username"] + ""))
                    {
                        where += " and a.UserName like '%" + Request["username"] + "%'";
                    }
                    if (!string.IsNullOrEmpty(Request["projectname"] + ""))
                    {
                        where += " and a.ProjectNames like '%" + Request["projectname"] + "%'";
                    }
                    if (!string.IsNullOrEmpty(Request["deptid"] + ""))
                    {
                        where += " and b.Server_IAGUID ='" + Request["deptid"] + "'";
                    }
                    sql = @"select a.*,Replace(b.Server_Seed,'江西瑞林建设监理有限公司','') as DeptName from NCRL_SP..MonAttendance a left join NCRL_Portal..SysUser b on a.UserId=b.UserId
                    where Year='{0}' and Month='{1}' " + where + "order by  DeptName,ProjectNames";
                    sql = string.Format(sql, caEnt.Year, caEnt.Month);
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{success:true,rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
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