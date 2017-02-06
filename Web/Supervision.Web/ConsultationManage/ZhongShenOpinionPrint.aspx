<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZhongShenOpinionPrint.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ZhongShenOpinionPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        *
        {
            font-family: "microsoft jhenghei";
        }
        .table2
        {
            border-collapse: collapse;
            border: none;
            font-size: 15px;
        }
        .table2 td
        {
            border: solid #000 1px;
            padding-left: 5px;
        }
        .table2 tr
        {
            height: 35px;
        }
        .left div
        {
            margin-top: 15px;
        }
        .underline
        {
            display: -moz-inline-box;
            display: inline-block;
            height: 17px;
            border-bottom: 1px solid #000;
        }
        .opinion
        {
            height: auto !important;
            height: 390px !important;
            vertical-align: top;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table width="670px" border="0" cellspacing="0" cellpadding="0" style="height: 150px;
            margin-left: 40px; margin-right: 40px; text-align: center">
            <tr>
                <td style="padding-top: 20px; font-size: 20px;">
                    <h3>
                        房屋建筑和市政基础设施工程施工图设计文件审查</h3>
                </td>
            </tr>
            <tr>
                <td style="font-size: 18px;">
                    <h3>
                        终审意见表</h3>
                </td>
            </tr>
        </table>
        <div style="margin-left: 40px; padding-left: 5px; font-size: 15px; text-align: left">
            编号:
            <label id="lbZiXunCode" runat="server">
            </label>
        </div>
        <div style="margin-left: 40px; padding-left: 5px; font-size: 15px; text-align: left">
            专业:
            <label id="MajorName_h" runat="server">
            </label>
        </div>
        <table style="margin-left: 40px; margin-right: 40px; text-align: left" class="table2"
            width="668px">
            <tr>
                <td>
                    工程名称
                </td>
                <td>
                    <label id="ProjectName" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    建设单位
                </td>
                <td>
                    <label id="JianSheUnit" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    勘察单位
                </td>
                <td>
                    <label id="KanChaUnit" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    设计单位
                </td>
                <td>
                    <label id="SheJiUnit" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    审查意见
                </td>
            </tr>
            <tr>
                <td colspan="2" class="opinion">
                    <label id="ZhongShenOpinion" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div>
                        <div class="left" style="width: 65%; margin: 5px 0px 10px 0px; float: left">
                            <div>
                                <span>审查人：</span>
                                <label class="underline" id="QianZhangName_h" runat="server">
                                </label>
                            </div>
                            <div>
                                <span>审查人签字：</span>
                            </div>
                            <div>
                                <span>复核人：</span>
                                <label class="underline" id="ShengHeName_h" runat="server">
                                </label>
                            </div>
                            <div>
                                <span>复核人签字：</span>
                            </div>
                        </div>
                        <div class="right" style="width: 30%; float: right">
                            <div style="margin-top: 60px;">
                                审查任务 （盖章）</div>
                            <div style="margin-top: 20px; margin-left: 20px;" class="Time">
                                <span id="year" runat="server"></span>&nbsp 年 <span id="month" runat="server"></span>
                                &nbsp;月&nbsp;<span id="day" runat="server"></span>&nbsp;日
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
