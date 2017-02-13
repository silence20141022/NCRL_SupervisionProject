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

namespace SP.Web.ConsultationManage
{
    public partial class ChouJinCard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            string sql = "";
            DataTable dt = null;
            ChouJin cjEnt = null;
            ShouKuan skEnt = null;
            ChouJinDetail cjdEnt = null;
            ChouJinResult cjrEnt = null;
            string id = Request["id"];
            IList<ShouKuan> skEnts = null;
            IList<ChouJinDetail> cjdEnts = null;
            IList<ChouJinResult> cjrEnts = null;
            switch (action)
            {
                case "loadyear":
                    sql = "select value as year from NCRL_Portal..SysEnumeration where ParentId='058fbee9-0a9a-4b25-b343-ea8c05396632' order by SortIndex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "loadmonth":
                    sql = "select value as month from NCRL_Portal..SysEnumeration where ParentId='b25e537b-34e3-4437-87af-692e00facd73' order by SortIndex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "create":
                    cjEnt = JsonHelper.GetObject<ChouJin>(Request["formdata"]);
                    cjEnt.DoCreate();
                    Response.Write("{success:true,id:'" + cjEnt.Id + "'}");
                    Response.End();
                    break;
                case "update":
                    cjEnt = JsonHelper.GetObject<ChouJin>(Request["formdata"]);
                    ChouJin originalEnt = ChouJin.Find(cjEnt.Id);
                    EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(Request["formdata"]);
                    originalEnt = DataHelper.MergeData<ChouJin>(originalEnt, cjEnt, dic.Keys);
                    originalEnt.DoUpdate();
                    Response.Write("{success:true,id:'" + cjEnt.Id + "'}");
                    Response.End();
                    break;
                case "loadform":
                    cjEnt = ChouJin.Find(id);
                    Response.Write("{success:true,data:" + JsonHelper.GetJsonString(cjEnt) + "}");
                    Response.End();
                    break;
                case "loadshoukuan":
                    skEnts = ShouKuan.FindAllByProperty(ShouKuan.Prop_ShouKuanDate, ShouKuan.Prop_ChouJinId, id);
                    if (skEnts.Count == 0)
                    {
                        cjEnt = ChouJin.Find(id);
                        sql = @"select a.Id,a.ProjectId,a.InvoiceId,a.ShouKuanAmount,a.ShouKuanDate,a.ShiJiShouFei,
                        a.YiFenPercent,a.ChouJinAmount,b.ProjectName,c.InvoiceNo
                        from NCRL_SP..ShouKuan a left join NCRL_SP..Project b on a.ProjectId=b.Id
                        left join NCRL_SP..Invoice c on a.InvoiceId=c.Id
                        where YiFenPercent is null and  year(ShouKuanDate)='" + cjEnt.BelongYear + "' and month(ShouKuanDate)='" + (Convert.ToInt32(cjEnt.BelongMonth) - 1) + "' and isnull(a.Status,'')<>'已作废' order by ShouKuanDate asc";
                    }
                    else
                    {
                        sql = @"select a.Id,a.ProjectId,a.InvoiceId,a.ShouKuanAmount,a.ShouKuanDate,a.ShiJiShouFei,
                        a.YiFenPercent,a.ChouJinAmount,b.ProjectName,c.InvoiceNo
                        from NCRL_SP..ShouKuan a left join NCRL_SP..Project b on a.ProjectId=b.Id
                        left join NCRL_SP..Invoice c on a.InvoiceId=c.Id
                        where ChouJinId='" + id + "'  order by a.ShouKuanDate asc";
                    }
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "updateshoukuan":
                    string shoukuanids = Request["shoukuanids"];
                    string[] idarray = shoukuanids.Split(new string[] { "," }, StringSplitOptions.RemoveEmptyEntries);
                    foreach (string str in idarray)
                    {
                        skEnt = ShouKuan.Find(str);
                        skEnt.ChouJinId = id;
                        skEnt.DoUpdate();
                    }
                    //顺便把酬金分配明细的store构建后送到前端  为动态页面的生成提供数据基础
                    skEnts = ShouKuan.FindAllByProperty(ShouKuan.Prop_ShouKuanDate, ShouKuan.Prop_ChouJinId, id);
                    DataTable dt2 = new DataTable();
                    //构建表格列
                    // dc = new DataColumn("MajorName");
                    //dt2.Columns.Add(dc);
                    DataColumn dc = new DataColumn("UserId");
                    dt2.Columns.Add(dc);
                    dc = new DataColumn("UserName");
                    dt2.Columns.Add(dc);
                    dc = new DataColumn("StageAmount");
                    dt2.Columns.Add(dc);
                    foreach (ShouKuan tempEnt in skEnts)
                    {
                        dc = new DataColumn(tempEnt.Id + "@A");
                        dt2.Columns.Add(dc);
                        dc = new DataColumn(tempEnt.Id + "@B");
                        dt2.Columns.Add(dc);
                        dc = new DataColumn(tempEnt.Id + "@C");
                        dt2.Columns.Add(dc);
                    }   //构建表格行  先构建前面的特殊5行
                    DataRow dr1 = dt2.NewRow();
                    DataRow dr2 = dt2.NewRow();
                    DataRow dr3 = dt2.NewRow();
                    DataRow dr4 = dt2.NewRow();
                    DataRow dr5 = dt2.NewRow();
                    Project pEnt = null;
                    dr1["UserName"] = "项目收费"; dr2["UserName"] = "窗口|比例"; dr3["UserName"] = "实际收费"; dr4["UserName"] = "项目酬金"; dr5["UserName"] = "分配比例%";
                    foreach (ShouKuan tempEnt in skEnts)
                    {
                        pEnt = Project.Find(tempEnt.ProjectId);
                        dr1[tempEnt.Id + "@A"] = pEnt.ProjectName;
                        dr1[tempEnt.Id + "@C"] = tempEnt.ShouKuanAmount;//获取收款金额
                        if (!string.IsNullOrEmpty(pEnt.DelegateInfoId))
                        {
                            dr2[tempEnt.Id + "@A"] = DelegateInfo.Find(pEnt.DelegateInfoId).DelegateName;//第二行收款记录第一列显示窗口名称 第三列显示窗口比例  
                        }
                        dr2[tempEnt.Id + "@B"] = tempEnt.Id;
                        dr2[tempEnt.Id + "@C"] = pEnt.ChuangKouBiLi;//将收款记录的ID存到第二行的第三列上。便于前台获取
                        dr3[tempEnt.Id + "@C"] = tempEnt.ShiJiShouFei;//第三行收款记录第三列存显示实际收费 即收款金额-收款金额*窗口比例
                        dr4[tempEnt.Id + "@C"] = tempEnt.ChouJinAmount;
                        dr5[tempEnt.Id + "@A"] = tempEnt.YiFenPercent;
                        dr5[tempEnt.Id + "@B"] = 100;
                    }
                    dt2.Rows.Add(dr1); dt2.Rows.Add(dr2); dt2.Rows.Add(dr3); dt2.Rows.Add(dr4); dt2.Rows.Add(dr5);
                    //所有的专家
                    IList<Expert> expEnts = Expert.FindAllByProperty(Expert.Prop_SortIndex, Expert.Prop_Status, "T");
                    foreach (Expert tEnt in expEnts)
                    {
                        DataRow dr = dt2.NewRow();
                        dr["UserId"] = tEnt.Id;
                        dr["UserName"] = tEnt.UserName;
                        cjrEnts = ChouJinResult.FindAllByProperties(ChouJinResult.Prop_ChouJinId, id, ChouJinResult.Prop_ExpertId, tEnt.Id);
                        dr["StageAmount"] = cjrEnts.Count == 0 ? "" : cjrEnts[0].StageAmount + "";
                        foreach (ShouKuan shoukuanEnt in skEnts)
                        {
                            cjdEnts = ChouJinDetail.FindAllByProperties(ChouJinDetail.Prop_ChouJinId, id, ChouJinDetail.Prop_ExpertId, tEnt.Id, ChouJinDetail.Prop_ShouKuanId, shoukuanEnt.Id);
                            IList<ProjectUser> puEnts = ProjectUser.FindAllByProperties(ProjectUser.Prop_ProjectId, shoukuanEnt.ProjectId, ProjectUser.Prop_UserId, tEnt.Id);
                            dr[shoukuanEnt.Id + "@A"] = puEnts.Count > 0 ? "√" : "";
                            dr[shoukuanEnt.Id + "@B"] = cjdEnts.Count > 0 ? cjdEnts[0].ChouJinPercent : null;
                            dr[shoukuanEnt.Id + "@C"] = cjdEnts.Count > 0 ? cjdEnts[0].ChouJinAmount : null;
                        }
                        dt2.Rows.Add(dr);
                    }
                    Response.Write("{success:true,rows:" + JsonHelper.GetJsonStringFromDataTable(dt2) + "}");
                    Response.End();
                    break;
                case "savechoujindetail":
                    cjdEnts = ChouJinDetail.FindAllByProperties(ChouJinDetail.Prop_ChouJinId, id, ChouJinDetail.Prop_ExpertId, Request["expertid"], ChouJinDetail.Prop_ShouKuanId, Request["shoukuanid"]);
                    if (cjdEnts.Count == 0)
                    {
                        if (Convert.ToDecimal(Request["choujinpercent"]) > 0)
                        {
                            cjdEnt = new ChouJinDetail();
                            cjdEnt.ChouJinId = id;
                            cjdEnt.ExpertId = Request["expertid"];
                            cjdEnt.UserName = Request["username"];
                            cjdEnt.ShouKuanId = Request["shoukuanid"];
                            cjdEnt.ChouJinPercent = Convert.ToDecimal(Request["choujinpercent"]);
                            cjdEnt.ChouJinAmount = Convert.ToDecimal(Request["choujinamount"]);
                            cjdEnt.IfCanYu = Request["ifcanyu"];
                            cjdEnt.DoCreate();//酬金明细保存后，同时更新酬金结果 、收款记录的已分百分比                       
                            skEnt = ShouKuan.Find(Request["shoukuanid"]);
                            skEnt.YiFenPercent = Convert.ToDecimal(Request["yifenpercent"]);
                            skEnt.DoUpdate();
                        }
                    }
                    else
                    {
                        if (Convert.ToDecimal(Request["choujinpercent"]) > 0)
                        {
                            cjdEnt = cjdEnts[0];
                            cjdEnt.ChouJinPercent = Convert.ToDecimal(Request["choujinpercent"]);
                            cjdEnt.ChouJinAmount = Convert.ToDecimal(Request["choujinamount"]);
                            cjdEnt.IfCanYu = Request["ifcanyu"];
                            cjdEnt.DoUpdate();
                            skEnt = ShouKuan.Find(Request["shoukuanid"]);
                            skEnt.YiFenPercent = Convert.ToDecimal(Request["yifenpercent"]);
                            skEnt.DoUpdate();
                        }
                        else
                        {
                            cjdEnts[0].DoDelete();
                        }
                    }
                    cjrEnts = ChouJinResult.FindAllByProperties(ChouJinResult.Prop_ExpertId, Request["expertid"], ChouJinResult.Prop_ChouJinId, id);
                    if (cjrEnts.Count == 0)
                    {
                        cjrEnt = new ChouJinResult();
                        cjrEnt.ExpertId = Request["expertid"];
                        cjrEnt.UserName = Request["username"];
                        cjrEnt.ChouJinId = id;
                        cjrEnt.StageAmount = Convert.ToDecimal(Request["stageamount"]);
                        cjrEnt.DoCreate();
                    }
                    else
                    {
                        if (Convert.ToDecimal(Request["stageamount"]) > 0)
                        {
                            cjrEnt = cjrEnts[0];
                            cjrEnt.StageAmount = Convert.ToDecimal(Request["stageamount"]);
                            cjrEnt.DoUpdate();
                        }
                        else
                        {
                            cjrEnts[0].DoDelete();
                        }
                    }
                    break;
                case "loadchoujinresult"://默认调整金额==分配金额
                    sql = @"select a.Id as ExpertId,a.UserName,b.Remark,b.StageAmount,isnull(AdjustAmount,StageAmount) AdjustAmount from NCRL_SP..Expert a
                          left join (select * from  NCRL_SP..ChouJinResult where ChouJinId='{0}') b on a.Id=b.ExpertId";
                    sql = string.Format(sql, id);
                    dt = DataHelper.QueryDataTable(sql);
                    cjEnt = ChouJin.Find(id);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",title:'" + cjEnt.BelongYear + "年" + cjEnt.BelongMonth + "月专家酬金'}");
                    Response.End();
                    break;
                case "adjustresult":
                    cjrEnts = ChouJinResult.FindAllByProperties(ChouJinResult.Prop_ChouJinId, id, ChouJinResult.Prop_ExpertId, Request["expertid"]);
                    if (cjrEnts.Count == 0)
                    {
                        cjrEnt = new ChouJinResult();
                        cjrEnt.ExpertId = Request["expertid"];
                        cjrEnt.UserName = Request["username"];
                        cjrEnt.ChouJinId = id;
                        cjrEnt.AdjustAmount = Convert.ToDecimal(Request["adjustamount"]);
                        cjrEnt.Remark = Request["remark"];
                        cjrEnt.DoCreate();
                    }
                    else
                    {
                        cjrEnt = cjrEnts[0];
                        cjrEnt.AdjustAmount = Convert.ToDecimal(Request["adjustamount"]);
                        cjrEnt.Remark = Request["remark"];
                        cjrEnt.DoUpdate();
                    }
                    break;
                case "loadshoukuan_unfenpei":
                    sql = @"select a.Id,a.ProjectId,a.InvoiceId,a.ShouKuanAmount,a.ShouKuanDate,a.ShiJiShouFei,
                        a.YiFenPercent,a.ChouJinAmount,b.ProjectName,c.InvoiceNo from NCRL_SP..ShouKuan a                        
                        left join NCRL_SP..Project b on a.ProjectId=b.Id
                        left join NCRL_SP..Invoice c on a.InvoiceId=c.Id
                        where isnull(ChouJinId,'')='' order by a.ShouKuanDate asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
            }
        }
    }
}