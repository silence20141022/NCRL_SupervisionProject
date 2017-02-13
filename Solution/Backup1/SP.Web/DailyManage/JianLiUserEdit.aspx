<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JianLiUserEdit.aspx.cs"
    Inherits="SP.Web.DailyManage.JianLiUserEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../Extjs42/TreePicker.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <title></title>
    <script type="text/javascript">
        var formpanel;
        var combo_GroupId;
        var UserId = getQueryString("UserId");
        Ext.onReady(function () {
            var field_Name = Ext.create('Ext.form.field.Text', {
                xtype: 'textfield',
                name: 'Name',
                allowBlank: false,
                margin: '10',
                columnWidth: .5,
                fieldLabel: '姓名',
                labelAlign: 'right',
                msgTarget: 'under',
                emptyText: '请输入姓名',
                blankText: '姓名不能为空!'
            });
            Ext.regModel('UserType', { fields: ['name'] });
            var data_UserType = { UserType: [{ name: '返聘' }, { name: '派遣' }, { name: '正式'}] };
            var store_combo = Ext.create('Ext.data.JsonStore', {
                model: 'UserType',
                proxy: {
                    type: 'memory',
                    data: data_UserType,
                    reader: {
                        root: 'UserType',
                        type: 'json'
                    }
                }
            })
            var combo_UserType = Ext.create('Ext.form.field.ComboBox', {
                name: 'UserType',
                store: store_combo,
                emptyText: "请选择",
                displayField: 'name',
                valueField: 'name',
                margin: '10',
                editable: false,
                columnWidth: .5,
                fieldLabel: '人员类型',
                labelAlign: 'right',
                triggerAction: 'all'
            });
            var store_status = Ext.create('Ext.data.JsonStore', {
                fields: ['id', 'name'],
                data: [{ id: 1, name: '启用' }, { id: 0, name: '停用'}]
            })
            var combo_status = Ext.create('Ext.form.field.ComboBox', {
                name: 'Status',
                value: 1,
                editable: false,
                store: store_status,
                fieldLabel: '状态',
                displayField: 'name',
                valueField: 'id',
                margin: 10,
                columnWidth: .5,
                labelAlign: 'right',
                queryMode: 'local'
            })
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
            combo_GroupId = {
                name: 'Server_IAGUID',
                fieldLabel: '所属部门',
                allowBlank: false,
                emptyText: '请选择所属部门',
                blankText: '所属部门为必选项!',
                msgTarget: 'under',
                labelAlign: 'right',
                xtype: 'treepicker',
                valueField: 'id',
                displayField: 'text',
                forceSelection: true,
                editable: false,
                margin: '10',
                columnWidth: .5,
                // minPickerHeight: 200,select( picker, record, eOpts )
                //anchor: "50%",
                store: store_group,
                listeners: { select: function (picker, record, eOpts) {
                    Ext.getCmp("Server_Seed").setValue(record.get("text"));
                    //formpanel.getForm().findField("FirstTypeId").setValue(record.get("parentid"));
                }
                }
            }
            var field_loginname = Ext.create('Ext.form.field.Display', {
                fieldLabel: '登录账号',
                labelAlign: 'right',
                name: 'LoginName',
                id: "LoginName",
                columnWidth: .5,
                margin: '10',
                readOnly: true
            })
            var field_Email = Ext.create('Ext.form.field.Text', {
                fieldLabel: '邮箱',
                labelAlign: 'right',
                name: 'Email',
                msgTarget: 'under',
                margin: '10',
                vtype: 'email',
                vtypeText: 'Email格式不正确',
                msgTarget: 'under',
                columnWidth: .5
            });
            var field_Job = Ext.create('Ext.form.field.Text', {
                fieldLabel: '岗位',
                labelAlign: 'right',
                name: 'Job',
                columnWidth: .5,
                margin: '10'
            })
            var field_JobLevel = Ext.create('Ext.form.field.Text', {
                fieldLabel: '岗位等级',
                labelAlign: 'right',
                name: 'Joblevel',
                columnWidth: .5,
                margin: '10'
            })
            var field_IDNumber = Ext.create('Ext.form.field.Text', {
                fieldLabel: '身份证号',
                labelAlign: 'right',
                name: 'IDNumber',
                msgTarget: 'under',
                allowBlank: false,
                blankText: '身份证号不能为空',
                regex: /\d{15}|\d{18}/,
                regexText: '请输入正确的身份号码',
                columnWidth: .5,
                margin: '10'
            })
            var field_RegistrationNo = Ext.create('Ext.form.field.Text', {
                fieldLabel: '注册号',
                labelAlign: 'right',
                name: 'RegistrationNo',
                columnWidth: .5,
                margin: '10'
            })
            var field_CreateDate = Ext.create('Ext.form.field.Date', {
                fieldLabel: '入职日期',
                labelAlign: 'right',
                format: 'Y-m-d',
                name: 'CreateDate',
                id: "CreateDate",
                margin: '10',
                columnWidth: .5
            })
            var field_Remark = Ext.create('Ext.form.field.TextArea', {
                fieldLabel: '备注',
                labelAlign: 'right',
                name: 'Remark',
                height: 45,
                margin: '10',
                anchor: '100%'
            })
            formpanel = Ext.create('Ext.form.Panel', {
                title: '人员信息',
                region: 'center',
                items: [
                //第1行
                {layout: 'column', border: 0, items: [field_Name, combo_UserType] },
                //第2行
                {layout: 'column', border: 0, items: [combo_GroupId, field_Email] },
                //第3行
                {layout: 'column', border: 0, items: [field_Job, field_JobLevel] },
                //第4行
                {layout: 'column', border: 0, items: [field_IDNumber, field_RegistrationNo] },
                //第5行
                {layout: 'column', border: 0, items: [field_loginname, field_CreateDate] },
                { layout: 'column', border: 0, items: [combo_status,
                { xtype: 'textfield', margin: 10, columnWidth: .5, fieldLabel: '移动电话', name: 'Phone', labelAlign: 'right'}]
                },
                { layout: 'column', border: 0, items: [
                { xtype: 'textfield', margin: 10, columnWidth: .5, fieldLabel: '固定电话', labelAlign: 'right', name: 'HomePhone'}]
                },
                field_Remark,
                { xtype: 'label', text: '说明：工号字段不允许编辑,员工信息进入NISM后工号等其他信息会自动同步过来', style: 'color:blue', margin: '0 0 0 110' },
                { xtype: 'textfield', hidden: true, name: 'UserID' },
                { xtype: 'textfield', hidden: true, id: "Server_Seed", name: 'Server_Seed' }
            ],
                buttons: [
                { text: '保 存', handler: function () {
                    if (formpanel.getForm().isValid()) {
                        var action = UserId ? "Update" : "Create";
                        var str = formpanel.getForm().getValues();
                        Ext.Ajax.request({
                            url: "JianLiUserEdit.aspx",
                            params: { action: action, json: Ext.encode(str) },
                            success: function (option, success, response) {
                                Ext.MessageBox.alert('提示', '保存成功！', function () {
                                    if (window.opener && window.opener.store_user) {
                                        window.opener.store_user.load();
                                    }
                                    window.close();
                                });
                            }
                        });
                    }
                }
                },
                { text: '取 消', handler: function () { window.close(); } }
                ],
                buttonAlign: 'center'
            });
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [formpanel]
            })
            if (UserId) {
                formpanel.getForm().load({
                    url: "JianLiUserEdit.aspx",
                    params: { action: "SelectEdit", UserId: UserId },
                    method: "POST",
                    success: function (form, action) {
                        if (action.result.data.CreateDate) {
                            var str = new Date(action.result.data.CreateDate);
                            Ext.getCmp("CreateDate").setValue(str);
                        }
                    }
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
