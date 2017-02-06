using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SP.Model;

namespace SP.Web.ConsultationManage
{
    public partial class ShenChaReport_KanCha_Print : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string projectid = Request["ProjectId"];
            Project pEnt = Project.Find(projectid);
            lbKanChaPrjName.InnerHtml = pEnt.KanChaReportPrjName;
            lbJianSheUnit1.InnerHtml = pEnt.JianSheUnit;
            lbKanChaPrjName2.InnerHtml = pEnt.KanChaReportPrjName;
            lbZuanKongJinChi.InnerHtml = pEnt.ZuanKongJinChi;
            lbDetailLocation.InnerHtml = pEnt.DetailLocation;
            lbGongChengGuiMo.InnerHtml = pEnt.GongChengGuiMo;
            lbJianSheUnit.InnerHtml = pEnt.JianSheUnit;
            lbJianSheUnitHead.InnerHtml = pEnt.JianSheUnitHead;
            lbKanChaUnit.InnerHtml = pEnt.KanChaUnit;
            lbKanChaUnitHead.InnerHtml = pEnt.KanChaUnitHead;
            lbKanChaZZLevel.InnerHtml = pEnt.KanChaZZLevel;
            lbKanChaUnitZSNo.InnerHtml = pEnt.KanChaUnitZSNo;
        }
    }
}