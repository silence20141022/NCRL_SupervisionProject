<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DelegateInfoList.aspx.cs"
    Inherits="SP.Web.ConsultationManage.DelegateInfoList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var store, grid;
        Ext.onReady(SetPage);
        function SetPage() {
            Ext.regModel("Window", { fields: ["Id", "DelegateName", "DelegateCode", "DengJiBenNo", "Address", "DelegateHead", "Telephone", "Email", "Remark", "CreateName", "CreateTime"] });
            store = Ext.create("Ext.data.JsonStore", {
                model: "Window",
                pageSize: 25,
                proxy: {
                    url: "DelegateInfoList.aspx?action=SelectList",
                    extraParams: { NameOrCode: "" },
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
                { xtype: "textfield", fieldLabel: "窗口名称/编号", id: "NameOrCode", labelAlign: 'right' },
                { text: "查询", icon: '/images/shared/search_show.gif', handler: function () {
                    var NameOrCode = Ext.getCmp("NameOrCode").getValue();
                    store.getProxy().setExtraParam("NameOrCode", NameOrCode);
                    store.load();
                }
                }, '-',
                { text: "添 加", handler: function () {
                    opencenterwin("DelegateInfoEdit.aspx", 700, 400);
                }
                }, '-',
                { text: "修 改", handler: function () {
                    var recs = grid.getSelectionModel().getSelection();
                    if (!recs || recs.length <= 0) {
                        Ext.Msg.alert("提示", "请选择修改记录!");
                        return;
                    }
                    opencenterwin("DelegateInfoEdit.aspx?Id=" + recs[0].get("Id"), 700, 400);
                }
                }, '-',
                { text: "删 除", handler: function () {
                    var recs = grid.getSelectionModel().getSelection();
                    if (!recs || recs.length <= 0) {
                        Ext.Msg.alert("提示", "请选择删除记录!");
                        return;
                    }
                    Ext.MessageBox.confirm("提示", "确定删除吗?", callBack);
                    function callBack(str) {
                        if (str == "yes") {
                            var Jarray = [];
                            Ext.each(recs, function (rec) {
                                Jarray.push(rec.get("Id"));
                            });
                        }
                        Ext.Ajax.request({
                            url: "DelegateInfoList.aspx",
                            params: { Jarray: Jarray, action: "Delete" },
                            callback: function () {
                                store.reload();
                            }
                        });
                    }
                }
                }
                ]
            });
            var pagebar = Ext.create('Ext.toolbar.Paging', {
                displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                // emptyMsg: "没有数据",
                //                beforePageText: "当前页",
                //                afterPageText: "共{0}页",
                store: store,
                displayInfo: true
            });
            grid = Ext.create("Ext.grid.Panel", {
                store: store,
                title: "窗口管理",
                region: "center",
                selModel: { selType: "checkboxmodel" },
                enableColumnHide: false,
                columns: [
                    { xtype: "rownumberer", width: 35 },
                    { dataIndex: "Id", header: "标示", hidden: true },
                    { dataIndex: "DelegateName", header: "窗口名称", width: 150 },
                    { dataIndex: "DelegateCode", header: "窗口编号", width: 75 },
                    { dataIndex: "DengJiBenNo", header: "登记本序号", width: 120 },
                    { dataIndex: "DelegateHead", header: "联系人", width: 80 },
                    { dataIndex: "Telephone", header: "联系电话", width: 120 },
                    { dataIndex: "Email", header: "电子邮箱", width: 160 },
                    { dataIndex: "Remark", header: "备注", flex: 1 },
                    { dataIndex: "CreateName", header: "创建人", width: 70 },
                    { dataIndex: "CreateTime", header: "创建时间", xtype: 'datecolumn', format: 'Y-m-d', width: 100 }
                ],
                tbar: toolbar,
                bbar: pagebar
            });
            var viewport = Ext.create("Ext.container.Viewport", {
                layout: "border",
                items: [grid]
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
