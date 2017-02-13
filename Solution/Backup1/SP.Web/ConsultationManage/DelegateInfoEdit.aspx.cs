using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SP.Model;
using Aim;
using Aim.Portal.Web;
using Aim.Data;

namespace SP.Web.ConsultationManage
{
    public partial class DelegateInfoEdit : System.Web.UI.Page
    {
        DelegateInfo ent = null;
        string Id = "";
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
            Id = Request["Id"];
            switch (action)
            {
                case "Create":
                    Create();
                    break;
                case "Update":
                    string obj = Request["json"];
                    ent = JsonHelper.GetObject<DelegateInfo>(obj);
                    DelegateInfo ori_Ent = DelegateInfo.Find(Id);
                    EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(obj);
                    ori_Ent = DataHelper.MergeData<DelegateInfo>(ori_Ent, ent, dic.Keys);
                    ori_Ent.DoUpdate();
                    break;
                case "SelectEdit":
                    SelectEdit();
                    break;
            }
        }
        private void Create()
        {
            Convertor();
            ent.DoCreate();
        }
        private void Update()
        {

        }
        private void SelectEdit()
        {
            if (!string.IsNullOrEmpty(Id))
            {
                string data = JsonHelper.GetJsonString(DelegateInfo.Find(Id));
                string sa = "{success: true  ,data:" + data + "}";
                Response.Write(sa);
                Response.End();
            }
        }
        private void Convertor()
        {
            string obj = Request["json"];
            ent = JsonHelper.GetObject<DelegateInfo>(obj);
            ent.CreateId = WebPortalService.CurrentUserInfo.UserID;
            ent.CreateName = WebPortalService.CurrentUserInfo.Name;
            ent.CreateTime = DateTime.Now;
        }
    }
}