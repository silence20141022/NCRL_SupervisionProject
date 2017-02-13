<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroupUser.aspx.cs" Inherits="SP.Web.ConsultationManage.GroupUser" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="/js/pan.js" type="text/javascript"></script>
    <title></title>
    <script type="text/javascript">
        var groupid, store_user;
        Ext.onReady(function () {
            var toolbar = Ext.create('Ext.toolbar.Toolbar', {
                items: [
                { xtype: 'textfield', fieldLabel: '姓名|工号', labelWidth: 60, labelAlign: 'right', id: 'NameWorkNo_s' },
                { xtype: 'textfield', fieldLabel: '人员类型', labelWidth: 60, labelAlign: 'right', id: 'UserType_s' },
                { xtype: 'button', text: '查 询', handler: function () {
                    var name_workno = Ext.getCmp("NameWorkNo_s").getValue();
                    store_user.load({ params: { name_workno: name_workno} });
                }
                }, '-',
                { text: '添 加', handler: function () {
                    opencenterwin("ZiXunUserEdit.aspx", 900, 500);
                }
                }, '-', { text: '修 改', handler: function () {
                    var recs = gridpanel.getSelectionModel().getSelection();
                    if (recs.length == 0) {
                        Ext.MessageBox.alert('提示', '请选择要修改的记录!');
                        return;
                    }
                    opencenterwin("ZiXunUserEdit.aspx?UserId=" + recs[0].get("UserId"), 900, 500)
                }
                }, '-',
                { text: '从NIMS同步机构和人员信息', handler: function () {
                    Ext.Ajax.request({
                        url: 'GroupUser.aspx?action=sync',
                        async: false,
                        callback: function (option, success, response) {
                            var json = Ext.decode(response.responseText);
                            if (json.success) {
                                Ext.Msg.alert('提示', "同步成功！");
                            }
                            else {
                                Ext.Msg.alert('提示', "同步失败!");
                            }
                        }
                    });
                }
                }, '-', { xtype: 'label', text: '说明：无工号人员请用身份证登录本系统' }
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
                    id: '267',
                    name: '江西瑞林工程咨询有限公司',
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
                listeners: { itemclick: function (treepanel, record, item, index, e, eOpts) {
                    store_user.load({ params: { groupid: record.get("id")} });
                }
                }
            })
            Ext.regModel('User', { fields: ['UserId', 'LoginName', 'Name', 'Sex', 'Phone', 'HomePhone', 'CreateDate', 'IDNumber', 'Server_Seed', 'GroupId'] })
            store_user = Ext.create('Ext.data.JsonStore', {
                model: 'User',
                pageSize: 25,
                proxy: {
                    type: 'ajax',
                    url: 'GroupUser.aspx?action=loaduser',
                    reader: {
                        root: 'rows',
                        type: 'json',
                        totalProperty: 'total'
                    }
                },
                autoLoad: true
            })
            var pgbar = Ext.create('Ext.toolbar.Paging', {
                displayMsg: '显示 {0} - {1} 条,共计 {2} 条',
                store: store_user,
                displayInfo: true
            })
            var gridpanel = Ext.create('Ext.grid.Panel', {
                region: 'center',
                store: store_user,
                bbar: pgbar,
                columns: [
                { header: 'UserId', dataIndex: 'UserId', hidden: true },
                { header: '工号', dataIndex: 'LoginName', width: 85, renderer: function (value) {
                    return value.length > 6 ? "" : value;
                }
                },
                { header: '姓名', dataIndex: 'Name', width: 75 },
                //{ header: '性别', dataIndex: 'Sex', width: 60 },
                {header: '移动电话', dataIndex: 'Phone', width: 110 },
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
