using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SP.Model;
using Aim;
using Aim.Portal.Web;
using Newtonsoft.Json.Linq;
using Aim.Portal.Model;

namespace SP.Web.ConsultationManage
{
    public partial class ExamineOpinionEdit : System.Web.UI.Page
    {
        ExamineTask eEnt = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            switch (action)
            {
                case "load":
                    IniPage();
                    break;
                case "create":
                    ExamineOpinion ent = JsonHelper.GetObject<ExamineOpinion>(Request["json"]);
                    ent.CreateTime = DateTime.Now;
                    ent.DoCreate();
                    break;
            }
        }
        private void IniPage()
        {
            JObject jo = new JObject();
            string ZhuCeUsers = "";
            string SheJiUsers = "";
            string ExamineTaskId = Request["ExamineTaskId"];
            eEnt = ExamineTask.Find(ExamineTaskId);//审查任务
            Project pEnt = Project.Find(eEnt.ProjectId);//项目
            ProjectUser puEnt = ProjectUser.Find(eEnt.ProjectUserId);//项目人员
            IList<ExamineOpinion> eoEnts = ExamineOpinion.FindAllByProperty(ExamineOpinion.Prop_ExamineTaskId, ExamineTaskId);//看意见有几条
            IList<KanChaSheJi> kEnts = KanChaSheJi.FindAllByProperties(KanChaSheJi.Prop_ProjectId, pEnt.Id, KanChaSheJi.Prop_MajorName, eEnt.MajorName);//勘察设计人员
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
            IList<SysEnumeration> seEnts = SysEnumeration.FindAllByProperty("SortIndex", SysEnumeration.Prop_ParentID, "b640c40c-e2a9-41a8-bd28-d8ff9d71ff70");
            jo.Add("ExamineTaskId", ExamineTaskId);
            jo.Add("ZiXunCode", pEnt.ZiXunCode);
            jo.Add("ProjectName", pEnt.ProjectName);
            jo.Add("ZhuCeUsers", ZhuCeUsers);
            jo.Add("SheJiUsers", SheJiUsers);
            jo.Add("Stage", seEnts[eoEnts.Count].Name);
            jo.Add("MajorName", eEnt.MajorName);
            jo.Add("ShenChaUserId", eEnt.ProjectUserId);
            jo.Add("ShenChaUserName", puEnt.UserName);
            jo.Add("FuHeUserId", puEnt.ShenHeId);
            jo.Add("FuHeUserName", puEnt.ShenHeName);
            jo.Add("ShenChaOrganization", "江西瑞林工程咨询有限公司");
            if (seEnts[eoEnts.Count].Name == "初审")
            {
                string StartTime = eEnt.CreateTime.ToString().Replace("}", "").Replace("{", "");
                jo.Add("StartTime", StartTime);
            }
            string str = JsonHelper.GetJsonString(jo);
            Response.Write("{success:true,data:" + str + " }");
            Response.End();
        }
    }
}