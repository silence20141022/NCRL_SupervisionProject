<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectList.aspx.cs" Inherits="SP.Web.ConsultationManage.ProjectList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../Extjs42/RowExpander.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var store1, grid1;
        var ProjectName = "";
        var recs;
        Ext.onReady(function () {
            var store = Ext.create("Ext.data.JsonStore", {
                fields: ["Id", "ZiXunCode", "ProjectName", "ProjectType", "ContractAmount", "Status", "TaskQuan", "JianSheUnit", "SongShenTime", "CreateName"],
                pageSize: 25,
                proxy: {
                    url: "ProjectList.aspx?action=loadproject",
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
                   { xtype: "textfield", fieldLabel: "项目名称|编号", id: "ProjectName_s", labelAlign: 'right' },
                   { text: "查 询", handler: function () {
                       store.load({ params: { start: 0, ProjectName: Ext.getCmp("ProjectName_s").getValue()} });
                   }
                   },
                   { text: "添 加", handler: function () {
                       opencenterwin("ProjectCard.aspx", 1100, 600);
                   }
                   },
                   { text: "修 改", handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.Msg.alert("提示", "请选择要修改的记录！");
                           return;
                       }
                       opencenterwin("ProjectCard.aspx?id=" + recs[0].get("Id"), 1100, 600);
                   }
                   },
                   { text: "删 除", handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.Msg.alert("提示", "请选择要删除的记录！");
                           return;
                       }
                       if (recs.length > 1) {
                           Ext.Msg.alert("提示", "请单个删除！");
                           return;
                       }
                       if (recs[0].get("Status") == "已下达") {
                           Ext.Msg.alert("提示", "已下达任务的项目不能删除！");
                           return;
                       }
                       Ext.MessageBox.confirm("提示", "确定删除吗?", callBack);
                       function callBack(str) {
                           if (str = "yes") {
                               Ext.Ajax.request({
                                   url: "ProjectList.aspx?action=delete",
                                   params: { Id: recs[0].get("Id") },
                                   callback: function () {
                                       store.reload();
                                   }
                               });

                           }
                       }
                   }
                   },
                   { text: "下达任务", handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (recs[0].get("Status") == "已结束" || recs[0].get("Status") == "已下达") {
                           Ext.Msg.alert("提示", "该项目的审查任务" + recs[0].get("Status"));
                       }
                       else {
                           opencenterwin("AssignedTasks.aspx?Id=" + recs[0].get("Id"), 1000, 500);
                       }
                   }
                   },
                   { text: "回收任务", handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.Msg.alert("提示", "请先选择要回收的记录!");
                           return;
                       }
                       Ext.Ajax.request({
                           url: "ProjectList.aspx?action=Recycle",
                           params: { id: recs[0].get("Id") },
                           async: false,
                           callback: function (option, success, response) {
                               var json = Ext.decode(response.responseText);
                               if (json.Result == "T") {
                                   store1.load();
                               } else {
                                   Ext.Msg.alert("提示", "审查任务回收失败,请先删除各任务的审查意见！");
                               }
                           }
                       });
                   }
                   }, { text: "添加发票", handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.Msg.alert("提示", "请先选择要操作的记录！");
                           return;
                       }
                       opencenterwin("InvoiceEdit.aspx?ProjectId=" + recs[0].get("Id"), 900, 600);
                   }
                   }, { text: '文件编辑', icon: '/images/shared/edit.gif', menu: [
                    { text: "审查备案登记表", handler: function () {
                        recs = grid.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert("提示", "请先选择要操作的记录！");
                            return;
                        }
                        opencenterwin("BeiAnDengJiBiao_Edit.aspx?ProjectId=" + recs[0].get("Id"));
                    }
                    },
                   { text: "审查报告", handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.Msg.alert("提示", "请先选择要操作的记录！");
                           return;
                       }
                       var projecttype = recs[0].get("ProjectType");
                       if (projecttype == "房屋建筑") {
                           opencenterwin("ShenChaReport_FWJZ.aspx?ProjectId=" + recs[0].get("Id"));
                       }
                       if (projecttype == "市政工程") {
                           opencenterwin("ShenChaReport_SZ.aspx?ProjectId=" + recs[0].get("Id"));
                       }
                       if (projecttype == "勘察") {
                           opencenterwin("ShenChaReport_KanCha.aspx?ProjectId=" + recs[0].get("Id"));
                       }
                       if (projecttype == "基坑支护") {
                           opencenterwin("ShenChaReport_JiKeng.aspx?ProjectId=" + recs[0].get("Id"));
                       }
                   }
                   },
                   { text: '工程勘察审查报告', handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.Msg.alert("提示", "请先选择要操作的记录！");
                           return;
                       }
                       opencenterwin("ShenChaReport_KanCha_Edit.aspx?ProjectId=" + recs[0].get("Id"));
                   }
                   },
                   { text: '审查终审意见表', handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.Msg.alert("提示", "请先选择要操作的记录！");
                           return;
                       }
                       opencenterwin("ZhongShenOpinionEdit.aspx?ProjectId=" + recs[0].get("Id"));
                   }
                   }, { text: '抗震设防专项审查监管表', handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.Msg.alert("提示", "请先选择要操作的记录！");
                           return;
                       }
                       opencenterwin("KangZhenOpinion_Edit.aspx?ProjectId=" + recs[0].get("Id"));
                   }
                   }
              ]
                   },
                   { text: '导出到WORD', icon: '/images/shared/xls.gif',
                       menu: [
                        { text: '审查意见封面', handler: function () {
                            recs = grid.getSelectionModel().getSelection();
                            if (!recs || recs.length <= 0) {
                                Ext.MessageBox.alert("提示", "请先选择要操作的记录!");
                                return;
                            }
                            Ext.Ajax.request({
                                url: "ProjectList.aspx?action=export_opinioncover",
                                params: { id: recs[0].get("Id") },
                                success: function (response, opts) {
                                    Ext.MessageBox.alert('提示', '导出成功!');
                                },
                                failure: function (response, opts) {
                                    Ext.MessageBox.alert('提示', '导出失败!');
                                }
                            });
                        }
                        },
                       { text: '审查合格书', handler: function () {
                           recs = grid.getSelectionModel().getSelection();
                           if (!recs || recs.length <= 0) {
                               Ext.MessageBox.alert("提示", "请先选择要操作的记录!");
                               return;
                           }
                           Ext.Ajax.request({
                               url: "ProjectList.aspx?action=exporthegeshu",
                               params: { id: recs[0].get("Id") },
                               callback: function (option, success, response) {
                                   Ext.MessageBox.alert("提示", "导出成功！");
                               }
                           });
                       }
                       },
                   { text: '审查备案登记表', handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.MessageBox.alert("提示", "请先选择要操作的记录!");
                           return;
                       }
                       Ext.Ajax.request({
                           url: "ProjectList.aspx?action=export_beiandengjibiao",
                           params: { id: recs[0].get("Id") },
                           success: function (response, opts) {
                               Ext.MessageBox.alert('提示', '导出成功!');
                           },
                           failure: function (response, opts) {
                               Ext.MessageBox.alert('提示', '导出失败!');
                           }
                       });
                   }
                   }, { text: '审查报告', handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.MessageBox.alert("提示", "请先选择要操作的记录!");
                           return;
                       }
                       Ext.Ajax.request({
                           url: "ProjectList.aspx?action=export_shenchabaogao",
                           params: { id: recs[0].get("Id") },
                           success: function (response, opts) {
                               Ext.MessageBox.alert('提示', '导出成功!');
                           },
                           failure: function (response, opts) {
                               Ext.MessageBox.alert('提示', '导出失败!');
                           }
                       });
                   }
                   }, { text: '工程勘察审查报告', handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.MessageBox.alert("提示", "请先选择要操作的记录!");
                           return;
                       }
                       Ext.Ajax.request({
                           url: "ProjectList.aspx?action=export_kanchashenchabaogao",
                           params: { id: recs[0].get("Id") },
                           success: function (response, opts) {
                               Ext.MessageBox.alert('提示', '导出成功!');
                           },
                           failure: function (response, opts) {
                               Ext.MessageBox.alert('提示', '导出失败!');
                           }
                       });
                   }
                   },
                    { text: '审查终审意见表', handler: function () {
                        recs = grid.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.MessageBox.alert("提示", "请先选择要操作的记录!");
                            return;
                        }
                        Ext.Ajax.request({
                            url: "ProjectList.aspx?action=export_zhongshenyijianbiao",
                            params: { id: recs[0].get("Id") },
                            success: function (response, opts) {
                                Ext.MessageBox.alert('提示', '导出成功!');
                            },
                            failure: function (response, opts) {
                                Ext.MessageBox.alert('提示', '导出失败!');
                            }
                        });
                    }
                    },
                   { text: '审查情况记录', handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.MessageBox.alert("提示", "请先选择要操作的记录!");
                           return;
                       }
                       Ext.Ajax.request({
                           url: "ProjectList.aspx?action=exportqingkuangjilu",
                           params: { id: recs[0].get("Id") },
                           success: function (response, opts) {
                               Ext.MessageBox.alert('提示', '导出成功!');
                           },
                           failure: function (response, opts) {
                               Ext.MessageBox.alert('提示', '导出失败!');
                           }
                       });
                   }
                   },
                   { text: '审查情况汇总', handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.MessageBox.alert("提示", "请先选择要操作的记录!");
                           return;
                       }
                       Ext.Ajax.request({
                           url: "ProjectList.aspx?action=export_shenchahuizong",
                           params: { id: recs[0].get("Id") },
                           success: function (response, opts) {
                               Ext.MessageBox.alert('提示', '导出成功!');
                           },
                           failure: function (response, opts) {
                               Ext.MessageBox.alert('提示', '导出失败!');
                           }
                       });
                   }
                   },
                   { text: '工程勘察审查情况汇总', handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.MessageBox.alert("提示", "请先选择要操作的记录!");
                           return;
                       }
                       Ext.Ajax.request({
                           url: "ProjectList.aspx?action=export_shenchahuizong_kancha",
                           params: { id: recs[0].get("Id") },
                           success: function (response, opts) {
                               Ext.MessageBox.alert('提示', '导出成功!');
                           },
                           failure: function (response, opts) {
                               Ext.MessageBox.alert('提示', '导出失败!');
                           }
                       });
                   }
                   },
                   { text: '抗震设防专项审查监管表', handler: function () {
                       recs = grid.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.MessageBox.alert("提示", "请先选择要操作的记录!");
                           return;
                       }
                       Ext.Ajax.request({
                           url: "ProjectList.aspx?action=export_kangzhen",
                           params: { id: recs[0].get("Id") },
                           success: function (response, opts) {
                               Ext.MessageBox.alert('提示', '导出成功!');
                           },
                           failure: function (response, opts) {
                               Ext.MessageBox.alert('提示', '导出失败!');
                           }
                       });
                   }
                   }, { text: '审查备案登记单'}]
                   },
                   { text: '同步到建设厅' }
                  ]
            });
            var pagebar1 = Ext.create('Ext.toolbar.Paging', {
                displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                store: store,
                displayInfo: true
            })
            var grid = Ext.create("Ext.grid.Panel", {
                title: '项目管理',
                tbar: toolbar,
                store: store,
                enableColumnHide: false,
                region: "center",
                selModel: { selType: 'checkboxmodel' },
                columns: [
                { xtype: "rownumberer", width: 35 },
                { dataIndex: "Id", header: "标示", hidden: true },
                { dataIndex: "ZiXunCode", header: "项目编号", width: 200, sortable: false },
                { dataIndex: "ProjectName", header: "项目名称", flex: 1, renderer: function (value, cellmeta, record, rowIndex, columnIndex, store) {
                    return "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" + record.get("Id") + "\")'>" + value + "</label>";
                }
                },
                { dataIndex: "ProjectType", header: "项目类别", width: 100 },
                { dataIndex: "ContractAmount", header: "合同金额", width: 80, xtype: 'numbercolumn', format: '0,000' },
                { dataIndex: "Status", header: "状态", width: 60, sortable: false },
                { dataIndex: "SongShenTime", header: "送审时间", xtype: 'datecolumn', format: 'Y-m-d', width: 90 },
                { dataIndex: 'CreateName', header: '录入人', width: 70 }
                ],
                bbar: pagebar1,
                plugins: [{
                    ptype: 'rowexpander',
                    rowBodyTpl: ['<div id="{Id}"></div>']
                }]
            });
            grid.view.on('expandBody', function (rowNode, record, expandRow, eOpts) {
                displayInnerGrid(record.get('Id'));
            });
            grid.view.on('collapsebody', function (rowNode, record, expandRow, eOpts) {
                destroyInnerGrid(record.get("Id"));
            });
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: "border",
                items: [grid]
            });
        });
        function displayInnerGrid(div) {
            var store_inner = Ext.create('Ext.data.JsonStore', {
                fields: ['Id', 'Name', 'CreateTime'],
                proxy: {
                    url: 'ProjectList.aspx?action=loadexportfile&id=' + div,
                    type: 'ajax',
                    reader: {
                        type: 'json',
                        root: 'innerrows'
                    }
                },
                autoLoad: true
            })
            var grid_inner = Ext.create('Ext.grid.Panel', {
                store: store_inner,
                margin: '0 0 0 70',
                columns: [
                    { xtype: 'rownumberer', width: 25 },
                    { dataIndex: "Name", header: "文件名称", flex: 1 },
                    { dataIndex: "CreateTime", header: "生成时间", width: 130 },
                    { xtype: 'actioncolumn', width: 60, text: '下载', align: 'center',
                        items: [{
                            icon: '/images/download.png',
                            handler: function (grid, rowIndex, colIndex) {
                                var rec = grid.getStore().getAt(rowIndex);
                                window.location.href = "/ProjectFile/Default/" + rec.get("Name");
                            }
                        }]
                    }
                    ],
                renderTo: div
            })
        }
        function destroyInnerGrid(div) {
            var parent = document.getElementById(div);
            var child = parent.firstChild;
            while (child) {
                child.parentNode.removeChild(child);
                child = child.nextSibling;
            }
        }
        function showwin(val) {
            opencenterwin("ProjectCard.aspx?id=" + val, 1100, 600);
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0"
            height="0">
        </object>
    </div>
    </form>
</body>
</html>
