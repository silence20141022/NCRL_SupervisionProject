<%@ Page Title="房屋建筑" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="ShenChaFWdy.aspx.cs" Inherits="SP.Web.ShenChaFWdy" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        *
        {
            font-family: "宋体";
            color: #000000;
        }
        body
        {
            background-color: #fff;
        }
        .Opinion
        {
            padding: 5px 5px 5px 5px;
        }
        label
        {
            padding-left: 5px;
        }
    </style>
    <script type="text/javascript">
        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            var pi = AimState["ProjectInfo"];
            $("#ProjectName").text(pi.ProjectName);     //项目名称
            $("#Investment").text(pi.Investment);   //投资额
            $("#DetailLocation").text(pi.DetailLocation);     //建设地点
            $("#EngineeringLevel").text(pi.EngineeringLevel);   //工程等级
            $("#Height").text(pi.Height);    //建筑高度
            $("#CengShu").text("地上" + pi.UpperLayers + "层  地下" + pi.DownLayers + "层");               //cj  层级 为 楼层上层层数+楼层下层层数  字符串拼接
            $("#BuildingArea").text(pi.BuildingArea);     //建筑面积(㎡)
            $("#JianSheUnit").text(pi.JianSheUnit);     //建设单位
            $("#JianSheUnitHead").text(pi.JianSheUnitHead);     //建设单位负责人
            $("#KanChaUnit").text(pi.KanChaUnit);     //勘察单位
            $("#KanChaUnitHead").text(pi.KanChaUnitHead);     //勘察单位负责人
            $("#KanChaZZLevel").text(pi.KanChaZZLevel);     //勘察单位资质等级
            $("#KanChaUnitZSNo").text(pi.KanChaUnitZSNo);     //勘察单位证书编号
            $("#SheJiUnit").text(pi.SheJiUnit);     //设计单位
            $("#SheJiUnitHead").text(pi.SheJiUnitHead);     //设计单位负责人
            $("#SheJiUnitGrade").text(pi.SheJiUnitGrade);     //设计单位资质等级 
            $("#SheJiUnitZSNo").text(pi.SheJiUnitZSNo);     //设计单位证书编号
            $("#IfChaoGao").text((pi.IfChaoGao == "0" ? "否" : "是"));     //超高建筑
            $("#lbProjectName").text(pi.ProjectName);
            $("#lbJianSheUnit").text(pi.JianSheUnit);
            var reportInfo = AimState["ReportInfo"];
            $("#ShenChaNo").text(reportInfo.ShenChaNo);
            $("#Opinion1").text(reportInfo.Opinion1) + "";
            $("#Opinion2").text(reportInfo.Opinion2) + "";
            $("#Opinion3").text(reportInfo.Opinion3) + "";
            $("#Opinion4").text(reportInfo.Opinion4) + "";
            $("#Opinion5").text(reportInfo.Opinion5) + "";
            $("#Opinion6").text(reportInfo.Opinion6) + "";
            $("#Opinion7").text(reportInfo.Opinion7) + "&nbsp;";
        } 
    </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div style="text-align: center">
        <table width="730px" border="0" height="1050" cellspacing="0" cellpadding="0">
            <tr style="height: 55px">
                <td style="padding-top: 190px; font-size: 28px; text-align: center; vertical-align: middle"
                    colspan="2">
                    <h1>
                        江西省房屋建筑工程施工图设计文件</h1>
                </td>
            </tr>
            <tr style="height: 220px">
                <td colspan="2" style="padding-top: 50px; font-size: 22px; text-align: center; vertical-align: top">
                    <h2>
                        审 查 报 告</h2>
                </td>
            </tr>
            <tr style="height: 47px">
                <td style="width: 40%; text-align: right;">
                    <h3>
                        建筑工程名称:</h3>
                </td>
                <td style="width: 60%">
                    <label id="lbProjectName">
                    </label>
                </td>
            </tr>
            <tr style="height: 47px">
                <td style="text-align: right;">
                    <h3>
                        建设单位名称:</h3>
                </td>
                <td>
                    <label id="lbJianSheUnit">
                    </label>
                </td>
            </tr>
            <tr style="height: 47px">
                <td style="text-align: right;">
                    <h3>
                        施工图审查机构名称:</h3>
                </td>
                <td>
                    <label>
                        江西瑞林工程咨询有限公司
                    </label>
                </td>
            </tr>
            <tr style="margin-top: 120px; height: 55px">
                <td colspan="2" style="font-size: 20px; text-align: center">
                    江 西 省 建 设 厅 制
                </td>
            </tr>
        </table>
        <table width="730px" border="0" height="1050" cellspacing="0" cellpadding="0">
            <tr style="height: 60px">
                <td style="font-size: 28px; text-align: center; vertical-align: middle">
                    <h1>
                        说 明</h1>
                </td>
            </tr>
            <tr style="height: 40px">
                <td style="width: 100%">
                    1、审查意见有经省建设厅考核认定的施工图审查人员认真填写，并签字、盖章。
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    2、审查结论由施工图审查机构负责人认真填写，并签字、盖章。
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    3、本《审查报告》系该工程项目施工图设计文件交付使用的法律凭证。
                </td>
            </tr>
            <tr style="height: 40px">
                <td>
                    4、本审查报告一式三份，由建设单位（业主）、施工图审查机构和分管的建设行政主管部门各执一份。
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
        </table>
        <div style="height: 65px; font-size: 22px; text-align: center; width: 730px; margin-top: 20px">
            <h2>
                江西省房屋建筑工程施工图设计文件</h2>
        </div>
        <div style="height: 65px; text-align: center; font-size: 22px; width: 730px">
            <h2>
                审 查 报 告</h2>
        </div>
        <div style="height: 35px; vertical-align: bottom; text-align: right; width: 730px">
            编号：
            <label id="ShenChaNo">
            </label>
        </div>
        <table width="730px" border="1" cellspacing="0" cellpadding="0">
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
                <td colspan="3">
                    <label id="DetailLocation">
                    </label>
                </td>
            </tr>
            <tr style="height: 52px">
                <td>
                    工程等级
                </td>
                <td>
                    <label id="EngineeringLevel">
                    </label>
                </td>
                <td>
                    建筑高度
                </td>
                <td>
                    <label id="Height">
                    </label>
                </td>
            </tr>
            <tr style="height: 52px">
                <td>
                    建筑层数
                </td>
                <td>
                    <label id="CengShu">
                    </label>
                </td>
                <td>
                    建筑面积(㎡)
                </td>
                <td>
                    <label id="BuildingArea">
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
            <tr style="height: 52px">
                <td>
                    是否属超限高层建筑工程
                </td>
                <td>
                    <label id="IfChaoGao">
                    </label>
                </td>
                <td>
                </td>
                <td>
                </td>
            </tr>
            <tr style="height: 40px">
                <td colspan="4" style="text-align: center">
                    地基基础及结构体系是否安全、可靠，各专业无明显的不安全因素
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
            <tr style="height: 30px">
                <td colspan="3">
                    审查人员签章:
                </td>
            </tr>
            <tr style="height: 30px">
                <td colspan="4" style="text-align: right">
                    年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr style="height: 50px">
                <td colspan="4" style="text-align: center">
                    是否符合消防、环保、抗震、卫生、无障碍等有关强制性标准规范
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
                    <label id="Opinion2">
                    </label>
                </td>
            </tr>
            <tr style="height: 30px">
                <td colspan="3">
                    审查人员签章:
                </td>
            </tr>
            <tr style="height: 30px">
                <td colspan="4" style="text-align: right">
                    年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr style="height: 50px">
                <td colspan="4" style="text-align: center">
                    是否按批准的初步设计文件进行施工图设计
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
                    <label id="Opinion3">
                    </label>
                </td>
            </tr>
            <tr style="height: 30px">
                <td colspan="3">
                    审查人员签章:
                </td>
            </tr>
            <tr style="height: 30px">
                <td colspan="4" style="text-align: right">
                    年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr style="height: 50px">
                <td colspan="4" style="text-align: center">
                    1.是否达到建设部《市政公用工程设计文件编制深度的规定》和省有关规定要求；
                    <br />
                    2.施工图是否按规定盖有出图章和签署。
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
                    <label id="Opinion4">
                    </label>
                </td>
            </tr>
            <tr style="height: 30px">
                <td colspan="3">
                    审查人员签章:
                </td>
            </tr>
            <tr style="height: 30px">
                <td colspan="4" style="text-align: right">
                    年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr style="height: 50px">
                <td colspan="4" style="text-align: center">
                    是否损害公众利益
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
                    <label id="Opinion5">
                    </label>
                </td>
            </tr>
            <tr style="height: 30px">
                <td colspan="3">
                    审查人员签章:
                </td>
            </tr>
            <tr style="height: 30px">
                <td colspan="4" style="text-align: right">
                    年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr style="height: 50px">
                <td colspan="4" style="text-align: center">
                    施工图审查机构综合结论
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
                    <label id="Opinion6">
                    </label>
                </td>
            </tr>
            <tr style="height: 30px">
                <td colspan="3">
                    审查人员签章:
                </td>
            </tr>
            <tr style="height: 30px">
                <td colspan="4" style="text-align: right">
                    年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
            <tr style="height: 50px">
                <td colspan="4" style="text-align: center">
                    建设行政主管部门备案意见
                </td>
            </tr>
            <tr style="height: 240px">
                <td rowspan="3" style="text-align: center; vertical-align: middle">
                </td>
                <td colspan="3">
                    <label id="Opinion7">
                    </label>
                </td>
            </tr>
            <tr style="height: 30px">
                <td colspan="3">
                    审查人员签章:
                </td>
            </tr>
            <tr style="height: 30px">
                <td colspan="4" style="text-align: right">
                    年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
