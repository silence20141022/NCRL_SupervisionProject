using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Aim.Data;
using Aim;
using Aim.Portal.Model;
using SP.Model;
using Newtonsoft.Json.Linq;

namespace SP.Web.ConsultationManage
{
    public partial class ProjectCard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Aim.Portal.Web.WebPortalService.CheckLogon();
            }
            catch
            {
                Response.Write("<script> window.location.href = '/Login.aspx';</script>");
                Response.End();
            }
            string action = Request["action"];
            string sql = "";
            DataTable dt = null;
            Project pEnt = null;
            Project oriEnt = null;
            EasyDictionary dic = null;
            string id = Request["id"];
            if (!string.IsNullOrEmpty(id))
            {
                pEnt = Project.Find(id);
            }
            switch (action)
            {
                case "loadprojecttype":
                    sql = "select name from SysEnumeration where ParentId='f6845db5-6277-43b7-885d-031754bd51b0' order by SortIndex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "loadlocationfirst":
                    sql = "select id,name from NCRL_SP..LocationFirst order by Id asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "loadlocationsecond":
                    if (!string.IsNullOrEmpty(Request["locationfirst"]))
                    {
                        sql = @"select id,name from NCRL_SP..LocationSecond where First_Id=(select top 1 Id from 
                              NCRL_SP..LocationFirst where Name='" + Request["locationfirst"] + "') order by Id asc";
                        dt = DataHelper.QueryDataTable(sql);
                        Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                        Response.End();
                    }
                    break;
                case "loadchuangkou":
                    sql = "select id,DelegateName as name from NCRL_SP..DelegateInfo";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "loadgongchengleixing":
                    if (Request["prjleibiename"] == "市政工程")
                    {
                        sql = "select name from SysEnumeration where ParentId='120731f7-1ddd-4acc-a410-8bd39356863e' order by SortIndex asc";
                    }
                    else
                    {
                        sql = "select name from SysEnumeration where ParentId='110731f7-1ddd-4acc-a410-8bd39356863e' order by SortIndex asc";
                    }
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "create":
                    pEnt = JsonHelper.GetObject<Project>(Request["formdata"]);
                    pEnt.BelongCmp = "ZX";
                    pEnt.Status = "已创建";
                    pEnt.CreateId = Aim.Portal.Web.WebPortalService.CurrentUserInfo.UserID;
                    pEnt.CreateName = Aim.Portal.Web.WebPortalService.CurrentUserInfo.Name;
                    pEnt.CreateTime = DateTime.Now;
                    pEnt.DoCreate();
                    Response.Write("{success:true,data:" + JsonHelper.GetJsonString(pEnt) + "}");
                    Response.End();
                    break;
                case "update":
                    pEnt = JsonHelper.GetObject<Project>(Request["formdata"]);
                    dic = JsonHelper.GetObject<EasyDictionary>(Request["formdata"]);
                    oriEnt = Project.Find(pEnt.Id);
                    oriEnt = DataHelper.MergeData<Project>(oriEnt, pEnt, dic.Keys);
                    oriEnt.DoUpdate();
                    Response.Write("{success:true,data:" + JsonHelper.GetJsonString(oriEnt) + "}");
                    Response.End();
                    break;
                case "loadform":
                    Response.Write("{success:true,data:" + JsonHelper.GetJsonString(pEnt) + "}");
                    Response.End();
                    break;
                case "loadjiegouleixing":
                    sql = "select name from SysEnumeration where ParentId='28c731f7-1ddd-4acc-a410-8bd39356863e' order by SortIndex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "update_gaikuang":
                case "update_unit":
                case "update_standard":
                case "update_other":
                    pEnt = JsonHelper.GetObject<Project>(Request["formdata"]);
                    dic = JsonHelper.GetObject<EasyDictionary>(Request["formdata"]);
                    oriEnt = Project.Find(id);
                    oriEnt = DataHelper.MergeData<Project>(oriEnt, pEnt, dic.Keys);
                    oriEnt.DoUpdate();
                    Response.Write("{success:true,data:" + JsonHelper.GetJsonString(oriEnt) + "}");
                    Response.End();
                    break;
                case "loadsubprj":
                    sql = "select * from NCRL_SP..SubProject where ProjectId='" + id + "'";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "loadkanchashejiuser":
                    sql = @"select a.*,(select top 1 SortIndex from NCRL_Portal..SysEnumeration where Name=a.MajorName and ParentId='b640c40c-e2a9-41a8-bd28-d8ff9d71ff94') as SortIndex
                    from NCRL_SP..KanChaSheJi a where a.ProjectId='" + id + "' order by SortIndex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "loadprojectuser":
                    sql = @"select a.*,(select top 1 SortIndex from NCRL_Portal..SysEnumeration where Name=a.MajorName and ParentId='b640c40c-e2a9-41a8-bd28-d8ff9d71ff94') as SortIndex
                    from NCRL_SP..ProjectUser a where a.ProjectId='" + id + "' order by SortIndex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "update_subprj":
                    IList<SubProject> spEnts = SubProject.FindAllByProperty(SubProject.Prop_ProjectId, id);
                    foreach (SubProject spEnt in spEnts)
                    {
                        spEnt.DoDelete();
                    }
                    spEnts = JsonHelper.GetObject<IList<SubProject>>(Request["subprjs"]);
                    foreach (SubProject spEnt in spEnts)
                    {
                        spEnt.ProjectId = id;
                        spEnt.DoCreate();
                    }
                    Response.Write("{success:true}");
                    Response.End();
                    break;
                case "loadmajor":
                    sql = "select Name name from  NCRL_Portal..SysEnumeration where ParentID = 'b640c40c-e2a9-41a8-bd28-d8ff9d71ff94' order by sortindex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "update_kanchashejiuser":
                    IList<KanChaSheJi> kcsEnts = KanChaSheJi.FindAllByProperty(KanChaSheJi.Prop_ProjectId, id);
                    foreach (KanChaSheJi kcsEnt in kcsEnts)
                    {
                        kcsEnt.DoDelete();
                    }
                    kcsEnts = JsonHelper.GetObject<IList<KanChaSheJi>>(Request["kanchashejiuser"]);
                    foreach (KanChaSheJi kcsEnt in kcsEnts)
                    {
                        kcsEnt.ProjectId = id;
                        kcsEnt.DoCreate();
                    }
                    Response.Write("{success:true}");
                    Response.End();
                    break;
                case "loadexpert_shentu":
                    if (!string.IsNullOrEmpty(Request["majorname"]))
                    {
                        sql = "select Id UserId,UserName from NCRL_SP..Expert where ProfessionType like '%审图专家%' and MajorName like '%" + Request["majorname"] + "%'";
                        dt = DataHelper.QueryDataTable(sql);
                        Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                        Response.End();
                    }
                    break;
                case "loadexpert_qianzhang":
                    if (!string.IsNullOrEmpty(Request["majorname"]))
                    {
                        sql = "select Id UserId,UserName from NCRL_SP..Expert where ProfessionType like '%签章专家%' and MajorName like '%" + Request["majorname"] + "%'";
                        dt = DataHelper.QueryDataTable(sql);
                        Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                        Response.End();
                    }
                    break;
                case "loadexpert_shenhe":
                    if (!string.IsNullOrEmpty(Request["majorname"]))
                    {
                        sql = "select Id UserId,UserName from NCRL_SP..Expert where ProfessionType like '%审核专家%' and MajorName like '%" + Request["majorname"] + "%'";
                        dt = DataHelper.QueryDataTable(sql);
                        Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                        Response.End();
                    }
                    break;
                case "update_projectexpert":
                    if (pEnt.Status == "已创建")//如果项目任务已经下达了，不允许再对专家信息进行修改，不然会造成后面数据错误
                    {
                        IList<ProjectUser> puEnts = ProjectUser.FindAllByProperty(ProjectUser.Prop_ProjectId, id);
                        foreach (ProjectUser puEnt in puEnts)
                        {
                            puEnt.DoDelete();
                        }
                        puEnts = JsonHelper.GetObject<IList<ProjectUser>>(Request["projectexpert"]);
                        foreach (ProjectUser puEnt in puEnts)
                        {
                            puEnt.ProjectId = id;
                            puEnt.DoCreate();
                        }
                        Response.Write("{success:true}");
                        Response.End();
                    }
                    break;
            }
        }
    }
}