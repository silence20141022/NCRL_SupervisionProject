using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using Aim.Portal.Model;
using Aim.Security;
using Aim.Data;
using System.Data.SqlClient;
using Aim;
using Newtonsoft.Json.Linq;
using Oracle.DataAccess.Client;

namespace SP.Web.DailyManage
{
    public partial class GroupUser : System.Web.UI.Page
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
            SysGroup sgEnt = null;
            SysUser suEnt = null;
            IList<SysUser> suEnts = null;
            string sql = "";
            DataTable dt = null;
            string where = "";
            MD5Encrypt encrypt = new MD5Encrypt();
            switch (action)
            {
                case "sync":
                    string connstr = ConfigurationManager.ConnectionStrings["NimsConn"].ToString();
                    OracleConnection conn = new OracleConnection(connstr);
                    sql = "select * from apps.cux_hr_org_structrue_v where ORG_ID_CHILD='228' or org_id_parent='228'";
                    OracleCommand com = new OracleCommand(sql, conn);
                    OracleDataAdapter da = new OracleDataAdapter(com);
                    DataSet ds = new DataSet();
                    da.Fill(ds);
                    //首先同步部门信息
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        sgEnt = SysGroup.TryFind(dr["ORG_ID_CHILD"] + "");
                        if (sgEnt == null)//如果不存在该部门
                        {
                            //此处将PATH字段用来存储父部门的名称                            
                            sql = "insert into SysGroup (GroupID,Name,Code,ParentID,Path,Status) values('{0}','{1}','{2}','{3}','{4}',1)";
                            sql = string.Format(sql, dr["ORG_ID_CHILD"], dr["ORG_NAME_CHILD"], dr["ORG_CODE_CHILD"], dr["ORG_ID_PARENT"], dr["ORG_NAME_PARENT"]);
                            DataHelper.ExecSql(sql);
                        }
                        else
                        {
                            sql = "update SysGroup set Name='{0}',Code='{1}',ParentID='{2}',Path='{3}' where GroupID='{4}'";
                            sql = string.Format(sql, dr["ORG_NAME_CHILD"], dr["ORG_CODE_CHILD"], dr["ORG_ID_PARENT"], dr["ORG_NAME_PARENT"], dr["ORG_ID_CHILD"]);
                            DataHelper.ExecSql(sql);
                        }
                    }
                    //同步人员信息
                    sql = @"select * from apps.cux_hr_employee_v where ORG_ID in 
                    (select ORG_ID_CHILD from apps.cux_hr_org_structrue_v where ORG_ID_CHILD='228' or org_id_parent='228') and primary_flag='Y'";
                    com = new OracleCommand(sql, conn);
                    da = new OracleDataAdapter(com);
                    ds = new DataSet();
                    da.Fill(ds);
                    SqlConnection conn_sql = new SqlConnection();
                    conn_sql.ConnectionString = ConfigurationManager.AppSettings["Con_Portal"];
                    conn_sql.Open();
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        suEnts = SysUser.FindAllByProperty(SysUser.Prop_IDNumber, dr["NATIONAL_IDENTIFIER"]);//通过身份证就行匹配
                        if (suEnts.Count == 0)
                        {
                            sql = @"insert into SysUser (UserID,LoginName,Name,Password,Email,Phone,HomePhone,Sex,IDNumber,Server_IAGUID,Server_Seed,Status,CreateDate)
                            values(@UserID,@LoginName,@Name,@Password,@Email,@Phone,@HomePhone,@Sex,@IDNumber,@Server_IAGUID,@Server_Seed,@Status,@CreateDate)";
                            SqlParameter[] sparray = new SqlParameter[13];
                            sparray[0] = new SqlParameter("@UserID", dr["PERSON_ID"]);
                            sparray[1] = new SqlParameter("@LoginName", dr["EMP_NUM"]);//NIMS数据库工号是不能为空的 即进入的NIMS系统的员工工号是肯定有的
                            sparray[2] = new SqlParameter("@Name", dr["LAST_NAME"]);
                            sparray[3] = new SqlParameter("@Password", encrypt.GetMD5FromString(dr["SYS_ACCOUNT"].ToString()));
                            sparray[4] = new SqlParameter("@Email", dr["EMAIL_ADDRESS"]);
                            sparray[5] = new SqlParameter("@Phone", dr["MOBILE_PHONE_NUMBER"]);
                            sparray[6] = new SqlParameter("@HomePhone", dr["OFFICE_PHONE_NUMBER"]);
                            sparray[7] = new SqlParameter("@Sex", dr["SEX"]);
                            sparray[8] = new SqlParameter("@IDNumber", dr["NATIONAL_IDENTIFIER"]);
                            sparray[9] = new SqlParameter("@Server_IAGUID", dr["ORG_ID"]);
                            sparray[10] = new SqlParameter("@Server_Seed", dr["ORG_NAME"]);
                            sparray[11] = new SqlParameter("@Status", SqlDbType.TinyInt);
                            sparray[11].Value = 1;
                            sparray[12] = new SqlParameter("@CreateDate", dr["HIRE_DATE"]);
                            SqlCommand com_sql = new SqlCommand(sql, conn_sql);
                            com_sql.Parameters.AddRange(sparray);
                            com_sql.ExecuteNonQuery();
                        }
                        else
                        {
                            sql = @"update SysUser set LoginName=@LoginName,Name=@Name,Email=@Email,Phone=@Phone,HomePhone=@HomePhone,
                            Sex=@Sex,Server_IAGUID=@Server_IAGUID,Server_Seed=@Server_Seed,CreateDate=@CreateDate where IDNumber=@IDNumber";
                            SqlParameter[] sparray = new SqlParameter[10];
                            sparray[0] = new SqlParameter("@LoginName", dr["EMP_NUM"]);
                            sparray[1] = new SqlParameter("@Name", dr["LAST_NAME"]);
                            sparray[2] = new SqlParameter("@Email", dr["EMAIL_ADDRESS"]);
                            sparray[3] = new SqlParameter("@Phone", dr["MOBILE_PHONE_NUMBER"]);
                            sparray[4] = new SqlParameter("@HomePhone", dr["OFFICE_PHONE_NUMBER"]);
                            sparray[5] = new SqlParameter("@Sex", dr["SEX"]);
                            sparray[6] = new SqlParameter("@Server_IAGUID", dr["ORG_ID"]);
                            sparray[7] = new SqlParameter("@Server_Seed", dr["ORG_NAME"]);
                            sparray[8] = new SqlParameter("@CreateDate", dr["HIRE_DATE"]);
                            sparray[9] = new SqlParameter("@IDNumber", dr["NATIONAL_IDENTIFIER"]);
                            SqlCommand com_sql = new SqlCommand(sql, conn_sql);
                            com_sql.Parameters.AddRange(sparray);
                            com_sql.ExecuteNonQuery();
                        }
                    }
                    conn_sql.Close();
                    Response.Write("{success:true}");
                    Response.End();
                    break;
                case "inipsd":
                    suEnt = SysUser.Find(Request["UserId"]);
                    suEnt.Password = encrypt.GetMD5FromString(suEnt.LoginName);
                    suEnt.DoUpdate();
                    Response.Write("{success:true}");
                    Response.End();
                    break;
                case "loadtreedata":
                    string id = Request["id"];
                    sql = "select GroupID as id,replace(Name,'江西瑞林建设监理有限公司','') as name,1 as leaf from SysGroup where ParentId='" + id + "' order by Code asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write(JsonHelper.GetJsonStringFromDataTable(dt));
                    Response.End();
                    break;
                case "loaduser":
                    string groupid = Request["groupid"];
                    if (!string.IsNullOrEmpty(Request["name_workno"]))
                    {
                        where += " and (LoginName like '%" + Request["name_workno"] + "%' or Name like '%" + Request["name_workno"] + "%')";
                    }
                    if (!string.IsNullOrEmpty(Request["UserType"]))
                    {
                        where += "  and UserType='" + Request["UserType"] + "'";
                    }
                    if (!string.IsNullOrEmpty(Request["Status"]))
                    {
                        where += "  and Status='" + Request["Status"] + "'";
                    }
                    if (string.IsNullOrEmpty(groupid) || groupid == "228")
                    {
                        sql = @"select UserID as UserId,Name,LoginName,Sex,Phone,Replace(Server_Seed,'江西瑞林建设监理有限公司','') as  Server_Seed,
                        HomePhone,IDNumber,CreateDate from SysUser where 
                        (Server_Seed like '%江西瑞林建设监理有限公司%' ) " + where;
                    }
                    else
                    {
                        sql = @"select UserID as UserId,Name,LoginName,Sex,Phone,Replace(Server_Seed,'江西瑞林建设监理有限公司','') as  Server_Seed,
                        HomePhone,IDNumber,CreateDate from SysUser
                        where Server_Seed like '%江西瑞林建设监理有限公司%' and Server_IAGUID='" + groupid + "'" + where;
                    }
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{'rows':" + JsonHelper.GetJsonStringFromDataTable(dt) + ",total:'" + totalProperty + "'}");
                    Response.End();
                    break;
            }
        }
        private string GetPageSql(string tempsql)
        {
            int start = Convert.ToInt32(Request["start"]);
            int limit = Convert.ToInt32(Request["limit"]);
            totalProperty = DataHelper.QueryValue<int>("select count(1) from (" + tempsql + ") t");
            string order = "CreateDate";
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