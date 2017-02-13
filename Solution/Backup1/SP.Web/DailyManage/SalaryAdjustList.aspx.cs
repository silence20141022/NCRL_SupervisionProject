using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using SP.Model;
using Aim.Portal.Model;
using Aim;
namespace SP.Web.DailyManage
{
    public partial class SalaryAdjustList : System.Web.UI.Page
    {
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
            string action = Request["action"];
            string nowStage = "";
            string preStage = "";
            switch (action)
            {
                case "loadadjustdetail":
                    string stageId = Request["stageId"];
                    DataTable dt = new DataTable();
                    DataColumn dc = new DataColumn("Id");//人员工资单Id
                    dt.Columns.Add(dc);
                    dc = new DataColumn("UserName");
                    dt.Columns.Add(dc);
                    dc = new DataColumn("StageName");
                    dt.Columns.Add(dc);
                    dc = new DataColumn("Job");
                    dt.Columns.Add(dc);
                    dc = new DataColumn("JobLevel");
                    dt.Columns.Add(dc);
                    dc = new DataColumn("GangWeiSalary");
                    dt.Columns.Add(dc);
                    dc = new DataColumn("GongLingBuTie");
                    dt.Columns.Add(dc);
                    dc = new DataColumn("ZhuCeBuTie");
                    dt.Columns.Add(dc);
                    dc = new DataColumn("GangWeiBuTie");
                    dt.Columns.Add(dc);
                    dc = new DataColumn("TeShuBuTie");
                    dt.Columns.Add(dc);
                    dc = new DataColumn("XianChangBuTie");
                    dt.Columns.Add(dc);
                    dc = new DataColumn("TotalSalary");
                    dt.Columns.Add(dc);
                    SalaryStage stageEnt = SalaryStage.Find(stageId);
                    nowStage = stageEnt.Year + "年" + stageEnt.Month + "月";
                    IList<SalaryAdjust> saEnts = SalaryAdjust.FindAllByProperty(SalaryAdjust.Prop_StageId, stageId);
                    foreach (SalaryAdjust saEnt in saEnts)
                    {
                        if (!string.IsNullOrEmpty(saEnt.PreStageId))
                        {
                            stageEnt = SalaryStage.Find(saEnt.PreStageId);
                            preStage = stageEnt.Year + "年" + stageEnt.Month + "月";
                        }
                        DataRow dr = dt.NewRow();
                        IList<Salary> sEnts = null;
                        if (!string.IsNullOrEmpty(saEnt.PreStageId))
                        {
                            sEnts = Salary.FindAllByProperties(Salary.Prop_StageId, saEnt.PreStageId, Salary.Prop_UserId, saEnt.UserId);
                            if (saEnts.Count > 0)
                            {
                                dr["Id"] = sEnts[0].Id;
                                dr["UserName"] = sEnts[0].UserName;
                                dr["StageName"] = preStage;
                                dr["Job"] = sEnts[0].Job;
                                dr["JobLevel"] = sEnts[0].JobLevel;
                                dr["GangWeiSalary"] = sEnts[0].GangWeiSalary;
                                dr["GongLingBuTie"] = sEnts[0].GongLingBuTie;
                                dr["ZhuCeBuTie"] = sEnts[0].ZhuCeBuTie;
                                dr["GangWeiBuTie"] = sEnts[0].GangWeiBuTie;
                                dr["TeShuBuTie"] = sEnts[0].TeShuBuTie;
                                dr["XianChangBuTie"] = sEnts[0].XianChangBuTie;
                                dr["TotalSalary"] = sEnts[0].TotalSalary;
                            }
                        }
                        else
                        {
                            dr["UserName"] = SysUser.Find(saEnt.UserId).Name;
                        }
                        dt.Rows.Add(dr);
                        dr = dt.NewRow();
                        sEnts = Salary.FindAllByProperties(Salary.Prop_StageId, saEnt.StageId, Salary.Prop_UserId, saEnt.UserId);
                        if (saEnts.Count > 0)
                        {
                            dr["Id"] = sEnts[0].Id;
                            //dr["UserName"] = sEnts[0].UserName;
                            dr["StageName"] = nowStage;
                            dr["Job"] = sEnts[0].Job;
                            dr["JobLevel"] = sEnts[0].JobLevel;
                            dr["GangWeiSalary"] = sEnts[0].GangWeiSalary;
                            dr["GongLingBuTie"] = sEnts[0].GongLingBuTie;
                            dr["ZhuCeBuTie"] = sEnts[0].ZhuCeBuTie;
                            dr["GangWeiBuTie"] = sEnts[0].GangWeiBuTie;
                            dr["TeShuBuTie"] = sEnts[0].TeShuBuTie;
                            dr["XianChangBuTie"] = sEnts[0].XianChangBuTie;
                            dr["TotalSalary"] = sEnts[0].TotalSalary;
                        }
                        dt.Rows.Add(dr);
                    }
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",StageName:'" + nowStage + "'}");
                    Response.End();
                    break;
            }
        }
    }
}