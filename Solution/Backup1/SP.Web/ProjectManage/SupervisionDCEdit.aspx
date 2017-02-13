<%@ Page Title="危险源及控制清单" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master"
    AutoEventWireup="true" CodeBehind="SupervisionDCEdit.aspx.cs" Inherits="SP.Web.SupervisionDCEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
        .aim-ui-td-caption
        {
            text-align: right;
        }
        body
        {
            background-color: #F2F2F2;
        }
        fieldset
        {
            margin: 15px;
            width: 100%;
            padding: 5px;
        }
        fieldset legend
        {
            font-size: 12px;
            font-weight: bold;
        }
        /*
        .x-superboxselect-display-btns
        {
            width: 90% !important;
        }*/.x-form-field-trigger-wrap
        {
            width: 100% !important;
        }
    </style>

    <script type="text/javascript">

        function onPgLoad() {
            setPgUI();
            IniCheckBoxGroup();
            IniGrid();
        }
        function setPgUI() {
            if (pgOperation == "c" || pgOperation == "cs") {
                $("#CreateName").val(AimState.UserInfo.Name);
                $("#CreateTime").val(jQuery.dateOnly(AimState.SystemInfo.Date));
            }
            FormValidationBind('btnSubmit', SuccessSubmit);
            $("#btnCancel").click(function() {
                window.close();
            });
        }
        function IniCheckBoxGroup() {
            var itemarray = [];
            var dsarray = $("#DangerSourceIds").val().split(',');
            $.each(AimState["DSEnts"], function() {
                var p = this;
                var sel = false;
                $.each(dsarray, function() {//已选择的业务类型 
                    if (this && this == p.Id) {
                        sel = true;
                        return false;
                    }
                });
                itemarray.push({ boxLabel: p.DangerName, name: p.Id, checked: sel });
            })
            cbg = new Ext.form.CheckboxGroup({
                id: 'myGroup',
                xtype: 'checkboxgroup',
                fieldLabel: 'Single Column',
                itemCls: 'x-check-group-alt',
                renderTo: 'div1',
                columns: 4,
                items: itemarray
            })
        }
        function IniGrid() { 
            var myData2 = { total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            }
            var store2 = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData2,
                fields: [{ name: 'Id' }, { name: 'DangerName' }, { name: 'ControlMethod'}]
            });
            //            var tlBar2 = new Ext.Toolbar({
            //                items: [{
            //                    text: '添加',
            //                    iconCls: 'aim-icon-add',
            //                    handler: function() {
            //                        OPNSelect();
            //                    }
            //                }, '-',
            //            {
            //                text: '删除 ',
            //                iconCls: 'aim-icon-delete',
            //                handler: function() {
            //                    var recs = grid2.getSelectionModel().getSelections();
            //                    if (recs.length > 0) {
            //                        store2.remove(recs);
            //                    }
            //                }
            //            }, '->']
            //            });
            var grid2 = new Ext.ux.grid.AimGridPanel({
                title: '控制措施',
                store: store2,
                renderTo: 'div2',
                height: 200,
                // tbar: tlBar2,
                autoExpandColumn: 'ControlMethod',
                columns: [
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'Id', dataIndex: 'Id', header: 'Id', hidden: true },
                    { id: 'DangerName', dataIndex: 'DangerName', header: '危险源', width: 200 },
                    { id: 'ControlMethod', dataIndex: 'ControlMethod', header: '控制措施' }
                    ]
            });
        }
        function SuccessSubmit() {
            AimFrm.submit(pgAction, {}, null, SubFinish);
        }
        function SubFinish(args) {
            RefreshClose();
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            危险源及控制清单</h1>
    </div>
    <div id="editDiv" align="center">
        <table class="aim-ui-table-edit">
            <tbody>
                <tr style="display: none">
                    <td>
                        <input id="Id" name="Id" />
                        <input id="DangerSourceIds" name="DangerSourceIds" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        项目名称
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input id="ProjectId" name="ProjectId" type="hidden" />
                        <input id="ProjectName" name="ProjectName" aimctrl='popup' class="wai" popurl="/CommonPages/Select/ProjectSelect.aspx?seltype=single&cid=2"
                            popparam="ProjectId:Id;ProjectName:ProjectName;PManagerName:PManagerName;PManagerId:PManagerId;ShiGongUnit:BelongDeptName"
                            popstyle="width=450,height=450" style="width: 87%" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        施工单位
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input id="ShiGongUnit" name="ShiGongUnit" style="width: 87%" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        项目总监
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="PManagerName" name="PManagerName" />
                    </td>
                    <td class="aim-ui-td-caption">
                        附件
                    </td>
                    <td class="aim-ui-td-data">
                        <input id="FileId" name="FileId" aimctrl="file" mode="single" style="width: 76%" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        危险源
                    </td>
                    <td colspan="3">
                        <div id="div1">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        备注
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <textarea id="WorkRecord" name="WorkRecord" rows="3" style="width: 87%"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-button-panel" colspan="4">
                        <a id="btnSubmit" class="aim-ui-button submit">保存</a> <a id="btnCancel" class="aim-ui-button cancel">
                            取消</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div id="div2">
    </div>
</asp:Content>
