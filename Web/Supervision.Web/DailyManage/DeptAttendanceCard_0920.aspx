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
        .btn-active
        {
            background-color: rgba(21, 127, 204, 1);
        }
    </style>
    <script type="text/javascript">
        var id = getQueryString("id");
        var store;
        var SignType = "正常上班";
        Ext.onReady(function () {
            var store_dept = Ext.create("Ext.data.JsonStore", {
                fields: ["BelongDeptId", "BelongDeptName"],
                proxy: {
                    url: "DeptAttendanceCard.aspx?action=loaddept",
                    type: "ajax",
                    reader: {
                        type: "json",
                        root: "rows"
                    }
                }
            });
            var combo_dept = Ext.create("Ext.form.ComboBox", {
                name: "BelongDeptName",
                labelAlign: "right",
                store: store_dept,
                //   queryParam: 'BelongDeptName',
                //  minChars: 1,
                // emptyText: "请输入项目名称或编号...",
                fieldLabel: "部门名称",
                displayField: 'BelongDeptName',
                msgTarget: 'under',
                allowBlank: false,
                blankText: '部门不能为空',
                margin: "10",
                // anchor: '50%',
                readOnly: id ? true : false,
                //  hideTrigger: true,
                valueField: "BelongDeptName",
                listeners: { select: function (combo, records, eOpts) {
                    Ext.getCmp("BelongDeptId").setValue(records[0].get("BelongDeptId"));
                    //  Ext.getCmp("BelongDeptName").setValue(records[0].get("BelongDeptName"));
                }
                }
            });
            var store_year = Ext.create('Ext.data.JsonStore', {
                fields: ['year'],
                proxy: {
                    type: 'ajax',
                    url: 'DeptAttendanceCard.aspx?action=loadyear',
                    reader: {
                        root: 'rows',
                        type: 'json'
                    }
                },
                autoLoad: true
            })
            var combo_year = Ext.create('Ext.form.field.ComboBox', {
                displayField: 'year',
                valueField: 'year',
                name: 'Year',
                store: store_year,
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
                proxy: {
                    type: 'ajax',
                    url: 'DeptAttendanceCard.aspx?action=loadmonth',
                    reader: {
                        root: 'rows',
                        type: 'json'
                    }
                },
                autoLoad: true
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
            Ext.regModel("DeptAttendance", { fields: []
            });
            var btn1 = Ext.create('Ext.button.Button', { text: '<span style="color:white">上 班√</span>',
                cls: 'btn-active', handler: function (btn) {
                    SignType = "正常上班";
                    btn2.removeCls('btn-active'); btn2.setText('请 假!');
                    btn3.removeCls('btn-active'); btn3.setText('其 他×');
                    btn1.addCls('btn-active'); btn1.setText('<span style="color:white">上 班√</span>');
                }
            })
            var btn2 = Ext.create('Ext.button.Button', { text: '请 假!', handler: function (btn) {
                SignType = "请假";
                btn1.removeCls('btn-active'); btn1.setText('上 班√');
                btn3.removeCls('btn-active'); btn3.setText('其 他×');
                btn2.addCls('btn-active'); btn2.setText('<span style="color:white">请 假!</span>');
            }
            })
            var btn3 = Ext.create('Ext.button.Button', { text: '其 他×', handler: function (btn) {
                SignType = "其他";
                btn1.removeCls('btn-active'); btn1.setText('上 班√');
                btn2.removeCls('btn-active'); btn2.setText('请 假!');
                btn3.addCls('btn-active'); btn3.setText('<span style="color:white">其 他×</span>');
            }
            })
            var toolbar = Ext.create('Ext.toolbar.Toolbar', {
                items: [{ text: '添加人员', handler: function () {
                    var win = showGroupUserWin();
                    win.show();
                }
                }, '-', { text: '删除人员', handler: function () {
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
            var grid = Ext.create('Ext.grid.Panel', {
                tbar: toolbar,
                enableColumnHide: false,
                titleAlign: 'center',
                columnLines: true,
                columns: [],
                listeners: { cellclick: function (view, td, cellIndex, record, tr, rowIndex, e, eOpts) {
                    var header = view.getHeaderCt().getHeaderAtIndex(cellIndex);
                    if (header.dataIndex != "UserName" && header.dataIndex != "ProjectName") {
                        Ext.Ajax.request({
                            url: "DeptAttendanceCard.aspx?action=updatedetail",
                            params: { "day": header.dataIndex.replace('C', ''), UserId: record.get("UserId"), UserName: record.get("UserName"), "SignType": SignType, id: id },
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
                            var action = id ? 'update' : 'create';
                            Ext.Ajax.request({
                                url: 'DeptAttendanceCard.aspx?action=' + action + '&formdata=' + Ext.encode(formpanel.getForm().getValues()),
                                method: 'POST',
                                success: function (response, opts) {
                                    var json = Ext.decode(response.responseText);
                                    if (json.id) {
                                        id = json.id;
                                        formpanel.getForm().findField("Id").setValue(id);
                                        combo_dept.setReadOnly({ readOnly: true });
                                        combo_year.setReadOnly({ readOnly: true });
                                        combo_month.setReadOnly({ readOnly: true });
                                        Ext.Ajax.request({
                                            url: 'DeptAttendanceCard.aspx?action=inigrid&id=' + id,
                                            method: 'POST',
                                            success: function (response, opts) {
                                                var json = Ext.decode(response.responseText);
                                                var filedarray = [];
                                                var columnarray = [{ xtype: 'rownumberer', width: 30}];
                                                for (var i = 0; i < json.columns.length; i++) {
                                                    filedarray.push(json.columns[i].ColumnName);
                                                    var key = json.columns[i].ColumnName;
                                                    switch (key) {
                                                        case "UserName":
                                                            columnarray.push({ header: '姓名', dataIndex: key, width: 80, sortable: false });
                                                            break;
                                                        case "UserId":
                                                            columnarray.push({ header: key, header: key, hidden: true, sortable: false });
                                                            break;
                                                        case "ProjectName":
                                                            columnarray.push({ header: '项目名称', dataIndex: key, sortable: false, width: 150 });
                                                            break;
                                                        default:
                                                            columnarray.push({ header: key.replace('C', ''), dataIndex: key, sortable: false, width: 38 });
                                                            break;
                                                    }
                                                }
                                                DeptAttendance.setFields(filedarray); //Model构建完毕
                                                store = Ext.create('Ext.data.JsonStore', {
                                                    model: 'DeptAttendance',
                                                    data: json.rows
                                                })
                                                grid.reconfigure(store, columnarray);
                                                grid.setTitle(json.title);
                                                layout.next(); //获得当前active的component的后台一个component 或false
                                                Ext.getCmp('move-next').setDisabled(!layout.getNext());
                                                Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
                                            }
                                        })
                                    }
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
        })
        function GetUsers(recs) {
            Ext.each(recs, function (rec) {
                var obj = new ProjectAttendance({ UserId: rec.get("UserId"), UserName: rec.get("Name") });
                if (store.find("UserId", rec.get("UserId")) == -1) {
                    Ext.Ajax.request({
                        url: 'DeptAttendanceCard.aspx?action=updateprojectuser',
                        params: { userid: rec.get("UserId"), username: rec.get("Name"), id: id },
                        callback: function () {
                            store.insert(store.data.length, obj);
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
