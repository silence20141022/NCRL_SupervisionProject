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
    public partial class SupervisionJianBaoList : System.Web.UI.Page
    {
        string sql = "";
        int PageCount;
        string where = "";
        DataTable dt = null;
        string str1 = "";
        string json = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            switch (action)
            {
                case "select":
                    Select();
                    break;
                case "delete":
                    Delete();
                    break;
            }
        }
        private void Select()
        {
            if (!string.IsNullOrEmpty(Request["ProjectName"]))
            {
                where += " and n.ProjectName like '%" + Request["ProjectName"] + "%'";
            }
            if (!string.IsNullOrEmpty(Request["PManagerName"]))
            {
                where += " and n.PManagerName like '%" + Request["PManagerName"] + "%'";
            }
            if (!string.IsNullOrEmpty(Request["ShiGongUnit"]))
            {
                where += " and n.ShiGongUnit like '%" + Request["ShiGongUnit"] + "%'";
            }
            sql = @" select CONVERT(varchar(36),n.year,1)+'/'+ CONVERT(varchar(36),n.month,1)  as YearAndMonth,CONVERT(varchar(100), n.CreateTime, 111) CreateTime2 , n.* from NCRL_SP..SupervisionJianBao n where 1 = 1 " + where + "";
            sql = GetPageSql(sql);
            dt = DataHelper.QueryDataTable(sql);
            str1 = JsonHelper.GetJsonStringFromDataTable(dt);
            json = "{'totalRecord':" + PageCount + ",'rows':" + str1 + "}";
            Response.Write(json);
            Response.End();
        }
        private void Delete()
        {
            string ids = Request["ids"];
            string[] idArray = ids.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            for (int i = 0; i < idArray.Length; i++)
            {
                SupervisionJianBao.DeleteAll("Id='" + idArray[i] + "'");//删除数据
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