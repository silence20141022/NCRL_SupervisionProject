<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeptAttendanceCard.aspx.cs"
    Inherits="SP.Web.DailyManage.DeptAttendanceCard" %>

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
        var store, pgbar;
        var SignType = "√";
        var data_dept = [];
        var data_year = [];
        var data_month = [];
        Ext.onReady(function () {
            Ext.Ajax.request({
                url: "DeptAttendanceCard.aspx?action=loaddept",
                success: function (response, opts) {
                    var json_data = Ext.decode(response.responseText);
                    data_dept = json_data.rows;
                    data_year = json_data.year;
                    data_month = json_data.month;

                    var store_dept = Ext.create("Ext.data.JsonStore", {
                        fields: ["BelongDeptId", "BelongDeptName"],
                        data: data_dept
                    });
                    var combo_dept = Ext.create("Ext.form.ComboBox", {
                        name: "BelongDeptName",
                        labelAlign: "right",
                        store: store_dept,
                        fieldLabel: "部门名称",
                        displayField: 'BelongDeptName',
                        msgTarget: 'under',
                        allowBlank: false,
                        blankText: '部门不能为空',
                        margin: "10",
                        queryMode: 'local',
                        readOnly: id ? true : false,
                        valueField: "BelongDeptName",
                        listeners: {
                            select: function (combo, records, eOpts) {
                                Ext.getCmp("BelongDeptId").setValue(records[0].get("BelongDeptId"));
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
                        editable: false,
                        fieldLabel: '所属年份',
                        labelAlign: 'right',
                        queryMode: 'local',
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
                        displayField: 'month',
                        valueField: 'month',
                        editable: false,
                        allowBlank: false,
                        readOnly: id ? true : false,
                        queryMode: 'local',
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
                        title: '部门考勤_基本信息',
                        id: 'form_baseinfo',
                        items: [combo_dept, combo_year, combo_month,
                        { xtype: 'textfield', name: 'Id', hidden: true },
                        { xtype: 'textfield', name: 'BelongDeptId', id: 'BelongDeptId', hidden: true },
                        field_remark
                        ]
                    })
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
                        items: [
                        { xtype: 'textfield', fieldLabel: '姓名', labelWidth: 60, id: 'UserName' },
                        { xtype: 'textfield', fieldLabel: '项目名称', labelWidth: 60, id: 'ProjectName' },
                    {
                        text: "查询", handler: function () {
                            Ext.Ajax.request({
                                url: "DeptAttendanceCard.aspx?action=search&id=" + id,
                                params: { UserName: Ext.getCmp('UserName').getValue(), ProjectName: Ext.getCmp("ProjectName").getValue() },
                                success: function (response, opts) {
                                    var json = Ext.decode(response.responseText);
                                    store.loadData(json.rows);
                                }
                            });
                        }
                    },
                     {
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
                    store = Ext.create('Ext.data.JsonStore', {
                        fields: ['UserId', 'UserName', 'ProjectNames', 'Date1', 'Date2', 'Date3', 'Date4', 'Date5', 'Date6', 'Date7', 'Date8', 'Date9', 'Date10', 'Date11'
                        , 'Date11', 'Date12', 'Date13', 'Date14', 'Date15', 'Date16', 'Date17', 'Date18', 'Date19', 'Date20', 'Date21'
                        , 'Date22', 'Date23', 'Date24', 'Date25', 'Date26', 'Date27', 'Date28', 'Date29', 'Date30', 'Date31'],
                        data: []
                        //listeners: {
                        //    beforeload: function () {
                        //        store.getProxy().extraParams = { UserName: Ext.getCmp('UserName').getValue(), ProjectName: Ext.getCmp("ProjectName").getValue() }
                        //    }
                        //}
                    })
                    var grid = Ext.create('Ext.grid.Panel', {
                        tbar: toolbar,
                        enableColumnHide: false,
                        titleAlign: 'center',
                        columnLines: true,
                        store: store,
                        columns: [
                        { xtype: 'rownumberer', width: 30 },
                        { header: '姓名', dataIndex: 'UserName', width: 70, sortable: false },
                        { header: '参与项目', dataIndex: 'ProjectNames', width: 160 },
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
                                if (header.dataIndex != "UserName" && header.dataIndex != "ProjectNames") {
                                    Ext.Ajax.request({
                                        url: "DeptAttendanceCard.aspx?action=updatedetail",
                                        params: { "day": header.dataIndex, UserId: record.get("UserId"), UserName: record.get("UserName"), "SignType": SignType, id: id },
                                        success: function (response, opts) {
                                            var json = Ext.decode(response.responseText);
                                            record.set(header.dataIndex, json.result);
                                            record.commit();
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
                                        url: 'DeptAttendanceCard.aspx?action=save&formdata=' + Ext.encode(formpanel.getForm().getValues()),
                                        method: 'POST',
                                        success: function (response, opts) {
                                            var json = Ext.decode(response.responseText);
                                            id = json.id;
                                            formpanel.getForm().findField("Id").setValue(id);
                                            combo_dept.setReadOnly({ readOnly: true });
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
                                            store.loadData(json.detail);
                                            grid.setTitle(json.title);
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
                            url: 'DeptAttendanceCard.aspx?action=loadform&id=' + id,
                            method: 'POST', //请求方式   
                            success: function (form, action) {
                            }
                        });
                    }
                    var layout = panel.getLayout();
                    Ext.getCmp('move-next').setDisabled(!layout.getNext());
                    Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
                }
            });//回调函数结束的位置
        })

        function GetUsers(recs) {
            Ext.each(recs, function (rec) {
                //    var obj = new ProjectAttendance({ UserId: rec.get("UserId"), UserName: rec.get("Name") });
                if (store.find("UserId", rec.get("UserId")) == -1) {
                    //Ext.Ajax.request({
                    //    url: 'DeptAttendanceCard.aspx?action=updateprojectuser',
                    //    params: { userid: rec.get("UserId"), username: rec.get("Name"), id: id },
                    //    callback: function () {
                    store.insert(store.data.length, { UserId: rec.get("UserId"), UserName: rec.get("Name") });
                    //     }
                    // })
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
