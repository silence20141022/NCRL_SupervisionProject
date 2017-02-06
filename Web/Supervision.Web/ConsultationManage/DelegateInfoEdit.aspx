<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DelegateInfoEdit.aspx.cs"
    Inherits="SP.Web.ConsultationManage.DelegateInfoEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var panel;
        var Id = getQueryString("Id");
        Ext.onReady(SetPage);
        function SetPage() {

            var DelegateName = {
                xtype: "textfield",
                name: "DelegateName",
                id: "DelegateName",
                allowBlank: false,
                blankText: "窗口名称不能为空",
                fieldLabel: "窗口名称",
                labelWidth: 100,
                labelAlign: "right",
                autoFitErrors: true,
                msgTarget: 'under'
            }
            var DelegateHead = {
                xtype: "textfield",
                name: "DelegateHead",
                id: "DelegateHead",
                fieldLabel: "联系人",
                labelWidth: 100,
                labelAlign: "right"
            }
            var DelegateCode = {
                xtype: "textfield",
                name: "DelegateCode",
                id: "DelegateCode",
                fieldLabel: "窗口编号",
                labelWidth: 100,
                labelAlign: "right"
            }
            var Telephone = {
                xtype: "textfield",
                name: "Telephone",
                id: "Telephone",
                fieldLabel: "联系电话",
                labelWidth: 100,
                labelAlign: "right",
                maxLength: 11,
                enforceMaxLength: true,
                maskRe: /\d/
            }
            var Email = {
                xtype: "textfield",
                name: "Email",
                id: "Email",
                vtype: "email",
                vtypeText: 'Email格式不正确',
                fieldLabel: "电子邮箱",
                labelWidth: 100,
                labelAlign: "right",
                autoFitErrors: true,
                msgTarget: 'under'
            }
            var DengJiBenNo = Ext.create('Ext.form.field.Text', {
                fieldLabel: '登记本序号',
                labelWidth: 100,
                name: 'DengJiBenNo',
                labelAlign: "right"
            })
            var Address = {
                xtype: "textfield",
                name: "Address",
                id: "Address",
                fieldLabel: "邮寄地址",
                margin: '10',
                labelWidth: 100,
                labelAlign: "right",
                anchor: '90%'
            }
            var Remark = {
                xtype: "textareafield",
                name: "Remark",
                id: "Remark",
                fieldLabel: "备注",
                height: 120,
                margin: '10',
                labelWidth: 100,
                labelAlign: "right",
                anchor: '90%'
            }
            panel = Ext.create("Ext.form.Panel", {
                title: '窗口信息',
                region: 'center',
                frame: true,
                items: [
                { layout: 'column', bodyStyle: 'border:0', margin: '10',
                    items: [
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [DelegateName] },
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [DelegateCode] }
                ]
                },
                { layout: 'column', bodyStyle: 'border:0', margin: '10',
                    items: [
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [DelegateHead] },
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [Telephone] }
                ]
                },
                { layout: 'column', bodyStyle: 'border:0', margin: '10',
                    items: [
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [Email] },
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [DengJiBenNo] }
                ]
                },
                Address, Remark,
              { xtype: 'textfield', name: 'Id', hidden: true }
        ],
                buttonAlign: "center",
                buttons: [{ text: '确 定', handler: create
                }, { text: '取 消', handler: function () {
                    window.close();
                }
                }]
            });
            var viewport = Ext.create("Ext.container.Viewport", {
                layout: "border",
                items: [panel]
            });
            update();
        }
        function create() {
            if (panel.getForm().isValid()) {
                var action = Id ? "Update" : "Create";
                var str = panel.getForm().getValues();
                var json = Ext.encode(str);
                Ext.Ajax.request({
                    url: "DelegateInfoEdit.aspx",
                    async: false,
                    params: { action: action, json: json, Id: Id },
                    callback: function (option, success, response) {
                        window.opener.store.load();
                        window.close();
                    }
                });
            }
        }
        function update() {
            if (Id) {
                panel.getForm().load({
                    url: 'DelegateInfoEdit.aspx',
                    params: { Id: Id, action: "SelectEdit" },
                    method: 'POST', //请求方式      
                    success: function (form, action) {
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
