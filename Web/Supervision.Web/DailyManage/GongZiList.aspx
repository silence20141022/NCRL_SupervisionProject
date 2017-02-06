<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GongZiList.aspx.cs" Inherits="SP.Web.DailyManage.GongZiList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <link href="../font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var grid, store_stage;
        Ext.onReady(function () {
            var yearstore = new Ext.data.Store({
                fields: ['year'],
                data: [
                    { "year": "2014" }, { "year": "2015" }, { "year": "2016" }, { "year": "2017" }
                ]
            });
            var yearcombo = new Ext.form.ComboBox({
                fieldLabel: '所属年份',
                labelAlign: 'right',
                labelWidth: 60,
                width: 150,
                store: yearstore,
                queryMode: 'local',
                displayField: 'year',
                valueField: 'year'
            });
            var monthstore = new Ext.data.Store({
                fields: ['month'],
                data: [
                    { "month": "1" }, { "month": "2" }, { "month": "3" }, { "month": "4" },
                    { "month": "5" }, { "month": "6" }, { "month": "7" }, { "month": "8" },
                    { "month": "9" }, { "month": "10" }, { "month": "11" }, { "month": "12" }
                ]
            });
            var monthcombo = new Ext.form.ComboBox({
                fieldLabel: '所属月份',
                labelWidth: 60,
                width: 150,
                labelAlign: 'right',
                store: monthstore,
                queryMode: 'local',
                displayField: 'month',
                valueField: 'month'
            });
            var tbar = new Ext.toolbar.Toolbar({
                items: [
                yearcombo, monthcombo,
                { text: '查 询', handler: function () {
                    store_stage.load({ params: { Year: yearcombo.getValue(), Month: monthcombo.getValue()} })
                }
                }, '-',
                { text: '添 加', handler: function () {
                    opencenterwin("GongZiEdit.aspx", 1300, 600);
                }
                }, '-', { text: '修改', handler: function () {
                    var recs = grid.getSelectionModel().getSelection();
                    if (recs.length > 0) {
                        opencenterwin("GongZiEdit.aspx?formId=" + recs[0].get("Id"), 1300, 600);
                    }
                    else {
                        alert("请选择要修改的记录!");
                    }
                }
                }, '-', { text: '删除', handler: function () {
                    var recs = grid.getSelectionModel().getSelection();
                    if (recs.length > 0) {
                        var formIds = "";
                        Ext.each(recs, function (rec) {
                            formIds += rec.get("Id") + ",";
                        })
                        Ext.Ajax.request({
                            url: 'GongZiList.aspx?action=delete',
                            params: { formIds: formIds },
                            callback: function () {
                                store_stage.reload();
                            }
                        })
                    }
                    else {
                        alert("请选择要删除的记录!");
                    }
                }
                }]
            });
            Ext.regModel('SalaryStage', { fields: ['Id', 'Year', 'Month', 'PeopleCount', 'AdjustCount', 'TotalAmount', 'Remark', 'Status'] });
            store_stage = Ext.create('Ext.data.JsonStore', {
                model: 'SalaryStage',
                pageSize: 25,
                proxy: {
                    url: 'GongZiList.aspx?action=autoload',
                    type: 'ajax',
                    reader: {
                        root: 'rows',
                        totalProperty: 'total'
                    }
                },
                autoLoad: true
            })
            var pagebar = Ext.create('Ext.toolbar.Paging', {
                store: store_stage,
                displayInfo: true,
                displayMsg: '显示 {0} - {1} 条,共计 {2} 条'
            })
            grid = new Ext.grid.Panel({
                title: '工资管理',
                region: 'center',
                store: store_stage,
                columnLines: true,
                selModel: { selType: 'checkboxmodel' },
                tbar: tbar,
                bbar: pagebar,
                columns: [
                { xtype: 'rownumberer', width: 35 },
                { text: '所属年月', dataIndex: 'Month', width: 130, renderer: function (value, metadata, record, rowindex, colIndex) {
                    return record.get("Year") + "年" + value + "月";
                }
                },
                { text: '人数合计', dataIndex: 'PeopleCount', width: 100 },
                { text: '调整人数', dataIndex: 'AdjustCount', width: 100 },
                { xtype: 'numbercolumn', format: '0,000', text: '金额合计', dataIndex: 'TotalAmount', width: 100 },
                { text: '备注', dataIndex: 'Remark', flex: 1 },
                { text: '状态', dataIndex: 'Status', width: 70 },
                { text: '调整明细', dataIndex: 'Id', width: 90, renderer: function (value, metadata, record) {
                    return '<span style="cursor: pointer; text-decoration: underline" onclick="showadjustdetail(\'' + value + '\')"><font color="blue"><i class="fa fa-calculator"></i><span>调整明细</span></font></span>';
                }
                }
                ]
            })
            var viewport = new Ext.container.Viewport({
                layout: 'border',
                items: [grid]
            })
        })
        function showadjustdetail(val) {
            opencenterwin("SalaryAdjustList.aspx?stageId=" + val, 1100, 550);
        }      
    </script>
</head>
<body>
    <form id="form1" runat="server">
    </form>
</body>
</html>
