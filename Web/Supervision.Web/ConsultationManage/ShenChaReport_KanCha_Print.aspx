<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShenChaReport_KanCha_Print.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ShenChaReport_KanCha_Print" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
                    <label id="lbKanChaPrjName" runat="server" style="border-bottom: 1px solid black;">
                    </label>
                </td>
            </tr>
            <tr>
                <td style="width: 50%; text-align: right;">
                    <h3>
                        建设单位名称:</h3>
                </td>
                <td style="width: 50%; text-align: left">
                    <label id="lbJianSheUnit1" runat="server" style="border-bottom: 1px solid black;">
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
            <table width="650px" border="0" cellspacing="0" cellpadding="0" style="margin-left: auto;
                margin-right: auto; height: 1050px">
                <tr style="height: 50px; text-align: center">
                    <td style="font-size: 28px; vertical-align: middle">
                        <h4>
                            说 明</h4>
                    </td>
                </tr>
                <tr style="height: 150px; font-size: 16px; letter-spacing: 5px">
                    <td style="padding-left: 50px">
                        <div style="padding-top: 15px; margin-left: auto; margin-right: auto">
                            1、审查意见有经省建设厅考核认定的施工图审查人员认真填
                        </div>
                        <div style="padding-top: 15px">
                            写，并签字、盖章。
                        </div>
                        <div style="padding-top: 15px">
                            2、审查结论由施工图审查机构负责人认真填写，并签字、盖
                        </div>
                        <div style="padding-top: 15px">
                            章。
                        </div>
                        <div style="padding-top: 15px">
                            3、本《审查报告》系该工程项目施工图设计文件交付使用的
                        </div>
                        <div style="padding-top: 15px">
                            法律凭证。
                        </div>
                        <div style="padding-top: 15px">
                            4、本《审查报告》一式三份，由建设单位(业主)、施工图审
                        </div>
                        <div style="padding-top: 15px">
                            查机构和分管的建设行政主管部门各执一份。
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
            </table>
        </div>
        <div style="height: 75px; font-size: 22px; text-align: center; font-weight: bolder;
            width: 750px; margin-top: 80px">
            江西省工程勘察审查报告
        </div>
        <div style="height: 35px; vertical-align: bottom; width: 650px; margin-left: auto;
            margin-right: auto">
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
                    <label id="lbKanChaPrjName2" runat="server">
                    </label>
                </td>
                <td style="width: 10%">
                    投资额
                </td>
                <td style="width: 13%">
                    /
                </td>
                <td style="width: 10%">
                    工程量
                </td>
                <td style="width: 17%">
                    <label id="lbZuanKongJinChi" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    建设地点
                </td>
                <td colspan="2">
                    <label id="lbDetailLocation" runat="server">
                    </label>
                </td>
                <td>
                    设计规模
                </td>
                <td colspan="2">
                    <label id="lbGongChengGuiMo" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    建设单位名称
                </td>
                <td colspan="2">
                    <label id="lbJianSheUnit" runat="server">
                    </label>
                </td>
                <td>
                    项目负责人
                </td>
                <td colspan="2">
                    <label id="lbJianSheUnitHead" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    勘察单位名称
                </td>
                <td colspan="2">
                    <label id="lbKanChaUnit" runat="server">
                    </label>
                </td>
                <td>
                    项目负责人
                </td>
                <td colspan="2">
                    <label id="lbKanChaUnitHead" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    资质等级
                </td>
                <td colspan="2">
                    <label id="lbKanChaZZLevel" runat="server">
                    </label>
                </td>
                <td>
                    证书编号
                </td>
                <td colspan="2">
                    <label id="lbKanChaUnitZSNo" runat="server">
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    见证单位名称
                </td>
                <td colspan="2">
                </td>
                <td>
                    见证人员以及编号
                </td>
                <td>
                    <label id="lbJianZhengRen">
                    </label>
                </td>
                <td>
                    <label id="lbJianZhengRenBianHao">
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
            <tr style="height: 300px">
                <td rowspan="2" style="text-align: center; width: 30px; vertical-align: middle">
                    审<br />
                    查<br />
                    意<br />
                    见
                </td>
                <td style="border-bottom: 0">
                    <div style="padding-top: 6px">
                        1、勘察报告提供的数据真实可靠；</div>
                    <div style="padding-top: 6px">
                        2、报建手续齐全；
                    </div>
                    <div style="padding-top: 6px">
                        3、按规定盖有出图章和签署；
                    </div>
                    <div style="padding-top: 6px">
                        4、工程基础含软基处理安全、可靠；
                    </div>
                    <div style="padding-top: 6px">
                        5、见证材料符合《关于加强全省建设工程勘察外业工作的意见》（赣建字2013-2）要求。</div>
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
        <div style="height: 200px;">
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
                    查<br />
                    意<br />
                    见
                </td>
                <td style="border-bottom: 0">
                    <div style="padding-top: 10px; padding-left: 10px">
                        符合有关工程强制性标准规范</div>
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
                    <div style="padding-top: 10px; padding-left: 10px">
                        符合要求</div>
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
                    查<br />
                    意<br />
                    见
                </td>
                <td style="border-bottom: 0">
                    <div style="padding-left: 30px; padding-top: 10px">
                        该岩土工程勘察报告按照审查意见经回复整改后符合国家有关《工程建设标</div>
                    <div style="padding-top: 10px">
                        准强制性条文》及国家和本省的各种建设工程设计规范、标准要求。</div>
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
