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
using Newtonsoft.Json.Linq;

namespace SP.Web.ConsultationManage
{
    public partial class ExpertList : System.Web.UI.Page
    {
        string sql = "";
        string where = "";
        int totalProperty;
        DataTable dt;
        Expert expertEnt = null;
        IList<EasyDictionary> dics = null;
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
                    DoSelect();
                    break;
                case "Delete":
                    Delete();
                    break;
                case "loadmajor":
                    sql = "select name from NCRL_Portal..SysEnumeration where ParentID = 'b640c40c-e2a9-41a8-bd28-d8ff9d71ff94' order by sortindex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    string str = JsonHelper.GetJsonString(dt);
                    Response.Write("{rows:" + str + "}");
                    Response.End();
                    break;
                case "upsortindex":
                    expertEnt = JsonHelper.GetObject<Expert>(Request["expert"]);
                    sql = @"select top 1 Id from NCRL_SP..Expert where SortIndex=
                         (select max(SortIndex) from (select * from  NCRL_SP..Expert where SortIndex <{0}) t )";
                    sql = string.Format(sql, expertEnt.SortIndex);
                    dics = DataHelper.QueryDictList(sql);
                    if (dics.Count > 0)//如果有比他靠前的领导 2比3靠前
                    {
                        Expert tempEnt = Expert.Find(dics[0].Get<string>("Id"));
                        int? temp = tempEnt.SortIndex;
                        tempEnt.SortIndex = expertEnt.SortIndex;
                        tempEnt.DoUpdate();
                        expertEnt.SortIndex = temp;
                        expertEnt.DoUpdate();
                    }
                    break;
                case "downsortindex":
                    expertEnt = JsonHelper.GetObject<Expert>(Request["expert"]);
                    sql = @"select top 1 Id from NCRL_SP..Expert where SortIndex=
                         (select min(SortIndex)  from (select * from  NCRL_SP..Expert  where SortIndex >{0}) t )";
                    sql = string.Format(sql, expertEnt.SortIndex);
                    dics = DataHelper.QueryDictList(sql);
                    if (dics.Count > 0)
                    {
                        Expert tempEnt = Expert.Find(dics[0].Get<string>("Id"));
                        int? temp = tempEnt.SortIndex;
                        tempEnt.SortIndex = expertEnt.SortIndex;
                        tempEnt.DoUpdate();
                        expertEnt.SortIndex = temp;
                        expertEnt.DoUpdate();
                    }
                    break;
                case "updatesortindex":
                    expertEnt = Expert.Find(Request["id"]);
                    expertEnt.SortIndex = Convert.ToInt32(Request["sortindex"]);
                    expertEnt.DoUpdate();
                    break;
            }

        }
        private void Delete()
        {
            string Id = Request["Id"];
            sql = "select * from NCRL_SP..ProjectUser where userid='" + Id + "'";
            dt = DataHelper.QueryDataTable(sql);
            if (dt.Rows.Count > 0)
            {
                Response.Write("{IsDelete:'false'}");
                Response.End();
                return;
            }
            sql = "delete NCRL_SP..Expert where id='" + Id + "'";
            DataHelper.ExecSql(sql);
            Response.Write("{IsDelete:'true'}");
            Response.End();
        }
        private void DoSelect()
        {
            string UserName = Request["UserName"];
            string MajorName = Request["MajorName"];
            if (!string.IsNullOrEmpty(UserName))
            {
                where += " and UserName like '%" + UserName.Trim() + "%' ";
            }
            if (!string.IsNullOrEmpty(MajorName))
            {
                where += " and MajorName like '%" + MajorName.Trim() + "%' ";
            }
            sql = @"select *,charindex(MajorName,'结构,建筑,给排水,电气(强电),自控,仪表,电信(弱电),环境卫生,暖通,桥梁,注册建筑师,道路,园林景观,绿化,燃气,动力,注册结构师,总图,其它,工艺,水工,隧道,岩土,勘察') SortIndex2 
                  from NCRL_SP..Expert where 1=1 " + where;
            dt = DataHelper.QueryDataTable(GetPageSql(sql));
            Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",total:" + totalProperty + "}");
            Response.End();
        }

        private string GetPageSql(string tempsql)
        {
            int start = Convert.ToInt32(Request["start"]);
            int limit = Convert.ToInt32(Request["limit"]);
            totalProperty = DataHelper.QueryValue<int>("select count(1) from (" + tempsql + ") t");
            string order = "SortIndex asc";
            //  string order2 = Request["sort"];//[{"property":"MajorName","direction":"ASC"}]
            if (!string.IsNullOrEmpty(Request["sort"]))
            {
                JArray jarray = JsonHelper.GetObject<JArray>(Request["sort"]);
                order = jarray[0].Value<string>("property") + " " + jarray[0].Value<string>("direction");
            }
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