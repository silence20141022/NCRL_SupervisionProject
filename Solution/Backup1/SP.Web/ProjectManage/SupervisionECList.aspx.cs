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
    public partial class SupervisionECList : IMListPage
    {

        private IList<SupervisionEC> ents = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            SupervisionEC ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Delete:
                    ent = GetTargetData<SupervisionEC>();
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
            ents = SupervisionEC.FindAll(SearchCriterion);
            this.PageState.Add("DataList", ents);
        }

        [ActiveRecordTransaction]
        private void DoBatchDelete()
        {
            IList<object> idList = RequestData.GetList<object>("IdList");

            if (idList != null && idList.Count > 0)
            {
                SupervisionEC.DoBatchDelete(idList.ToArray());
            }
        }
    }
}

