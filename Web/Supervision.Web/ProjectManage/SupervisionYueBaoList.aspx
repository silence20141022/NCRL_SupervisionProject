<%@ Page Title="监理月报" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="SupervisionYueBaoList.aspx.cs" Inherits="SP.Web.SupervisionYueBaoList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=900,height=250,scrollbars=yes");
        var EditPageUrl = "SupervisionYueBaoEdit.aspx";
        var Month = { "1": "1", "2": "2", "3": "3", "4": "4", "5": "5", "6": "6", "7": "7", "8": "8", "9": "9", "10": "10", "11": "11", "12": "12" };
        var Year = { "2012": "2012", "2013": "2013", "2014": "2014", "2015": "2015", "2016": "2016", "2017": "2017" };
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
			{ name: 'ProjectName' },
			{ name: 'PManagerId' },
			{ name: 'PManagerName' }, { name: 'ShiGongUnit' },
			{ name: 'Year' },
			{ name: 'Month' },
			{ name: 'FileId' },
			{ name: 'State' },
			{ name: 'WFState' },
			{ name: 'YearAndMonth' },
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
                 { fieldLabel: '施工单位', id: 'ShiGongUnit', schopts: { qryopts: "{ mode: 'Like', field: 'ShiGongUnit' }"} }
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
}]
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
					{ id: 'ProjectName', dataIndex: 'ProjectName', header: '项目名称', width: 200, sortable: true },
					{ id: 'ShiGongUnit', dataIndex: 'ShiGongUnit', header: '施工单位', width: 180, sortable: true },
					{ id: 'PManagerName', dataIndex: 'PManagerName', header: '项目总监', width: 80, sortable: true },
  					{ id: 'YearAndMonth', dataIndex: 'YearAndMonth', header: '监理年月', width: 100
  					},
  					{ id: 'FileId', dataIndex: 'FileId', header: '监理月报', width: 130, sortable: true, renderer: linkRender }
                    ],
                    bbar: pgBar,
                    tbar: titPanel
                });
                viewport = new Ext.ux.AimViewport({
                    items: [grid]
                });
            }

            // 链接渲染
            function linkRender(val, p, rec) {
                var rtn = val;
                switch (this.dataIndex) {
                    case "FileId":
                        if (val) {
                            rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" +
                                   val + "\")'>监理月报</label>";
                        } else {
                        rtn = "监理月报";
                        }
                        break;
                }

                return rtn;
            }


            function showwin(val) {

                EditDocumentButton = new ActiveXObject("SharePoint.OpenDocuments.1");
                f = AimState["url"];
                EditDocumentButton.EditDocument(f + "/Filelist/" + val + "_监理月报.doc");

            }

               


         
          
            function onExecuted() {
                store.reload();
            }
            function link(id) {
                OpenWin("/ProjectManage/SupervisionYueBaoEdit.aspx?&id=" + id, "r", EditWinStyle);
            }
    
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
