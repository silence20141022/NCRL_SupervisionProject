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
using SP.Model;
using Aim;
using System.Data;
using System.Drawing;
using Newtonsoft.Json.Linq;

namespace SP.Web
{
    public partial class OpinionCoverPrint : IMListPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string projectid = RequestData.Get<string>("projectid");
            JObject jo = new JObject();
            Project pEnt = Project.Find(projectid);
            jo.Add("ZiXunCode", pEnt.ZiXunCode);
            jo.Add("JianSheUnit", pEnt.JianSheUnit);
            jo.Add("DetailLocation", pEnt.DetailLocation);
            jo.Add("ProjectName", pEnt.ProjectName);
            jo.Add("SheJiUnit", pEnt.SheJiUnit);
            jo.Add("SheJiUnitGrade", pEnt.SheJiUnitGrade);
            jo.Add("KanChaUnit", pEnt.KanChaUnit);
            jo.Add("KanChaZZLevel", pEnt.KanChaZZLevel);
            jo.Add("SendTime", DateTime.Now.ToShortDateString());
            PageState.Add("FormData", jo);
        }
    }
}

