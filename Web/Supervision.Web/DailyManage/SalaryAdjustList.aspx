<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalaryAdjustList.aspx.cs"
    Inherits="SP.Web.DailyManage.SalaryAdjustList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var stageId = getQueryString("stageId");
        Ext.onReady(function () {
            Ext.regModel('SalaryAdjustDetail', { fields: ['Id', 'UserName', 'StageName', 'Job', 'JobLevel',
             'GangWeiSalary', 'GongLingBuTie', 'ZhuCeBuTie', 'GangWeiBuTie', 'TeShuBuTie', 'XianChangBuTie', 'TotalSalary']
            });
            var store_salaryadjust = Ext.create('Ext.data.JsonStore', {
                model: 'SalaryAdjustDetail',
                proxy: {
                    url: 'SalaryAdjustList.aspx?action=loadadjustdetail&stageId=' + stageId,
                    type: 'ajax',
                    reader: {
                        root: 'rows',
                        type: 'json',
                        totalProperty: 'total'
                    }
                }
                //autoLoad: true
                //                listeners: { load: function () {
                //                    // Ext.getCmp('bl_title').setText("Hello");
                //                }
                //                }
            });
            var grid_salaryadjust = Ext.create('Ext.grid.Panel', {
                store: store_salaryadjust,
                region: 'center',
                titleAlign: 'center',
                frame: true,
                columns: [
                { dataIndex: 'UserName', width: 80, header: '姓名' },
                { dataIndex: 'StageName', width: 100, header: '阶段' },
                { dataIndex: 'Job', header: '岗位', width: 70 },
                { dataIndex: 'JobLevel', header: '岗位等级', width: 80 },
                { dataIndex: 'JobLevel', header: '岗位等级', width: 80 },
                { dataIndex: 'GangWeiSalary', header: '岗位工资', width: 80 },
                { dataIndex: 'GongLingBuTie', header: '工(司)龄津贴', width: 100 },
                { dataIndex: 'ZhuCeBuTie', header: '注册津贴', width: 80 },
                { dataIndex: 'GangWeiBuTie', header: '岗位津贴', width: 80 },
                { dataIndex: 'TeShuBuTie', header: '特殊津贴', width: 80 },
                { dataIndex: 'XianChangBuTie', header: '现场津贴', width: 80 },
                { dataIndex: 'TotalSalary', header: '工资总额', width: 90 }
                ]
            })
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [grid_salaryadjust]
            })
            store_salaryadjust.load({ callback: function (records, opition, success) {
                var json2 = Ext.decode(opition.response.responseText);
                grid_salaryadjust.setTitle("<h1>中国瑞林监理公司" + json2.StageName + "工资调整表</h1>");
            }
            }
                        )
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
