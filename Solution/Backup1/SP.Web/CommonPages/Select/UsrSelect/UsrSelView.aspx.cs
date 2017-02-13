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
//using Aim.Examining.Model;
using Aim.Utilities;

namespace Aim.Portal.Web.CommonPages
{
    public partial class UsrSelView : BaseListPage
    {
        string op = String.Empty;
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 查询类型
        string ctype = String.Empty; // 分类类型
        private IList<SysUser> users = new List<SysUser>();
        public UsrSelView()
        {
            IsCheckLogon = false;
            SearchCriterion.CurrentPageIndex = 1;
            SearchCriterion.PageSize = 100; // 一次最多显示100人
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            id = RequestData.Get<string>("id", String.Empty);
            type = RequestData.Get<string>("type", String.Empty).ToLower();
            ctype = RequestData.Get<string>("ctype", "user").ToLower();
            string deptsx = "";
            string DeptId = RequestData.Get<string>("DeptId");
            if (!string.IsNullOrEmpty(DeptId))
            {
                deptsx = " Pk_deptdoc='" + DeptId + "' ";
            }
            else
            {
                deptsx = " Status='1'";
            }
            if (!IsAsyncRequest)
            {
                SearchCriterion.PageSize = 40;
            }
            if (ctype == "group")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ICriterion cirt = null;
                    if (type == "gtype")
                    {
                        cirt = Expression.Sql("   Status='1' and UserID IN (SELECT UserID FROM SysUserGroup WHERE GroupID IN (SELECT GroupID FROM SysGroup WHERE Type = ?))", id, NHibernateUtil.String);
                    }
                    else
                    {
                        // 应该同时获取子组用户
                        cirt = Expression.Sql(deptsx + " and UserID IN (SELECT UserID FROM SysUserGroup WHERE GroupID IN (SELECT GroupID FROM SysGroup WHERE GroupID = ? OR Path LIKE '%" + id + "%'))",
                            id, NHibernateUtil.String);
                    }
                    SearchCriterion.AutoOrder = false;
                    SearchCriterion.SetOrder(SysUser.Prop_WorkNo);
                    users = SysUserRule.FindAll(SearchCriterion, cirt);
                    this.PageState.Add("UsrList", users);
                }
            }
            else if (ctype == "2")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ICriterion cirt = null;
                    if (type == "gtype")
                    {
                        cirt = Expression.Sql("   Status='1' and UserID IN (SELECT UserID FROM SysUserGroup WHERE GroupID IN (SELECT GroupID FROM SysGroup WHERE Type = ?))", id, NHibernateUtil.String);
                    }
                    else
                    {
                        // 应该同时获取子组用户
                        cirt = Expression.Sql(deptsx + " and UserID IN (SELECT UserID FROM SysUserGroup WHERE GroupID IN (SELECT GroupID FROM SysGroup WHERE GroupID = ? OR Path LIKE '%" + id + "%'))",
                            id, NHibernateUtil.String);
                    }
                    SearchCriterion.AutoOrder = false;
                    SearchCriterion.SetOrder(SysUser.Prop_WorkNo);
                    users = SysUserRule.FindAll(SearchCriterion, cirt);
                    this.PageState.Add("UsrList", users);
                }
            }
            else
            {
                SearchCriterion.AutoOrder = false;
                string dName = SearchCriterion.GetSearchValue<string>("Name");
                string workNo = SearchCriterion.GetSearchValue<string>("WorkNo");
                SearchCriterion.SetOrder(SysUser.Prop_WorkNo);
                if (dName != null && dName.Trim() != "")
                {
                    string where = "select * from SysUser where " + GetPinyinWhereString("Name", dName);
                    where += " and WorkNo like '%" + workNo + "%' and Status='1' ";
                    if (!string.IsNullOrEmpty(deptsx))
                    {
                        where += " and " + deptsx;
                    }
                    this.PageState.Add("UsrList", DataHelper.QueryDictList(where));
                }
                else
                {
                    if (deptsx != "")
                    {
                        users = SysUserRule.FindAll(SearchCriterion, Expression.Sql(deptsx));
                    }
                    else
                    {
                        users = SysUserRule.FindAll(SearchCriterion);
                    }
                    this.PageState.Add("UsrList", users);
                }
            }
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
            {
                return whereString.Substring(0, whereString.Length - 4) + ")";
            }
            else
            {
                return "(1=1)";
            }
        }
    }
}
