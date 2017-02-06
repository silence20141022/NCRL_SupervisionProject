<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExpertEdit.aspx.cs" Inherits="SP.Web.ConsultationManage.ExpertEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var panel;
        var check1 = "";
        var JSONArr, StampDate, Sex, MajorName1;
        var Id = getQueryString("Id");
        Ext.onReady(SetPage);
        function SetPage() {
            var UserName = {
                xtype: "textfield",
                name: 'UserName',
                id: 'UserName',
                allowBlank: false,
                blankText: '姓名不能为空',
                msgTarget: 'under',
                fieldLabel: '姓名',
                labelAlign: 'right',
                labelWidth: 100
                //autoFitErrors: true
            }
            var Email = {
                xtype: "textfield",
                name: 'Email',
                // allowBlank: false,
                blankText: '邮箱地址不能为空',
                fieldLabel: '邮箱',
                labelAlign: 'right',
                // labelWidth: 100,
                vtypeText: 'Email格式不正确',
                msgTarget: 'under',
                vtype: 'email'
            }
            Sex = Ext.create('Ext.form.RadioGroup', {
                name: "Sex",
                labelWidth: 100,
                id: "Sex1",
                fieldLabel: '性别',
                labelAlign: 'right',
                items: [
                    { boxLabel: '男', name: 'Sex', inputValue: '男' },
                    { boxLabel: '女', name: 'Sex', inputValue: '女' }
                ]
            })
            var ProfessionType1 = Ext.create('Ext.form.CheckboxGroup', {
                name: "ProfessionType1",
                fieldLabel: '专家类型',
                id: "ProfessionType1",
                allowBlank: false,
                blankText: '专家类型不能为空',
                labelWidth: 100,
                msgTarget: 'under',
                labelAlign: 'right',
                listeners: { render: function () {
                    Ext.Ajax.request({
                        url: "ExpertEdit.aspx",
                        async: false,
                        params: { action: "ProfessionType", Id: Id },
                        callback: function (option, success, response) {
                            JSONArr = Ext.decode(response.responseText);
                            var Type = JSONArr.ProfessionType;
                            for (var i = 0; i < JSONArr.rows.length; i++) {
                                var Ischeck = false;
                                if (Type.indexOf(JSONArr.rows[i].Name) != -1) {
                                    Ischeck = true;
                                };
                                if (Ischeck) {
                                    ProfessionType1.items.add(Ext.create('Ext.form.Checkbox', {
                                        inputValue: JSONArr.rows[i].Name,
                                        boxLabel: JSONArr.rows[i].Name,
                                        checked: true,
                                        name: "ProfessionType1"
                                    }))
                                }
                                else {
                                    ProfessionType1.items.add(Ext.create('Ext.form.Checkbox', {
                                        inputValue: JSONArr.rows[i].Name,
                                        boxLabel: JSONArr.rows[i].Name,
                                        name: "ProfessionType1"
                                    }))
                                }
                            }
                        }
                    });
                }
                }
            })
            MajorName1 = Ext.create("Ext.form.CheckboxGroup", {
                name: "MajorName1",
                id: "MajorName1",
                fieldLabel: '专业类型',
                allowBlank: false,
                blankText: '专业类型不能为空',
                msgTarget: 'under',
                labelWidth: 100,
                columns: 6,
                labelAlign: 'right',
                listeners: { render: function () {
                    Ext.Ajax.request({
                        url: "ExpertEdit.aspx",
                        async: false,
                        params: { action: "MajorName", Id: Id },
                        callback: function (option, success, response) {
                            var JSONArr1 = Ext.decode(response.responseText);
                            var type = JSONArr1.MajorName;
                            for (var i = 0; i < JSONArr1.rows.length; i++) {
                                MajorName1.items.add(Ext.create('Ext.form.Checkbox', {
                                    inputValue: JSONArr1.rows[i].Name,
                                    boxLabel: JSONArr1.rows[i].Name,
                                    name: "MajorName1"
                                }))
                            }
                        }
                    });
                }
                }
            })

            var RCStore = Ext.create("Ext.data.JsonStore", {
                fields: ["Name"],
                proxy: {
                    url: "ExpertEdit.aspx?action=RCStore",
                    type: "ajax",
                    reader: {
                        type: "json",
                        root: "rows"
                    }
                }
            });
            var RegistrationCategories = Ext.create("Ext.form.ComboBox", {
                name: "RegistrationCategories",
                labelAlign: "right",
                store: RCStore,
                labelWidth: 100,
                emptyText: "请选择...",
                fieldLabel: "注册师类别",
                displayField: 'Name',
                valueField: "Name"
            });
            var RegisteredNo = {
                xtype: "textfield",
                name: "RegisteredNo",
                labelAlign: "right",
                labelWidth: 100,
                fieldLabel: "注册师印章号"
            }
            var RegisteredDate = {
                xtype: 'datefield',
                fieldLabel: '有效期',
                name: 'RegisteredDate',
                id: "RegisteredDate",
                labelAlign: "right",
                labelWidth: 100,
                format: 'Y-m-d',
                Value: new Date()
            }

            var StampNo = {
                xtype: "textfield",
                name: "StampNo",
                labelAlign: "right",
                labelWidth: 100,
                fieldLabel: "审图章印章号"
            }
            StampDate = Ext.create("Ext.form.field.Date", {
                fieldLabel: '有效期',
                name: 'StampDate',
                id: "StampDate",
                labelAlign: "right",
                labelWidth: 100,
                format: 'Y-m-d'
            });
            var Phone = {
                xtype: "textfield",
                fieldLabel: '手机号',
                name: 'Phone',
                labelAlign: "right",
                labelWidth: 100,
                maxLength: 11,
                enforceMaxLength: true,
                maskRe: /\d/
            }
            var IdCard = {
                xtype: "textfield",
                fieldLabel: '身份证',
                name: 'IdCard',
                labelAlign: "right",
                labelWidth: 100
            }
            var HomeAddress = {
                xtype: "textareafield",
                height: "40",
                fieldLabel: '邮寄地址',
                name: 'HomeAddress',
                labelAlign: "right",
                labelWidth: 100
            }
            var Remark = {
                xtype: "textareafield",
                height: "40",
                fieldLabel: '备注',
                name: 'Remark',
                labelAlign: "right",
                labelWidth: 100
            }
            panel = Ext.create('Ext.form.Panel', {
                title: '专家管理',
                frame: true,
                region: 'center',
                items: [
                //第1行
            {layout: 'column', bodyStyle: 'border:0',
            items: [
                        { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [UserName] },
                        { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [Email] }
                    ]
        },
                //第2行
            {layout: 'column', bodyStyle: 'border:0',
            items: [
                    { columnWidth: 1, layout: 'form', bodyStyle: 'border:0', items: [ProfessionType1] }
                ]
        },
             { layout: 'column', bodyStyle: 'border:0',
                 items: [
                    { columnWidth: 1, layout: 'form', bodyStyle: 'border:0', items: [MajorName1] }
                ]
             },
             { layout: 'column', bodyStyle: 'border:0',
                 items: [
                   { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [Sex] },
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [RegistrationCategories] }
                ]
             },
              { layout: 'column', bodyStyle: 'border:0',
                  items: [
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [StampNo] },
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [RegisteredDate] }
                ]
              },
              { layout: 'column', bodyStyle: 'border:0',
                  items: [
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [RegisteredNo] },
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [StampDate] }
                ]
              },
              { layout: 'column', bodyStyle: 'border:0',
                  items: [
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [Phone] },
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [IdCard] }
                ]
              },
                            { layout: 'column', bodyStyle: 'border:0',
                                items: [
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [HomeAddress] },
                    { columnWidth: .45, layout: 'form', bodyStyle: 'border:0', items: [Remark] }
                ]

                            },
                             { xtype: 'hidden', name: 'Id' }
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
        function update() {
            if (Id != null) {
                panel.getForm().load({
                    url: 'ExpertEdit.aspx?action=SelectEdit',
                    params: { Id: Id },
                    method: 'POST', //请求方式      
                    success: function (form, action) {
                        Sex.setValue({ Sex: action.result.data.Sex });
                        if (action.result.data.RegisteredDate) {
                            var str = new Date(action.result.data.RegisteredDate);
                            Ext.getCmp("RegisteredDate").setValue(str);
                        }
                        if (action.result.data.StampDate) {
                            var str1 = new Date(action.result.data.StampDate);
                            Ext.getCmp("StampDate").setValue(str1);
                        }
                        var str = action.result.data.MajorName;
                        var arr = str.split(",");
                        MajorName1.setValue({ MajorName1: arr });
                    }
                });
            }
        }
        function create() {
            if (panel.getForm().isValid()) {
                var data = panel.getForm().getValues();
                var json = Ext.encode(data);
                var ProfessionType = Ext.getCmp("ProfessionType1").getValue().ProfessionType1.toString();
                var MajorName = Ext.getCmp("MajorName1").getValue().MajorName1.toString();
                var action = Id ? "Update" : "Create";
                Ext.Ajax.request({
                    url: "ExpertEdit.aspx",
                    async: false,
                    params: { action: action, data: json, ProfessionType: ProfessionType, MajorName: MajorName, Id: Id },
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
