using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SP.Model;

namespace SP.Web.ConsultationManage
{
    public partial class KangZhenBiao_Print : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string projectid = Request["ProjectId"];
            Project pEnt = Project.Find(projectid);
            lbProjectName.InnerHtml = pEnt.ProjectName;
            lbBuildingArea.InnerHtml = pEnt.BuildingArea;
            lbDetailLocation.InnerHtml = pEnt.DetailLocation;
            lbEngineeringLevel.InnerHtml = pEnt.EngineeringLevel;
            lbJianSheUnit.InnerHtml = pEnt.JianSheUnit;
            lbJianSheUnitHead.InnerHtml = pEnt.JianSheUnitHead;
            lbKanChaUnit.InnerHtml = pEnt.KanChaUnit;
            lbKanChaUnitHead.InnerHtml = pEnt.KanChaUnitHead;
            lbKanChaZZLevel.InnerHtml = pEnt.KanChaZZLevel;
            lbKanChaUnitZSNo.InnerHtml = pEnt.KanChaUnitZSNo;
            lbSheJiUnit.InnerHtml = pEnt.SheJiUnit;
            lbSheJiUnitHead.InnerHtml = pEnt.SheJiUnitHead;
            lbSheJiUnitGrade.InnerHtml = pEnt.SheJiUnitGrade;
            lbSheJiUnitZSNo.InnerHtml = pEnt.SheJiUnitZSNo;
            IList<KanChaSheJi> kcsjEnts = KanChaSheJi.FindAllByProperty(KanChaSheJi.Prop_ProjectId, projectid);
            string zhucejiegoushi = "";
            foreach (KanChaSheJi kcsjEnt in kcsjEnts)
            {
                if (kcsjEnt.MajorName == "注册结构师")
                {
                    zhucejiegoushi = kcsjEnt.UserName;
                }
            }
            lbZhuCeJiGouShi.InnerHtml = zhucejiegoushi;
            lbIfChaoGao.InnerHtml = pEnt.IfChaoGao;
            lbKangZhenLieDu.InnerHtml = pEnt.KangZhenLieDu;
            lbProjectType.InnerHtml = pEnt.ProjectType;
            lbLayer.InnerHtml = "地上：" + pEnt.UpperLayers + "  地下：" + pEnt.DownLayers;
            lbFoundationType.InnerHtml = pEnt.FoundationType;

            string property = pEnt.Property;
            if (property == "新建")
            {
                lbXinJian.InnerHtml = "(√)";
            }
            if (property == "改建")
            {
                lbGaiJian.InnerHtml = "(√)";
            }
            if (property == "扩建")
            {
                lbKuoJian.InnerHtml = "(√)";
            }
            lbYear1.InnerHtml = DateTime.Now.Year + "";
            lbMonth1.InnerHtml = DateTime.Now.Month + "";
            lbDay1.InnerHtml = DateTime.Now.Day + "";
        }
    }
}