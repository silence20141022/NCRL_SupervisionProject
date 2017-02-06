<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectList2.aspx.cs" Inherits="SP.Web.ConsultationManage.ProjectList2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../Extjs42/RowExpander.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var store1, grid1, store2, grid2;
        var tabIndex = 0;
        var ProjectName = "";
        var recs;
        Ext.onReady(function () {
            Unfinished(); //未完成
            Accomplish(); //已完成
        });
        function Unfinished() {
            Ext.regModel("Project1",
            { fields: ["Id", "ZiXunCode", "ProjectName", "ProjectType", "ContractAmount", "Status", "TaskQuan", "JianSheUnit", "SongShenTime"] });
            store1 = Ext.create("Ext.data.JsonStore", {
                model: "Project1",
                pageSize: 25,
                proxy: {
                    url: "ProjectList.aspx?action=DoSelect",
                    extraParams: { tabIndex: tabIndex, ProjectName: ProjectName },
                    type: "ajax",
                    reader: {
                        type: "json",
                        root: "rows",
                        totalProperty: "total"
                    }
                }
            });

            var toolbar = Ext.create("Ext.toolbar.Toolbar", {
                items: [
                   { xtype: "textfield", fieldLabel: "项目名称|编号", id: "ProjectName_s", labelAlign: 'right' },
                   { text: "查 询", handler: function () {
                       ProjectName = Ext.getCmp("ProjectName_s").getValue();
                       store1.getProxy().setExtraParam("ProjectName", ProjectName);
                       store1.load();
                   }
                   },
                   { text: "添 加", handler: function () {
                       opencenterwin("ProjectCard.aspx", 1100, 600);
                   }
                   },
                   { text: "修 改", handler: function () {
                       recs = grid1.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.Msg.alert("提示", "请选择要修改的记录！");
                           return;
                       }
                       opencenterwin("ProjectCard.aspx?id=" + recs[0].get("Id"), 1100, 600);
                   }
                   },
                   { text: "删 除", handler: function () {
                       recs = grid1.getSelectionModel().getSelection();
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
                                       store1.getProxy().setExtraParam("tabIndex", 0);
                                       store1.reload();
                                   }
                               });

                           }
                       }
                   }
                   },
                   { text: "下达任务", handler: function () {
                       recs = grid1.getSelectionModel().getSelection();
                       if (recs[0].get("Status") == "已结束" || recs[0].get("Status") == "已下达") {
                           Ext.Msg.alert("提示", "该项目的审查任务" + recs[0].get("Status"));
                       }
                       else {
                           opencenterwin("AssignedTasks.aspx?Id=" + recs[0].get("Id"), 1000, 500);
                       }
                   }
                   },
                   { text: "回收任务", handler: function () {
                       recs = grid1.getSelectionModel().getSelection();
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
                                   store1.getProxy().setExtraParam("tabIndex", 0);
                                   store1.load();
                               } else {
                                   Ext.Msg.alert("提示", "审查任务回收失败,请先删除各任务的审查意见！");
                               }
                           }
                       });
                   }
                   }, { text: "添加发票", handler: function () {
                       recs = grid1.getSelectionModel().getSelection();
                       if (!recs || recs.length <= 0) {
                           Ext.Msg.alert("提示", "请先选择要操作的记录！");
                           return;
                       }
                       opencenterwin("InvoiceEdit.aspx?ProjectId=" + recs[0].get("Id"), 900, 600);
                   }
                   },
                   { text: '导出操作', icon: '/images/shared/xls.gif',
                       menu: [
                       { text: '审查合格书', handler: function () {
                           recs = grid1.getSelectionModel().getSelection();
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
                       }, { text: '审查情况记录', handler: function () {
                           recs = grid1.getSelectionModel().getSelection();
                           if (!recs || recs.length <= 0) {
                               Ext.MessageBox.alert("提示", "请先选择要操作的记录!");
                               return;
                           }
                           Ext.Ajax.request({
                               url: "ProjectList.aspx?action=exportqingkuangjilu",
                               params: { id: recs[0].get("Id") },
                               callback: function (option, success, response) {
                                   Ext.MessageBox.alert("提示", "导出成功！");
                               }
                           });
                       }
                       }]
                   },
                   { text: '文档操作', menu: [
                    { text: "审查报告", handler: function () {
                        recs = grid1.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert("提示", "请先选择要操作的记录!");
                            return;
                        }
                        switch (recs[0].get("ProjectType")) {
                            case "房屋建筑":
                                opencenterwin("ShenChaReport_FWJZ.aspx?ProjectId=" + recs[0].get("Id"));
                                break;
                            case "勘察":
                                opencenterwin("ShenChaReport_KanCha.aspx?ProjectId=" + recs[0].get("Id"));
                                break;
                            case "市政工程":
                                opencenterwin("ShenChaReport_SZ.aspx?ProjectId=" + recs[0].get("Id"));
                                break;
                            case "基坑支护":
                                opencenterwin("ShenChaReport_JiKeng.aspx?ProjectId=" + recs[0].get("Id"));
                                break;
                        }
                    }
                    }, { text: "审查合格书", handler: function () {
                        recs = grid1.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.MessageBox.alert("提示", "请先选择要打印合格书的项目！");
                            return;
                        }
                        if (recs[0].get("ProjectType") == "市政工程" || recs[0].get("ProjectType") == "房屋建筑") {
                            doprint("ShenChaHeGeShuPrint.aspx?id=" + recs[0].get("Id"), 'shenchahege');
                        }
                        else {
                            Ext.MessageBox.alert('提示', '只有市政工程、房屋建筑类项目才能打印审查合格书！');
                        }
                    }
                    }, { text: '情况记录表', handler: function () {
                        recs = grid1.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert("提示", "请先选择要操作的记录！");
                            return;
                        }
                        if (recs[0].get("ProjectType") == "市政工程" || recs[0].get("ProjectType") == "房屋建筑") {
                            doprint("ShenChaQingKuang_Print.aspx?ProjectId=" + recs[0].get("Id"));
                        }
                        else {
                            Ext.MessageBox.alert('提示', '只有市政工程、房屋建筑类项目才能打印审查情况记录表！');
                        }
                    }
                    },
                    { text: '抗震表', handler: function () {
                        recs = grid1.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert("提示", "请先选择要操作的记录！");
                            return;
                        }
                        if (recs[0].get("ProjectType") == "市政工程" || recs[0].get("ProjectType") == "房屋建筑") {
                            doprint("KangZhenBiao_Print.aspx?ProjectId=" + recs[0].get("Id"));
                        }
                        else {
                            Ext.MessageBox.alert('提示', '只有市政工程、房屋建筑类项目才能打印抗震表！');
                        }
                    }
                    }, { text: '终审意见', handler: function () {
                        recs = grid1.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert("提示", "请先选择要操作的记录！");
                            return;
                        }
                        opencenterwin("ZhongShenOpinionEdit.aspx?ProjectId=" + recs[0].get("Id"), 900, 600);
                    }
                    }, { text: '汇总表', handler: function () {
                        recs = grid1.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert("提示", "请先选择要操作的记录！");
                            return;
                        }
                        doprint("HuiZongBiaoPrint.aspx?ProjectId=" + recs[0].get("Id"));
                    }
                    },
                    { text: '查备案登记表', handler: function () {
                        recs = grid1.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert("提示", "请先选择要操作的记录！");
                            return;
                        }
                        if (recs[0].get("ProjectType") == "市政工程" || recs[0].get("ProjectType") == "房屋建筑") {
                            doprint("BeiAnDengJiBiaoPrint.aspx?ProjectId=" + recs[0].get("Id"));
                        }
                        else {
                            Ext.MessageBox.alert('提示', '只有市政工程、房屋建筑类项目才能打印备案登记表！');
                        }
                    }
                    },
                    { text: '工程勘察审查报告', handler: function () {
                        recs = grid1.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert("提示", "请先选择要操作的记录！");
                            return;
                        }
                        doprint("ShenChaReport_KanCha_Print.aspx?ProjectId=" + recs[0].get("Id"));
                    }
                    }
                   ]
                   }
                ]
            });
            var pagebar1 = Ext.create('Ext.toolbar.Paging', {
                displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                store: store1,
                displayInfo: true
            })
            grid1 = Ext.create("Ext.grid.Panel", {
                tbar: toolbar,
                store: store1,
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
                { dataIndex: "ProjectType", header: "项目类别", width: 100, sortable: false },
                { dataIndex: "ContractAmount", header: "合同金额", width: 80, xtype: 'numbercolumn', format: '0,000', sortable: false },
                { dataIndex: "Status", header: "状态", width: 60, sortable: false },
                { dataIndex: "SongShenTime", header: "送审时间", xtype: 'datecolumn', format: 'Y-m-d', width: 90, sortable: false }
                ],
                bbar: pagebar1,
                plugins: [{
                    ptype: 'rowexpander',
                    rowBodyTpl: ['<div id="{Id}"></div>']
                }]
            });
        }
        function doprint(url, val) {
            try {
                var LODOP = document.getElementById("LODOP"); //这行语句是为了符合DTD规范
                LODOP.PRINT_INIT("");
                if (val != "shenchahege") {
                    LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");
                    LODOP.ADD_PRINT_URL(20, 18, 750, 1050, url);
                }
                else {
                    LODOP.SET_PRINT_PAGESIZE(2, 0, 0, "A4"); //设定打印纸张为固定纸张或自适应内容高，并设定相关大小值或纸张名及打印方向
                    LODOP.ADD_PRINT_URL(20, 18, 1050, 750, url); //按URL地址增加超文本打印项，设定该打印项在纸张内的位置和区域大小
                }
                LODOP.PREVIEW();
            }
            catch (ex) {
                Ext.Msg.alert("提示", "未安装打印控件，请安装打印控件");
                window.open("/install_lodop.rar", "print", "");
            }
        }
        function Accomplish() {
            Ext.regModel("Project2",
                    { fields: ["Id", "ZiXunCode", "ProjectName", "ProjectType", "ContractAmount", "Status", "TaskQuan", "JianSheUnit", "SongShenTime"] });
            store2 = Ext.create("Ext.data.JsonStore", {
                model: "Project2",
                pageSize: 25,
                proxy: {
                    url: "ProjectList.aspx?action=DoSelect",
                    extraParams: { start: 0, limit: 25, tabIndex: tabIndex },
                    type: "ajax",
                    reader: {
                        type: "json",
                        root: "rows",
                        totalProperty: "total"
                    }
                }
            });
            var pagebar2 = Ext.create('Ext.toolbar.Paging', {
                displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                store: store2,
                displayInfo: true
            })
            grid2 = Ext.create("Ext.grid.Panel", {
                store: store2,
                region: "center",
                enableColumnHide: false,
                selModel: { selType: 'checkboxmodel' },
                columns: [
                        { xtype: "rownumberer", width: 35 },
                        { dataIndex: "Id", header: "标示", hidden: true },
                        { dataIndex: "ZiXunCode", header: "项目编号", width: 200, sortable: false },
                        { dataIndex: "ProjectName", header: "项目名称", flex: 1, renderer: function (value, cellmeta, record, rowIndex, columnIndex, store) {
                            return "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" + record.get("Id") + "\")'>" + value + "</label>";
                        }
                        },
                        { dataIndex: "ProjectType", header: "项目类别", width: 100, sortable: false },
                        { dataIndex: "ContractAmount", header: "合同金额", xtype: 'numbercolumn', format: '0,000', width: 80, sortable: false },
                        { dataIndex: "Status", header: "状态", width: 60, sortable: false },
                        { dataIndex: "SongShenTime", header: "送审时间", xtype: 'datecolumn', format: 'Y-m-d', width: 80, sortable: false }
                        ],
                bbar: pagebar2
            });
            var tabPanel = Ext.create("Ext.tab.Panel", {
                region: "center",
                items:
                        [
                            { title: "进行中", layout: "border",
                                listeners: { activate: function (tab, opitions) {
                                    store1.getProxy().setExtraParam("tabIndex", 0);
                                    store1.load();
                                }
                                },
                                items: [grid1]
                            },
                             { title: "已结束", layout: "border",
                                 listeners: { activate: function (tab, opitions) {
                                     tabIndex = 1;
                                     store2.getProxy().setExtraParam("tabIndex", tabIndex);
                                     store2.load();
                                 }
                                 },
                                 items: [grid2]
                             }
                        ]
            });
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: "border",
                items: [tabPanel]
            });
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
