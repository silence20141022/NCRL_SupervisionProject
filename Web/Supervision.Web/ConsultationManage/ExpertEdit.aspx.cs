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
using Aim.Portal.Web;

namespace SP.Web.ConsultationManage
{
    public partial class ExpertEdit : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        Expert ent = null;
        string Id = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Aim.Portal.Web.WebPortalService.CheckLogon();
            }
            catch
            {
                Response.Write("<script> window.parent.location.href = '/Login.aspx';</script>");
                Response.End();
            }
            string action = Request["action"];
            Id = Request["Id"];
            if (!string.IsNullOrEmpty(action))
            {
                switch (action)
                {
                    case "ProfessionType":
                        DoProfessionType();
                        break;
                    case "MajorName":
                        sql = "select  * from  NCRL_Portal..SysEnumeration where ParentID = 'b640c40c-e2a9-41a8-bd28-d8ff9d71ff94' order by sortindex asc";
                        dt = DataHelper.QueryDataTable(sql);
                        string str = JsonHelper.GetJsonString(dt);
                        if (!string.IsNullOrEmpty(Id))
                        {
                            ent = Expert.Find(Id);
                            Response.Write("{success:  true  ,MajorName:'" + ent.MajorName + "',rows:" + str + "}");
                            Response.End();
                            return;
                        }
                        Response.Write("{success:true,MajorName:'',rows:" + str + "}");
                        Response.End();
                        break;
                    case "RCStore":
                        RCStore();
                        break;
                    case "Create":
                        string obj = Request["data"];
                        string ProfessionType = Request["ProfessionType"];
                        string MajorName = Request["MajorName"];
                        ent = JsonHelper.GetObject<Expert>(obj);
                        ent.MajorCode = MajorName;
                        ent.MajorName = MajorName;
                        ent.ProfessionType = ProfessionType;
                        sql = "select max(SortIndex) from NCRL_SP..Expert";
                        ent.SortIndex = DataHelper.QueryValue<int>(sql) + 1;
                        ent.DoCreate();
                        break;
                    case "Update":
                        Update();
                        break;
                    case "SelectEdit":
                        SelectEdit();
                        break;
                }
            }
        }
        private void Update()
        {

            string obj = Request["data"];
            string ProfessionType = Request["ProfessionType"];
            string MajorName = Request["MajorName"];
            ent = JsonHelper.GetObject<Expert>(obj);
            Expert ori_Ent = Expert.Find(ent.Id);
            EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(obj);
            ent = DataHelper.MergeData<Expert>(ori_Ent, ent, dic.Keys);
            ent.MajorCode = MajorName;
            ent.MajorName = MajorName;
            ent.ProfessionType = ProfessionType;
            ent.DoUpdate();
        }
        private void SelectEdit()
        {
            if (!string.IsNullOrEmpty(Id))
            {
                string data = JsonHelper.GetJsonString(Expert.Find(Id));
                string sa = "{success: true  ,data:" + data + "}";
                Response.Write(sa);
                Response.End();
            }
        }
        private void Create()
        {
            string obj = Request["data"];
            string ProfessionType = Request["ProfessionType"];
            string MajorName = Request["MajorName"];
            ent = JsonHelper.GetObject<Expert>(obj);
            ent.MajorCode = MajorName;
            ent.MajorName = MajorName;
            ent.ProfessionType = ProfessionType;
            ent.CreateId = WebPortalService.CurrentUserInfo.UserID;
            ent.CreateName = WebPortalService.CurrentUserInfo.Name;
            ent.CreateTime = DateTime.Now;
            ent.DoCreate();
        }

        private void RCStore()
        {
            sql = "select * from NCRL_Portal..SysEnumeration where ParentID='5b05bf17-5b33-4493-8250-c934d352281b'";
            dt = DataHelper.QueryDataTable(sql);
            string str = JsonHelper.GetJsonString(dt);
            Response.Write("{rows:" + str + "}");
            Response.End();
        }
        private void MajorName()
        {
            sql = "select  * from  NCRL_Portal..SysEnumeration where path like '%b640c40c-e2a9-41a8-bd28-d8ff9d71ff94%'";
            dt = DataHelper.QueryDataTable(sql);
            string str = JsonHelper.GetJsonString(dt);
            if (!string.IsNullOrEmpty(Id))
            {
                ent = Expert.Find(Id);
                Response.Write("{success:  true  ,MajorName:'" + ent.MajorName + "',rows:" + str + "}");
                Response.End();
                return;
            }
            Response.Write("{success:true,MajorName:'',rows:" + str + "}");
            Response.End();
        }
        private void DoProfessionType()
        {
            sql = "select * from  NCRL_Portal..SysEnumeration where PATH LIKE '%c2d9fcd4-82ad-4007-a0f5-76162ee51cd4%'";
            dt = DataHelper.QueryDataTable(sql);
            string str = JsonHelper.GetJsonString(dt);
            if (!string.IsNullOrEmpty(Id))
            {
                ent = Expert.Find(Id);
                Response.Write("{success:  true  ,ProfessionType:'" + ent.ProfessionType + "',rows:" + str + "}");
                Response.End();
                return;
            }
            Response.Write("{success:  true ,ProfessionType:'',rows:" + str + "}");
            Response.End();
        }
    }
}