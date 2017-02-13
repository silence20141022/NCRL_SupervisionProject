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
using SP.Model;
using System.Configuration;
using Aim;
using Aim.Portal.Model;
namespace SP.Web
{
    public partial class ProjectSelect : IMListPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DoSelect();
        }

        private void DoSelect()
        {
            IList<Project> puEnts = Project.FindAll(SearchCriterion);
            this.PageState.Add("ProjectList", puEnts);
        }
    }
}
