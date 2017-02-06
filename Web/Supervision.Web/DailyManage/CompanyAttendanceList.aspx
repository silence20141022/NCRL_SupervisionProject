<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompanyAttendanceList.aspx.cs"
    Inherits="SP.Web.DailyManage.CompanyAttendanceList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <link href="../font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var store, grid;
        Ext.onReady(init);
        function init() {
            var store_year = Ext.create('Ext.data.JsonStore', {
                fields: ['year'],
                proxy: {
                    type: 'ajax',
                    url: 'CompanyAttendanceList.aspx?action=loadyear',
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
                    url: 'CompanyAttendanceList.aspx?action=loadmonth',
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
            Ext.regModel("CompanyAttendance", { fields: ["Id", "Year", "Month"]
            });
            store = Ext.create("Ext.data.Store", {
                model: "CompanyAttendance",
                proxy: {
                    type: "ajax",
                    url: "CompanyAttendanceList.aspx?action=select",
                    reader: {
                        reader: "json",
                        root: "rows",
                        totalProperty: "pageCount"
                    }
                },
                pageSize: 15,
                autoLoad: { start: 0, limit: 15 }
            });
            var tbar = Ext.create("Ext.toolbar.Toolbar", {
                items: [yearcombo, monthcombo,
                {
                    text: "查 询",
                    handler: function () {
                        var year = yearcombo.getValue();
                        var month = monthcombo.getValue();
                        var json = { year: year, month: month };
                        store.load({ params: json })
                    }
                }, '-', { text: '修 改', handler: function () {
                    var recs = grid.getSelectionModel().getSelection();
                    if (recs.length > 0) {
                        opencenterwin("CmpAttendEdit.aspx?id=" + recs[0].get("Id"), 1300, 650);
                    }
                }
                }
                ]
            });
            var pagebar = Ext.create('Ext.toolbar.Paging', {
                displayInfo: true,
                store: store,
                displayMsg: '显示 {0} - {1} 条，共计 {2} 条'
            })
            grid = Ext.create("Ext.grid.Panel", {
                title: '公司考勤',
                store: store,
                region: "center",
                bbar: pagebar,
                tbar: tbar,
                selModel: { selType: "checkboxmodel" },
                columns: [
                    new Ext.grid.RowNumberer(),
                    { header: "标示", dataIndex: "Id", hidden: true },
                    { header: "所属年份", dataIndex: "Year", width: 100 },
                    { header: "所属月份", dataIndex: "Month", width: 100 }
                        ]
            });
            function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
                var rtn = "";
                switch (columnIndex + "") {
                    case "9":
                        rtn += "<span class=' fa fa-list' style='color:Blue; cursor:pointer;' onclick='showdetail()'></span>";
                        break;
                }
                return rtn;
            }
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: "border",
                items: [grid]
            });

        }
        function showdetail() {
            var rec = grid.getSelectionModel().getSelection();
            var Year = rec[0].get("Year");
            var DeptId = rec[0].get("BelongDeptId")
            var Month = rec[0].get("Month");
            opencenterwin("CompanyDetail.aspx?Year=" + Year + "&Month=" + Month, '1350', '700');
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
