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
    public partial class SupervisionGuiHuaList : IMListPage
    {
        #region 变量

        private IList<SupervisionGuiHua> ents = null;

        #endregion

        #region 构造函数

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            SupervisionGuiHua ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<SupervisionGuiHua>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    break;
                default:
                    if (RequestActionString == "batchdelete")
                    {
                        DoBatchDelete();
                    }
                    else if (RequestActionString == "Revoke") {
                        Revoke();
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
            string where = "";
          
            foreach (CommonSearchCriterionItem item in SearchCriterion.Searches.Searches)
            {
                if (!String.IsNullOrEmpty(item.Value.ToString()))
                {
                    switch (item.PropertyName)
                    {
                        case "State":
                            if (!string.IsNullOrEmpty( item.Value+"") && item.Value.ToString() != "new")
                                where += " and State='" + item.Value + "' ";
                            else
                                where += " and (State=null or State='')";
                            break;
                        default:
                            where += " and " + item.PropertyName + " like '%" + item.Value + "%' ";
                            break;
                    }
                }
            }



            string sql = @"select * from NCRL_SP..SupervisionGuiHua where CreateId='" + UserInfo.UserID + "' " + where;
           // sql = string.Format(sql);
            PageState.Add("DataList", GetPageData(sql, SearchCriterion));


            string url = this.Request.Url.GetLeftPart(UriPartial.Authority) + this.Request.ApplicationPath;
            this.PageState.Add("url", url);
        }



        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search)
        {
            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "CreateTime";
            string asc = search.Orders.Count <= 0 || search.Orders[0].Ascending ? " desc" : " asc";
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
                SupervisionGuiHua.DoBatchDelete(idList.ToArray());
            }
        }

        /// <summary>
        /// 撤回
        /// </summary>
        [ActiveRecordTransaction]
        private void Revoke()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {
                foreach (var id in idList)
                {
                    string str = @"update  NCRL_SP..SupervisionGuiHua  set State='',ModifyTime='" + DateTime.Now + "',ModifyName='" + UserInfo.Name + "',ModifyId='" + UserInfo.UserID + "' where Id='" + id + "'; ";
                    str += "update  Task set Description='撤回提交',Status='4' where Status='0' and  WorkflowInstanceID =(select ID from   NCRL_Portal..WorkflowInstance where  Status !='Completed' and   RelateId='" + id + "')";
                    str += "update WorkflowInstance set Status='Completed' where Status !='Completed' and  RelateId='" + id + "';";
                    DataHelper.ExecSql(str);
                }
            }
        }

        #endregion
    }
}

