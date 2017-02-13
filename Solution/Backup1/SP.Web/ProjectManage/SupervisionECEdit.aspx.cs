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
using SP.Model;

namespace SP.Web
{
    public partial class SupervisionECEdit : IMListPage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型  
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            type = RequestData.Get<string>("type");
            SupervisionEC ent = null;
            if (!string.IsNullOrEmpty(id))
            {
                ent = SupervisionEC.Find(id);
            }
            switch (RequestActionString)
            {
                case "update":
                    ent = this.GetMergedData<SupervisionEC>();
                    ent.DoUpdate();
                    break;
                case "create":
                    ent = this.GetPostedData<SupervisionEC>();
                    ent.DoCreate();
                    break;
                default:
                    IList<EnvironmentFactor> dsEnts = EnvironmentFactor.FindAll();
                    PageState.Add("DSEnts", dsEnts);
                    SetFormData(ent);
                    if (ent != null)
                    {
                        string sql = @"select * from NCRL_SP..EnvironmentFactor where PatIndex('%'+Id+'%','" + ent.EnvironmentFactorIds + "')>0  ";
                        PageState.Add("DataList", DataHelper.QueryDictList(sql));
                    }
                    break;
            }
        }
    }
}

