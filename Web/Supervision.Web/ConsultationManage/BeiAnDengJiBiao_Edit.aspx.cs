using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SP.Model;
using Aim;
using Aim.Data;

namespace SP.Web.ConsultationManage
{
    public partial class BeiAnDengJiBiao_Edit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BeiAn_Project bap_Ent = null;
            IList<BeiAn_Project> bap_Ents = null;
            string action = Request["action"];
            string projectid = Request["ProjectId"];
            string sql = "";
            switch (action)
            {
                case "loadform":
                    sql = "select a.*,b.ProjectName from NCRL_SP..BeiAn_Project a left join NCRL_SP..Project b on a.ProjectId=b.Id where a.ProjectId='" + projectid + "'";
                    IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
                    if (dics.Count > 0)
                    {
                        Response.Write("{success:true,data:" + JsonHelper.GetJsonString(dics[0]) + "}");
                    }
                    else
                    {
                        Project pEnt = Project.Find(projectid);
                        Response.Write("{success:true,data:" + JsonHelper.GetJsonString(pEnt) + "}");
                    }
                    Response.End();
                    break;
                case "update":
                    bap_Ents = BeiAn_Project.FindAllByProperty(BeiAn_Project.Prop_ProjectId, projectid);
                    string json = Request["json"];
                    BeiAn_Project ent_new = JsonHelper.GetObject<BeiAn_Project>(json);
                    if (bap_Ents.Count > 0)
                    {
                        bap_Ent = bap_Ents[0];
                        EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(json);
                        bap_Ent = DataHelper.MergeData<BeiAn_Project>(bap_Ent, ent_new, dic.Keys);
                        bap_Ent.DoUpdate();
                    }
                    else
                    {
                        ent_new.ProjectId = projectid;
                        ent_new.CreateId = Aim.Portal.Web.WebPortalService.CurrentUserInfo.UserID;
                        ent_new.CreateName = Aim.Portal.Web.WebPortalService.CurrentUserInfo.Name;
                        ent_new.CreateTime = DateTime.Now;
                        ent_new.DoCreate();
                    }
                    Response.Write("{success:true}");
                    Response.End();
                    break;
            }
        }
    }
}