<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamineOpinionEdit.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ExamineOpinionEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var form;
        var ExamineTaskId = getQueryString("ExamineTaskId");
        Ext.onReady(function () {
            SetPage();
            if (ExamineTaskId) {
                load();
            }
        });
        function load() {
            form.getForm().load({
                url: "ExamineOpinionEdit.aspx",
                params: { action: "load", ExamineTaskId: ExamineTaskId },
                method: "POST",
                success: function (form, action) {
                 //   if (action.result.data.StartTime) {
                 //       var str = new Date(action.result.data.StartTime);
                 //       Ext.getCmp("StartTime").setValue(str);
                 //   }
                }
            });
        }
        function SetPage() {
            var ZiXunCode = Ext.create("Ext.form.field.Display", {
                fieldLabel: "咨询公司项目编号",
                name: "ZiXunCode",
                id: "ZiXunCode",
                labelWidth: 130,
                labelAlign: "right",
                columnWidth: .5
            });
            var ProjectName = Ext.create("Ext.form.field.Display", {
                fieldLabel: "工程名称",
                name: "ProjectName",
                id: "ProjectName",
                labelWidth: 130,
                margin: "3",
                labelAlign: "right",
                columnWidth: .5
            });

            var ZhuCeUsers = Ext.create("Ext.form.field.Display", {
                fieldLabel: "注册人员",
                name: "ZhuCeUsers",
                id: "ZhuCeUsers",
                labelWidth: 130,
                labelAlign: "right",
                columnWidth: .5
            })
            var SheJiUsers = Ext.create("Ext.form.field.Display", {
                fieldLabel: "设计人员",
                name: "SheJiUsers",
                id: "SheJiUsers",
                labelWidth: 130,
                labelAlign: "right",
                columnWidth: .5
            });
            var StartTime = Ext.create("Ext.form.field.Date", {
                fieldLabel: "开始时间",
                allowBlank: false,
                blankText: "开始时间不能为空!",
                msgTarget: "under",
                name: "StartTime",
                labelWidth: 130,
                id: "StartTime",
             //   readOnly: true,
                format: 'Y-m-d',
                labelAlign: "right",
                columnWidth: .5
            });

            var EndTime = Ext.create("Ext.form.field.Date", {
                fieldLabel: "结束时间",
                allowBlank: false,
                blankText: "结束时间不能为空!",
                msgTarget: "under",
                labelWidth: 130,
                name: "EndTime",
                id: "EndTime",
                labelAlign: "right",
                columnWidth: .5,
                format: 'Y-m-d',
                listeners: { select: function (field, value, eOpts) {
             //       if (Ext.getCmp('Stage').getValue() != '初审') {
             //           StartTime.setValue(value);
             //       }
                }
                }
            });
            var MajorName = Ext.create("Ext.form.field.Display", {
                fieldLabel: "专业",
                name: "MajorName",
                id: "MajorName",
                labelWidth: 130,
                labelAlign: "right",
                columnWidth: .5
            });
            var JiangZhuSheJi = {
                xtype: 'numberfield',
                fieldLabel: " 建筑设计(条)",
                name: "JiangZhuSheJi",
                labelWidth: 130,
                id: "JiangZhuSheJi",
                listeners: { change: function (str, isValid, eOpts) {
                    if (isValid || isValid == 0) {
                        count();
                    }
                }
                },
                labelAlign: "right",
                columnWidth: .5
            };
            var FangHuo = {
                xtype: 'numberfield',
                fieldLabel: " 建筑防火(条)",
                labelWidth: 130,
                name: "FangHuo",
                id: "FangHuo",
                listeners: { change: function (str, isValid, eOpts) {
                    if (isValid || isValid == 0) {
                        count();
                    }
                }
                },
                labelAlign: "right",
                columnWidth: .5
            };

            var SheBei = {
                xtype: 'numberfield',
                fieldLabel: " 建筑设备(条)",
                labelWidth: 130,
                name: "SheBei",
                id: "SheBei",
                listeners: { change: function (str, isValid, eOpts) {
                    if (isValid || isValid == 0) {
                        count();
                    }
                }
                },
                labelAlign: "right",
                columnWidth: .5
            };
            var JiChu = {
                xtype: 'numberfield',
                fieldLabel: " 建筑设备(条)",
                labelWidth: 130,
                name: "JiChu",
                id: "JiChu",
                listeners: { change: function (str, isValid, eOpts) {
                    if (isValid || isValid == 0) {
                        count();
                    }
                }
                },
                labelAlign: "right",
                columnWidth: .5
            };
            var JiGouSheJi = {
                xtype: 'numberfield',
                fieldLabel: " 机构设计(条)",
                labelWidth: 130,
                name: "JiGouSheJi",
                id: "JiGouSheJi",
                listeners: { change: function (str, isValid, eOpts) {
                    if (isValid || isValid == 0) {
                        count();
                    }
                }
                },
                labelAlign: "right",
                columnWidth: .5
            };
            var KangZhenSheJi = {
                xtype: 'numberfield',
                labelWidth: 130,
                fieldLabel: " 房屋抗震(条)",
                name: "KangZhenSheJi",
                id: "KangZhenSheJi",
                listeners: { change: function (str, isValid, eOpts) {
                    if (isValid || isValid == 0) {
                        count();
                    }
                }
                },
                labelAlign: "right",
                columnWidth: .5
            };
            var JiaGu = {
                xtype: 'numberfield',
                fieldLabel: " 结构鉴定和加固(条)",
                name: "JiaGu",
                id: "JiaGu",
                labelWidth: 130,
                listeners: { change: function (str, isValid, eOpts) {
                    if (isValid || isValid == 0) {
                        count();
                    }
                }
                },
                labelAlign: "right",
                columnWidth: .5
            };
            var QiangTiao = {
                xtype: 'numberfield',
                fieldLabel: " 违反强条数(条)",
                name: "QiangTiao",
                id: "QiangTiao",
                labelWidth: 130,
                readOnly: true,
                labelAlign: "right",
                columnWidth: .5
            };
            var ShenChaUserName = {
                xtype: 'textfield',
                fieldLabel: " 审查人",
                readOnly: true,
                labelWidth: 130,
                name: "ShenChaUserName",
                id: "ShenChaUserName",
                labelAlign: "right",
                columnWidth: .5
            };
            var FuHeUserName = {
                xtype: 'textfield',
                fieldLabel: " 复核人",
                readOnly: true,
                labelWidth: 130,
                name: "FuHeUserName",
                id: "FuHeUserName",
                labelAlign: "right",
                columnWidth: .5
            };
            var ShenChaOrganization = Ext.create("Ext.form.field.Display", {
                fieldLabel: " 审查机构",
                name: "ShenChaOrganization",
                labelWidth: 130,
                id: "ShenChaOrganization",
                labelAlign: "right",
                columnWidth: .5
            });
            var ExamineOpinions = Ext.create("Ext.form.HtmlEditor", {
                fieldLabel: " 审查意见",
                allowBlank: false,
                labelWidth: 130,
                blankText: "审查意见不能为空!",
                msgTarget: "under",
                name: "ExamineOpinions",
                id: "ExamineOpinions",
                height: 200,
                margin: '10',
                enableFont: false,
                labelAlign: "right",
                columnWidth: 1
            });

            form = Ext.create('Ext.form.Panel', {
                title: "审查意见",
                region: 'center',
                autoScroll: true,
                frame: true,
                items: [
                { xtype: "textfield", name: "Id", id: "Id", hidden: true },
                { xtype: "textfield", name: "ExamineTaskId", id: "ExamineTaskId", hidden: true },
                { xtype: "textfield", name: "ShenChaUserId", id: "ShenChaUserId", hidden: true },
                { xtype: "textfield", name: "FuHeUserId", id: "FuHeUserId", hidden: true },
                { layout: 'column', border: 0, margin: '10', items: [ZiXunCode, ProjectName] },
                { layout: 'column', border: 0, margin: '10', items: [ZhuCeUsers, SheJiUsers] },
                { xtype: 'textfield', fieldLabel: '审查阶段', labelAlign: 'right', readOnly: true, margin: '10', labelWidth: 130, name: 'Stage', anchor: '51%', id: 'Stage' },
                { layout: 'column', border: 0, margin: '10', items: [StartTime, EndTime] },
                { layout: 'column', border: 0, margin: '10', items: [MajorName, JiangZhuSheJi] },
                { layout: 'column', border: 0, margin: '10', items: [FangHuo, SheBei] },
                { layout: 'column', border: 0, margin: '10', items: [JiChu, JiGouSheJi] },
                { layout: 'column', border: 0, margin: '10', items: [KangZhenSheJi, JiaGu] },
                { layout: 'column', border: 0, margin: '10', items: [QiangTiao, ShenChaUserName] },
                { layout: 'column', border: 0, margin: '10', items: [FuHeUserName, ShenChaOrganization] },
                ExamineOpinions
            ],
                buttons: [
                { text: '保 存', handler: function () { create("unclosed") } },
                { text: '关 闭 ', handler: function () { window.close(); } }
                ],
                buttonAlign: 'center'
            });
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [form]
            })

        }
        function count() {
            var s1 = Ext.getCmp("JiangZhuSheJi").getValue();
            var s2 = Ext.getCmp("FangHuo").getValue();
            var s3 = Ext.getCmp("SheBei").getValue();
            var s4 = Ext.getCmp("JiGouSheJi").getValue();
            var s5 = Ext.getCmp("KangZhenSheJi").getValue();
            var s6 = Ext.getCmp("JiaGu").getValue();
            var s7 = Ext.getCmp("JiChu").getValue();
            var total = s1 + s2 + s3 + s4 + s5 + s6 + s7;
            Ext.getCmp("QiangTiao").setValue(total);
        }
        function create(state) {
            if (form.getForm().isValid()) {
                var str = form.getForm().getValues();
                var json = Ext.encode(str);
                Ext.Ajax.request({
                    url: "ExamineOpinionEdit.aspx?action=create",
                    params: { json: json },
                    callback: function (option, success, response) {
                        /// window.opener.store.reload();
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
