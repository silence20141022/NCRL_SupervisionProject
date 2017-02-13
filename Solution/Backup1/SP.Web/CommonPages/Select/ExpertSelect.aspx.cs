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


namespace SP.Web.CommonPages.Select
{
    public partial class ExpertSelect : IMListPage
    {


        #region 变量

        private Expert[] ents = null;

        #endregion


        #region ASP.NET 事件
        protected void Page_Load(object sender, EventArgs e)
        {
            ents = Expert.FindAll(SearchCriterion);
            PageState.Add("Expert", ents);

        }
        # endregion
    }
}