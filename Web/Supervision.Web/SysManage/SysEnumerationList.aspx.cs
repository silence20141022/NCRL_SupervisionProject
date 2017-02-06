using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Portal.Model;
using Aim;
using Aim.Data;
using Aim.Portal.Web;

namespace SP.Web.SysManage
{
    public partial class SysEnumerationList : System.Web.UI.Page
    {
        string id = "";
        SysEnumeration Ent = null;
        string parentid = "";
        string json = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Aim.Portal.Web.WebPortalService.CheckLogon();
            }
            catch
            {
                Response.Write("<script> window.parent.location.href = '/Login.aspx';</script>");
                Response.End();
            }
            string action = Request["action"];
            json = Request["json"];
            switch (action)
            {
                case "select":
                    Select();
                    break;
                case "delete":
                    Delete();
                    break;
                case "update":
                    Ent = JsonHelper.GetObject<SysEnumeration>(json);
                    SysEnumeration originalEnt = SysEnumeration.Find(Ent.EnumerationID);
                    EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(json);
                    originalEnt = DataHelper.MergeData<SysEnumeration>(originalEnt, Ent, dic.Keys);
                    originalEnt.Value = originalEnt.Name;
                    originalEnt.DoUpdate();
                    break;
                case "create":
                    Ent = JsonHelper.GetObject<SysEnumeration>(json);
                    SysEnumeration EntParent = SysEnumeration.Find(Ent.ParentID);
                    Ent.Value = Ent.Name;
                    Ent.IsLeaf = true;
                    if (string.IsNullOrEmpty(EntParent.Path))
                    {
                        Ent.Path = EntParent.EnumerationID;
                    }
                    else
                    {
                        Ent.Path = EntParent.Path + "." + EntParent.EnumerationID;
                    }
                    Ent.PathLevel = EntParent.PathLevel + 1;
                    Ent.CreaterID = WebPortalService.CurrentUserInfo.UserID;
                    Ent.CreaterName = WebPortalService.CurrentUserInfo.Name;
                    Ent.DoCreate();
                    //------------------------
                    if (Convert.ToInt32(EntParent.IsLeaf) == 1)
                    {
                        EntParent.IsLeaf = false;
                        EntParent.Update();
                    }
                    break;
                case "loadform":
                    string EnumerationID = Request["EnumerationID"];
                    json = JsonHelper.GetJsonString(SysEnumeration.Find(EnumerationID));
                    Response.Write("{success:true,data:" + json + "}");
                    Response.End();
                    break;
            }
        }
        private void Delete()
        {
            string EnumID = Request["EnumID"];
            Ent = SysEnumeration.Find(EnumID);
            SysEnumeration ent_parent = SysEnumeration.Find(Ent.ParentID);
            Ent.DoDelete();
            IList<SysEnumeration> ents_sysenumeration = SysEnumeration.FindAllByProperty(SysEnumeration.Prop_ParentID, ent_parent.EnumerationID);
            if (ents_sysenumeration.Count == 0)
            {
                ent_parent.IsLeaf = true;
                ent_parent.DoUpdate();
            }
        }
        private void Select()
        {
            id = Request["id"];
            if (!string.IsNullOrEmpty(id))
            {
                IList<SysEnumeration> Ents = SysEnumeration.FindAllByProperty(SysEnumeration.Prop_SortIndex, SysEnumeration.Prop_ParentID, id);
                string result = "[";
                int i = 0;
                foreach (SysEnumeration Ent in Ents)
                {
                    if (i != Ents.Count - 1)
                    {
                        result += "{id:'" + Ent.EnumerationID + "',Name:'" + Ent.Name + "',Code:'" + Ent.Code + "',Value:'" + Ent.Value + "',ParentID:'" + Ent.ParentID + "',leaf:" + (Ent.IsLeaf.Value ? "true" : "false") + "},";
                    }
                    else
                    {
                        result += "{id:'" + Ent.EnumerationID + "',Name:'" + Ent.Name + "',Code:'" + Ent.Code + "',Value:'" + Ent.Value + "',ParentID:'" + Ent.ParentID + "',leaf:" + (Ent.IsLeaf.Value ? "true" : "false") + "}";
                    }
                    i++;
                }
                result += "]";
                Response.Write("{children:" + result + "}");
                Response.End();
            }
        }
    }
}