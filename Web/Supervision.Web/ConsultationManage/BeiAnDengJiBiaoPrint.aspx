<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeiAnDengJiBiaoPrint.aspx.cs"
    Inherits="SP.Web.ConsultationManage.BeiAnDengJiBiaoPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .underline
        {
            display: -moz-inline-box;
            display: inline-block;
            height: 25px;
            border-bottom: 1px solid #000;
        }
        .table_gaikuang
        {
            border-collapse: collapse;
            border: 1px solid #000;
        }
        .table_gaikuang tr
        {
            height: 40px;
        }
        .table_gaikuang td
        {
            border: solid #000 1px;
            padding-left: 5px;
        }
    </style>
</head>
<body>
    <div>
        <div style="text-align: right; padding-right: 50px; margin-top: 100px; font-size: 20px">
            备案编号：<label id="lbBeiAnNo" runat="server" class="underline" style="width: 160px"></label></div>
        <div style="text-align: center; margin-top: 20px; font-size: 40px">
            施工图设计文件审查备案
        </div>
        <div style="font-weight: 800; text-align: center; font-size: 50px; margin-top: 100px;
            margin-bottom: 100px">
            登
        </div>
        <div style="font-weight: 800; text-align: center; font-size: 50px; margin-top: 100px;
            margin-bottom: 100px">
            记
        </div>
        <div style="font-weight: 800; text-align: center; font-size: 50px; margin-top: 100px;
            margin-bottom: 100px">
            表
        </div>
        <div style="padding-left: 150px; font-size: 20px; margin-top: 90px; margin-bottom: 30px">
            项目名称：<label id="lbProjectName" runat="server" class="underline"></label>
        </div>
        <div style="padding-left: 150px; font-size: 20px; margin-top: 30px; margin-bottom: 60px">
            施工图审查机构：<label id="lbShenChaJiGou" runat="server" class="underline"></label>
        </div>
        <div style="text-align: center; font-size: 20px">
            江西省建设厅制
        </div>
        <div style="height: 200px">
        </div>
        <!--第一页结束-->
        <div style="text-align: center; margin-top: 50px">
            <h3>
                一、工程概况</h3>
        </div>
        <div>
            <table width="710px" class="table_gaikuang">
                <tr>
                    <td>
                        工程名称
                    </td>
                    <td colspan="5">
                        <label id="lbGongChengName" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
                        工程地址
                    </td>
                    <td colspan="5">
                        <label id="lbDetailLocation" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
                        建设单位
                    </td>
                    <td colspan="5">
                        <label id="lbJianSheUnit" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
                        建筑面积(㎡)
                    </td>
                    <td>
                        <label id="lbBuildingArea" runat="server">
                        </label>
                    </td>
                    <td>
                        预算投资(万元)
                    </td>
                    <td colspan="3">
                        <label id="lbInvestment" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
                        建筑高度(m)
                    </td>
                    <td>
                        <label id="lbHeight" runat="server">
                        </label>
                    </td>
                    <td>
                        层数
                    </td>
                    <td colspan="3">
                        <label id="lbLayer" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
                        结构体系
                    </td>
                    <td>
                        <label id="lbStructureType" runat="server">
                        </label>
                    </td>
                    <td>
                        基础型式
                    </td>
                    <td colspan="3">
                        <label id="lbFoundationType" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 24%">
                        工程勘察等级
                    </td>
                    <td style="width: 20%">
                        <label id="lbKanChaGCLevel" runat="server">
                        </label>
                    </td>
                    <td style="width: 20%">
                        建筑工程设计等级
                    </td>
                    <td style="width: 13%">
                        <label id="lbSheJiLevel" runat="server">
                        </label>
                    </td>
                    <td style="width: 13%">
                        建筑物类型
                    </td>
                    <td style="width: 14%">
                        <label id="lbJianZhuLeiXing" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
                        市政项目工程规模指标
                    </td>
                    <td>
                        <label id="lbShiZhengZhiBiao" runat="server">
                        </label>
                    </td>
                    <td>
                        市政项目设计规模
                    </td>
                    <td colspan="3">
                        <label id="lbShiZhengGuiMo" runat="server">
                        </label>
                    </td>
                </tr>
            </table>
        </div>
        <div style="text-align: center; margin-top: 80px">
            <h3>
                二、工程勘察概况</h3>
        </div>
        <div>
            <table width="710px" class="table_gaikuang" style="text-align: center">
                <tr>
                    <td colspan="2">
                        工程勘察单位
                    </td>
                    <td colspan="3">
                        <label id="lbKanChaUnit" runat="server">
                        </label>
                    </td>
                    <td>
                        项目负责人
                    </td>
                    <td>
                        <label id="lbKanChaUnitHead" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        勘察资质范围及等级
                    </td>
                    <td>
                        <label id="lbKanChaZZLevel" runat="server">
                        </label>
                    </td>
                    <td>
                        证书号码
                    </td>
                    <td colspan="3">
                        <label id="lbKanChaUnitZSNo" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        外省单位是否办理进赣备案
                    </td>
                    <td>
                        <label id="lbKanChaIfBeiAn" runat="server">
                        </label>
                    </td>
                    <td>
                        进赣备案号
                    </td>
                    <td colspan="3">
                        <label id="lbKanChaUnitBeiAnNo" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td rowspan="5">
                        项<br />
                        目<br />
                        勘<br />
                        察<br />
                        人<br />
                        员<br />
                        情<br />
                        况
                    </td>
                    <td>
                        专业
                    </td>
                    <td>
                        姓名
                    </td>
                    <td>
                        注册执业印章号码
                    </td>
                    <td colspan="3">
                        身份证号码(外省单位)
                    </td>
                </tr>
                <tr>
                    <td>
                        注册岩土工程师
                    </td>
                    <td>
                        <label id="lbKanChaUserName" runat="server">
                        </label>
                    </td>
                    <td>
                        <label id="lbKanChaYinZhangHao" runat="server">
                        </label>
                    </td>
                    <td colspan="3">
                        <label id="lbKanChaShenFenZheng" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td rowspan="3">
                        其它勘察人员
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                    </td>
                    <td colspan="3">
                    </td>
                </tr>
                <tr>
                    <td style="width: 30px">
                    </td>
                    <td style="width: 175px">
                    </td>
                    <td style="width: 70px">
                    </td>
                    <td style="width: 140px">
                    </td>
                    <td style="width: 85px">
                    </td>
                    <td style="width: 95px">
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </div>
        <div style="height: 150px">
        </div>
        <div style="text-align: center; margin-top: 30px">
            <h3>
                三、工程设计概况</h3>
        </div>
        <div>
            <table width="710px" class="table_gaikuang" style="text-align: center">
                <tr>
                    <td colspan="2">
                        工程设计单位
                    </td>
                    <td>
                        <label id="lbSheJiUnit" runat="server">
                        </label>
                    </td>
                    <td>
                        项目负责人
                    </td>
                    <td>
                        <label id="lbSheJiUnitHead" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        工程设计资质范围及等级
                    </td>
                    <td>
                        <label id="lbSheJiUnitGrade" runat="server">
                        </label>
                    </td>
                    <td>
                        证书号码
                    </td>
                    <td>
                        <label id="lbSheJiUnitZSNo" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        外省单位是否办理备案
                    </td>
                    <td>
                        <label id="lbSheJiIfBeiAn" runat="server">
                        </label>
                    </td>
                    <td>
                        备案号
                    </td>
                    <td>
                        <label id="lbSheJiUnitBeiAnNo" runat="server">
                        </label>
                    </td>
                </tr>
                <asp:Literal runat="server" ID="literalSheJiUsers"></asp:Literal>
            </table>
        </div>
        <div style="text-align: center; margin-top: 30px">
            <h3>
                四、施工图审查概况</h3>
        </div>
        <div>
            <table width="710px" class="table_gaikuang" style="text-align: center">
                <tr>
                    <td colspan="2">
                        审查机构名称
                    </td>
                    <td colspan="4">
                        江西瑞林工程咨询有限公司
                    </td>
                    <td>
                        机构负责人
                    </td>
                    <td>
                        陈志军
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        审查范围</br>及认定类型
                    </td>
                    <td colspan="2">
                        <div>
                            房屋建筑一类</div>
                        <div>
                            市政工程一类</div>
                    </td>
                    <td colspan="2">
                        认定书号码
                    </td>
                    <td colspan="2">
                        <div>
                            S14102</div>
                        <div>
                            S14202</div>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        该项目勘察报告是否进行前置性审查
                    </td>
                    <td>
                    </td>
                    <td colspan="2">
                        施工图审查是否一次通过
                    </td>
                    <td>
                        <label id="lbIfYiCiPass" runat="server">
                        </label>
                    </td>
                </tr>
                <asp:Literal runat="server" ID="literal_shencha"></asp:Literal>
                <tr>
                    <td colspan="8" style="text-align: left">
                        <div style="margin-bottom: 50px; margin-top: 15px">
                            施工图审查机构法定代表签字：
                        </div>
                        <div style="margin-bottom: 40px">
                            施工图审查机构（盖章）：</div>
                        <div style="text-align: right; margin-right: 50px">
                            <label id='lbYear' class="underline" style="width: 60px">
                            </label>
                            年
                            <label id='Label6' class="underline" style="width: 30px">
                            </label>
                            月
                            <label id='Label7' class="underline" style="width: 30px">
                            </label>
                            日</div>
                    </td>
                </tr>
            </table>
        </div>
        <div style="height: 50px">
        </div>
        <div style="text-align: center; margin-top: 180px">
            <h3>
                五、建设行政主管部门备案</h3>
        </div>
        <div>
            <table width="710px" class="table_gaikuang" style="text-align: center">
                <tr>
                    <td style="width: 150px">
                        建设行政主管部门
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        备案号码
                    </td>
                    <td>
                    </td>
                </tr>
                <tr style="height: 120px">
                    <td>
                        经办人员意见
                    </td>
                    <td>
                        <label id="lbJingBanYiJian" runat="server">
                        </label>
                    </td>
                </tr>
                <tr style="height: 120px">
                    <td>
                        负责人意见
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
