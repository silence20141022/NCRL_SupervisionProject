<%@ Page Title="收款记录" Language="C#" MasterPageFile="~/Masters/Ext/IE8Site.Master"
    AutoEventWireup="true" CodeBehind="ShouKuanList.aspx.cs" Inherits="SP.Web.ShouKuanList" %>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <link href="../bootstrap32/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        span
        {
            padding-right: 5px;
        }

        .x-toolbar
        {
            box-sizing: content-box !important;
        }
    </style>
    <script type="text/javascript">
        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;
        function onPgLoad() {
            setPgUI();
            IniBtn();
        }
        function setPgUI() {

            df1 = new Ext.form.DateField({
                id: 'BeginDate',
                endDateField: 'EndDate',
                width: 200,
                format: 'Y-m-d',
                renderTo: 'div2',
                listeners: {
                    "change": function (e, p) {
                        df2.setMinValue(e.value);
                    }
                }
            })
            df2 = new Ext.form.DateField({
                id: 'EndDate',
                width: 200,
                startDateField: 'BeginDate',
                format: 'Y-m-d',
                renderTo: 'div3',
                listeners: {
                    "change": function (e, p) {
                        df1.setMaxValue(e.value);
                    }
                }
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
			{ name: 'Id' }, { name: 'ProjectId' }, { name: 'ProjectName' }, { name: 'ShouKuanAmount' }, { name: 'ShouKuanDate' },
			{ name: 'InvoiceNo' }, { name: 'InvoiceDate' }, { name: 'CreateId' }, { name: 'KaiPiaoDate' }, { name: 'CreateName' }, { name: 'CreateTime' }, { name: 'Remark' }, { name: 'Status' }
                ]
            });
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                autoExpandColumn: 'ProjectName',
                margins: '92 0 0 0',
                columns: [
                      { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'ProjectName', dataIndex: 'ProjectName', header: '项目名称', width: 250, sortable: true },
					{ id: 'InvoiceNo', dataIndex: 'InvoiceNo', header: '发票号码', width: 100, sortable: true },
                    { id: 'KaiPiaoDate', dataIndex: 'InvoiceDate', header: '开票日期', width: 100, sortable: true },
					{ id: 'ShouKuanDate', dataIndex: 'ShouKuanDate', header: '收款日期', width: 100, sortable: true },
                { id: 'ShouKuanAmount', dataIndex: 'ShouKuanAmount', header: '收款金额', width: 100, sortable: true, renderer: function (v) { return filterValue(v) } },
                 { id: 'Status', dataIndex: 'Status', header: '状态', width: 100, sortable: true },
					{ id: 'Remark', dataIndex: 'Remark', header: '备注', width: 150, sortable: true },
					{ id: 'CreateName', dataIndex: 'CreateName', header: '录入人', width: 60, sortable: true },
					{ id: 'CreateTime', dataIndex: 'CreateTime', header: '录入时间', width: 130, sortable: true }
                ],
                bbar: pgBar,
                tbar: titPanel
            });
            viewport = new Ext.ux.AimViewport({
                items: [grid]
            });
        }
        function onExecuted() {
            store.reload();
        }
        function IniBtn() {
            $("#search").click(function () {
                var json = { InvoiceNo: $("#InvoiceNo_s").val(), ProjectName: $("#ProjectName_s").val(), JianSheUnit: $("#ShouKuanDate_s").val(), BeginDate: df1.getValue(), EndDate: df2.getValue() };
                store.reload(json);
            })
            $(document).keydown(function (event) {
                if (event.keyCode == 13) {
                    $("#search").click();
                }
            });
            $("#btnModify").click(function () {
                var recs = grid.getSelectionModel().getSelections();
                if (!recs || recs.length <= 0) {
                    alert("请先选择要修改的记录！");
                    return;
                }
                if (recs[0].get("Status") == "已作废") {
                    AimDlg.show("已作废的记录不能修改。");
                    return;
                }
                opencenterwin("ShouKuanEdit.aspx?id=" + recs[0].get("Id"), '', 800, 400);
            });
            $("#btnDelete").click(function () {
                var recs = grid.getSelectionModel().getSelections();
                if (!recs || recs.length <= 0) {
                    AimDlg.show("请先选择要删除的记录！");
                    return;
                }
                var orderids = "";
                $.each(recs, function () {
                    orderids = orderids + this.get("Id") + ",";
                });
                if (confirm("确定删除所选记录？")) {
                    $.ajaxExec("delete", { data1: orderids }, function (rtn) {
                        store.reload();
                    })
                }
            });
        }
        function filterValue(val) {
            if (!val)
                return "";
            val = String(val);
            var whole = val;
            var r = /(\d+)(\d{3})/;
            while (r.test(whole)) {
                whole = whole.replace(r, '$1' + ',' + '$2');
            }
            return '￥' + (whole == "null" || whole == null ? "" : whole);
        }
    </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div class="panel panel-default">
        <div class=" panel-heading small" style="padding-bottom: 0px;">
            <ul class="nav nav-tabs" style="border-bottom-width: 0px">
                <li><a href="InvoiceList.aspx" style="color: black; font-weight: bolder">
                    <span class="fa fa-calendar"></span>发票管理</a></li>
                <li class="active"><a href="ShouKuanList.aspx" style="color: black; font-weight: bolder"><span class="fa fa-table"></span>收款记录</a></li>
                <%-- <li><a href="LeaderList.aspx?op=u" style="color: black; font-weight: bolder"><span
                    class="fa fa-users"></span>领导维护</a></li>--%>
            </ul>
        </div>
        <table class="table">
            <tr>
                <td style="width: 13%">
                    <div class="input-group input-group-sm">
                        <span class="input-group-addon">发票号码</span>
                        <input type="text" class=" form-control" id="InvoiceNo_s" />
                    </div>
                </td>
                <td style="width: 15%">
                    <div class="input-group  input-group-sm">
                        <span class="input-group-addon">项目名称</span>
                        <input type="text" class=" form-control" id="ProjectName_s" />
                    </div>
                </td>
                <%--  <td style="width: 15%">
                    <div class="input-group  input-group-sm">
                        <span class="input-group-addon">建设单位</span>
                        <input type="text" class=" form-control" id="JianSheUnit_s" />
                    </div>
                </td>--%>
                <td style="width: 14%">
                    <div class="input-group  input-group-sm">
                        <span class="input-group-addon">收款日期从</span>
                        <div id="div2" class="form-control">
                        </div>
                    </div>
                </td>
                <td style="width: 14%">
                    <div class="input-group  input-group-sm">
                        <span class="input-group-addon">至</span>
                        <div id="div3" class="form-control">
                        </div>
                        <span class="input-group-addon" id="search" style="cursor: pointer"><span class="fa fa-search"></span><strong>查 询</strong></span>
                    </div>
                </td>
                <td>
                    <div class="btn-group">
                        <%--  <a class="btn btn-primary btn-sm" id="btnAdd"><span class="fa fa-plus-square"></span>
                            <strong>添 加</strong></a>
                        <a class="btn btn-primary btn-sm" id="btnModify"><span class="fa fa-pencil-square-o"></span><strong>修 改</strong></a><a class="btn btn-primary btn-sm" id="btnDelete"><span
                            class="fa fa-times-circle"> </span><strong>删 除</strong></a>--%>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
