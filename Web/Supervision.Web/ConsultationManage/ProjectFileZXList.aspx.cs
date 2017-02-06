using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Aim.Data;
using SP.Model;
using Aim;
using Aim.Portal.Model;
namespace SP.Web.ConsultationManage
{
    public partial class ProjectFileZXList : System.Web.UI.Page
    {
        string sql = "";
        string where = "";
        DataTable dt;
        int totalProperty;
        FileItem FIEnt = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            switch (action)
            {
                case "selectPorject":
                    selectPorject();
                    break;
                case "FileItem":
                    fileItem();
                    break;
                case "Delete":
                    Delete();
                    break;
            }
        }
        private void Delete()
        {
            string Jarray = Request["Jarray"];
            string[] idArray = Jarray.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
            for (int i = 0; i < idArray.Length; i++)
            {
                FIEnt = FileItem.Find(idArray[i]);
                if (FIEnt != null)
                {
                    sql = "delete FileItem where id='" + FIEnt.Id + "'";
                    DataHelper.ExecSql(sql);
                    sql = "delete FileFolder where id='" + FIEnt.FolderId + "'";
                    DataHelper.ExecSql(sql);
                }
            }
        }
        private void selectPorject()
        {
            string id = Request["id"];
            string ProjectName = Request["ProjectName"];
            if (id == "100001")
            {
                if (!string.IsNullOrEmpty(ProjectName))
                {
                    where += "and ProjectName like '%" + ProjectName + "%'  ";
                }
                sql = "select Id as id, ProjectName as Name from NCRL_SP..Project where BelongCmp='ZX' " + where + "order by CreateTime desc";
                IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
                string result = "[";
                int i = 0;
                foreach (EasyDictionary dic in dics)
                {
                    if (i != dics.Count - 1)
                    {
                        result += "{id:'" + dic.Get<string>("id") + "',Name:'" + dic.Get<string>("Name") + "',leaf:true},";
                    }
                    else
                    {
                        result += "{id:'" + dic.Get<string>("id") + "',Name:'" + dic.Get<string>("Name") + "',leaf:true}";
                    }
                    i++;
                }
                result += "]";
                Response.Write(result);
                Response.End();
            }
        }
        private void fileItem()
        {
            string ProjectId = Request["ProjectId"];
            string Name = Request["Name"];
            if (!string.IsNullOrEmpty(Name))
            {
                where += " and FI.Name like '%" + Name + "%'";
            }

            if (!string.IsNullOrEmpty(ProjectId) && ProjectId != "100001")
            {
                where += " and FI.ProjectId='" + ProjectId + "'";

                sql = "select FI.Id Id , FI.Name Name , FI.FullId FullId ,FI.CreateTime CreateTime ,FI.CreatorName CreatorName, FF.Name FolderName    from FileItem FI  left Join FileFolder FF ON  FF.ID=FI.FolderId where FI.GroupId='267' " + where;
            }
            else
            {
                sql = "select FI.Id Id , FI.Name Name , FI.FullId FullId ,FI.CreateTime CreateTime ,FI.CreatorName CreatorName, FF.Name FolderName    from FileItem FI  left Join FileFolder FF ON  FF.ID=FI.FolderId where FI.GroupId='267' " + where;
            }
            dt = DataHelper.QueryDataTable(GetPageSql(sql));
            string json = JsonHelper.GetJsonString(dt);
            Response.Write("{'rows':" + json + ",total:'" + totalProperty + "'}");
            Response.End();
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