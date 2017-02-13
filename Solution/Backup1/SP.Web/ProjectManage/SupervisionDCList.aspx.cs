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
    public partial class SupervisionDCList : IMListPage
    {
        private IList<SupervisionDC> ents = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            SupervisionDC ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<SupervisionDC>();
                    ent.DoDelete();
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
        private void DoSelect()
        {
            ents = SupervisionDC.FindAll(SearchCriterion);
            PageState.Add("DataList", ents);
        }

        [ActiveRecordTransaction]
        private void DoBatchDelete()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {
                SupervisionDC.DoBatchDelete(idList.ToArray());
            }
        }
    }
}

