using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SP.Model;
using System.Data;
using Aim.Data;

namespace SP.Web.ConsultationManage
{
    public partial class ZhongShenOpinionPrint : System.Web.UI.Page
    {
        Project PEnt = null;
        string sql = "";
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            string Id = Request["Id"];
            if (!string.IsNullOrEmpty(Id))
            {
                PEnt = Project.Find(Id);
                sql = @"select PU.MajorName as MajorName , PU.QianZhangName as QianZhangName ,PU.ShenHeName as ShenHeName from NCRL_SP..ProjectUser PU left join NCRL_Portal..SysEnumeration E ON PU.MajorName = E.Name 
                        where PU.ProjectId='" + Id + "' and E.ParentID = 'b640c40c-e2a9-41a8-bd28-d8ff9d71ff94' order by E.sortindex asc";
                dt = DataHelper.QueryDataTable(sql);
                string MajorName = "";
                string QianZhangName = "";
                string ShengHeName = "";
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (i != dt.Rows.Count - 1)
                    {
                        MajorName += dt.Rows[i].ItemArray[0].ToString().Trim() + "、";
                        QianZhangName += dt.Rows[i].ItemArray[1].ToString().Trim() + "、";
                        ShengHeName += dt.Rows[i].ItemArray[2].ToString().Trim() + "、";
                    }
                    else
                    {
                        MajorName += dt.Rows[i].ItemArray[0].ToString().Trim();
                        QianZhangName += dt.Rows[i].ItemArray[1].ToString().Trim();
                        ShengHeName += dt.Rows[i].ItemArray[2].ToString().Trim();
                    }
                }
                lbZiXunCode.InnerHtml = PEnt.ZiXunCode;
                ProjectName.InnerHtml = PEnt.ProjectName;
                JianSheUnit.InnerHtml = PEnt.JianSheUnit;
                KanChaUnit.InnerHtml = PEnt.KanChaUnit;
                SheJiUnit.InnerHtml = PEnt.SheJiUnit;
              //  ZhongShenOpinion.InnerHtml = PEnt.ZhongShenOpinion;
                QianZhangName_h.InnerHtml = QianZhangName;
                ShengHeName_h.InnerHtml = ShengHeName;
                MajorName_h.InnerHtml = MajorName;
                year.InnerHtml = DateTime.Now.ToString("yyyy");
                month.InnerHtml= DateTime.Now.ToString("MM") ;
                day.InnerHtml = DateTime.Now.ToString("dd");

            }
        }
    }
}