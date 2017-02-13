using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Castle.ActiveRecord;
using NHibernate;
using NHibernate.Criterion;
using Aim.Data;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;
using SP.Model;
using Aim;

namespace SP.Web
{
    public partial class ShouKuanList : IMListPage
    {
        private IList<ShouKuan> ents = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            ShouKuan ent = null;
            switch (RequestActionString)
            {
                case "delete":
                    string idall = RequestData.Get<string>("data1");
                    string[] idArray = idall.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                    for (int i = 0; i < idArray.Length; i++)
                    {
                        ShouKuan.DeleteAll("Id='" + idArray[i] + "'");
                    }
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            string where = "";
            if (IsAsyncRequest)
            {
                foreach (string str in RequestData.Keys)
                {
                    if (!string.IsNullOrEmpty(RequestData[str] + ""))
                    {
                        switch (str)
                        {
                            case "ProjectName":
                            case "InvoiceNo":
                                where += " and " + str + " like '%" + RequestData[str].ToString().Replace(" ", "") + "%'";
                                break;
                            case "BeginDate":
                                where += "and ShouKuanDate >='" + RequestData[str].ToString() + " 00:00:00'";
                                break;
                            case "EndDate":
                                where += "and ShouKuanDate<='" + RequestData[str].ToString() + " 23:59:59'";
                                break;
                        }
                    }
                }
            }
            string sql = "select * from NCRL_SP..ShouKuan where 1=1 " + where;
            IList<EasyDictionary> dics = GetPageData(sql, SearchCriterion);
            PageState.Add("DataList", dics);
        }
        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search)
        {
            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "CreateTime";
            string asc = search.Orders.Count <= 0 || !search.Orders[0].Ascending ? " desc" : " asc";
            string pageSql = @"
		    WITH OrderedOrders AS
		    (SELECT *,
		    ROW_NUMBER() OVER (order by {0} {1})as RowNumber
		    FROM ({2}) temp ) 
		    SELECT * 
		    FROM OrderedOrders 
		    WHERE RowNumber between {3} and {4}";
            pageSql = string.Format(pageSql, order, asc, sql, (search.CurrentPageIndex - 1) * search.PageSize + 1, search.CurrentPageIndex * search.PageSize);
            IList<EasyDictionary> dicts = DataHelper.QueryDictList(pageSql);
            return dicts;
        }
    }
}

