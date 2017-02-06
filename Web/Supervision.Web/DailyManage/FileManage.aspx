<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileManage.aspx.cs" Inherits="SP.Web.DailyManage.FileManage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <title></title>
    <script type="text/javascript">
        var node;
        Ext.onReady(function () {
            var toolbar = Ext.create('Ext.toolbar.Toolbar', {
                items: [
                { xtype: 'textfield', fieldLabel: '文件名称', labelWidth: 60, labelAlign: 'right', id: 'FileName_s' },
                { xtype: 'textfield', fieldLabel: '项目名称|编号', labelAlign: 'right', id: 'Project_s' },
                {
                    xtype: 'button', text: '查 询', handler: function () {
                        store_file.load({
                            params: {
                                filename: Ext.getCmp("FileName_s").getValue(), projectnamecode: Ext.getCmp("Project_s").getValue(),
                                node: '{level:5}'
                            }
                        });
                    }
                }, '-', {
                    text: '上 传', handler: function () {
                        var nodes = treepanel.getSelectionModel().getSelection();
                        //客户20141124更改需求,文件可以直接上传到部门下面，也可以上传到部门下面
                        if (nodes.length > 0) {
                            opencenterwin("ProjectFileUpload.aspx?groupid=" + nodes[0].get("groupid") + "&projectid=" + nodes[0].get("projectid"), 800, 400);
                        }
                        else {
                            Ext.Msg.alert('提示', "请选择需要上传文件的项目或者项目下的文件类型！");
                        }
                    }
                }, '-', {
                    text: '删 除', handler: function () {
                        var recs = gridpanel.getSelectionModel().getSelection();
                        if (recs.length > 0) {
                            Ext.Ajax.request({
                                url: 'FileManage.aspx?action=delete&fileid=' + recs[0].get("Id"),
                                success: function (response) {
                                    store_file.remove(recs[0]);
                                    Ext.Msg.alert('提示', "文件删除成功！");
                                }
                            })
                        }
                        else {
                            Ext.Msg.alert('提示', "请选择需要删除的文件！");
                        }
                    }
                }
                ]
            })
            Ext.regModel('TreeModel', { fields: ['id', 'name', 'leaf', 'level', 'groupid', 'projectid', 'firsttypeid', 'secondtypeid'] })
            var treestore = Ext.create('Ext.data.TreeStore', {
                model: 'TreeModel',
                nodeParam: 'id',
                proxy: {
                    url: 'FileManage.aspx?action=loadtreedata',
                    type: 'ajax',
                    reader: 'json'
                },
                root: {
                    id: '228',
                    level: '0',
                    name: '江西瑞林建设监理有限公司',
                    expanded: true
                },
                listeners: {
                    beforeload: function (treestore, operation, eOpts) {
                        treestore.getProxy().setExtraParam("node", Ext.encode(operation.node.data));
                    }
                }
            })
            var treepanel = Ext.create('Ext.tree.Panel', {
                region: 'west',
                width: 320,
                // rootVisible: false,
                store: treestore,
                columns: [
                { header: 'id', dataIndex: 'id', hidden: true },
                { header: 'leaf', dataIndex: 'leaf', hidden: true },
                { header: '名称', dataIndex: 'name', xtype: 'treecolumn', flex: 1 }
                ],
                listeners: {
                    itemclick: function (treepanel, record, item, index, e, eOpts) {
                        node = Ext.encode(record.data);
                        store_file.load();
                        //store_file.load({ params: { 'node': Ext.encode(record.data)} });
                    }
                }
            })
            Ext.regModel("FileItem", { fields: ['Id', 'Name', 'ProjectName', 'SecondTypeName', 'FolderName', 'CreateTime', 'CreateName'] })
            var store_file = Ext.create('Ext.data.JsonStore', {
                model: 'FileItem',
                pageSize: 25,
                proxy: {
                    url: 'FileManage.aspx?action=loadfile',
                    type: 'ajax',
                    reader: {
                        root: 'rows',
                        totalProperty: 'total',
                        type: 'json'
                    }
                },
                listeners: {
                    beforeload: function () {
                        store_file.getProxy().extraParams = {
                            node: node
                        }
                    }
                }
            })
            var pgbar = Ext.create('Ext.toolbar.Paging', {
                store: store_file,
                displayInfo: true,
                displayMsg: '显示 {0} - {1} 条,共计 {2} 条'
            })
            var gridpanel = Ext.create('Ext.grid.Panel', {
                region: 'center',
                bbar: pgbar,
                store: store_file,
                selModel: { selType: 'checkboxmodel' },
                columns: [
                { xtype: 'rownumberer', width: 35 },
                // { header: 'Id', dataIndex: 'Id', hidden: true },
                { header: '文件名称', dataIndex: 'Name', flex: 1 },
                { header: '文件类型', dataIndex: 'SecondTypeName', width: 100 },
                { header: '所属项目', dataIndex: 'ProjectName', width: 150 },
                { header: '上传人', dataIndex: 'CreateName', width: 70 },
                { header: '上传时间', dataIndex: 'CreateTime', xtype: 'datecolumn', width: 90, format: 'Y-m-d' },
                {
                    header: '下载', dataIndex: 'Id', align: 'center', width: 60, xtype: 'actioncolumn', items: [
                      {
                          icon: '/images/download.png', handler: function (grid, rowIndex, colIndex) {
                              var rec = store_file.getAt(rowIndex);
                              var url = "/ProjectFile/" + rec.get("FolderName") + "/" + rec.get("Id") + "_" + rec.get("Name");
                              opencenterwin(url, 400, 400);
                          }
                      }]
                }
                ]
            })
            var panel = Ext.create('Ext.panel.Panel', {
                title: '文件管理',
                tbar: toolbar,
                region: 'center',
                layout: 'border',
                items: [treepanel, gridpanel]
            })
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [panel]
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
