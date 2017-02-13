using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using System.Data;
using Aim;
using System.Configuration;
using Oracle.DataAccess.Client;
using SP.Model;

namespace SP.Web.DailyManage
{
    public partial class ProjectList : System.Web.UI.Page
    {
        string sql = "";
        string where = "";
        int totalProperty = 0;
        IList<Project> ents = null;
        Project ent = null;
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
                case "loadproject":
                    if (!string.IsNullOrEmpty(Request["CodeName"]))
                    {
                        string codeorname = Request["CodeName"];
                        where += " and (ProjectCode like '%" + codeorname + "%' or ProjectName like '%" + codeorname + "%')";
                    }
                    if (!string.IsNullOrEmpty(Request["Manager"]))
                    {
                        where += " and PManagerName like '%" + Request["Manager"] + "%'";
                    }
                    if (!string.IsNullOrEmpty(Request["BelongDeptId"]))
                    {
                        where += " and BelongDeptId = '" + Request["BelongDeptId"] + "'";
                    }
                    string tabIndex = Request["tabIndex"];
                    if (tabIndex == "0")
                    {
                        sql = @"select * from NCRL_SP..Project  where BelongCmp='JL' and isnull(Status,'')='' " + where;
                    }
                    if (tabIndex == "1")
                    {
                        sql = @"select * from NCRL_SP..Project  where BelongCmp='JL' and  Status='已完成' " + where;
                    }
                    DataTable dt = DataHelper.QueryDataTable(GetPageSql(sql));
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",total:" + totalProperty + "}");
                    Response.End();
                    break;
                case "synchronize":
                    SynchronizeNims();
                    break;
                case "loadgroup":
                    sql = "select GroupId id,replace(Name,'江西瑞林建设监理有限公司','') as name from SysGroup where ParentId='228' order by id asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
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
        private void SynchronizeNims()
        {
            string connstr = ConfigurationManager.ConnectionStrings["NimsConn"].ToString();
            OracleConnection conn = new OracleConnection(connstr);
            string sql = "select * from apps.CUX_PA_BASE_OA_INT_V where project_type='监理'";
            OracleCommand com = new OracleCommand(sql, conn);
            OracleDataAdapter da = new OracleDataAdapter(com);
            DataSet ds = new DataSet();
            da.Fill(ds);
            //228	江西瑞林建设监理有限公司
            //233	江西瑞林建设监理有限公司生产技术部
            //234	江西瑞林建设监理有限公司造价咨询部
            //235	江西瑞林建设监理有限公司第一监理所
            //236	江西瑞林建设监理有限公司第二监理所
            //237	江西瑞林建设监理有限公司第三监理所
            //238	江西瑞林建设监理有限公司第四监理所
            //239	江西瑞林建设监理有限公司第五监理所
            //532	江西瑞林建设监理有限公司其他监理分部
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                ents = Project.FindAllByProperty(Project.Prop_ProjectCode, dr["PROJECT_NUMBER"]);
                if (ents.Count == 0)//如果不存在该项目
                {
                    ent = new Project();
                    ent.ProjectCode = dr["PROJECT_NUMBER"] + "";
                    ent.ProjectName = dr["NAME"] + "";
                    ent.PManagerName = dr["PROJECT_MANAGER"] + "";
                    ent.JianSheUnit = dr["CUSTOMER_NAME"] + "";
                    ent.ProjectType = dr["INDUSTRY_CODE"] + "";
                    ent.BelongDeptId = dr["ATTRIBUTE4"] + "";
                    switch (dr["ATTRIBUTE4"] + "")
                    {
                        case "233":
                            ent.BelongDeptName = "生产技术部";
                            break;
                        case "234":
                            ent.BelongDeptName = "造价咨询部";
                            break;
                        case "235":
                            ent.BelongDeptName = "第一监理所";
                            break;
                        case "236":
                            ent.BelongDeptName = "第二监理所";
                            break;
                        case "237":
                            ent.BelongDeptName = "第三监理所";
                            break;
                        case "238":
                            ent.BelongDeptName = "第四监理所";
                            break;
                        case "239":
                            ent.BelongDeptName = "第五监理所";
                            break;
                        case "532":
                            ent.BelongDeptName = "其他监理分部";
                            break;
                    }
                    ent.Remark = dr["DESCRIPTION"] + "";
                    ent.BelongCmp = "JL";
                    ent.CreateTime = Convert.ToDateTime(dr["START_DATE"]);
                    ent.DoCreate();
                }
                else
                {
                    ents[0].ProjectName = dr["NAME"] + "";
                    ents[0].PManagerName = dr["PROJECT_MANAGER"] + "";
                    ents[0].JianSheUnit = dr["CUSTOMER_NAME"] + "";
                    ents[0].ProjectType = dr["INDUSTRY_CODE"] + "";
                    ents[0].BelongDeptId = dr["ATTRIBUTE4"] + "";
                    switch (dr["ATTRIBUTE4"] + "")
                    {
                        case "233":
                            ents[0].BelongDeptName = "生产技术部";
                            break;
                        case "234":
                            ents[0].BelongDeptName = "造价咨询部";
                            break;
                        case "235":
                            ents[0].BelongDeptName = "第一监理所";
                            break;
                        case "236":
                            ents[0].BelongDeptName = "第二监理所";
                            break;
                        case "237":
                            ents[0].BelongDeptName = "第三监理所";
                            break;
                        case "238":
                            ents[0].BelongDeptName = "第四监理所";
                            break;
                        case "239":
                            ents[0].BelongDeptName = "第五监理所";
                            break;
                        case "532":
                            ents[0].BelongDeptName = "其他监理分部";
                            break;
                    }
                    ents[0].Remark = dr["DESCRIPTION"] + "";
                    //DateTimeFormatInfo dtFormat = new System.GlobalizationDateTimeFormatInfo();
                    //dtFormat.ShortDatePattern = "yyyy/MM/dd";
                    //dt = Convert.ToDateTime("2012/11/26", dtFormat);
                    //yyyy-MM-dd hh:mm:ss
                    ents[0].CreateTime = Convert.ToDateTime(dr["START_DATE"]);
                    ents[0].DoUpdate();
                }
            }
            Response.Write("{success:true}");
            Response.End();
            // }
            //catch (Exception ex)
            //{
            //    Response.Write("{success:'" + ex.Message + "'}");
            //    Response.End();
            //}
        }
    }
}