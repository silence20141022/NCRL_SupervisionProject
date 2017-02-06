<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InvoiceList.aspx.cs" Inherits="SP.Web.ConsultationManage.InvoiceList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var store;
        Ext.onReady(SetPage);
        function SetPage() {
            Ext.regModel("Invoice", { fields: ['Id', 'ProjectId', 'ProjectName', 'HuiKuanAmount', 'KaiPiaoDate', 'Status', 'InvoiceAmount', 'InvoiceNo', 'InvoiceDate', 'ShouKuanAmount', 'JianSheUnit', 'Remark', 'CreateId', 'CreateName', 'CreateTime'] });
            store = Ext.create("Ext.data.JsonStore", {
                model: "Invoice",
                pageSize: 25,
                proxy: {
                    url: "InvoiceList.aspx?action=DoSelect",
                    extraParams: { InvoiceNo: "", ProjectName: "", KaiPiaoDate: "" },
                    type: "ajax",
                    reader: {
                        type: "json",
                        root: "rows",
                        totalProperty: "total"
                    }
                },
                autoLoad: true
            });
            var toolbar = Ext.create("Ext.toolbar.Toolbar", {
                items: [
                { xtype: "textfield", fieldLabel: "项目名称|编号", id: "ProjectName_invoice", labelAlign: 'right', width: 200 },
                { xtype: "textfield", fieldLabel: "发票号码", id: "InvoiceNo_invoice", labelAlign: 'right', labelWidth: 60, width: 150 },
                { xtype: "datefield", fieldLabel: "开票日期从", id: "StartDate_invoice", labelAlign: 'right', format: 'Y-m-d' },
                { xtype: "datefield", fieldLabel: "至", id: "EndDate_invoice", labelAlign: 'right', labelWidth: 50, format: 'Y-m-d' },
                { text: "查 询", handler: function () {
                    store.load({ params: { ProjectName: Ext.getCmp("ProjectName_invoice").getValue(),
                        InvoiceNo: Ext.getCmp("InvoiceNo_invoice").getValue(),
                        StartDate: Ext.getCmp("StartDate_invoice").getValue(), EndDate: Ext.getCmp("EndDate_invoice").getValue()
                    }
                    });
                }
                }, '-',
                { text: "修 改", handler: function () {
                    var recs = grid1.getSelectionModel().getSelection();
                    if (!recs || recs.length <= 0) {
                        Ext.Msg.alert("提示", "请选择要修改的记录!");
                        return;
                    }
                    if (recs[0].get("Status") == "已作废") {
                        Ext.Msg.alert("提示", "已作废的记录不能修改。");
                        return;
                    }
                    opencenterwin("InvoiceEdit.aspx?Id=" + recs[0].get("Id"), 900, 500);
                }
                }, '-',
                { text: "作废", handler: function () {
                    var recs = grid.getSelectionModel().getSelection();
                    if (!recs || recs.length <= 0) {
                        Ext.Msg.alert("提示", "请先选择要作废的记录!");
                        return;
                    }
                    if (recs[0].get("Status") == "已作废") {
                        Ext.Msg.alert("提示", "此条记录已作废!");
                        return;
                    }
                    if (Ext.MessageBox.confirm("提示", "确定要执行作废操作吗?", function (str) {
                        var Jarray = [];
                        if (str == "yes") {
                            Ext.each(recs, function (rec) {
                                Jarray.push(rec.get("Id"));
                            });
                        }
                        Ext.Ajax.request({
                            url: "InvoiceList.aspx?action=zf",
                            params: { Jarray: Jarray },
                            callback: function () {
                                store.reload();
                            }
                        });
                    })) { }
                }
                }
                ]
            });
            var pagebar1 = Ext.create('Ext.toolbar.Paging', {
                displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                emptyMsg: "没有数据",
                beforePageText: "当前页",
                afterPageText: "共{0}页",
                store: store,
                displayInfo: true
            })
            var grid1 = Ext.create("Ext.grid.Panel", {
                store: store,
                region: "center",
                selModel: { selType: "checkboxmodel" },
                columns: [
                { xtype: "rownumberer", width: 35 },
                { dataIndex: "Id", header: "标识", hidden: true },
                { dataIndex: "ProjectId", header: "标识", hidden: true },
                { dataIndex: "InvoiceNo", header: "发票号码", width: 100 },
                { dataIndex: "ProjectName", header: "项目名称", flex: 1 },
                { dataIndex: "InvoiceAmount", header: "开票金额", width: 90, xtype: 'numbercolumn', format: '0,000' },
                { dataIndex: "ShouKuanAmount", header: "已收款金额", width: 90, xtype: 'numbercolumn', format: '0,000' },
                { dataIndex: "KaiPiaoDate", header: "开票日期", xtype: 'datecolumn', format: 'Y-m-d', width: 100 },
                { dataIndex: "Status", header: "发票状态", width: 80 },
                { dataIndex: "Remark", header: "备注", width: 120 },
                { dataIndex: "CreateName", header: "录入人", width: 70 },
                { dataIndex: "CreateTime", header: "录入时间", xtype: 'datecolumn', format: 'Y-m-d', width: 100 }
                ],
                tbar: toolbar,
                bbar: pagebar1
            });
            Ext.regModel('ShouKuan', { fields: ['Id', 'InvoiceId', 'InvoiceNo', 'ProjectId', 'ProjectName', 'ShouKuanDate', 'ShouKuanAmount',
            'YiFenPercent', 'ChouJinPercent', 'ChouJinAmount', 'CreateName', 'CreateTime']
            });
            var store_shoukuan = Ext.create('Ext.data.JsonStore', {
                model: 'ShouKuan',
                pageSize: 25,
                proxy: {
                    url: 'InvoiceList.aspx?action=loadshoukun',
                    type: 'ajax',
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty: 'total'
                    }
                },
                autoLoad: true
            })
            var toolbar2 = Ext.create('Ext.toolbar.Toolbar', {
                items: [{ xtype: 'textfield', fieldLabel: '项目名称/编号', labelAlign: 'right', id: 'ProjectName_Code_s' },
                { xtype: 'numberfield', fieldLabel: '发票号码', labelAlign: 'right', labelWidth: 60, id: 'InvoiceNo_s' },
                { xtype: 'datefield', fieldLabel: '收款日期从', labelAlign: 'right', id: 'BeginDate_s', format: 'Y-m-d' },
                { xtype: 'datefield', fieldLabel: '至', labelAlign: 'right', id: 'EndDate_s', labelWidth: 50, format: 'Y-m-d' },
                { text: '查 询', handler: function () {
                    store_shoukuan.load({ params: { ProjectName: Ext.getCmp('ProjectName_Code_s').getValue(),
                        InvoiceNo: Ext.getCmp('InvoiceNo_s').getValue(),
                        StartDate: Ext.getCmp('BeginDate_s').getValue(), EndDate: Ext.getCmp('EndDate_s').getValue()
                    }
                    })
                }
                }, '-',
                { text: '删 除' }
                ]
            })
            var pagebar2 = Ext.create('Ext.toolbar.Paging', {
                displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                emptyMsg: "没有数据",
                beforePageText: "当前页",
                afterPageText: "共{0}页",
                store: store_shoukuan,
                displayInfo: true
            })
            var grid_shoukuan = Ext.create('Ext.grid.Panel', {
                region: 'center',
                tbar: toolbar2,
                bbar: pagebar2,
                store: store_shoukuan,
                columns: [
                { header: '项目名称', dataIndex: 'ProjectName', flex: 1 },
                { header: '发票号码', dataIndex: 'InvoiceNo', width: 90 },
                { header: '收款日期', dataIndex: 'ShouKuanDate', width: 100, xtype: 'datecolumn', format: 'Y-m-d' },
                { header: '收款金额', dataIndex: 'ShouKuanAmount', width: 100, xtype: 'numbercolumn', format: '0,000' },
                { header: '备注', dataIndex: 'Remark', width: 200 },
                { header: '录入人', dataIndex: 'CreateName', width: 80 },
                { header: '录入日期', dataIndex: 'CreateTime', xtype: 'datecolumn', format: 'Y-m-d', width: 100 }
                ]
            })
            var tabPanel = Ext.create("Ext.tab.Panel", {
                region: "center",
                items: [
                            { title: "发票管理", layout: "border",
                                listeners: { activate: function (tab, opitions) {
                                    store.getProxy().setExtraParam("tabIndex", 0);
                                    store.load();
                                }
                                },
                                items: [grid1]
                            },
                             { title: "收款记录", layout: "border",
                                 listeners: { activate: function (tab, opitions) {
                                     //                                     tabIndex = 1;
                                     //                                     store2.getProxy().setExtraParam("tabIndex", tabIndex);
                                     //                                     store2.load();
                                 }
                                 },
                                 items: [grid_shoukuan]
                             }
                        ]
            });
            var viewport = Ext.create("Ext.container.Viewport", {
                layout: "border",
                items: [tabPanel]
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    </div>
    </form>
</body>
</html>
