<%@ Page Title="标题" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="PartQualityReportList.aspx.cs" Inherits="SP.Web.PartQualityReportList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=660,height=170,scrollbars=yes");
        var EditPageUrl = "PartQualityReportEdit.aspx";
        var enumState = { '': '起草', 'null': '起草', 'Flowing': '审核中', 'End': '流程结束' };

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;

        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'ProjectId' },
			{ name: 'ProjectName' }, { name: 'ShiGongUnit' },
			{ name: 'PManagerId' },
			{ name: 'PManagerName' },
			{ name: 'ProjectStage' },
			{ name: 'FileId' },
			{ name: 'State' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateTime' }
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
                collapsed: false,
                columns: 5,
                items: [
                { fieldLabel: '项目名称', id: 'ProjectName', schopts: { qryopts: "{ mode: 'Like', field: 'ProjectName' }"} },
                { fieldLabel: '项目总监', id: 'PManagerName', schopts: { qryopts: "{ mode: 'Like', field: 'PManagerName' }"} },
                { fieldLabel: '状态', id: 'State', xtype: 'aimcombo', style: { marginTop: '-1px' }, enumdata: { 'new': '起草', 'Flowing': '审核中', 'End': '流程结束'}, schopts: { qryopts: "{ mode: 'Like', field: 'State' }"} }
                ]
            });


            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                    text: '添加',
                    iconCls: 'aim-icon-add',
                    handler: function() {
                        ExtOpenGridEditWin(grid, EditPageUrl, "c", EditWinStyle);
                    }
                }, {
                    text: '修改',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                    var recs = grid.getSelectionModel().getSelections();

                    if (recs.length != 1) {
                        AimDlg.show("只可以选择一条记录进行操作！");
                        return;
                    }
                    if (Number(recs[0].data.State) < 1) {
                        ExtOpenGridEditWin(grid, EditPageUrl, "u", EditWinStyle);
                    } else {
                        AimDlg.show("已经提交流程的记录不能修改！");
                        return;
                    }
                    }
                }, {
                    text: '删除',
                    iconCls: 'aim-icon-delete',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要删除的记录！");
                            return;
                        }
//                        for (var i = 0; i < recs.length; i++) {
//                            if (recs[i].get("State")) {
//                                alert("已经提交流程的记录不能删除!"); return;
//                            }
//                        }
                        if (confirm("确定删除所选记录？")) {
                            ExtBatchOperate('batchdelete', recs, null, null, onExecuted);
                        }
                    }
} ,"-", {
                    text: '流程跟踪',
                    iconCls: 'aim-icon-search',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要跟踪的记录！");
                            return;
                        }
                        ExtOpenGridEditWin(grid, "../workflow/flowtrace.aspx?FormId=" + recs[0].get("Id"), "c", CenterWin("width=900,height=700,scrollbars=yes"));
                    }
                } ]
                });
                titPanel = new Ext.ux.AimPanel({
                    tbar: tlBar,
                    items: [schBar]
                });
                grid = new Ext.ux.grid.AimGridPanel({
                    store: store,
                    region: 'center',
                    autoExpandColumn: 'ProjectName',
                    columns: [
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'ProjectName', dataIndex: 'ProjectName', header: '项目名称', width: 100, sortable: true },
					{ id: 'ShiGongUnit', dataIndex: 'ShiGongUnit', header: '施工单位', width: 180, sortable: true },
					{ id: 'PManagerName', dataIndex: 'PManagerName', header: '项目总监', width: 130, sortable: true },
					{ id: 'ProjectStage', dataIndex: 'ProjectStage', header: '项目阶段', width: 130, sortable: true},
					{ id: 'State', dataIndex: 'State', header: '状态', width: 100, sortable: true, enumdata: enumState },
					{ id: 'CreateName', dataIndex: 'CreateName', header: '创建人', width: 130, sortable: true },
					{ id: 'CreateTime', dataIndex: 'CreateTime', header: '创建日期', width: 100, renderer: ExtGridDateOnlyRender, sortable: true },
					{ id: 'FileId', dataIndex: 'FileId', header: '评估报告', width: 65, renderer: RowRender }
                    ],
                    bbar: pgBar,
                    tbar: titPanel
                });
                viewport = new Ext.ux.AimViewport({
                    items: [grid]
                });
            }

            function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
                var rtn = "";
                switch (this.id) {
                    case "FileId":
                        if (record.data.State) {
                            rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" +
                                                    value + "\",\"" + record.data.State + "\")'>查看</label>";
                        } else {
                            rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" +
                                                     value + "\",\"" + record.data.State + "\")'>编辑</label>";
                        }
                        break;
                }
                return rtn;
            }

            function showwin(val, sta) {
                EditDocumentButton = new ActiveXObject("SharePoint.OpenDocuments.1");
                f = AimState["url"];
                if (!sta) {
                    EditDocumentButton.EditDocument(f + "/Filelist/" + val + "_分部工程质量评估报告.doc");
                } else {
                EditDocumentButton.CreateNewDocument(f + "/Filelist/" + val + "_分部工程质量评估报告.doc", "asd");
                  
                }
            }
            function onExecuted() {
                store.reload();
            }
    
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
