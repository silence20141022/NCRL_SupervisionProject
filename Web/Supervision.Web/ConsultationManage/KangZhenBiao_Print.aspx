<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KangZhenBiao_Print.aspx.cs"
    Inherits="SP.Web.ConsultationManage.KangZhenBiao_Print" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .underline
        {
            display: -moz-inline-box;
            display: inline-block;
            height: 15px;
            border-bottom: 1px solid #000;
        }
        .table_gaikuang
        {
            font-size: 15px;
            text-align: center;
            border-collapse: collapse;
            border: 1px solid #000;
        }
        .table_gaikuang tr
        {
            height: 33px;
        }
        .table_gaikuang td
        {
            border: solid #000 1px;
            padding-left: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div style="text-align: center; font-size: 25px; padding-top: 90px; width: 710px">
            建设工程施工图设计文件抗震设防
        </div>
        <div style="text-align: center; font-size: 25px; margin-top: 30px; margin-bottom: 30px;
            width: 710px">
            专项审查监管表</div>
        <div>
            <table width="710px" class="table_gaikuang">
                <tr>
                    <td colspan="2">
                        建设项目名称
                    </td>
                    <td colspan="4">
                        <label id="lbProjectName" runat="server">
                        </label>
                    </td>
                    <td>
                        建筑面积
                    </td>
                    <td>
                        <label id="lbBuildingArea" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        建设地点
                    </td>
                    <td colspan="4">
                        <label id="lbDetailLocation" runat="server">
                        </label>
                    </td>
                    <td>
                        工程等级
                    </td>
                    <td>
                        <label id="lbEngineeringLevel" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        建设单位名称
                    </td>
                    <td colspan="4">
                        <label id="lbJianSheUnit" runat="server">
                        </label>
                    </td>
                    <td>
                        项目负责人
                    </td>
                    <td>
                        <label id="lbJianSheUnitHead" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        勘察单位名称
                    </td>
                    <td colspan="4">
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
                        资质等级
                    </td>
                    <td colspan="4">
                        <label id="lbKanChaZZLevel" runat="server">
                        </label>
                    </td>
                    <td>
                        证书编号
                    </td>
                    <td>
                        <label id="lbKanChaUnitZSNo" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        设计单位名称
                    </td>
                    <td colspan="4">
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
                        资质等级
                    </td>
                    <td colspan="2">
                        <label id="lbSheJiUnitGrade" runat="server">
                        </label>
                    </td>
                    <td>
                        证书编号
                    </td>
                    <td>
                        <label id="lbSheJiUnitZSNo" runat="server">
                        </label>
                    </td>
                    <td>
                        注册结构师
                    </td>
                    <td>
                        <label id="lbZhuCeJiGouShi" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        施工图审查机构
                    </td>
                    <td colspan="4">
                        江西瑞林工程咨询有限公司
                    </td>
                    <td>
                        资质等级
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        新建
                        <label id="lbXinJian" runat="server">
                        </label>
                    </td>
                    <td colspan="3">
                        改建
                        <label id="lbGaiJian" runat="server">
                        </label>
                    </td>
                    <td colspan="2">
                        扩建<label id="lbKuoJian" runat="server"></label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        是否属超限高层
                    </td>
                    <td colspan="2">
                        <label id="lbIfChaoGao" runat="server">
                        </label>
                    </td>
                    <td>
                        抗震设防烈度
                    </td>
                    <td>
                        <label id="lbKangZhenLieDu" runat="server">
                        </label>
                    </td>
                    <td>
                        建筑类别
                    </td>
                    <td>
                        <label id="lbProjectType" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 60px">
                        层数
                    </td>
                    <td style="width: 60px">
                        <label id="lbLayer" runat="server">
                        </label>
                    </td>
                    <td style="width: 70px">
                        底层层高
                    </td>
                    <td style="width: 50px">
                        <label id="Label1" runat="server">
                        </label>
                    </td>
                    <td style="width: 100px">
                        檐口高度
                    </td>
                    <td style="width: 80px">
                        <label id="Label2" runat="server">
                        </label>
                    </td>
                    <td>
                        是否进行场地性能测定
                    </td>
                    <td style="width: 70px">
                        <label id="Label3" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" rowspan="2">
                        结构型式
                    </td>
                    <td colspan="2">
                        上部结构型式
                    </td>
                    <td colspan="2">
                        <label id="Label4" runat="server">
                        </label>
                    </td>
                    <td>
                        场地土类别
                    </td>
                    <td>
                        <label id="Label5" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        基础型式
                    </td>
                    <td colspan="2">
                        <label id="lbFoundationType" runat="server">
                        </label>
                    </td>
                    <td>
                        抗震等级
                    </td>
                    <td>
                        <label id="Label6" runat="server">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        抗震设防专项审查意见
                    </td>
                    <td colspan="4">
                        抗震主管部门监管意见
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <div style="height: 140px; text-align: center; padding-top: 80px">
                            满足规范要求</div>
                        <div style="text-align: right; padding-right: 50px; margin-bottom: 10px">
                            审查机构(盖章)
                        </div>
                        <div style="text-align: right; padding-right: 50px">
                            <label id="lbYear1" runat="server" class="underline" style="width: 40px">
                            </label>
                            年<label id="lbMonth1" runat="server" class="underline" style="width: 20px">
                            </label>
                            月<label id="lbDay1" runat="server" class="underline" style="width: 20px">
                            </label>
                            日
                        </div>
                    </td>
                    <td colspan="4" style="vertical-align: bottom">
                        <label id="lbYear2" runat="server" class="underline" style="width: 40px">
                        </label>
                        年<label id="lbMonth2" runat="server" class="underline" style="width: 20px">
                        </label>
                        月<label id="lbDay2" runat="server" class="underline" style="width: 20px">
                        </label>
                        日
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
