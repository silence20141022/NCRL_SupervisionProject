using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SP.Model;
using System.Data;
using Aim.Data;
using Aim;
using Newtonsoft.Json.Linq;
using Aim.Portal.Model;
using Aspose.Words;
using System.Reflection;
using System.Configuration;

namespace SP.Web.ConsultationManage
{
    public partial class ExamineOpinionView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            string ExamineTaskId = Request["ExamineTaskId"];
            string id = Request["id"];
            string sql = "";
            DataTable dt = null;
            ExamineTask eEnt = null;
            ExamineOpinion eoEnt = null;
            Project pEnt = null;
            JObject jo = null;
            string ZhuCeUsers = "";
            string SheJiUsers = "";
            ProjectUser puEnt = null;
            IList<KanChaSheJi> kEnts = null;
            string templatepath = ConfigurationManager.AppSettings["TemplatePath"].ToString();
            switch (action)
            {
                case "loadtimes":
                    IList<ExamineOpinion> eoEnts = ExamineOpinion.FindAllByProperty(ExamineOpinion.Prop_CreateTime, ExamineOpinion.Prop_ExamineTaskId, ExamineTaskId);
                    sql = "select Id,Stage from NCRL_SP..ExamineOpinion where ExamineTaskId='" + ExamineTaskId + "' order by CreateTime asc";
                    dt = DataHelper.QueryDataTable(sql);
                    jo = new JObject();
                    eEnt = ExamineTask.Find(ExamineTaskId);//审查任务
                    pEnt = Project.Find(eEnt.ProjectId);//项目
                    puEnt = ProjectUser.Find(eEnt.ProjectUserId);//项目人员 
                    kEnts = KanChaSheJi.FindAllByProperties(KanChaSheJi.Prop_ProjectId, pEnt.Id, KanChaSheJi.Prop_MajorName, eEnt.MajorName);//勘察设计人员
                    foreach (KanChaSheJi kEnt in kEnts)
                    {
                        if (!string.IsNullOrEmpty(kEnt.SealNo))
                        {
                            ZhuCeUsers += kEnt.UserName;
                        }
                        else
                        {
                            SheJiUsers += kEnt.UserName;
                        }
                    }
                    jo.Add("ExamineTaskId", ExamineTaskId);
                    jo.Add("ZiXunCode", pEnt.ZiXunCode);
                    jo.Add("ProjectName", pEnt.ProjectName);
                    jo.Add("ZhuCeUsers", ZhuCeUsers);
                    jo.Add("SheJiUsers", SheJiUsers);
                    jo.Add("MajorName", eEnt.MajorName);
                    jo.Add("ShenChaUserId", eEnt.ProjectUserId);
                    jo.Add("ShenChaUserName", puEnt.UserName);
                    jo.Add("FuHeUserId", puEnt.ShenHeId);
                    jo.Add("FuHeUserName", puEnt.ShenHeName);
                    jo.Add("ShenChaOrganization", "江西瑞林工程咨询有限公司");

                    jo.Add("Id", eoEnts[0].Id);
                    jo.Add("Stage", eoEnts[0].Stage);
                    jo.Add("StartTime", eoEnts[0].StartTime.Value.ToString("yyyy-MM-dd"));
                    jo.Add("EndTime", eoEnts[0].EndTime.Value.ToString("yyyy-MM-dd"));
                    jo.Add("JiangZhuSheJi", eoEnts[0].JiangZhuSheJi);
                    jo.Add("FangHuo", eoEnts[0].FangHuo);
                    jo.Add("SheBei", eoEnts[0].SheBei);
                    jo.Add("JiGouSheJi", eoEnts[0].JiGouSheJi);
                    jo.Add("KangZhenSheJi", eoEnts[0].KangZhenSheJi);
                    jo.Add("JiaGu", eoEnts[0].JiaGu);
                    jo.Add("QiangTiao", eoEnts[0].QiangTiao);
                    jo.Add("ExamineOpinions", eoEnts[0].ExamineOpinions);
                    Response.Write("{success:true,formdata:" + JsonHelper.GetJsonString(jo) + ",rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "loadopinion":
                    eoEnt = ExamineOpinion.Find(id);
                    jo = new JObject();
                    eEnt = ExamineTask.Find(eoEnt.ExamineTaskId);//审查任务
                    pEnt = Project.Find(eEnt.ProjectId);//项目
                    puEnt = ProjectUser.Find(eEnt.ProjectUserId);//项目人员 
                    kEnts = KanChaSheJi.FindAllByProperties(KanChaSheJi.Prop_ProjectId, pEnt.Id, KanChaSheJi.Prop_MajorName, eEnt.MajorName);//勘察设计人员
                    foreach (KanChaSheJi kEnt in kEnts)
                    {
                        if (!string.IsNullOrEmpty(kEnt.SealNo))
                        {
                            ZhuCeUsers += kEnt.UserName;
                        }
                        else
                        {
                            SheJiUsers += kEnt.UserName;
                        }
                    }
                    jo.Add("ExamineTaskId", eEnt.Id);
                    jo.Add("ZiXunCode", pEnt.ZiXunCode);
                    jo.Add("ProjectName", pEnt.ProjectName);
                    jo.Add("ZhuCeUsers", ZhuCeUsers);
                    jo.Add("SheJiUsers", SheJiUsers);
                    jo.Add("MajorName", eEnt.MajorName);
                    jo.Add("ShenChaUserId", eEnt.ProjectUserId);
                    jo.Add("ShenChaUserName", puEnt.UserName);
                    jo.Add("FuHeUserId", puEnt.ShenHeId);
                    jo.Add("FuHeUserName", puEnt.ShenHeName);
                    jo.Add("ShenChaOrganization", "江西瑞林工程咨询有限公司");

                    jo.Add("Id", eoEnt.Id);
                    jo.Add("Stage", eoEnt.Stage);
                    jo.Add("StartTime", eoEnt.StartTime.Value.ToString("yyyy-MM-dd"));
                    jo.Add("EndTime", eoEnt.EndTime.Value.ToString("yyyy-MM-dd"));
                    jo.Add("JiangZhuSheJi", eoEnt.JiangZhuSheJi);
                    jo.Add("FangHuo", eoEnt.FangHuo);
                    jo.Add("SheBei", eoEnt.SheBei);
                    jo.Add("JiGouSheJi", eoEnt.JiGouSheJi);
                    jo.Add("KangZhenSheJi", eoEnt.KangZhenSheJi);
                    jo.Add("JiaGu", eoEnt.JiaGu);
                    jo.Add("QiangTiao", eoEnt.QiangTiao);
                    jo.Add("ExamineOpinions", eoEnt.ExamineOpinions);
                    Response.Write("{success:true,formdata:" + JsonHelper.GetJsonString(jo) + "}");
                    Response.End();
                    break;
                case "saveopinion":
                    ExamineOpinion oriEnt = ExamineOpinion.Find(id);
                    eoEnt = JsonHelper.GetObject<ExamineOpinion>(Request["formdata"]);
                    EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(Request["formdata"]);
                    oriEnt = DataHelper.MergeData<ExamineOpinion>(oriEnt, eoEnt, dic.Keys);
                    oriEnt.DoUpdate();
                    Response.Write("{success:true}");
                    Response.End();
                    break;
                case "export_shenchajilu":
                    try
                    {
                        eoEnt = ExamineOpinion.Find(id);
                        eEnt = ExamineTask.Find(eoEnt.ExamineTaskId);
                        pEnt = Project.Find(eEnt.ProjectId);
                        Document srcDoc = new Document(templatepath + "审查记录表.doc");
                        BookmarkCollection marks = srcDoc.Range.Bookmarks;
                        for (int j = 0; j < marks.Count; j++)
                        {
                            if (ContainProperty(eoEnt, marks[j].Name))
                            {
                                marks[j].Text = eoEnt.GetValue(marks[j].Name) + "";
                            }
                        }
                        if (marks["StartYear"] != null)
                        {
                            marks["StartYear"].Text = eoEnt.StartTime.Value.Year + "";
                        }
                        if (marks["StartMonth"] != null)
                        {
                            marks["StartMonth"].Text = eoEnt.StartTime.Value.Month + "";
                        }
                        if (marks["StartDay"] != null)
                        {
                            marks["StartDay"].Text = eoEnt.StartTime.Value.Day + "";
                        }
                        if (marks["EndYear"] != null)
                        {
                            marks["EndYear"].Text = eoEnt.EndTime.Value.Year + "";
                        }
                        if (marks["EndMonth"] != null)
                        {
                            marks["EndMonth"].Text = eoEnt.EndTime.Value.Month + "";
                        }
                        if (marks["EndDay"] != null)
                        {
                            marks["EndDay"].Text = eoEnt.EndTime.Value.Day + "";
                        }
                        kEnts = KanChaSheJi.FindAllByProperties(KanChaSheJi.Prop_ProjectId, pEnt.Id, KanChaSheJi.Prop_MajorName, eEnt.MajorName);//勘察设计人员
                        foreach (KanChaSheJi kEnt in kEnts)
                        {
                            if (!string.IsNullOrEmpty(kEnt.SealNo))
                            {
                                ZhuCeUsers += kEnt.UserName;
                            }
                            else
                            {
                                SheJiUsers += kEnt.UserName;
                            }
                        }
                        if (marks["MajorName"] != null)
                        {
                            marks["MajorName"].Text = eEnt.MajorName;
                        }
                        if (marks["ZhuCeName"] != null)
                        {
                            marks["ZhuCeName"].Text = ZhuCeUsers;
                        }
                        if (marks["SheJiName"] != null)
                        {
                            marks["SheJiName"].Text = SheJiUsers;
                        }
                        if (marks["ZiXunCode"] != null)
                        {
                            marks["ZiXunCode"].Text = pEnt.ZiXunCode;
                        }
                        if (marks["ProjectName"] != null)
                        {
                            marks["ProjectName"].Text = pEnt.ProjectName;
                        }
                        string filename = pEnt.ProjectName.Replace("#","") + "_审查记录表_" + eEnt.MajorName + "_" + eoEnt.Stage + ".doc";
                        srcDoc.Save(@"D:\RW\Files\AppFiles\Portal\Default\" + filename);
                        UpdateFileItem(pEnt, filename);
                        Response.Write("{success:true}");
                        Response.End();
                    }
                    catch
                    {
                        Response.Write("{success:false}");
                        Response.End();
                    }
                    break;
                case "delete":
                    string ExamineOpinionId = Request["ExamineOpinionId"];
                    sql = " delete from NCRL_SP..ExamineOpinion where ID='" + ExamineOpinionId + "'";
                    DataHelper.ExecSql(sql);
                    int ExamineOpinionCount = ExamineOpinion.FindAll().Where(S => S.ExamineTaskId == ExamineTaskId).Count();
                    Response.Write("{success:true,ExamineOpinionCount:" + ExamineOpinionCount + "}");
                    Response.End();
                    break;


            }
        }
        private bool ContainProperty(ExamineOpinion eoEnt, string propertyName)
        {
            if (eoEnt != null && !string.IsNullOrEmpty(propertyName))
            {
                PropertyInfo _findedPropertyInfo = eoEnt.GetType().GetProperty(propertyName);
                return (_findedPropertyInfo != null);
            }
            return false;
        }
        private void UpdateFileItem(Project pEnt, string filename)
        {
            IList<FileItem> fiEnts = FileItem.FindAllByProperties(FileItem.Prop_ProjectId, pEnt.Id, FileItem.Prop_Path, "导出", FileItem.Prop_Name, filename);
            if (fiEnts.Count == 0)
            {
                FileItem fiEnt = new FileItem();
                fiEnt.ProjectId = pEnt.Id;
                fiEnt.Name = filename;
                fiEnt.FolderId = "1";
                fiEnt.CreateTime = DateTime.Now;
                fiEnt.Path = "导出";
                fiEnt.DoCreate();
            }
            else
            {
                fiEnts[0].CreateTime = DateTime.Now;
                fiEnts[0].DoUpdate();
            }
        }
    }
}