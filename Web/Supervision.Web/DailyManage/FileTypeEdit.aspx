<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FileTypeEdit.aspx.cs" Inherits="SP.Web.DailyManage.FileTypeEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <title></title>
    <script type="text/javascript">
        var parentid = getQueryString("ParentID");
        var SysEnumerationId = getQueryString("SysEnumerationId");
        Ext.onReady(function () {
            var formpanel = Ext.create('Ext.form.Panel', {
                layout: 'anchor',
                region: 'center',
                frame: true,
                title: '文件类型',
                defaults: { labelAlign: 'right', xtype: 'textfield', msgTarget: 'under', margin: '10' },
                items: [
                { name: 'Code', anchor: '70%', fieldLabel: '类型编码', allowBlank: false, blankText: '类型编码不能为空', emptyText: '请输入类型编码' },
                { name: 'Name', anchor: '70%', fieldLabel: '类型名称', allowBlank: false, blankText: '类型名称不能为空', emptyText: '请输入类型名称' },
                { name: 'SortIndex', anchor: '70%', fieldLabel: '序号', xtype: 'numberfield' },
                { name: 'Description', anchor: '100%', fieldLabel: '描述', xtype: 'textareafield' },
                { name: 'EnumerationID', xtype: 'hidden' },
                { name: 'ParentID', xtype: 'hidden' }
               ],
                buttons: [{ text: '保 存', handler: function () {
                    var baseForm = formpanel.getForm();
                    if (baseForm.isValid()) {
                        var action = baseForm.findField("EnumerationID").getValue() ? "update" : "create";
                        Ext.Ajax.request({
                            url: "FileTypeEdit.aspx",
                            params: { action: action, json: Ext.encode(baseForm.getValues()) },
                            callback: function (option, success, response) {
                                window.opener.location.href = "FileType.aspx";
                                Ext.Msg.alert("提示", "保存成功!", function () {
                                    var rec = window.opener.treepanelstore.getNodeById(parentid);
                                    window.opener.treepanel.expandNode(rec);
                                    window.close();
                                });
                            }
                        });
                    }
                }
                }],
                buttonAlign: 'center'
            })
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [formpanel]
            })
            if (parentid) {
                formpanel.getForm().findField("ParentID").setValue(parentid);
            }
            if (SysEnumerationId) {
                formpanel.getForm().load({
                    url: 'FileTypeEdit.aspx?action=loadformdata&id=' + SysEnumerationId,
                    success: function (action, s) {
                    },
                    method: 'GET'
                });
            }
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
