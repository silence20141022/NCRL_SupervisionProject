using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;

using Aim;
using SP.Model;
using System.Data;

namespace SP.Web.ConsultationManage
{
    public partial class ProjectContractEdit : IMListPage
    {
      
        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型
        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            type = RequestData.Get<string>("type");
            IList<string> projectUser = RequestData.GetList<string>("projectUser");
           
            Project ent = null;
            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<Project>();
                    ent.Status = "已提交";
                    ent.DoUpdate();
                    ///专家
                    ProjectUser.DeleteAll("ProjectId='" + ent.Id + "'");
        

                    ProjectUserDetail(projectUser, ent);

                    this.SetMessage("修改成功！");
                    break;
                case RequestActionEnum.Insert:
                case RequestActionEnum.Create:
                    ent = this.GetPostedData<Project>();
                    ent.DoCreate();
                  
                    this.SetMessage("新建成功！");
                    break;
                case RequestActionEnum.Delete:
                    ent = this.GetTargetData<Project>();
                    ent.DoDelete();
                 
                    break;
                default:
                    DoSelect();
                    break;
            }

            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = Project.Find(id);

                }
                this.SetFormData(ent);

            }
        }
        public void DoSelect()
        {
           // IList<EasyDictionary> dics = null;
            string tempsql = string.Empty;

            DataTable dt = DataHelper.QueryDataTable("select pro.*,s.name from  NCRL_SP..Project pro left join SysEnumeration s on s.Code=pro.ProjectType   where pro.Id='" + id + "'");
            this.PageState.Add("pro", dt);
            ///查询子信息
            if (!String.IsNullOrEmpty(id))
            {
                //审查人员表
          

                ProjectUser[] dics= ProjectUser.FindAllByProperty("ProjectId", id);
          
                PageState.Add("DetailChildList", dics);
            }
        } 
        private void ProjectUserDetail(IList<string> entProjectUser, Project poEnt)
        {
            if (entProjectUser != null && entProjectUser.Count > 0)
            {
                for (int j = 0; j < entProjectUser.Count; j++)
                {
                    Newtonsoft.Json.Linq.JObject objL = JsonHelper.GetObject<Newtonsoft.Json.Linq.JObject>(entProjectUser[j]);
                    ProjectUser podEnt = new ProjectUser();
                    podEnt.BelongDeptId = string.Empty;// System.Guid.NewGuid().ToString();
                    podEnt.BelongDeptName = string.Empty;//System.Guid.NewGuid().ToString();
                    podEnt.MajorCode = string.Empty;
                    podEnt.MajorName = objL.Value<string>("MajorName");
                    podEnt.ProjectId = poEnt.Id;
                    podEnt.ShenHeId = string.Empty;
                    podEnt.UserId = objL.Value<string>("UserId");
                    podEnt.UserName = objL.Value<string>("UserName");
                    podEnt.ShenHeName = objL.Value<string>("ShenHeUserName");
                    podEnt.DistributeAmount = objL.Value<decimal>("DistributeAmount");
                    podEnt.DistributePercent = objL.Value<decimal>("DistributePercent");
                    podEnt.AcctualAmount = objL.Value<decimal>("AcctualAmount");
                    podEnt.DoCreate();
                }
            }
        } 
    }
}