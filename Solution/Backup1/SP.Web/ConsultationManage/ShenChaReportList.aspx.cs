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
    public partial class ShenChaReportList : IMListPage
    {
        #region 变量

        private IList<ShenChaReport> ents = null;

        #endregion

        #region 构造函数

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            Project ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<Project>();
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
		
        ///// <summary>
        ///// 查询
        ///// </summary>
        //private void DoSelect()
        //{
        //    ents = ShenChaReport.FindAll(SearchCriterion);
        //    this.PageState.Add("ProjectList", ents);
        //}

        /// <summary>
        /// 查询
        /// </summary>
        private void DoSelect()
        {
            string where = " 1=1 ";
            foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
            {

                if (item.Value + "" != "")
                {
                    where += " and p." + item.PropertyName + " like '%" + item.Value + "%' ";
                }
            }

          IList<EasyDictionary> datalist = GetPageData(@"select s.Id as SCID,s.CreateName ,p.Id,p.ProjectName,p.ProjectType,p.CreateTime from NCRL_SP..Project as p left join NCRL_SP..ShenChaReport as s on p.Id=s.ProjectId  where p.BelongCmp='ZX' and  " + where, SearchCriterion);
          //  IList<EasyDictionary> datalist = GetPageData(@"select s.Id as SCID,s.CreateName ,p.Id,p.ProjectName,p.ProjectType,p.CreateTime from NCRL_SP..Project as p left join NCRL_SP..ShenChaReport as s on p.Id=s.ProjectId  where  " + where, SearchCriterion);
           
            this.PageState.Add("ProjectList", datalist);
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
                //Project.DoBatchDelete(idList.ToArray());
                foreach (var item in idList)
                {
                    DataHelper.ExecSql(" delete  NCRL_SP..ShenChaReport where ProjectId='" + item + "'");
                }
             
			}
		}

        #endregion
    }
}

