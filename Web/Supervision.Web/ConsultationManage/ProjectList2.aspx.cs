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
using Aspose.Words;
using System.Net;
using System.IO;
using System.Reflection;
using Aim.Portal.Model;

namespace SP.Web.ConsultationManage
{
    public partial class ProjectList2 : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        int totalProperty;
        string where = "";
        Project pEnt = null;
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
            string id = Request["id"];
            Document srcDoc = null;
            BookmarkCollection marks = null;
            string filename = "";
            switch (action)
            {
                case "DoSelect":
                    DoSelect();
                    break;
                case "delete":
                    Delete();
                    break;
                case "Recycle":
                    Recycle();
                    break;
                case "exporthegeshu":
                    pEnt = Project.Find(id);
                    srcDoc = new Document(@"D:\中国瑞林\NCRL_SupervisionProject\Web\Supervision.Web\Template\审查合格书_市政工程_房屋建筑.doc");
                    marks = srcDoc.Range.Bookmarks;
                    for (int j = 0; j < marks.Count; j++)
                    {
                        Bookmark mark = marks[j];
                        if (ContainProperty(pEnt, mark.Name))
                        {
                            mark.Text = pEnt.GetValue<string>(mark.Name);
                        }
                    }
                    string sql = @"select a.MajorName,(select top 1 SortIndex from SysEnumeration where ParentId='b640c40c-e2a9-41a8-bd28-d8ff9d71ff94' and Name=a.MajorName) as SortIndex
                                 from NCRL_SP..ProjectUser a where a.ProjectId='" + pEnt.Id + "' order by SortIndex asc";
                    IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
                    int i = 1;
                    foreach (EasyDictionary dic in dics)
                    {
                        if (dic.Get<string>("MajorName") != "勘察")
                        {
                            if (marks["Major" + i] != null)
                            {
                                marks["Major" + i].Text = dic.Get<string>("MajorName");
                            }
                            i++;
                        }
                    }
                    string fileName = System.Guid.NewGuid().ToString() + ".docx";
                    srcDoc.Save(@"D:\中国瑞林\NCRL_SupervisionProject\Web\Supervision.Web\Template\" + fileName);
                    break;
                case "exportqingkuangjilu":
                    pEnt = Project.Find(id);
                    srcDoc = new Document(@"D:\中国瑞林\NCRL_SupervisionProject\Web\Supervision.Web\Template\附件6房屋建筑和市政基础设施工程施工图设计文件审查情况记录.doc");
                    marks = srcDoc.Range.Bookmarks;
                    for (int j = 0; j < marks.Count; j++)
                    {
                        Bookmark mark = marks[j];
                        if (ContainProperty(pEnt, mark.Name))
                        {
                            mark.Text = pEnt.GetValue<string>(mark.Name);
                        }
                    }
                    filename = pEnt.ProjectName + "_审查情况记录_" + DateTime.Now.ToString();
                    srcDoc.Save(@"D:\RW\Files\AppFiles\Portal\Default\" + filename + ".docx");
                    FileItem fiEnt = new FileItem();
                    fiEnt.ProjectId = pEnt.Id;
                    fiEnt.Name = filename;
                    fiEnt.CreateTime = DateTime.Now;
                    fiEnt.Path = "导出";
                    fiEnt.DoCreate();
                    break;
            }
        }
        private bool ContainProperty(Project pEnt, string propertyName)
        {
            if (pEnt != null && !string.IsNullOrEmpty(propertyName))
            {
                PropertyInfo _findedPropertyInfo = pEnt.GetType().GetProperty(propertyName);
                return (_findedPropertyInfo != null);
            }
            return false;
        }
        private void Recycle()
        {
            string Result = "T";
            string id = Request["id"];
            IList<ExamineTask> etEnts = ExamineTask.FindAllByProperty(ExamineTask.Prop_ProjectId, id);
            foreach (ExamineTask etEnt in etEnts)
            {
                IList<ExamineOpinion> eoEnts = ExamineOpinion.FindAllByProperty(ExamineOpinion.Prop_ExamineTaskId, etEnt.Id);
                if (eoEnts.Count > 0)
                {
                    Result = "F";
                    break;
                }
            }
            if (Result == "T")
            {
                ExamineTask.DeleteAll("ProjectId='" + id + "'");
                pEnt = Project.Find(id);
                pEnt.Status = "已创建";
                pEnt.TaskQuan = 0;
                pEnt.DoUpdate();
            }
            Response.Write("{success:  true ,Result:'" + Result + "'}");
            Response.End();
        }
        private void Delete()
        {
            string Id = Request["Id"];
            if (!string.IsNullOrEmpty(Id))
            {
                ProjectUser.DeleteAll("ProjectId='" + Id + "'");
                SubProject.DeleteAll("ProjectId='" + Id + "'");
                KanChaSheJi.DeleteAll("ProjectId='" + Id + "'");
                sql = "delete NCRL_SP..Project where Id='" + Id + "'";
                DataHelper.ExecSql(sql);
            }
        }
        private void DoSelect()
        {
            string tabIndex = Request["tabIndex"];
            string ProjectName = Request["ProjectName"];
            if (!string.IsNullOrEmpty(ProjectName))
            {
                where = "and p.ProjectName like '%" + ProjectName + "%' ";
            }
            if (tabIndex == "0")
            {
                sql = @"select p.* from NCRL_SP..Project as p  where p.BelongCmp = 'ZX' and isnull(p.Status,'')!='已结束' " + where;
            }
            if (tabIndex == "1")
            {
                sql = @"select p.* from NCRL_SP..Project as p where p.BelongCmp = 'ZX' and  p.Status='已结束' " + where;
            }
            dt = DataHelper.QueryDataTable(GetPageSql(sql));
            Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",total:" + totalProperty + "}");
            Response.End();

        }
        private string GetPageSql(string tempsql)
        {
            int start = Convert.ToInt32(Request["start"]);
            int limit = Convert.ToInt32(Request["limit"]);
            totalProperty = DataHelper.QueryValue<int>("select count(1) from (" + tempsql + ") t");
            string order = "CREATETIME";
            string asc = " desc";
            string pageSql = @"
		    WITH OrderedOrders AS
		    (SELECT *,
		    ROW_NUMBER() OVER (order by {0} {1})as RowNumber
		    FROM ({2}) temp ) 
		    SELECT * 
		    FROM OrderedOrders 
		    WHERE RowNumber between {3} and {4}";
            pageSql = string.Format(pageSql, order, asc, tempsql, start + 1, limit + start);
            return pageSql;
        }
    }
}