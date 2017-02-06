<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamineMeetingList.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ExamineMeetingList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var store, grid;
        Ext.onReady(SetPage);
        function SetPage() {
            Ext.regModel("ExamineMeeting", { fields: ["Id", "MeetingName", "MeetingTime", "MeetingPlace", "ContractAmount", "DistributeAmount", "CreateId", "CreateName", "CreateTime", "Remark"] });
            store = Ext.create("Ext.data.JsonStore", {
                model: "ExamineMeeting",
                pageSize: 15,
                proxy: {
                    url: "ExamineMeetingList.aspx",
                    extraParams: { start: 0, limit: 15, action: "Select", MeetingName: "" },
                    type: "ajax",
                    reader: {
                        type: "json",
                        root: "rows",
                        totalProperty: "total"
                    }
                },
                autoLoad: true
            });
            var toolbar = Ext.create("Ext.toolbar.Toolbar", {
                items: [
                    { xtype: "textfield", fieldLabel: "会议名称", labelAlign: "right", id: "MeetingName", name: "MeetingName" },
                    { text: "查询", handler: function () {
                        var MeetingName = Ext.getCmp("MeetingName").getValue();
                        store.getProxy().setExtraParam("MeetingName", MeetingName);
                        store.load();
                    }
                    }, '-',
                    { text: "添加", handler: function () {
                        opencenterwin("ExamineMeetingEdit.aspx", 900, 600);
                    }
                    }, '-',
                    { text: "修改", handler: function () {
                        recs = grid.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert("提示", "请选择要修改的记录！");
                            return;
                        }
                        opencenterwin("ExamineMeetingEdit.aspx?Id=" + recs[0].get("Id"), 900, 600);

                    }
                    }, '-',
                    { text: "删除", handler: function () {
                        var recs = grid.getSelectionModel().getSelection();
                        if (!recs || recs.length <= 0) {
                            Ext.Msg.alert("提示", "请先选择要删除的记录!");
                            return;
                        }
                        Ext.MessageBox.confirm("提示", "确定要删除吗?", function (str) {
                            var Jarray = [];
                            if (str == "yes") {
                                Ext.each(recs, function (rec) {
                                    Jarray.push(rec.get("Id"));
                                });
                                Ext.Ajax.request({
                                    url: "ExamineMeetingList.aspx?action=delete",
                                    async: false,
                                    params: { Jarray: Jarray },
                                    callback: function () {
                                        store.reload();
                                    }
                                });
                            }
                        })
                    }
                    }
                ]
            });
            var grid = Ext.create("Ext.grid.Panel", {
                title: "专家评审会",
                store: store,
                region: "center",
                selModel: { selType: "checkboxmodel" },
                columns: [
                    { xtype: "rownumberer", width: 35 },
                    { dataIndex: "Id", header: "标示", hidden: true },
                    { dataIndex: "MeetingName", header: "会议名称", flex: 1, width: 200 },
                    { dataIndex: "MeetingTime", header: "会议时间", width: 100 },
                    { dataIndex: "MeetingPlace", header: "会议地点", width: 150 },
                    { dataIndex: "ContractAmount", header: "合同金额", width: 80 },
                    { dataIndex: "DistributeAmount", header: "分配金额", width: 80 },
                    { dataIndex: "DistributePercent", header: "分配比列", width: 80 },
                    { dataIndex: "Remark", header: "备注", width: 100 },
                    { dataIndex: "CreateTime", header: "创建日期", width: 100 }
                ],
                tbar: toolbar
            });
            var viewport = Ext.create("Ext.container.Viewport", {
                layout: "border",
                items: [grid]
            });
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
