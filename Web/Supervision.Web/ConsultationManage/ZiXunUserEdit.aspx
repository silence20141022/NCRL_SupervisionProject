<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZiXunUserEdit.aspx.cs"
    Inherits="SP.Web.ZiXunUserEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
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
            //            var store_group = Ext.create('Ext.data.TreeStore', {
            //                fields: ['id', 'text', 'leaf'],
            //                root: {
            //                    text: '江西瑞林建设监理有限公司',
            //                    id: '228',
            //                    expanded: true
            //                },
            //                proxy: {
            //                    type: 'ajax',
            //                    url: 'JianLiUserEdit.aspx?action=loadgroupdata',
            //                    reader: { type: 'json' }
            //                },
            //                nodeParam: 'id'
            //            })
            //            combo_GroupId = {
            //                name: 'Server_IAGUID',
            //                fieldLabel: '所属部门',
            //                allowBlank: false,
            //                emptyText: '请选择所属部门',
            //                blankText: '所属部门为必选项!',
            //                msgTarget: 'under',
            //                labelAlign: 'right',
            //                xtype: 'treepicker',
            //                valueField: 'id',
            //                displayField: 'text',
            //                forceSelection: true,
            //                editable: false,
            //                margin: '10',
            //                columnWidth: .5,
            //                // minPickerHeight: 200,select( picker, record, eOpts )
            //                //anchor: "50%",
            //                store: store_group,
            //                listeners: { select: function (picker, record, eOpts) {
            //                    Ext.getCmp("Server_Seed").setValue(record.get("text"));
            //                    //formpanel.getForm().findField("FirstTypeId").setValue(record.get("parentid"));
            //                }
            //                }
            //            }
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
            var field_Mobile = Ext.create('Ext.form.field.Text', {
                fieldLabel: '移动电话',
                labelAlign: 'right',
                name: 'Phone',
                columnWidth: .5,
                margin: '10'
            })
            var field_OfficePhone = Ext.create('Ext.form.field.Text', {
                fieldLabel: '办公电话',
                labelAlign: 'right',
                name: 'HomePhone',
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
                margin: '10',
                anchor: '100%'
            })
            formpanel = Ext.create('Ext.form.Panel', {
                title: '人员信息',
                region: 'center',
                frame: true,
                items: [
                //第1行
                {layout: 'column', border: 0, items: [field_Name, combo_UserType] },
                //第2行
                {layout: 'column', border: 0, items: [field_Email, field_IDNumber] },
                //第3行
                {layout: 'column', border: 0, items: [field_Mobile, field_OfficePhone] },
                { layout: 'column', border: 0, items: [field_Job, field_JobLevel] },
                //第4行
                {layout: 'column', border: 0, items: [field_loginname, field_CreateDate] },
                field_Remark,
                { xtype: 'label', text: '说明：登录账号不允许编辑,无工号人员请用身份证登录,后续如果该人员信息进入NIMS会自动将工号同步过来', style: 'color:blue', margin: '0 0 0 110' },
                { xtype: 'textfield', hidden: true, name: 'UserID' },
                { xtype: 'textfield', hidden: true, id: "Server_Seed", name: 'Server_Seed' }
            ],
                buttons: [
                { text: '保 存', handler: create },
                { text: '取 消', handler: function () { window.close(); } }
                ],
                buttonAlign: 'center'
            });
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [formpanel]
            })
            update();
        })
        function create() {
            if (formpanel.getForm().isValid()) {
                var action = UserId ? "Update" : "Create";
                var str = formpanel.getForm().getValues();
                Ext.Ajax.request({
                    url: "ZiXunUserEdit.aspx",
                    params: { action: action, json: Ext.encode(str) },
                    callback: function (option, success, response) {
                        if (window.opener && window.opener.store_user) {
                            window.opener.store_user.load();
                        }
                        window.close();
                    }
                });
            }
        }
        function update() {
            if (UserId) {
                formpanel.getForm().load({
                    url: "ZiXunUserEdit.aspx",
                    params: { action: "SelectEdit", UserId: UserId },
                    method: "POST",
                    success: function (form, action) {
                        var str = new Date(action.result.data.CreateDate);
                        Ext.getCmp("CreateDate").setValue(str);
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
