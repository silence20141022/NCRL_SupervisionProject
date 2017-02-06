<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExpertList.aspx.cs" Inherits="SP.Web.ConsultationManage.ExpertList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <link href="../font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var store, grid;
        Ext.onReady(SetPage);
        function SetPage() {
            Ext.regModel("Expert", { fields: ["Id", "UserName", "Sex", "Email", "Phone", "ProfessionType", "MajorName",
            "Burthen", "HomeAddress", "CreateTime", "SortIndex"]
            });
            store = Ext.create("Ext.data.JsonStore", {
                model: "Expert",
                pageSize: 25,
                remoteSort: true,
                proxy: {
                    url: "ExpertList.aspx?action=DoSelect",
                    type: "ajax",
                    reader: {
                        type: "json",
                        root: "rows",
                        totalProperty: "total"
                    }
                },
                autoLoad: true
            });
            var store_major = Ext.create("Ext.data.JsonStore", {
                fields: ['name'],
                proxy: {
                    url: "ExpertList.aspx?action=loadmajor",
                    type: "ajax",
                    reader: {
                        type: "json",
                        root: "rows"
                    }
                }
            });
            var toolbar = Ext.create("Ext.toolbar.Toolbar", {
                items: [
                { xtype: "textfield", fieldLabel: "姓名", id: "UserName", labelAlign: 'right', labelWidth: 60 },
                { xtype: "combobox", fieldLabel: "专业", labelWidth: 60, labelAlign: 'right', displayField: 'name',
                    valueField: 'name', id: "MajorName", store: store_major
                },
                { text: "查 询", handler: function () {
                    store.load({ params: { UserName: Ext.getCmp("UserName").getValue(), MajorName: Ext.getCmp("MajorName").getValue(), start: 0} });
                }
                }, '-',
                { text: "添 加", handler: function () {
                    opencenterwin("ExpertEdit.aspx", 900, 500);
                }
                }, '-',
                { text: "修 改", handler: function () {
                    var recs = grid.getSelectionModel().getSelection();
                    if (!recs || recs.length <= 0) {
                        Ext.Msg.alert("提示", "请选择修改信息!");
                        return;
                    }
                    opencenterwin("ExpertEdit.aspx?id=" + recs[0].get("Id"), 900, 500);
                }
                }, '-',
                { text: "删 除", handler: function () {
                    var recs = grid.getSelectionModel().getSelection();
                    if (!recs || recs.length <= 0) {
                        Ext.Msg.alert("提示", "请选择删除信息!");
                        return;
                    }
                    if (recs.length > 1) {
                        Ext.Msg.alert("提示", "不支持多条删除!");
                        return;
                    }
                    Ext.MessageBox.confirm("提示", "确定删除吗?", function (str) {
                        if (str == "yes") {
                            Ext.Ajax.request({
                                url: "ExpertList.aspx?action=Delete",
                                async: false,
                                params: { Id: recs[0].get("Id") },
                                callback: function (option, success, response) {
                                    var data = Ext.decode(response.responseText);
                                    var IsDelete = data.IsDelete;
                                    if (IsDelete == "false") {
                                        Ext.Msg.alert("提示", "该专家已关联项目,不可删除!");
                                        return;
                                    }
                                    store.reload();
                                }
                            });
                        }
                    });
                }
                }
                ]
            });
            var pagebar = Ext.create('Ext.toolbar.Paging', {
                store: store,
                displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                emptyMsg: "没有数据",
                beforePageText: "当前页",
                afterPageText: "共{0}页",
                displayInfo: true
            })
            grid = Ext.create("Ext.grid.Panel", {
                enableColumnHide: false,
                store: store,
                title: "专家管理",
                region: "center",
                plugins: [Ext.create('Ext.grid.plugin.CellEditing', {
                    clickToEdit: 1,
                    listeners: { edit: function (editor, e, eOpts) {
                        Ext.Ajax.request({
                            url: 'ExpertList.aspx?action=updatesortindex',
                            params: { id: e.record.get("Id"), sortindex: e.value },
                            callback: function () {
                                e.record.commit();
                            }
                        })
                    }
                    }
                })],
                selModel: { selType: "checkboxmodel" },
                columns: [
                { dataIndex: "SortIndex", header: "序号", width: 70, editor: { xtype: 'numberfield', minValue: 0, allowBlank: false} },
                { dataIndex: "Id", header: "标示", hidden: true },
                { dataIndex: "UserName", header: "姓名", width: 70 },
                { dataIndex: "Sex", header: "性别", width: 50 },
                { dataIndex: "Email", header: "邮箱", width: 180 },
                { dataIndex: "Phone", header: "手机号码", width: 120 },
                { dataIndex: "ProfessionType", header: "专家类型", width: 190 },
                { dataIndex: "MajorName", header: "专业", flex: 1 },
                { dataIndex: 'SortIndex', header: '升/降序', width: 65, sortable: false, renderer: function (value, metadata, record, rowindex, colIndex) {
                    rtn = "<span class='fa fa-arrow-up  text-info' style='cursor: pointer' onclick='levelup(\"" + rowindex + "\")'></span>&nbsp;&nbsp;&nbsp;&nbsp;<span onclick='leveldown(\"" + rowindex + "\")' class='fa fa-arrow-down text-info' style='cursor: pointer'></span>";
                    return rtn;
                }
                }
                ],
                tbar: toolbar,
                bbar: pagebar
            });
            var viewport = Ext.create("Ext.container.Viewport", {
                layout: "border",
                items: [grid]
            });
        }
        function levelup(rowindex) {
            Ext.Ajax.request({
                url: 'ExpertList.aspx?action=upsortindex',
                params: { expert: Ext.encode(store.getAt(rowindex).data) },
                callback: function (option, success, response) {
                    store.reload();
                }
            })
        }
        function leveldown(rowindex) {
            Ext.Ajax.request({
                url: 'ExpertList.aspx?action=downsortindex',
                params: { expert: Ext.encode(store.getAt(rowindex).data) },
                callback: function (option, success, response) {
                    store.reload();
                }
            })
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
