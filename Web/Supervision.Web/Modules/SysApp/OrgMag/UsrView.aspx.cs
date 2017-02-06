﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using NHibernate;
using NHibernate.Criterion;
using Castle.ActiveRecord;
using Castle.ActiveRecord.Queries;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using System.Configuration;
using Aim;
using Aim.Utilities;

namespace SP.Web
{
    public partial class UsrView : BaseListPage
    {
        string op = String.Empty;
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 查询类型  
        string sql = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            id = RequestData.Get<string>("id", String.Empty);
            type = RequestData.Get<string>("type", String.Empty).ToLower();
            IList<string> UserIds = RequestData.GetList<string>("UserIds");
            IList<string> GroupIds = RequestData.GetList<string>("GroupIds");
            switch (RequestActionString)
            {
                case "addUserGroup":
                    if (!String.IsNullOrEmpty(id))
                    {
                        foreach (string uid in UserIds)
                        {
                            sql += "insert into SysUserGroup (UserId,GroupId) values ('" + uid + "','" + id + "') ";
                        }
                        DataHelper.ExecSql(sql);
                    }
                    break;
                case "delete":
                    for (int i = 0; i < UserIds.Count; i++)
                    {
                        sql += "delete BJKY_Portal..SysUserGroup where UserId='" + UserIds[i] + "' and GroupId='" + GroupIds[i] + "' ";
                        DataHelper.ExecSql(sql);
                    }
                    break;
                default:
                    DoSelect();
                    break;
            }
        }
        private void DoSelect()
        {
            string dName = SearchCriterion.GetSearchValue<string>("Name");
            string where = "";
            if (dName != null && dName.Trim() != "")
            {
                where = "and " + GetPinyinWhereString("B.Name", dName);
            } 
            string sql = @"select A.UserId as UserId,A.GroupId as GroupId,B.Name,B.WorkNo,C.Name as GroupName 
            from BJKY_Portal..SysUserGroup as A 
            left join BJKY_Portal..SysUser as B on B.UserId=A.UserId 
            left join BJKY_Portal..SysGroup as C on A.GroupId=C.GroupId where PatIndex('%{0}%',C.Path)>0 " + where;
            PageState.Add("UsrList", GetPageData(string.Format(sql, id), SearchCriterion));
        }
        public string GetPinyinWhereString(string fieldName, string pinyinIndex)
        {
            string[,] hz = Tool.GetHanziScope(pinyinIndex);
            string whereString = "(";
            for (int i = 0; i < hz.GetLength(0); i++)
            {
                whereString += "(SUBSTRING(" + fieldName + ", " + (i + 1) + ", 1) >= '" + hz[i, 0] + "' AND SUBSTRING(" + fieldName + ", " + (i + 1) + ", 1) <= '" + hz[i, 1] + "') AND ";
            }
            if (whereString.Substring(whereString.Length - 4, 4) == "AND ")
                return whereString.Substring(0, whereString.Length - 4) + ")";
            else
                return "(1=1)";
        }
        private IList<EasyDictionary> GetPageData(String sql, SearchCriterion search)
        {
            SearchCriterion.RecordCount = DataHelper.QueryValue<int>("select count(*) from (" + sql + ") t");
            string order = search.Orders.Count > 0 ? search.Orders[0].PropertyName : "WorkNo";
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
        //private void RemoveOldDeptRelations(IList<string> userIDs)
        //{
        //    //using (new SessionScope())
        //    //{
        //    foreach (string userId in userIDs)
        //    {
        //        DataHelper.ExecSql("delete from SysUserGroup where UserID='" + userId + "'");
        //        continue;
        //        SysUser sysUser = SysUser.Find(userId);
        //        IEnumerable<SysGroup> group = sysUser.RetrieveAllGroup().Where(en => en.Type == 2);
        //        if (group.Count() > 0)
        //        {
        //            foreach (SysGroup gp in group)
        //                gp.User.Remove(sysUser);
        //        }
        //    }
        //    //}
        //}
    }
}
