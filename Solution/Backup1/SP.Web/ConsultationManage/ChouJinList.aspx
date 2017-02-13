<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChouJinList.aspx.cs" Inherits="SP.Web.ConsultationManage.ChouJinList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        Ext.onReady(function () {
            Ext.regModel('ChouJin', { fields: ['Id', 'BelongYear', 'BelongMonth', 'ChouJinAmount', 'Remark', 'CreateId',
            'CreateName', 'CreateTime']
            })
            var store_choujin = Ext.create('Ext.data.JsonStore', {
                model: 'ChouJin',
                pageSize: 25,
                proxy: {
                    url: 'ChouJinList.aspx?action=loadlistdata',
                    type: 'ajax',
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty: 'total'
                    }
                },
                autoLoad: true
            })
            var toolbar = Ext.create('Ext.toolbar.Toolbar', {
                items: [{ text: '添 加', handler: function () {
                    opencenterwin("ChouJinCard.aspx", 1200, 600);
                }
                }, { text: '修改', handler: function () {
                    var recs = grid.getSelectionModel().getSelection();
                    if (!recs || recs.length == 0) {
                        Ext.Msg.alert('提示', '请选择要修改的记录!');
                        return;
                    }
                    opencenterwin("ChouJinCard.aspx?id=" + recs[0].get("Id"), 1200, 600);
                }
                }, { text: '删 除'}]
            })
            var pagebar = Ext.create('Ext.toolbar.Paging', {
                displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                emptyMsg: "没有数据",
                beforePageText: "当前页",
                afterPageText: "共{0}页",
                store: store_choujin,
                displayInfo: true
            })
            var grid = Ext.create('Ext.grid.Panel', {
                title: '酬金分配',
                selModel: { selType: "checkboxmodel" },
                tbar: toolbar,
                bbar: pagebar,
                region: 'center',
                store: store_choujin,
                columns: [
                { xtype: "rownumberer", width: 35 },
                { header: '分配时间', dataIndex: 'BelongMonth', width: 120, renderer: function (value, metadata, record) {
                    return record.get("BelongYear") + "年" + value + "月";
                }
                },
                { header: '分配金额', dataIndex: 'ChouJinAmount', xtype: 'numbercolumn', format: '0,000', width: 120 },
                { header: '备注', dataIndex: 'Remark', flex: 1 },
                { header: '创建人', dataIndex: 'CreateName', width: 80 },
                { header: '创建时间', dataIndex: 'CreateTime', width: 100, xtype: 'datecolumn', format: 'Y-m-d' }
                ]
            })
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [grid]
            })
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
