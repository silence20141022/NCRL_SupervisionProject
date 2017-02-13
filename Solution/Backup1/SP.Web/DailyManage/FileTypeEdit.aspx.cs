using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Portal.Model;
using Aim;
using Aim.Data;

namespace SP.Web.DailyManage
{
    public partial class FileTypeEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Aim.Portal.Web.WebPortalService.CheckLogon();
            }
            catch
            {
                Response.Redirect("/Login.aspx");
            }
            string action = Request["action"];
            SysEnumeration seEnt = null;
            string json = "";
            switch (action)
            {
                case "create":
                    json = Request["json"];
                    seEnt = JsonHelper.GetObject<SysEnumeration>(json);
                    seEnt.Value = seEnt.Name;
                    seEnt.IsLeaf = true;
                    seEnt.DoCreate();
                    SysEnumeration seEnt_parent = SysEnumeration.Find(seEnt.ParentID);
                    seEnt_parent.IsLeaf = false;
                    seEnt_parent.DoUpdate();
                    break;
                case "update":
                    json = Request["json"];
                    seEnt = JsonHelper.GetObject<SysEnumeration>(json);
                    SysEnumeration originalEnt = SysEnumeration.Find(seEnt.EnumerationID);
                    EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(json);
                    originalEnt = DataHelper.MergeData<SysEnumeration>(originalEnt, seEnt, dic.Keys);
                    originalEnt.Value = originalEnt.Name;
                    originalEnt.DoUpdate();
                    break;
                case "loadformdata":
                    string id = Request["id"];
                    json = JsonHelper.GetJsonString(SysEnumeration.Find(id));
                    Response.Write("{success:true,data:" + json + "}");
                    Response.End();
                    break;
            }
        }
    }
}