using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Portal.Model;
using Aim.Portal;
using Aim.Common;
using Aim.Portal.Web;

namespace SP.Web
{
    public partial class SysFrame : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request["id"];
            string strAction = Request["action"];
            IList<SysModule> ents = null;

            if (strAction == "logout")
            {
                WebPortalService.LogoutAndRedirect();
            }

            if (!string.IsNullOrEmpty(id))
            {
                if (id == "-1")
                {
                    // WebPortalService.CurrentUserContext.UserInfo.UserID
                    ents = WebPortalService.CurrentUserContext.AccessibleModules.Where(tent => tent.ApplicationID == "d0f7290f-914c-4de0-af68-3ca340209e11").ToList();
                    ents = ents.Where(tent => String.IsNullOrEmpty(tent.ParentID)).ToList();
                    ents = ents.OrderBy(tent => tent.SortIndex).ToList();
                }
                else
                {
                    ents = WebPortalService.CurrentUserContext.AccessibleModules.Where(tent => tent.ParentID == id).ToList();
                    ents = ents.OrderBy(tent => tent.SortIndex).ToList();
                }
                int i = 0;
                string result = "[";
                foreach (SysModule smEnt in ents)
                {
                    if (i != ents.Count - 1)
                    {
                        result += "{id:'" + smEnt.ModuleID + "',name:'" + smEnt.Name + "',leaf:'" + smEnt.IsLeaf + "',url:'" + smEnt.Url + "'},";
                    }
                    else
                    {
                        result += "{id:'" + smEnt.ModuleID + "',name:'" + smEnt.Name + "',leaf:'" + smEnt.IsLeaf + "',url:'" + smEnt.Url + "'}";
                    }
                    i++;
                }
                result += "]";
                Response.Write(result);
                Response.End();
            }
        }
    }
}