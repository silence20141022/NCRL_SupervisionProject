<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsersCheck.aspx.cs" Inherits="SP.Web.DailyManage.UsersCheck" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/lib/jquery-1.7.1.js" type="text/javascript"></script>
    <link href="../font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <script src="groupuser.js" type="text/javascript"></script>
    <style type="text/css">
        .x-grid-cell-inner
        {
            overflow: visible;
        }
    </style>
    <script type="text/javascript">
        var store, grid, store1, grid1;
        var Year, Month;
        var SignType = "正常上班";
        var columns = [];
        var yearcombo, monthcombo;
        Ext.onReady(init);
        function init() {
            Ext.regModel("UsersCheck", { fields: ["DeptName", "ComId", "UserId", "UserName", "SumDay",
            "c1", "c2", "c3", "c4", "c5", "c6", "c7", "c8", "c9", "c10", "c11", "c12", "c13", "c14", "c15", "c16", "c17",
             "c18", "c19", "c20", "c21", "c22", "c23", "c24", "c25", "c26", "c27", "c28", "c29", "c30", "c31"]
            });
            store = new Ext.data.JsonStore({
                model: 'UsersCheck',
                proxy: {
                    type: 'ajax',
                    url: "UsersCheck.aspx",
                    reader: {
                        reader: "json",
                        root: 'rows',
                        totalProperty: "pageCount"
                    }
                }
                //                ,
                //                PageSize: 15,
                //                autoLoad: { action: "async", "Year": Year, "Month": Month }
            });

            columns.push({ header: "标示", dataIndex: "UserId", hidden: true });
            columns.push(new Ext.grid.RowNumberer());
            columns.push({ header: "部门名称", dataIndex: "DeptName", width: 90 });
            columns.push({ header: "姓名", dataIndex: "UserName", width: 50 });
            for (var a = 26; a <= 31; a++) {
                columns.push({ header: "" + a, dataIndex: "c" + a, width: 35, renderer: RowRender });
            }
            for (var i = 1; i < 26; i++) {
                columns.push({ header: "" + i, dataIndex: "c" + i, width: 35, renderer: RowRender });
            }
            // columns.push({ header: "汇总天", dataIndex: "SumDay", width: 120 });
            columns.push({ header: "公司Id", dataIndex: "ComId", hidden: true });
            grid = Ext.create("Ext.grid.Panel", {
                title: "非项目人员考勤",
                store: store,
                region: "center",
                selModel: { selType: "checkboxmodel" },
                columns: columns
            });
            var yearstore = new Ext.data.Store({
                fields: ['year'],
                data: [
                    { "year": "2014" }, { "year": "2015" }, { "year": "2016" }, { "year": "2017" }
                ]
            });
            yearcombo = new Ext.form.ComboBox({
                fieldLabel: '所属年份',
                labelAlign: 'right',
                store: yearstore,
                name: 'year',
                id: 'year',
                queryMode: 'local',
                displayField: 'year',
                valueField: 'year',
                listeners: { select: function () {
                    Year = yearcombo.getRawValue();
                    Month = monthcombo.getRawValue();
                    if (Year && Month) {
                        SelectData();
                    }
                }
                }
            });
            var monthstore = new Ext.data.Store({
                fields: ['month'],
                data: [
                    { "month": "1" }, { "month": "2" }, { "month": "3" }, { "month": "4" },
                    { "month": "5" }, { "month": "6" }, { "month": "7" }, { "month": "8" },
                    { "month": "9" }, { "month": "10" }, { "month": "11" }, { "month": "12" }
                ]
            });
            monthcombo = new Ext.form.ComboBox({
                fieldLabel: '所属月份',
                labelAlign: 'right',
                store: monthstore,
                name: 'month',
                id: 'month',
                queryMode: 'local',
                displayField: 'month',
                valueField: 'month',
                listeners: { select: function () {
                    Year = yearcombo.getRawValue();
                    Month = monthcombo.getRawValue();
                    if (Year && Month) {
                        SelectData();
                    }
                }
                }
            });
            var deleteuser = {
                xtype: 'button',
                width: 80,
                text: '删除人员 ',
                handler: function () {
                    var recs = grid.getSelectionModel().getSelection();
                    if (!recs) { return; }
                    var jarray = [];
                    $.each(recs, function () {
                        if (this.get("ComId")) {
                            jarray.push(this.get("UserId"));
                        } else {
                            store.remove(this);
                        }
                    });
                    if (jarray.length > 0) {
                        Ext.MessageBox.confirm("提示", "确定删除吗?", callBack);
                        function callBack(str) {
                            if (str != "yes") { return; }
                            var ComId = recs[0].get("ComId");
                            var requestConfig = {
                                url: "UsersCheck.aspx",
                                params: { jarray: jarray, action: "delete", ComId: ComId },
                                callback: function (option, success, response) {
                                    store.reload({ params: { "action": "SelectData", "Year": Year, "Month": Month} });
                                }
                            }
                            Ext.Ajax.request(requestConfig);
                        }
                    }
                }

            }
            var adduser = {
                xtype: 'button',
                width: 80,
                text: '添加人员 ',
                handler: function () {
                    Year = yearcombo.getRawValue();
                    Month = monthcombo.getRawValue();
                    if (Year && Month) {
                        var win = showGroupUserWin();
                        win.show();
                    } else {
                        Ext.Msg.alert("提示", "请选择年份或月份!");
                    }

                }
            }
            var shangban = {
                xtype: 'button',
                width: 80,
                icon: "../images/shared/flag_green.gif",
                text: '正常上班 ',
                handler: function () {
                    SignType = "正常上班";
                }
            }
            var xiujia = {
                xtype: 'button',
                width: 80,
                icon: "../images/shared/flag_red.gif",
                text: '休假 ',
                handler: function () {
                    SignType = "休假";
                }
            }
            var qingjia = {
                xtype: 'button',
                width: 80,
                icon: "../images/shared/exclam1.gif",
                text: '请假 ',
                handler: function () {
                    SignType = "请假";
                }
            }
            var qita = {
                xtype: 'button',
                width: 80,
                icon: "../images/shared/cross.gif",
                text: '其他',
                handler: function () {
                    SignType = "其他";
                }
            }
            var panel = new Ext.form.Panel({
                region: 'north',
                layout: 'form',

                items: [
                        { layout: 'column', bodyStyle: 'border:0',
                            items: [
                                { columnWidth: .2, layout: 'form', bodyStyle: 'border:0', items: [yearcombo] },
                                { columnWidth: .2, layout: 'form', bodyStyle: 'border:0', items: [monthcombo] },
                                { columnWidth: .1, layout: 'form', bodyStyle: 'border:0', items: [deleteuser] },
                                { columnWidth: .1, layout: 'form', bodyStyle: 'border:0', items: [adduser] },
                                { columnWidth: .1, layout: 'form', bodyStyle: 'border:0', items: [shangban] },
                                { columnWidth: .1, layout: 'form', bodyStyle: 'border:0', items: [xiujia] },
                                { columnWidth: .1, layout: 'form', bodyStyle: 'border:0', items: [qingjia] },
                                { columnWidth: .1, layout: 'form', bodyStyle: 'border:0', items: [qita] },

                            ]
                        }
                    ]
            });

            var viewport = Ext.create("Ext.container.Viewport", {
                layout: 'border',
                items: [grid, panel]
            });
            function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
                if (value == "正常上班") {
                    return '<img src="../images/shared/flag_green.gif" check="false"  onclick="checkclick(' + columnIndex + ',\'' + rowIndex + '\')"/>'
                } else if (value == "休假") {
                    return '<img src="../images/shared/flag_red.gif" check="false" onclick="checkclick(' + columnIndex + ',\'' + rowIndex + '\')"/>'
                } else if (value == "请假") {
                    return '<img src="../images/shared/exclam1.gif" check="false" onclick="checkclick(' + columnIndex + ',\'' + rowIndex + '\')" />'
                } else if (value == "其他") {
                    return '<img src="../images/shared/cross.gif" check="false" onclick="checkclick(' + columnIndex + ',\'' + rowIndex + '\')"/>'
                } else {
                    return '<input type="checkbox" onclick="checkclick(' + columnIndex + ',\'' + rowIndex + '\')"/>'
                }
            }
        }
        function checkclick(columnIndex, i) {
            var day = columns[columnIndex].dataIndex.replace("c", "");
            var recs = grid.getSelectionModel().getSelection();
            var UserId = recs[0].get("UserId");
            var UserName = recs[0].get("UserName");
            //var ComId = recs[0].get("ComId");
            var Year = yearcombo.getRawValue();
            var Month = monthcombo.getRawValue();
            if (!Year || !Month) {
                Ext.Msg.alert("提示", "请选择年或月!");
                return;
            }
            var RequestConfig = {
                url: "UsersCheck.aspx?action=create",
                params: { "Year": Year, "Month": Month, "day": day, "UserId": UserId, "UserName": UserName, "SignType": SignType },
                callback: function (option, success, response) {
                    var json = Ext.decode(response.responseText);
                    recs[0].set("ComId", json.ComId);
                    day = "c" + day;
                    if (recs[0].get(day) == SignType) {
                        store.getAt(i).set(day, "");
                    }
                    else {
                        store.getAt(i).set(day, SignType);
                    }
                }
            }
            Ext.Ajax.request(RequestConfig);
        }
        function GetUsers(recs) {
            $.each(recs, function () {
                if (store.find("UserName", this.get("Name")) == -1) {
                    var row = store.data.length;
                    store.insert(row, { UserId: this.get("UserID"), UserName: this.get("Name"), DeptName: this.get("GroupName") });
                }
            });
        }
        function SelectData() {
            store.load({ params: { "action": "SelectData", "Year": Year, "Month": Month} });
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
