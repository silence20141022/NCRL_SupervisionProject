﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JKSCDY.aspx.cs" Inherits="SP.Web.ConsultationManage.JKSCDY" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script src="../js/lib/jquery-1.7.1.js" type="text/javascript"></script>
    <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0"
        height="0">
    </object>
    <style type="text/css">
        *
        {
            font-family: "microsoft jhenghei";
        }
        ul
        {
            list-style-type: none;
        }
        .table3
        {
            border-collapse: collapse;
            border: none;
            width: 750;
        }
        .table3 td
        {
            border: solid #000 1px;
        }
    </style>
    <script type="text/javascript">
        var Id = getQueryString("Id");
        $(function () {
            $.ajaxSetup({
                async: false
            });
            $.post("FWJZDY.aspx", { action: "select", Id: Id }, function (data) {
                data = eval("(" + data + ")");
                $("#ShenChaNo").text(data.ShenChaNo);
                $("#ProjectName1").text(data.ProjectName);
                $("#ProjectName").text(data.ProjectName);
                $("#JianSheUnit1").text(data.JianSheUnit);
                $("#JianSheUnit").text(data.JianSheUnit);
                $("#Investment").text(data.Investment);
                $("#DetailLocation").text(data.DetailLocation);
                $("#EngineeringLevel").text(data.EngineeringLevel);
                $("#JianSheUnitHead").text(data.JianSheUnitHead);
                $("#KanChaUnit").text(data.KanChaUnit);
                $("#KanChaUnitHead").text(data.KanChaUnitHead);
                $("#KanChaZZLevel").text(data.KanChaZZLevel);
                $("#KanChaUnitZSNo").text(data.KanChaUnitZSNo);
                $("#SheJiUnit").text(data.SheJiUnit);
                $("#SheJiUnitHead").text(data.SheJiUnitHead);
                $("#SheJiUnitGrade").text(data.SheJiUnitGrade);
                $("#SheJiUnitZSNo").text(data.SheJiUnitZSNo);

                $("#Opinion1").append(data.Opinion1);
                $("#Opinion1ShenChaName").text(data.Opinion1ShenChaName);
                var date1 = data.Opinion1CreateTime;
                if (date1) {
                    var str = date1.split("/");
                    $("#Year1").text(str[0]);
                    $("#Month1").text(str[1]);
                    $("#Day1").text(str[2]);
                }

                $("#Opinion2").append(data.Opinion2);
                $("#Opinion2ShenChaName").text(data.Opinion2ShenChaName);
                var date2 = data.Opinion1CreateTime;
                if (date2) {
                    var str = date2.split("/");
                    $("#Year2").text(str[0]);
                    $("#Month2").text(str[1]);
                    $("#Day2").text(str[2]);
                }

                $("#Opinion3").append(data.Opinion3);
                $("#Opinion3ShenChaName").text(data.Opinion3ShenChaName);
                var date3 = data.Opinion3CreateTime;
                if (date3) {
                    var str = date3.split("/");
                    $("#Year3").text(str[0]);
                    $("#Month3").text(str[1]);
                    $("#Day3").text(str[2]);
                }

                $("#Opinion4").append(data.Opinion4);
                $("#Opinion4ShenChaName").text(data.Opinion4ShenChaName);
                var date4 = data.Opinion4CreateTime;
                if (date4) {
                    var str = date4.split("/");
                    $("#Year4").text(str[0]);
                    $("#Month4").text(str[1]);
                    $("#Day4").text(str[2]);
                }

                $("#Opinion5").append(data.Opinion5);

            });
        });
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table width="750px" border="0" height="1050" cellspacing="0" cellpadding="0" style="text-align: center">
            <tr style="height: 100px">
                <td style="padding-top: 50px; font-size: 20px; text-align: center; vertical-align: middle"
                    colspan="2">
                    <h1>
                        江西省深基坑支护工程施工图设计文件</h1>
                </td>
            </tr>
            <tr style="height: 500px">
                <td colspan="2" style="padding-top: 0px; font-size: 18px; text-align: center; vertical-align: top">
                    <h2>
                        审 查 报 告</h2>
                </td>
            </tr>
            <tr>
                <td style="width: 50%; text-align: right;">
                    <h3>
                        建筑工程名称:</h3>
                </td>
                <td style="width: 50%; text-align: left">
                    <label id="ProjectName1" style="border-bottom: 1px solid black;">
                    </label>
                </td>
            </tr>
            <tr>
                <td style="width: 50%; text-align: right;">
                    <h3>
                        建设单位名称:</h3>
                </td>
                <td style="width: 50%; text-align: left">
                    <label id="JianSheUnit1" style="border-bottom: 1px solid black;">
                    </label>
                </td>
            </tr>
            <tr>
                <td style="width: 50%; text-align: right;">
                    <h3>
                        施工图审查机构名称:</h3>
                </td>
                <td style="width: 50%; text-align: left">
                    <label id="" style="border-bottom: 1px solid black;">
                        江西瑞林工程咨询有限公司
                    </label>
                </td>
            </tr>
            <tr style="margin-top: 120px; height: 155px">
                <td colspan="2" style="font-size: 20px; text-align: center">
                    江西省住房与城乡建设厅制
                </td>
            </tr>
        </table>
        <div style="height: 50px; font-size: 22px; text-align: center; width: 750px; margin-top: 20px">
            <h2>
                江西省深基坑支护工程施工图设计文件</h2>
        </div>
        <div style="height: 65px; text-align: center; font-size: 22px; width: 750px">
            <h2>
                审 查 报 告</h2>
        </div>
        <div style="height: 35px; vertical-align: bottom; text-align: right; width: 740px">
            编号：
            <label id="ShenChaNo">
            </label>
        </div>
        <table class="table3" style="width: 740px">
            <tr style="height: 52px">
                <td style="width: 15%">
                    建设项目名称
                </td>
                <td style="width: 35%">
                    <label id="ProjectName">
                    </label>
                </td>
                <td style="width: 15%">
                    投资额(万元)
                </td>
                <td style="width: 35%">
                    <label id="Investment">
                    </label>
                </td>
            </tr>
            <tr style="height: 52px">
                <td>
                    建设地点
                </td>
                <td>
                    <label id="DetailLocation">
                    </label>
                </td>
                <td>
                    设计等级
                </td>
                <td>
                    <label id="EngineeringLevel">
                    </label>
                </td>
            </tr>
            <tr style="height: 52px">
                <td>
                    建设单位名称
                </td>
                <td>
                    <label id="JianSheUnit">
                    </label>
                </td>
                <td>
                    项目负责人
                </td>
                <td>
                    <label id="JianSheUnitHead">
                    </label>
                </td>
            </tr>
            <tr style="height: 52px">
                <td>
                    勘察单位名称
                </td>
                <td>
                    <label id="KanChaUnit">
                    </label>
                </td>
                <td>
                    项目负责人
                </td>
                <td>
                    <label id="KanChaUnitHead">
                    </label>
                </td>
            </tr>
            <tr style="height: 52px">
                <td>
                    资质等级
                </td>
                <td>
                    <label id="KanChaZZLevel">
                    </label>
                </td>
                <td>
                    证书编号
                </td>
                <td>
                    <label id="KanChaUnitZSNo">
                    </label>
                </td>
            </tr>
            <tr style="height: 52px">
                <td>
                    设计单位名称
                </td>
                <td>
                    <label id="SheJiUnit">
                    </label>
                </td>
                <td>
                    项目负责人
                </td>
                <td>
                    <label id="SheJiUnitHead">
                    </label>
                </td>
            </tr>
            <tr style="height: 52px">
                <td>
                    资质等级
                </td>
                <td>
                    <label id="SheJiUnitGrade">
                    </label>
                </td>
                <td>
                    证书编号
                </td>
                <td>
                    <label id="SheJiUnitZSNo">
                    </label>
                </td>
            </tr>
            <tr style="height: 60px">
                <td colspan="4">
                    1.是否按专家提出的设计方案审查意见进行施工图设计<br />
                    2.深基坑支护结构体系是否安全、可靠、无明显的不安全因素
                </td>
            </tr>
            <tr style="height: 240px">
                <td rowspan="3" style="text-align: center; vertical-align: middle">
                    审<br />
                    <br />
                    查<br />
                    <br />
                    报<br />
                    <br />
                    告
                </td>
                <td colspan="3">
                    <label id="Opinion1">
                    </label>
                </td>
            </tr>
            <tr style="height: 63px">
                <td colspan="3">
                    <div style="margin-left: 63%;">
                        审查人员签章:<label id="Opinion1ShenChaName"></label><br />
                        <label id="Year1">
                        </label>
                        年&nbsp;&nbsp;&nbsp;<label id="Month1"></label>&nbsp;&nbsp; 月&nbsp;&nbsp;&nbsp;<label
                            id="Day1"></label>&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                </td>
            </tr>
        </table>
        <div style="height: 120px;">
        </div>
        <table class="table3" style="width: 740px">
            <tr style="height: 50px">
                <td colspan="4">
                    1是否达到建设部《建筑工程设计文件编制深度的规定》和省有关规定要求<br />
                    施工图是否按规定盖有出图章和签署
                </td>
            </tr>
            <tr style="height: 240px">
                <td rowspan="2" style="text-align: center; width: 15%; vertical-align: middle">
                    审<br />
                    <br />
                    查<br />
                    <br />
                    报<br />
                    <br />
                    告
                </td>
                <td colspan="3">
                    <label id="Opinion2">
                    </label>
                </td>
            </tr>
            <tr style="height: 58px">
                <td colspan="3">
                    <div style="margin-left: 430px;">
                        审查人员签章:<label id="Opinion2ShenChaName"></label><br />
                        <label id="Year2">
                        </label>
                        年&nbsp;&nbsp;&nbsp;<label id="Month2"></label>&nbsp;&nbsp; 月&nbsp;&nbsp;&nbsp;<label
                            id="Day2"></label>&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                </td>
            </tr>
            <tr style="height: 50px">
                <td colspan="4">
                    1.本深基坑工程是否进行坑震设计<br />
                    2.是否损害公众利益
                </td>
            </tr>
            <tr style="height: 240px">
                <td rowspan="2" style="text-align: center; width: 15%; vertical-align: middle">
                    审<br />
                    <br />
                    查<br />
                    <br />
                    报<br />
                    <br />
                    告
                </td>
                <td colspan="3">
                    <label id="Opinion3">
                    </label>
                </td>
            </tr>
            <tr style="height: 58px">
                <td colspan="3">
                    <div style="margin-left: 430px;">
                        审查人员签章:<label id="Opinion3ShenChaName"></label><br />
                        <label id="Year3">
                        </label>
                        年&nbsp;&nbsp;&nbsp;<label id="Month3"></label>&nbsp;&nbsp; 月&nbsp;&nbsp;&nbsp;<label
                            id="Day3"></label>&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                </td>
            </tr>
            <tr style="height: 50px">
                <td colspan="4" style="text-align: center">
                    施工图审查机构综合结构
                </td>
            </tr>
            <tr style="height: 240px">
                <td rowspan="2" style="text-align: center; width: 15%; vertical-align: middle">
                    审<br />
                    <br />
                    查<br />
                    <br />
                    报<br />
                    <br />
                    告
                </td>
                <td colspan="3">
                    <label id="Opinion4">
                    </label>
                </td>
            </tr>
            <tr style="height: 58px">
                <td colspan="3">
                    <div style="margin-left: 430px;">
                        审查人员签章:<label id="Opinion4ShenChaName"></label><br />
                        <label id="Year4">
                        </label>
                        年&nbsp;&nbsp;&nbsp;<label id="Month4"></label>&nbsp;&nbsp; 月&nbsp;&nbsp;&nbsp;<label
                            id="Day4"></label>&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
                </td>
            </tr>
        </table>
        <div style="height: 5px">
        </div>
        <table class=" table3" style="width: 740px">
            <tr style="height: 50px; width: 100%">
                <td colspan="4" style="text-align: center">
                    备 注
                </td>
            </tr>
            <tr style="height: 250px">
                <td colspan="4">
                    <label id="Opinion5">
                    </label>
                </td>
            </tr>

        </table>
    </div>
    </form>
</body>
</html>
