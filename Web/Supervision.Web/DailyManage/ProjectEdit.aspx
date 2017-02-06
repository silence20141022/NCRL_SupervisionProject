<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectEdit.aspx.cs" Inherits="SP.Web.DailyManage.ProjectEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../Extjs42/TreePicker.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script src="groupuser.js" type="text/javascript"></script>
    <script type="text/javascript">
        Ext.onReady(SetPage);
        var formpanel;
        var Id = getQueryString("Id");
        function SetPage() {
            var ProjectName = {
                xtype: "textfield",
                name: "ProjectName",
                fieldLabel: '项目名称',
                readOnly: true,
                anchor: '70%'
            }
            var store_group = Ext.create('Ext.data.TreeStore', {
                fields: ['id', 'text', 'leaf'],
                root: {
                    text: '江西瑞林建设监理有限公司',
                    id: '228',
                    expanded: true
                },
                proxy: {
                    type: 'ajax',
                    url: 'JianLiUserEdit.aspx?action=loadgroupdata',
                    reader: { type: 'json' }
                },
                nodeParam: 'id'
            })
            var combo_BelongDeptId = {
                name: 'BelongDeptId',
                fieldLabel: '所属部门',
                xtype: 'treepicker',
                valueField: 'id',
                displayField: 'text',
                forceSelection: true,
                editable: false,
                store: store_group,
                anchor: '70%',
                listeners: { select: function (picker, record, eOpts) {
                    Ext.getCmp("BelongDeptName").setValue(record.get("text"));
                }
                }
            }
            var PManagerName = {
                xtype: "textfield",
                name: "PManagerName",
                fieldLabel: '项目总监',
                allowBlank: false,
                blankText: '请选择人员',
                allowBlank: false,
                blankText: '项目总监不能为空',
                msgTarget: 'side',
                listeners: {
                    focus: function () {
                        var win = showGroupUserWin();
                        win.show();
                    }
                }
            }
            var ProjectCode = {
                xtype: "textfield",
                name: "ProjectCode",
                fieldLabel: '项目编码',
                readOnly: true
            }
            var Remark = {
                xtype: "textarea",
                name: "Remark",
                fieldLabel: '工程概况',
                msgTarget: 'under',
                height: 85,
                anchor: '70%'
            }
            formpanel = Ext.create("Ext.form.Panel", {
                title: '项目管理',
                region: 'center',
                defaults: { labelAlign: 'right', margin: 10 },
                items: [ProjectCode, ProjectName,
                        combo_BelongDeptId, PManagerName,
                        Remark,
                        { xtype: 'textfield', name: 'Id', hidden: true },
                        { xtype: 'textfield', name: 'BelongDeptName', id: 'BelongDeptName', hidden: true }
                        ],
                buttons: [
                        { text: "确定", handler: function () {
                            var formjson = formpanel.getForm().getValues();
                            Ext.Ajax.request({
                                url: 'ProjectEdit.aspx?action=Update',
                                params: { formdata: Ext.encode(formjson) },
                                success: function () {
                                    Ext.MessageBox.alert('提示', '保存成功!', function () {
                                        if (window.opener && window.opener.store_project) {
                                            window.opener.store_project.load();
                                        }
                                        window.close();
                                    })
                                }
                            })
                        }
                        }
                        ],
                buttonAlign: 'center'
            });
            var viewport = Ext.create("Ext.container.Viewport", {
                layout: "border",
                items: [formpanel]
            });
            if (Id) {
                formpanel.getForm().load({
                    url: 'ProjectEdit.aspx?action=LoadFormData',
                    params: { Id: Id },
                    method: 'POST'
                });
            }
        }
        function GetUsers(rec) {
            formpanel.getForm().findField('PManagerName').setValue(rec[0].get("Name"));
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
