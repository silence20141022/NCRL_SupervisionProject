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
using SP.Web;
using Aim.Portal.Model; 

namespace Aim.Portal.Web.CommonPages
{
    public partial class RolSelView : IMBasePage
    {
        string op = String.Empty;
        string cid = String.Empty;   // 对象id
        string type = String.Empty; // 查询类型
        string ctype = String.Empty; // 分类类型
        private IList<SysRole> ents = new List<SysRole>();
        public RolSelView()
        {
            SearchCriterion.CurrentPageIndex = 1;
            SearchCriterion.PageSize = 100; // 一次最多显示100个角色
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            cid = RequestData.Get<string>("cid", String.Empty);
            type = RequestData.Get<string>("type", String.Empty).ToLower();
            ctype = RequestData.Get<string>("ctype", "role").ToLower();

            if (!String.IsNullOrEmpty(cid))
            {
                try
                {
                    int icid = Convert.ToInt32(cid);

                    SearchCriterion.AddSearch("Type", icid);

                    ents = SysRoleRule.FindAll(SearchCriterion);
                }
                catch { }
            }
            else
            {
                ents = SysRoleRule.FindAll(SearchCriterion);
            }
            this.PageState.Add("DtList", ents);
        }
    }
}
