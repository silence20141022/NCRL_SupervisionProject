<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkLianXi_Edit.aspx.cs"
    Inherits="SP.Web.ConsultationManage.WorkLianXi_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script src="groupuser.js" type="text/javascript"></script>
    <script type="text/javascript">
        var form;
        var id = getQueryString("id");
        Ext.onReady(function () {
            var store_jinjidegree = Ext.create('Ext.data.JsonStore', {
                fields: ['name'],
                data: [{ name: '一般' }, { name: '重要' }, { name: '紧急'}]
            })
            var combo_jinjidegree = Ext.create('Ext.form.field.ComboBox', {
                store: store_jinjidegree,
                valueField: 'name',
                displayField: 'name',
                queryMode: 'local',
                fieldLabel: '紧急程度',
                labelAlign: 'right',
                margin: 10
            })
            var field_attachment = Ext.create('Ext.form.field.File', {
                name: 'projectfile',
                fieldLabel: '附件',
                margin: '10',
                labelAlign: 'right',
                buttonText: '浏览..',
                anchor: '90%'
            })
            var workContent = Ext.create("Ext.form.HtmlEditor", {
                fieldLabel: " 工作内容",
                allowBlank: false,
                blankText: "工作内容不能为空!",
                msgTarget: "under",
                name: "WorkContent",
                height: 180,
                margin: '10',
                enableFont: false,
                labelAlign: "right",
                anchor: '90%'
            });
            var form = Ext.create('Ext.form.Panel', {
                title: "工作联系",
                region: 'center',
                autoScroll: true,
                items: [
                { xtype: "textfield", name: "Id", id: "Id", hidden: true },
                { xtype: "textfield", name: "SendUserId", hidden: true },
                { xtype: 'textfield', name: 'ReceiveUserIds', hidden: true, id: 'ReceiveUserIds' },
                { xtype: 'textfield', name: 'ReceiveUserIds', hidden: true, id: 'ChaoSongUserIds' },
                { xtype: 'textfield', fieldLabel: '标题', margin: 10, anchor: '90%', labelAlign: 'right', name: 'Title', allowBlank: false, msgTarget: 'under', blankText: '标题不能为空' },
                { xtype: 'textfield', fieldLabel: '发送人', margin: 10, labelAlign: 'right', readOnly: true, name: 'SendUserName' },
                combo_jinjidegree,
                { xtype: 'textfield', fieldLabel: '接收人', anchor: '90%', labelAlign: 'right', readOnly: true, margin: '10',
                    name: 'ReceiveUserNames', id: 'ReceiveUserNames', listeners: { focus: function () {
                        showGroupUserWin().show();
                    }
                    }
                },
                { xtype: 'textfield', fieldLabel: '抄送人', anchor: '90%', labelAlign: 'right', readOnly: true, margin: '10', name: 'ReceiveUserNames', id: 'ChaoSongUserNames' },
                { xtype: 'datefield', margin: '10', fieldLabel: '要求完成时间', labelAlign: 'right', name: 'YaoQiuFinishTime', format: 'Y-m-d' },
                field_attachment, workContent
                ],
                buttons: [
                { text: '保 存', handler: function () {
                    if (form.getForm().isValid()) {
                        var json = Ext.encode(form.getForm().getValues());
                        Ext.Ajax.request({
                            url: "WorkLianXi_Edit.aspx",
                            params: { action: id ? 'update' : 'create', json: json },
                            success: function (option, success, response) {
                                window.close();
                            }
                        });
                    }
                }
                },
                { text: '关 闭 ', handler: function () { window.close(); } }
                ],
                buttonAlign: 'center'
            });
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [form]
            })
            if (id) {
                form.getForm().load({
                    url: "ExamineOpinionEdit.aspx",
                    params: { action: "load", ExamineTaskId: ExamineTaskId },
                    method: "POST",
                    success: function (form, action) {
                        if (action.result.data.StartTime) {
                            var str = new Date(action.result.data.StartTime);
                            Ext.getCmp("StartTime").setValue(str);
                        }
                    }
                });
            }
        });
        function GetUsers(recs) {
            var receiveUserIds = '';
            var receiveUserNames = '';
            Ext.each(recs, function (rec) {
                receiveUserIds += rec.get("UserId") + ",";
                receiveUserNames += rec.get("Name") + ",";
                Ext.getCmp('ReceiveUserIds').setValue(receiveUserIds);
                Ext.getCmp('ReceiveUserNames').setValue(receiveUserNames);
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
