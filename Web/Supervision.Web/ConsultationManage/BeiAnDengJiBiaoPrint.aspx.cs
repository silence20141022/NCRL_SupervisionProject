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
    public partial class BeiAnDengJiBiaoPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string projectid = Request["ProjectId"];
            Project pEnt = Project.Find(projectid);
            lbProjectName.InnerHtml = pEnt.ProjectName;
            lbShenChaJiGou.InnerHtml = "江西瑞林工程咨询有限公司";

            lbGongChengName.InnerHtml = pEnt.ProjectName;
            lbDetailLocation.InnerHtml = pEnt.DetailLocation;
            lbJianSheUnit.InnerHtml = pEnt.JianSheUnit;
            lbBuildingArea.InnerHtml = pEnt.BuildingArea;
            lbInvestment.InnerHtml = pEnt.Investment + "";
            lbHeight.InnerHtml = pEnt.Height;
            lbLayer.InnerHtml = "地上层数:" + pEnt.UpperLayers + (string.IsNullOrEmpty(pEnt.DownLayers) ? "" : "地下层数:" + pEnt.DownLayers);
            lbStructureType.InnerHtml = pEnt.StructureType;
            lbFoundationType.InnerHtml = pEnt.FoundationType;
            lbKanChaGCLevel.InnerHtml = pEnt.KanChaGCLevel;
            //pEnt.EngineeringLevel
            lbJianZhuLeiXing.InnerHtml = pEnt.GongChengLeiXing;

            lbKanChaUnit.InnerHtml = pEnt.KanChaUnit;
            lbKanChaUnitHead.InnerHtml = pEnt.KanChaUnitHead;
            lbKanChaZZLevel.InnerHtml = pEnt.KanChaZZLevel;
            lbKanChaUnitZSNo.InnerHtml = pEnt.KanChaUnitZSNo;
            lbKanChaIfBeiAn.InnerHtml = "否";
            if (!string.IsNullOrEmpty(pEnt.KanChaUnitBeiAnNo))
            {
                lbKanChaIfBeiAn.InnerHtml = "是";
            }
            lbKanChaUnitBeiAnNo.InnerHtml = pEnt.KanChaUnitBeiAnNo;

            lbSheJiUnit.InnerHtml = pEnt.SheJiUnit;
            lbSheJiUnitHead.InnerHtml = pEnt.SheJiUnitHead;
            lbSheJiUnitGrade.InnerHtml = pEnt.SheJiUnitGrade;
            lbSheJiUnitZSNo.InnerHtml = pEnt.SheJiUnitZSNo;
            lbSheJiIfBeiAn.InnerHtml = "否";
            if (!string.IsNullOrEmpty(pEnt.SheJiUnitBeiAnNo))
            {
                lbSheJiIfBeiAn.InnerHtml = "是";
            }
            lbSheJiUnitBeiAnNo.InnerHtml = pEnt.SheJiUnitBeiAnNo;
            literalSheJiUsers.Text = "";
            IList<KanChaSheJi> kcsjEnts = KanChaSheJi.FindAllByProperty(KanChaSheJi.Prop_ProjectId, projectid);
            literalSheJiUsers.Text += "<tr><td rowspan='" + kcsjEnts.Count + 1 + "' style='width:40px'>项</br>目</br>设</br>计</br>人</br>员</br>情</br>况</td><td style='width:150px'>专业</td><td  style='width:190px'>姓名</td><td  style='width:130px'>执业印章号码</td><td>身份证号码(外省单位)</td></tr>";
            foreach (KanChaSheJi kcsjEnt in kcsjEnts)
            {
                if (kcsjEnt.Position == "注册土木工程师(岩土)")
                {
                    lbKanChaUserName.InnerHtml = kcsjEnt.UserName;
                    lbKanChaYinZhangHao.InnerHtml = kcsjEnt.SealNo;
                    lbKanChaShenFenZheng.InnerHtml = kcsjEnt.ShenFenZhengNo;
                }
                else
                {
                    literalSheJiUsers.Text += "<tr><td>" + kcsjEnt.MajorName + "</td><td>" + kcsjEnt.UserName + "</td><td>" + kcsjEnt.SealNo + "</td><td>" + kcsjEnt.ShenFenZhengNo + "</td></tr>";
                }
            }
            string sql = @"select count(QiangTiao) from NCRL_SP..ExamineOpinion where ExamineTaskId in 
                         (select Id from NCRL_SP..ExamineTask where ProjectId='" + projectid + "')";
            lbIfYiCiPass.InnerHtml = "是";
            if (DataHelper.QueryValue<int>(sql) > 0)
            {
                lbIfYiCiPass.InnerHtml = "否";
            }
            sql = @"select a.*,b.StampNo ShenChaYinZhangHao,c.StampNo as ShenHeYinZhangHao,
                  (select top 1 SortIndex from NCRL_Portal..SysEnumeration where ParentId='b640c40c-e2a9-41a8-bd28-d8ff9d71ff94' and Name=a.MajorName) as SortIndex from NCRL_SP..ProjectUser a
                  left join NCRL_SP..Expert b  on a.QianZhangId=b.Id
                  left join NCRL_SP..Expert c on a.ShenHeId=c.Id where a.ProjectId='" + projectid + "' order by SortIndex asc ";
            literal_shencha.Text = "";
            IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
            literal_shencha.Text += "<tr><td rowspan='" + (dics.Count + 1) + "' style='width:40px'>项<br />目<br />审<br />查<br />人<br />员<br />情<br />况</td><td style='width:95px'>专业</td><td  style='width:110px'>审查人员姓名</td><td  style='width:110px'>审查印章号码</td><td style='width:60px'>签名</td><td  style='width:110px'>复核人员姓名</td><td style='width:110px'>审查印章号码</td><td style='width:60px'>签名</td></tr>";
            foreach (EasyDictionary dic in dics)
            {
                if (dic.Get<string>("MajorName") != "勘察")
                {
                    literal_shencha.Text += "<tr><td>" + dic.Get<string>("MajorName") + "</td><td>" + dic.Get<string>("QianZhangName") + "</td><td>" + dic.Get<string>("ShenChaYinZhangHao") + "</td><td></td><td>" + dic.Get<string>("ShenHeName") + "</td><td>" + dic.Get<string>("ShenHeYinZhangHao") + "</td><td></td></tr>";
                }
            }
            IList<ShenChaReport> scrEnts = ShenChaReport.FindAllByProperty(ShenChaReport.Prop_ProjectId, projectid);
            if (scrEnts.Count > 0)
            {
                lbJingBanYiJian.InnerHtml = scrEnts[0].Opinion7;
            }
        }
    }
}