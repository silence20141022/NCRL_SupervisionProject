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
    public partial class SupervisionNoticeList : IMListPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
			SupervisionNotice ent = null;
            switch (RequestActionString)
            {
                case "delete":
                    ent = this.GetTargetData<SupervisionNotice>();
                    ent.DoDelete();
                    break;
                case "batchdelete":
                    DoBatchDelete();
                    break;
                default:
                    DoSelect();
                    break;
            }
            
        }
		
        private void DoSelect()
        {
            string sql = string.Empty;
            string where = "";
            foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
            {
                if (item.Value + "" != "")
                {
                    switch (item.PropertyName)
                    {
                        case "BeginDate":
                            where += " and NoticeDate>='" + item.Value + "' ";
                            break;
                        case "EndDate":
                            where += " and NoticeDate<='" + (item.Value.ToString()).Replace(" 0:00:00", " 23:59:59") + "' ";
                            break;
                        default:
                            where += " and " + item.PropertyName + " like '%" + item.Value + "%' ";
                            break;
                    }
                }
            }
            sql = @"select * from NCRL_SP..SupervisionNotice where 1=1" + where;
            this.PageState.Add("SupervisionNoticeList", GetPageData(sql, SearchCriterion));

            string url = this.Request.Url.GetLeftPart(UriPartial.Authority) + this.Request.ApplicationPath;
            this.PageState.Add("url", url);
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
        [ActiveRecordTransaction]
        private void DoBatchDelete()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");
            if (idList != null && idList.Count > 0)
            {
                SupervisionNotice.DoBatchDelete(idList.ToArray());
            }
        }
    }
}

