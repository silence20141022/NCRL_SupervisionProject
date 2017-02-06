using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim;
using Aim.Portal.Model;
using Aim.Portal.Web;
using SP.Model;
using System.IO;

namespace SP.Web.ConsultationManage
{
    public partial class ProjectFileZXEdit : System.Web.UI.Page
    {
        FileItem FEnt;
        Project PEnt;
        FileFolder ffEnt = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            switch (action)
            {
                case "upload":
                    upLoad();
                    break;
            }
        }
        private void upLoad()
        {
            string json = Request["json"];
            FEnt = JsonHelper.GetObject<FileItem>(json);
            PEnt = Project.Find(FEnt.ProjectId);
            IList<FileFolder> ffEnts = FileFolder.FindAllByProperty(FileFolder.Prop_FolderKey, PEnt.ZiXunCode);
            if (ffEnts.Count == 0)
            {
                ffEnt = new FileFolder();
                ffEnt.Name = PEnt.ZiXunCode;
                ffEnt.FolderKey = PEnt.ZiXunCode;
                ffEnt.Path = PEnt.ZiXunCode;
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
            if (!Directory.Exists(@"D:\RW\Files\AppFiles\Portal\" + PEnt.ZiXunCode))
            {
                Directory.CreateDirectory(@"D:\RW\Files\AppFiles\Portal\" + PEnt.ZiXunCode);
            }
            HttpPostedFile postedFile = Request.Files["File"];
            FEnt.Name = Path.GetFileName(postedFile.FileName);       //获取文件名称
            FEnt.GroupId = "267";
            FEnt.FolderId = ffEnt.Id;
            FEnt.CreatorId = WebPortalService.CurrentUserInfo.UserID;
            FEnt.CreatorName = WebPortalService.CurrentUserInfo.Name;
            FEnt.CreateTime = DateTime.Now;
            FEnt.DoCreate();
            postedFile.SaveAs(@"D:\RW\Files\AppFiles\Portal\" + PEnt.ZiXunCode + @"/" + FEnt.Id + "_" + FEnt.Name);//保存到这个地址
            Response.Write("{success:true}");
            Response.End();
        }
    }
}