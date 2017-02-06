<%@ Page Title="监理环境因素" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master"
    AutoEventWireup="true" CodeBehind="SupervisionECList.aspx.cs" Inherits="SP.Web.SupervisionECList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var EditWinStyle = CenterWin("width=1000,height=600,scrollbars=yes");
        var EditPageUrl = "SupervisionECEdit.aspx";
        var Month = { "1": "1", "2": "2", "3": "3", "4": "4", "5": "5", "6": "6", "7": "7", "8": "8", "9": "9", "10": "10", "11": "11", "12": "12" };
        var Year = { "2012": "2012", "2013": "2013", "2014": "2014", "2015": "2015", "2016": "2016", "2017": "2017" };
        var store, myData;
        var pgBar, schBar, tlBar, titPanel, grid, viewport;

        function onPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["DataList"] || []
            };
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DataList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'ProjectId' },
			{ name: 'ProjectName' }, { name: 'ShiGongUnit' },
			{ name: 'PManagerId' }, { name: 'WorkRecord' },
			{ name: 'PManagerName' }, { name: 'Remark' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateTime' }
			]
            });
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });
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
                    viewConfig: { forceFit: true },
                    columns: [
                    new Ext.ux.grid.AimRowNumberer(),
                    new Ext.ux.grid.AimCheckboxSelectionModel(),
					{ id: 'ProjectName', dataIndex: 'ProjectName', header: '项目名称', width: 180, sortable: true },
					{ id: 'ShiGongUnit', dataIndex: 'ShiGongUnit', header: '施工单位', width: 180, sortable: true },
					{ id: 'PManagerName', dataIndex: 'PManagerName', header: '项目总监', width: 80, sortable: true },
                    //{ id: 'Year', dataIndex: 'Year', header: '监理年月', width: 100, renderer: RowRender },
  					{id: 'Remark', dataIndex: 'Remark', header: '备注', width: 180 },
                    { id: 'CreateName', dataIndex: 'CreateName', header: '创建人', width: 80 },
                    { id: 'CreateTime', dataIndex: 'CreateTime', header: '创建时间', width: 130 },
                    { id: 'Id', dataIndex: 'Id', header: '查看', width: 65, renderer: RowRender }
                    ],
                    bbar: pgBar,
                    tbar: titPanel
                });
                viewport = new Ext.ux.AimViewport({
                    items: [grid]
                });
            }
            function showwin(val) {
                opencenterwin("SupervisionECEdit.aspx?op=v&id=" + val);
            }
            function opencenterwin(url) {
                var iWidth = "1000", iHeight = "600";
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置; 
                window.open(url, '', 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes, resizable = no');
            }
            function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
                var rtn = "";
                switch (this.id) {
                    case "Id":
                        rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" +
                                                     record.get('Id') + "\")'>查看</label>";
                        break;
                    case "SubContractContent":
                        if (value) {
                            cellmeta.attr = 'ext:qtitle="" ext:qtip="' + value + '"';
                            rtn = value;
                        }
                        break;
                    case "Year":
                        rtn = value + "/" + record.get("Month");
                        break;
                }
                return rtn;
            }
            function onExecuted() {
                store.reload();
            }
    
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
