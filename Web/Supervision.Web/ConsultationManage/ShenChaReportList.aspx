
<%@ Page Title="标题" Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true" CodeBehind="ShenChaReportList.aspx.cs" Inherits="SP.Web.ShenChaReportList" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0"
        height="0">
    </object>
<script type="text/javascript">
    var EditWinStyle = CenterWin("width=1000,height=600,scrollbars=yes");
    var EditPageUrl = "ShenChaReportEdit.aspx";
    
    var store, myData;
    var pgBar, schBar, tlBar, titPanel, grid, viewport;


    function onPgLoad() {
        setPgUI();
    }



    function doprint(id,url) {

        try {
            var LODOP = document.getElementById("LODOP"); //这行语句是为了符合DTD规范

            LODOP.PRINT_INIT("");

            LODOP.NewPage();

            LODOP.ADD_PRINT_URL(20, 18, 750, 1050, url+'?id=' + id);
            //  LODOP.ADD_PRINT_URL(20, 18, 750, 1050, 'CommissionHanDY.aspx?id=' + id);

            LODOP.PREVIEW();
        }
        catch (ex) {
            alert("未安装打印控件，请安装打印控件");
            window.open("/install_lodop.rar", "print", "");
        }
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
			{ name: 'PManagerName' }, { name: 'ShiGongUnit' }, { name: 'ProjectType' }, { name: 'JunGongId' },
			{ name: 'BelongDeptId' },
			{ name: 'BelongDeptName' },
			{ name: 'CreateId' },
			{ name: 'CreateName' },
			{ name: 'CreateTime' },
			{ name: 'PartA' },
			{ name: 'Status' },
			{ name: 'PMRenMingHanId' },
			{ name: 'JianLiGuiHuaId' },
			{ name: 'SCID' },
			{ name: 'CreateName' }
			]
        });
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
                { fieldLabel: '编码', id: 'Code', schopts: { qryopts: "{ mode: 'Like', field: 'Code' }"} },
                { fieldLabel: '创建人', id: 'CreateName', schopts: { qryopts: "{ mode: 'Like', field: 'CreateName' }"} }]
            });

            // 工具栏
            tlBar = new Ext.ux.AimToolbar({
                items: [{
                text: '添加审查报告',
                    iconCls: 'aim-icon-add',
                    handler: function() {

                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要添加的记录！");
                            return;
                        }
                        if (recs[0].get("SCID") != null) {
                            AimDlg.show("以添加过审查报告！");
                            return;
                        }

                        var entTyp = recs[0].get("ProjectType");
                        var id = recs[0].get("Id");
                        EditPageUrl = geturl(entTyp);

                        showwin(id, entTyp, "c");
                    }
                }, {
                text: '修改审查报告',
                    iconCls: 'aim-icon-edit',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要修改的记录！");
                            return;
                        } 
                        if (recs[0].get("SCID") == null) {
                            AimDlg.show("未添加过审查报告！");
                            return;
                        }

                        var entTyp = recs[0].get("ProjectType");
                        EditPageUrl = geturl(entTyp);
                     //   ExtOpenGridEditWin(grid, EditPageUrl, "u", EditWinStyle);
                    }
                }, {
                    text: '删除审查报告',
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
                }, '-'
                , { text: '打印',
                    iconCls: 'aim-icon-printer',
                    handler: function() {
                        var recs = grid.getSelectionModel().getSelections();
                        if (!recs || recs.length <= 0) {
                            AimDlg.show("请先选择要打印的审查报告！");
                            return;
                        }

                        if (recs[0].get("SCID") == null) {
                            AimDlg.show("未添加过审查报告！");
                            return;
                        }
                        
                        var entId = recs[0].get("Id");
                        var url = getdyurl(recs[0].get("ProjectType"));


                        doprint(entId, url)
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
					{ id: 'ProjectName', dataIndex: 'ProjectName', header: '项目名称', width: 100, sortable: true },
//				    { id: 'ProjectType', dataIndex: 'ProjectType', header: '项目类型', width: 100, sortable: true }, 
					{ id: 'bg', dataIndex: 'ProjectType', header: '审查报告', width: 100,  renderer: linkRender, sortable: true },
					{ id: 'CreateName', dataIndex: 'CreateName', header: '创建人', width: 100,  sortable: true },
					{ id: 'CreateTime', dataIndex: 'CreateTime', header: '创建日期', width: 100, renderer: ExtGridDateOnlyRender,  sortable: true }
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
                    case "ProjectType":
                        if (rec.data.SCID)
                            rtn = "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" +
                                   rec.id + "\",\"" + rec.data.ProjectType + "\",\"r\")'>审查报告</label>";
                        else
                            rtn = "审查报告";       
                        break;
                }
                return rtn;
            }



            function showwin(id, typ, op) {
                var url = geturl(typ);
               var thisurl = url + "?op=" + op + "&id=" + id;
                opencenterwin(thisurl);
            }


            //编辑页面
            function geturl(typ) {
                if (typ == "房屋建筑" || typ == "house") {
                    url = "ShenChaFWEdit.aspx";
                } else if (typ == "市政工程" || typ == "publicWorks") {
                    url = "ShenChaSZEdit.aspx";
                } else if (typ == "勘察" || typ == "Survey") {
                url = "ShenChaKTEdit.aspx";
                } else {
                   url = "ShenChaJKEdit.aspx";   //深基坑支护工程
                }
                
                return url;
            }

            //打印页面
            function getdyurl(typ) {

                if (typ == "房屋建筑" || typ == "house") {
                    url = "ShenChaFWdy.aspx";
                } else if (typ == "市政工程" || typ == "publicWorks") {
                    url = "ShenChaSZdy.aspx";
                } else if (typ == "勘察" || typ == "Survey") {
                url = "ShenChaKTdy.aspx";
                } else {
                   url = "ShenChaJKdy.aspx";    //基坑支护工程
                }
             //   url = "ShenChaJKdy.aspx";
                return url;
            }
            
            
            function opencenterwin(url) {
                // alert(url)
                var iWidth = "1000", iHeight = "540";
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置; 
                window.open(url, '', 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes, resizable = no');
            }


          

            // 提交数据成功后
            function onExecuted() {
                store.reload();
            }
    
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header" style="display:none;"><h1>标题</h1></div>
</asp:Content>


