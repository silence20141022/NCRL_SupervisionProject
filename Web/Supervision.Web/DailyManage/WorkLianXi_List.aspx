<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkLianXi_List.aspx.cs"
    Inherits="SP.Web.DailyManage.WorkLianXi_List" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <link href="../font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var grid, store;
        Ext.onReady(function () {
            var store_status = Ext.create('Ext.data.JsonStore', {
                fields: ['name'],
                data: [{ name: '未查看' }, { name: '已查看' }, { name: '已处理'}]
            })
            var combo_status = Ext.create('Ext.form.field.ComboBox', {
                store: store_status,
                queryMode: 'local',
                fieldLabel: '状态',
                displayField: 'name',
                valueField: 'name',
                width: 140,
                labelWidth: 60,
                labelAlign: 'right'
            })
            var tbar = new Ext.toolbar.Toolbar({
                items: [
                { xtype: 'textfield', fieldLabel: '标题', labelWidth: 60, labelAlign: 'right', id: 'Title_s' },
                { xtype: 'textfield', fieldLabel: '接收人', labelWidth: 60, labelAlign: 'right', id: 'ReceiveUserNames_s' },
                combo_status,
                { text: '查 询', handler: function () {
                    store_stage.load({ params: { start: 0} })
                }
                }, '-',
                { text: '添 加', handler: function () {
                    opencenterwin("WorkLianXi_Edit.aspx", 800, 550);
                }
                }, '-', { text: '修改', handler: function () {
                    var recs = grid.getSelectionModel().getSelection();
                    if (recs.length > 0) {
                        opencenterwin("GongZiEdit.aspx?formId=" + recs[0].get("Id"), 1300, 600);
                    }
                    else {
                        alert("请选择要修改的记录!");
                    }
                }
                }, '-', { text: '删除', handler: function () {
                    var recs = grid.getSelectionModel().getSelection();
                    if (recs.length > 0) {
                        var formIds = "";
                        Ext.each(recs, function (rec) {
                            formIds += rec.get("Id") + ",";
                        })
                        Ext.Ajax.request({
                            url: 'GongZiList.aspx?action=delete',
                            params: { formIds: formIds },
                            callback: function () {
                                store_stage.reload();
                            }
                        })
                    }
                    else {
                        alert("请选择要删除的记录!");
                    }
                }
                }]
            });
            store = Ext.create('Ext.data.JsonStore', {
                fields: ['Id', 'Title', 'JinJiDegree', 'SendUserName', 'ReceiveUserNames', 'YaoQiuFinishTime', 'Status', 'SendTime'],
                proxy: {
                    url: 'WorkLianXi_List.aspx?action=load',
                    type: 'ajax',
                    reader: {
                        root: 'rows',
                        totalProperty: 'total'
                    }
                },
                autoLoad: true,
                listeners: { beforeload: function (store, options) {
                    var new_params = {
                        Title: Ext.getCmp("Title_s").getValue(),
                        ReceiveUserName: Ext.getCmp("ReceiveUserNames_s").getValue(),
                        Status: combo_status.getValue()
                    }
                    Ext.apply(store.proxy.extraParams, new_params);
                }
                }
            })
            var pagebar = Ext.create('Ext.toolbar.Paging', {
                store: store,
                displayInfo: true,
                displayMsg: '显示 {0} - {1} 条,共计 {2} 条'
            })
            grid = new Ext.grid.Panel({
                title: '工作联系',
                region: 'center',
                store: store,
                columnLines: true,
                selModel: { selType: 'checkboxmodel' },
                tbar: tbar,
                bbar: pagebar,
                columns: [
                { xtype: 'rownumberer', width: 35 },
                { text: '标题', dataIndex: 'Title', width: 250 },
                { text: '接收人', dataIndex: 'ReceiveUserNames', flex: 1 },
                { text: '紧急程度', dataIndex: 'JinJiDegree', width: 100 },
                { text: '发送时间', dataIndex: 'SendTime' },
                { text: '要求完成时间', dataIndex: 'YaoQiuFinishTime', width: 120, format: 'Y-m-d' },
                { text: '状态', dataIndex: 'Status', width: 90 }
                ]
            })
            var viewport = new Ext.container.Viewport({
                layout: 'border',
                items: [grid]
            })
        })
        function showadjustdetail(val) {
            opencenterwin("SalaryAdjustList.aspx?stageId=" + val, 1100, 550);
        }      
    </script>
</head>
<body>
    <form id="form1" runat="server">
    </form>
</body>
</html>
