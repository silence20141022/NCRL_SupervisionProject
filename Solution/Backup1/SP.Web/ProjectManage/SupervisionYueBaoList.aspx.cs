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
    public partial class SupervisionYueBaoList : IMListPage
    {
        #region 变量

        private IList<SupervisionYueBao> ents = null;

        #endregion

        #region 构造函数

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            SupervisionYueBao ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<SupervisionYueBao>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    break;
                default:
                    if (RequestActionString == "batchdelete")
                    {
                        DoBatchDelete();
                    }
                    else
                    {
                        DoSelect();
                    }
                    break;
            }

        }

        #endregion

        #region 私有方法

        /// <summary>
        /// 查询
        /// </summary>
        private void DoSelect()
        {
            string where = " 1= 1 ";
            foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
            {
                if (item.PropertyName == "Year")
                {
                    if (item.Value + "" != "")
                    {
                        where += " and n.Year='" + item.Value + "' ";
                    }
                }
                else if (item.PropertyName == "Month")
                {
                    if (item.Value + "" != "")
                    {
                        where += " and n.Month='" + item.Value + "' ";
                    }
                }

                else if (item.Value + "" != "")
                {
                    where += " and n." + item.PropertyName + " like '%" + item.Value + "%' ";
                }
            }
            string sql = @"  select CONVERT(varchar(36),year,1)+'/'+ CONVERT(varchar(36),month,1)  as YearAndMonth, n.* from NCRL_SP..SupervisionYueBao n where " + where;
            IList<EasyDictionary> datalist = GetPageData(sql, SearchCriterion);
            this.PageState.Add("DataList", datalist);
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
        /// <summary>
        /// 批量删除
        /// </summary>
        [ActiveRecordTransaction]
        private void DoBatchDelete()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {
                SupervisionYueBao.DoBatchDelete(idList.ToArray());
            }
        }

        #endregion
    }
}

