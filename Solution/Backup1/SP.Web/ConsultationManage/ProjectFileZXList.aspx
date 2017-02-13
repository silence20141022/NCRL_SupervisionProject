<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectFileZXList.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ProjectFileZXList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../Extjs42/TreePicker.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var treepanelStore, treepanelGrid, store, grid;
        var ProjectId;
        Ext.onReady(function () {
            Project();
            ProjectFile();
            SetPageUI();
        });
        function SetPageUI() {
            var tbar = Ext.create("Ext.toolbar.Toolbar", {
                items: [
                    { xtype: "textfield", fieldLabel: "项目名称", labelAlign: "right", id: "ProjectName_s" },
                    { xtype: "textfield", fieldLabel: "文件名", labelWidth: 60, labelAlign: "right", id: "FileName_s" },
                    { text: "查询", icon: '/images/shared/search_show.gif', handler: function () {
                        var ProjectName_s = Ext.getCmp("ProjectName_s").getValue();
                        var FileName_s = Ext.getCmp("FileName_s").getValue();

                        treepanelStore.load({ params: { ProjectName: ProjectName_s} });

                        store.load({ params: { Name: FileName_s, start: 0} });
                    }
                    },
                    { text: "删除", icon: '/images/shared/delete.gif', handler: function () {
                        var recs = grid.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert("提示", "请选择要删除的记录!");
                            return;
                        }
                        Ext.MessageBox.confirm("提示", "确定删除吗?", function (str) {
                            if (str == "yes") {
                                var Jarray = [];
                                Ext.each(recs, function (rec) {
                                    Jarray.push(rec.get("Id"));
                                });
                                Ext.Ajax.request({
                                    url: "ProjectFileZXList.aspx?action=Delete",
                                    async: false,
                                    params: { Jarray: Jarray },
                                    callback: function (option, success, response) {
                                        store.reload();
                                    }
                                });
                            }
                        });


                    }
                    },
                    { text: "上传", icon: '/images/shared/upload.png', handler: function () {
                        var rec = treepanelGrid.getSelectionModel().getSelection();
                        if (!rec || rec.length <= 0) {
                            Ext.Msg.alert("提示", "请选择要上传文件的项目!");
                            return;
                        }
                        opencenterwin("ProjectFileZXEdit.aspx?ProjectId=" + rec[0].get("id") + "&ProjectName=" + rec[0].get("Name"), 600, 400);
                    }
                    }
                ]
            });

            var panel = Ext.create("Ext.panel.Panel", {
                title: "项目资料库",
                tbar: tbar,
                region: "center",
                layout: "border",
                items: [treepanelGrid, grid]
            });
            var viewport = Ext.create("Ext.Viewport", {
                layout: "border",
                items: [panel]
            });
        }
        function Project() {
            treepanelStore = Ext.create("Ext.data.TreeStore", {
                fields: ["id", "Name", "leaf"],
                nodeParam: "id",
                proxy: {
                    type: "ajax",
                    url: "ProjectFileZXList.aspx?action=selectPorject",
                    reader: {
                        type: 'json'
                    }
                },
                root: {
                    expanded: true,
                    Name: "所有项目",
                    id: "100001"
                }
            });
            treepanelGrid = Ext.create("Ext.tree.Panel", {
                region: "west",
                width: 400,
                useArrows: true,
                store: treepanelStore,
                columns: [
                    { text: "id", dataIndex: "id", hidden: true },
                    { xtype: "treecolumn", text: "项目名称", dataIndex: "Name", flex: 1 }
                ],
                listeners: { itemclick: function (treepanel, record, item, index, e, eOpts) {
                    ProjectId = record.get("id");
                    store.load({ params: { ProjectId: ProjectId} });
                }
                }
            });
        }
        function ProjectFile() {
            Ext.regModel("FileItem", { fields: ["Name", "CreatorName", "CreateTime", "Id", "FolderName"] });
            store = Ext.create("Ext.data.JsonStore", {
                model: "FileItem",
                pageSize: 2,
                proxy: {
                    url: "ProjectFileZXList.aspx?action=FileItem",
                    type: "ajax",
                    extraParams: { ProjectId: "" },
                    reader: {
                        root: "rows",
                        totalProperty: "total",
                        type: "json"
                    }
                },
                listeners: { "beforeload": function (store, operation, eOpts) {
                    store.proxy.extraParams.ProjectId = ProjectId;
                }
                },
                autoLoad: { start: 0, limit: 2 }
            });
            var pagebar = Ext.create('Ext.toolbar.Paging', {
                store: store,
                displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                emptyMsg: "没有数据",
                beforePageText: "当前页",
                afterPageText: "共{0}页"
            })

            grid = Ext.create("Ext.grid.Panel", {
                region: "center",
                store: store,
                selModel: { selType: "checkboxmodel" },
                columns: [
                    { xtype: "rownumberer", width: 35 },
                    { header: "文件名称", dataIndex: "Name", flex: 1 },
                    { header: "上传人", dataIndex: "CreatorName", width: 100 },
                    { header: "上传时间", dataIndex: "CreateTime", xtype: "datecolumn", format: "Y-m-d", width: 100 },
                    { header: "下载", dataIndex: "Id", width: 60, align: "center", xtype: "actioncolumn",
                        items: [
                                            { icon: '/images/download.png', handler: function (grid, rowIndex, colIndex) {
                                                var rec = store.getAt(rowIndex);
                                                var url = "/ProjectFile/" + rec.get("FolderName") + "/" + rec.get("Id") + "_" + rec.get("Name");
                                                opencenterwin(url, 400, 400);
                                            }
                                            }
                        ]
                    }
                ],
                bbar: pagebar
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
