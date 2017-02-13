using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Aim;
using Aim.Data;
using SP.Model;

namespace SP.Web.ProjectManage
{
    public partial class SupervisionRiZhiList : System.Web.UI.Page
    {
        string sql = "";
        int PageCount;
        string where = "";
        DataTable dt = null;
        string json = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            switch (action)
            {
                case "select":
                    select();
                    break;
                case "delete":
                    delete();
                    break;
            }
        }

        private void select()
        {
            string ProjectName = Request["ProjectName"];
            string PManagerName = Request["PManagerName"];
            string ShiGongUnit = Request["ShiGongUnit"];
            if (!string.IsNullOrEmpty(ProjectName))
            {
                where += " and ProjectName like '%" + ProjectName + "%'";
            }
            if (!string.IsNullOrEmpty(PManagerName))
            {
                where += " and PManagerName like '%" + PManagerName + "%'";
            }
            if (!string.IsNullOrEmpty(ShiGongUnit))
            {
                where += " and ShiGongUnit like '%" + ShiGongUnit + "%'";
            }
            sql = @"select * from NCRL_SP..SupervisionRiZhi where 1 = 1 " + where + "";
            dt = DataHelper.QueryDataTable(GetPageSql(sql));
            string str = JsonHelper.GetJsonString(dt);
            json = "{'totalRecord':" + PageCount + ",'rows':" + str + "}";
            Response.Write(json);
            Response.End();
        }

        private void delete()
        {
            string ids = Request["ids"];
            string[] idArray = ids.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            for (int i = 0; i < idArray.Length; i++)
            {
                SupervisionRiZhi.DeleteAll("Id='" + idArray[i] + "'");//删除数据
            }
        }
        private string GetPageSql(string tempsql)
        {
            int start = Convert.ToInt32(Request["start"]);
            int limit = Convert.ToInt32(Request["limit"]);
            PageCount = Convert.ToInt32(DataHelper.QueryValue("select count(1) from (" + tempsql + ") t"));
            string order = "CreateTime";
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