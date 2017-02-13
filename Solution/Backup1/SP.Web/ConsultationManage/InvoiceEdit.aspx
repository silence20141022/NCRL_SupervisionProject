<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InvoiceEdit.aspx.cs" Inherits="SP.Web.ConsultationManage.InvoiceEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>发票信息</title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <link href="../font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var formPanel, store_invoice, SkGrid;
        var Id = getQueryString("Id");
        var projectid = getQueryString("projectid");
        Ext.onReady(function () {
            var field_ProjectName = Ext.create('Ext.form.field.Display', {
                fieldLabel: '项目名称',
                labelAlign: 'right',
                name: 'ProjectName',
                id: "ProjectName",
                margin: '5'
            })
            var field_InvoiceNo = Ext.create('Ext.form.field.Text', {
                fieldLabel: '发票号',
                labelAlign: 'right',
                name: 'InvoiceNo',
                allowBlank: false,
                msgTarget: 'under',
                blankText: '发票号码不能为空',
                margin: '5'
            })
            var field_KaiPiaoDate = Ext.create('Ext.form.field.Date', {
                fieldLabel: '开票日期',
                labelAlign: 'right',
                allowBlank: false,
                blankText: '开票日期不能为空',
                msgTarget: 'under',
                name: 'KaiPiaoDate',
                id: "KaiPiaoDate",
                margin: '5',
                format: 'Y-m-d'
            })
            var field_InvoiceAmount = Ext.create('Ext.form.field.Number', {
                fieldLabel: '发票金额',
                labelAlign: 'right',
                minValue: 0,
                allowBlank: false,
                blankText: '发票金额不能为空',
                msgTarget: 'under',
                name: 'InvoiceAmount',
                margin: '5'
            })
            var field_Remark = Ext.create('Ext.form.field.TextArea', {
                fieldLabel: '备注',
                labelAlign: 'right',
                name: 'Remark',
                margin: '5',
                anchor: '100%'
            })
            formPanel = Ext.create('Ext.form.Panel', {
                region: 'center',
                items: [
                { xtype: "textfield", name: "Id", id: "Id", hidden: true },
                { xtype: "textfield", name: "ProjectId", id: "ProjectId", hidden: true },
                 field_ProjectName,
                 field_InvoiceNo,
                 field_InvoiceAmount,
                 field_KaiPiaoDate,
                 field_Remark],
                buttons: [
                { text: '保 存', handler: function () {
                    if (formPanel.getForm().isValid()) {
                        var json = Ext.encode(Ext.pluck(store_invoice.data.items, 'data'));
                        var action = Id ? "Update" : "Create";
                        Ext.Ajax.request({
                            url: "InvoiceEdit.aspx",
                            params: { action: action, data: Ext.encode(formPanel.getForm().getValues()), json: json, Id: Id },
                            callback: function (option, success, response) {
                                if (window.opener && window.opener.store) {
                                    window.opener.store.reload();
                                }
                                window.close();
                            }
                        });
                    }
                }
                },
                { text: '取 消', handler: function () { window.close(); } }
                ],
                buttonAlign: 'center'
            });
            Ext.regModel('ShouKuan', { fields: ['Id', 'ShouKuanDate', 'CreateName', 'ShouKuanAmount', 'InvoiceId',
            'ChouJinId', 'YiFenPercent', 'ChouJinAmount', 'CreateId', 'CreateTime', 'Remark', 'ProjectId'
            ]
            })
            store_invoice = Ext.create('Ext.data.JsonStore', {
                model: "ShouKuan",
                proxy: {
                    type: 'ajax',
                    url: "InvoiceEdit.aspx?action=skdetail",
                    extraParams: { Id: Id },
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                },
                autoLoad: true
            });
            var toolbar = Ext.create('Ext.toolbar.Toolbar', {
                items: [{ text: '添加', handler: function () {
                    var rec = new ShouKuan();
                    var Invoice = store_invoice.data.length;
                    store_invoice.insert(store_invoice.data.length, rec);
                }
                }, '-', { text: '删除', handler: function () {
                    var recs = SkGrid.getSelectionModel().getSelection();
                    if (!recs || recs.length <= 0) {
                        Ext.Msg.alert('提示', '请先选择要删除的记录！');
                        return;
                    }
                    var allow = true;
                    Ext.each(recs, function (rec) {
                        if (rec.get("YiFenPercent")) {
                            allow = false;
                            return false
                        }
                    })
                    if (!allow) {
                        Ext.Msg.alert('提示', '已分配的收款不能删除！');
                        return;
                    }
                    store_invoice.remove(recs);
                }
                }]
            })
            SkGrid = Ext.create('Ext.grid.Panel', {
                region: 'south',
                height: 300,
                store: store_invoice,
                tbar: toolbar,
                features: [{ ftype: 'summary'}],
                selModel: { selType: 'checkboxmodel' },
                plugins: [
                             Ext.create('Ext.grid.plugin.CellEditing', {
                                 clicksToEdit: 1, //设置单击单元格编辑  
                                 listeners: { edit: function (editor, e) {
                                     if (e.field == 'ShouKuanAmount') {//验证收款总金额有没有超过发票金额
                                         var total = 0;
                                         Ext.each(store_invoice.getRange(), function (rec) {
                                             total += parseFloat(rec.get("ShouKuanAmount"));
                                         })
                                         if (total > parseFloat(formPanel.getForm().findField("InvoiceAmount").getValue())) {
                                             Ext.Msg.alert("提示", '收款总金额不能大于发票金额！');
                                             e.record.set("ShouKuanAmount", e.originalValue);
                                         }
                                     }
                                 }
                                 }
                             })
                             ],
                columns: [
                            { text: 'Id', dataIndex: 'Id', hidden: true },
                            { text: 'InvoiceId', dataIndex: 'InvoiceId', hidden: true },
                            { dataIndex: 'ShouKuanDate', width: 150, header: '收款日期', xtype: 'datecolumn', format: 'Y-m-d', editor: { xtype: 'datefield', allowBlank: false },
                                summaryRenderer: function (v, params, data) { return "合计:" }
                            },
                            { dataIndex: 'ShouKuanAmount', width: 120, header: '收款金额', field: { xtype: 'numberfield', allowDecimals: 2, minValue: 0, allowBlank: false },
                                summaryType: 'sum', format: '0,000', xtype: 'numbercolumn'
                            },
                            { dataIndex: 'Remark', header: '备注', flex: 1, field: { xtype: 'textarea', allowBlank: false} },
                            { header: "酬金金额", dataIndex: 'ChouJinAmount', width: 80 },
                            { header: "已分比例", dataIndex: 'YiFenPercent', width: 80 },
                            { header: "录入人", dataIndex: 'CreateName', width: 70 },
                            { header: "录入日期", dataIndex: 'CreateTime', width: 100, xtype: 'datecolumn', format: 'Y-m-d' }
                          ],
                listeners: {}
            })
            var panel = Ext.create('Ext.panel.Panel', {
                title: '发票收款',
                region: 'center',
                layout: 'border',
                frame: true,
                items: [formPanel, SkGrid]
            })
            var viewport = new Ext.container.Viewport({
                layout: 'border',
                items: [panel]
            });
            formPanel.getForm().load({
                url: 'InvoiceEdit.aspx?action=loadinvoice&projectid=' + projectid,
                params: { Id: Id },
                method: 'POST', //请求方式   
                success: function (form, action) {
                    if (action.result.data.KaiPiaoDate) {
                        var str = new Date(action.result.data.KaiPiaoDate);
                        Ext.getCmp("KaiPiaoDate").setValue(str);
                    }
                }
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    </div>
    </form>
</body>
</html>
