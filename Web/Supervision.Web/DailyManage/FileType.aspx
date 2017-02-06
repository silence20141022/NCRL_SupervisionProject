<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileType.aspx.cs" Inherits="SP.Web.DailyManage.FileType" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var treepanelstore, treepanel, view_cur, rec_cur, node_cur;
        var nodeid = getQueryString("nodeid");
        Ext.onReady(function () {
            Ext.regModel("SysEnumeration", { fields: ["id", "Name", "Code", "Value", "ParentID", "Path", "PathLevel", "leaf", "SortIndex"] });
            treepanelstore = new Ext.data.TreeStore({
                model: 'SysEnumeration',
                nodeParam: 'id',
                proxy: {
                    type: 'ajax',
                    url: 'FileType.aspx?action=select',
                    reader: 'json'
                },
                root: {
                    expanded: true,
                    Name: '文件类型',
                    id: 'cf38bd7a-79d1-46fb-bf06-640b30f61654'
                }
            });
            var toolbar = Ext.create('Ext.toolbar.Toolbar', {
                items: [
                { text: '添 加', handler: function () {
                    var recs = treepanel.getSelectionModel().getSelection();
                    if (!recs) {
                        Ext.Msg.alert("提示", "请选择要增加子节点的位置!");
                        return;
                    }
                    opencenterwin("FileTypeEdit.aspx?ParentID=" + recs[0].get('id'), 600, 400);
                }
                }, '-',
                { text: '修 改', handler: function () {
                    var recs = treepanel.getSelectionModel().getSelection();
                    if (!recs) {
                        Ext.Msg.alert("提示", "请选择要修改的节点!");
                        return;
                    }
                    if (recs[0].isRoot()) {
                        Ext.Msg.alert("提示", "根节点不允许修改!");
                        return;
                    }
                    opencenterwin("FileTypeEdit.aspx?SysEnumerationId=" + recs[0].get('id') + "&ParentID=" + recs[0].get("ParentID"), 600, 400);
                }
                }, '-', {
                    text: '删 除', handler: function () {
                        var recs = treepanel.getSelectionModel().getSelection();
                        if (!recs) {
                            Ext.Msg.alert("提示", "请选择要删除的节点!");
                            return;
                        }
                        if (!recs[0].get("leaf")) {
                            Ext.Msg.alert("提示", "包含子节点的记录不允许删除!");
                            return;
                        }
                        nodeid = recs[0].get("ParentID");
                        Ext.Ajax.request({
                            url: 'FileType.aspx?action=delete',
                            params: { id: recs[0].get("id") },
                            callback: function () {
                                Ext.Msg.alert("提示", "删除成功!", function () {
                                    window.location.href = "FileType.aspx?nodeid=" + nodeid;
                                });
                            }
                        })
                    }
                }]
            })
            treepanel = Ext.create('Ext.tree.Panel', {
                title: '文件类型',
                useArrows: true,
                region: 'center',
                tbar: toolbar,
                hideHeaders: true,
                store: treepanelstore,
                columns: [
                { text: 'id', dataIndex: 'id', width: 100, hidden: true },
                { xtype: 'treecolumn', text: '文件类型', dataIndex: 'Name', flex: 1 },
                { text: '值', dataIndex: 'Value', width: 100, hidden: true },
                { text: '父节点ID', dataIndex: 'ParentID', width: 100, hidden: true },
                { text: '父级ID', dataIndex: 'Path', width: 100, hidden: true },
                { text: '哪一级', dataIndex: 'PathLevel', width: 100, hidden: true },
                { text: '是不是叶子', dataIndex: 'leaf', width: 100, hidden: true }
                ],
                listeners: { itemclick: function (view, rec, node) {
                    view_cur = view;
                    rec_cur = rec;
                    node_cur = node;
                }
                }
            });
            var viewport = new Ext.Viewport({
                layout: 'border',
                items: [treepanel]
            });
            if (nodeid) {
                var dt = new Ext.util.DelayedTask(function () {
                    var rec = treepanelstore.getNodeById(nodeid);
                    treepanel.expandNode(rec);
                })
                dt.delay(1000);
            }          
      });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    </form>
</body>
</html>
