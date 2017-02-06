using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Portal.Web.UI;
using Aim.Data;
using Aim;
using Aim.Portal.Model;
using System.Data;
using SP.Model;

namespace SP.Web.ProjectManage
{
    public partial class ProjectFileReport : System.Web.UI.Page
    {
        string action = string.Empty;
        string EnumID = string.Empty;
        string sql = string.Empty;
        string ParentID = string.Empty;
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
            action = Request["action"];
            EnumID = Request["id"];
            ParentID = Request["ParentID"];
            switch (action)
            {
                case "select":
                    if (!string.IsNullOrEmpty(EnumID))
                    {
                        IList<SysEnumeration> seEnts = SysEnumeration.FindAllByProperty(SysEnumeration.Prop_SortIndex, SysEnumeration.Prop_ParentID, EnumID);
                        string result = "[";
                        int i = 0;
                        string checkstr = "";
                        foreach (SysEnumeration seEnt in seEnts)
                        {
                            checkstr = seEnt.IsLeaf.Value == true ? "checked:false," : "";
                            if (i != seEnts.Count - 1)
                            {
                                result += "{id:'" + seEnt.EnumerationID + "',Name:'" + seEnt.Name + "'," + checkstr + "Value:'" + seEnt.Value + "',ParentID:'" + seEnt.ParentID + "',leaf:" + (seEnt.IsLeaf.Value ? "true" : "false") + "},";
                            }
                            else
                            {
                                result += "{id:'" + seEnt.EnumerationID + "',Name:'" + seEnt.Name + "'," + checkstr + "Value:'" + seEnt.Value + "',ParentID:'" + seEnt.ParentID + "',leaf:" + (seEnt.IsLeaf.Value ? "true" : "false") + "}";
                            }
                            i++; checkstr = "";
                        }
                        result += "]";
                        Response.Write(result);
                        Response.End();
                    }
                    break;
                case "delete":
                    SysEnumeration ent_sysenumeration = SysEnumeration.Find(EnumID);
                    SysEnumeration ent_parent = SysEnumeration.Find(ent_sysenumeration.ParentID);
                    ent_sysenumeration.DoDelete();
                    IList<SysEnumeration> ents_sysenumeration = SysEnumeration.FindAllByProperty(SysEnumeration.Prop_ParentID, ent_parent.EnumerationID);
                    if (ents_sysenumeration.Count == 0)
                    {
                        ent_parent.IsLeaf = true;
                        ent_parent.DoUpdate();
                    }
                    break;
                case "inigrid":
                    string typeids = Request["typeids"];
                    DataTable dt = new DataTable();
                    DataColumn dc = new DataColumn("Id");
                    dt.Columns.Add(dc);
                    dc = new DataColumn("ProjectName");
                    dt.Columns.Add(dc);
                    sql = "select EnumerationID Id,Name,PatIndex('%'+EnumerationID+'%','" + typeids + "') as SortIndex from SysEnumeration where '" + typeids + "' like  '%'+EnumerationID+'%' order by SortIndex asc";
                    DataTable dt_enum = DataHelper.QueryDataTable(sql);
                    foreach (DataRow dr_enum in dt_enum.Rows)
                    {
                        dc = new DataColumn(dr_enum["Id"].ToString() + dr_enum["Name"]);
                        dt.Columns.Add(dc);
                    }
                    string where = "";
                    if (!string.IsNullOrEmpty(Request["belongdept"]))
                    {
                        where += " and BelongDeptId='" + Request["belongdept"] + "'";
                    }
                    sql = "select Id,ProjectName from NCRL_SP..Project where BelongCmp='JL' " + where + " order by CreateTime desc";
                    IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
                    foreach (EasyDictionary dic in dics)
                    {
                        DataRow dr = dt.NewRow();
                        dr["Id"] = dic.Get<string>("Id");
                        dr["ProjectName"] = dic.Get<string>("ProjectName");
                        foreach (DataRow dr_enum in dt_enum.Rows)
                        {
                            IList<FileItem> fiEnts = FileItem.FindAllByProperties(FileItem.Prop_ProjectId, dic.Get<string>("Id"), FileItem.Prop_SecondTypeId, dr_enum["Id"]);
                            if (fiEnts.Count > 0)
                            {
                                dr[dr_enum["Id"].ToString() + dr_enum["Name"]] = "√";
                            }
                        }
                        dt.Rows.Add(dr);
                    }
                    Response.Write("{success:true,rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "loadgroup":
                    sql = "select GroupId id,replace(Name,'江西瑞林建设监理有限公司','') as name from SysGroup where ParentId='228' order by id asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
            }
        }
    }
}