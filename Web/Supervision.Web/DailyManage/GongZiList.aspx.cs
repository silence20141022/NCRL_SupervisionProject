using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim;
using Aim.Data;
using System.Data;
using SP.Model;

namespace SP.Web.DailyManage
{
    public partial class GongZiList : System.Web.UI.Page
    {
        string sql = "";
        string where = "";
        int totalProperty = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Aim.Portal.Web.WebPortalService.CheckLogon();
            }
            catch
            {
                // Response.Redirect("/Login.aspx");
                Response.Write("<script> window.parent.location.href = '/Login.aspx';</script>");
                Response.End();
            }
            string action = Request["action"];
            switch (action)
            {
                case "autoload":
                    if (!string.IsNullOrEmpty(Request["Year"] + ""))
                    {
                        where += " and a.Year='" + Request["Year"] + "'";
                    }
                    if (!string.IsNullOrEmpty(Request["Month"] + ""))
                    {
                        where += " and a.Month='" + Request["Month"] + "'";
                    }
                    sql = @"select a.*,(select count(1) from NCRL_SP..Salary b where b.StageId=a.Id) as PeopleCount,
                    (select count(1) from NCRL_SP..SalaryAdjust c where c.StageId=a.Id) as AdjustCount,
                    (select sum(d.TotalSalary) from NCRL_SP..Salary d where d.StageId=a.Id) as TotalAmount
                    from NCRL_SP..SalaryStage a where 1=1 " + where;
                    DataTable dt = DataHelper.QueryDataTable(GetPageSql(sql));
                    string json = "{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",totalProperty:'" + totalProperty + "'}";
                    Response.Write(json);
                    Response.End();
                    break;
                case "delete":
                    string formIds = Request["formIds"];
                    if (!string.IsNullOrEmpty(formIds))
                    {
                        string[] array = formIds.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                        foreach (string str in array)
                        {
                            SalaryStage ssEnt = SalaryStage.Find(str);
                            IList<Salary> sEnts = Salary.FindAllByProperty(Salary.Prop_StageId, ssEnt.Id);
                            foreach (Salary sEnt in sEnts)
                            {
                                sEnt.DoDelete();
                            }
                            IList<SalaryAdjust> saEnts = SalaryAdjust.FindAllByProperty(SalaryAdjust.Prop_StageId, ssEnt.Id);
                            if (saEnts.Count > 0)
                            {
                                saEnts[0].DoDelete();
                            }
                            ssEnt.DoDelete();
                        }
                    }
                    break;
            }
        }
        private string GetPageSql(string tempsql)
        {
            int start = Convert.ToInt32(Request["start"]);
            int limit = Convert.ToInt32(Request["limit"]);
            totalProperty = DataHelper.QueryValue<int>("select count(1) from (" + tempsql + ") t");
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