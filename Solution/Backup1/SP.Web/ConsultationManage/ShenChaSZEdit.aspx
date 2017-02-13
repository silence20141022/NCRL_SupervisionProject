<%@ Page Title="市政报告" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="ShenChaSZEdit.aspx.cs" Inherits="SP.Web.ShenChaSZEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0"
        height="0">
    </object>
    <style type="text/css">
        body
        {
            padding: 0px;
            background-color: #fff !important;
            border-bottom: 4px solid #157fcc;
            border-left: 4px solid #157fcc;
            border-right: 4px solid #157fcc;
            margin: 0 auto;
        }
        
        #header
        {
            background-color: #157fcc;
            background-image: none;
            height: 36px;
            font-size: large;
            font-weight: bold;
            text-align: center;
        }
        
        #header h1
        {
            font-family: arial, helvetica, verdana, sans-serif;
            line-height: 36px;
            font-size: large;
            font-weight: bold;
            padding-left: 10px;
            padding-top: 0px;
            padding-bottom: 0px;
            font-size: large;
            text-align: center;
        }
        
        .aim-ui-button
        {
            height: 24px;
            line-height: 24px;
            background-image: url(/images/form/btn-default-small-bg.gif);
            background-position-x: 0;
            background-position-y: top;
            border-style: none;
            font-weight: bold;
        }
        
        .submit, .cancel
        {
            padding-left: 20px;
            padding-right: 20px;
        }
        
        .aim-ui-table-edit
        {
            border-width: 0px;
            align: center;
        }
        
        .aim-ui-button-panel
        {
            border: 0px;
            background-color: rgb(223, 234, 242);
            height: 36px;
        }
    </style>
    <style type="text/css">
        .bg
        {
            font-size: 18px;
            line-height: 20px;
        }
        .c
        {
            border-width: 1px;
        }
    </style>
    <script type="text/javascript">
        var id = $.getQueryString({ ID: 'id' });
        function onPgLoad() {
            $("#dy").hide();
            setPgUI();
        }

        function setPgUI() {
            if (pgOperation == "c" || pgOperation == "cs") {
                $("#CreateName").val(AimState.UserInfo.Name);
                $("#CreateTime").val(jQuery.dateOnly(AimState.SystemInfo.Date));
            } else {
                $("#dy").show();
            }


            $("#ProjectId").val(id);

            //绑定按钮验证
            FormValidationBind('btnSubmit', SuccessSubmit);

            $("#btnCancel").click(function () {
                window.close();
            });


            $("#dy").click(function () {
                doprint(id, "ShenChaSZdy.aspx");
            });

            bindpro();
        }


        function doprint(id, url) {

            try {
                var LODOP = document.getElementById("LODOP"); //这行语句是为了符合DTD规范

                LODOP.PRINT_INIT("");

                LODOP.NewPage();

                LODOP.ADD_PRINT_URL(20, 18, 750, 1050, url + '?id=' + id);
                //  LODOP.ADD_PRINT_URL(20, 18, 750, 1050, 'CommissionHanDY.aspx?id=' + id);

                LODOP.PREVIEW();
            }
            catch (ex) {
                alert("未安装打印控件，请安装打印控件");
                window.open("/install_lodop.rar", "print", "");
            }
        }


        function bindpro() {
            var dat = AimState["pro"][0];
            $("#ProjectName").html( dat.ProjectName);     //项目名称
            $("#Investment").html(dat.Investment == null ? "&nbsp;" : dat.Investment);    //投资额
            $("#BelongDeptName").html("&nbsp;" + dat.BelongDeptName);     //建设地点
            $("#EngineeringLevel").html("&nbsp;" + dat.EngineeringLevel);   //规模等级
            $("#JianSheUnit").html("&nbsp;" + dat.JianSheUnit);     //建设单位
            $("#JianSheUnitHead").html("&nbsp;" + dat.JianSheUnitHead);     //建设单位负责人
            $("#KanChaUnit").html("&nbsp;" + dat.KanChaUnit);     //勘察单位
            $("#KanChaUnitHead").html("&nbsp;" + dat.KanChaUnitHead);     //勘察单位负责人
            $("#KanChaZZLevel").html("&nbsp;" + dat.KanChaZZLevel);     //勘察单位资质等级
            //$("#").html(dat.);     //勘察单位证书编号
            $("#SheJiUnit").html("&nbsp;" + dat.SheJiUnit);     //设计单位
            $("#SheJiUnitHead").html("&nbsp;" + dat.SheJiUnitHead);     //设计单位负责人
            $("#KanChaZZLevel").html("&nbsp;" + dat.KanChaZZLevel);     //设计单位资质等级
            //$("#").html(dat.);     //设计单位资质等级
            //$("#").html(dat.);     //设计单位证书编号


            // alert(dat.Id)
        }




        //验证成功执行保存方法
        function SuccessSubmit() {
            AimFrm.submit(pgAction, {}, null, SubFinish);
        }

        function SubFinish(args) {
            RefreshClose();
        }

        function DateTimePickerEnd() {
            WdatePicker({
                dateFmt: 'yyyy-MM-dd'
            });
        }

    </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            审查报告
        </h1>
    </div>
    <div id="editDiv" width="100%" align="center">
        <center>
            <table>
                <tbody>
                    <tr style="display: none">
                        <td>
                            <input id="Id" name="Id" />
                            <input id="ShenChaUserId" name="ShenChaUserId" />
                            <input id="ProjectUserId" name="ProjectUserId" />
                            <input id="ProjectId" name="ProjectId" />
                        </td>
                    </tr>
                    <tr>
                        <td width="900px" align="center" valign="middle">
                            <table width="100%" align="center" valign="middle" class="aim-ui-table-edit" cellpadding="0"
                                cellspacing="0">
                                <tr>
                                    <td colspan="4" align="center" style="width: 20%;">
                                        <span style="font-size: 25px; font-weight: bold;">江西省市政基础设施工程施工图设计文件</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" align="center" style="width: 20%;">
                                        <span style="font-size: 24px; font-weight: bold;">审 查 报 告</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 410px; padding-left: -10px; padding-top: 20px; padding-bottom: 10px;">
                                        编号：<input name="ShenChaNo" id="ShenChaNo" />
                                    </td>
                                    <td>
                                        审查报告提交时间：<input name="ReportSubmitTime" id="ReportSubmitTime" class="Wdate" onclick="DateTimePickerEnd()"
                                            style="margin-right: -37px;" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td width="900px">
                            <table width="100%" class="aim-ui-table-edit c" border="1" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td width="120px" height="30">
                                        &nbsp;建设项目名称
                                    </td>
                                    <td width="240px" id="ProjectName">
                                        
                                    </td>
                                    <td width="120px">
                                        &nbsp; 投资额(万元)
                                    </td>
                                    <td width="120px" id="Investment">
                                    </td>
                                </tr>
                                <tr>
                                    <td height="30">
                                        &nbsp;建设地点
                                    </td>
                                    <td id="BelongDeptName">
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;规模等级
                                    </td>
                                    <td id="EngineeringLevel">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td height="30">
                                        &nbsp;建设单位名称
                                    </td>
                                    <td id="JianSheUnit">
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;项目负责人
                                    </td>
                                    <td id="JianSheUnitHead">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td height="30">
                                        &nbsp;勘察单位名称
                                    </td>
                                    <td id="KanChaUnit">
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;项目负责人
                                    </td>
                                    <td id="KanChaUnitHead">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td height="30">
                                        &nbsp;资质等级
                                    </td>
                                    <td id="KanChaZZLevel">
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;证书编号
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td height="30">
                                        &nbsp;设计单位名称
                                    </td>
                                    <td id="SheJiUnit">
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;项目负责人
                                    </td>
                                    <td id="SheJiUnitHead">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td height="30">
                                        &nbsp;资质等级
                                    </td>
                                    <td id="">
                                        &nbsp;
                                    </td>
                                    <td>
                                        &nbsp;证书编号
                                    </td>
                                    <td id="">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" height="50">
                                        1. 工程基础(含软基)处理是否安全、可靠。<br />
                                        2. 工程结构体系是否安全、可靠。<br />
                                        3. 工程配套结构（涵管、挡土墙等）是否安全、可靠。<br />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <table width="100%" class="aim-ui-table-edit" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="30" rowspan="3" align="center" class="bg">
                                                    审查报告
                                                </td>
                                            </tr>
                                            <tr>
                                                <td valign="top" style="height: 90px;">
                                                    <textarea id="Opinion1" name="Opinion1" style="height: 90px; width: 100%;"></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px;">
                                                    审查人员:<input style="margin-left: 51px; width: 236px;" id="Opinion1ShenChaName" name="Opinion1ShenChaName" />
                                                    审查时间:<input style="margin-left: 85px; width: 225px;" name="Opinion1CreateTime" id="Opinion1CreateTime"
                                                        class="Wdate" onclick="DateTimePickerEnd()" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="30" colspan="4">
                                        是否符合有关工程强制性标准规范
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <table width="100%" class="aim-ui-table-edit" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="30" rowspan="3" align="center" class="bg">
                                                    审查报告
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="90">
                                                    <textarea id="Opinion2" name="Opinion2" type="text" style="height: 90px; width: 100%"></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px;">
                                                    审查人员:<input style="margin-left: 51px; width: 236px;" id="Opinion2ShenChaName" name="Opinion2ShenChaName" />
                                                    审查时间:<input style="margin-left: 85px; width: 225px;" name="Opinion2CreateTime" id="Opinion2CreateTime"
                                                        class="Wdate" onclick="DateTimePickerEnd()" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="30" colspan="4">
                                        是否按批准的初步设计文件进行施工图设计
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <table width="100%" class="aim-ui-table-edit" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="30" rowspan="3" align="center" class="bg">
                                                    审查报告
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="90">
                                                    <textarea id="Opinion3" name="Opinion3" value="未提供初步设计文件" type="text" style="height: 90px;
                                                        width: 100%"></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px;">
                                                    审查人员:<input style="margin-left: 51px; width: 236px;" id="Opinion3ShenChaName" name="Opinion3ShenChaName" />
                                                    审查时间:<input style="margin-left: 85px; width: 225px;" name="Opinion3CreateTime" id="Opinion3CreateTime"
                                                        class="Wdate" onclick="DateTimePickerEnd()" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="30" colspan="4">
                                        1.是否达到建设部《市政公用工程设计文件编制深度的规定》和省有关规定要求；
                                        <br />
                                        2.施工图是否按规定盖有出图章和签署。
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <table width="100%" class="aim-ui-table-edit" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="30" rowspan="3" align="center" class="bg">
                                                    审查报告
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="90">
                                                    <textarea id="Opinion4" name="Opinion4" type="text" style="height: 90px; width: 100%">
                                    1.按审查意见修改后，基本达到建设部《市政公用工程设计文件编制深度规定》和省有关规定要求。
                                    2.施工图设计按规定盖有出图章和签署。
                                    </textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px;">
                                                    审查人员:<input style="margin-left: 51px; width: 236px;" id="Opinion4ShenChaName" name="Opinion4ShenChaName" />
                                                    审查时间:<input style="margin-left: 85px; width: 225px;" name="Opinion4CreateTime" id="Opinion4CreateTime"
                                                        class="Wdate" onclick="DateTimePickerEnd()" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="30" colspan="4">
                                        是否损害公众利益
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <table width="100%" class="aim-ui-table-edit" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="30" rowspan="3" align="center" class="bg">
                                                    审查报告
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="90">
                                                    <textarea id="Opinion5" name="Opinion5" type="text" style="height: 90px; width: 100%" />符合公众利益。</textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px;">
                                                    审查人员:<input style="margin-left: 51px; width: 236px;" id="Opinion5ShenChaName" name="Opinion5ShenChaName" />
                                                    审查时间:<input style="margin-left: 85px; width: 225px;" name="Opinion5CreateTime" id="Opinion5CreateTime"
                                                        class="Wdate" onclick="DateTimePickerEnd()" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="30" colspan="4">
                                        施工图审查机构综合结论
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <table width="100%" class="aim-ui-table-edit" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td width="30" rowspan="3" align="center" class="bg">
                                                    审查报告
                                                </td>
                                            </tr>
                                            <tr>
                                                <td height="90">
                                                    <textarea id="Opinion6" name="Opinion6" type="text" style="height: 90px; width: 100%"></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px;">
                                                    负责人:<input style="width: 170px;" id="FuZeName" name="FuZeName" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    审查人员:<input style="width: 170px;" id="Opinion6ShenChaName" name="Opinion6ShenChaName" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    审查时间:<input style="width: 175px;" name="Opinion6CreateTime" id="Opinion6CreateTime"
                                                        class="Wdate" onclick="DateTimePickerEnd()" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td height="30" colspan="4">
                                        建设行政主管部门备案意见
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <table width="100%" class="aim-ui-table-edit" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td height="90">
                                                    <textarea id="Opinion7" name="Opinion7" type="text" style="height: 90px; width: 100%"></textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px;">
                                                    &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;审查人员:<input
                                                        style="margin-left: 51px; width: 236px;" id="Opinion7ShenChaName" name="Opinion7ShenChaName" />
                                                    审查时间:<input style="margin-left: 85px; width: 225px;" name="Opinion7CreateTime" id="Opinion7CreateTime"
                                                        class="Wdate" onclick="DateTimePickerEnd()" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </tbody>
            </table>
        </center>
        <table class="aim-ui-table-edit">
            <tbody>
                <tr>
                    <td class="aim-ui-button-panel" colspan="4">
                        <a id="btnSubmit" class="aim-ui-button submit">保存</a> <a id="btnCancel" class="aim-ui-button cancel">
                            取消</a> <a id="dy" class="aim-ui-button cancel">打印</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</asp:Content>
