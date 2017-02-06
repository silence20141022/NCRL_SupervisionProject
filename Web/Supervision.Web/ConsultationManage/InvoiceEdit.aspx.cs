using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using Aim;
using System.Data;
using Newtonsoft.Json.Linq;
using SP.Model;

namespace SP.Web.ConsultationManage
{
    public partial class InvoiceEdit : System.Web.UI.Page
    {
        string Id = "";
        string projectid = "";
        string sql = "";
        Invoice iEnt = null;
        Project pj = null;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Aim.Portal.Web.WebPortalService.CheckLogon();
            }
            catch
            {
                Response.Write("<script> window.opener.location.href = '/Login.aspx';window.close();</script>");
                Response.End();
            }
            projectid = Request["projectid"];
            Id = Request["Id"];
            string obj = "";
            string action = Request["action"];
            switch (action)
            {
                case "Create":
                    obj = Request["data"];
                    iEnt = JsonHelper.GetObject<Invoice>(obj);
                    iEnt.DoCreate();
                    string json = Request["json"];
                    IList<ShouKuan> sk = JsonHelper.GetObject<IList<ShouKuan>>(json);
                    pj = Project.Find(iEnt.ProjectId);
                    foreach (ShouKuan skEnt in sk)
                    {
                        skEnt.InvoiceId = iEnt.Id;
                        skEnt.ProjectId = iEnt.ProjectId;    //根据项目的窗口信息和窗口比例 初始化收款记录的其他信息
                        if (!string.IsNullOrEmpty(pj.DelegateInfoId))
                        {
                            skEnt.ShiJiShouFei = skEnt.ShouKuanAmount - (skEnt.ShouKuanAmount * pj.ChuangKouBiLi) / 100;
                            skEnt.ChouJinAmount = skEnt.ShiJiShouFei * (decimal)0.3;
                        }
                        skEnt.DoCreate();
                    }
                    break;
                case "Update":
                    iEnt = JsonHelper.GetObject<Invoice>(Request["data"]);
                    Invoice original_Ent = Invoice.Find(iEnt.Id);
                    EasyDictionary dic = JsonHelper.GetObject<EasyDictionary>(Request["data"]);
                    original_Ent = DataHelper.MergeData<Invoice>(original_Ent, iEnt, dic.Keys);
                    original_Ent.DoUpdate();
                    pj = Project.Find(iEnt.ProjectId);
                    IList<ShouKuan> details = ShouKuan.FindAllByProperty(ShouKuan.Prop_InvoiceId, original_Ent.Id);
                    foreach (ShouKuan skEnt in details)
                    {
                        if (!skEnt.YiFenPercent.HasValue)//项目收款没有参与分配才可执行删除操作
                        {
                            skEnt.DoDelete();
                        }
                    }
                    details = JsonHelper.GetObject<IList<ShouKuan>>(Request["json"]);
                    foreach (ShouKuan skEnt in details)
                    {
                        if (!skEnt.YiFenPercent.HasValue)//重新对未分配的收款进行创建操作
                        {
                            skEnt.InvoiceId = Id;
                            skEnt.ProjectId = original_Ent.ProjectId;
                            if (!string.IsNullOrEmpty(pj.DelegateInfoId))
                            {
                                skEnt.ShiJiShouFei = skEnt.ShouKuanAmount - (skEnt.ShouKuanAmount * pj.ChuangKouBiLi / 100);
                                skEnt.ChouJinAmount = skEnt.ShiJiShouFei * (decimal)0.3;
                            }
                            skEnt.DoCreate();
                        }
                    }
                    break;
                case "skdetail":
                    sql = "select * from NCRL_SP..ShouKuan where InvoiceId='" + Id + "'  order by ShouKuanDate asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "loadinvoice":
                    IList<EasyDictionary> dics = null;
                    if (!string.IsNullOrEmpty(Id))
                    {
                        sql = @"select a.*,b.ProjectName from NCRL_SP..Invoice a left join NCRL_SP..Project b on a.ProjectId=b.Id where a.Id='" + Id + "'";
                        dics = DataHelper.QueryDictList(sql);
                    }
                    else
                    {
                        sql = @"select Id as ProjectId, ProjectName from NCRL_SP..Project where BelongCmp='ZX' and Id='" + projectid + "'";
                        dics = DataHelper.QueryDictList(sql);
                    }
                    Response.Write("{success:true,data:" + JsonHelper.GetJsonString(dics[0]) + "}");
                    Response.End();
                    break;
            }
        }
    }
}

