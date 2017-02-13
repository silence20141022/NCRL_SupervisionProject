//说明：调用该JS的地方 需声明一个GetUsers(recs)函数以接受返回值
var GroupID, win_groupuser;
function showGroupUserWin() {
    Ext.regModel("SysUser", { fields: ['UserId', 'LoginName', 'Name', 'Sex', 'Phone', 'HomePhone', 'Job', 'JobLevel', 'CreateDate', 'IDNumber', 'Server_Seed', 'GroupId'] });
    var userstore = new Ext.data.JsonStore({
        model: 'SysUser',
        proxy: {
            type: 'ajax',
            url: "/DailyManage/GroupUser.aspx?action=loaduser",
            reader: {
                reader: 'json',
                root: 'rows',
                totalProperty: 'total'
            }
        },
        pageSize: 15,
        autoLoad: { start: 0, limit: 15 },
        listeners: { 'beforeload': function (store, op, options) {
            var params = {
                GroupID: GroupID
                //Name: $("#Name_S").val(), WorkNo: $("#WorkNo_S").val()
            };
            Ext.apply(store.proxy.extraParams, params);
        }
        }
    });
    var toolbar = Ext.create('Ext.toolbar.Toolbar', {
        items: [
        { xtype: 'textfield', fieldLabel: '姓名|工号', labelWidth: 60, labelAlign: 'right', id: 'name_workno' },
        { xtype: 'button', text: '查询', icon: '/images/shared/preview.png', handler: function () {
            var name_workno = Ext.getCmp('name_workno').getValue();
            userstore.load({ params: { name_workno: name_workno} });
        }
        }
    ]
    });
    var usergrid = Ext.create('Ext.grid.Panel', {
        tbar: toolbar,
        store: userstore,
        region: 'center',
        selModel: { selType: 'checkboxmodel' },
        columns: [
                { header: '标识', dataIndex: 'UserId', hidden: true },
                { xtype: 'rownumberer', width: 30 },
                { header: '姓名', dataIndex: 'Name', width: 80 },
        //  { header: '工号', dataIndex: 'LoginName', width: 90 }, 
                {header: '所属部门', dataIndex: 'Server_Seed', flex: 1 }
                ],
        bbar: {
            xtype: 'pagingtoolbar',
            displayMsg: '显示 {0} - {1} 条,共计 {2} 条',
            store: userstore,
            displayInfo: true
        },
        listeners: { itemdblclick: function (sg, record, item, index, e, eOpts) {
            if (GetUsers) {
                GetUsers([record]);
                win_groupuser.close();
            }
        }
        }
    });
    Ext.regModel("SysGroup", { fields: ['id', 'name', 'leaf'] });
    var treepanelstore = new Ext.data.TreeStore({
        model: 'SysGroup',
        nodeParam: 'id',
        proxy: {
            type: 'ajax',
            url: '/DailyManage/GroupUser.aspx?action=loadtreedata',
            reader: 'json'
        },
        root: {
            expanded: true,
            name: '江西瑞林建设监理有限公司', id: '228'  //第一次加载数据;
        }
    });
    var treepanel = Ext.create('Ext.tree.Panel', {
        useArrows: true,
        region: 'west',
        width: 273,
        store: treepanelstore,
        columns: [
                { text: 'id', dataIndex: 'id', width: 100, hidden: true },
                { text: 'leaf', dataIndex: 'leaf', width: 100, hidden: true },
                { xtype: 'treecolumn', text: '部门名称', dataIndex: 'name', width: 200, sortable: true }
                ],
        listeners: { cellclick: function (rows) {
            var rec = treepanel.getSelectionModel().getSelection();
            GroupID = rec[0].get('id');
            if (rec[0]) {
                userstore.reload({ params: { GroupID: GroupID} });
            }
        }
        }
    });
    var win_groupuser = Ext.create('Ext.window.Window', {
        height: 500,
        width: 800,
        layout: 'border',
        items: [treepanel, usergrid],
        buttonAlign: 'center',
        buttons: [{ text: '确 定', handler: function () {
            if (GetUsers) {
                var recs = usergrid.getSelectionModel().getSelection();
                GetUsers(recs)
                win_groupuser.close();
            }
        }
        }, { text: '取 消', handler: function () {
            win_groupuser.close();
        }
        }]
    })
    return win_groupuser;
}