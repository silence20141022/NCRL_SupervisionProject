<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectAttendanceList.aspx.cs"
    Inherits="SP.Web.DailyManage.ProjectAttendanceList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <link href="../font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <title></title>
    <script type="text/javascript">
        Ext.onReady(function () {
            var toolbar = Ext.create('Ext.toolbar.Toolbar', {
                items: [
                { xtype: 'textfield', fieldLabel: '项目名称', labelWidth: 60, id: 'ProjectName_s' },
                { xtype: 'textfield', fieldLabel: '项目总监', labelWidth: 60, id: 'PManagerName_s' },
                { text: '查 询', handler: function () {
                    store_projectattendance.load({ params: { ProjectName: Ext.getCmp("ProjectName_s").getValue(),
                        PManagerName: Ext.getCmp("PManagerName_s").getValue()
                    }
                    })
                }
                }, '-',
                            { text: '添 加', handler: function () {
                                opencenterwin("ProjectAttendanceCard.aspx", 1300, 500);
                            }
                            }, '-',
                            { text: '修 改', handler: function () {
                                var recs = gridpanel.getSelectionModel().getSelection();
                                if (!recs) {
                                    Ext.Msg.alert("提示", "请选择要修改的节点!");
                                    return;
                                }
                                opencenterwin("ProjectAttendanceCard.aspx?id=" + recs[0].get('Id'), 1300, 500);
                            }
                            }
                            ]
            })
            Ext.regModel("ProjectAttendance",
            { fields: ["Id", "ProjectId", "ProjectName", "Year", "Month", "Status", 'Remark',
            "Attachment", "PManagerId", "PManagerName", "CreateId", "CreateName", "CreateTime", "BelongDeptId", "BelongDeptName"]
            });
            var store_projectattendance = Ext.create("Ext.data.JsonStore", {
                model: "ProjectAttendance",
                pageSize: 25,
                proxy: {
                    url: "ProjectAttendanceList.aspx?action=select",
                   //extraParams: { start: 0, limit: 25 },
                    type: "ajax",
                    reader: {
                        type: "json",
                        root: "rows",
                        totalProperty: "total"
                    }
                },
                autoLoad: true
            });
            var pgbar = Ext.create("Ext.toolbar.Paging", {
                store: store_projectattendance,
                displayMsg: '显示 {0} - {1} 条,共计 {2} 条',
                displayInfo: true
            })
            var gridpanel = Ext.create('Ext.grid.Panel', {
                tbar: toolbar,
                title: '项目监理部考勤',
                region: 'center',
                selModel: { selType: 'checkboxmodel' },
                store: store_projectattendance,
                enableColumnHide: false,
                columnLines: true,
                columns: [
                { xtype: 'rownumberer', width: 35 },
                { header: '项目名称', dataIndex: 'ProjectName', width: 250 },
                { dataIndex: 'PManagerName', header: '项目总监', width: 100 },
			    { dataIndex: 'Year', header: '所属年份', width: 100, renderer: function (value, metadata, record) {
			        return value + "年" + record.get("Month") + "月";
			    }
			    },
                { dataIndex: 'Status', header: '状态', width: 70 },
                { dataIndex: 'BelongDeptName', header: '所属部门', width: 140, sortable: true },
			    { dataIndex: 'CreateName', header: '填报人', width: 80 },
                { header: '备注', dataIndex: 'Remark', flex: 1 }
                ],
                bbar: pgbar
            })
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [gridpanel]
            })
        })
        function showdetail(val1) {
            opencenterwin("TBProjectAttendanceEdit.aspx?action=view&id=" + val1, 1200, 500);
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
