<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeptAttendanceDetail.aspx.cs"
    Inherits="SP.Web.DailyManage.DeptAttendanceDetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var grid, store;
        var DeptId = getQueryString("DeptId");
        var DeptName = getQueryString("DeptName");
        var Year = getQueryString("Year");
        var Month = getQueryString("Month");
        Ext.onReady(init);
        function init() {
            Ext.regModel("DeptDetail", { fields: ["DeptId", "RowNumber", "ProjectName", "UserId", "UserName", "SumDay",
            "c1", "c2", "c3", "c4", "c5", "c6", "c7", "c8", "c9", "c10", "c11", "c12", "c13", "c14", "c15", "c16", "c17",
             "c18", "c19", "c20", "c21", "c22", "c23", "c24", "c25", "c26", "c27", "c28", "c29", "c30", "c31"]
            });
            store = new Ext.data.JsonStore({
                model: 'DeptDetail',
                proxy: {
                    type: 'ajax',
                    url: "DeptAttendanceDetail.aspx?action=select&DeptId=" + DeptId + "&Year=" + Year + "&Month=" + Month + "",
                    reader: {
                        reader: "json",
                        root: 'rows'
                    }
                },
                PageSize: 15,
                autoLoad: { start: 0, limit: 15 }
            });
            var columns = [];
            columns.push({ header: "标示", dataIndex: "DeptId", hidden: true });
            columns.push({ header: "标示", dataIndex: "UserId", hidden: true });
            columns.push({ header: "行号", dataIndex: "RowNumber", width: 50, sortable: false });
            columns.push({ header: "项目名称", dataIndex: "ProjectName", width: 150, sortable: false });
            columns.push({ header: "姓名", dataIndex: "UserName", width: 70 });
            for (var a = 26; a <= 31; a++) {
                columns.push({ header: "" + a, dataIndex: "c" + a, width: 40, renderer: RowRender, sortable: false });
            }
            for (var i = 1; i < 26; i++) {
                columns.push({ header: "" + i, dataIndex: "c" + i, width: 40, renderer: RowRender, sortable: false });
            }
            // columns.push({ header: "汇总天", dataIndex: "SumDay", width: 120 });
            grid = Ext.create("Ext.grid.Panel", {
                title: "<h2>" + Year + "年" + Month + "月" + DeptName + "考勤明细</h2>",
                store: store,
                enableColumnHide: false,
                titleAlign: 'center',
                region: "center",
                // selModel: { selType: "checkboxmodel" },
                columns: columns

            });
            function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
                if (value == "正常上班") {
                    return '<img src="../images/shared/flag_green.gif" check="false" />'
                } else if (value == "休假") {
                    return '<img src="../images/shared/flag_red.gif" check="false" />'
                } else if (value == "请假") {
                    return '<img src="../images/shared/exclam1.gif" check="false" />'
                } else if (value == "其他") {
                    return '<img src="../images/shared/cross.gif" check="false"/>'
                } else {
                    return '<input type="checkbox" />'
                }
            }

            var viewport = new Ext.Viewport({
                layout: 'border',
                items: [grid]
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
