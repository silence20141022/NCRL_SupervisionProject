<%@ Page Title="审查任务管理" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="OpinionCoverPrint.aspx.cs" Inherits="SP.Web.OpinionCoverPrint" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0"
        height="0">
    </object>
    <style type="text/css">
        body
        {
            padding: 0px;
            margin: 0px;
            background-color: #fff !important;
        }
        .one
        {
            width: 480px;
            border-bottom: 1px solid black;
        }
        .two
        {
            width: 300px;
            border-bottom: 1px solid black;
        }
        .three
        {
            width: 100px;
            border-bottom: 1px solid black;
        }
        
        #one div
        {
            margin-top: 70px;
        }
        
        #one table
        {
            line-height: 30px;
        }
        #two
        {
            margin-top: 360px;
        }
        p
        {
            margin-top: 20px;
        }
    </style>
    <script type="text/javascript">
        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            if (AimState["FormData"]) {
                var formData = AimState["FormData"];
                $("#ZiXunCode").text(formData.ZiXunCode);
                $("#ProjectName").text(formData.ProjectName);
                $("#JianSheUnit").text(formData.JianSheUnit);
                $("#DetailLocation").text(formData.DetailLocation);
                $("#SheJiUnit").text(formData.SheJiUnit);
                $("#SheJiUnitGrade").text(formData.SheJiUnitGrade);
                $("#KanChaUnit").text(formData.KanChaUnit);
                $("#KanChaZZLevel").text(formData.KanChaZZLevel);
                $("#SendTime").text(formData.SendTime);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div style="width: 730px;">
        <div id="one" style="width: 100%; text-align: center;">
            <div style="text-align: center; font-size: 28px; font-weight: bold;">
                房屋建筑和市政基础设施工程施工图设计
            </div>
            <div style="text-align: center; font-size: 28px; font-weight: bold;">
                文件审查记录表
            </div>
            <div style="font-size: 20px; text-align: center;">
                <label style="font-weight: bold; border-bottom: 0;">
                    施工图审查编号：<label style="border-bottom: 0;" id="ZiXunCode"></label>
                </label>
            </div>
            <div style="text-align: center; width: 100%; margin-top: 50px;">
                <table style="margin: auto; font-size: 19px;">
                    <tr>
                        <td colspan="2">
                            建设单位：<label id="JianSheUnit" class="one"></label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            建设地点：<label id="DetailLocation" class="one"></label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            工程名称：<label id="ProjectName" class="one"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            设计单位：<label id="SheJiUnit" class="two"></label>
                        </td>
                        <td>
                            资质等级：<label id="SheJiUnitGrade" class="three"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            勘察单位：<label id="KanChaUnit" class="two"></label>
                        </td>
                        <td>
                            资质等级：<label id="KanChaZZLevel" class="three"></label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            文件发出时间：<label id="SendTime"></label>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="text-align: center; font-size: 28px; font-weight: bold; margin-top: 100px;">
                江西瑞林工程咨询有限公司</div>
            <div style="font-size: 18px; text-align: center; margin-top: 40px;">
                南昌市城乡建设委员会制</div>
        </div>
        <div id="two" style="width: 100%;">
            <div style="font-size: larger; font-weight: bold; margin-top: 20px; margin-left: 50px">
                审查依据：</div>
            <div style="text-align: center;">
                <table cellpadding="0" cellspacing="0" border="0" style="margin: auto; font-size: 18px;
                    margin-top: 35px;">
                    <tr style="height: 35px;">
                        <td>
                            （1）、
                        </td>
                        <td>
                            《建设工程勘察设计管理条例》；
                        </td>
                    </tr>
                    <tr style="height: 35px; margin-top: 20px;">
                        <td>
                            （2）、
                        </td>
                        <td>
                            &nbsp; 第134号部令《房屋建筑和市政基础设施工程施工图设
                        </td>
                    </tr>
                    <tr style="height: 35px; margin-top: 20px;">
                        <td>
                        </td>
                        <td>
                            &nbsp; 计文件审查管理办法》
                        </td>
                    </tr>
                    <tr style="height: 35px; margin-top: 20px;">
                        <td>
                            （3）、
                        </td>
                        <td>
                            《江西省建筑工程施工图设计文件审查暂行办法》及赣
                        </td>
                    </tr>
                    <tr style="height: 35px; margin-top: 20px;">
                        <td>
                        </td>
                        <td>
                            &nbsp;建设[2005]25号文件；
                        </td>
                    </tr>
                    <tr style="height: 35px; margin-top: 20px;">
                        <td>
                            （4）、
                        </td>
                        <td>
                            《中华人名共和国工程建设标准强制性条文》；
                        </td>
                    </tr>
                    <tr style="height: 35px; margin-top: 20px;">
                        <td>
                            （5）、
                        </td>
                        <td>
                            &nbsp; 国家现行相关工程设计规程、规范。
                        </td>
                    </tr>
                </table>
            </div>
            <div style="font-size: larger; font-weight: bold; margin-top: 30px; margin-left: 50px">
                注意事项：</div>
            <div style="text-align: center;">
                <table cellpadding="0" cellspacing="0" border="0" style="margin: auto; font-size: 18px;
                    margin-top: 35px;">
                    <tr style="height: 35px;">
                        <td>
                            1、
                        </td>
                        <td>
                            勘察、设计整改回复书要求根据审查意见逐条答复，
                        </td>
                    </tr>
                    <tr style="height: 35px; margin-top: 20px;">
                        <td>
                        </td>
                        <td>
                            并注明变更的图号，文稿及出图均需采用电脑打印。
                        </td>
                    </tr>
                    <tr style="height: 35px; margin-top: 20px;">
                        <td>
                            2、
                        </td>
                        <td>
                            设计变更图需采用蓝图变更，变更的图号加上“修
                        </td>
                    </tr>
                    <tr style="height: 35px; margin-top: 20px;">
                        <td>
                        </td>
                        <td>
                            改”与原图区分。
                        </td>
                    </tr>
                    <tr style="height: 35px; margin-top: 20px;">
                        <td>
                            3、
                        </td>
                        <td style="font-weight: bold">
                            整改回复书及“设计变更”壹式肆份。由更改人（变
                        </td>
                    </tr>
                    <tr style="height: 35px; margin-top: 20px; font-weight: bold">
                        <td>
                        </td>
                        <td>
                            更人）签字、加盖单位红章。
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
