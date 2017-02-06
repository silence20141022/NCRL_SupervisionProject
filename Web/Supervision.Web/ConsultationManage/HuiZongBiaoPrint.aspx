<%@ Page Language="C#" AutoEventWireup="True" CodeBehind="HuiZongBiaoPrint.aspx.cs"
    Inherits="SP.Web.ConsultationManage.HuiZongBiaoPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        ul
        {
            list-style-type: none;
        }
        .table2
        {
            border-collapse: collapse;
            border: none;
            margin-left: 0px;
            font-size: 14px;
            margin-top: 30px;
            width: 708px;
        }
        
        .table2 td
        {
            border: solid #000 1px;
            width: 59px;
        }
        .table2 tr
        {
            height: 45px;
        }
        .left div
        {
            margin-top: 15px;
        }
        
        .trText
        {
            text-align: center;
        }
        .underline
        {
            display: -moz-inline-box;
            display: inline-block;
            width: 30px;
            height: 20px;
            text-align: center;
            border-bottom: 1px solid #000;
        }
        
        .table4
        {
            width: 708px;
            border-collapse: collapse;
            border: none;
            margin-left: 0px;
            font-size: 14px;
        }
        .table4 td
        {
            border: solid #000 1px;
            border-top: 0px;
        }
        
        .trleft div
        {
            height: 20px;
            text-align: center;
        }
        .table5
        {
            width: 708px;
            border-collapse: collapse;
            border: none;
            margin-left: 0px;
            font-size: 15px;
        }
        .table5 td
        {
            height: 40px;
            border: solid #000 1px;
            border-top: 0px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width: 750px; height: 1050px;">
        <table border="0" cellspacing="0" cellpadding="0" style="text-align: center; width: 750px;
            height: 200px;">
            <tr>
                <td style="padding-top: 20px; font-size: 20px;" colspan="2">
                    <h3>
                        房屋建筑和市政基础设施工程施工图设计文件审查</h3>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="font-size: 18px;">
                    <h3 style="margin-top: -15px;">
                        项目审查情况汇总表（<span id="title" runat="server"></span>）</h3>
                </td>
            </tr>
            <tr>
                <td style="width: 50%">
                    <div style="margin-left: 30px;">
                        <span style="font-size: 18px; font-weight: bold">审查机构：</span>江西瑞林工程咨询有限公司
                    </div>
                </td>
                <td style="width: 50%">
                    <div style="margin-right: -120px;">
                        <label id="year" runat="server">
                        </label>
                        年
                        <label id="month" runat="server">
                        </label>
                        月
                        <label id="day" runat="server">
                        </label>
                        日
                    </div>
                </td>
            </tr>
        </table>
        <table class="table2">
            <tr>
                <td style="width: 15%" class="trText" colspan="2">
                    工程名称
                </td>
                <td style="width: 35%" colspan="4">
                    <label id="ProjectName" runat="server">
                    </label>
                </td>
                <td style="width: 18%" class="trText" colspan="2">
                    建设单位
                </td>
                <td style="width: 32%" colspan="4">
                    <label id="JianSheUnit" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td class="trText" colspan="2">
                    勘察单位
                </td>
                <td colspan="4">
                    <label id="KanChaUnit" runat="server">
                    </label>
                </td>
                <td class="trText" colspan="2">
                    资质等级及编号
                </td>
                <td colspan="4">
                    <label id="KanChaZZLevelAndCode" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td class="trText" colspan="2">
                    设计单位
                </td>
                <td colspan="4">
                    /
                </td>
                <td class="trText" colspan="2">
                    资质等级及编号
                </td>
                <td colspan="4">
                    /
                </td>
            </tr>
            <tr>
                <td class="trText" style="width: 88px">
                    工程类别
                </td>
                <td>
                    <label id="ProjectType" runat="server">
                    </label>
                </td>
                <td class="trText" style="width: 30px">
                    工程级别
                </td>
                <td>
                    <label id="EngineeringLevel" runat="server">
                    </label>
                </td>
                <td class="trText">
                    投资额
                </td>
                <td>
                    <label id="Investment" runat="server">
                    </label>
                </td>
                <td class="trText">
                    建筑面积
                </td>
                <td>
                    <label id="BuildingArea" runat="server">
                    </label>
                </td>
                <td class="trText">
                    层数
                </td>
                <td>
                    <label id="CengShu" runat="server">
                    </label>
                </td>
                <td class="trText">
                    高度
                </td>
                <td>
                    <label id="Height" runat="server">
                    </label>
                </td>
            </tr>
        </table>
        <table class="table4">
            <tr>
                <td style="width: 61px;" rowspan="3" class="trleft">
                    <div>
                        按</div>
                    <div>
                        审</div>
                    <div>
                        查</div>
                    <div>
                        专</div>
                    <div>
                        业</div>
                    <div>
                        分</div>
                </td>
                <td colspan="15" style="height: 30px; text-align: center">
                    审 查 人 员 姓 名
                </td>
            </tr>
            <tr style="height: 30px; text-align: center">
                <asp:Literal ID="majorName" runat="server" />
            </tr>
            <tr style="height: 50px; text-align: center">
                <asp:Literal ID="userName" runat="server" />
            </tr>
            <tr>
                <td rowspan="2" class="trleft">
                    <div>
                        技</div>
                    <div>
                        术</div>
                    <div>
                        责</div>
                    <div>
                        任</div>
                    <div>
                        人</div>
                </td>
            </tr>
            <tr style="height: 30px; text-align: center">
                <asp:Literal ID="userName1" runat="server" />
            </tr>
            <tr>
                <td rowspan="2" class="trleft">
                    <div>
                        违</div>
                    <div>
                        反</div>
                    <div>
                        强</div>
                    <div>
                        条</div>
                    <div>
                        数</div>
                </td>
            </tr>
            <tr style="height: 30px; text-align: center">
                <asp:Literal ID="qiangTiao" runat="server" />
            </tr>
            <tr>
                <td rowspan="2" class="trleft">
                    <div>
                        一</div>
                    <div>
                        次</div>
                    <div>
                        审</div>
                    <div>
                        查</div>
                    <div>
                        合</div>
                    <div>
                        格</div>
                </td>
            </tr>
            <tr style="height: 30px; text-align: center">
                <asp:Literal ID="EO" runat="server" />
            </tr>
        </table>
        <table class="table5">
            <tr>
                <td>
                    合计违反条数：<label class="underline" id="Total" runat="server">123</label>条
                </td>
            </tr>
            <tr>
                <td style="font-size: 14px;">
                    备注:
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
