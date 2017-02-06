<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShenChaHeGeShuPrint.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ShenChaHeGeShuPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .prjinfo
        {
            margin-top: 10px;
            margin-bottom: 10px;
            margin-left: 10px;
        }
        tr
        {
            height: 25px;
        }
        table
        {
            border-left: 1px solid #666;
            border-bottom: 1px solid #666;
        }
        td
        {
            border-right: 1px solid black;
            border-top: 1px solid black;
            text-align: center;
        }
    </style>
</head>
<body>
    <div style="height: 650px; width: 450px; border: 1px solid black; float: left; margin-left: 40px;
        margin-top: 30px">
        <div style="text-align: center; font-size: 10.8pt; margin-top: 10px;">
            房屋建筑和市政基础设施工程施工图设计文件审查</div>
        <div style="text-align: center">
            <h1>
                审查合格书</h1>
        </div>
        <div style="text-align: center; font-size: 10.8pt">
            <label id="lbZiXunCode" runat="server">
            </label>
        </div>
        <div style="font-size: 15pt; font-weight: 500; padding-left: 45px; letter-spacing: 2px;
            margin-top: 30px; margin-bottom: 30px">
            根据《房屋建筑和市政基础设施工程施工
        </div>
        <div style="font-size: 15pt; font-weight: 500; letter-spacing: 2px; margin-top: 30px;
            margin-bottom: 30px; padding-left: 5px;">
            图设计文件审查管理办法》(建设部令第13号)
        </div>
        <div style="font-size: 15pt; font-weight: 500; letter-spacing: 2px; margin-top: 30px;
            margin-bottom: 30px; padding-left: 5px">
            本工程施工图设计文件经审查合格。
        </div>
        <div style="font-size: 15pt; font-weight: 500; letter-spacing: 2px; margin-top: 70px;
            margin-bottom: 30px; padding-left: 70px">
            审查合格专用章：</div>
        <div style="font-size: 15pt; font-weight: 500; letter-spacing: 2px; margin-top: 100px;
            margin-bottom: 30px; padding-left: 70px">
            审查机构(盖章)：</div>
        <div style="font-size: 15pt; font-weight: 500; letter-spacing: 2px; margin-bottom: 10px;
            padding-left: 70px">
            日期：<label id="lbHeGeShuTime" runat="server"></label></div>
        <div style="text-align: center; font-size: 10.8pt">
            江西省建设厅印制</div>
    </div>
    <div style="width: 450px; border: 1px solid black; float: right; margin-right: 40px;
        margin-top: 30px; border-bottom: 0; font-size: 10.8pt">
        <div class="prjinfo">
            工程名称：<label id="lbProjectName" runat="server"></label></div>
        <div class="prjinfo">
            工程地址：<label id="lbProjectAddress" runat="server"></label></div>
        <div class="prjinfo">
            工程类别：<label id="lbProjectType" runat="server"></label></div>
        <div class="prjinfo">
            工程等级：<label id="lbEngineeringLevel" runat="server"></label></div>
        <div class="prjinfo" style="margin-bottom: 50px">
            工程规模：<label id="lbGongChengGuiMo" runat="server"></label></div>
        <div class="prjinfo">
            建设单位：<label id="lbJianSheUnit" runat="server"></label></div>
        <div class="prjinfo">
            勘察单位：<label id="lbKanChaUnit" runat="server"></label></div>
        <div class="prjinfo">
            设计单位：<label id="lbSheJiUnit" runat="server"></label></div>
        <div class="prjinfo">
            审查机构：江西瑞林工程咨询有限公司</div>
    </div>
    <table width="452px" cellpadding="0" cellspacing="0" border="0" style="float: right;
        margin-right: 40px; font-size: 10.8pt">
        <tr>
            <td style="width: 33.3%">
                专业
            </td>
            <td style="width: 33.3%">
                审查人员签字
            </td>
            <td>
                复核人员签字
            </td>
        </tr>
        <asp:Literal ID="lt1" runat="server"></asp:Literal>
    </table>
    <div style="float: right; width: 450px; margin-right: 40px">
        <div style="font-size: 18px; font-weight: bold;">
            说明：
        </div>
        <div style="font-size: 12px; font-weight: bold; letter-spacing: 1px;">
            1、本合格证书由审查机构对审查合格的建设工程施工图设计文件核发</div>
        <div style="font-size: 12px; font-weight: bold; letter-spacing: 1px;">
            2、本合格书是基本建设程序的法定文书，不得涂改、伪造；</div>
        <div style="font-size: 12px; font-weight: bold; letter-spacing: 1px;">
            3、本合格书在工程竣工后作为工程档案归档；</div>
        <div style="font-size: 12px; font-weight: bold; letter-spacing: 1px;">
            4、本合格书由省建设厅统一印制并加盖省建设厅核发的施工图文件审</div>
        <div style="font-size: 12px; font-weight: bold; letter-spacing: 1px; margin-left: 20px;">
            查合格专用章后方可有效，任何人和机构不得翻印。</div>
    </div>
</body>
</html>
