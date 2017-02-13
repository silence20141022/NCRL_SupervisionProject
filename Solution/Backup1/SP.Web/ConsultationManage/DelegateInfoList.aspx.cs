using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Aim.Data;
using Aim;
using Newtonsoft.Json.Linq;

namespace SP.Web.ConsultationManage
{
    public partial class DelegateInfoList : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        string where = "";
        int totalProperty;
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
                case "SelectList":
                    string NameOrCode = Request["NameOrCode"];
                    if (!string.IsNullOrEmpty(NameOrCode))
                    {
                        where += " and DelegateName like '%" + NameOrCode.Replace(" ", "") + "%' or DelegateCode like '%" + NameOrCode.Replace(" ", "") + "%' ";
                    }
                    sql = " select * from  NCRL_SP..DelegateInfo where 1=1 " + where;
                    dt = DataHelper.QueryDataTable(GetPageSql(sql));
                    string str = JsonHelper.GetJsonString(dt);
                    Response.Write("{rows:" + str + ",total:" + totalProperty + "}");
                    Response.End();
                    break;
                case "Delete":
                    string Jarray = Request["Jarray"];
                    string[] ids = Jarray.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                    for (int i = 0; i < ids.Length; i++)
                    {
                        sql = "delete NCRL_SP..DelegateInfo where id='" + ids[i] + "'";
                        DataHelper.ExecSql(sql);
                    }
                    break;
            }
        } 
        private string GetPageSql(string tempsql)
        {
            int start = Convert.ToInt32(Request["start"]);
            int limit = Convert.ToInt32(Request["limit"]);
            totalProperty = DataHelper.QueryValue<int>("select count(1) from (" + tempsql + ") t");
            string order = "DelegateCode asc";
            if (!string.IsNullOrEmpty(Request["sort"]))
            {
                JArray jarray = JsonHelper.GetObject<JArray>(Request["sort"]);
                order = jarray[0].Value<string>("property") + " " + jarray[0].Value<string>("direction");
            }
            string pageSql = @"
		    WITH OrderedOrders AS
		    (SELECT *,
		    ROW_NUMBER() OVER (order by {0})as RowNumber
		    FROM ({1}) temp ) 
		    SELECT * 
		    FROM OrderedOrders 
		    WHERE RowNumber between {2} and {3}";
            pageSql = string.Format(pageSql, order, tempsql, start + 1, limit + start);
            return pageSql;
        }
    }
}