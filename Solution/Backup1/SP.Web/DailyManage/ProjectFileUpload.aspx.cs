using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using SP.Model;
using Aim.Portal.Model;
using Newtonsoft.Json.Linq;
using System.Configuration;
using System.Data.SqlClient;

namespace SP.Web.DailyManage
{
    public partial class ProjectFileUpload : System.Web.UI.Page
    {
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
            string groupid = Request["groupid"];
            string projectId = Request["projectid"];
            FileFolder ffEnt = null;
            Project pEnt = null;
            switch (action)
            {
                case "upload":
                    //如果是项目文档  上传项目编号文件夹 如果是部门文档上传到DEFAULT文件夹
                    if (!string.IsNullOrEmpty(projectId))
                    {
                        pEnt = Project.Find(projectId);
                        IList<FileFolder> ffEnts = FileFolder.FindAllByProperty(FileFolder.Prop_FolderKey, pEnt.ProjectCode);
                        if (ffEnts.Count == 0)
                        {
                            ffEnt = new FileFolder();
                            ffEnt.Name = pEnt.ProjectCode;
                            ffEnt.FolderKey = pEnt.ProjectCode;
                            ffEnt.Path = pEnt.ProjectCode;
                            ffEnt.ParentId = "1";
                            ffEnt.CreateTime = DateTime.Now;
                            ffEnt.ModuleId = "1";
                            ffEnt.DoCreate();
                            ffEnt.FullId = "1." + ffEnt.Id;
                            ffEnt.DoUpdate();
                        }
                        else
                        {
                            ffEnt = ffEnts[0];
                        }
                        if (!Directory.Exists(@"D:\RW\Files\AppFiles\Portal\" + pEnt.ProjectCode))
                        {
                            Directory.CreateDirectory(@"D:\RW\Files\AppFiles\Portal\" + pEnt.ProjectCode);
                        }
                    }
                    else
                    {
                        ffEnt = FileFolder.Find("1");//如果是非项目文档，上传到默认文件夹
                    }
                    string formdata = Request["formdata"];
                    JObject json = Aim.JsonHelper.GetObject<JObject>(formdata);
                    FileItem fiEnt = new FileItem();
                    fiEnt.GroupId = groupid;
                    fiEnt.ProjectId = projectId;
                    fiEnt.FirstTypeId = json.Value<string>("FirstTypeId");
                    fiEnt.SecondTypeId = json.Value<string>("SecondTypeId");
                    HttpPostedFile postedFile = Request.Files["projectfile"];//获取上传信息对象  
                    string fileName = Path.GetFileName(postedFile.FileName);
                    fiEnt.Name = fileName;
                    fiEnt.FolderId = ffEnt.Id;
                    fiEnt.CreatorId = Aim.Portal.Web.WebPortalService.CurrentUserInfo.UserID;
                    fiEnt.CreatorName = Aim.Portal.Web.WebPortalService.CurrentUserInfo.Name;
                    fiEnt.CreateTime = DateTime.Now;
                    fiEnt.DoCreate();
                    // string filename = postedFile.FileName;//获取上传的文件路径
                    // string tempPath = System.Configuration.ConfigurationManager.AppSettings["NewsFolderPath"];//获取保存文件夹路径，我是设置在webconfig中了。
                    // string savepath = Server.MapPath(@"D:\RW\Files\AppFiles\Portal\" + pEnt.ProjectCode + "\\");//获取保存路径
                    // string sExtension = filename.Substring(filename.LastIndexOf('.'));//获取拓展名
                    //if (!Directory.Exists(savepath))
                    //Directory.CreateDirectory(savepath);
                    //string sNewFileName = DateTime.Now.ToString("yyyyMMddhhmmsfff"); + fiEnt.Id + "_"" + seEnt.IsLeaf + "
                    postedFile.SaveAs(@"D:\RW\Files\AppFiles\Portal\" + ffEnt.Path + @"/" + fiEnt.Id + "_" + fileName);//保存
                    Response.Write("{success:true}");
                    Response.End();
                    break;
                case "loadfiletype":
                    string id = Request["id"];
                    if (string.IsNullOrEmpty(id))
                    {
                        id = "cf38bd7a-79d1-46fb-bf06-640b30f61654";
                    }
                    IList<SysEnumeration> seEnts = SysEnumeration.FindAllByProperty("SortIndex", SysEnumeration.Prop_ParentID, id);
                    int i = 0;
                    string result = "[";
                    foreach (SysEnumeration seEnt in seEnts)
                    {
                        if (i != seEnts.Count - 1)
                        {

                            result += "{'id':'" + seEnt.EnumerationID + "','text':'" + seEnt.Name + "','leaf':" + (seEnt.IsLeaf.Value ? "true" : "false") + ",'parentid':'" + seEnt.ParentID + "'},";
                        }
                        else
                        {
                            result += "{'id':'" + seEnt.EnumerationID + "','text':'" + seEnt.Name + "','leaf':" + (seEnt.IsLeaf.Value ? "true" : "false") + ",'parentid':'" + seEnt.ParentID + "'}";
                        }
                        i++;
                    }
                    result += "]";
                    Response.Write(result);
                    Response.End();
                    break;
                case "getprojectname":
                    string temp = "{";
                    if (!string.IsNullOrEmpty(projectId))
                    {
                        pEnt = Project.Find(projectId);
                        temp += "ProjectName:'" + pEnt.ProjectName + "'";
                    }
                    if (!string.IsNullOrEmpty(groupid))
                    {
                        SysGroup sgEnt = SysGroup.Find(groupid);
                        temp += (temp.Length > 1 ? ",GroupName:'" : "GroupName:'") + sgEnt.Name + "'";
                    }
                    Response.Write(temp + "}");
                    Response.End();
                    break;
            }
        }
    }
}