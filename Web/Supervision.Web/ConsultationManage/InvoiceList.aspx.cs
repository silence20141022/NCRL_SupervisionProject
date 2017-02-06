using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using System.Data;
using Aim;
using Aim.Portal.Model;
using SP.Model;

namespace SP.Web.ConsultationManage
{
    public partial class InvoiceList : System.Web.UI.Page
    {
        Invoice ent = null;
        string sql = "";
        string where = "";
        int totalProperty;
        DataTable dt;

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
                case "DoSelect":
                    if (!string.IsNullOrEmpty(Request["ProjectName"]))
                    {
                        where += " and (b.ProjectName like '%" + Request["ProjectName"].Trim() + "%' or b.ZiXunCode like '%" + Request["ProjectName"].Trim() + "%')";
                    }
                    if (!string.IsNullOrEmpty(Request["InvoiceNo"]))
                    {
                        where += " and InvoiceNo like '%" + Request["InvoiceNo"].Trim() + "%' ";
                    }
                    if (!string.IsNullOrEmpty(Request["StartDate"]))
                    {
                        where += "and KaiPiaoDate >='" + Request["StartDate"] + "'";
                    }
                    if (!string.IsNullOrEmpty(Request["EndDate"]))
                    {
                        where += "and KaiPiaoDate <='" + Request["StartDate"] + "'";
                    }
                    sql = @"select a.*,b.ProjectName,b.ZiXunCode,b.JianSheUnit,(select sum(ShouKuanAmount) from NCRL_SP..ShouKuan  where InvoiceId=a.Id group by  InvoiceId) ShouKuanAmount
                    from NCRL_SP..Invoice a left join NCRL_SP..Project b on  a. ProjectId=b.Id  where   1=1" + where;
                    dt = DataHelper.QueryDataTable(GetPageSql(sql));
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",total:" + totalProperty + "}");
                    Response.End();
                    break;
                case "zf":
                    string Jarray = Request["Jarray"];
                    if (!string.IsNullOrEmpty(Jarray))
                    {
                        string[] idArray = Jarray.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                        for (int i = 0; i < idArray.Length; i++)
                        {
                            ent = Invoice.Find(idArray[i]);
                            ent.Status = "已作废";
                            ent.DoUpdate();
                            IList<ShouKuan> skEnts = ShouKuan.FindAllByProperty(ShouKuan.Prop_InvoiceId, ent.Id);
                            foreach (ShouKuan skEnt in skEnts)
                            {
                                skEnt.Status = "已作废";
                                skEnt.DoUpdate();
                            }
                            break;
                        }
                    }
                    break;
                case "loadshoukun":
                    if (!string.IsNullOrEmpty(Request["ProjectName"]))
                    {
                        where += " and (b.ZiXunCode like '%" + Request["ProjectName"].Trim() + "%' or b.ProjectName like '%" + Request["ProjectName"].Trim() + "%')";
                    }
                    if (!string.IsNullOrEmpty(Request["InvoiceNo"]))
                    {
                        where += " and InvoiceNo like '%" + Request["InvoiceNo"].Trim() + "%'";
                    }
                    if (!string.IsNullOrEmpty(Request["StartDate"]))
                    {
                        where += " and ShouKuanDate >=   '" + Request["StartDate"] + "'";
                    }
                    if (!string.IsNullOrEmpty(Request["EndDate"]))
                    {
                        where += " and ShouKuanDate <=   '" + Request["EndDate"] + "'";
                    }
                    sql = @"select a.Id,a.ShouKuanDate,a.ShouKuanAmount,a.CreateName,a.CreateTime,a.Remark,a.YiFenPercent,
                          a.ChouJinAmount,b.ZiXunCode,b.ProjectName,c.InvoiceNo from NCRL_SP..ShouKuan a 
                          left join NCRL_SP..Invoice c on a.InvoiceId=c.Id
                          left join NCRL_SP..Project b on a.ProjectId=b.Id where 1=1 " + where;
                    dt = DataHelper.QueryDataTable(GetPageSql(sql));
                    Response.Write("{total:" + totalProperty + ",rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
            }
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