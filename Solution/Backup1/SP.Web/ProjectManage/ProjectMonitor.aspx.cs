using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Portal.Model;
using Aim.Data;
using System.Data;
using Aim;

namespace SP.Web.ProjectManage
{
    public partial class ProjectMonitor : System.Web.UI.Page
    {
        string sql = "";
        DataTable dt;
        string where = "";
        int count;
        int[] arr = new int[32];
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            switch (action)
            {
                case "loadFileType":
                    LoadFileType();
                    break;
                case "async":
                    Async();
                    break;
                case "select":
                    Select();
                    break;
            }
        }
        private void Select()
        {
            string rtn = "{";
            string date1 = "";
            string Years1 = "";
            string Years = Request["Years"];
            if (!string.IsNullOrEmpty(Years))
            {
                Years = Years.Substring(0, 7);
                for (int i = 1; i < 32; i++)
                {
                    if (i < 10)
                    {
                        Years1 = Years + "-0" + i;
                        where = "and CONVERT(varchar(10), createtime,120)='" + Years1 + "'";
                    }
                    else
                    {
                        Years1 = Years + "-" + i;
                        where = "and CONVERT(varchar(10), createtime,120)= '" + Years1 + "'";
                    }
                    sql = "select count(Id) as day" + i + "  from Fileitem where 1=1 " + where;
                    count = DataHelper.QueryValue<int>(sql);
                    if (i == 31)
                    {
                        rtn += "day" + i + ":" + count;
                    }
                    else
                    {
                        rtn += "day" + i + ":" + count + ",";
                    }
                }
            }
            else
            {
                string date = DateTime.Now.ToString().Substring(0, 7);

                for (int i = 1; i < 32; i++)
                {
                    if (i < 10)
                    {
                        date1 = date + "-0" + i;
                        where = "and CONVERT(varchar(10), createtime,120)='" + date1.Replace("/", "-") + "'";
                    }
                    else
                    {
                        date1 = date + "-" + i;
                        where = "and CONVERT(varchar(10), createtime,120)= '" + date1.Replace("/", "-") + "'";
                    }
                    sql = "select count(Id) as day" + i + "  from Fileitem where 1=1 " + where;
                    count = DataHelper.QueryValue<int>(sql);
                    if (i == 31)
                    {
                        rtn += "day" + i + ":" + count;
                    }
                    else
                    {
                        rtn += "day" + i + ":" + count + ",";
                    }
                }

            }
            rtn += "}";
            Response.Write("{count:" + rtn + "}");
            Response.End();
        }
        private void Async()
        {
            string FileTypeId = Request["FileTypeId"];
            string Years = Request["Years"];
            string ProjectName = Request["ProjectName"];
            string State = Request["State"];
            if (!string.IsNullOrEmpty(Years))
            {
                where += "and CONVERT(varchar(7), createtime,120)> '" + Years.Substring(0, 7) + "'";
            }
            string child = "select ProjectId from Fileitem where secondtypeid='" + FileTypeId + "' " + where;
            string child1 = "select count(ProjectId) from Fileitem where secondtypeid='" + FileTypeId + "' " + where;
            sql = "select count(Id) as undone ,(" + child1 + ") as finished  from NCRL_SP..Project where BelongCmp='JL' and Id not in(" + child + ") and  Status !='已完成' or Status is null";
            dt = DataHelper.QueryDataTable(sql);
            DataTable dt1;
            if (State.Equals("已上传"))
            {
                sql = "select  ProjectName, PManagerName,Remark,CreateTime  from NCRL_SP..Project where BelongCmp='JL' and Id  in(" + child + ") ";
                dt1 = DataHelper.QueryDataTable(GetPageSql(sql));
            }
            else
            {
                sql = "select  ProjectName, PManagerName,Remark,CreateTime  from NCRL_SP..Project where BelongCmp='JL' and Id not in(" + child + ") and  Status !='已完成' or Status is null";
                dt1 = DataHelper.QueryDataTable(GetPageSql(sql));

            }
            Response.Write("{success:true,rows:" + JsonHelper.GetJsonString(dt1) + ",str:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
            Response.End();
        }


        private void LoadFileType()
        {
            string EnumID = Request["id"];
            if (!string.IsNullOrEmpty(EnumID))
            {
                IList<SysEnumeration> seEnts = SysEnumeration.FindAllByProperty(SysEnumeration.Prop_SortIndex, SysEnumeration.Prop_ParentID, EnumID);
                string result = "[";
                int i = 0;
                foreach (SysEnumeration seEnt in seEnts)
                {
                    if (i != seEnts.Count - 1)
                    {

                        result += "{id:'" + seEnt.EnumerationID + "',Name:'" + seEnt.Name + "',leaf:" + (seEnt.IsLeaf.Value ? "true" : "false") + "},";
                    }
                    else
                    {
                        result += "{id:'" + seEnt.EnumerationID + "',Name:'" + seEnt.Name + "',leaf:" + (seEnt.IsLeaf.Value ? "true" : "false") + "}";
                    }
                    i++;
                }
                result += "]";
                Response.Write(result);
                Response.End();
            }
        }
        private string GetPageSql(string tempsql)
        {

            //  totalProperty = DataHelper.QueryValue<int>("select count(1) from (" + tempsql + ") t");
            string order = "CREATETIME";
            string asc = " desc";
            string pageSql = @"
		    WITH OrderedOrders AS
		    (SELECT *,
		    ROW_NUMBER() OVER (order by {0} {1})as RowNumber
		    FROM ({2}) temp ) 
		    SELECT * 
		    FROM OrderedOrders ";
            pageSql = string.Format(pageSql, order, asc, tempsql);
            return pageSql;
        }
    }
}