<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupervisionJianBaoEdit.aspx.cs"
    Inherits="SP.Web.ProjectManage.SupervisionJianBaoEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>监理简报</title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var form;
        var Id = getQueryString("Id");
        Ext.onReady(function () {
            setPage();
            if (Id) {
                form.getForm().load({
                    url: 'SupervisionJianBaoEdit.aspx',
                    params: { Id: Id, action: "Load" },
                    method: 'POST',
                    success: function (form, action) {
                    }
                });
            }
        })
        function setPage() {
            var ProjectNameStore = Ext.create("Ext.data.JsonStore", {
                fields: ["ProjectName", "ProjectId", "PManagerId", "PManagerName"],
                proxy: {
                    url: "SupervisionJianBaoEdit.aspx?action=PNameCombo",
                    type: "ajax",
                    reader: {
                        type: "json",
                        root: "rows"
                    }
                }
            });

            var ProjectName = Ext.create("Ext.form.ComboBox", {
                id: 'ProjectName',
                name: 'ProjectName',
                emptyText: '请选择项目...',
                queryParam: 'name',
                allowBlank: false,
                blankText: "不能为空",
                msgTarget: "under",
                store: ProjectNameStore,
                displayField: 'ProjectName',
                valueField: 'ProjectName',
                labelAlign: 'right',
                hideTrigger: true,
                minChars: 1,
                fieldLabel: '项目名称',
                margin: "7",
                columnWidth: .5,
                listeners: {
                    select: function (combo, records, eOpts) {
                        Ext.getCmp("PManagerName").setValue(records[0].data.PManagerName);
                        Ext.getCmp("ProjectId").setValue(records[0].data.ProjectId);
                        Ext.getCmp("PManagerId").setValue(records[0].data.PManagerId);
                    }
                }
            })

            var Yearstore = Ext.create("Ext.data.Store", {
                fields: ['year'],
                data: [
                    { "year": "2013" }, { "year": "2014" }, { "year": "2015" }, { "year": "2016" }, { "year": "2017" }, { "year": "2018" }, { "year": "2019" }
                ]
            });

            var Year = {
                xtype: 'combobox',
                id: 'Year',
                name: 'Year',
                emptyText: '请选择...',
                queryMode: 'local',
                store: Yearstore,
                margin: "7",
                labelAlign: 'right',
                fieldLabel: '年',
                displayField: 'year',
                valueField: 'year',
                columnWidth: .5
            };

            var Monthstore = Ext.create("Ext.data.Store", {
                fields: ['month'],
                data: [
                    { "month": "1" }, { "month": "2" }, { "month": "3" }, { "month": "4" },
                    { "month": "5" }, { "month": "6" }, { "month": "7" }, { "month": "8" },
                    { "month": "9" }, { "month": "10" }, { "month": "11" }, { "month": "12" }
                ]
            });

            var Month = {
                xtype: 'combobox',
                id: 'Month',
                margin: "7",
                name: 'Month',
                emptyText: '请选择...',
                queryMode: 'local',
                store: Monthstore,
                labelAlign: 'right',
                fieldLabel: '月',
                columnWidth: .5,
                displayField: 'month',
                valueField: 'month'
            };

            var ShiGongUnit = {
                xtype: 'textfield',
                columnWidth: .5,
                margin: "7",
                id: 'ShiGongUnit',
                name: 'ShiGongUnit',
                labelAlign: 'right',
                fieldLabel: '施工单位'
            };

            var PManagerName = {
                xtype: 'textfield',
                readOnly: true,
                id: 'PManagerName',
                name: 'PManagerName',
                margin: "7",
                labelAlign: 'right',
                fieldLabel: '项目总监',
                columnWidth: .5
            };

            var WorkRecord = {
                xtype: 'htmleditor',
                id: "WorkRecord",
                name: 'WorkRecord',
                height: 150,
                labelAlign: 'right',
                margin: "7",
                enableFont: false,
                fieldLabel: '工作记录',
                columnWidth: 1
            }
            form = new Ext.form.Panel({
                region: 'center',
                frame: true,
                layout: 'form',
                title: '监理简报',
                items: [
                { xtype: "textfield", name: "Id", id: "Id", hidden: true },
                { xtype: "textfield", name: "PManagerId", id: "PManagerId", hidden: true },
                { xtype: "textfield", name: "ProjectId", id: "ProjectId", hidden: true },
                { xtype: "textfield", name: "FileId", id: "FileId", hidden: true },
                { layout: "column", border: 0, items: [ProjectName, PManagerName] },
                { layout: "column", border: 0, items: [Year, Month] },
                { layout: "column", border: 0, items: [ShiGongUnit] },
                { layout: "column", border: 0, items: [WorkRecord] }
                 ],
                buttonAlign: "center",
                buttons: [
                     { xtype: 'button', id: "confirm", text: '保 存', handler: create },
                     { xtype: 'button', id: "cancle", text: '取 消', handler: function () { window.close() } }
                ]
            });

            var viewport = new Ext.container.Viewport({
                layout: 'border',
                items: [form]
            });
        }
        function create() {
            if (form.getForm().isValid()) {
                var data = form.getForm().getValues();
                var json = Ext.encode(data);
                var action = Id ? "update" : "create";
                Ext.Ajax.request({
                    url: "SupervisionJianBaoEdit.aspx",
                    params: { action: action, obj: json },
                    callback: function (option, success, response) {
                        window.opener.store.load();
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
