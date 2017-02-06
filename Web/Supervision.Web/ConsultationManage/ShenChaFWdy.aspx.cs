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
using System.Data;

namespace SP.Web
{
    public partial class ShenChaFWdy : IMListPage
    {
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id 
        ShenChaReport ent = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");

            switch (this.RequestAction)
            {
                default:
                    DoSelect();
                    break;
            }
            DataTable dt = DataHelper.QueryDataTable("select * from  NCRL_SP..Project where id='" + id + "'");
            this.PageState.Add("pro", dt);
            if (op != "c" && op != "cs")
            {
                dt = DataHelper.QueryDataTable("select Id from  NCRL_SP..ShenChaReport where ProjectId='" + id + "'");
                if (dt.Rows.Count != 0)
                {
                    string sid = dt.Rows[0]["Id"].ToString();
                    if (!String.IsNullOrEmpty(sid))
                    {
                        ent = ShenChaReport.Find(sid);
                    }

                    this.SetFormData(ent);
                }
            }
        }
        private void DoSelect()
        {
            if (!string.IsNullOrEmpty(id))
            {
                ent = ShenChaReport.Find(id); 
                Project pEnt = Project.Find(ent.ProjectId);
                PageState.Add("ProjectInfo", pEnt);
                PageState.Add("ReportInfo", ent);
            }
        }
    }
}

