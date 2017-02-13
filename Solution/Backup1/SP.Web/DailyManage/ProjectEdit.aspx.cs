using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim;
using SP.Model;
using Aim.Data;

namespace SP.Web.DailyManage
{
    public partial class ProjectEdit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "LoadFormData":
                        SetPage();
                        break;
                    case "Update":
                        string formdata = Request["formdata"];
                        EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(formdata);
                        Project originalEnt = Project.Find(dic.Get<string>("Id"));
                        originalEnt = DataHelper.MergeData<Project>(originalEnt, JsonHelper.GetObject<Project>(formdata), dic.Keys);
                        originalEnt.DoUpdate();
                        Response.Write("{success:true}");
                        Response.End();
                        break;
                }
            }
        }
        private void SetPage()
        {
            string Id = Request["Id"];
            if (!string.IsNullOrEmpty(Id))
            {
                string data = JsonHelper.GetJsonString(Project.Find(Id));
                string sa = "{success:  true  ,data:" + data + "}";
                Response.Write(sa);
                Response.End();
            }
        }
    }
}