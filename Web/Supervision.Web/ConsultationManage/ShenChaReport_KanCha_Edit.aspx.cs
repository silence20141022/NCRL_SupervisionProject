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
    public partial class ShenChaReport_KanCha_Edit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            string projectid = Request["ProjectId"];
            string sql = "";
            IList<ShenChaReport_KanCha> scrkEnts = null;
            ShenChaReport_KanCha scrkEnt = null;
            switch (action)
            {
                case "loadform":
                    sql = "select a.*,b.ProjectName from NCRL_SP..ShenChaReport_KanCha a left join NCRL_SP..Project b on a.ProjectId=b.Id where a.ProjectId='" + projectid + "'";
                    IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
                    if (dics.Count > 0)
                    {
                        Response.Write("{success:true,data:" + JsonHelper.GetJsonString(dics[0]) + "}");
                    }
                    else
                    {
                        Project pEnt = Project.Find(projectid);
                        string opinion1 = "1、勘察报告提供的数据真实可靠；2、报建手续齐全；3、按规定盖有出图章和签署；4、工程基础含软基处理安全、可靠；5、见证材料符合《关于加强全省建设工程勘察外业工作的意见》（赣建字2013-2）要求。";
                        string opinion2 = "符合有关工程强制性标准规范";
                        string opinion3 = "符合要求";
                        string opinion4 = "该岩土工程勘察报告按照审查意见经回复整改后符合国家有关《工程建设标准强制性条文》及国家和本省的各种建设工程设计规范、标准要求。";
                        Response.Write("{success:true,data:{ProjectName:'" + pEnt.ProjectName + "',Opinion1:'" + opinion1 + "',Opinion2:'" + opinion2 + "',Opinion3:'" + opinion3 + "',Opinion4:'" + opinion4 + "'}}");
                    }
                    Response.End();
                    break;
                case "update":
                    try
                    {
                        scrkEnts = ShenChaReport_KanCha.FindAllByProperty(ShenChaReport_KanCha.Prop_ProjectId, projectid);
                        string json = Request["json"];
                        ShenChaReport_KanCha ent_new = JsonHelper.GetObject<ShenChaReport_KanCha>(json);
                        if (scrkEnts.Count > 0)
                        {
                            scrkEnt = scrkEnts[0];
                            EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(json);
                            scrkEnt = DataHelper.MergeData<ShenChaReport_KanCha>(scrkEnt, ent_new, dic.Keys);
                            scrkEnt.DoUpdate();
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