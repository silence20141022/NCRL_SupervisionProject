<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CmpAttendEdit.aspx.cs"
    Inherits="SP.Web.DailyManage.CmpAttendEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Extjs42/resources/css/ext-all-gray.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <style type="text/css">
        .btn-active
        {
            background-color: rgba(21, 127, 204, 1);
        }
    </style>
    <title></title>
    <script type="text/javascript">
        var id = getQueryString("id");
        var attendant = "正常上班";
        var pgbar;
        Ext.onReady(function () {
            var store_combo = Ext.create('Ext.data.Store', {
                fields: ['value', 'name'],
                data: [{ value: 'UserName', name: '按人员' }, { value: 'DeptName', name: '按部门' }, { value: 'ProjectName', name: '按项目'}]
            })
            var combo_search = Ext.create('Ext.form.ComboBox', {
                store: store_combo,
                valueField: 'value',
                displayField: 'name',
                value: 'UserName',
                fieldLabel: '查询条件',
                labelAlign: 'right'
            })
            var btn1 = Ext.create('Ext.button.Button', { text: '<span style="color:white">上 班√</span>',
                cls: 'btn-active', handler: function (btn) {
                    attendant = "正常上班";
                    btn2.removeCls('btn-active'); btn2.setText('请 假!');
                    btn3.removeCls('btn-active'); btn3.setText('其 他×');
                    btn1.addCls('btn-active'); btn1.setText('<span style="color:white">上 班√</span>');
                }
            })
            var btn2 = Ext.create('Ext.button.Button', { text: '请 假!', handler: function (btn) {
                attendant = "请假";
                btn1.removeCls('btn-active'); btn1.setText('上 班√');
                btn3.removeCls('btn-active'); btn3.setText('其 他×');
                btn2.addCls('btn-active'); btn2.setText('<span style="color:white">请 假!</span>');
            }
            })
            var btn3 = Ext.create('Ext.button.Button', { text: '其 他×', handler: function (btn) {
                attendant = "其他";
                btn1.removeCls('btn-active'); btn1.setText('上 班√');
                btn2.removeCls('btn-active'); btn2.setText('请 假!');
                btn3.addCls('btn-active'); btn3.setText('<span style="color:white">其 他×</span>');
            }
            })
            var toolbar = Ext.create('Ext.toolbar.Toolbar', {
                items: [combo_search, { xtype: 'textfield', id: 'search_val' },
                { text: '查 询', icon: '/images/shared/search_show.gif', handler: function () {
                    pgbar.moveFirst(); 
                }
                }, '-', btn1, '-', btn2, '-', btn3]
            })
            Ext.regModel("CompanyAttend", { fields: [] })
            var store_cmpattend = Ext.create('Ext.data.JsonStore', {
                model: 'CompanyAttend'
            })
            pgbar = Ext.create('Ext.toolbar.Paging', {
                displayMsg: '显示 {0} - {1} 条，共计 {2} 条',
                store: store_cmpattend,
                displayInfo: true
            });
            var grid = Ext.create('Ext.grid.Panel', {
                titleAlign: 'center',
                tbar: toolbar,
                store: store_cmpattend,
                bbar: pgbar,
                enableColumnHide: false,
                columnLines: true,
                //enableLocking: true,
                columns: [],
                region: 'center',
                listeners: { cellclick: function (view, td, cellIndex, record, tr, rowIndex, e, eOpts) {
                    var header = view.getHeaderCt().getHeaderAtIndex(cellIndex);
                    if (header.dataIndex != "UserName" && header.dataIndex != "DeptName" && header.dataIndex != "ProjectName") {
                        Ext.Ajax.request({
                            url: 'CmpAttendEdit.aspx?action=update',
                            params: { userid: record.get("UserId"), username: record.get("UserName"), day: header.dataIndex.replace('C', ''), attendanttype: attendant, id: id },
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
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [grid]
            })
            Ext.Ajax.request({
                url: 'CmpAttendEdit.aspx?action=loaddetail&start=0&limit=25&id=' + id,
                method: 'POST',
                success: function (response, opts) {
                    var json = Ext.decode(response.responseText);
                    var filedarray = [];
                    var columnarray = [{ xtype: 'rownumberer', width: 40}];
                    for (var key in json.rows[0]) {
                        filedarray.push(key);
                        switch (key) {
                            case "UserId":
                                columnarray.push({ header: key, dataIndex: key, hidden: true, sortable: false });
                                break;
                            case "UserName":
                                columnarray.push({ header: '姓名', dataIndex: key, width: 70, locked: true, sortable: false });
                                break;
                            case "DeptName":
                                columnarray.push({ header: '部门', dataIndex: key, width: 150, locked: true, sortable: false });
                                break;
                            case "ProjectName":
                                columnarray.push({ header: '项目', dataIndex: key, width: 150, locked: true, sortable: false });
                                break;
                            default:
                                columnarray.push({ header: key.replace('C', ''), dataIndex: key, width: 30, sortable: false });
                                break;
                        }
                    }
                    CompanyAttend.setFields(filedarray); //Model构建完毕                     
                    //store_cmpattend.loadData(json.rows);
                    store_cmpattend = new Ext.data.JsonStore({
                        model: 'CompanyAttend',
                        proxy: {
                            type: 'ajax',
                            url: 'CmpAttendEdit.aspx?action=loaddetail&id=' + id,
                            reader: {
                                reader: "json",
                                root: 'rows',
                                totalProperty: "total"
                            }                           
                        },
                        pageSize: 25,
                        data: json.rows,
                        listeners: { beforeload: function () { store_cmpattend.getProxy().extraParams = { SearchCondition: combo_search.getValue(), SearchValue: Ext.getCmp("search_val").getValue()} } }
                    });
                    grid.reconfigure(store_cmpattend, columnarray);
                    grid.setTitle("<h2>" + json.title + "</h2>");
                    pgbar.bindStore(store_cmpattend);
                    pgbar.doRefresh()
                }
            });
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
