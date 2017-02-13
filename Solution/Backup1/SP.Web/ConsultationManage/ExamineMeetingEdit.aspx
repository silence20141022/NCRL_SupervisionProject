<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamineMeetingEdit.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ExamineMeetingEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var form, grid, store;
        var DistributeAmount;
        var Id = getQueryString("Id");
        Ext.onReady(function () {
            Ext.regModel("ProjectUser", { fields: ["Id", "UserId", "UserName", "Position", "Unit", "MajorName", "DistributeAmount", "DistributePercent"] });
            store = Ext.create("Ext.data.JsonStore", {
                model: "ProjectUser",
                proxy: {
                    url: "ExamineMeetingEdit.aspx",
                    extraParams: { action: "async", "ProjectId": Id },
                    type: "ajax",
                    reader: {
                        type: "json",
                        root: "rows"
                    }
                }
            });
            grid = Ext.create("Ext.grid.Panel", {
                store: store,
                height: 262,
                region: "south",
                features: [{ ftype: 'summary'}],
                selModel: { selType: "checkboxmodel" },
                plugins: [
                 Ext.create('Ext.grid.plugin.CellEditing', {
                     clicksToEdit: 1,
                     listeners: { edit: function (editor, e) {

                         var total = 0;
                         var DistributeAmount = Ext.getCmp("DistributeAmount").getValue(); //分配给专家的总金额
                         if (e.field == "DistributeAmount") {
                             Ext.each(store.getRange(), function (rec) {
                                 total += parseFloat(rec.get("DistributeAmount"));
                             });
                             if (total > DistributeAmount) {
                                 Ext.Msg.alert("提示", '分配金额已超！');
                                 e.record.set("DistributeAmount", "");
                                 e.record.set("DistributePercent", "");
                             } else {
                                 var str = parseFloat(e.value) / DistributeAmount * 100;
                                 e.record.set("DistributePercent", str.toFixed(2));
                             }
                         }
                         if (e.field == "DistributePercent") {
                             Ext.each(store.getRange(), function (rec) {
                                 total += parseFloat(rec.get("DistributePercent"));
                             });
                             if (total > 100) {
                                 Ext.Msg.alert("提示", '分配金额已超！');
                                 e.record.set("DistributePercent", "");
                                 e.record.set("DistributeAmount", "");
                             } else {
                                 var str = parseFloat(e.value) * DistributeAmount / 100;
                                 e.record.set("DistributeAmount", str.toFixed(2));
                             }
                         }
                     }
                     }
                 })
                ],
                columns: [
                { xtype: "rownumberer", width: 35 },
                { dataIndex: "Id", header: "标示", hidden: true },
                { dataIndex: "UserName", header: "姓名", width: 90, editor: { xtype: 'textfield', allowBlank: false} },
                { dataIndex: "Unit", header: "单位", flex: 1, width: 150, editor: { xtype: 'textfield', allowBlank: false} },
                { dataIndex: "MajorName", header: "专业", width: 100, editor: { xtype: 'textfield', allowBlank: false} },
                { dataIndex: "Position", header: "职务", width: 100, editor: { xtype: 'textfield', allowBlank: false} },
                { dataIndex: 'DistributeAmount', width: 100, header: '评审费(￥)'
                },
                { dataIndex: "DistributePercent", header: "分配比例(%)", width: 100, editor: { xtype: 'numberfield', allowDecimals: 2, minValue: 0, maxValue: 100, allowBlank: false }
                }]
            });

            var MeetingName = {
                xtype: "textfield",
                name: "MeetingName",
                id: "MeetingName",
                msgTarget: 'under',
                margin: "10",
                allowBlank: false,
                blankText: '会议名称不能为空',
                fieldLabel: "会议名称",
                labelAlign: "right",
                columnWidth: .5
            }
            var MeetingTime = Ext.create('Ext.form.field.Date', {
                name: "MeetingTime",
                id: "MeetingTime",
                margin: "10",
                fieldLabel: "会议时间",
                format: 'Y-m-d',
                labelAlign: "right",
                columnWidth: .5
            });
            var MeetingPlace = {
                xtype: "textfield",
                name: "MeetingPlace",
                id: "MeetingPlace",
                margin: "10",
                fieldLabel: "会议地点",
                labelAlign: "right",
                columnWidth: .5
            }


            var ContractAmount = Ext.create('Ext.form.field.Number', {
                name: "ContractAmount",
                id: "ContractAmount",
                msgTarget: 'under',
                margin: "10",
                fieldLabel: "合同金额(￥)",
                labelAlign: "right",
                minValue: 0,
                columnWidth: .5,
                listeners: { change: function (str, isValid, eOpts) {
                    if (isValid) {
                        //  Ext.getCmp("DistributeAmount").setValue();
                        Ext.getCmp("DistributePercent").setValue();
                        store.removeAll(store.getRange());
                    }
                }
                }
            });
            DistributeAmount = Ext.create("Ext.form.field.Display", {
                name: "DistributeAmount",
                id: "DistributeAmount",
                margin: "10",
                mstTarget: 'under',
                fieldLabel: "分配金额",
                labelAlign: "right",
                msgTarget: 'under',
                columnWidth: .5,
                minValue: 0
            })
            var DistributePercent = Ext.create("Ext.form.field.Number", {
                name: "DistributePercent",
                id: "DistributePercent",
                minValue: 0,
                maxValue: 100,
                margin: "10",
                msgTarget: 'under',
                fieldLabel: "分配比列(%)",
                labelAlign: "right",
                columnWidth: .5,
                listeners: { change: function (str, isValid, eOpts) {
                    var str = str.value;
                    if (isValid) {
                        var str1 = Ext.getCmp("ContractAmount").getValue();
                        var str2 = str * str1 / 100;
                        Ext.getCmp("DistributeAmount").setValue(str2.toFixed(2));
                        store.removeAll(store.getRange());
                    }
                    if (!str) {
                        Ext.getCmp("DistributeAmount").setValue();
                    }
                }
                },
                validateOnChange: true,
                validator: function (val) {
                    if (!val) {
                        return true;
                    }
                    var Amount = Ext.getCmp("ContractAmount").getValue();
                    if (!Amount) {
                        return "先填写合同金额!";
                    }
                    return true;
                }
            });

            var Remark = {
                xtype: "textarea",
                name: "Remark",
                id: "Remark",
                margin: "10",
                fieldLabel: "备注",
                labelAlign: "right",
                columnWidth: 1
            };
            var CreateTime = Ext.create('Ext.form.field.Date', {
                name: "CreateTime",
                id: "CreateTime",
                margin: "10",
                fieldLabel: "开会时间",
                labelAlign: "right",
                columnWidth: .5,
                format: 'Y-m-d'
            })
            form = Ext.create("Ext.form.Panel", {
                region: 'north',
                height: 300,
                frame: false,
                items: [
                { xtype: "textfield", name: "Id", id: "Id", hidden: true },
                { xtype: "textfield", name: "Projectid", id: "Projectid", hidden: true },
                { layout: "column", border: 0, items: [MeetingName, MeetingTime] },
                { layout: "column", border: 0, items: [MeetingPlace, ContractAmount] },
                { layout: "column", border: 0, items: [DistributeAmount, DistributePercent] },
                { layout: "column", border: 0, items: [Remark] }
                ],
                buttons: [
                    { text: "添 加", handler: function () { RowAdd(); } },
                    { text: "删 除", handler: function () {
                        var recs = grid.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert('提示', '请先选择要删除的记录！');
                            return;
                        }
                        store.remove(recs);
                    }
                    },
                    { text: "保 存", handler: function () { create(); } },
                    { text: "取 消", handler: function () { window.close(); } }
                ],
                buttonAlign: "center"
            });
            var panel = Ext.create('Ext.panel.Panel', {
                title: "评审会信息",
                region: 'center',
                layout: 'border',
                frame: true,
                items: [form, grid]
            })
            var Viewport = Ext.create("Ext.container.Viewport", {
                layout: "border",
                items: [panel]
            });
            if (Id) {
                load();
            }
        });


        function load() {
            form.getForm().load({
                url: 'ExamineMeetingEdit.aspx?action=Load&Id=' + Id,
                params: { Id: Id },
                method: 'POST', //请求方式   
                success: function (form, action) {
                    if (action.result.data.MeetingTime) {
                        var str = new Date(action.result.data.MeetingTime);
                        Ext.getCmp("MeetingTime").setValue(str);
                    }
                    Ext.getCmp("DistributePercent").setReadOnly(true);
                    Ext.getCmp("ContractAmount").setReadOnly(true);
                    store.load();
                }
            });
        }

        function RowAdd() {
            var row = store.data.length;
            var rec = new ProjectUser();
            store.insert(row, rec);
        }

        function create() {
            if (form.getForm().isValid()) {
                var json = Ext.encode(Ext.pluck(store.data.items, 'data'));
                var action = Id ? "Update" : "Create";
                var DistributeAmount = Ext.getCmp("DistributeAmount").getValue(); //分配给专家的总金额
                Ext.Ajax.request({
                    url: "ExamineMeetingEdit.aspx",
                    params: { action: action, data: Ext.encode(form.getForm().getValues()), json: json, DistributeAmount: DistributeAmount },
                    callback: function (option, success, response) {
                        if (window.opener && window.opener.store) {
                            window.opener.store.reload();
                        }
                        window.close();
                    }
                });
            }
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
