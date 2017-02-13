<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    CodeBehind="ProjectSelect.aspx.cs" Inherits="SP.Web.ProjectSelect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <script src="../../js/pgfunc-ext-sel.js" type="text/javascript"></script>
    <script type="text/javascript">

        var store, myData;
        var pgBar, schBar, tlBar, titPanel, AimSelGrid, viewport;
        var EditWinStyle = CenterWin("width=400,height=200,scrollbars=yes,resizable=yes");

        function onSelPgLoad() {
            setPgUI();
        }
        function setPgUI() {
            // 表格数据
            myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["ProjectList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'ProjectList',
                idProperty: 'Id',
                data: myData,
                fields: [
			{ name: 'Id' },
			{ name: 'ProjectCode' },
			{ name: 'ProjectName' },
			{ name: 'PManagerId' },
			{ name: 'PManagerName' },
			{ name: 'BelongDeptId' },
			{ name: 'BelongDeptName' },
			{ name: 'JianSheUnit' },
			{ name: 'ProjectType' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateTime' },
			{ name: 'PartA' },
			{ name: 'ShiGongUnit' },
			{ name: 'JianSheUnit' },
			{ name: 'Status' },
			{ name: 'PMRenMingHanId' },
			{ name: 'JianLiGuiHuaId' },
			{ name: 'JunGongId' }
			],
                listeners: {
                    'aimbeforeload': function (proxy, options) {
                        options.data = options.data || {};
                    }
                }
            });

            // 分页栏
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });

            // 搜索栏


            // 工具

            // 工具标题栏

            var buttonPanel = new Ext.form.FormPanel({
                region: 'south',
                frame: true,
                buttonAlign: 'center',
                buttons: [{
                    text: '确定', handler: function () {
                        AimGridSelect();
                    }
                }, {
                    text: '取消', handler: function () {
                        window.close();
                    }
                }]
            });
            // 表格面板

            AimSelGrid = new Ext.ux.grid.AimGridPanel({
                title: '项目列表',
                store: store,
                region: 'center',
                autoExpandColumn: 'ProjectName',
                columns: [
                    { id: 'Id', dataIndex: 'Id', header: '标识', hidden: true },
                    { id: 'PManagerId', dataIndex: 'PManagerId', header: '项目总监', hidden: true },
                    { id: 'ShiGongUnit', dataIndex: 'ShiGongUnit', header: '施工单位', hidden: true },
                    { id: 'JianSheUnit', dataIndex: 'JianSheUnit', header: '建设单位', hidden: true },

                    new Ext.ux.grid.AimRowNumberer(),
                    AimSelCheckModel,
                    { id: 'ProjectName', dataIndex: 'ProjectName', header: '项目名称', width: 120 },
                    { id: 'PManagerName', dataIndex: 'PManagerName', header: '项目总监', width: 150 },
                    { id: 'BelongDeptName', dataIndex: 'BelongDeptName', header: '所属部门', width: 150 }
                ],
                //tbar: titPanel,
                bbar: pgBar
            });
            // 页面视图
            viewport = new Ext.ux.AimViewport({
                items: [AimSelGrid, buttonPanel]
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
</asp:Content>
