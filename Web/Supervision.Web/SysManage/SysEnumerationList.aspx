<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SysEnumerationList.aspx.cs"
    Inherits="SP.Web.SysManage.SysEnumerationList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script type="text/javascript">
        var treepanelstore, Treepanelgrid, formPanel, win;
        Ext.onReady(function () {
            Ext.regModel("SysEnumeration", { fields: ["id", "Name", "Code", "Value", "ParentID", "Path", "PathLevel", "leaf", "SortIndex"] });
            treepanelstore = Ext.create("Ext.data.TreeStore", {
                model: "SysEnumeration",
                nodeParam: "id",
                proxy: {
                    type: "ajax",
                    url: "SysEnumerationList.aspx?action=select",
                    reader:
                    {
                        type: "json",
                        root: 'children'
                    }
                },
                root: {
                    expanded: true,
                    Name: "系统枚举",
                    id: "100001"
                }
            });
            var toolbar = Ext.create("Ext.toolbar.Toolbar", {
                items: [
                    { text: "添加", handler: function () {
                        var recs = Treepanelgrid.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert("提示", "请选择要增加子节点的记录!");
                            return;
                        }
                        formPanel.form.reset();
                        Ext.getCmp("ParentID").setValue(recs[0].get("id"));
                        win.show();
                    }
                    }, "-",
                    { text: "修改", handler: function () {
                        var recs = Treepanelgrid.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert("提示", "请选择要修改的节点");
                            return;
                        }
                        Id = recs[0].get('id');
                        formPanel.getForm().load({
                            url: "SysEnumerationList.aspx",
                            params: { action: "loadform", EnumerationID: Id },
                            method: "GET",
                            success: function () {
                                win.show();
                            }
                        });
                    }
                    }, "-",
                    { text: "删除", handler: function () {
                        var recs = Treepanelgrid.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert("提示", "请选择要删除的节点!");
                            return;
                        }
                        if (!recs[0].get("leaf")) {
                            Ext.Msg.alert("提示", "包含子节点的记录不允许删除!");
                            return;
                        }
                        Ext.Ajax.request({
                            url: 'SysEnumerationList.aspx?action=delete',
                            params: { EnumID: recs[0].get("id") },
                            callback: function () {
                                Ext.Msg.alert("提示", "删除成功!", function () {
                                    var path = recs[0].getPath("id");
                                    treepanelstore.load({
                                        scope: this,
                                        callback: function (records, operation, success) {
                                            Treepanelgrid.expandPath(path);
                                        }
                                    });
                                });
                            }
                        })
                    }
                    }]
            });

            Treepanelgrid = Ext.create("Ext.tree.Panel", {
                title: "枚举管理",
                tbar: toolbar,
                useArrows: true,
                region: "center",
                hideHeaders: true,
                store: treepanelstore,
                columns: [
                    { text: "id", dataIndex: "id", hidden: true },
                    { xtype: "treecolumn", text: "文件类型", dataIndex: "Name", flex: 1 },
                    { text: '值', dataIndex: 'Value', hidden: true },
                    { text: '父节点ID', dataIndex: 'ParentID', hidden: true },
                    { text: '父级ID', dataIndex: 'Path', hidden: true },
                    { text: '哪一级', dataIndex: 'PathLevel', hidden: true },
                    { text: '是不是叶子', dataIndex: 'leaf', hidden: true }
                ]
            });
            var viewport = Ext.create("Ext.Viewport", {
                layout: 'border',
                items: [Treepanelgrid]
            });
            formPanel = Ext.create("Ext.form.Panel", {
                layout: "anchor",
                frame: false,
                defaults: { labelAlign: 'right', xtype: 'textfield', msgTarget: 'under', margin: '10' },
                items: [
                { name: 'Code', anchor: '70%', fieldLabel: '编码', allowBlank: false, blankText: '类型编码不能为空' },
                { name: 'Name', anchor: '70%', fieldLabel: '名称', allowBlank: false, blankText: '类型名称不能为空' },
                { name: 'SortIndex', anchor: '70%', fieldLabel: '序号', minValue: 0, xtype: 'numberfield' },
                { name: 'Description', anchor: '100%', fieldLabel: '描述', xtype: 'textareafield' },
                { name: 'EnumerationID', id: "EnumerationID", xtype: 'hidden' },
                { name: 'ParentID', id: 'ParentID', xtype: 'hidden' }
                ],
                buttons: [
                { text: "保 存", handler: save },
                { text: "取 消", handler: function () {
                    win.close();
                }
                }
                ],
                buttonAlign: "center"
            });
            win = Ext.create("Ext.window.Window", {
                title: "枚举类型",
                width: 600,
                height: 400,
                closeAction: "hide",
                layout: "fit",
                collapsible: true,
                modal: true,
                maximizable: true,
                minimizable: true,
                items: [formPanel]
            });
        });

        function save() {
            var Form = formPanel.getForm();
            if (Form.isValid()) {
                var action = Form.findField("EnumerationID").getValue() ? "update" : "create";
                var json = Ext.encode(Form.getValues());
                Ext.Ajax.request({
                    url: "SysEnumerationList.aspx",
                    params: { action: action, json: json },
                    callback: function (option, success, response) {
                        var recs = Treepanelgrid.getSelectionModel().getSelection();
                        var path = recs[0].getPath("id");
                        treepanelstore.reload({
                            scope: this,
                            callback: function (records, operation, success) {
                                Treepanelgrid.expandPath(path);
                                win.close()
                            }
                        });

                    }
                });
            }
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
