using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Aim.Data;
using Aim;
using SP.Model;

namespace SP.Web.ConsultationManage
{
    public partial class HuiZongBiaoPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string sql = "";
            DataTable dt;
            IList<EasyDictionary> ETList;
            string ProjectId = Request["ProjectId"];
            if (!string.IsNullOrEmpty(ProjectId))
            {
                string MajorName = "";
                string UserName = "";
                string Qiangtiao = "";
                string ExamineOpinion = "";
                string ischeck = "否";
                int total = 0;
                sql = @"select P.MajorName as MajorName,P.Username as UserName,P.Id as Id
                from NCRL_SP..ProjectUser P 
                where P.ProjectId='" + ProjectId + "'  ";
                IList<EasyDictionary> data = DataHelper.QueryDictList(sql);
                if (data.Count > 0)
                {
                    for (int i = 0; i < data.Count; i++)
                    {
                        int count = 0;
                        MajorName += "<td>" + data[i].Get<string>("MajorName") + "</td>";
                        UserName += "<td>" + data[i].Get<string>("UserName") + "</td>";
                        sql = @"select JiangZhuSheJi,FangHuo,SheBei,JiGouSheJi,KangZhenSheJi,JiaGu,JiChu,Stage,ExamineOpinions from NCRL_SP..ExamineOpinion where ExamineTaskId in 
                    (select Id from NCRL_SP..ExamineTask where  ProjectId='" + ProjectId + "' and  ProjectUserId='" + data[i].Get<string>("Id") + "')";
                        ETList = DataHelper.QueryDictList(sql);
                        for (int j = 0; j < ETList.Count; j++)
                        {

                            if (!string.IsNullOrEmpty(ETList[j].Get<string>("JiangZhuSheJi")))
                            {
                                count += Convert.ToInt32(ETList[j].Get<string>("JiangZhuSheJi"));
                            }

                            if (!string.IsNullOrEmpty(ETList[j].Get<string>("FangHuo")))
                            {
                                count += Convert.ToInt32(ETList[j].Get<string>("FangHuo"));
                            }

                            if (!string.IsNullOrEmpty(ETList[j].Get<string>("SheBei")))
                            {
                                count += Convert.ToInt32(ETList[j].Get<string>("SheBei"));
                            }

                            if (!string.IsNullOrEmpty(ETList[j].Get<string>("JiGouSheJi")))
                            {
                                count += Convert.ToInt32(ETList[j].Get<string>("JiGouSheJi"));
                            }

                            if (!string.IsNullOrEmpty(ETList[j].Get<string>("KangZhenSheJi")))
                            {
                                count += Convert.ToInt32(ETList[j].Get<string>("KangZhenSheJi"));
                            }

                            if (!string.IsNullOrEmpty(ETList[j].Get<string>("JiaGu")))
                            {
                                count += Convert.ToInt32(ETList[j].Get<string>("JiaGu"));
                            }

                            if (!string.IsNullOrEmpty(ETList[j].Get<string>("JiChu")))
                            {
                                count += Convert.ToInt32(ETList[j].Get<string>("JiChu"));
                            }
                            if (!string.IsNullOrEmpty(ETList[j].Get<string>("Stage")) && ETList[j].Get<string>("Stage").Equals("初审"))
                            {
                                if (string.IsNullOrEmpty(ETList[j].Get<string>("ExamineOpinions")))
                                {
                                    ischeck = "是";
                                }
                                else
                                {
                                    ischeck = "否";
                                }
                            }

                        }

                        Qiangtiao += "<td>" + count + "</td>";
                        ExamineOpinion += "<td>" + ischeck + "</td>";
                        total += count;
                    }
                }
                else
                {

                    MajorName += "<td>无数据</td>";
                    UserName += "<td>无数据</td>";
                    Qiangtiao += "<td>0</td>";
                    ExamineOpinion += "<td>无数据</td>";
                }
                majorName.Text = MajorName;
                userName.Text = UserName;
                userName1.Text = UserName;
                qiangTiao.Text = Qiangtiao;
                EO.Text = ExamineOpinion;
                Total.InnerHtml = total.ToString();
                //项目信息
                Project PEnt = Project.Find(ProjectId);
                ProjectName.InnerHtml = PEnt.ProjectName;
                JianSheUnit.InnerHtml = PEnt.JianSheUnit;
                KanChaUnit.InnerHtml = PEnt.KanChaUnit;
                KanChaZZLevelAndCode.InnerHtml = PEnt.KanChaGCLevel + "&nbsp;&nbsp;" + PEnt.KanChaUnitZSNo;
                ProjectType.InnerHtml = PEnt.ProjectType;
                EngineeringLevel.InnerHtml = PEnt.EngineeringLevel;
                Investment.InnerHtml = PEnt.Investment + "万元";
                BuildingArea.InnerHtml = PEnt.BuildingArea + "(㎡)";
                if (!string.IsNullOrEmpty(PEnt.UpperLayers))
                {
                    CengShu.InnerHtml += Convert.ToInt32(PEnt.UpperLayers).ToString();
                } if (!string.IsNullOrEmpty(PEnt.DownLayers))
                {
                    CengShu.InnerHtml += Convert.ToInt32(PEnt.DownLayers).ToString();
                }
                Height.InnerHtml = PEnt.Height;
                year.InnerHtml = DateTime.Now.ToString("yyyy");
                month.InnerHtml = DateTime.Now.ToString("MM");
                day.InnerHtml = DateTime.Now.ToString("dd");
                if (PEnt.ProjectType.Equals("勘察"))
                {
                    title.InnerHtml = "工程勘察";
                }
                else
                {
                    title.InnerHtml = PEnt.ProjectType;
                }
            }
        }
    }
}