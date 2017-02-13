<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamineOpinionPrint.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ExamineOpinionPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        #three table
        {
            border-collapse: collapse;
            width: 90%;
            border: 1px solid #000;
            margin-right: 15px;
            margin-left: 25px;
        }
        
        #three table tr td
        {
            line-height: 22px;
            font-size: 10.8pt;
            padding-left: 10px;
            border: solid #000 1px;
        }
        .qiangtiao
        {
            display: -moz-inline-box;
            display: inline-block;
            width: 19px;
            height: 17px;
            text-align: center;
            border-bottom: 1px solid #000;
        }
        .shenchafuhe
        {
            display: -moz-inline-box;
            display: inline-block;
            width: 100px;
            height: 22px;
            text-align: center;
            border-bottom: 1px solid #000;
        }
        .shenchajigou
        {
            display: -moz-inline-box;
            display: inline-block;
            width: 180px;
            height: 22px;
            text-align: center;
            border-bottom: 1px solid #000;
        }
        .startyear
        {
            display: -moz-inline-box;
            display: inline-block;
            width: 70px;
            height: 17px;
            text-align: center;
            border-bottom: 1px solid #000;
        }
        .stage
        {
            display: -moz-inline-box;
            display: inline-block;
            width: 80px;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="three">
        <div style="font-size: 16.5pt; text-align: center; font-weight: 600; padding-top: 30px;
            margin-bottom: 10px;">
            房屋建筑和市政基础设施工程施工图设计文件审查
        </div>
        <div style="font-size: 16.5pt; text-align: center; margin-top: 10px; font-weight: 600">
            审查记录表<label id="lbStage" runat="server" class="stage"></label>
        </div>
        <div style="font-size: 10.8pt; margin-top: 15px; padding-left: 100px;">
            该项目施工图设计文件审查已于<label id="lbStartYear" runat="server" class="startyear"></label>年<label
                id="lbStartMonth" runat="server" class="qiangtiao"></label>月<label id="lbStartDay"
                    runat="server" class="qiangtiao"></label>日至<label id="Label1" runat="server" class="startyear">&nbsp;</label>年<label
                        id="Label2" runat="server" class="qiangtiao">&nbsp;</label>月<label id="Label3" runat="server"
                            class="qiangtiao">&nbsp;</label>日审查完
        </div>
        <div style="font-size: 10.8pt; margin-top: 5px; padding-left: 30px; font-weight: 100">
            毕，存在以下问题, 请修改后返回。</div>
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td rowspan="2" colspan="2" style="width: 50%">
                    编号：<label id="lbZiXunCode" runat="server"></label>
                </td>
                <td rowspan="2" style="width: 25%">
                    专业：<label id="lbMajorName" runat="server"></label>
                </td>
                <td style="width: 25%">
                    注册人员：
                    <label id="lbZhuCeUsers" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    设计人员：
                    <label id="lbSheJiUsers" runat="server">
                    </label>
                </td>
            </tr>
            <tr style="height: 35px;">
                <td style="width: 25%">
                    工程名称：
                </td>
                <td colspan="3">
                    <label id="lbProjectName" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td colspan="4">
                    <div style="width: 100%; height: 600px;">
                        <label id="lbExamineOpinions" runat="server">
                        </label>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 50px">
                    违反强条数：
                    <label id="lbQiangTiao" runat="server" class="qiangtiao">
                    </label>
                    条，其中：建筑设计<label id="lbJiangZhuSheJi" runat="server" class="qiangtiao"></label>条，建筑防火<label
                        id="lbFangHuo" runat="server" class="qiangtiao"></label>条，建筑设备<label id="lbSheBei"
                            runat="server" class="qiangtiao"></label>条，勘察和地基基础
                    <label id="lbJiChu" runat="server" class="qiangtiao">
                    </label>
                    条，结构设计<label id="lbJiGouSheJi" runat="server" class="qiangtiao"></label>条，房屋抗震设计<label
                        id="lbKangZhenSheJi" runat="server" class="qiangtiao"></label>条， 结构鉴定和加固<label id="lbJiaGu"
                            runat="server" class="qiangtiao"></label>条。
                </td>
            </tr>
            <tr>
                <td colspan="4" style="border-bottom: none; height: 35px">
                    审查人：<label id="lbShenChaUserName" runat="server" class="shenchafuhe"></label>
                    复核人：<label id="lbFuHeUserName" runat="server" class="shenchafuhe"></label>
                    审查机构：
                    <label class="shenchajigou">
                        江西瑞林工程咨询有限公司</label>
                    <div style="text-align: right; padding-right: 50px; margin-top: 10px">
                        <label id="lbEndTime" runat="server">
                        </label>
                    </div>
                </td>
            </tr>
        </table>
        <div style="padding-left: 50px; font-size: 10.8pt;">
            注：1、记录内容应写出违反工程建设强制标准条文的标准规范名称及具体条目。</div>
        <div style="padding-left: 80px; font-size: 10.8pt;">
            2、同一强条重复出现时记为一条，同一强条在不同类问题出现时重复记入。</div>
    </div>
    </form>
</body>
</html>
