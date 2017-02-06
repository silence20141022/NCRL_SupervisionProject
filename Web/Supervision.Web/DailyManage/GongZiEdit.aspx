<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GongZiEdit.aspx.cs" Inherits="SP.Web.DailyManage.GongZiEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-gray.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="groupuser.js" type="text/javascript"></script>
    <script src="/js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var store_user, year, month, gongziPanel, usergrid;
        var formId = getQueryString("formId");
        Ext.onReady(function () {
            var store1 = new Ext.data.Store({
                fields: ['year'],
                data: [
                    { "year": "2014" }, { "year": "2015" }, { "year": "2016" }, { "year": "2017" }
                ]
            });
            var combo1 = new Ext.form.ComboBox({
                fieldLabel: '所属年份',
                labelAlign: 'right',
                readOnly: formId,
                editable: false,
                store: store1,
                margin: '5 5 5 5',
                name: 'Year',
                queryMode: 'local',
                displayField: 'year',
                valueField: 'year',
                listeners: { select: function (combo, records, eOpts) {
                    year = records[0].get("year");
                    if (year && month) {
                        Ext.Ajax.request({
                            url: 'GongZiEdit.aspx?action=savestage',
                            params: { year: year, month: month },
                            callback: function (option, success, response) {
                                var json1 = Ext.JSON.decode(response.responseText);
                                if (json1.Id) {
                                    window.location.href = "GongZiEdit.aspx?formId=" + json1.Id;
                                }
                                else {
                                    alert("该阶段的工资单已经存在！");
                                    gongziPanel.getForm().findField("Year").setValue("");
                                    gongziPanel.getForm().findField("Month").setValue("");
                                }
                            }
                        });
                    }
                }
                }
            });
            var store2 = new Ext.data.Store({
                fields: ['month'],
                data: [
                    { "month": "1" }, { "month": "2" }, { "month": "3" }, { "month": "4" },
                    { "month": "5" }, { "month": "6" }, { "month": "7" }, { "month": "8" },
                    { "month": "9" }, { "month": "10" }, { "month": "11" }, { "month": "12" }
                ]
            });
            var combo2 = new Ext.form.ComboBox({
                fieldLabel: '所属月份',
                labelAlign: 'right',
                store: store2,
                margin: '5 5 5 5',
                readOnly: formId,
                editable: false,
                name: 'Month',
                queryMode: 'local',
                displayField: 'month',
                valueField: 'month',
                listeners: { select: function (combo, records, eOpts) {
                    month = records[0].get("month");
                    if (year && month) {
                        Ext.Ajax.request({
                            url: 'GongZiEdit.aspx?action=savestage',
                            params: { year: year, month: month },
                            callback: function (option, success, response) {
                                var json1 = Ext.JSON.decode(response.responseText);
                                if (json1.Id) {
                                    window.location.href = "GongZiEdit.aspx?formId=" + json1.Id;
                                }
                                else {
                                    alert("该阶段的工资单已经存在！");
                                    gongziPanel.getForm().findField("Year").setValue("");
                                    gongziPanel.getForm().findField("Month").setValue("");
                                }
                            }
                        });
                    }
                }
                }
            });
            var remark = {
                xtype: 'textareafield',
                height: 45,
                name: 'Remark',
                labelAlign: 'right',
                margin: '5 5 5 5',
                anchor: '100%',
                fieldLabel: '备注'
            }
            var gongziPanel = new Ext.form.Panel({
                region: 'north',
                height: 160,
                items: [{ layout: 'column', bodyStyle: 'border:0', items: [
                { columnWidth: .5, bodyStyle: 'border:0', items: [combo1] },
                { columnWidth: .5, bodyStyle: 'border:0', items: [combo2] }
                ]
                } //1 行结束
                          , remark,
                { xtype: 'textfield', name: 'Id', hidden: true },
                { xtype: 'displayfield', fieldLabel: '说明', value: '1 工资单年份和月份一经确认后不允许再修改,系统会自动载入上月工资明细&nbsp;&nbsp;&nbsp;&nbsp;2 人员工资明细调整时系统自动保存&nbsp;&nbsp;&nbsp;&nbsp;3 当添加人员时选择了记录,则添加的人员会插入到选择的记录之前;', labelAlign: 'right' }
                ],
                buttons: [{ text: '保 存', handler: function () {
                    var detaildata = Ext.encode(Ext.pluck(store_user.data.items, 'data'));
                    Ext.Ajax.request({
                        url: 'GongZiEdit.aspx?action=updateRemark',
                        params: { id: formId, Remark: gongziPanel.getForm().findField("Remark").getValue(), detaildata: detaildata },
                        success: function (response) {
                            Ext.Msg.alert('提示', '保存成功！', function () {
                                if (window.opener && window.opener.store_stage) {
                                    window.opener.store_stage.load();
                                }
                                window.close();
                            })
                        }
                    })
                }
                }, { text: '关 闭', handler: function () {
                    window.close();
                }
                }],
                buttonAlign: 'center'
            })
            Ext.regModel('Salary', { fields: [{ name: 'Id' }, { name: 'UserId' }, { name: 'UserName' }, { name: 'Job' }, { name: 'JobLevel' },
             { name: 'IDNumber' }, { name: 'DeptName' }, { name: 'DeptId' }, { name: 'GangWeiSalary', type: 'float' },
             { name: 'GongLingBuTie', type: 'float' }, { name: 'ZhuCeBuTie', type: 'float' },
             { name: 'GangWeiBuTie', type: 'float' }, { name: 'TeShuBuTie', type: 'float' }, { name: 'XianChangBuTie', type: 'float' },
             { name: 'TotalSalary', type: 'float' }, { name: 'ModifyDate' }, { name: 'State' }, { name: 'Remark' }, { name: 'CreateId' },
             { name: 'CreateName' }, { name: 'CreateTime' }, { name: 'StageId' }, { name: 'SortIndex', type: 'int' }, { name: 'SalaryAdjustId'}]
            })
            store_user = new Ext.data.JsonStore({
                model: "Salary",
                proxy: {
                    type: 'ajax',
                    url: "GongZiEdit.aspx?action=loaddetail",
                    extraParams: { id: formId },
                    reader: {
                        type: "json",
                        root: 'rows',
                        totalProperty: 'total'
                    }
                },
                autoLoad: true,
                listeners: { beforeload: function (store, options) {
                    var new_params = {
                        UserName: Ext.getCmp("UserName_s").getValue(),
                        DeptId: combo_dept.getValue()
                    }
                    Ext.apply(store.proxy.extraParams, new_params);
                }
                }
            });
            var store_dept = Ext.create('Ext.data.JsonStore', {
                fields: ['id', 'name'],
                proxy: {
                    url: 'GongZiEdit.aspx?action=loaddept',
                    type: 'ajax',
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                },
                autoLoad: true
            })
            var combo_dept = Ext.create('Ext.form.field.ComboBox', {
                store: store_dept,
                valueField: 'id',
                displayField: 'name',
                fieldLabel: '部门',
                labelAlign: 'right',
                labelWidth: 60,
                editable: false
            })
            var tbar = new Ext.toolbar.Toolbar({
                items: [
                { xtype: 'textfield', fieldLabel: '姓名', labelAlign: 'right', labelWidth: 60, width: 140, id: 'UserName_s' },
                combo_dept,
                { text: '添 加', handler: function () {
                    if (gongziPanel.getForm().findField("Id").getValue("")) {
                        showGroupUserWin().show();
                    }
                    else {
                        alert("请先选择工资所属年月!");
                    }
                }
                },
                { text: '查 询', handler: function () {
                    store_user.load();
                }
                }, { text: '删 除', handler: function () {
                    var recs = usergrid.getSelectionModel().getSelection();
                    var salaryIds = "";
                    if (recs && recs.length > 0) {
                        Ext.each(recs, function (rec) {
                            if (rec.get("Id")) {
                                salaryIds += rec.get("Id") + ",";
                            }
                        })
                        Ext.Ajax.request({
                            url: 'GongZiEdit.aspx?action=delete',
                            params: { id: formId, salaryIds: salaryIds },
                            callback: function () {
                                store_user.remove(recs);
                            }
                        });
                    }
                }
                }]
            });
            usergrid = new Ext.grid.Panel({
                store: store_user,
                tbar: tbar,
                region: 'center',
                plugins: [Ext.create('Ext.grid.plugin.CellEditing', {
                    clicksToEdit: 1,
                    listeners: { edit: function (editor, e) {
                        if (e.field != 'Remark') {
                            var oriTotal = (e.record.get("TotalSalary") ? parseFloat(e.record.get("TotalSalary")) : 0);
                            var change = parseFloat(e.value ? e.value : 0) - (e.originalValue ? parseFloat(e.originalValue) : 0);
                            e.record.set("TotalSalary", oriTotal + change);
                        }
                        var detail = Ext.encode(e.record.data);
                        Ext.Ajax.request({
                            url: 'GongZiEdit.aspx?action=update',
                            async: false, //改为同步，防止快速输入的时候同一个人产生多条记录
                            params: { id: formId, detail: detail },
                            callback: function (option, success, response) {
                                var json_t = Ext.decode(response.responseText);
                                e.record.set("Id", json_t.Id);
                                e.record.set("StageId", json_t.StageId);
                                e.record.commit();
                            }
                        })
                    }
                    }
                })],
                selModel: { selType: 'checkboxmodel', multiSelect: true },
                columns: [
                { dataIndex: 'Id', header: 'Id', hidden: true },
                { dataIndex: 'UserId', header: 'UserId', hidden: true },
                { xtype: 'rownumberer', width: 35 },
                // {dataIndex: 'SortIndex', header: '序号', width: 50 },
                {dataIndex: 'UserName', header: '姓名', width: 65 },
                { dataIndex: 'DeptName', header: '部门', width: 90 },
                { dataIndex: 'Job', header: '岗位', width: 70 },
                { dataIndex: 'JobLevel', header: '岗位等级', width: 80 },
                { dataIndex: 'GangWeiSalary', header: '岗位工资', width: 80, field: { xtype: 'numberfield', allowDecimals: 2} },
                { dataIndex: 'GongLingBuTie', header: '工(司)龄津贴', width: 100, field: { xtype: 'numberfield', allowDecimals: 2} },
                { dataIndex: 'ZhuCeBuTie', header: '注册津贴', width: 80, field: { xtype: 'numberfield', allowDecimals: 2} },
                { dataIndex: 'GangWeiBuTie', header: '岗位津贴', width: 80, field: { xtype: 'numberfield', allowDecimals: 2} },
                { dataIndex: 'TeShuBuTie', header: '特殊津贴', width: 80, field: { xtype: 'numberfield', allowDecimals: 2} },
                { dataIndex: 'XianChangBuTie', header: '现场津贴', width: 80, field: { xtype: 'numberfield', allowDecimals: 2} },
                { dataIndex: 'TotalSalary', header: '工资总额', width: 90, renderer: function (value, metadata, record, rowindex, colIndex) {
                    if (record.get("SalaryAdjustId")) {
                        rtn = "<span style='color:red'>" + value + "</span>";
                    }
                    else {
                        rtn = value;
                    }
                    return rtn;
                }
                },
                { dataIndex: 'IDNumber', header: '身份证号', width: 150 },
                { dataIndex: 'Remark', header: '备注', width: 100, field: { xtype: 'textfield'} },
                { xtype: 'actioncolumn', header: '升/降序', width: 80, items: [
                { icon: '/images/shared/arrow_up.gif', handler: function (grid, rowIndex, colIndex) {
                    if (rowIndex > 0) {
                        var up_rec = store_user.getAt(rowIndex - 1);
                        store_user.remove(up_rec);
                        store_user.insert(rowIndex, up_rec);
                    }
                    //                    Ext.Ajax.request({
                    //                        url: 'GongZiEdit.aspx?action=upsortindex',
                    //                        params: { id: formId, detail: Ext.encode(store_user.getAt(rowIndex).data) },
                    //                        callback: function (option, success, response) {
                    //                            store_user.reload();
                    //                        }
                    //                    })
                }
                }, '->', { icon: '/images/shared/arrow_down.gif', handler: function (grid, rowIndex, colIndex) {
                    if (rowIndex < store_user.data.length - 1) { //如果不是最后一条
                        var down_rec = store_user.getAt(rowIndex + 1);
                        store_user.remove(down_rec);
                        store_user.insert(rowIndex, down_rec);
                    }
                    //                    Ext.Ajax.request({
                    //                        url: 'GongZiEdit.aspx?action=downsortindex',
                    //                        params: { id: formId, detail: Ext.encode(store_user.getAt(rowIndex).data) },
                    //                        callback: function (option, success, response) {
                    //                            store_user.reload();
                    //                        }
                    //                    })
                }
                }]
                }
        ]
            })
            var viewport = new Ext.container.Viewport({
                layout: 'border',
                items: [gongziPanel, usergrid]
            })
            if (formId) {
                gongziPanel.getForm().load({
                    url: 'GongZiEdit.aspx?action=loadform',
                    params: { id: formId },
                    method: 'POST'//请求方式     
                });
            }
        })
        function GetUsers(recs) {
            var recs_temp = usergrid.getSelectionModel().getSelection();
            Ext.each(recs, function (rec) {
                if (store_user.find("UserId", rec.get("UserId")) == -1) {
                    var rec = new Salary({ UserId: rec.get("UserId"), UserName: rec.get("Name"), Job: rec.get("Job"), JobLevel: rec.get("JobLevel"),
                        IDNumber: rec.get("IDNumber"), DeptId: rec.get("Server_IAGUID"), DeptName: rec.get("Server_Seed")
                    });
                    var index = recs_temp.length > 0 ? store_user.indexOf(recs_temp[0]) : store_user.data.length;
                    store_user.insert(index, rec);
                }
            })
        }
        function levelup(rowindex) {
            Ext.Ajax.request({
                url: 'GongZiEdit.aspx?action=upsortindex',
                params: { id: formId, detail: Ext.encode(store_user.getAt(rowindex).data) },
                callback: function (option, success, response) {
                    store_user.reload();
                }
            })
        }
        function leveldown(rowindex) {
            Ext.Ajax.request({
                url: 'GongZiEdit.aspx?action=downsortindex',
                params: { id: formId, detail: Ext.encode(store_user.getAt(rowindex).data) },
                callback: function (option, success, response) {
                    store_user.reload();
                }
            })
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    </form>
</body>
</html>
