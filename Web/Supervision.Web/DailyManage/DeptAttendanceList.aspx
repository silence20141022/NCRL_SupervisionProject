<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeptAttendanceList.aspx.cs"
    Inherits="SP.Web.DailyManage.DeptAttendanceList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var grid, store;
        Ext.onReady(function () {
            Ext.regModel("KaoQi", { fields: ["Id", "BelongDeptName", "BelongDeptId", "Remark", "BelongDeptId", "Year", "Month", "Status"] });
            store = new Ext.data.JsonStore({
                model: 'KaoQi',
                proxy: {
                    type: 'ajax',
                    url: "DeptAttendanceList.aspx?action=async",
                    reader: {
                        reader: "json",
                        root: 'rows',
                        totalProperty: "pageCount"
                    }
                },
                pageSize: 25,
                autoLoad: { start: 0, limit: 25 }
            });
            var store_year = Ext.create('Ext.data.JsonStore', {
                fields: ['year'],
                proxy: {
                    type: 'ajax',
                    url: 'DeptAttendanceList.aspx?action=loadyear',
                    reader: {
                        root: 'rows',
                        type: 'json'
                    }
                },
                autoLoad: true
            })
            var yearcombo = new Ext.form.ComboBox({
                fieldLabel: '所属年份',
                labelAlign: 'right',
                labelWidth: 60,
                width: 150,
                store: store_year,
                queryMode: 'local',
                displayField: 'year',
                valueField: 'year'
            });
            var store_month = Ext.create('Ext.data.JsonStore', {
                fields: ['month'],
                proxy: {
                    type: 'ajax',
                    url: 'DeptAttendanceList.aspx?action=loadmonth',
                    reader: {
                        root: 'rows',
                        type: 'json'
                    }
                },
                autoLoad: true
            })
            var monthcombo = new Ext.form.ComboBox({
                fieldLabel: '所属月份',
                labelWidth: 60,
                width: 150,
                labelAlign: 'right',
                store: store_month,
                queryMode: 'local',
                displayField: 'month',
                valueField: 'month'
            });
            var toolbar = Ext.create("Ext.toolbar.Toolbar", {
                items: [yearcombo, monthcombo,
                    { xtype: 'textfield', fieldLabel: '部门名称', labelWidth: 60, id: 'DeptName' },
                    {
                        text: "查询", handler: function () {
                            var DeptName = Ext.getCmp("DeptName").getValue();
                            var json = { DeptName: DeptName, year: yearcombo.getValue(), month: monthcombo.getValue() };
                            store.reload({ params: json });
                        }
                    }, '-',
                //{
                //    text: "添加", handler: function () {
                //        opencenterwin("DeptAttendanceCard.aspx", 1300, 500);
                //    }
                //    }, '-',
                    {
                        text: "修改", handler: function () {
                            var recs = grid.getSelectionModel().getSelection();
                            if (!recs || recs.length <= 0) {
                                Ext.Msg.alert("提示", "请选择修改的记录!");
                                return;
                            }
                            opencenterwin("DeptAttendanceCard.aspx?id=" + recs[0].get("Id"), '1300', '650');
                        }
                    }
                ]
            });
            grid = Ext.create("Ext.grid.Panel", {
                store: store,
                region: "center",
                title: '部门考勤',
                tbar: toolbar,
                selModel: { selType: "checkboxmodel" },
                columns: [
                    { xtype: 'rownumberer', width: 60 },
                    { header: "标示", dataIndex: "Id", hidden: true },
                    { header: "年", dataIndex: "Year", width: 100 },
                    { header: "月", dataIndex: "Month", width: 100 },
                    { header: "所属部门", dataIndex: "BelongDeptName", width: 200 },
                    { header: '备注', dataIndex: 'Remark', flex: 1 }
                ],
                bbar: {
                    xtype: 'pagingtoolbar',
                    displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                    emptyMsg: "没有数据",
                    beforePageText: "当前页",
                    afterPageText: "共{0}页",
                    store: store,
                    displayInfo: true
                }
            });
            var viewport = new Ext.Viewport({
                layout: 'border',
                items: [grid]
            });
        })
        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            switch (columnIndex + "") {
                case "10":
                    rtn += "<span class=' fa fa-list' style='color:Blue; cursor:pointer;' onclick='showdetail()'></span>";
                    break;
            }
            return rtn;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="">
        </div>
    </form>
</body>
</html>
