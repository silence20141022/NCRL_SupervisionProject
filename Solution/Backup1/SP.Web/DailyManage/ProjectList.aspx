<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectList.aspx.cs" Inherits="SP.Web.DailyManage.ProjectList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var tabIndex = 0;
        var store_project;
        Ext.onReady(function () {
            Ext.regModel('Project', { fields: ['Id', 'ProjectCode', 'ProjectName', 'PManagerName', 'BelongDeptId',
             'BelongDeptName', 'JianSheUnit',
            'BelongDeptName', 'Remark', 'CreateTime']
            })
            store_project = Ext.create('Ext.data.JsonStore', {
                model: 'Project',
                pageSize: 25,
                proxy: {
                    url: 'ProjectList.aspx?action=loadproject',
                    extraParams: { tabIndex: tabIndex },
                    type: 'ajax',
                    reader: {
                        type: 'json',
                        root: 'rows',
                        totalProperty: 'total'
                    }
                }
            })
            var store_group = Ext.create('Ext.data.JsonStore', {
                fields: ['id', 'name'],
                proxy: {
                    url: 'ProjectList.aspx?action=loadgroup',
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
                fieldLabel: '所属部门'
                // width: 180,
                // editable: false
            })
            var toolbar = Ext.create('Ext.toolbar.Toolbar', {
                items: [
                { xtype: 'textfield', fieldLabel: '编号|名称', labelAlign: 'right', id: 'CodeName_s', labelWidth: 60 },
                { xtype: 'textfield', fieldLabel: '项目总监', labelAlign: 'right', id: 'Manager_s', labelWidth: 60 },
                combo_group,
                { xtype: 'button', text: '查询', icon: '/images/shared/search_show.gif', handler: function () {
                    store_project.load({ params: { tabIndex: tabIndex, CodeName: Ext.getCmp("CodeName_s").getValue(),
                        Manager: Ext.getCmp("Manager_s").getValue(), BelongDeptId: combo_group.getValue(), start: 0
                    }
                    })
                }
                },
                { text: '同步项目', handler: function () {
                    Ext.Ajax.request({
                        url: 'ProjectList.aspx?action=synchronize',
                        type: 'ajax',
                        callback: function (option, success, response) {
                            alert(response.responseText);
                            //var json = Ext.decode(response.responseText);
                            //                            if (json.success) {
                            //                                alert('同步成功！');
                            //                            }
                            //                            else {
                            //                                alert('同步失败！');
                            //                            }
                        }
                    })
                }
                }, '-', { text: '修改', handler: function () {
                    var recs = grid_project1.getSelectionModel().getSelection();
                    if (recs && recs.length > 0) {
                        opencenterwin("ProjectEdit.aspx?action=init&Id=" + recs[0].get("Id"), 800, 500);
                    }
                    else {
                        alert("请选择要修改的记录！");
                    }
                }
                }, '-', { text: '文档上传',
                    handler: function () {
                        var recs = grid_project1.getSelectionModel().getSelection();
                        if (recs && recs.length > 0) {
                            opencenterwin("ProjectFileUpload.aspx?groupid=" + recs[0].get("BelongDeptId") + "&projectid=" + recs[0].get("Id"), 800, 400);
                        }
                        else {
                            alert("请选择要上传文件的项目！");
                        }
                    }
                }, '-', { text: '标记结束', handler: function () {
                }
                }
            ]
            })
            var grid_project1 = Ext.create('Ext.grid.Panel', {
                tbar: toolbar,
                store: store_project,
                region: 'center',
                columnLines: true,
                style: {
                    borderWidth: 0,
                    borderColor: 'red'
                },
                bbar: {
                    xtype: 'pagingtoolbar',
                    displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                    // emptyMsg: "没有数据",
                    // beforePageText: "当前页",
                    // afterPageText: "共{0}页",
                    store: store_project,
                    displayInfo: true
                },
                enableColumnHide: false,
                selModel: { selType: 'checkboxmodel' },
                columns: [
                { xtype: 'rownumberer', width: 35 },
                { dataIndex: 'ProjectCode', header: '项目编号', width: 120 },
                { dataIndex: 'ProjectName', header: '项目名称', width: 200 },
                { dataIndex: 'PManagerName', header: '项目总监', width: 80 },
                { dataIndex: 'BelongDeptName', header: '所属部门', width: 110 },
                { dataIndex: 'Remark', header: '工程概况', flex: 1, sortable: false },
                { dataIndex: 'CreateTime', xtype: 'datecolumn', header: '下达日期', width: 100, format: 'Y-m-d' }
                ]
            })
            var grid_project2 = Ext.create('Ext.grid.Panel', {
                //tbar: toolbar,
                store: store_project,
                region: 'center',
                columnLines: true,
                style: {
                    borderWidth: 0,
                    borderColor: 'red'
                },
                bbar: {
                    xtype: 'pagingtoolbar',
                    displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                    store: store_project,
                    displayInfo: true
                },
                enableColumnHide: false,
                selModel: { selType: 'checkboxmodel' },
                columns: [
                { xtype: 'rownumberer', width: 35 },
                { dataIndex: 'ProjectCode', header: '项目编号', width: 120 },
                { dataIndex: 'ProjectName', header: '项目名称', flex: 1, sortable: false },
                { dataIndex: 'PManagerName', header: '项目总监', width: 80, sortable: false },
                { dataIndex: 'BelongDeptName', header: '所属部门', width: 110 }
                ]
            })
            var tabpanel = Ext.create('Ext.tab.Panel', {
                region: 'center',
                items: [
                {
                    title: '进行中', layout: 'border', height: 160,
                    listeners: { activate: function (tab, opitions) {
                        store_project.getProxy().setExtraParam("tabIndex", 0);
                        store_project.load();
                    }
                    },
                    items: [grid_project1]
                },
                     { title: '已完成', layout: 'border',
                         listeners: { activate: function () {
                             tabIndex = 1;
                             store_project.getProxy().setExtraParam("tabIndex", tabIndex);
                             store_project.load();
                         }
                         }, items: [grid_project2]
                     }]
            })
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [tabpanel]
            })

        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
    </form>
</body>
</html>
