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
using Newtonsoft.Json.Linq;
using Aim;
using SP.Model;
using Aim.Common;
using System.Data;
using System.IO;

namespace SP.Web.ProjectManage
{
    public partial class SupervisionJianBaoEdit : System.Web.UI.Page
    {
        SupervisionJianBao ent = null;
        DataTable dt;
        string obj = "";
        string sql = "";
        string where = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            switch (action)
            {
                case "create":
                    create();
                    break;
                case "update":
                    obj = Request["obj"];
                    ent = JsonHelper.GetObject<SupervisionJianBao>(obj);
                    SupervisionJianBao oldEnt = SupervisionJianBao.Find(ent.Id);
                    EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(obj);
                    ent = DataHelper.MergeData<SupervisionJianBao>(oldEnt, ent, dic.Keys);
                    ent.DoUpdate();
                    break;
                case "Load":
                    string Id = Request["Id"];
                    ent = SupervisionJianBao.Find(Id);
                    string str = JsonHelper.GetJsonString(ent);
                    Response.Write("{success:  true  ,data:" + str + "}");
                    Response.End();
                    break;
                case "PNameCombo":
                    PNameCombo();
                    break;

            }
        }
        private void create()
        {
            obj = Request["obj"];
            ent = JsonHelper.GetObject<SupervisionJianBao>(obj);
            ent.CreateId = WebPortalService.CurrentUserInfo.UserID;
            ent.CreateName = WebPortalService.CurrentUserInfo.Name;
            ent.CreateTime = DateTime.Now;
            ent.DoCreate();
        }
        private void PNameCombo()
        {
            string name = Request["name"].Replace(" ", "");
            if (!string.IsNullOrEmpty(name))
            {
                where = " and ProjectName like '%" + name + "%'  or ProjectCode like '%" + name + "%'";
            }
            sql = "select Id as ProjectId,PManagerId,ProjectName,PManagerName from NCRL_SP..Project  where 1=1 " + where;
            dt = DataHelper.QueryDataTable(sql);
            string str = JsonHelper.GetJsonString(dt);
            string json = "{'rows':" + str + "}";
            Response.Write(json);
            Response.End();
        }
    }
}