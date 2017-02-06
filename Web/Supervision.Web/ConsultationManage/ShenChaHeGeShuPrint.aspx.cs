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
    public partial class ShenChaHeGeShuPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Project pEnt = Project.Find(Request["id"]);
            lbZiXunCode.InnerHtml = pEnt.ZiXunCode;
            lbHeGeShuTime.InnerHtml = DateTime.Now.Year + "年" + DateTime.Now.Month + "月" + DateTime.Now.Day + "日";
            lbProjectName.InnerHtml = pEnt.ProjectName;
            lbProjectAddress.InnerHtml = pEnt.DetailLocation;
            lbProjectType.InnerHtml = pEnt.ProjectType;
            lbEngineeringLevel.InnerHtml = pEnt.EngineeringLevel;
            lbGongChengGuiMo.InnerHtml = pEnt.GongChengGuiMo;
            lbJianSheUnit.InnerHtml = pEnt.JianSheUnit;
            lbKanChaUnit.InnerHtml = pEnt.KanChaUnit;
            lbSheJiUnit.InnerHtml = pEnt.SheJiUnit;

            string sql = @"select a.MajorName,(select top 1 SortIndex from SysEnumeration where ParentId='b640c40c-e2a9-41a8-bd28-d8ff9d71ff94' and Name=a.MajorName) as SortIndex
                         from NCRL_SP..ProjectUser a where a.ProjectId='" + Request["id"] + "' order by SortIndex asc";
            IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
            lt1.Text = "";
            foreach (EasyDictionary dic in dics)
            {
                if (dic.Get<string>("MajorName") != "勘察")
                {
                    lt1.Text += "<tr><td>" + dic.Get<string>("MajorName") + "</td><td></td><td></td></tr>";
                }
            }
            lt1.Text += "<tr><td colspan='3' style='text-align:left'>审查机构法定代表人(签字)</td></tr>";
        }
    }
}