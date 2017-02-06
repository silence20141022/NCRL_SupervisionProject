﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim.Portal.Web.UI;
using Aim.Portal.Model;


namespace Aim.Portal.Web.Modules.SysApp.SiteMag
{
    public partial class SysParameterCatalogEdit : BasePage
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

            SysParameterCatalog ent = null;

            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<SysParameterCatalog>();
                    ent.Update();
                    this.SetMessage("修改成功！");
                    break;
                case RequestActionEnum.Create:
                    ent = this.GetPostedData<SysParameterCatalog>();
                    ent.CreaterID = UserInfo.UserID;
                    ent.CreaterName = UserInfo.Name;

                    if (String.IsNullOrEmpty(id))
                    {
                        ent.CreateAsRoot();
                    }
                    else
                    {
                        ent.CreateAsSibling(SysParameterCatalog.Find(id));
                    }

                    this.SetMessage("新建成功！");
                    break;
                default:
                    if (RequestActionString == "createsub")
                    {
                        ent = this.GetPostedData<SysParameterCatalog>();
                        ent.CreaterID = UserInfo.UserID;
                        ent.CreaterName = UserInfo.Name;

                        ent.CreateAsChild(SysParameterCatalog.Find(id));

                        this.SetMessage("新建成功！");
                    }
                    break;
            }

            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = SysParameterCatalog.Find(id);
                }
                
                this.SetFormData(ent);
            }
            else
            {
                PageState.Add("CreaterName", UserInfo.Name);
                PageState.Add("CreatedDate", DateTime.Now);
            }
        }

        #endregion
    }
}

