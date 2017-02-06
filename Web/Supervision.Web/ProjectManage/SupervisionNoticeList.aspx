<%@ Page Title="监理通知" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="SupervisionNoticeList.aspx.cs" Inherits="SP.Web.SupervisionNoticeList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=699,height=300,scrollbars=yes");
        var EditPageUrl = "SupervisionNoticeEdit.aspx";

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;

        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["SupervisionNoticeList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'SupervisionNoticeList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
            { name: 'Code' },
            { name: 'BuildDept' },
			{ name: 'ProjectId' },
			{ name: 'ProjectName' },
			{ name: 'PManagerId' },
			{ name: 'PManagerName' },
			{ name: 'ShiGongUnit' },
			{ name: 'NoticeDate' },
			{ name: 'NoticeContent' },
			{ name: 'State' },
			{ name: 'FileId' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateTime' },
			{ name: 'Remark' }
			]
            });

            // 分页栏
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });

            // 搜索栏
            schBar = new Ext.ux.AimSchPanel({
                store: store,
                columns: 6,
                collapsed: false,
                items: [
                { fieldLabel: '通知编号', id: 'Code', schopts: { qryopts: "{ mode: 'Like', field: 'Code' }"} },
                { fieldLabel: '项目名称', id: 'ProjectName', schopts: { qryopts: "{ mode: 'Like', field: 'ProjectName' }"} },
                 { fieldLabel: '通知时间', id: 'BeginDate', xtype: 'datefield', vtype: 'daterange', endDateField: 'EndDate', schopts:
                { qryopts: "{ mode: 'GreaterThan', datatype:'Date', field: 'BeginDate' }" }
                 },
                { fieldLabel: '至', id: 'EndDate', xtype: 'datefield', vtype: 'daterange', startDateField: 'BeginDate',
                    schopts: { qryopts: "{ mode: 'LessThan', datatype:'Date', field: 'EndDate' }" }
                },
                 { fieldLabel: '按钮', xtype: 'button', iconCls: 'aim-icon-search', width: 60, margins: '2 30 0 0', text: '查 询', handler: function () {
                     Ext.ux.AimDoSearch(Ext.getCmp("ProjectName"));
                 }
                 }]
            });

            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function () {
                        ExtOpenGridEditWin(grid, EditPageUrl, "c", EditWinStyle);
                    }
                }, {
                    text: '修改',
                    iconCls: 'aim-icon-edit',
                    handler: function () {
                        ExtOpenGridEditWin(grid, EditPageUrl, "u", EditWinStyle);
                    }
                }, {
                    text: '删除',
                    iconCls: 'aim-icon-delete',
                    handler: function () {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要删除的记录！");
                            return;
                        }

                        if (confirm("确定删除所选记录？")) {
                            ExtBatchOperate('batchdelete', recs, null, null, onExecuted);
                        }
                    }
                }]
            });

            // 工具标题栏
            titPanel = new Ext.ux.AimPanel({
                tbar: tlBar,
                items: [schBar]
            });

            // 表格面板
            grid = new Ext.ux.grid.AimGridPanel({
                store: store,
                region: 'center',
                viewConfig: { forceFit: true },
                autoExpandColumn: 'Name',
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
                    { id: 'Code', dataIndex: 'Code', header: '通知编号', linkparams: { url: EditPageUrl, style: EditWinStyle }, width: 80, sortable: true },
					{ id: 'ProjectName', dataIndex: 'ProjectName', header: '项目名称', width: 120, sortable: true },
					{ id: 'PManagerName', dataIndex: 'PManagerName', header: '项目总监', width: 120, sortable: true },
                    { id: 'BuildDept', dataIndex: 'BuildDept', header: '建设单位', width: 120, sortable: true },
					{ id: 'ShiGongUnit', dataIndex: 'ShiGongUnit', header: '施工单位', width: 120, sortable: true },
					{ id: 'NoticeDate', dataIndex: 'NoticeDate', header: '通知时间', width: 100, sortable: true },
                    { id: 'FileId', dataIndex: 'FileId', header: '通知内容', width: 180, renderer: linkRender }
                    ],
                bbar: pgBar,
                tbar: titPanel
            });

            // 页面视图
            viewport = new Ext.ux.AimViewport({
                items: [{ xtype: 'box', region: 'north', applyTo: 'header', height: 30 }, grid]
            });
        }

        // 链接渲染
        function linkRender(val, p, rec) {
            var rtn = val;
            switch (this.dataIndex) {
                case "FileId":
                    if (val) {
                        rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" +
                                   val + "\")'>通知内容</label>";
                    } else {
                        rtn = "通知内容";
                    }
                    break;
            }

            return rtn;
        }
        function showwin(val) {
            EditDocumentButton = new ActiveXObject("SharePoint.OpenDocuments.1");
            f = AimState["url"];
            EditDocumentButton.EditDocument(f + "/Filelist/" + val + "_监理通知.doc");
        }
        // 提交数据成功后
        function onExecuted() {
            store.reload();
        }
    </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display: none;">
        <h1>
            监理通知</h1>
    </div>
</asp:Content>
