using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SP.Model;
using Aim;
using Aim.Data;
using System.Data;

namespace SP.Web.ConsultationManage
{
    public partial class ExamineMeetingEdit : System.Web.UI.Page
    {
        ExamineMeeting Ent;
        string sql = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            switch (action)
            {
                case "Create":
                    string obj = Request["data"];
                    string DistributeAmount = Request["DistributeAmount"];
                    Ent = JsonHelper.GetObject<ExamineMeeting>(obj);
                    Ent.DistributeAmount = Convert.ToDecimal(DistributeAmount);
                    Ent.DoCreate();
                    string json = Request["json"];
                    IList<ProjectUser> sk = JsonHelper.GetObject<IList<ProjectUser>>(json);
                    foreach (ProjectUser skEnt in sk)
                    {
                        skEnt.ProjectId = Ent.Id;
                        skEnt.DoCreate();
                    }
                    break;
                case "Update":
                    Update();
                    break;
                case "Load":
                    Load();
                    break;
                case "async":
                    Async();
                    break;

            }
        } 
        private void Update()
        {
            string DistributeAmount = Request["DistributeAmount"];
            Ent = JsonHelper.GetObject<ExamineMeeting>(Request["data"]);
            ExamineMeeting original_Ent = ExamineMeeting.Find(Ent.Id);
            EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(Request["data"]);
            original_Ent = DataHelper.MergeData<ExamineMeeting>(original_Ent, Ent, dic.Keys);
            original_Ent.DistributeAmount = Convert.ToDecimal(DistributeAmount);
            original_Ent.DoUpdate();
            sql = "delete NCRL_SP..projectUser where projectid='" + original_Ent.Id + "'";
            DataHelper.ExecSql(sql);
            string json = Request["json"];
            IList<ProjectUser> sk = JsonHelper.GetObject<IList<ProjectUser>>(json);
            foreach (ProjectUser skEnt in sk)
            {
                skEnt.ProjectId = Ent.Id;
                skEnt.DoCreate();
            }
        }
        private void Load()
        {
            string Id = Request["Id"];
            if (!string.IsNullOrEmpty(Id))
            {
                string data = JsonHelper.GetJsonString(ExamineMeeting.Find(Id));
                string sa = "{success:  true  ,data:" + data + "}";
                Response.Write(sa);
                Response.End();
            }

        }
        private void Async()
        {
            string ProjectId = Request["ProjectId"];
            sql = @"select Id,Position,UserName,DistributeAmount,Unit,UserId,MajorName,DistributePercent from NCRL_SP..projectUser where projectid='" + ProjectId + "' ";
            DataTable dt = DataHelper.QueryDataTable(sql);
            Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
            Response.End();
        }
    }

}