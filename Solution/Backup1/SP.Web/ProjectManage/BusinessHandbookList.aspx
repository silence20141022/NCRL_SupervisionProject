<%@ Page Title="标题" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="BusinessHandbookList.aspx.cs" Inherits="SP.Web.BusinessHandbookList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=720,height=150,scrollbars=yes");
        var EditPageUrl = "BusinessHandbookEdit.aspx";

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;

        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {

            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["BusinessHandbookList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'BusinessHandbookList',
                idProperty: 'Id',
                data: myData,
                fields: [
		{ name: 'Id' },
			{ name: 'ProjectId' },
			{ name: 'ProjectName' },
			{ name: 'PManagerId' },
			{ name: 'PManagerName' },
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
                { fieldLabel: '创建人', id: 'CreateName', schopts: { qryopts: "{ mode: 'Like', field: 'CreateName' }"} }]
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
                            ExtOpenGridEditWin(grid, EditPageUrl, "u", EditWinStyle);
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

                            if (confirm("确定删除所选记录？")) {
                                ExtBatchOperate('batchdelete', recs, null, null, onExecuted);
                            }
                        }
                    }, '-', {
                        text: '导出Excel',
                        iconCls: 'aim-icon-xls',
                        handler: function() {
                            ExtGridExportExcel(grid, { store: null, title: '标题' });
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
                        autoExpandColumn: 'ProjectName',
                        columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                  
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'ProjectName', dataIndex: 'ProjectName', header: '项目名称', linkparams: { url: EditPageUrl, style: EditWinStyle }, width: 100, sortable: true },
					{ id: 'PManagerName', dataIndex: 'PManagerName', header: '项目总监', width: 130, sortable: true },
					{ id: 'FileId', dataIndex: 'FileId', header: '监理业务手册', width: 130, sortable: true, renderer: linkRender },
					{ id: 'CreateName', dataIndex: 'CreateName', header: '创建人', width: 130, sortable: true },
					{ id: 'CreateTime', dataIndex: 'CreateTime', header: '创建日期', width: 100, renderer: ExtGridDateOnlyRender, sortable: true }
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
                                   val + "\")'>监理业务手册</label>";
                            } else {
                                rtn = "监理业务手册";
                            }
                            break;
                    }

                    return rtn;
                }
                function showwin(val) {
                    EditDocumentButton = new ActiveXObject("SharePoint.OpenDocuments.1");
                    f = AimState["url"];
                   
                    
                    EditDocumentButton.EditDocument(f + "/Filelist/" + val + "_监理业务手册.doc");

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
            标题</h1>
    </div>
</asp:Content>
