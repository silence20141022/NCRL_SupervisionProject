using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Aim.Data;
using Aim;
using Newtonsoft.Json.Linq;
using Aim.Portal.Model;
using System.IO;

namespace SP.Web.DailyManage
{
    public partial class FileManage : System.Web.UI.Page
    {
        int totalProperty = 0;
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
            string sql = "";
            DataTable dt = null;
            string node = Request["node"];
            JObject json = null;
            if (!string.IsNullOrEmpty(node))
            {
                json = JsonHelper.GetObject<JObject>(node);
            }
            switch (action)
            {
                case "loadtreedata":
                    switch (json.Value<string>("level"))
                    {
                        case "0":
                            sql = @"select GroupID as id,replace(Name,'江西瑞林建设监理有限公司','') as name,GroupID as groupid,'' as projectid,'1' as level,'false' as leaf,
                            '' as firsttypeid,'' as secondtypeid from SysGroup where ParentId='" + json.Value<string>("id") + "' order by Code asc";
                            break;
                        case "1":
                            sql = @"select Id as id,projectName as name,'{0}' as groupid,Id as projectid,'' as firsttypeid,'' as secondtypeid,'2' as level,'false' as leaf
                            from NCRL_SP..Project where BelongCmp = 'JL' and BelongDeptId = '{0}'";
                            sql = string.Format(sql, json.Value<string>("id"));
                            break;
                        case "2":
                            sql = @"select EnumerationID as id,Name as name,'{0}' as groupid,'{1}' as projectid,EnumerationID as firsttypeid,'' as secondtypeid,'3' as level,'false' as leaf
                            from sysenumeration where parentid='cf38bd7a-79d1-46fb-bf06-640b30f61654' order by SortIndex asc";
                            sql = string.Format(sql, json.Value<string>("groupid"), json.Value<string>("id"));
                            break;
                        case "3":
                            sql = @"select EnumerationID as id,Name as name,'{0}' as groupid,'{1}' as projectid,'{2}' as firsttypeid,EnumerationID as secondtypeid,'4' as level,'true' as leaf
                            from sysenumeration where ParentID='{3}'";
                            sql = string.Format(sql, json.Value<string>("groupid"), json.Value<string>("projectid"), json.Value<string>("firsttypeid"), json.Value<string>("id"));
                            break;
                    }
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write(JsonHelper.GetJsonStringFromDataTable(dt));
                    Response.End();
                    break;
                case "loadfile":
                    switch (json.Value<string>("level"))
                    {
                        case "0"://加载所有文档
                            sql = @"select a.Id,a.Name,a.CreatorName as CreateName,a.CreateTime,b.ProjectName,C.Name SecondTypeName,d.Path as FolderName from FileItem a 
                            left join NCRL_SP..Project b on a.ProjectId=b.Id 
                            left join SysEnumeration c on a.SecondTypeId=c.EnumerationId
                            left join FileFolder d on a.FolderId=d.Id where b.BelongCmp='JL'";
                            break;
                        case "1"://加载某一部门的文档
                            sql = @"select a.Id,a.Name,a.CreatorName as CreateName,a.CreateTime,b.ProjectName,C.Name SecondTypeName,d.Path as FolderName from FileItem a 
                            left join NCRL_SP..Project b on a.ProjectId=b.Id 
                            left join SysEnumeration c on a.SecondTypeId=c.EnumerationId
                            left join FileFolder d on a.FolderId=d.Id where  b.BelongCmp='JL' and a.GroupId='" + json.Value<string>("id") + "'";
                            break;
                        case "2"://加载某一项目的文档
                            sql = @"select a.Id,a.Name,a.CreatorName as CreateName,a.CreateTime,b.ProjectName,C.Name SecondTypeName,d.Path as FolderName from FileItem a 
                            left join NCRL_SP..Project b on a.ProjectId=b.Id 
                            left join SysEnumeration c on a.SecondTypeId=c.EnumerationId
                            left join FileFolder d on a.FolderId=d.Id where  a.ProjectId='" + json.Value<string>("projectid") + "'";
                            break;
                        case "3"://加载某一项目某一大类文档
                            sql = @"select a.Id,a.Name,a.CreatorName as CreateName,a.CreateTime,b.ProjectName,C.Name SecondTypeName,d.Path as FolderName from FileItem a 
                            left join NCRL_SP..Project b on a.ProjectId=b.Id 
                            left join SysEnumeration c on a.SecondTypeId=c.EnumerationId
                            left join FileFolder d on a.FolderId=d.Id where a.ProjectId='{0}' and  a.FirstTypeId='{1}'";
                            sql = string.Format(sql, json.Value<string>("projectid"), json.Value<string>("firsttypeid"));
                            break;
                        case "4"://加载某一项目某一大类的某一小类文档
                            sql = @"select a.Id,a.Name,a.CreatorName as CreateName,a.CreateTime,b.ProjectName,C.Name SecondTypeName,d.Path as FolderName from FileItem a 
                            left join NCRL_SP..Project b on a.ProjectId=b.Id 
                            left join SysEnumeration c on a.SecondTypeId=c.EnumerationId
                            left join FileFolder d on a.FolderId=d.Id where a.ProjectId='{0}' and  a.FirstTypeId='{1}' and a.SecondTypeId='{2}'";
                            sql = string.Format(sql, json.Value<string>("projectid"), json.Value<string>("firsttypeid"), json.Value<string>("secondtypeid"));
                            break;
                        case "5":
                            string filename = Request["filename"];
                            string projectnamecode = Request["projectnamecode"];
                            string where = "";
                            if (!string.IsNullOrEmpty(filename))
                            {
                                where += " and a.Name like '%" + filename + "%'";
                            }
                            if (!string.IsNullOrEmpty(projectnamecode))
                            {
                                where += " and (b.ProjectName like '%" + projectnamecode + "%' or b.ProjectCode like '%" + projectnamecode + "%')";
                            }
                            sql = @"select a.Id,a.Name,a.CreatorName as CreateName,a.CreateTime,b.ProjectName,C.Name SecondTypeName,d.Path as FolderName from FileItem a 
                                left join NCRL_SP..Project b on a.ProjectId=b.Id 
                                left join SysEnumeration c on a.SecondTypeId=c.EnumerationId
                                left join FileFolder d on a.FolderId=d.Id where 1=1 " + where;
                            break;
                    }
                    dt = DataHelper.QueryDataTable(GetPageSql(sql));
                    Response.Write("{'rows':" + JsonHelper.GetJsonStringFromDataTable(dt) + ",total:'" + totalProperty + "'}");
                    Response.End();
                    break;
                case "delete":
                    string fileid = Request["fileid"];
                    FileItem fiEnt = FileItem.Find(fileid);
                    FileFolder ffEnt = FileFolder.Find(fiEnt.FolderId);
                    if (File.Exists(@"D:\RW\Files\AppFiles\Portal\" + ffEnt.Path + @"\" + fiEnt.Id + "_" + fiEnt.Name))
                    {
                        File.Delete(@"D:\RW\Files\AppFiles\Portal\" + ffEnt.Path + @"\" + fiEnt.Id + "_" + fiEnt.Name);
                    }
                    fiEnt.DoDelete();
                    Response.Write("{success:true}");
                    Response.End();
                    break;
            }
        }
        private string GetPageSql(string tempsql)
        {
            int start = Convert.ToInt32(Request["start"]);
            int limit = Convert.ToInt32(Request["limit"]);
            totalProperty = DataHelper.QueryValue<int>("select count(1) from (" + tempsql + ") t");
            string order = "CreateTime";
            string asc = " desc";
            string pageSql = @"
		    WITH Temp AS
		    (SELECT *,
		    ROW_NUMBER() OVER (order by {0} {1})as RowNumber
		    FROM ({2}) temp ) 
		    SELECT * 
		    FROM Temp 
		    WHERE RowNumber between {3} and {4}";
            pageSql = string.Format(pageSql, order, asc, tempsql, start + 1, limit + start);
            return pageSql;
        }
    }
}