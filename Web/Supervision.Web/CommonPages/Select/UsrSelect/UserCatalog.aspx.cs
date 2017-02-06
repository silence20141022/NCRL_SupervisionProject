using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Web.Script.Serialization;

using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
//using Aim.Examining.Model;


namespace Aim.Portal.Web.CommonPages
{
    public partial class UserCatalog : BaseListPage
    {
        #region 属性

        private SysGroup[] ents = null;

        #endregion

        #region 变量

        #endregion

        #region 构造函数

        public UserCatalog()
        {
            IsCheckLogon = false;
        }

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.IsAsyncRequest)
            {
                switch (this.RequestAction)
                {
                    case RequestActionEnum.Custom:
                        if (RequestActionString == "querychildren")
                        {
                            string id = (RequestData.ContainsKey("ID") ? RequestData["ID"].ToString() : String.Empty);
                            if (RequestData.ContainsKey("Type"))
                            {
                                string type = RequestData["Type"].ToString().ToLower();
                                if (type == "gtype")
                                {
                                    ents = SysGroup.FindAll("FROM SysGroup as ent WHERE ent.Type = ? and ent.ParentID is null order by SortIndex", id);

                                    this.PageState.Add("DtList", ents);
                                }
                                if (id != "" && id.Length > 1)
                                {
                                    ents = SysGroup.FindAll("FROM SysGroup as ent WHERE ent.ParentID = ? and ent.Type=2 order by SortIndex ", id);
                                    this.PageState.Add("DtList", ents);
                                }
                            }
                        }
                        break;
                }
            }
            else
            {
                // 选择组织结构类型
                ents = SysGroup.FindAll("FROM SysGroup as ent WHERE ent.GroupID = 'A67ADFAA-CC13-4168-9588-B52D6BC555D3' and ent.Type=2 order by SortIndex ");
                this.PageState.Add("DtList", ents);
            }



        }

        #endregion
    }
}
