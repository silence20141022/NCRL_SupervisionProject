<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssignedTasks.aspx.cs"
    Inherits="SP.Web.ConsultationManage.AssignedTasks" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>下达任务</title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var store, grid, form;
        var Id = getQueryString("Id");
        Ext.onReady(function () {
            Ext.regModel("task", { fields: ["Id", "UserId", "UserName", "MajorName", "Phone", "Email", "QianZhangName", "ShenHeName"] });
            store = Ext.create("Ext.data.JsonStore", {
                model: "task",
                proxy: {
                    url: "AssignedTasks.aspx",
                    extraParams: { action: "async", Id: Id },
                    type: "ajax",
                    reader: {
                        type: "json",
                        root: "rows"
                    }
                },
                autoLoad: true
            })
            grid = Ext.create("Ext.grid.Panel", {
                title: "",
                store: store,
                hieght: 300,
                region: "center",
                columns: [
                    { xtype: "rownumberer", width: 30 },
                    { dataIndex: "Id", header: "标示", hidden: true },
                    { dataIndex: "UserId", header: "标示", hidden: true },
                    { dataIndex: "UserName", header: "姓名", width: 70 },
                    { dataIndex: "MajorName", header: "专业", width: 90 },
                    { dataIndex: "Phone", header: "联系电话", width: 120 },
                    { dataIndex: "Email", header: "电子邮箱", flex: 1 }
                //  { dataIndex: "QianZhangName", header: "签章专家", width: 100 },
                // { dataIndex: "ShenHeName", header: "审核专家", width: 100 }
                ]
            });
            var ProjectName = Ext.create("Ext.form.field.Display", {
                fieldLabel: "项目名称",
                margin: "10",
                columnWidth: .5,
                labelAlign: "right",
                name: "ProjectName",
                id: "ProjectName"
            });
            var SheJiUnit = Ext.create("Ext.form.field.Display", {
                fieldLabel: "设计单位",
                margin: "10",
                columnWidth: .5,
                labelAlign: "right",
                name: "SheJiUnit",
                id: "SheJiUnit"
            });
            var JianSheUnit = Ext.create("Ext.form.field.Display", {
                fieldLabel: "建设单位",
                margin: "10",
                columnWidth: .5,
                labelAlign: "right",
                name: "JianSheUnit",
                id: "JianSheUnit"
            });
            var KanChaUnit = Ext.create("Ext.form.field.Display", {
                fieldLabel: "勘察单位",
                margin: "10",
                columnWidth: .5,
                labelAlign: "right",
                name: "KanChaUnit",
                id: "KanChaUnit"
            });
            var ProjectType = Ext.create("Ext.form.field.Display", {
                fieldLabel: "项目类型",
                margin: "10",
                columnWidth: .5,
                labelAlign: "right",
                name: "ProjectType",
                id: "ProjectType"
            });
            var PlaneEndTime = Ext.create("Ext.form.field.Date", {
                fieldLabel: "反馈时间",
                margin: "10",
                allowBlank: false,
                blankText: "反馈时间不能为空",
                msgTarget: "under",
                columnWidth: .5,
                format: 'Y-m-d',
                labelAlign: "right",
                name: "PlaneEndTime",
                id: "PlaneEndTime"
            });

            form = Ext.create("Ext.form.Panel", {
                region: "north",
                height: 220,
                frame: false,
                items: [
                    { xtype: "textfield", name: "Id", id: "Id", hidden: true },
                    { layout: "column", border: 0, items: [ProjectName, SheJiUnit, ] },
                    { layout: "column", border: 0, items: [JianSheUnit, KanChaUnit, ] },
                    { layout: "column", border: 0, items: [ProjectType, PlaneEndTime, ] }
                ],
                buttons: [
                    { text: "确 定", handler: function () { create(); } },
                    { text: "取 消", handler: function () { window.close(); } }
                ],
                buttonAlign: "center"
            })

            var viewport = Ext.create("Ext.container.Viewport", {
                layout: "border",
                items: [form, grid]
            });
            if (Id) {
                load();
            }
        });

        function load() {
            form.getForm().load({
                url: "AssignedTasks.aspx",
                params: { action: "Load", Id: Id },
                method: "POST",
                success: function (form, action) {
                    store.load();
                }
            });
        }
        function create() {
            if (form.getForm().isValid()) {
                var BackTime = Ext.getCmp("PlaneEndTime").getValue();
                var Id = Ext.getCmp("Id").getValue();
                Ext.Ajax.request({
                    url: "AssignedTasks.aspx",
                    async: false,
                    params: { action: "create", BackTime: BackTime, Id: Id },
                    callback: function (option, success, respones) {
                        if (window.opener && window.opener.store1) {
                            window.opener.store1.load();
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
