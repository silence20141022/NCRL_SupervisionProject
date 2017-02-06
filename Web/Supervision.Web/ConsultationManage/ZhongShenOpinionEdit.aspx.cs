using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SP.Model;
using Aim.Data;
using Aim;

namespace SP.Web.ConsultationManage
{
    public partial class ZhongShenOpinionEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            string projectid = Request["ProjectId"];
            string sql = "";
            DataTable dt;
            ZhongShenOpinion_Project zsop_Ent = null;
            IList<ZhongShenOpinion_Project> zsop_Ents = null;
            switch (action)
            {
                case "loadform":
                    sql = "select a.*,b.ProjectName from NCRL_SP..ZhongShenOpinion_Project a left join NCRL_SP..Project b on a.ProjectId=b.Id where a.ProjectId='" + projectid + "'";
                    IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
                    if (dics.Count > 0)
                    {
                        Response.Write("{success:true,data:" + JsonHelper.GetJsonString(dics[0]) + "}");
                    }
                    else
                    {
                        Project pEnt = Project.Find(projectid);
                        sql = @"select PU.MajorName,PU.QianZhangName,PU.ShenHeName from NCRL_SP..ProjectUser PU 
                        left join NCRL_Portal..SysEnumeration E ON PU.MajorName = E.Name 
                        where PU.ProjectId='" + projectid + "' and E.ParentID = 'b640c40c-e2a9-41a8-bd28-d8ff9d71ff94' order by E.sortindex asc";
                        dt = DataHelper.QueryDataTable(sql);
                        string MajorName = "";
                        string ShenChaName = "";
                        string FuHeName = "";
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            if (i != dt.Rows.Count - 1)
                            {
                                MajorName += dt.Rows[i].ItemArray[0].ToString().Trim() + "、";
                                ShenChaName += dt.Rows[i].ItemArray[1].ToString().Trim() + "、";
                                FuHeName += dt.Rows[i].ItemArray[2].ToString().Trim() + "、";
                            }
                            else
                            {
                                MajorName += dt.Rows[i].ItemArray[0];
                                ShenChaName += dt.Rows[i].ItemArray[1];
                                FuHeName += dt.Rows[i].ItemArray[2];
                            }
                        }
                        string zhongshenopinion = "按审查意见答复后各专业均满足相关规范要求。";//默认值
                        Response.Write("{success:true,data:{ProjectName:'" + pEnt.ProjectName + "',MajorName:'" + MajorName + "',ShenChaName:'" + ShenChaName + "',FuHeName:'" + FuHeName + "',ZhongShenOpinion:'" + zhongshenopinion + "'}}");
                    }
                    Response.End();
                    break;
                case "update":
                    zsop_Ents = ZhongShenOpinion_Project.FindAllByProperty(ZhongShenOpinion_Project.Prop_ProjectId, projectid);
                    string json = Request["json"];
                    ZhongShenOpinion_Project ent_new = JsonHelper.GetObject<ZhongShenOpinion_Project>(json);
                    if (zsop_Ents.Count > 0)
                    {
                        zsop_Ent = zsop_Ents[0];
                        EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(json);
                        zsop_Ent = DataHelper.MergeData<ZhongShenOpinion_Project>(zsop_Ent, ent_new, dic.Keys);
                        zsop_Ent.DoUpdate();
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