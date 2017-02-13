<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SupervisionRiZhiEdit.aspx.cs"
    Inherits="SP.Web.ProjectManage.SupervisionRiZhiEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>监理日志</title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../Extjs42/locale/ext-lang-zh_CN.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var form;
        var Id = getQueryString("Id");
        Ext.onReady(function () {
            setPage();
            if (Id) {
                load();
            };
        })
        function load() {
            form.getForm().load({
                url: 'SupervisionRiZhiEdit.aspx',
                params: { Id: Id, action: "load" },
                method: 'POST',
                success: function (form, action) {
                    if (action.result.data.SupervisionDate) {
                        var str = new Date(action.result.data.SupervisionDate);
                        Ext.getCmp("SupervisionDate").setValue(str);
                    }
                }
            });
        }
        function setPage() {
            var ProjectNameStore = Ext.create("Ext.data.JsonStore", {
                fields: ["ProjectName", "ProjectId", "PManagerId", "PManagerName"],
                proxy: {
                    url: "SupervisionRiZhiEdit.aspx?action=loadprj",
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
                blankText: "项目名称不能为空",
                msgTarget: "under",
                store: ProjectNameStore,
                displayField: 'ProjectName',
                valueField: 'ProjectName',
                labelAlign: 'right',
                hideTrigger: true,
                minChars: 1,
                fieldLabel: '项目名称',
                margin: "3",
                columnWidth: .5,
                listeners: {
                    select: function (combo, records, eOpts) {
                        Ext.getCmp("PManagerName").setValue(records[0].data.PManagerName);
                        Ext.getCmp("ProjectId").setValue(records[0].data.ProjectId);
                        Ext.getCmp("PManagerId").setValue(records[0].data.PManagerId);
                    }
                }
            })

            var ShiGongUnit = {
                xtype: 'textfield',
                id: 'ShiGongUnit',
                name: 'ShiGongUnit',
                labelAlign: 'right',
                margin: "3",
                columnWidth: .5,
                fieldLabel: '施工单位'
            };

            var PManagerName = {
                xtype: 'textfield',
                id: 'PManagerName',
                name: 'PManagerName',
                labelAlign: 'right',
                margin: "3",
                columnWidth: .5,
                fieldLabel: '项目总监'
            };

            var SupervisionDate = {
                xtype: 'datefield',
                id: 'SupervisionDate',
                name: 'SupervisionDate',
                format: 'Y-m-d',
                labelAlign: 'right',
                margin: "3",
                columnWidth: .5,
                fieldLabel: '监理日期'
            };

            var Weather = {
                xtype: 'textfield',
                id: 'Weather',
                name: 'Weather',
                labelAlign: 'right',
                margin: "3",
                columnWidth: .5,
                fieldLabel: '天气'
            };

            var WorkRecord = {
                xtype: 'htmleditor',
                id: "WorkRecord",
                name: 'WorkRecord',
                labelAlign: 'right',
                margin: "3",
                height: 100,
                columnWidth: 1,
                enableFont: false,
                fieldLabel: '主要工作'
            }

            var SafetySupervision = {
                xtype: 'htmleditor',
                id: "SafetySupervision",
                name: 'SafetySupervision',
                labelAlign: 'right',
                margin: "3",
                height: 100,
                columnWidth: 1,
                enableFont: false,
                fieldLabel: '安全监理'
            }

            var NextArrange = {
                xtype: 'htmleditor',
                id: "NextArrange",
                name: 'NextArrange',
                labelAlign: 'right',
                margin: "3",
                height: 100,
                columnWidth: 1,
                enableFont: false,
                fieldLabel: '下一步工作安排'
            }

            var PManagerOpinion = {
                xtype: 'htmleditor',
                id: "PManagerOpinion",
                name: 'PManagerOpinion',
                labelAlign: 'right',
                margin: "3",
                height: 100,
                columnWidth: 1,
                enableFont: false,
                fieldLabel: '总监阅示'
            }

            form = Ext.create("Ext.form.Panel", {
                region: 'center',
                frame: true,
                layout: 'form',
                title: '监理日志',
                items: [
                 { xtype: "textfield", name: "Id", id: "Id", hidden: true },
                 { xtype: "textfield", name: "ProjectId", id: "ProjectId", hidden: true },
                 { xtype: "textfield", name: "PManagerId", id: "PManagerId", hidden: true },
                 { layout: "column", border: 0, items: [ProjectName, ShiGongUnit] },
                 { layout: "column", border: 0, items: [PManagerName, SupervisionDate] },
                 { layout: "column", border: 0, items: [Weather] },
                 { layout: "column", border: 0, items: [WorkRecord] },
                 { layout: "column", border: 0, items: [SafetySupervision] },
                 { layout: "column", border: 0, items: [NextArrange] },
                 { layout: "column", border: 0, items: [PManagerOpinion] }
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
                    url: "SupervisionRiZhiEdit.aspx",
                    async: false,
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
