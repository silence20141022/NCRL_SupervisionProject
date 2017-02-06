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
    public partial class KangZhenOpinion_Edit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            string projectid = Request["ProjectId"];
            string sql = "";
            KangZhen_Project kzp_Ent = null;
            IList<KangZhen_Project> kzp_Ents = null;
            switch (action)
            {
                case "loadform":
                    sql = "select a.*,b.ProjectName from NCRL_SP..KangZhen_Project a left join NCRL_SP..Project b on a.ProjectId=b.Id where a.ProjectId='" + projectid + "'";
                    IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
                    if (dics.Count > 0)
                    {
                        Response.Write("{success:true,data:" + JsonHelper.GetJsonString(dics[0]) + "}");
                    }
                    else
                    {
                        Project pEnt = Project.Find(projectid);
                        string layers = "";
                        if (!string.IsNullOrEmpty(pEnt.UpperLayers))
                        {
                            layers += "地上层数：" + pEnt.UpperLayers;
                        }
                        if (!string.IsNullOrEmpty(pEnt.DownLayers))
                        {
                            layers += "  地下层数：" + pEnt.DownLayers;
                        }
                        sql = @"select top 1 UserName as ZhuCeJieGouShi from NCRL_SP..KanChaSheJi  a 
                        where a.ProjectId='" + projectid + "' and  a.Position like '%注册结构师%'";
                        Response.Write("{success:true,data:{ProjectName:'" + pEnt.ProjectName + "',KangZhenLieDu:'" + pEnt.KangZhenLieDu + "',ProjectType:'" + pEnt.ProjectType + "',ZhuCeJieGouShi:'" + DataHelper.QueryValue(sql) + "',CengShu:'" + layers + "',FoundationType:'" + pEnt.FoundationType + "',ZhuanXiangShenChaOpinion:'满足规范要求'}}");
                    }
                    Response.End();
                    break;
                case "update":
                    try
                    {
                        kzp_Ents = KangZhen_Project.FindAllByProperty(KangZhen_Project.Prop_ProjectId, projectid);
                        string json = Request["json"];
                        KangZhen_Project ent_new = JsonHelper.GetObject<KangZhen_Project>(json);
                        if (kzp_Ents.Count > 0)
                        {
                            kzp_Ent = kzp_Ents[0];
                            EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(json);
                            kzp_Ent = DataHelper.MergeData<KangZhen_Project>(kzp_Ent, ent_new, dic.Keys);
                            kzp_Ent.DoUpdate();
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
                    }
                    catch
                    {
                        Response.Write("{success:false}");
                    }
                    Response.End();
                    break;
            }
        }
    }
}