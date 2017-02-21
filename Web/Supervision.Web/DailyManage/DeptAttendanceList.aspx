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
        var grid, store, pgbar;
        Ext.onReady(function () {
            Ext.Ajax.request({
                url: "DeptAttendanceList.aspx?action=basedata",
                success: function (response, opts) {
                    var json = Ext.decode(response.responseText);
                    var store_year = Ext.create('Ext.data.JsonStore', {
                        fields: ['year'],
                        data: json.year
                    })
                    var yearcombo = new Ext.form.ComboBox({
                        fieldLabel: '所属年份',
                        id: 'yearcombo',
                        labelAlign: 'right',
                        labelWidth: 60,
                        width: 150,
                        store: store_year,
                        editable: false,
                        queryMode: 'local',
                        displayField: 'year',
                        valueField: 'year'
                    });
                    var store_month = Ext.create('Ext.data.JsonStore', {
                        fields: ['month'],
                        data: json.month
                    })

                    var monthcombo = new Ext.form.ComboBox({
                        fieldLabel: '所属月份',
                        id: 'monthcombo',
                        labelWidth: 60,
                        width: 150,
                        labelAlign: 'right',
                        store: store_month,
                        editable: false,
                        queryMode: 'local',
                        displayField: 'month',
                        valueField: 'month'
                    });
                    var store_dept = Ext.create('Ext.data.JsonStore', {
                        fields: ['GroupID', 'Name'],
                        data: json.dept
                    })
                    var deptcombo = new Ext.form.ComboBox({
                        fieldLabel: '部门名称',
                        id: 'deptcombo',
                        editable: false,
                        labelWidth: 60,
                        width: 250,
                        labelAlign: 'right',
                        store: store_dept,
                        queryMode: 'local',
                        displayField: 'Name',
                        valueField: 'GroupID'
                    });
                    var toolbar = Ext.create("Ext.toolbar.Toolbar", {
                        items: [yearcombo, monthcombo, deptcombo,
                            {
                                text: "查询", handler: function () {
                                    pgbar.moveFirst();
                                }
                            }, '-',
                        {
                            text: "重置", handler: function () {
                                Ext.getCmp('yearcombo').setValue('');
                                Ext.getCmp("monthcombo").setValue('');
                                Ext.getCmp('deptcombo').setValue('');
                            }
                        }, '-',
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
                        autoLoad: true,
                        listeners: {
                            beforeload: function () {
                                store.getProxy().extraParams = {
                                    year: Ext.getCmp('yearcombo').getValue(),
                                    month: Ext.getCmp("monthcombo").getValue(),
                                    deptid: Ext.getCmp('deptcombo').getValue()
                                }
                            }
                        }
                    });
                    pgbar = Ext.create('Ext.toolbar.Paging', {
                        displayMsg: '显示 {0} - {1} 条,共计 {2} 条',
                        store: store,
                        displayInfo: true
                    })
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
                        bbar: pgbar
                    });
                    var viewport = new Ext.Viewport({
                        layout: 'border',
                        items: [grid]
                    });
                }
            })
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
