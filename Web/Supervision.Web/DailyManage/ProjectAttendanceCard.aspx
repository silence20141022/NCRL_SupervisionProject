<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectAttendanceCard.aspx.cs"
    Inherits="SP.Web.DailyManage.ProjectAttendanceCard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script src="groupuser.js" type="text/javascript"></script>
    <style type="text/css">
        .btn-active {
            background-color: rgba(21, 127, 204, 1);
        }
    </style>
    <script type="text/javascript">
        var id = getQueryString("id");
        var store_detail, grid;
        var SignType = "√";
        var data_prj = [];
        var data_year = [];
        var data_month = [];
        Ext.onReady(function () {
            //首先加载所有项目
            Ext.Ajax.request({
                url: "ProjectAttendanceCard.aspx?action=loadproject",
                success: function (response, opts) {
                    var json_data = Ext.decode(response.responseText);
                    data_prj = json_data.rows;
                    data_year = json_data.year;
                    data_month = json_data.month;
                    var store_project = Ext.create("Ext.data.JsonStore", {
                        fields: ['ProjectName', 'ProjectId', "PManagerId", "PManagerName", "BelongDeptId", "BelongDeptName", "LogName"],
                        data: data_prj
                    });
                    var combo_project = Ext.create("Ext.form.ComboBox", {
                        name: "ProjectName",
                        labelAlign: "right",
                        store: store_project,
                        queryParam: 'ProjectName',
                        queryMode: 'local',
                        minChars: 1,
                        emptyText: "请输入项目名称或编号...",
                        fieldLabel: "项目名称",
                        displayField: 'ProjectName',
                        msgTarget: 'under',
                        allowBlank: false,
                        blankText: '项目名称不能为空',
                        margin: "10",
                        forceSelection: true,
                        anchor: '50%',
                        readOnly: id ? true : false,
                        //hideTrigger: true,
                        valueField: "ProjectName",
                        listeners: {
                            select: function (combo, records, eOpts) {
                                Ext.getCmp("ProjectId").setValue(records[0].get("ProjectId"));
                                Ext.getCmp("PManagerName").setValue(records[0].get("PManagerName"));
                                Ext.getCmp("BelongDeptId").setValue(records[0].get("BelongDeptId"));
                                Ext.getCmp("BelongDeptName").setValue(records[0].get("BelongDeptName"));
                            }
                        }
                    });
                    var store_year = Ext.create('Ext.data.JsonStore', {
                        fields: ['year'],
                        data: data_year
                    })
                    var combo_year = Ext.create('Ext.form.field.ComboBox', {
                        displayField: 'year',
                        valueField: 'year',
                        name: 'Year',
                        store: store_year,
                        queryMode: 'local',
                        editable: false,
                        fieldLabel: '所属年份',
                        labelAlign: 'right',
                        margin: '10',
                        allowBlank: false,
                        readOnly: id ? true : false,
                        blankText: '所属年份不能为空',
                        msgTarget: 'under'
                    })
                    var store_month = Ext.create('Ext.data.JsonStore', {
                        fields: ['month'],
                        data: data_month
                    })
                    var combo_month = Ext.create('Ext.form.field.ComboBox', {
                        fieldLabel: '所属月份',
                        labelAlign: 'right',
                        store: store_month,
                        queryMode: 'local',
                        displayField: 'month',
                        valueField: 'month',
                        editable: false,
                        allowBlank: false,
                        readOnly: id ? true : false,
                        margin: '10',
                        blankText: '所属月份不能为空',
                        msgTarget: 'under',
                        name: 'Month'
                    })
                    var field_remark = Ext.create('Ext.form.field.TextArea', {
                        fieldLabel: '备注',
                        labelAlign: 'right',
                        name: 'Remark',
                        height: 100,
                        margin: '10',
                        anchor: '50%'
                    })
                    var formpanel = Ext.create('Ext.form.Panel', {
                        title: '项目监理部考勤_基本信息',
                        id: 'form_baseinfo',
                        items: [combo_project, combo_year, combo_month,
                        { xtype: 'textfield', name: 'Id', hidden: true },
                        { xtype: 'textfield', hidden: true, name: 'ProjectId', id: 'ProjectId' },
                        { xtype: 'textfield', name: 'BelongDeptId', id: 'BelongDeptId', hidden: true },
                        { xtype: 'textfield', fieldLabel: '项目总监', readOnly: true, labelAlign: "right", margin: '10', name: 'PManagerName', id: 'PManagerName' },
                        { xtype: 'textfield', fieldLabel: '所属部门', readOnly: true, labelAlign: 'right', margin: '10', name: 'BelongDeptName', id: 'BelongDeptName' },
                        field_remark
                        ]
                    })
                    Ext.regModel("ProjectAttendance", {
                        fields: []
                    });
                    var btn1 = Ext.create('Ext.button.Button', {
                        text: '<span style="color:white">上 班√</span>',
                        cls: 'btn-active', handler: function (btn) {
                            SignType = "√";
                            btn2.removeCls('btn-active'); btn2.setText('请 假!');
                            btn3.removeCls('btn-active'); btn3.setText('其 他×');
                            btn1.addCls('btn-active'); btn1.setText('<span style="color:white">上 班√</span>');
                        }
                    })
                    var btn2 = Ext.create('Ext.button.Button', {
                        text: '请 假!', handler: function (btn) {
                            SignType = "!";
                            btn1.removeCls('btn-active'); btn1.setText('上 班√');
                            btn3.removeCls('btn-active'); btn3.setText('其 他×');
                            btn2.addCls('btn-active'); btn2.setText('<span style="color:white">请 假!</span>');
                        }
                    })
                    var btn3 = Ext.create('Ext.button.Button', {
                        text: '其 他×', handler: function (btn) {
                            SignType = "×";
                            btn1.removeCls('btn-active'); btn1.setText('上 班√');
                            btn2.removeCls('btn-active'); btn2.setText('请 假!');
                            btn3.addCls('btn-active'); btn3.setText('<span style="color:white">其 他×</span>');
                        }
                    })
                    var toolbar = Ext.create('Ext.toolbar.Toolbar', {
                        items: [{
                            text: '添加人员', handler: function () {
                                var win = showGroupUserWin();
                                win.show();
                            }
                        }, '-', {
                            text: '删除人员', handler: function () {
                                var recs = grid.getSelectionModel().getSelection();
                                if (recs.length == 0) {
                                    Ext.MessageBox.alert('提示', '请选择要删除的记录!');
                                    return;
                                }
                                Ext.Ajax.request({
                                    url: 'ProjectAttendanceCard.aspx?action=delete',
                                    params: { userid: recs[0].get("UserId"), id: id },
                                    method: 'POST',
                                    callback: function () {
                                        store.remove(recs[0]);
                                    }
                                })
                            }
                        }, '-', btn1, btn2, btn3]
                    })
                    //2017-2-15 modify by panhuaguo
                    store_detail = Ext.create('Ext.data.JsonStore', {
                        fields: ['UserId', 'UserName', 'Date1', 'Date2', 'Date3', 'Date4', 'Date5', 'Date6', 'Date7', 'Date8', 'Date9', 'Date10', 'Date11'
                        , 'Date11', 'Date12', 'Date13', 'Date14', 'Date15', 'Date16', 'Date17', 'Date18', 'Date19', 'Date20', 'Date21'
                        , 'Date22', 'Date23', 'Date24', 'Date25', 'Date26', 'Date27', 'Date28', 'Date29', 'Date30', 'Date31'],
                        data: []
                    })
                    grid = Ext.create('Ext.grid.Panel', {
                        tbar: toolbar,
                        enableColumnHide: false,
                        titleAlign: 'center',
                        columnLines: true,
                        store: store_detail,
                        columns: [
                        { xtype: 'rownumberer', width: 30 },
                        { header: '姓名', dataIndex: 'UserName', width: 80, sortable: false },
                        { header: 'UserId', dataIndex: 'UserId', hidden: true, sortable: false },
                        { header: '20', dataIndex: 'Date20', sortable: false, width: 38 },
                        { header: '21', dataIndex: 'Date21', sortable: false, width: 38 },
                        { header: '22', dataIndex: 'Date22', sortable: false, width: 38 },
                        { header: '23', dataIndex: 'Date23', sortable: false, width: 38 },
                        { header: '24', dataIndex: 'Date24', sortable: false, width: 38 },
                        { header: '25', dataIndex: 'Date25', sortable: false, width: 38 },
                        { header: '26', dataIndex: 'Date26', sortable: false, width: 38 },
                        { header: '27', dataIndex: 'Date27', sortable: false, width: 38 },
                        { header: '28', dataIndex: 'Date28', sortable: false, width: 38 },
                        { header: '29', dataIndex: 'Date29', sortable: false, width: 38, itemId: 'col29' },
                        { header: '30', dataIndex: 'Date30', sortable: false, width: 38, itemId: 'col30' },
                        { header: '31', dataIndex: 'Date31', sortable: false, width: 38, itemId: 'col31' },
                        { header: '1', dataIndex: 'Date1', sortable: false, width: 38 },
                        { header: '2', dataIndex: 'Date2', sortable: false, width: 38 },
                        { header: '3', dataIndex: 'Date3', sortable: false, width: 38 },
                        { header: '4', dataIndex: 'Date4', sortable: false, width: 38 },
                        { header: '5', dataIndex: 'Date5', sortable: false, width: 38 },
                        { header: '6', dataIndex: 'Date6', sortable: false, width: 38 },
                        { header: '7', dataIndex: 'Date7', sortable: false, width: 38 },
                        { header: '8', dataIndex: 'Date8', sortable: false, width: 38 },
                        { header: '9', dataIndex: 'Date9', sortable: false, width: 38 },
                        { header: '10', dataIndex: 'Date10', sortable: false, width: 38 },
                        { header: '11', dataIndex: 'Date11', sortable: false, width: 38 },
                        { header: '12', dataIndex: 'Date12', sortable: false, width: 38 },
                        { header: '13', dataIndex: 'Date13', sortable: false, width: 38 },
                        { header: '14', dataIndex: 'Date14', sortable: false, width: 38 },
                        { header: '15', dataIndex: 'Date15', sortable: false, width: 38 },
                        { header: '16', dataIndex: 'Date16', sortable: false, width: 38 },
                        { header: '17', dataIndex: 'Date17', sortable: false, width: 38 },
                        { header: '18', dataIndex: 'Date18', sortable: false, width: 38 },
                        { header: '19', dataIndex: 'Date19', sortable: false, width: 38 }],
                        listeners: {
                            cellclick: function (view, td, cellIndex, record, tr, rowIndex, e, eOpts) {
                                var header = view.getHeaderCt().getHeaderAtIndex(cellIndex);
                                if (header.dataIndex != "UserName") {
                                    Ext.Ajax.request({
                                        url: "ProjectAttendanceCard.aspx?action=updatedetail",
                                        params: { "day": header.dataIndex, UserId: record.get("UserId"), UserName: record.get("UserName"), "SignType": SignType, id: id },
                                        success: function (response, opts) {
                                            var json = Ext.decode(response.responseText);
                                            if (json.success) {
                                                record.set(header.dataIndex, json.result);
                                                record.commit();
                                            }
                                        }
                                    });
                                }
                            }
                        }
                    })
                    var panel = Ext.create('Ext.panel.Panel', {
                        layout: 'card',
                        region: 'center',
                        items: [formpanel, grid],
                        buttonAlign: 'center',
                        buttons: [{
                            id: 'move-prev',
                            text: '上一步',
                            handler: function () {
                                var layout = panel.getLayout();
                                layout.prev(); //设定当前active的component的前一个component可见
                                Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
                                Ext.getCmp('move-next').setDisabled(!layout.getNext()); //获得当前active的component的后一个component或false
                            }
                        }, {
                            id: 'move-next',
                            text: '下一步', handler: function () {
                                if (formpanel.getForm().isValid()) {
                                    Ext.Ajax.request({
                                        url: 'ProjectAttendanceCard.aspx?action=save&formdata=' + Ext.encode(formpanel.getForm().getValues()),
                                        method: 'POST',
                                        success: function (response, opts) {
                                            var json = Ext.decode(response.responseText);
                                            id = json.Id;
                                            formpanel.getForm().findField("Id").setValue(json.Id);
                                            combo_project.setReadOnly({ readOnly: true });
                                            combo_year.setReadOnly({ readOnly: true });
                                            combo_month.setReadOnly({ readOnly: true });
                                            if (json.month - 1 == 2 || json.month - 1 == 4 || json.month - 1 == 6 || json.month - 1 == 9 || json.month - 1 == 11) {
                                                grid.down('#col31').hide();
                                            }
                                            if (json.month - 1 == 2) {
                                                grid.down('#col30').hide();
                                                if (!json.runyear) {
                                                    grid.down('#col29').hide();
                                                }
                                            }
                                            store_detail.loadData(json.detail);
                                            // var json = Ext.decode(response.responseText);
                                            //var filedarray = [];
                                            // var columnarray = [{ xtype: 'rownumberer', width: 30 }];

                                            // ProjectAttendance.setFields(filedarray); //Model构建完毕
                                            //store = Ext.create('Ext.data.JsonStore', {
                                            //    model: 'ProjectAttendance',
                                            //    data: json.rows
                                            //})
                                            //grid.reconfigure(store, columnarray);
                                            grid.setTitle('<h2>' + json.title + '</h2>');
                                            layout.next(); //获得当前active的component的后台一个component 或false
                                            Ext.getCmp('move-next').setDisabled(!layout.getNext());
                                            Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
                                        }
                                    })
                                }
                            }
                        }]
                    });
                    var viewport = Ext.create('Ext.container.Viewport', {
                        layout: 'card',
                        items: [panel]
                    })
                    if (id) {
                        formpanel.getForm().load({
                            url: 'ProjectAttendanceCard.aspx?action=loadform&id=' + id,
                            method: 'POST', //请求方式   
                            success: function (form, action) {
                            }
                        });
                    }
                    var layout = panel.getLayout();
                    Ext.getCmp('move-next').setDisabled(!layout.getNext());
                    Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
                }
            })
        })
        function GetUsers(recs) {
            Ext.each(recs, function (rec) {
                if (store_detail.find("UserId", rec.get("UserId")) == -1) {
                    Ext.Ajax.request({
                        url: 'ProjectAttendanceCard.aspx?action=updateprojectuser',
                        params: { userid: rec.get("UserId"), username: rec.get("Name"), id: id },
                        callback: function () {
                            store_detail.insert(store_detail.data.length, { UserId: rec.get("UserId"), UserName: rec.get("Name") });
                        }
                    })
                }
            })
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
