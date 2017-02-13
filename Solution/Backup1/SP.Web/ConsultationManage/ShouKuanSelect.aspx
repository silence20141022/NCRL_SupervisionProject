<%@ Page Title="ShouKuanSelect" Language="C#" MasterPageFile="~/Masters/Ext/IE8Site.Master"
    AutoEventWireup="true" CodeBehind="ShouKuanSelect.aspx.cs" Inherits="SP.Web.ShouKuanSelect" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="../bootstrap32/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <script src="/js/pgfunc-ext-sel.js" type="text/javascript"></script>
    <style type="text/css">
        a
        {
            margin-right: 5px;
        }
    </style>
    <script type="text/javascript">
        var myData, store, AimSelGrid, df1, df2;
        var seltype = 'multi';
        var rtntype = "array";
        Ext.override(Ext.grid.CheckboxSelectionModel, {
            handleMouseDown: function (g, rowIndex, e) {
                if (e.button !== 0 || this.isLocked()) {
                    return;
                }
                var view = this.grid.getView();
                if (e.shiftKey && !this.singleSelect && this.last !== false) {
                    var last = this.last;
                    this.selectRange(last, rowIndex, e.ctrlKey);
                    this.last = last; // reset the last     
                    view.focusRow(rowIndex);
                } else {
                    var isSelected = this.isSelected(rowIndex);
                    if (isSelected) {
                        this.deselectRow(rowIndex);
                    } else if (!isSelected || this.getCount() > 1) {
                        this.selectRow(rowIndex, true);
                        view.focusRow(rowIndex);
                    }
                }
            }
        });
        function onSelPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            df1 = new Ext.form.DateField({
                id: 'BeginDate',
                width: 150,
                renderTo: 'div2'
            })
            df2 = new Ext.form.DateField({
                id: 'EndDate',
                width: 150,
                renderTo: 'div3'
            })
            $("#search").click(function () {
                var json = { ProjectName: $("#ProjectName_s").val(), InvoiceNo: $("#InvoiceNo_s").val(), BeginDate: df1.getValue(), EndDate: df2.getValue() };
                store.reload(json);
            })
            $("#btnCancel").click(function () {
                window.close();
            })
            $("#btnSubmit").click(function () {
                AimGridSelect();
            })
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: [
			    { name: 'Id' }, { name: 'ShouKuanDate' }, { name: 'ShouKuanAmount' }, { name: 'InvoiceNo' },
			    { name: 'ProjectId' }, { name: 'ProjectName' }, { name: 'InvoiceDate' }, { name: 'Remark' }, { name: 'ZiXunCode' }
			]
            });
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            //            var buttonPanel = new Ext.form.FormPanel({
            //                region: 'south',
            //                frame: true,
            //                buttonAlign: 'center',
            //                buttons: [{ text: '确定', handler: function () { AimGridSelect(); } }, { text: '取消', handler: function () {
            //                    window.close();
            //                }
            //                }]
            //            });
            //            schBar = new Ext.ux.AimSchPanel({
            //                store: store,
            //                collapsed: false,
            //                items: [
            //                        { fieldLabel: '项目名称', id: 'ProjectName', schopts: { qryopts: "{ mode: 'Like', field: 'ProjectName' }"}}]
            //            });
            AimSelGrid = new Ext.ux.grid.AimGridPanel({
                store: store,
                //region: 'center',
                height: 395,
                renderTo: 'div1',
                autoExpandColumn: 'ProjectName',
                columns: [
                    { id: 'Id', header: 'Id', dataIndex: 'Id', hidden: true },
                    { id: 'ProjectId', header: 'ProjectId', dataIndex: 'ProjectId', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    AimSelCheckModel,
                    { id: 'ZiXunCode', dataIndex: 'ZiXunCode', header: '项目编号', width: 200, sortable: true },
					{ id: 'ProjectName', dataIndex: 'ProjectName', header: '项目名称', width: 200, sortable: true },
					{ id: 'ShouKuanAmount', dataIndex: 'ShouKuanAmount', header: '收款金额', width: 100, sortable: true },
                    { id: 'ShouKuanDate', dataIndex: 'ShouKuanDate', header: '收款日期', width: 100, sortable: true },
                    { id: 'InvoiceNo', dataIndex: 'InvoiceNo', header: '发票号', width: 100, sortable: true },
                    { id: 'InvoiceDate', dataIndex: 'InvoiceDate', header: '开票日期', width: 100, sortable: true }
                    ],
                bbar: pgBar
                // tbar: titPanel
            });
            //            viewport = new Ext.ux.AimViewport({
            //                layout: 'border',
            //                items: [AimSelGrid]
            //            });

        }
    
    </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div class="panel panel-primary">
        <div class=" panel-heading">
            <strong>收款选择</strong>
        </div>
        <table class="table">
            <tr>
                <td>
                    <div class="input-group input-group-sm">
                        <span class="input-group-addon">项目名称</span>
                        <input type="text" class=" form-control" id="ProjectName_s" />
                    </div>
                </td>
                <td>
                    <div class="input-group  input-group-sm">
                        <span class="input-group-addon">发票号码</span>
                        <input type="text" class=" form-control" id="InvoiceNo_s" />
                    </div>
                </td>
                <td>
                    <div class="input-group  input-group-sm">
                        <span class="input-group-addon">收款日期从</span>
                        <div id="div2" class="form-control">
                        </div>
                    </div>
                </td>
                <td>
                    <div class="input-group  input-group-sm">
                        <span class="input-group-addon">至</span>
                        <div id="div3" class="form-control">
                        </div>
                        <span class="input-group-addon" id="search"><i class="fa fa-search">&nbsp;查 询</i></span>
                    </div>
                </td>
            </tr>
        </table>
        <div id="div1">
        </div>
        <div class=" panel-footer" style="text-align: center">
            <a class="btn btn-primary" id="btnSubmit"><i class="fa fa-check"></i><strong>确 定</strong></a><a
                class="btn btn-primary" id="btnCancel"><i class="fa fa-ban"></i><strong>取 消</strong></a>
        </div>
    </div>
</asp:Content>
