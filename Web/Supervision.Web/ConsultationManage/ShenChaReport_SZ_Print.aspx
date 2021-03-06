﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShenChaReport_SZ_Print.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ShenChaReport_SZ_Print" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script src="../js/lib/jquery-1.7.1.js" type="text/javascript"></script>
    <style type="text/css">
        *
        {
            font-family: "microsoft jhenghei";
        }
        ul
        {
            list-style-type: none;
        }
        .table3 tr
        {
            height: 40px;
        }
        .table3 td
        {
            padding-left: 5px;
            border: solid #000 1px;
        }
    </style>
    <script type="text/javascript">
        var Id = getQueryString("Id");
        $(function () {
            $.ajaxSetup({
                async: false
            });
            $.post("ShenChaReport_FWJZ_Print.aspx", { action: "select", Id: Id }, function (data) {
                data = eval("(" + data + ")");
                $("#GongChenLiang").text(data.GongChenLiang);
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
                $("#Opinion5ShenChaName").text(data.Opinion5ShenChaName);
                var date5 = data.Opinion5CreateTime;
                if (date5) {
                    var str = date5.split("/");
                    $("#Year5").text(str[0]);
                    $("#Month5").text(str[1]);
                    $("#Day5").text(str[2]);
                }

                $("#Opinion6").append(data.Opinion6);
                $("#Opinion6ShenChaName").text(data.Opinion6ShenChaName);
                var date6 = data.Opinion6CreateTime;
                if (date6) {
                    var str = date6.split("/");
                    $("#Year6").text(str[0]);
                    $("#Month6").text(str[1]);
                    $("#Day6").text(str[2]);
                }

                $("#Opinion7").append(data.Opinion7);
                $("#Opinion7ShenChaName").text(data.Opinion7ShenChaName);
                var date7 = data.Opinion7CreateTime;
                if (date7) {
                    var str = date7.split("/");
                    $("#Year7").text(str[0]);
                    $("#Month7").text(str[1]);
                    $("#Day7").text(str[2]);
                }
            });
        });
        
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table width="750px" border="0" height="1050" cellspacing="0" cellpadding="0" style="text-align: center">
            <tr style="height: 100px">
                <td style="padding-top: 50px; text-align: center; vertical-align: middle" colspan="2">
                    <h1>
                        江西省市政基础设施工程施工图设计文件</h1>
                </td>
            </tr>
            <tr style="height: 500px">
                <td colspan="2" style="padding-top: 0px; text-align: center; vertical-align: top">
                    <h2>
                        审 查 报 告</h2>
                </td>
            </tr>
            <tr>
                <td style="width: 40%; text-align: right;">
                    <h3 style="letter-spacing: 6px">
                        市政工程名称:</h3>
                </td>
                <td style="width: 60%; text-align: left">
                    <label id="ProjectName1" style="border-bottom: 1px solid black;">
                    </label>
                </td>
            </tr>
            <tr>
                <td style="width: 40%; text-align: right;">
                    <h3 style="letter-spacing: 6px">
                        建设单位名称:</h3>
                </td>
                <td style="width: 60%; text-align: left">
                    <label id="JianSheUnit1" style="border-bottom: 1px solid black;">
                    </label>
                </td>
            </tr>
            <tr>
                <td style="width: 40%; text-align: right;">
                    <h3 style="letter-spacing: 6px">
                        施工图审查机构名称:</h3>
                </td>
                <td style="width: 60%; text-align: left">
                    <label id="" style="border-bottom: 1px solid black;">
                        江西瑞林工程咨询有限公司
                    </label>
                </td>
            </tr>
            <tr style="margin-top: 120px; height: 155px">
                <td colspan="2" style="font-size: 20px; text-align: center">
                    江 西 省 建 设 厅 制
                </td>
            </tr>
        </table>
        <table width="500px" border="0" height="1050" cellspacing="0" cellpadding="0" style="margin-left: auto;
            margin-right: auto">
            <tr style="height: 60px; text-align: center">
                <td style="font-size: 28px; vertical-align: middle">
                    <h4>
                        说 明</h4>
                </td>
            </tr>
            <tr style="height: 150px;">
                <td>
                    <p style="letter-spacing: 3px; line-height: 30px">
                        1、审查意见有经省建设厅考核认定的施工图审查人员认真填写，并签字、盖章。</p>
                    <p style="letter-spacing: 3px; line-height: 30px">
                        2、审查结论由施工图审查机构负责人认真填写，并签字、盖章。</p>
                    <p style="letter-spacing: 3px; line-height: 30px">
                        3、本《审查报告》系该工程项目施工图设计文件交付使用 的法律凭证。</p>
                    <p style="letter-spacing: 3px; line-height: 30px">
                        4、本审查报告一式三份，由建设单位（业主），施工图审查机构和分管的建设行政主管部门各执一份。</p>
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
        <div style="height: 50px; font-size: 22px; text-align: center; width: 750px; margin-top: 20px">
            <h2>
                江西省市政基础设施工程施工图设计文件</h2>
        </div>
        <div style="height: 65px; text-align: center; font-size: 22px; width: 750px">
            <h2>
                审 查 报 告</h2>
        </div>
        <div style="height: 35px; vertical-align: bottom; text-align: right; width: 650px;
            margin-left: auto; margin-right: auto">
            编号：
            <label id="ShenChaNo">
            </label>
        </div>
        <div>
            <table width="650px" class="table3" style="margin-left: auto; margin-right: auto;
                border-collapse: collapse; border: none; font-size: 14px">
                <tr>
                    <td style="width: 15%">
                        建设项目名称
                    </td>
                    <td style="width: 45%">
                        <label id="ProjectName">
                        </label>
                    </td>
                    <td style="width: 15%">
                        投资额(万元)
                    </td>
                    <td style="width: 25%">
                        <label id="Investment">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
                        建设地点
                    </td>
                    <td colspan="3">
                        <label id="DetailLocation">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
                        工程量
                    </td>
                    <td>
                        <label id="GongChenLiang">
                        </label>
                    </td>
                    <td>
                        规模等级
                    </td>
                    <td>
                        <label id="EngineeringLevel">
                        </label>
                    </td>
                </tr>
                <tr>
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
                <tr>
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
                <tr>
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
                <tr>
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
                <tr>
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
            </table>
            <table class="table3" width="650px" style="margin-left: auto; margin-right: auto;
                border-collapse: collapse; border: none; font-size: 14px">
                <tr style="height: 40px">
                    <td colspan="4" style="padding-left: 5px; border-top: 0">
                        1.工程基础(含软基)处理是否安全、可靠。<br />
                        2.工程结构体系是否安全、可靠。<br />
                        3.工程配套结构(涵管、档土墙)是否安全、可靠。
                    </td>
                </tr>
                <tr style="height: 410px">
                    <td rowspan="2" style="text-align: center; width: 30px; vertical-align: middle">
                        审<br />
                        <br />
                        查<br />
                        <br />
                        意<br />
                        <br />
                        见
                    </td>
                    <td colspan="3" style="border-bottom: 0">
                        <label id="Opinion1">
                        </label>
                    </td>
                </tr>
                <tr style="height: 48px">
                    <td colspan="3" style="text-align: right; border-top: 0">
                        <div style="padding-right: 30px">
                            审查人员签章:<label id="Opinion1ShenChaName"></label></div>
                        <div style="padding-right: 30px">
                            <label id="Year1">
                            </label>
                            年&nbsp;&nbsp;<label id="Month1"></label>&nbsp; 月&nbsp;&nbsp;<label id="Day1"></label>&nbsp;日
                        </div>
                    </td>
                </tr>
            </table>
            <div style="height: 10px">
            </div>
            <table class="table3" width="650px" style="margin-left: auto; margin-right: auto;
                border-collapse: collapse; border: none; font-size: 14px">
                <tr style="height: 40px">
                    <td colspan="4" style="text-align: center; width: 100%">
                        是否符合有关工程强制性标准规范
                    </td>
                </tr>
                <tr style="height: 260px">
                    <td rowspan="2" style="text-align: center; width: 30px; vertical-align: middle">
                        审<br />
                        <br />
                        查<br />
                        <br />
                        意<br />
                        <br />
                        见
                    </td>
                    <td colspan="3" style="border-bottom: 0">
                        <label id="Opinion2">
                        </label>
                    </td>
                </tr>
                <tr style="height: 48px">
                    <td colspan="3" style="text-align: right; border-top: 0">
                        <div style="padding-right: 30px">
                            审查人员签章:<label id="Opinion2ShenChaName"></label>
                        </div>
                        <div style="padding-right: 30px">
                            <label id="Year2">
                            </label>
                            年&nbsp;&nbsp;<label id="Month2"></label>&nbsp;&nbsp; 月&nbsp;&nbsp;<label id="Day2"></label>&nbsp;日
                        </div>
                    </td>
                </tr>
                <tr style="height: 40px">
                    <td colspan="4" style="text-align: center">
                        是否按批准的初步设计文件进行施工图设计
                    </td>
                </tr>
                <tr style="height: 260px">
                    <td rowspan="2" style="text-align: center; vertical-align: middle">
                        审<br />
                        <br />
                        查<br />
                        <br />
                        意<br />
                        <br />
                        见
                    </td>
                    <td colspan="3" style="border-bottom: 0">
                        <label id="Opinion3">
                        </label>
                    </td>
                </tr>
                <tr style="height: 48px">
                    <td colspan="3" style="text-align: right; border-top: 0">
                        <div style="padding-right: 30px">
                            审查人员签章:<label id="Opinion3ShenChaName"></label></div>
                        <div style="padding-right: 30px">
                            <label id="Year3">
                            </label>
                            年&nbsp;&nbsp;<label id="Month3"></label>&nbsp; 月&nbsp;&nbsp;&nbsp;<label id="Day3"></label>&nbsp;日
                        </div>
                    </td>
                </tr>
                <tr style="height: 50px">
                    <td colspan="4" style="padding-left: 5px">
                        1.是否达到建设部《市政公用工程设计文件编制深度的规定》和省有关规定要求；<br />
                        2.施工图是否按规定盖有出图章和签署。
                    </td>
                </tr>
                <tr style="height: 250px">
                    <td rowspan="2" style="text-align: center; vertical-align: middle">
                        审<br />
                        <br />
                        查<br />
                        <br />
                        意<br />
                        <br />
                        见
                    </td>
                    <td colspan="3" style="border-bottom: 0">
                        <label id="Opinion4">
                        </label>
                    </td>
                </tr>
                <tr style="height: 48px">
                    <td colspan="3" style="text-align: right; border-top: 0">
                        <div style="padding-right: 30px">
                            审查人员签章:<label id="Opinion4ShenChaName"></label>
                        </div>
                        <div style="padding-right: 30px">
                            <label id="Year4">
                            </label>
                            年&nbsp;&nbsp;<label id="Month4"></label>&nbsp;&nbsp; 月&nbsp;&nbsp;<label id="Day4"></label>&nbsp;日</div>
                    </td>
                </tr>
            </table>
            <div style="height: 5px">
            </div>
            <table class=" table3" width="650px" style="margin-left: auto; margin-right: auto;
                border-collapse: collapse; border: none; font-size: 14px">
                <tr style="height: 40px; width: 100%">
                    <td colspan="4" style="text-align: center">
                        是否损害公众利益
                    </td>
                </tr>
                <tr style="height: 260px">
                    <td rowspan="2" style="text-align: center; width: 30px; vertical-align: middle">
                        审<br />
                        <br />
                        查<br />
                        <br />
                        意<br />
                        <br />
                        见
                    </td>
                    <td colspan="3" style="border-bottom: 0">
                        <label id="Opinion5">
                        </label>
                    </td>
                </tr>
                <tr style="height: 48px">
                    <td colspan="3" style="text-align: right; border-top: 0">
                        <div style="padding-right: 30px">
                            审查人员签章:<label id="Opinion5ShenChaName"></label>
                        </div>
                        <div style="padding-right: 30px">
                            <label id="Year5">
                            </label>
                            年&nbsp;&nbsp;<label id="Month5"></label>&nbsp;&nbsp; 月&nbsp;&nbsp;<label id="Day5"></label>&nbsp;日
                        </div>
                    </td>
                </tr>
                <tr style="height: 40px">
                    <td colspan="4" style="text-align: center">
                        施工图审查机构综合结论
                    </td>
                </tr>
                <tr style="height: 260px">
                    <td rowspan="2" style="text-align: center; width: 30px; vertical-align: middle">
                        审<br />
                        <br />
                        查<br />
                        <br />
                        意<br />
                        <br />
                        见
                    </td>
                    <td colspan="3" style="border-bottom: 0">
                        <label id="Opinion6">
                        </label>
                    </td>
                </tr>
                <tr style="height: 48px">
                    <td colspan="3" style="text-align: right; border-top: 0">
                        <div style="padding-right: 30px">
                            <div style="float: left; padding-left: 20px">
                                负责人签字：<label id="Opinion6ShenChaName"></label>
                            </div>
                            <div>
                                审查机构(盖章)
                            </div>
                        </div>
                        <div style="padding-right: 30px">
                            <label id="Year6">
                            </label>
                            年&nbsp;&nbsp;<label id="Month6"></label>&nbsp;月&nbsp;&nbsp;<label id="Day6"></label>&nbsp;&nbsp;日
                        </div>
                    </td>
                </tr>
                <tr style="height: 40px">
                    <td colspan="4" style="text-align: center">
                        建设行政主管部门备案意见
                    </td>
                </tr>
                <tr style="height: 260px">
                    <td colspan="4" style="border-bottom: 0">
                        <label id="Opinion7">
                        </label>
                    </td>
                </tr>
                <tr style="height: 48px">
                    <td colspan="3" style="text-align: right; border-top: 0">
                        <div style="padding-right: 30px">
                            (盖章)
                        </div>
                        <div style="padding-right: 30px">
                            <label id="Year7">
                            </label>
                            年&nbsp;&nbsp;<label id="Month7"></label>&nbsp; 月&nbsp;&nbsp;<label id="Day7"></label>&nbsp;日
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
