<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamineTaskList.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ExamineTaskList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../Extjs42/RowExpander.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        Ext.onReady(function () {
            var store = Ext.create("Ext.data.JsonStore", {
                fields: ["Id", "ProjectName", "ProjectType", "ZiXunCode", "JianSheUnit"],
                pageSize: 25,
                proxy: {
                    url: "ExamineTaskList.aspx?action=Select",
                    extraParams: { start: 0, limit: 25, ProjectName: "" },
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
                    { xtype: "textfield", fieldLabel: "项目名称", labelAlign: "right", name: "ProjectName", id: "ProjectName" },
                    { text: "查 询", handler: function () {
                        var str = Ext.getCmp("ProjectName").getValue();
                        store.getProxy().setExtraParam("ProjectName", str);
                        store.load();
                    }
                    }
                ]
            });
            var bbar = Ext.create("Ext.toolbar.Paging", {
                displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                emptyMsg: "没有数据",
                beforePageText: "当前页",
                afterPageText: "共{0}页",
                store: store,
                displayInfo: true
            });
            var grid = Ext.create("Ext.grid.Panel", {
                store: store,
                title: "审查任务",
                region: "center",
                selModel: { selType: "checkboxmodel" },
                columns: [
                { xtype: "rownumberer", width: 35 },
                { dataIndex: "Id", header: "标示", hidden: true },
                { dataIndex: "ZiXunCode", header: "咨询编号", width: 150 },
                { dataIndex: "ProjectName", header: "项目名称", flex: 1 },
                { dataIndex: "ProjectType", header: "项目类型", width: 100 },
                { dataIndex: "JianSheUnit", header: "建设单位", width: 160 },
                { xtype: 'actioncolumn', width: 90, text: '意见封面', align: 'center',
                    items: [{
                        icon: '/images/icon/printer.png',
                        handler: function (grid, rowIndex, colIndex) {
                            var rec = store.getAt(rowIndex);
                            doprint("OpinionCoverPrint.aspx?projectid=" + rec.get("Id"));
                        }
                    }]
                }
                ],
                tbar: toolbar,
                bbar: bbar,
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
            var viewport = Ext.create("Ext.container.Viewport", {
                layout: "border",
                items: [grid]
            });
        });
        function displayInnerGrid(div) {
            var store_inner = Ext.create('Ext.data.JsonStore', {
                fields: ['Id', 'MajorName', 'UserName', 'PlanBackTime', 'ExamineOpinion'],
                proxy: {
                    url: 'ExamineTaskList.aspx?action=loadtask&projectid=' + div,
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
                    { dataIndex: "MajorName", header: "专业名称", width: 100 },
                    { dataIndex: "UserName", header: "审图专家", width: 100 },
                    { dataIndex: "PlanBackTime", header: "计划反馈时间", width: 120 },
                    { xtype: 'actioncolumn', width: 90, text: '添加意见', align: 'center',
                        items: [{
                            icon: '/images/icon/add.png',
                            handler: function (grid, rowIndex, colIndex) {
                                var rec = grid.getStore().getAt(rowIndex);
                                opencenterwin("ExamineOpinionEdit.aspx?ExamineTaskId=" + rec.get("Id"), 1000, 650);
                            }
                        }]
                    },
                   { dataIndex: "ExamineOpinion", header: "审查意见", width: 110, renderer: function (value, cellmeta, record, rowIndex, columnIndex, store) {
                       if (value) {
                           return "<label style='color:Blue; cursor:pointer; text-decoration:underline;' onclick='showwin(\"" + record.get("Id") + "\")'> 审查意见【" + value + "】</label>";
                       }
                   }
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
            opencenterwin("ExamineOpinionView.aspx?ExamineTaskId=" + val, 1000, 650);
        }
        function doprint(url) {
            try {
                var LODOP = document.getElementById("LODOP"); //这行语句是为了符合DTD规范
                LODOP.PRINT_INIT("");
                LODOP.NewPage();
                LODOP.ADD_PRINT_URL(20, 18, 750, 1050, url);
                LODOP.PREVIEW();
            }
            catch (ex) {
                alert("未安装打印控件，请安装打印控件");
                window.open("/install_lodop.rar", "print", "");
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div>
            <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0"
                height="0">
            </object>
        </div>
    </div>
    </form>
</body>
</html>
