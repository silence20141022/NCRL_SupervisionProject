using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Portal.Model;
using SP.Model;
using Aim.Data;
using Aim;
using System.Data;

namespace SP.Web.DailyManage
{
    public partial class GongZiEdit : System.Web.UI.Page
    {
        string id = "";
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
            IList<SalaryStage> ssEnts = null;
            SalaryStage ssEnt = null;
            Salary sEnt = null;
            DataTable datat = null;
            IList<Salary> sEnts = null;
            SalaryAdjust saEnt = null;
            string sql = "";
            id = Request["id"];
            DateTime dt = DateTime.Now;
            string salarydetail = "";
            IList<EasyDictionary> dics = null;
            switch (action)
            {
                case "savestage":
                    string year = Request["year"];
                    string month = Request["month"];
                    ssEnts = SalaryStage.FindAllByProperties(SalaryStage.Prop_Year, year, SalaryStage.Prop_Month, month);
                    if (ssEnts.Count == 0)
                    {
                        ssEnt = new SalaryStage();
                        ssEnt.Year = year;
                        ssEnt.Month = month;
                        ssEnt.CreateId = Aim.Portal.Web.WebPortalService.CurrentUserInfo.UserID;
                        ssEnt.CreateName = Aim.Portal.Web.WebPortalService.CurrentUserInfo.Name;
                        ssEnt.CreateTime = DateTime.Now;
                        ssEnt.DoCreate();
                        //  取出最近一个月的工资明细
                        dt = new DateTime(Convert.ToInt32(year), Convert.ToInt32(month), 1);
                        dt = dt.AddMonths(-1);
                        ssEnts = SalaryStage.FindAllByProperties(SalaryStage.Prop_Year, dt.Year.ToString(), SalaryStage.Prop_Month, dt.Month.ToString());
                        //  string detail = "[]";
                        if (ssEnts.Count > 0)
                        {
                            sEnts = Salary.FindAllByProperty(Salary.Prop_StageId, ssEnts[0].Id);
                            foreach (Salary tEnt in sEnts)
                            {
                                Salary tempEnt = new Salary();
                                tempEnt = tEnt;
                                tempEnt.StageId = ssEnt.Id;
                                tempEnt.DoCreate();
                            }
                        }
                        Response.Write("{Id:'" + ssEnt.Id + "'}");
                        Response.End();
                    }
                    else
                    {
                        Response.Write("{}");
                        Response.End();
                    }
                    break;
                case "update":
                    salarydetail = Request["detail"];
                    sEnt = JsonHelper.GetObject<Salary>(salarydetail);
                    if (!string.IsNullOrEmpty(sEnt.Id))
                    {
                        sEnt.DoUpdate();
                        Response.Write("{Id:'" + sEnt.Id + "',StageId:'" + sEnt.StageId + "'}");
                    }
                    else
                    {
                        sEnt.StageId = id;
                        sEnt.DoCreate();
                        Response.Write("{Id:'" + sEnt.Id + "',StageId:'" + sEnt.StageId + "'}");
                    } //每次更新的时候                   
                    ssEnt = SalaryStage.Find(id);
                    dt = new DateTime(Convert.ToInt32(ssEnt.Year), Convert.ToInt32(ssEnt.Month), 1);
                    dt = dt.AddMonths(-1);
                    ssEnts = SalaryStage.FindAllByProperties(SalaryStage.Prop_Year, dt.Year.ToString(), SalaryStage.Prop_Month, dt.Month.ToString());
                    if (ssEnts.Count > 0)
                    {
                        IList<SalaryAdjust> saEnts = SalaryAdjust.FindAllByProperties(SalaryAdjust.Prop_UserId, sEnt.UserId, SalaryAdjust.Prop_StageId, id);
                        IList<Salary> ori_sEnts = Salary.FindAllByProperties(Salary.Prop_StageId, ssEnts[0].Id, Salary.Prop_UserId, sEnt.UserId);
                        if (ori_sEnts.Count > 0)//如果上个月的工资单中有这个人
                        {
                            Salary tent = ori_sEnts[0];
                            if (sEnt.GangWeiSalary != tent.GangWeiSalary || sEnt.GangWeiBuTie != tent.GangWeiBuTie || sEnt.ZhuCeBuTie != tent.ZhuCeBuTie || sEnt.GongLingBuTie != tent.GongLingBuTie || sEnt.TeShuBuTie != tent.TeShuBuTie || sEnt.XianChangBuTie != tent.XianChangBuTie)
                            {
                                //如果有任何一个值不同，且该人员不在该阶段的调整表里面
                                if (saEnts.Count == 0)
                                {
                                    saEnt = new SalaryAdjust();
                                    saEnt.StageId = ssEnt.Id;
                                    saEnt.PreStageId = tent.StageId;
                                    saEnt.UserId = sEnt.UserId;
                                    saEnt.DoCreate();
                                }
                            }
                            else
                            {
                                sql = "delete NCRL_SP..SalaryAdjust where StageId='" + id + "' and UserId='" + sEnt.UserId + "'";
                                DataHelper.ExecSql(sql);
                            }
                        }
                        else
                        {
                            if (saEnts.Count == 0)
                            {
                                saEnt = new SalaryAdjust();
                                saEnt.StageId = ssEnt.Id;
                                //  saEnt.PreStageId = ssEnts[0].Id;//如果上个月工资表中没有这个人，该字段不赋值
                                saEnt.UserId = sEnt.UserId;
                                saEnt.DoCreate();
                            }
                        }
                    }
                    Response.End();
                    break;
                case "loadform":
                    ssEnt = SalaryStage.Find(id);
                    Response.Write("{success:true,data:" + JsonHelper.GetJsonString(ssEnt) + "}");
                    Response.End();
                    break;
                case "loaddetail":
                    if (!string.IsNullOrEmpty(id))
                    {
                        string where = "";
                        if (!string.IsNullOrEmpty(Request["UserName"]))
                        {
                            where += " and UserName like '%" + Request["UserName"] + "%'";
                        }
                        if (!string.IsNullOrEmpty(Request["DeptId"]))
                        {
                            where += " and DeptId = '" + Request["DeptId"] + "'";
                        }
                        sql = @"select a.*,b.IDNumber,(select top 1 b.Id from NCRL_SP..SalaryAdjust b where b.UserId=a.UserId and b.StageId=a.StageId ) as SalaryAdjustId
                        from NCRL_SP..Salary a                         
                        left join NCRL_Portal..SysUser b on a.UserId=b.UserId where a.StageId='" + id + "'" + where + " order by a.SortIndex asc";
                        datat = DataHelper.QueryDataTable(sql);
                        string json = "{rows:" + JsonHelper.GetJsonStringFromDataTable(datat) + "}";
                        Response.Write(json);
                        Response.End();
                    }
                    break;
                case "delete":
                    string salaryIds = Request["salaryIds"];
                    if (!string.IsNullOrEmpty(salaryIds))
                    {
                        string[] array = salaryIds.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                        foreach (string str in array)
                        {
                            sEnt = Salary.Find(str);
                            IList<SalaryAdjust> saEnts = SalaryAdjust.FindAllByProperties(SalaryAdjust.Prop_StageId, id, SalaryAdjust.Prop_UserId, sEnt.UserId);
                            if (saEnts.Count > 0)
                            {
                                saEnts[0].DoDelete();
                            }
                            sEnt.DoDelete();
                        }
                    }
                    break;
                case "updateRemark":
                    string remark = Server.HtmlDecode(Request["Remark"]);
                    ssEnt = SalaryStage.Find(id);
                    ssEnt.Remark = remark;
                    ssEnt.DoUpdate();
                    string detail = Request["detaildata"];
                    IList<Salary> temp_Ents = JsonHelper.GetObject<IList<Salary>>(Request["detaildata"]);
                    for (int i = 0; i < temp_Ents.Count; i++)
                    {
                        temp_Ents[i].SortIndex = i + 1;
                        temp_Ents[i].StageId = ssEnt.Id;
                        temp_Ents[i].DoSave();
                    }
                    Response.Write("{success:true}");
                    Response.End();
                    break;
                //                case "upsortindex":
                //                    salarydetail = Request["detail"];
                //                    sEnt = JsonHelper.GetObject<Salary>(salarydetail);
                //                    if (string.IsNullOrEmpty(sEnt.Id))
                //                    {
                //                        sEnt.StageId = id;
                //                        sEnt.DoCreate();
                //                        Response.Write(sEnt.Id);
                //                    }
                //                    sql = @"select top 1 Id from NCRL_SP..Salary where SortIndex=
                //                         (select max(SortIndex) from (select * from  NCRL_SP..Salary  where SortIndex <{0}) t )";
                //                    sql = string.Format(sql, sEnt.SortIndex);
                //                    dics = DataHelper.QueryDictList(sql);
                //                    if (dics.Count > 0)//如果有比他靠后的人员
                //                    {
                //                        Salary tempEnt = Salary.Find(dics[0].Get<string>("Id"));
                //                        int? temp = tempEnt.SortIndex;
                //                        tempEnt.SortIndex = sEnt.SortIndex;
                //                        tempEnt.DoUpdate();
                //                        sEnt.SortIndex = temp;
                //                        sEnt.DoUpdate();
                //                    }
                //                    break;
                //                case "downsortindex":
                //                    salarydetail = Request["detail"];
                //                    sEnt = JsonHelper.GetObject<Salary>(salarydetail);
                //                    if (string.IsNullOrEmpty(sEnt.Id))
                //                    {
                //                        sEnt.StageId = id;
                //                        sEnt.DoCreate();
                //                        Response.Write(sEnt.Id);
                //                    }
                //                    sql = @"select top 1 Id from NCRL_SP..Salary where SortIndex=
                //                         (select min(SortIndex)  from (select * from  NCRL_SP..Salary  where SortIndex >{0}) t )";
                //                    sql = string.Format(sql, sEnt.SortIndex);
                //                    dics = DataHelper.QueryDictList(sql);
                //                    if (dics.Count > 0)
                //                    {
                //                        Salary tempEnt = Salary.Find(dics[0].Get<string>("Id"));
                //                        int? temp = tempEnt.SortIndex;
                //                        tempEnt.SortIndex = sEnt.SortIndex;
                //                        tempEnt.DoUpdate();
                //                        sEnt.SortIndex = temp;
                //                        sEnt.DoUpdate();
                //                    }
                //                    break;
                case "loaddept":
                    sql = "select GroupID as id,replace(Name,'江西瑞林建设监理有限公司','') as name from SysGroup where ParentId='228' order by Code asc";
                    DataTable dataTable = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dataTable) + "}");
                    Response.End();
                    break;
            }
        }
    }
}