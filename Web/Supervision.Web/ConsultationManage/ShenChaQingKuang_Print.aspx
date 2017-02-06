<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShenChaQingKuang_Print.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ShenChaQingKuang_Print" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .underline
        {
            display: -moz-inline-box;
            display: inline-block;
            height: 20px;
            border-bottom: 1px solid #000;
        }
        .table_gaikuang
        {
            font-size: 14px;
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
        <div style="margin-top: 25px; text-align: center; font-size: 22px; font-weight: 600">
            房屋建筑和市政基础设施工程施工图设计</div>
        <div style="margin-top: 15px; text-align: center; font-size: 22px; font-weight: 600">
            文件审查情况记录</div>
        <div style="width: 710px">
            <p style="font-size: 14px">
                &nbsp; &nbsp; &nbsp; &nbsp;我单位<label id="lbYear" runat="server" class="underline"></label>年<label
                    id="lbMonth" runat="server" class="underline"></label>月审查的
                <label id="lbProjectName" runat="server" class="underline">
                </label>
                项目勘察文件（编号：<label id="lbKanChaNo" runat="server"></label>）、施工图 设计文件（编号：），该项目建设单位、勘察单位、设计单位存在下列情况，记录如下：</p>
        </div>
        <div>
            <table class="table_gaikuang" width="710px" style="text-align: center">
                <tr>
                    <td style="width: 100px;">
                        责任单位
                    </td>
                    <td>
                        内容
                    </td>
                    <td style="width: 50px;">
                        是或否
                    </td>
                </tr>
                <tr>
                    <td rowspan="5">
                        建设单位
                    </td>
                    <td style="text-align: left">
                        1、施工图设计文件应审查而未经审查批准，擅自施工的；设计文件在施工过程中有重大设计变更，未将变更后的施工图报原施工图审查机构进行审查并获批准，擅自施工的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        2、采购的建筑材料、建筑构配件和设备不符合设计文件和合同要求的；明示或者暗示施工单位使用不合格的建筑材料、建筑构配件的设备的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        3、明示或者暗示勘察、设计单位违反工程建设强制性标准，降低工程质量的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        4、涉及建筑主体和承重结构变动的装修工程，没有经原设计单位或具有相应资质等级的设计单位提出设计方案，擅自施工的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        5、其他影响建设工程质量的违法违规行为。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td rowspan="10">
                        勘察单位
                    </td>
                    <td style="text-align: left">
                        1、未按照政府有关部门的批准文件要求进行勘察的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        2、未按照工程建设强制性标准进行勘察。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        3、勘察中采用可能影响工程质量和安全，且没有国家技术标准的新技术、新工艺、新材料，未按规定审定的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        4、勘察文件没有责任人签字或者签字不全的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        5、勘察原始记录不按照规定进行记录或者记录不完整的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        6、勘察文件在施工图审查批准前，经审查发现质量问题，进行一次以上修改的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        7、勘察文件经施工图审查未获批准的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        8、勘察单位不参加施工验槽的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        9、在竣工验收时未出据工程质量评估意见的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        10、其他可能影响工程勘察质量的违法违规行为。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td rowspan="10">
                        设计单位
                    </td>
                    <td style="text-align: left">
                        1、未按照政府有关部门的批准文件要求进行设计的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        2、设计单位未根据勘察文件进行设计的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        3、未按照工程建设强制性标准进行设计的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        4、设计中采用可能影响工程质量安全，且没有国家技术标准的新技术、新工艺、新材料，未按规定审定的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        5、设计文件没有责任人签字或者签字不全的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        6、设计文件在施工图审查批准前，经审查发现质量问题，进行一次以上修改的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        7、设计文件经施工图审查未获批准的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        8、在竣工验收时未出据工程质量评估意见的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        9、设计单位对施工图审查批准的设计文件，在施工前拒绝向施工单位进行设计交底的；拒绝参与建设工程质量事故分析的。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        10、其他可能影响工程设计质量的违法违规行为。
                    </td>
                    <td>
                        否
                    </td>
                </tr>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
