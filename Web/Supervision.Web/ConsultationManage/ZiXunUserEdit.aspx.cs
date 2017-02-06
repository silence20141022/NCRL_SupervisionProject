using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim;
using System.Data;
using SP.Model;
using Aim.Portal.Model;
using Aim.Security;

namespace SP.Web
{
    public partial class ZiXunUserEdit : System.Web.UI.Page
    {
        string sql = "";
        SysUser ent = null;
        string obj = "";
        string UserId = "";
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Aim.Portal.Web.WebPortalService.CheckLogon();
            }
            catch
            {
                Response.Write("<script> window.location.href = '/Login.aspx';</script>");
                Response.End();
            }
            string action = Request["action"];
            UserId = Request["UserId"];
            switch (action)
            {
                case "Create":
                    obj = Request["json"];
                    ent = JsonHelper.GetObject<SysUser>(obj);
                    MD5Encrypt encrypt = new MD5Encrypt();
                    ent.Server_IAGUID = "267";
                    ent.Server_Seed = "江西瑞林工程咨询有限公司";
                    ent.LoginName = ent.IDNumber;
                    ent.Status = 1;
                    ent.Password = encrypt.GetMD5FromString(ent.LoginName);
                    ent.DoCreate();
                    break;
                case "Update":
                    obj = Request["json"];
                    ent = JsonHelper.GetObject<SysUser>(obj);
                    SysUser ori_Ent = SysUser.Find(ent.UserID);
                    EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(obj);
                    ent = DataHelper.MergeData<SysUser>(ori_Ent, ent, dic.Keys);
                    ent.DoUpdate();
                    break;
                case "SelectEdit":
                    SelectEdit();
                    break;
                case "check":
                    Check();
                    break;
            }
        }

        private void Check()
        {
            int ischeck;
            var LoginName = Request["check"];
            if (!string.IsNullOrEmpty(UserId))
            {
                sql = "select * from NCRL_Portal..sysuser where LoginName = '" + LoginName.Replace(" ", "") + "' and UserId !='" + UserId + "' ";
            }
            else
            {
                sql = "select * from NCRL_Portal..sysuser where LoginName = '" + LoginName.Replace(" ", "") + "'";
            }
            dt = DataHelper.QueryDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                ischeck = 1;
            }
            else
            {
                ischeck = 0;
            }
            Response.Write("{success: true  ,ischeck:'" + ischeck + "'}");
            Response.End();
        }
        private void SelectEdit()
        {
            if (!string.IsNullOrEmpty(UserId))
            {
                string data = JsonHelper.GetJsonString(SysUser.Find(UserId));
                Response.Write("{success: true  ,data:" + data + "}");
                Response.End();
            }
        } 
    }
}