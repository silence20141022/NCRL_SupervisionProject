using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim;
using SP.Model;
using System.Data;
using Aim.Data;
using Aim.Portal.Web;

namespace SP.Web.ConsultationManage
{
    public partial class ShenChaReport_FWJZ : System.Web.UI.Page
    {
        string sql = "";
        ShenChaReport ent = null;
        string ProjectId = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            ProjectId = Request["ProjectId"];
            string obj = "";
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "SelectEdit":
                        sql = @"select P.ProjectName ,P.Investment,P.DetailLocation,P.EngineeringLevel,P.Height,
                        P.UpperLayers,P.DownLayers,P.BuildingArea,P.JianSheUnit,P.JianSheUnitHead,P.KanChaUnit,
                        P.KanChaUnitHead,P.KanChaZZLevel,P.KanChaUnitZSNo, P.SheJiUnit, P.SheJiUnitHead,
                        P.SheJiUnitGrade, P.SheJiUnitZSNo, P.IfChaoGao,P.GongChenLiang,
                        S.Id, S.ShenChaNo,S.ProjectId,S.Opinion1 ,S.Opinion1ShenChaName,S.Opinion1CreateTime, 
                        S.Opinion2, S.Opinion2ShenChaName,S.Opinion2CreateTime, S.Opinion3, S.Opinion3ShenChaName,S.Opinion3CreateTime, 
                        S.Opinion4, S.Opinion4ShenChaName,S.Opinion4CreateTime,S.Opinion5, S.Opinion5ShenChaName,S.Opinion5CreateTime, 
                        S.Opinion6, S.Opinion6ShenChaName,S.Opinion6CreateTime,S.Opinion7, S.Opinion7ShenChaName,S.Opinion7CreateTime 
                        from NCRL_SP..Project as P left join NCRL_SP..ShenChaReport as S on P.ID =S.ProjectId  where P.Id='" + ProjectId + "'";
                        IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
                        if (!string.IsNullOrEmpty(dics[0].Get<string>("Opinion1CreateTime")))
                        {
                            dics[0].Set("Opinion1CreateTime", dics[0].Get<DateTime>("Opinion1CreateTime").ToString("yyyy-MM-dd"));
                        }
                        if (!string.IsNullOrEmpty(dics[0].Get<string>("Opinion2CreateTime")))
                        {
                            dics[0].Set("Opinion2CreateTime", dics[0].Get<DateTime>("Opinion2CreateTime").ToString("yyyy-MM-dd"));
                        }
                        if (!string.IsNullOrEmpty(dics[0].Get<string>("Opinion3CreateTime")))
                        {
                            dics[0].Set("Opinion3CreateTime", dics[0].Get<DateTime>("Opinion3CreateTime").ToString("yyyy-MM-dd"));
                        }
                        if (!string.IsNullOrEmpty(dics[0].Get<string>("Opinion4CreateTime")))
                        {
                            dics[0].Set("Opinion4CreateTime", dics[0].Get<DateTime>("Opinion4CreateTime").ToString("yyyy-MM-dd"));
                        }
                        if (!string.IsNullOrEmpty(dics[0].Get<string>("Opinion5CreateTime")))
                        {
                            dics[0].Set("Opinion5CreateTime", dics[0].Get<DateTime>("Opinion5CreateTime").ToString("yyyy-MM-dd"));
                        }
                        if (!string.IsNullOrEmpty(dics[0].Get<string>("Opinion6CreateTime")))
                        {
                            dics[0].Set("Opinion6CreateTime", dics[0].Get<DateTime>("Opinion6CreateTime").ToString("yyyy-MM-dd"));
                        }
                        if (!string.IsNullOrEmpty(dics[0].Get<string>("Opinion7CreateTime")))
                        {
                            dics[0].Set("Opinion7CreateTime", dics[0].Get<DateTime>("Opinion7CreateTime").ToString("yyyy-MM-dd"));
                        }
                        Response.Write("{success: true,data:" + JsonHelper.GetJsonString(dics[0]) + "}");
                        Response.End();
                        break;
                    case "Create":
                        obj = Request["json"];
                        ent = JsonHelper.GetObject<ShenChaReport>(obj);
                        ent.ProjectId = ProjectId;
                        ent.CreateId = WebPortalService.CurrentUserInfo.UserID;
                        ent.CreateName = WebPortalService.CurrentUserInfo.Name;
                        ent.CreateTime = DateTime.Now;
                        ent.DoCreate();
                        Response.Write("{ShenChaId:'" + ent.Id + "'}");
                        Response.End();
                        break;
                    case "Update":
                        obj = Request["json"];
                        ent = JsonHelper.GetObject<ShenChaReport>(obj);
                        ShenChaReport Oent = ShenChaReport.Find(ent.Id);
                        EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(obj);
                        ent = DataHelper.MergeData<ShenChaReport>(Oent, ent, dic.Keys);
                        ent.DoUpdate();
                        Response.Write("{ShenChaId:'" + ent.Id + "'}");
                        Response.End();
                        break;
                    case "check":
                        DoCheck();
                        break;

                }
            }
        }
        private void DoCheck()
        {
            string code = Request["check"];
            string ProjectId = Request["ProjectId"];
            int ischeck;
            if (!string.IsNullOrEmpty(ProjectId))
            {
                sql = "select * from NCRL_SP..ShenChaReport where ShenChaNo = '" + code.Replace(" ", "") + "' and ProjectId !='" + ProjectId + "' ";
            }
            else
            {
                sql = "select * from NCRL_SP..ShenChaReport where ShenChaNo = '" + code.Replace(" ", "") + "'";
            }
            DataTable dt = DataHelper.QueryDataTable(sql);
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
    }
}