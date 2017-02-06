<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeptAttendanceEdit.aspx.cs"
    Inherits="SP.Web.DailyManage.DeptAttendanceEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <style type="text/css">
        .btn-active
        {
            background-color: rgba(21, 127, 204, 1);
        }
    </style>
    <script type="text/javascript">
        var columnarray = [];
        var id = getQueryString("id");
        var SignType = "正常上班";
        Ext.onReady(function () {
            Ext.regModel("DeptAttendance", { fields: [] });
            var store = Ext.create("Ext.data.JsonStore", {
                model: "DeptAttendance"
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
            var toolbar = Ext.create("Ext.toolbar.Toolbar", {
                items: [
                { xtype: "textfield", fieldLabel: "姓名", id: "Name", labelWidth: 60 },
                { xtype: "textfield", fieldLabel: "项目名称", id: "ProjectName", labelWidth: 60 },
                { text: "查 询", icon: '/images/shared/search_show.gif', handler: function () {
                    var name = Ext.getCmp("Name").getValue();
                    var ProjectName = Ext.getCmp("ProjectName").getValue();
                    var filters = [];
                    if (name) {
                        filter1 = Ext.create('Ext.util.Filter', { anyMatch: true, root: 'data', property: "UserName", value: name });
                        filters.push(filter1);
                    }
                    if (ProjectName) {
                        filter2 = Ext.create('Ext.util.Filter', { anyMatch: true, root: 'data', property: "ProjectName", value: ProjectName })
                        filters.push(filter2);
                    }
                    if (filters.length > 0) {
                        store.clearFilter(true);
                        store.filter(filters);
                    }
                    if (filters.length == 0) {
                        store.removeFilter();
                    }
                }
                }, '-',
               btn1, '-', btn2, '-', btn3]
            });
            var grid = Ext.create("Ext.grid.Panel", {
                titleAlign: 'center',
                store: store,
                tbar: toolbar,
                columnLines: true,
                enableColumnHide: false,
                columns: [],
                region: "center",
                listeners: { cellclick: function (view, td, cellIndex, record, tr, rowIndex, e, eOpts) {
                    var header = view.getHeaderCt().getHeaderAtIndex(cellIndex);
                    if (header.dataIndex != "UserName" && header.dataIndex != "ProjectName") {
                        Ext.Ajax.request({
                            url: "DeptAttendanceEdit.aspx?action=update",
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
            });
            var viewport = Ext.create("Ext.container.Viewport", {
                layout: "border",
                items: [grid]
            });
            Ext.Ajax.request({
                url: "DeptAttendanceEdit.aspx",
                method: "POST",
                params: { action: "load", id: id },
                success: function (response, opts) {
                    var json = Ext.decode(response.responseText);
                    var filedarray = [];
                    columnarray.push({ xtype: "rownumberer", width: 40 });
                    for (var key in json.rows[0]) {
                        filedarray.push(key);
                        switch (key) {
                            case "UserId":
                                columnarray.push({ header: key, dataIndex: key, hidden: true, sortable: false });
                                break;
                            case "UserName":
                                columnarray.push({ header: '姓名', dataIndex: key, width: 70 });
                                break;
                            case "ProjectName":
                                columnarray.push({ header: '项目名称', dataIndex: key, width: 150 });
                                break;
                            default:
                                columnarray.push({ header: key.replace('C', ''), dataIndex: key, width: 40, sortable: false });
                                break;
                        }
                    }
                    DeptAttendance.setFields(filedarray); //动态加载Model
                    store.loadData(json.rows);
                    grid.reconfigure(store, columnarray);
                    grid.setTitle('<h2>' + json.title + '</h2>');
                }
            });
        }); 
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    </div>
    </form>
</body>
</html>
