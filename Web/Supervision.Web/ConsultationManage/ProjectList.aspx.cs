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
using Aspose.Words;
using System.Net;
using System.IO;
using System.Reflection;
using Aim.Portal.Model;
using System.Configuration;

namespace SP.Web.ConsultationManage
{
    public partial class ProjectList : System.Web.UI.Page
    {
        DataTable dt;
        int totalProperty;
        string where = "";
        Project pEnt = null;
        string sql = "";
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
            string templatepath = ConfigurationManager.AppSettings["TemplatePath"].ToString();
            string action = Request["action"];
            string id = Request["id"];
            Document srcDoc = null;
            BookmarkCollection marks = null;
            IList<EasyDictionary> dics = null;
            string filename = "";
            if (!string.IsNullOrEmpty(id))
            {
                pEnt = Project.Find(id);
            }
            switch (action)
            {
                case "loadproject":
                    string ProjectName = Request["ProjectName"];
                    if (!string.IsNullOrEmpty(ProjectName))
                    {
                        where = "and ProjectName like '%" + ProjectName + "%' ";
                    }
                    sql = @"select * from NCRL_SP..Project where BelongCmp = 'ZX' " + where;
                    dt = DataHelper.QueryDataTable(GetPageSql(sql));
                    Response.Write("{rows:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",total:" + totalProperty + "}");
                    Response.End();
                    break;
                case "delete":
                    Delete();
                    break;
                case "Recycle":
                    Recycle();
                    break;
                case "loadexportfile":
                    sql = "select Id,Name,CreateTime from FileItem where ProjectId='" + id + "' and Path='导出' order by CreateTime asc";
                    dt = DataHelper.QueryDataTable(sql);
                    Response.Write("{innerrows:" + JsonHelper.GetJsonStringFromDataTable(dt) + "}");
                    Response.End();
                    break;
                case "export_opinioncover"://意见封面
                    try
                    {
                        srcDoc = new Document(templatepath + "审查意见封面.doc");
                        marks = srcDoc.Range.Bookmarks;
                        for (int j = 0; j < marks.Count; j++)
                        {
                            Bookmark mark = marks[j];
                            if (ContainProperty(pEnt, mark.Name))
                            {
                                mark.Text = pEnt.GetValue(mark.Name) + "";
                            }
                        }
                        filename = pEnt.ProjectName.Replace("#", "") + "_审查意见封面.doc";
                        srcDoc.Save(@"D:\RW\Files\AppFiles\Portal\Default\" + filename);
                        UpdateFileItem(filename);
                        Response.Write("{success:true}");
                    }
                    catch
                    {
                        Response.Write("{success:false}");
                    }
                    Response.End();
                    break;
                case "exporthegeshu":
                    srcDoc = new Document(templatepath + "审查合格书_市政工程_房屋建筑.doc");
                    marks = srcDoc.Range.Bookmarks;
                    for (int j = 0; j < marks.Count; j++)
                    {
                        Bookmark mark = marks[j];
                        if (ContainProperty(pEnt, mark.Name))
                        {
                            mark.Text = pEnt.GetValue(mark.Name) + "";
                        }
                    }
                    sql = @"select a.MajorName,(select top 1 SortIndex from SysEnumeration where ParentId='b640c40c-e2a9-41a8-bd28-d8ff9d71ff94' and Name=a.MajorName) as SortIndex
                                 from NCRL_SP..ProjectUser a where a.ProjectId='" + pEnt.Id + "' order by SortIndex asc";
                    dics = DataHelper.QueryDictList(sql);
                    int i = 1;
                    foreach (EasyDictionary dic in dics)
                    {
                        if (dic.Get<string>("MajorName") != "勘察")
                        {
                            if (marks["Major" + i] != null)
                            {
                                marks["Major" + i].Text = dic.Get<string>("MajorName");
                            }
                            i++;
                        }
                    }
                    filename = pEnt.ProjectName.Replace("#", "") + "_审查合格书.doc";
                    srcDoc.Save(@"D:\RW\Files\AppFiles\Portal\Default\" + filename);
                    UpdateFileItem(filename);
                    break;
                case "export_beiandengjibiao":
                    try
                    {
                        srcDoc = new Document(templatepath + "附件10施工图设计文件审查备案登记表.doc");
                        marks = srcDoc.Range.Bookmarks;
                        for (int j = 0; j < marks.Count; j++)
                        {
                            Bookmark mark = marks[j];
                            if (ContainProperty(pEnt, mark.Name))
                            {
                                mark.Text = pEnt.GetValue(mark.Name) + "";
                            }
                        }
                        if (marks["Layer"] != null)
                        {
                            marks["Layer"].Text = "地上层数:" + pEnt.UpperLayers + (string.IsNullOrEmpty(pEnt.DownLayers) ? "" : "地下层数:" + pEnt.DownLayers);
                        }
                        if (marks["KanChaIfBeiAn"] != null)
                        {
                            marks["KanChaIfBeiAn"].Text = string.IsNullOrEmpty(pEnt.KanChaUnitBeiAnNo) ? "否" : "是";
                        }
                        if (marks["SheJiIfBeiAn"] != null)
                        {
                            marks["SheJiIfBeiAn"].Text = string.IsNullOrEmpty(pEnt.SheJiUnitBeiAnNo) ? "否" : "是";
                        }
                        sql = @"select a.*,(select top 1 SortIndex from NCRL_Portal..SysEnumeration where Name=a.MajorName and ParentId='b640c40c-e2a9-41a8-bd28-d8ff9d71ff94') as SortIndex
                        from NCRL_SP..KanChaSheJi a where a.ProjectId='" + pEnt.Id + "' order by SortIndex asc";
                        dics = DataHelper.QueryDictList(sql);//勘察设计人员
                        int index = 1;
                        foreach (EasyDictionary dic in dics)
                        {
                            if (dic.Get<string>("Position") == "注册土木工程师(岩土)")
                            {
                                if (marks["ZhuCeYanTuName"] != null)
                                {
                                    marks["ZhuCeYanTuName"].Text = dic.Get<string>("UserName");
                                }
                                if (marks["ZhuCeYanTuSealNo"] != null)
                                {
                                    marks["ZhuCeYanTuSealNo"].Text = dic.Get<string>("SealNo");
                                }
                                if (marks["ZhuCeYanTuShenFenZheng"] != null)
                                {
                                    marks["ZhuCeYanTuShenFenZheng"].Text = dic.Get<string>("ShenFenZhengNo");
                                }
                            }
                            else if (dic.Get<string>("Position") == "一级注册建筑师")
                            {
                                if (marks["ZhuCeJianZaoShiName"] != null)
                                {
                                    marks["ZhuCeJianZaoShiName"].Text = dic.Get<string>("UserName");
                                }
                                if (marks["ZhuCeJianZaoShiSealNo"] != null)
                                {
                                    marks["ZhuCeJianZaoShiSealNo"].Text = dic.Get<string>("SealNo");
                                }
                                if (marks["ZhuCeJianZaoShiShenFenZheng"] != null)
                                {
                                    marks["ZhuCeJianZaoShiShenFenZheng"].Text = dic.Get<string>("ShenFenZhengNo");
                                }
                            }
                            else if (dic.Get<string>("Position") == "一级注册结构师")
                            {
                                if (marks["ZhuCeJieGouShiName"] != null)
                                {
                                    marks["ZhuCeJieGouShiName"].Text = dic.Get<string>("UserName");
                                }
                                if (marks["ZhuCeJieGouShiSealNo"] != null)
                                {
                                    marks["ZhuCeJieGouShiSealNo"].Text = dic.Get<string>("SealNo");
                                }
                                if (marks["ZhuCeJieGouShiShenFenZheng"] != null)
                                {
                                    marks["ZhuCeJieGouShiShenFenZheng"].Text = dic.Get<string>("ShenFenZhengNo");
                                }
                            }
                            else
                            {
                                if (marks["SheJi_MajorName" + index] != null)
                                {
                                    marks["SheJi_MajorName" + index].Text = dic.Get<string>("MajorName");
                                }
                                if (marks["SheJi_UserName" + index] != null)
                                {
                                    marks["SheJi_UserName" + index].Text = dic.Get<string>("UserName");
                                }
                                index++;
                            }
                        }
                        sql = @"select a.*,(select top 1 SortIndex from NCRL_Portal..SysEnumeration where Name=a.MajorName and ParentId='b640c40c-e2a9-41a8-bd28-d8ff9d71ff94') as SortIndex
                        ,b.StampNo as QianZhangStampNo,c.StampNo as ShenHeStampNo  from NCRL_SP..ProjectUser a 
                        left join NCRL_SP..Expert b on b.Id=a.QianZhangId 
                        left join NCRL_SP..Expert c on c.Id=a.ShenHeId where a.ProjectId='" + pEnt.Id + "' order by SortIndex asc";
                        dics = DataHelper.QueryDictList(sql);
                        index = 1;
                        foreach (EasyDictionary dic in dics)
                        {
                            if (marks["ShenTu_MajorName" + index] != null)
                            {
                                marks["ShenTu_MajorName" + index].Text = dic.Get<string>("MajorName");
                            }
                            if (marks["ShenTu_UserName" + index] != null)
                            {
                                marks["ShenTu_UserName" + index].Text = dic.Get<string>("QianZhangName");
                            }
                            if (marks["ShenTu_SealNo" + index] != null)
                            {
                                marks["ShenTu_SealNo" + index].Text = dic.Get<string>("QianZhangStampNo");
                            }
                            if (marks["FuHe_UserName" + index] != null)
                            {
                                marks["FuHe_UserName" + index].Text = dic.Get<string>("ShenHeName");
                            }
                            if (marks["FuHe_SealNo" + index] != null)
                            {
                                marks["FuHe_SealNo" + index].Text = dic.Get<string>("ShenHeStampNo");
                            }
                            index++;
                        }
                        //写入备案登记表信息
                        IList<BeiAn_Project> bapEnts = BeiAn_Project.FindAllByProperty(BeiAn_Project.Prop_ProjectId, pEnt.Id);
                        if (bapEnts.Count > 0)
                        {
                            for (int j = 0; j < marks.Count; j++)
                            {
                                Bookmark mark = marks[j];
                                if (ContainProperty_Object(bapEnts[0], mark.Name))
                                {
                                    mark.Text = bapEnts[0].GetValue(mark.Name) + "";
                                }
                            }
                        }
                        filename = pEnt.ProjectName.Replace("#", "") + "_审查备案登记表.doc";
                        srcDoc.Save(@"D:\RW\Files\AppFiles\Portal\Default\" + filename);
                        UpdateFileItem(filename);
                        Response.Write("{success:true}");
                    }
                    catch
                    {
                        Response.Write("{success:false}");
                    }
                    Response.End();
                    break;
                case "export_shenchabaogao":
                    try
                    {
                        if (pEnt.ProjectType == "房屋建筑")
                        {
                            srcDoc = new Document(templatepath + "房屋建筑_审查报告.doc");
                        }
                        if (pEnt.ProjectType == "市政工程")
                        {
                            srcDoc = new Document(templatepath + "市政工程_审查报告.doc");
                        }
                        if (pEnt.ProjectType == "基坑支护")
                        {
                            srcDoc = new Document(templatepath + "基坑支护_审查报告.doc");
                        }
                        marks = srcDoc.Range.Bookmarks;
                        for (int j = 0; j < marks.Count; j++)
                        {
                            Bookmark mark = marks[j];
                            if (ContainProperty(pEnt, mark.Name))
                            {
                                mark.Text = pEnt.GetValue(mark.Name) + "";
                            }
                        }
                        IList<ShenChaReport> scrEnts = ShenChaReport.FindAllByProperty(ShenChaReport.Prop_ProjectId, pEnt.Id);
                        if (scrEnts.Count > 0)
                        {
                            for (int j = 0; j < marks.Count; j++)
                            {
                                Bookmark mark = marks[j];
                                if (ContainProperty_Object(scrEnts[0], mark.Name))
                                {
                                    mark.Text = scrEnts[0].GetValue(mark.Name) + "";
                                }
                            }
                        }
                        if (marks["Layer"] != null)
                        {
                            marks["Layer"].Text = "地上层数:" + pEnt.UpperLayers + (string.IsNullOrEmpty(pEnt.DownLayers) ? "" : "地下层数:" + pEnt.DownLayers);
                        }
                        if (marks["ProjectName1"] != null)
                        {
                            marks["ProjectName1"].Text = pEnt.ProjectName;
                        }
                        if (marks["JianSheUnit1"] != null)
                        {
                            marks["JianSheUnit1"].Text = pEnt.JianSheUnit;
                        }
                        filename = pEnt.ProjectName.Replace("#", "") + "_审查报告.doc";
                        srcDoc.Save(@"D:\RW\Files\AppFiles\Portal\Default\" + filename);
                        UpdateFileItem(filename);
                        Response.Write("{success:true}");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("{success:false}");
                    }
                    Response.End();
                    break;
                case "export_kanchashenchabaogao":
                    try
                    {
                        srcDoc = new Document(templatepath + "江西省工程勘察审查报告书.doc");
                        marks = srcDoc.Range.Bookmarks;
                        for (int j = 0; j < marks.Count; j++)
                        {
                            Bookmark mark = marks[j];
                            if (ContainProperty(pEnt, mark.Name))
                            {
                                mark.Text = pEnt.GetValue(mark.Name) + "";
                            }
                        }
                        IList<ShenChaReport_KanCha> scrkEnts = ShenChaReport_KanCha.FindAllByProperty(ShenChaReport_KanCha.Prop_ProjectId, pEnt.Id);
                        if (scrkEnts.Count > 0)
                        {
                            for (int j = 0; j < marks.Count; j++)
                            {
                                if (ContainProperty_Object(scrkEnts[0], marks[j].Name))
                                {
                                    marks[j].Text = scrkEnts[0].GetValue(marks[j].Name) + "";
                                }
                            }
                        }
                        if (marks["ProjectName2"] != null)
                        {
                            marks["ProjectName2"].Text = pEnt.ProjectName;
                        }
                        if (marks["JianSheUnit2"] != null)
                        {
                            marks["JianSheUnit2"].Text = pEnt.JianSheUnit;
                        }
                        filename = pEnt.ProjectName.Replace("#", "") + "_工程勘察审查报告.doc";
                        srcDoc.Save(@"D:\RW\Files\AppFiles\Portal\Default\" + filename);
                        UpdateFileItem(filename);
                        Response.Write("{success:true}");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("{success:false}");
                    }
                    Response.End();
                    break;
                case "exportqingkuangjilu":
                    try
                    {
                        srcDoc = new Document(templatepath + "附件6房屋建筑和市政基础设施工程施工图设计文件审查情况记录.doc");
                        marks = srcDoc.Range.Bookmarks;
                        for (int j = 0; j < marks.Count; j++)
                        {
                            Bookmark mark = marks[j];
                            if (ContainProperty(pEnt, mark.Name))
                            {
                                mark.Text = pEnt.GetValue(mark.Name) + "";
                            }
                        }
                        filename = pEnt.ProjectName.Replace("#", "") + "_审查情况记录.doc";
                        srcDoc.Save(@"D:\RW\Files\AppFiles\Portal\Default\" + filename);
                        UpdateFileItem(filename);
                        Response.Write("{success:true}");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("{success:false}");
                    }
                    Response.End();
                    break;
                case "export_shenchahuizong":
                    try
                    {
                        srcDoc = new Document(templatepath + "审查情况汇总.doc");
                        marks = srcDoc.Range.Bookmarks;
                        for (int j = 0; j < marks.Count; j++)
                        {
                            Bookmark mark = marks[j];
                            if (ContainProperty(pEnt, mark.Name))
                            {
                                mark.Text = pEnt.GetValue(mark.Name) + "";
                            }
                        }
                        if (marks["ProjectType2"] != null)
                        {
                            marks["ProjectType2"].Text = pEnt.ProjectType;
                        }
                        if (marks["Layer"] != null)
                        {
                            marks["Layer"].Text = "地上层数:" + pEnt.UpperLayers + (string.IsNullOrEmpty(pEnt.DownLayers) ? "" : "地下层数:" + pEnt.DownLayers);
                        }
                        //找到项目人员 排除勘察专业的
                        sql = @"select a.*,(select top 1 SortIndex from NCRL_Portal..SysEnumeration where Name=a.MajorName and ParentId='b640c40c-e2a9-41a8-bd28-d8ff9d71ff94') as SortIndex
                        from NCRL_SP..ProjectUser a   where a.ProjectId='" + pEnt.Id + "' order by SortIndex asc";
                        dics = DataHelper.QueryDictList(sql);
                        int index = 1;
                        foreach (EasyDictionary dic in dics)
                        {
                            if (dic.Get<string>("MajorName") != "勘察")
                            {
                                if (marks["MajorName" + index] != null)
                                {
                                    marks["MajorName" + index].Text = dic.Get<string>("MajorName");
                                }
                                if (marks["QianZhangName" + index] != null)
                                {
                                    marks["QianZhangName" + index].Text = dic.Get<string>("QianZhangName");
                                }
                                index++;
                            }
                        }
                        sql = @"select isnull(sum(QiangTiao),0) from NCRL_SP..ExamineOpinion where ExamineTaskId in (
                        select Id from NCRL_SP..ExamineTask where ProjectId='" + pEnt.Id + "')";
                        if (marks["QiangTiao"] != null)
                        {
                            marks["QiangTiao"].Text = DataHelper.QueryValue(sql) + "";
                        }
                        filename = pEnt.ProjectName.Replace("#", "") + "_审查情况汇总.doc";
                        srcDoc.Save(@"D:\RW\Files\AppFiles\Portal\Default\" + filename);
                        UpdateFileItem(filename);
                        Response.Write("{success:true}");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("{success:false}");
                    }
                    Response.End();
                    break;
                case "export_shenchahuizong_kancha"://审查情况汇总表_工程勘察
                    try
                    {
                        srcDoc = new Document(templatepath + "审查情况汇总表_工程勘察.doc");
                        marks = srcDoc.Range.Bookmarks;
                        for (int j = 0; j < marks.Count; j++)
                        {
                            if (ContainProperty(pEnt, marks[j].Name))
                            {
                                marks[j].Text = pEnt.GetValue(marks[j].Name) + "";
                            }
                        }
                        if (marks["QianZhangName"] != null)//找到勘察专业的签章专家
                        {
                            IList<ProjectUser> puEnts = ProjectUser.FindAllByProperties(ProjectUser.Prop_ProjectId, pEnt.Id, ProjectUser.Prop_MajorName, "勘察");
                            if (puEnts.Count > 0)
                            {
                                marks["QianZhangName"].Text = puEnts[0].QianZhangName;
                            }
                        }
                        if (marks["QiangTiao"] != null)//找到勘察专业的强条
                        {
                            IList<ExamineTask> etEnts = ExamineTask.FindAllByProperties(ExamineTask.Prop_MajorName, "勘察", ExamineTask.Prop_ProjectId, pEnt.Id);
                            if (etEnts.Count > 0)
                            {
                                sql = "select isnull(sum(QiangTiao),0) from NCRL_SP..ExamineOpinion where ExamineTaskId='" + etEnts[0].Id + "'";
                                marks["QiangTiao"].Text = DataHelper.QueryValue<Int32>(sql) + "";
                            }
                        }
                        filename = pEnt.ProjectName.Replace("#", "") + "_工程勘察审查情况汇总表.doc";
                        srcDoc.Save(@"D:\RW\Files\AppFiles\Portal\Default\" + filename);
                        UpdateFileItem(filename);
                        Response.Write("{success:true}");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("{success:false}");
                    }
                    Response.End();
                    break;
                case "export_kangzhen":
                    try
                    {
                        srcDoc = new Document(templatepath + "抗震设防监管表.doc");
                        marks = srcDoc.Range.Bookmarks;
                        for (int j = 0; j < marks.Count; j++)
                        {
                            if (ContainProperty(pEnt, marks[j].Name))
                            {
                                marks[j].Text = pEnt.GetValue(marks[j].Name) + "";
                            }
                        }
                        IList<KangZhen_Project> kzpEnts = KangZhen_Project.FindAllByProperty(KangZhen_Project.Prop_ProjectId, pEnt.Id);
                        if (kzpEnts.Count > 0)
                        {
                            for (int j = 0; j < marks.Count; j++)
                            {
                                if (ContainProperty_Object(kzpEnts[0], marks[j].Name))
                                {
                                    marks[j].Text = kzpEnts[0].GetValue<string>(marks[j].Name);
                                }
                            }
                        }
                        if (pEnt.Property == "新建" && marks["XinJian"] != null)
                        {
                            marks["XinJian"].Text = "√";
                        }
                        if (pEnt.Property == "改建" && marks["GaiJian"] != null)
                        {
                            marks["GaiJian"].Text = "√";
                        }
                        if (pEnt.Property == "扩建" && marks["KuoJian"] != null)
                        {
                            marks["KuoJian"].Text = "√";
                        }
                        filename = pEnt.ProjectName.Replace("#", "") + "_抗震设防专项审查监管表.doc";
                        srcDoc.Save(@"D:\RW\Files\AppFiles\Portal\Default\" + filename);
                        UpdateFileItem(filename);
                        Response.Write("{success:true}");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("{success:false}");
                    }
                    Response.End();
                    break;
                case "export_zhongshenyijianbiao":
                    try
                    {
                        srcDoc = new Document(templatepath + "附件5_终审意见表.doc");
                        marks = srcDoc.Range.Bookmarks;
                        for (int j = 0; j < marks.Count; j++)
                        {
                            if (ContainProperty(pEnt, marks[j].Name))
                            {
                                marks[j].Text = pEnt.GetValue(marks[j].Name) + "";
                            }
                        }
                        IList<ZhongShenOpinion_Project> zsopEnts = ZhongShenOpinion_Project.FindAllByProperty(ZhongShenOpinion_Project.Prop_ProjectId, pEnt.Id);
                        if (zsopEnts.Count > 0)
                        {
                            for (int j = 0; j < marks.Count; j++)
                            {
                                if (ContainProperty_Object(zsopEnts[0], marks[j].Name))
                                {
                                    marks[j].Text = zsopEnts[0].GetValue(marks[j].Name) + "";
                                }
                            }
                        }
                        filename = pEnt.ProjectName.Replace("#", "") + "_终审意见表.doc";
                        srcDoc.Save(@"D:\RW\Files\AppFiles\Portal\Default\" + filename);
                        UpdateFileItem(filename);
                        Response.Write("{success:true}");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("{success:false}");
                    }
                    Response.End();
                    break;
                case "export_subproject"://导出子项
                    try
                    {
                        srcDoc = new Document(templatepath + "子项目明细表.doc");
                        marks = srcDoc.Range.Bookmarks;
                        IList<SubProject> suEnts = SubProject.FindAllByProperty(SubProject.Prop_ProjectId, pEnt.Id);
                        for (int j = 0; j < suEnts.Count; j++)
                        {
                            foreach (PropertyInfo pi in SubProject.AllProperties)
                            {
                                if (marks[pi.Name + (j + 1)] != null)
                                {
                                    marks[pi.Name + (j + 1)].Text = suEnts[j].GetValue(pi.Name) + "";
                                }
                            }
                        }
                        if (marks["ProjectName"] != null)
                        {
                            marks["ProjectName"].Text = pEnt.ProjectName;
                        }
                        filename = pEnt.ProjectName.Replace("#", "") + "_子项目明细表.doc";
                        srcDoc.Save(@"D:\RW\Files\AppFiles\Portal\Default\" + filename);
                        UpdateFileItem(filename);
                        Response.Write("{success:true}");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("{success:false}");
                    }
                    Response.End();
                    break;
            }
        }
        private bool ContainProperty(Project pEnt, string propertyName)
        {
            if (pEnt != null && !string.IsNullOrEmpty(propertyName))
            {
                PropertyInfo _findedPropertyInfo = pEnt.GetType().GetProperty(propertyName);
                return (_findedPropertyInfo != null);
            }
            return false;
        }
        private bool ContainProperty_Object(Object ob, string propertyName)
        {
            if (ob != null && !string.IsNullOrEmpty(propertyName))
            {
                PropertyInfo _findedPropertyInfo = ob.GetType().GetProperty(propertyName);
                return (_findedPropertyInfo != null);
            }
            return false;
        }
        private void UpdateFileItem(string filename)
        {
            IList<FileItem> fiEnts = FileItem.FindAllByProperties(FileItem.Prop_ProjectId, pEnt.Id, FileItem.Prop_Path, "导出", FileItem.Prop_Name, filename);
            if (fiEnts.Count == 0)
            {
                FileItem fiEnt = new FileItem();
                fiEnt.ProjectId = pEnt.Id;
                fiEnt.Name = filename;
                fiEnt.FolderId = "1";
                fiEnt.CreateTime = DateTime.Now;
                fiEnt.Path = "导出";
                fiEnt.DoCreate();
            }
            else
            {
                fiEnts[0].CreateTime = DateTime.Now;
                fiEnts[0].DoUpdate();
            }
        }
        private void Recycle()
        {
            string Result = "T";
            string id = Request["id"];
            IList<ExamineTask> etEnts = ExamineTask.FindAllByProperty(ExamineTask.Prop_ProjectId, id);
            foreach (ExamineTask etEnt in etEnts)
            {
                IList<ExamineOpinion> eoEnts = ExamineOpinion.FindAllByProperty(ExamineOpinion.Prop_ExamineTaskId, etEnt.Id);
                if (eoEnts.Count > 0)
                {
                    Result = "F";
                    break;
                }
            }
            if (Result == "T")
            {
                ExamineTask.DeleteAll("ProjectId='" + id + "'");
                pEnt = Project.Find(id);
                pEnt.Status = "已创建";
                pEnt.TaskQuan = 0;
                pEnt.DoUpdate();
            }
            Response.Write("{success:  true ,Result:'" + Result + "'}");
            Response.End();
        }
        private void Delete()
        {
            string Id = Request["Id"];
            if (!string.IsNullOrEmpty(Id))
            {
                ProjectUser.DeleteAll("ProjectId='" + Id + "'");
                SubProject.DeleteAll("ProjectId='" + Id + "'");
                KanChaSheJi.DeleteAll("ProjectId='" + Id + "'");
                sql = "delete NCRL_SP..Project where Id='" + Id + "'";
                DataHelper.ExecSql(sql);
            }
        }
        private string GetPageSql(string tempsql)
        {
            int start = Convert.ToInt32(Request["start"]);
            int limit = Convert.ToInt32(Request["limit"]);
            totalProperty = DataHelper.QueryValue<int>("select count(1) from (" + tempsql + ") t");
            string order = "CREATETIME";
            string asc = " desc";
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