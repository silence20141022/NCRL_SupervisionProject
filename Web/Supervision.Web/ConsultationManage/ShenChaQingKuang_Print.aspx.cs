using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SP.Model;

namespace SP.Web.ConsultationManage
{
    public partial class ShenChaQingKuang_Print : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string projectid = Request["ProjectId"];
            Project pEnt = Project.Find(projectid);
            lbYear.InnerHtml = DateTime.Now.Year + "";
            lbMonth.InnerHtml = DateTime.Now.Month + "";
            lbProjectName.InnerHtml = pEnt.ProjectName;
        }
    }
}