<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroupUser.aspx.cs" Inherits="SP.Web.DailyManage.GroupUser" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="/js/pan.js" type="text/javascript"></script>
    <title></title>
    <script type="text/javascript">
        var groupid, store_user;
        Ext.onReady(function () {
            var store_combo = Ext.create('Ext.data.JsonStore', {
                fields: ['name'],
                data: [{ name: '正式' }, { name: '返聘' }, { name: '派遣' }]
            })
            var combo_UserType = Ext.create('Ext.form.field.ComboBox', {
                queryMode: 'local',
                store: store_combo,
                displayField: 'name',
                valueField: 'name',
                editable: false,
                fieldLabel: '人员类型',
                labelAlign: 'right',
                labelWidth: 60,
                width: 150
            });
            var store_status = Ext.create('Ext.data.JsonStore', {
                fields: ['id', 'name'],
                data: [{ id: 1, name: '启用' }, { id: 0, name: '停用' }]
            })
            var combo_status = Ext.create('Ext.form.field.ComboBox', {
                value: 1,
                editable: false,
                store: store_status,
                fieldLabel: '状态',
                displayField: 'name',
                valueField: 'id',
                labelAlign: 'right',
                queryMode: 'local',
                labelWidth: 60,
                width: 150
            })
            var toolbar = Ext.create('Ext.toolbar.Toolbar', {
                items: [
                { xtype: 'textfield', fieldLabel: '姓名|工号', labelWidth: 60, labelAlign: 'right', id: 'NameWorkNo_s' },
                 combo_UserType, combo_status,
                              {
                                  xtype: 'button', text: '查 询', handler: function () {
                                      store_user.load();
                                  }
                              }, '-', {
                                  text: '添 加', handler: function () {
                                      opencenterwin("JianLiUserEdit.aspx", 900, 500);
                                  }
                              }, '-', {
                                  text: '修 改', handler: function () {
                                      var recs = gridpanel.getSelectionModel().getSelection();
                                      if (!recs || recs.length <= 0) {
                                          Ext.Msg.alert("提示", "请选择修改记录!");
                                          return;
                                      }
                                      opencenterwin("JianLiUserEdit.aspx?UserId=" + recs[0].get("UserId"), 900, 500);
                                  }
                              }, '-',
                            {
                                text: '初始化密码', handler: function () {
                                    var recs = gridpanel.getSelectionModel().getSelection();
                                    if (!recs || recs.length <= 0) {
                                        Ext.Msg.alert('提示', '请选择删除的记录!');
                                        return;
                                    }
                                    Ext.Ajax.request({
                                        url: 'GroupUser.aspx',
                                        params: { 'action': 'inipsd', 'UserId': recs[0].get('UserId') },
                                        async: false,
                                        callback: function (option, success, response) {
                                            // store_user.reload();
                                        }
                                    });
                                }
                            }, '-',
                {
                    text: '同步机构和人员信息', handler: function () {
                        Ext.Ajax.request({
                            url: 'GroupUser.aspx?action=sync',
                            async: false,
                            callback: function (option, success, response) {
                                var json = Ext.decode(response.responseText);
                                if (json.success) {
                                    alert("同步成功！");
                                }
                                else {
                                    alert("同步失败!");
                                }
                            }
                        });
                    }
                }
                ]
            })
            Ext.regModel('TreeModel', { fields: ['id', 'name', 'leaf'] })
            var treestore = Ext.create('Ext.data.TreeStore', {
                model: 'TreeModel',
                nodeParam: 'id',
                proxy: {
                    url: 'GroupUser.aspx?action=loadtreedata',
                    type: 'ajax',
                    reader: 'json'
                },
                root: {
                    id: '228',
                    name: '江西瑞林建设监理有限公司',
                    expanded: true
                }
            })
            var treepanel = Ext.create('Ext.tree.Panel', {
                region: 'west',
                width: 273,
                useArrows: true,
                store: treestore,
                columns: [
                    { header: 'id', dataIndex: 'id', hidden: true },
                    { header: 'leaf', dataIndex: 'leaf', hidden: true },
                    { header: '名称', dataIndex: 'name', xtype: 'treecolumn', flex: 1 }
                ],
                listeners: {
                    itemclick: function (treepanel, record, item, index, e, eOpts) {
                        store_user.load({ params: { groupid: record.get("id") } });
                    }
                }
            })
            Ext.regModel('User', { fields: ['UserId', 'LoginName', 'Name', 'Sex', 'Phone', 'HomePhone', 'CreateDate', 'IDNumber', 'Server_Seed', 'GroupId'] })
            store_user = Ext.create('Ext.data.JsonStore', {
                model: 'User',
                proxy: {
                    type: 'ajax',
                    url: 'GroupUser.aspx?action=loaduser',
                    reader: {
                        root: 'rows',
                        type: 'json',
                        totalProperty: 'total'
                    }
                },
                autoLoad: true,
                listeners: {
                    beforeload: function (store, options) {
                        var new_params = {
                            name_workno: Ext.getCmp("NameWorkNo_s").getValue(),
                            UserType: combo_UserType.getValue(), Status: combo_status.getValue()
                        }
                        Ext.apply(store.proxy.extraParams, new_params);
                    }
                }
            })
            var pgbar = Ext.create('Ext.toolbar.Paging', {
                displayMsg: '显示 {0} - {1} 条,共计 {2} 条',
                store: store_user,
                displayInfo: true
            })
            var gridpanel = Ext.create('Ext.grid.Panel', {
                region: 'center',
                store: store_user,
                //  bbar: pgbar,
                columns: [
                    { xtype: 'rownumberer', width: 35 },
                    { header: 'UserId', dataIndex: 'UserId', hidden: true },
                    {
                        header: '工号', dataIndex: 'LoginName', width: 85, renderer: function (value, metadata, record, rowindex, colIndex) {
                            return value.length > 6 ? "" : value;
                        }
                    },
                    { header: '姓名', dataIndex: 'Name', width: 75 },
                //{ header: '性别', dataIndex: 'Sex', width: 60 },
                    { header: '移动电话', dataIndex: 'Phone', width: 110 },
                    { header: '办公电话', dataIndex: 'HomePhone', width: 120 },
                    { header: '身份证号', dataIndex: 'IDNumber', width: 155 },
                    { header: '入职日期', xtype: 'datecolumn', dataIndex: 'CreateDate', width: 90, format: 'Y-m-d' },
                    { header: '所属部门', dataIndex: 'Server_Seed', flex: 1 }
                ]
            })
            var panel = Ext.create('Ext.panel.Panel', {
                title: '机构人员',
                tbar: toolbar,
                region: 'center',
                layout: 'border',
                items: [treepanel, gridpanel]
            })
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [panel]
            })
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
