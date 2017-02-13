using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SP.Model;
using Aim;
using System.Data;
using Aim.Data;
using Aim.Portal.Web;

namespace SP.Web.ConsultationManage
{
    public partial class AssignedTasks : System.Web.UI.Page
    {
        Project pEnt = null;
        string sql = "";
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            switch (action)
            {
                case "Load":
                    load();
                    break;
                case "async":
                    Async();
                    break;
                case "create":
                    Create();
                    break;
            }
        }
        private void Create()
        {
            string Id = Request["Id"];
            Project pEnt = Project.Find(Id);
            IList<ProjectUser> puEnts = ProjectUser.FindAllByProperty(ProjectUser.Prop_ProjectId, Id);
            pEnt.Status = "已下达";
            pEnt.DoUpdate();
            foreach (ProjectUser puEnt in puEnts)
            {
                ExamineTask etEnt = new ExamineTask();
                etEnt.ProjectId = Id;
                etEnt.ProjectUserId = puEnt.Id;//str ProjectUser 的主键 
                etEnt.MajorName = puEnt.MajorName;
                etEnt.PlanBackTime = Convert.ToDateTime(Request["BackTime"]);
                etEnt.State = "未结束";
                etEnt.CreateId = WebPortalService.CurrentUserInfo.UserID;
                etEnt.CreateName = WebPortalService.CurrentUserInfo.UserID;
                etEnt.CreateTime = DateTime.Now;
                etEnt.DoCreate();
                Expert eEnt = Expert.Find(puEnt.UserId);
                //发送邮件        
                try
                {
                    //string url = "http://192.168.15.81:7007/ConsultationManage/ExamineOpinionEdit.aspx?ExamineTaskId=" + etEnt.Id;
                    //PhoneMessage.SendWebMail("fpxt@nerin.com", eEnt.Email, "审查任务", "项目名称:【" + pEnt.ProjectName + "】 专业：" + eEnt.MajorName + "，填写审查意见请点击此链接：" + url, "fpxt", "000000", "mail.nerin.com");
                }
                catch (Exception ex)
                {

                }
            }
        }
        private void load()
        {
            string Id = Request["Id"];
            if (!string.IsNullOrEmpty(Id))
            {
                pEnt = Project.Find(Id);
                string data = JsonHelper.GetJsonString(pEnt);
                Response.Write("{success:true,data:" + data + "}");
                Response.End();
            }
        }
        private void Async()
        {
            string Id = Request["Id"];
            sql = @"select a.Id as Id ,a.UserId as UserId ,a.UserName as UserName ,a.MajorName as MajorName ,a.QianZhangName as QianZhangName ,a.ShenHeName as ShenHeName , b.Phone as Phone ,b.Email as Email from NCRL_SP..ProjectUser a 
            left join NCRL_SP..Expert b on a.UserId=b.Id where a.ProjectId='" + Id + "'";
            dt = DataHelper.QueryDataTable(sql);
            Response.Write("{rows:" + JsonHelper.GetJsonString(dt) + "}");
            Response.End();
        }
    }
}