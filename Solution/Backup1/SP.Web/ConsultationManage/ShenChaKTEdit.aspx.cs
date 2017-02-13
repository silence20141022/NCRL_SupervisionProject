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
    public partial class ShenChaKTEdit : IMListPage
    {
        #region 变量

        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            type = RequestData.Get<string>("type");

            ShenChaReport ent = null;

            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<ShenChaReport>();
                    ent.DoUpdate();
                    this.SetMessage("修改成功！");
                    break;
                case RequestActionEnum.Insert:
                case RequestActionEnum.Create:
                    ent = this.GetPostedData<ShenChaReport>();

                    ent.DoCreate();
                    this.SetMessage("新建成功！");
                    break;
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<ShenChaReport>();
                    ent.DoDelete();
                    this.SetMessage("删除成功！");
                    return;
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

        #endregion
    }
}

