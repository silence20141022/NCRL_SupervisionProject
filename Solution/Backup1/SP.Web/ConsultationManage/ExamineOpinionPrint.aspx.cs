using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SP.Model;

namespace SP.Web.ConsultationManage
{
    public partial class ExamineOpinionPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string id = Request["id"];
            ExamineOpinion eoEnt = ExamineOpinion.Find(id);
            lbStage.InnerHtml = "(" + eoEnt.Stage + ")";
            lbStartYear.InnerHtml = eoEnt.StartTime.Value.Year + "";
            lbStartMonth.InnerHtml = eoEnt.StartTime.Value.Month + "";
            lbStartDay.InnerHtml = eoEnt.StartTime.Value.Day + "";
            ExamineTask etEnt = ExamineTask.Find(eoEnt.ExamineTaskId);
            Project pEnt = Project.Find(etEnt.ProjectId);
            lbZiXunCode.InnerHtml = pEnt.ZiXunCode;
            lbMajorName.InnerHtml = etEnt.MajorName;
            string ZhuCeUsers = "";
            string SheJiUsers = "";
            IList<KanChaSheJi> kcsjEnts = KanChaSheJi.FindAllByProperties(KanChaSheJi.Prop_ProjectId, pEnt.Id, KanChaSheJi.Prop_MajorName, etEnt.MajorName);
            foreach (KanChaSheJi kcsjEnt in kcsjEnts)
            {
                if (!string.IsNullOrEmpty(kcsjEnt.SealNo))
                {
                    ZhuCeUsers += (string.IsNullOrEmpty(ZhuCeUsers) ? "" : ",") + kcsjEnt.UserName;
                }
                else
                {
                    SheJiUsers += (string.IsNullOrEmpty(SheJiUsers) ? "" : ",") + kcsjEnt.UserName;
                }
            }
            lbZhuCeUsers.InnerHtml = ZhuCeUsers;
            lbSheJiUsers.InnerHtml = SheJiUsers;
            lbProjectName.InnerHtml = pEnt.ProjectName;
            lbExamineOpinions.InnerHtml = eoEnt.ExamineOpinions;
            lbQiangTiao.InnerHtml = eoEnt.QiangTiao + "";
            lbJiangZhuSheJi.InnerHtml = eoEnt.JiangZhuSheJi + "";
            lbFangHuo.InnerHtml = eoEnt.FangHuo + "";
            lbSheBei.InnerHtml = eoEnt.SheBei + "";
            lbJiChu.InnerHtml = eoEnt.JiChu + "";
            lbJiGouSheJi.InnerHtml = eoEnt.JiGouSheJi + "";
            lbKangZhenSheJi.InnerHtml = eoEnt.KangZhenSheJi + "";
            lbJiaGu.InnerHtml = eoEnt.JiaGu + "";
            lbShenChaUserName.InnerHtml = eoEnt.ShenChaUserName;
            lbFuHeUserName.InnerHtml = eoEnt.FuHeUserName;
            lbEndTime.InnerHtml = eoEnt.EndTime.Value.Year + "年" + eoEnt.EndTime.Value.Month + "月" + eoEnt.EndTime.Value.Day + "日";
        }
    }
}