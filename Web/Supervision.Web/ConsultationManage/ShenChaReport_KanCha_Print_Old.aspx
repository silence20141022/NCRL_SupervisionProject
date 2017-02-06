<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShenChaReport_KanCha_Print_Old.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ShenChaReport_KanCha_Print_Old" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script src="../js/lib/jquery-1.7.1.js" type="text/javascript"></script>
    <style type="text/css">
        ul
        {
            list-style-type: none;
        }
        .table3
        {
            border-collapse: collapse;
            border: none;
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
                $("#ShenChaNo").text(data.ShenChaNo);
                $("#GongChenLiang").text(data.GongChenLiang);
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
                        江西省工程勘察审查报告书</h1>
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
                        工程名称:</h3>
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
                        勘察专项审查机构名称:</h3>
                </td>
                <td style="width: 50%; text-align: left">
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
        <div>
            <table width="500px" border="0" height="1050" cellspacing="0" cellpadding="0" style="margin-left: auto;
                margin-right: auto">
                <tr style="height: 50px; text-align: center">
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
        </div>
        <div style="height: 75px; font-size: 22px; text-align: center; width: 750px; margin-top: 80px">
            江西省工程勘察审查报告
        </div>
        <div style="height: 35px; vertical-align: bottom; text-align: right; width: 650px;
            margin-left: auto; margin-right: auto">
            编号：
            <label id="ShenChaNo">
            </label>
        </div>
        <table class="table3" style="width: 650px; margin-left: auto; margin-right: auto;
            font-size: 14px">
            <tr>
                <td style="width: 16%">
                    建设项目名称
                </td>
                <td style="width: 34%">
                    <label id="ProjectName">
                    </label>
                </td>
                <td style="width: 16%">
                    投资额(万元)
                </td>
                <td style="width: 34%">
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
                    设计规模
                </td>
                <td>
                    <label id="EngineeringLevel">
                    </label>
                </td>
                <td>
                    工程量
                </td>
                <td>
                    <label id="GongChenLiang">
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
        <table class="table3" style="width: 650px; margin-right: auto; margin-left: auto">
            <tr>
                <td colspan="2" style="border-top: 0px">
                    <div>
                        1、勘察报告提供的数据是否真实可靠;</div>
                    <div>
                        2、报建手续是否齐全;</div>
                    <div>
                        3、是否按规定盖有出图章和签署，资质与项目规模是否匹配;
                    </div>
                    <div>
                        4、工程基础（含软基）处理是否安全、可靠。（宏观、大的方面的审查）;
                    </div>
                </td>
            </tr>
            <tr style="height: 250px">
                <td rowspan="2" style="text-align: center; width: 30px; vertical-align: middle">
                    审<br />
                    查<br />
                    意<br />
                    见
                </td>
                <td style="border-bottom: 0">
                    <label id="Opinion1">
                    </label>
                </td>
            </tr>
            <tr style="height: 48px">
                <td style="text-align: right; border-top: 0">
                    <div style="padding-right: 30px">
                        审查人员签章:<label id="Opinion1ShenChaName"></label>
                    </div>
                    <div style="padding-right: 30px">
                        <label id="Year1">
                        </label>
                        年&nbsp;&nbsp;<label id="Month1"></label>&nbsp;&nbsp; 月&nbsp;&nbsp;<label id="Day1"></label>&nbsp;日
                    </div>
                </td>
            </tr>
        </table>
        <div style="height: 170px;">
        </div>
        <table class="table3" style="width: 650px; margin-right: auto; margin-left: auto">
            <tr>
                <td colspan="2" style="text-align: center; width: 100%">
                    是否符合有关工程强制性标准规范（违反强标方面的审查）
                </td>
            </tr>
            <tr style="height: 190px">
                <td rowspan="2" style="text-align: center; width: 30px; vertical-align: middle">
                    审<br />
                    <br />
                    查<br />
                    <br />
                    意<br />
                    <br />
                    见
                </td>
                <td style="border-bottom: 0">
                    <label id="Opinion2">
                    </label>
                </td>
            </tr>
            <tr style="height: 40px">
                <td style="text-align: right; border-top: 0">
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
            <tr>
                <td colspan="2" style="text-align: center">
                    按照建设部和省里的岩土工程勘察报告审查要点的审查
                </td>
            </tr>
            <tr style="height: 190px">
                <td rowspan="2" style="text-align: center; vertical-align: middle">
                    审<br />
                    查<br />
                    意<br />
                    见
                </td>
                <td style="border-bottom: 0">
                    <label id="Opinion3">
                    </label>
                </td>
            </tr>
            <tr style="height: 40px">
                <td style="text-align: right; border-top: 0">
                    <div style="padding-right: 30px">
                        审查人员签章:<label id="Opinion3ShenChaName"></label>
                    </div>
                    <div style="padding-right: 30px">
                        <label id="Year3">
                        </label>
                        年&nbsp;&nbsp;<label id="Month3"></label>&nbsp;&nbsp; 月&nbsp;&nbsp;<label id="Day3"></label>&nbsp;日
                    </div>
                </td>
            </tr>
            <tr style="height: 40px">
                <td colspan="2" style="text-align: center">
                    施工图审查机构综合结论
                </td>
            </tr>
            <tr style="height: 190px">
                <td rowspan="2" style="text-align: center; vertical-align: middle">
                    审<br />
                    <br />
                    查<br />
                    <br />
                    意<br />
                    <br />
                    见
                </td>
                <td style="border-bottom: 0">
                    <label id="Opinion4">
                    </label>
                </td>
            </tr>
            <tr style="height: 40px">
                <td style="text-align: right; border-top: 0">
                    <div style="padding-right: 30px;">
                        <div style="float: left; padding-left: 20px">
                            负责人签字：</div>
                        <div>
                            审查人员签章:<label id="Opinion4ShenChaName"></label></div>
                    </div>
                    <div style="padding-right: 30px">
                        <label id="Year4">
                        </label>
                        年&nbsp;&nbsp;<label id="Month4"></label>&nbsp;&nbsp; 月&nbsp;&nbsp;<label id="Day4"></label>&nbsp;日
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    备注
                </td>
            </tr>
            <tr style="height: 190px">
                <td colspan="2">
                    <label id="Opinion5">
                    </label>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
