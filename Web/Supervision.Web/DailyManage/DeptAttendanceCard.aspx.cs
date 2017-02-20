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
using Newtonsoft.Json.Linq;

namespace SP.Web.DailyManage
{
    public partial class DeptAttendanceCard : System.Web.UI.Page
    {
        int totalProperty = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            string id = Request["id"];
            string userid = Request["userid"];
            string sql = "";
            DataTable dt = null;
            DeptAttendance daEnt = null;
            ProjectAttendanceDetail padEnt = null;
            DateTime dt_cur = new DateTime();
            DateTime dt_pre = new DateTime();
            IList<EasyDictionary> dics_padetail = null;
            if (!string.IsNullOrEmpty(id))
            {
                daEnt = DeptAttendance.Find(id);
            }
            switch (action)
            {
                case "loaddept":
                    sql = @"select GroupId as BelongDeptId,REPLACE(Name,'江西瑞林建设监理有限公司','') as BelongDeptName from SysGroup  where GroupId!=228 and GroupId!=267";
                    dt = DataHelper.QueryDataTable(sql);
                    string data_dept = JsonHelper.GetJsonString(dt);
                    sql = "select value as year from NCRL_Portal..SysEnumeration where ParentId='058fbee9-0a9a-4b25-b343-ea8c05396632' order by SortIndex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    string data_year = JsonHelper.GetJsonString(dt);
                    sql = "select value as month from NCRL_Portal..SysEnumeration where ParentId='b25e537b-34e3-4437-87af-692e00facd73' order by SortIndex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    string data_month = JsonHelper.GetJsonString(dt);
                    Response.Write("{'rows':" + data_dept + ", year: " + data_year + ", month: " + data_month + "}");
                    Response.End();
                    break;
                case "save":
                    daEnt = JsonHelper.GetObject<DeptAttendance>(Request["formdata"]);
                    if (string.IsNullOrEmpty(daEnt.Id))
                    {
                        daEnt.CreateTime = DateTime.Now;
                        daEnt.DoCreate();
                    }
                    else
                    {
                        daEnt = JsonHelper.GetObject<DeptAttendance>(Request["formdata"]);
                        DeptAttendance originalEnt = DeptAttendance.Find(daEnt.Id);
                        EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(Request["formdata"]);
                        originalEnt = DataHelper.MergeData<DeptAttendance>(originalEnt, daEnt, dic.Keys);
                        originalEnt.DoUpdate();
                    }
                    //string where = "";
                    //if (!string.IsNullOrEmpty(Request["ProjectName"]))
                    //{
                    //    where += " and ProjectName like '%" + Request["ProjectName"] + "%')";
                    //}
                    //if (!string.IsNullOrEmpty(Request["UserName"]))
                    //{
                    //    where += " and UserName like '%" + Request["UserName"] + "%'";
                    //}
                    sql = @"select a.* from NCRL_SP..MonAttendance a  left join NCRL_Portal..SysUser b on a.UserId=b.UserId
                    where a.Month='{0}' and a.Year='{1}' and b.Server_IAGUID='" + daEnt.BelongDeptId + "' order by a.ProjectNames asc";
                    sql = string.Format(sql, daEnt.Month, daEnt.Year);
                    dt = DataHelper.QueryDataTable(sql);
                    string title = daEnt.BelongDeptName + daEnt.Year + "年" + daEnt.Month + "月考勤表";
                    int runyear = 0;
                    if ((daEnt.Year % 4 == 0 && daEnt.Year % 100 != 0) || daEnt.Year % 400 == 0)
                    {
                        runyear = 1;
                    }
                    Response.Write("{success:true,month:'" + daEnt.Month + "',runyear:" + runyear + ",id:'" + daEnt.Id + "',title:'" + title + "',detail:" + JsonHelper.GetJsonString(dt) + "}");
                    Response.End();
                    break;
                case "loadform":
                    daEnt = DeptAttendance.Find(id);
                    Response.Write("{success:true,data:" + JsonHelper.GetJsonString(daEnt) + "}");
                    Response.End();
                    break;
                case "search":
                    daEnt = DeptAttendance.Find(id);
                    string where = "";
                    if (!string.IsNullOrEmpty(Request["ProjectName"]))
                    {
                        where += " and ProjectNames like '%" + Request["ProjectName"] + "%'";
                    }
                    if (!string.IsNullOrEmpty(Request["UserName"]))
                    {
                        where += " and UserName like '%" + Request["UserName"] + "%'";
                    }
                    sql = @"select a.* from NCRL_SP..MonAttendance a  left join NCRL_Portal..SysUser b on a.UserId=b.UserId
                    where a.Month='{0}' and a.Year='{1}' and b.Server_IAGUID='" + daEnt.BelongDeptId + "' " + where + " order by a.ProjectNames asc";
                    sql = string.Format(sql, daEnt.Month, daEnt.Year);
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{success:true,rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "updatedetail":
                    string result = Request["SignType"];
                    daEnt = DeptAttendance.Find(id); 
                    sql = @"select * from NCRL_SP..MonAttendance where UserId='{0}' and Year='{1}' and Month='{2}'";
                    sql = string.Format(sql, Request["UserId"], daEnt.Year, daEnt.Month);
                    dt = DataHelper.QueryDataTable(sql);
                    if (dt.Rows.Count == 0)
                    {
                        sql = "insert into NCRL_SP..MonAttendance (Id,UserId,UserName,Year,Month," + Request["day"] + ") values('" + Guid.NewGuid() + "','" + Request["UserId"] + "','" + Request["UserName"] + "','" + daEnt.Year + "','" + daEnt.Month + "','" + Request["SignType"] + "')";
                    }
                    else
                    {
                        //如果先前同一个字段标记的是正常上班，再次点正常上班时，清空该字段
                        if (dt.Rows[0][Request["day"]] + "" == Request["SignType"])
                        {
                            sql = "update NCRL_SP..MonAttendance set " + Request["day"] + "=null where Id='" + dt.Rows[0]["Id"] + "'";
                            result = "";
                        }
                        else
                        {
                            sql = "update NCRL_SP..MonAttendance set " + Request["day"] + "='" + Request["SignType"] + "' where Id='" + dt.Rows[0]["Id"] + "'";
                            result = Request["SignType"];
                        }
                    }
                    DataHelper.ExecSql(sql); 
                    Response.Write("{success:true,result:'" + result + "'}");
                    Response.End();
                    break;
                case "delete":
                    sql = "delete NCRL_SP..ProjectAttendanceDetail where UserId='{0}' and ProjectAttendanceId='{1}' ";
                    sql = string.Format(sql, userid, id);
                    DataHelper.ExecSql(sql);
                    break;
            }
        }
        private string GetPageSql(string tempsql)
        {
            int start = Convert.ToInt32(Request["start"]);
            int limit = Convert.ToInt32(Request["limit"]);
            totalProperty = DataHelper.QueryValue<int>("select count(1) from (" + tempsql + ") t");
            string order = "UserId";
            string asc = " asc";
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