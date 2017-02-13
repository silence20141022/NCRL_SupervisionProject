<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupervisionRiZhiList.aspx.cs"
    Inherits="SP.Web.ProjectManage.SupervisionRiZhiList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        Ext.onReady(function () {
            var tbar = Ext.create("Ext.toolbar.Toolbar", {
                items: [
                {
                    xtype: 'textfield',
                    id: 'ProjectName',
                    labelWidth: 60,
                    name: 'ProjectName',
                    labelAlign: 'right',
                    fieldLabel: '项目名称'
                },
                {
                    xtype: 'textfield',
                    id: 'PManagerName',
                    labelWidth: 60,
                    name: 'PManagerName',
                    labelAlign: 'right',
                    fieldLabel: '项目总监'
                },
                {
                    xtype: 'textfield',
                    id: 'ShiGongUnit',
                    labelWidth: 60,
                    name: 'ShiGongUnit',
                    labelAlign: 'right',
                    fieldLabel: '施工单位'
                },
                { text: "查 询", handler: function () {
                    var ProjectName = Ext.getCmp("ProjectName").getValue();
                    var PManagerName = Ext.getCmp("PManagerName").getValue();
                    var ShiGongUnit = Ext.getCmp("ShiGongUnit").getValue();
                    var json = { ProjectName: ProjectName, PManagerName: PManagerName, ShiGongUnit: ShiGongUnit };
                    store.reload({ params: json });
                }
                }, '-',
                { text: '添 加', handler: function () {
                    opencenterwin("SupervisionRiZhiEdit.aspx", 900, 650);
                }
                }, '-',
                 { text: '修 改', handler: function () {
                     var recs = grid.getSelectionModel().getSelection();
                     if (!recs || recs.length <= 0) {
                         alert("请选择要修改的记录！");
                         return;
                     }
                     opencenterwin("SupervisionRiZhiEdit.aspx?Id=" + recs[0].get("Id"), 900, 650);
                 }
                 }, '-',
                 { text: '删 除', handler: function () {
                     var recs = grid.getSelectionModel().getSelection();
                     if (!recs || recs.length <= 0) {
                         alert("请先选择要删除的记录！");
                         return;
                     }
                     Ext.MessageBox.confirm("提示", "确定删除吗?", function () {
                         var orderids = "";
                         Ext.each(recs, function () {
                             orderids = orderids + this.get("Id") + ",";
                         });
                         Ext.Ajax.request({
                             url: "SupervisionRiZhiList.aspx?action=delete",
                             params: { ids: orderids },
                             async: false,
                             callback: function (option, success, response) {
                                 store.reload();
                             }
                         });
                     });
                 }
                 }
                ]
            });

            Ext.regModel("SupervisionRiZhi", { fields:
                    ["Id", "ProjectId", "ProjectName", "PManagerId", "Week", "PManagerName", "ShiGongUnit", "Weather", "SupervisionDate", "WorkRecord", "SafetySupervision", "NextArrange", "PManagerOpinion", "CreateId", "CreateName", "CreateTime"]
            });
            store = Ext.create("Ext.data.JsonStore", {
                pageSize: 15,
                model: "SupervisionRiZhi",
                proxy: {
                    type: 'ajax',
                    url: "SupervisionRiZhiList.aspx?action=select",
                    reader: {
                        type: "json",
                        root: 'rows',
                        totalProperty: 'totalRecord'
                    }
                },
                autoLoad: { start: 0, limit: 15 }
            });

            var grid = Ext.create("Ext.grid.Panel", {
                store: store,
                title: '监理日志',
                region: 'center',
                tbar: tbar,
                selModel: { selType: 'checkboxmodel' },
                columns: [
                { xtype: "rownumberer", text: "行号", width: 45 },
                { text: '项目名称', dataIndex: 'ProjectName', width: 150 },
                { text: '施工单位', dataIndex: 'ShiGongUnit', width: 150 },
                { text: '项目总监', dataIndex: 'PManagerName', width: 100 },
                { text: '主要工作', dataIndex: 'WorkRecord', flex: 1 },
                { text: '监理日期', dataIndex: 'SupervisionDate', width: 100 }
                ]
                , bbar: {
                    xtype: 'pagingtoolbar',
                    displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                    emptyMsg: "没有数据",
                    beforePageText: "当前页",
                    afterPageText: "共{0}页",
                    store: store,
                    displayInfo: true
                }
            })

            var viewport = new Ext.container.Viewport({
                layout: 'border',
                items: [grid]
            });
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    </div>
    </form>
</body>
</html>
