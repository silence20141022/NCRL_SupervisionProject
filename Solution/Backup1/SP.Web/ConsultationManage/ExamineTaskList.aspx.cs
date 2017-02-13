using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Aim.Data;
using Aim;

namespace SP.Web.ConsultationManage
{
    public partial class ExamineTaskList : System.Web.UI.Page
    {
        string sql = "";
        string where = "";
        DataTable dt;
        int totalProperty;
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
            switch (action)
            {
                case "Select":
                    string ProjectName = Request["ProjectName"].Trim();
                    if (!string.IsNullOrEmpty(ProjectName))
                    {
                        where = " and   ProjectName like '%" + ProjectName + "%'";
                    }
                    sql = "select * from NCRL_SP..Project where Status='已下达' and BelongCmp='ZX' " + where;
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",total:" + totalProperty + "}");
                    Response.End();
                    break;
                case "loadtask":
                    string projectid = Request["projectid"];
                    sql = @"select e.Id,e.MajorName,pu.UserId,pu.UserName,e.PlanBackTime, e.CreateTime,
                         (select count(1) from NCRL_SP..ExamineOpinion where ExamineTaskId=e.Id) as ExamineOpinion ,
                          (select top 1 SortIndex from  NCRL_Portal..SysEnumeration where ParentId='b640c40c-e2a9-41a8-bd28-d8ff9d71ff94' and Name=e.MajorName) as SortIndex
                          from NCRL_SP..ExamineTask e 
                          left join NCRL_SP..ProjectUser pu on e.ProjectUserId = pu.Id  where e.ProjectId='" + projectid + "' ";
                    dt = DataHelper.QueryDataTable(GetPageSql(sql));
                    Response.Write("{innerrows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
            }
        }
        private string GetPageSql(string tempsql)
        {
            int start = Convert.ToInt32(Request["start"]);
            int limit = Convert.ToInt32(Request["limit"]);
            totalProperty = DataHelper.QueryValue<int>("select count(1) from (" + tempsql + ") t");
            string order = "CREATETIME desc,SortIndex asc";
            string pageSql = @"
		    WITH OrderedOrders AS
		    (SELECT *,
		    ROW_NUMBER() OVER (order by {0})as RowNumber
		    FROM ({1}) temp ) 
		    SELECT * 
		    FROM OrderedOrders 
		    WHERE RowNumber between {2} and {3}";
            pageSql = string.Format(pageSql, order, tempsql, start + 1, limit + start);
            return pageSql;
        }
    }
}