<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectFileReport.aspx.cs"
    Inherits="SP.Web.ProjectManage.ProjectFileReport" %>

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
        var typearray = [];
        Ext.onReady(function () {
            Ext.regModel("SysEnumeration", { fields: ["id", "Name", "Code", "Value", "ParentID", "leaf", "SortIndex"] });
            treepanelstore = new Ext.data.TreeStore({
                model: 'SysEnumeration',
                nodeParam: 'id',
                proxy: {
                    type: 'ajax',
                    url: 'ProjectFileReport.aspx?action=select',
                    reader: 'json'
                },
                root: {
                    expanded: true,
                    Name: '文件类型',
                    id: 'cf38bd7a-79d1-46fb-bf06-640b30f61654'
                }
            });
            treepanel = Ext.create('Ext.tree.Panel', {
                title: '文件类型',
                useArrows: true,
                region: 'west',
                width: 280,
                hideHeaders: true,
                store: treepanelstore,
                columns: [
                { text: 'id', dataIndex: 'id', width: 100, hidden: true },
                { xtype: 'treecolumn', text: '文件类型', dataIndex: 'Name', width: 250}],
                listeners: { checkchange: function (node, checked, eOpts) {
                    if (checked) {
                        Ext.Array.push(typearray, node.get("id"));
                    }
                    else {
                        Ext.Array.remove(typearray, node.get("id"));
                    }
                    Ext.Ajax.request({
                        url: 'ProjectFileReport.aspx?action=inigrid',
                        params: { typeids: typearray, belongdept: combo_group.getValue() },
                        success: function (response, opts) {
                            var json = Ext.decode(response.responseText);
                            var filedarray = [];
                            var columnarray = [{ xtype: 'rownumberer', width: 50}];
                            for (var key in json.rows[0]) {
                                filedarray.push(key);
                                switch (key) {
                                    case "Id":
                                        columnarray.push({ header: 'Id', dataIndex: key, width: 200, hidden: true });
                                        break;
                                    case "ProjectName":
                                        columnarray.push({ header: '项目名称', dataIndex: key, width: 200, sortable: false });
                                        break;
                                    default:
                                        columnarray.push({ header: key.slice(36, key.length), dataIndex: key, width: 100, sortable: false });
                                        break;
                                }
                            }
                            store = Ext.create('Ext.data.JsonStore', {
                                fields: filedarray,
                                data: json.rows
                            })
                            gridpanel.reconfigure(store, columnarray);
                        }
                    })
                }
                }
            });
            var store = Ext.create('Ext.data.JsonStore', {
                fields: ['Id', 'ProjectName'],
                proxy: {
                    url: 'ProjectFileReport.aspx?action=loadprj',
                    type: 'ajax',
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            })
            var store_group = Ext.create('Ext.data.JsonStore', {
                fields: ['id', 'name'],
                proxy: {
                    url: 'ProjectFileReport.aspx?action=loadgroup',
                    type: 'ajax',
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            })
            var combo_group = Ext.create('Ext.form.field.ComboBox', {
                store: store_group,
                valueField: 'id',
                displayField: 'name',
                labelWidth: 60,
                fieldLabel: '所属部门',
                width: 180,
                editable: false
            })
            var tbar_grid = Ext.create('Ext.toolbar.Toolbar', {
                items: [{ xtype: 'textfield', fieldLabel: '项目名称', labelWidth: 70 }, '-', combo_group,
                { xtype: 'datefield', fieldLabel: '上传日期', labelWidth: 60, format: 'Y-m', width: 170 },
                 '-', { text: '查 询' },
                { text: '导出到EXCEL'}]
            })
            var gridpanel = Ext.create('Ext.grid.Panel', {
                tbar: tbar_grid,
                store: store,
                title: '项目文档报表',
                region: 'center',
                columnLines: true,
                columns: []
            })
            var viewport = new Ext.Viewport({
                layout: 'border',
                items: [treepanel, gridpanel]
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
