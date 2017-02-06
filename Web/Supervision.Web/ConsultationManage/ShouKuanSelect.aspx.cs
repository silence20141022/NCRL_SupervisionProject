using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim;
using SP.Model;

namespace SP.Web
{
    public partial class ShouKuanSelect : IMListPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string where = "";
            if (IsAsyncRequest)
            {
                foreach (string str in RequestData.Keys)
                {
                    if (!string.IsNullOrEmpty(RequestData[str] + ""))
                    {
                        switch (str)//在排序和分页的时候会传递其他的Key过来 防止报错所以没有用default
                        {
                            case "BeginDate":
                                where += "and a.ShouKuanDate >='" + RequestData[str].ToString() + " 00:00:00'";
                                break;
                            case "EndDate":
                                where += "and a.ShouKuanDate<='" + RequestData[str].ToString() + " 23:59:59'";
                                break;
                            case "ProjectName":
                            case "InvoiceNo":
                                where += " and a." + str + " like '%" + RequestData[str].ToString().Replace(" ", "") + "%'";
                                break;
                        }
                    }
                }
            }
            //foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
            //{
            //    if (item.Value + "" != "")
            //    {
            //        where += " and " + item.PropertyName + " like '%" + item.Value + "%' ";
            //    }
            //}

            string sql = @"select a.*,b.ZiXunCode from  NCRL_SP..ShouKuan a left join NCRL_SP..Project b on a.ProjectId=b.Id
            where ChouJinId is null " + where;
            PageState.Add("DataList", GetPageData(sql, SearchCriterion));
        }
        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search)
        {
            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "ShouKuanDate";
            string asc = search.Orders.Count <= 0 || !search.Orders[0].Ascending ? " asc" : " desc";
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
