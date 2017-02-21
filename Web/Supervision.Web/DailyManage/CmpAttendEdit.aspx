<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CmpAttendEdit.aspx.cs"
    Inherits="SP.Web.DailyManage.CmpAttendEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Extjs42/resources/css/ext-all-gray.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <style type="text/css">
        .btn-active {
            background-color: rgba(21, 127, 204, 1);
        }
    </style>
    <title></title>
    <script type="text/javascript">
        var id = getQueryString("id");
        var store_cmpattend;
        Ext.onReady(function () {
            Ext.Ajax.request({
                url: 'CmpAttendEdit.aspx?action=loaddata&id=' + id,
                method: 'POST',
                success: function (response, opts) {
                    var json = Ext.decode(response.responseText);
                    var store_combo = Ext.create('Ext.data.Store', {
                        fields: ['GroupID', 'Name'],
                        data: json.dept
                    })
                    var combo_search = Ext.create('Ext.form.ComboBox', {
                        id: 'deptcombo',
                        store: store_combo,
                        valueField: 'GroupID',
                        labelWidth: 45,
                        displayField: 'Name',
                        fieldLabel: '部门',
                        labelAlign: 'right'
                    })
                    var btn1 = Ext.create('Ext.button.Button', {
                        text: '上 班√',
                        cls: 'btn-active', handler: function (btn) {
                            //attendant = "正常上班";
                            //btn2.removeCls('btn-active'); btn2.setText('请 假!');
                            //btn3.removeCls('btn-active'); btn3.setText('其 他×');
                            //btn1.addCls('btn-active'); btn1.setText('<span style="color:white">上 班√</span>');
                        }
                    })
                    var btn2 = Ext.create('Ext.button.Button', {
                        text: '请 假!', handler: function (btn) {
                            //attendant = "请假";
                            //btn1.removeCls('btn-active'); btn1.setText('上 班√');
                            //btn3.removeCls('btn-active'); btn3.setText('其 他×');
                            //btn2.addCls('btn-active'); btn2.setText('<span style="color:white">请 假!</span>');
                        }
                    })
                    var btn3 = Ext.create('Ext.button.Button', {
                        text: '其 他×', handler: function (btn) {
                            //attendant = "其他";
                            //btn1.removeCls('btn-active'); btn1.setText('上 班√');
                            //btn2.removeCls('btn-active'); btn2.setText('请 假!');
                            //btn3.addCls('btn-active'); btn3.setText('<span style="color:white">其 他×</span>');
                        }
                    })
                    var toolbar = Ext.create('Ext.toolbar.Toolbar', {
                        items: [{ fieldLabel: '姓名', labelWidth: 45, xtype: 'textfield', id: 'search_user' },
                            { fieldLabel: '项目名称', labelWidth: 60, xtype: 'textfield', id: 'search_project' },
                            combo_search,
                        {
                            text: '查 询', handler: function () {
                                Ext.Ajax.request({
                                    url: 'CmpAttendEdit.aspx?action=search',
                                    method: 'POST',
                                    params: {
                                        id: id,
                                        username: Ext.getCmp('search_user').getValue(),
                                        projectname: Ext.getCmp("search_project").getValue(),
                                        deptid: Ext.getCmp('deptcombo').getValue()
                                    },
                                    success: function (response, opts) {
                                        var json = Ext.decode(response.responseText);
                                        store_cmpattend.loadData(json.rows);
                                    }
                                });
                            }
                        }, '-', {
                            text: '重置', handler: function () {
                                Ext.getCmp('search_user').setValue('');
                                Ext.getCmp("search_project").setValue('');
                                Ext.getCmp('deptcombo').setValue('');
                            }
                        }, '-', btn1, '-', btn2, '-', btn3]
                    })
                    store_cmpattend = Ext.create('Ext.data.JsonStore', {
                        fields: ['UserId', 'UserName', 'DeptName', 'ProjectNames', 'Date1', 'Date2', 'Date3', 'Date4', 'Date5', 'Date6', 'Date7', 'Date8', 'Date9', 'Date10', 'Date11'
                               , 'Date11', 'Date12', 'Date13', 'Date14', 'Date15', 'Date16', 'Date17', 'Date18', 'Date19', 'Date20', 'Date21'
                               , 'Date22', 'Date23', 'Date24', 'Date25', 'Date26', 'Date27', 'Date28', 'Date29', 'Date30', 'Date31'],
                        data: json.rows
                    })
                    var grid = Ext.create('Ext.grid.Panel', {
                        titleAlign: 'center',
                        tbar: toolbar,
                        store: store_cmpattend,
                        enableColumnHide: false,
                        columnLines: true,
                        title: json.title,
                        columns: [
                        { xtype: 'rownumberer', width: 30, locked: true },
                        { header: '姓名', dataIndex: 'UserName', width: 70, sortable: false, locked: true },
                        { header: '所属部门', dataIndex: 'DeptName', width: 100, locked: true },
                        { header: '参与项目', dataIndex: 'ProjectNames', width: 160, locked: true },
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
                        region: 'center',
                        listeners: {
                            //cellclick: function (view, td, cellIndex, record, tr, rowIndex, e, eOpts) {
                            //    var header = view.getHeaderCt().getHeaderAtIndex(cellIndex);
                            //    if (header.dataIndex != "UserName" && header.dataIndex != "DeptName" && header.dataIndex != "ProjectName") {
                            //        Ext.Ajax.request({
                            //            url: 'CmpAttendEdit.aspx?action=update',
                            //            params: { userid: record.get("UserId"), username: record.get("UserName"), day: header.dataIndex.replace('C', ''), attendanttype: attendant, id: id },
                            //            success: function (response, opts) {
                            //                var json = Ext.decode(response.responseText);
                            //                record.set(header.dataIndex, json.result);
                            //                record.commit();
                            //            }
                            //        });
                            //    }
                            //}
                        }
                    })
                    var viewport = Ext.create('Ext.container.Viewport', {
                        layout: 'border',
                        items: [grid]
                    })
                    if (json.month - 1 == 2 || json.month - 1 == 4 || json.month - 1 == 6 || json.month - 1 == 9 || json.month - 1 == 11) {
                        grid.down('#col31').hide();
                    }
                    if (json.month - 1 == 2) {
                        grid.down('#col30').hide();
                        if (!json.runyear) {
                            grid.down('#col29').hide();
                        }
                    }
                }
            });
            //pgbar = Ext.create('Ext.toolbar.Paging', {
            //    displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
            //    store: store_cmpattend,
            //    displayInfo: true
            //});

            //Ext.Ajax.request({
            //    url: 'CmpAttendEdit.aspx?action=loaddetail&start=0&limit=25&id=' + id,
            //    method: 'POST',
            //    success: function (response, opts) {
            //        var json = Ext.decode(response.responseText);
            //        var filedarray = [];
            //        var columnarray = [{ xtype: 'rownumberer', width: 40 }];
            //        for (var key in json.rows[0]) {
            //            filedarray.push(key);
            //            switch (key) {
            //                case "UserId":
            //                    columnarray.push({ header: key, dataIndex: key, hidden: true, sortable: false });
            //                    break;
            //                case "UserName":
            //                    columnarray.push({ header: '姓名', dataIndex: key, width: 70, locked: true, sortable: false });
            //                    break;
            //                case "DeptName":
            //                    columnarray.push({ header: '部门', dataIndex: key, width: 150, locked: true, sortable: false });
            //                    break;
            //                case "ProjectName":
            //                    columnarray.push({ header: '项目', dataIndex: key, width: 150, locked: true, sortable: false });
            //                    break;
            //                default:
            //                    columnarray.push({ header: key.replace('C', ''), dataIndex: key, width: 30, sortable: false });
            //                    break;
            //            }
            //        }
            //        CompanyAttend.setFields(filedarray); //Model构建完毕                     
            //        //store_cmpattend.loadData(json.rows);
            //        store_cmpattend = new Ext.data.JsonStore({
            //            model: 'CompanyAttend',
            //            proxy: {
            //                type: 'ajax',
            //                url: 'CmpAttendEdit.aspx?action=loaddetail&id=' + id,
            //                reader: {
            //                    reader: "json",
            //                    root: 'rows',
            //                    totalProperty: "total"
            //                }
            //            },
            //            pageSize: 25,
            //            data: json.rows,
            //            listeners: { beforeload: function () { store_cmpattend.getProxy().extraParams = { SearchCondition: combo_search.getValue(), SearchValue: Ext.getCmp("search_val").getValue() } } }
            //        });
            //        grid.reconfigure(store_cmpattend, columnarray);
            //        grid.setTitle("<h2>" + json.title + "</h2>");
            //        pgbar.bindStore(store_cmpattend);
            //        pgbar.doRefresh()
            //    }
            //});
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
    </form>
</body>
</html>
