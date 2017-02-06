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

namespace SP.Web.DailyManage
{
    public partial class JianLiUserEdit : System.Web.UI.Page
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
            MD5Encrypt encrypt = new MD5Encrypt();
            switch (action)
            {
                case "loadgroupdata":
                    string Id = Request["id"];
                    sql = "select GroupID,replace(Name,'江西瑞林建设监理有限公司','') as Name from SysGroup where ParentId='" + Id + "' order by Code asc";
                    IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
                    string result = "[";
                    int i = 0;
                    foreach (EasyDictionary dic_temp in dics)
                    {
                        if (i != dics.Count - 1)
                        {
                            result += "{id:'" + dic_temp.Get<string>("GroupID") + "',text:'" + dic_temp.Get<string>("Name") + "',leaf:true},";
                        }
                        else
                        {
                            result += "{id:'" + dic_temp.Get<string>("GroupID") + "',text:'" + dic_temp.Get<string>("Name") + "',leaf:true}";
                        }
                        i++;
                    }
                    result += "]";
                    Response.Write(result);
                    Response.End();
                    break;
                case "Create":
                    obj = Request["json"];
                    ent = JsonHelper.GetObject<SysUser>(obj);
                  
                    ent.Server_Seed = (ent.Server_Seed.IndexOf("江西瑞林建设监理有限公司") < 0 ? "江西瑞林建设监理有限公司" : "") + ent.Server_Seed;
                    ent.LoginName = ent.IDNumber;
                    ent.Password = encrypt.GetMD5FromString(ent.LoginName);
                    ent.DoCreate();
                    Response.Write("{success:true}");
                    Response.End();
                    break;
                case "Update":
                    obj = Request["json"];
                    ent = JsonHelper.GetObject<SysUser>(obj);
                    SysUser ori_Ent = SysUser.Find(ent.UserID);
                    EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(obj);
                    ent = DataHelper.MergeData<SysUser>(ori_Ent, ent, dic.Keys);
                    ent.Password = encrypt.GetMD5FromString(ent.LoginName);
                    ent.Server_Seed = (ent.Server_Seed.IndexOf("江西瑞林建设监理有限公司") < 0 ? "江西瑞林建设监理有限公司" : "") + ent.Server_Seed;
                    ent.DoUpdate();
                    Response.Write("{success:true}");
                    Response.End();
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