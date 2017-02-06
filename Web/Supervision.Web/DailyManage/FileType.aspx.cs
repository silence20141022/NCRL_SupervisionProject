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

namespace SP.Web.DailyManage
{
    public partial class FileType : System.Web.UI.Page
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
                Response.Redirect("/Login.aspx");
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
                        foreach (SysEnumeration seEnt in seEnts)
                        {
                            if (i != seEnts.Count - 1)
                            {

                                result += "{id:'" + seEnt.EnumerationID + "',Name:'" + seEnt.Name + "',Code:'" + seEnt.Code + "',Value:'" + seEnt.Value + "',ParentID:'" + seEnt.ParentID + "',leaf:" + (seEnt.IsLeaf.Value ? "true" : "false") + "},";
                            }
                            else
                            {
                                result += "{id:'" + seEnt.EnumerationID + "',Name:'" + seEnt.Name + "',Code:'" + seEnt.Code + "',Value:'" + seEnt.Value + "',ParentID:'" + seEnt.ParentID + "',leaf:" + (seEnt.IsLeaf.Value ? "true" : "false") + "}";
                            }
                            i++;
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
                    //sql = @"delete sysenumeration where enumerationid='" + EnumID + "'";
                    //DataHelper.ExecSql(sql);
                    //string sql1 = "select * from sysenumeration where ParentID ='" + ParentID + "'";
                    //IList<EasyDictionary> dics = DataHelper.QueryDictList(sql1);
                    //if (dics.Count() == 0)
                    //{
                    //    sql = "update sysenumeration set ISLEAF =1 where enumerationid='" + ParentID + "'";
                    //    DataHelper.ExecSql(sql);
                    //}
                    //Response.Write("");
                    //Response.End();
                    break;

            }
        }
    }
}