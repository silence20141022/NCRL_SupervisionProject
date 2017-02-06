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

namespace SP.Web.ProjectManage
{
    public partial class SupervisionRiZhiEdit : System.Web.UI.Page
    {
        SupervisionRiZhi ent = null;
        string sql = "";
        string obj = "";
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            switch (action)
            {
                case "load":
                    Select();
                    break;
                case "create":
                    Create();
                    break;
                case "update":
                    Update();
                    break;
                case "loadprj":
                    string name = Request["name"].Trim();
                    string where = "";
                    if (!string.IsNullOrEmpty(name))
                    {
                        where = " and ProjectName like '%" + name + "%'  or ProjectCode like '%" + name + "%'";
                    }
                    sql = "select Id as ProjectId,PManagerId,ProjectName,PManagerName from NCRL_SP..Project  where 1=1 " + where;
                    dt = DataHelper.QueryDataTable(sql);
                    string json = "{'rows':" + JsonHelper.GetJsonStringFromDataTable(dt) + "}";
                    Response.Write(json);
                    Response.End();
                    break;
            }
        }
        private void Create()
        {
            obj = Request["obj"];
            ent = JsonHelper.GetObject<SupervisionRiZhi>(obj);
            ent.CreateId = WebPortalService.CurrentUserInfo.UserID;
            ent.CreateName = WebPortalService.CurrentUserInfo.Name;
            ent.CreateTime = DateTime.Now;
            ent.DoCreate();
        }
        private void Update()
        {
            obj = Request["obj"];
            ent = JsonHelper.GetObject<SupervisionRiZhi>(obj);
            SupervisionRiZhi oldEnt = SupervisionRiZhi.Find(ent.Id);
            EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(obj);
            ent = DataHelper.MergeData<SupervisionRiZhi>(oldEnt, ent, dic.Keys);
            ent.DoUpdate();
        }

        private void Select()
        {
            string Id = Request["Id"];
            ent = SupervisionRiZhi.Find(Id);
            string str = JsonHelper.GetJsonString(ent);
            string json = "{success:  true  ,data:" + str + "}";
            Response.Write(json);
            Response.End();
        }
    }
}