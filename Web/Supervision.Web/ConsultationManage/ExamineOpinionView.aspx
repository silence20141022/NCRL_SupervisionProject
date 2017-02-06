<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamineOpinionView.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ExamineOpinionView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var ExamineTaskId = getQueryString("ExamineTaskId");
        var id = getQueryString("id");
        Ext.onReady(function () {
            var ZiXunCode = Ext.create("Ext.form.field.Display", {
                fieldLabel: "咨询公司编号",
                name: "ZiXunCode",
                id: "ZiXunCode",
                margin: "3",
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
                margin: "3",
                labelAlign: "right",
                columnWidth: .5
            })
            var SheJiUsers = Ext.create("Ext.form.field.Display", {
                fieldLabel: "设计人员",
                name: "SheJiUsers",
                id: "SheJiUsers",
                labelWidth: 130,
                margin: "3",
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
                //    readOnly: true,
                margin: "3",
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
                margin: "3",
                labelAlign: "right",
                columnWidth: .5,
                format: 'Y-m-d',
                listeners: { select: function (field, value, eOpts) {
                    if (Ext.getCmp('Stage').getValue() != '初审') {
                        StartTime.setValue(value);
                    }
                }
                }
            });
            var MajorName = Ext.create("Ext.form.field.Display", {
                fieldLabel: "专业",
                name: "MajorName",
                id: "MajorName",
                labelWidth: 130,
                margin: "3",
                labelAlign: "right",
                columnWidth: .5
            });
            var JiangZhuSheJi = {
                xtype: 'numberfield',
                fieldLabel: " 建筑设计(条)",
                name: "JiangZhuSheJi",
                labelWidth: 130,
                id: "JiangZhuSheJi",
                margin: "3",
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
                margin: "3",
                listeners: { change: function (str, isValid, eOpts) {
                    if (isValid || isValid==0) {
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
                margin: "3",
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
                margin: "3",
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
                margin: "3",
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
                margin: "3",
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
                margin: "3",
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
                margin: "3",
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
                margin: "3",
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
                margin: "3",
                labelAlign: "right",
                columnWidth: .5
            };
            var ShenChaOrganization = Ext.create("Ext.form.field.Display", {
                fieldLabel: " 审查机构",
                name: "ShenChaOrganization",
                labelWidth: 130,
                id: "ShenChaOrganization",
                margin: "5",
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
                margin: "3",
                height: 230,
                labelAlign: "right",
                enableFont: false,
                columnWidth: 1
                // fontFamilies: ["宋体", "隶书", "黑体", "西文", "1", "2"]
            });

            var formpanel = Ext.create('Ext.form.Panel', {
                title: "审查意见",
                region: 'center',
                items: [
                { xtype: "textfield", name: "Id", id: "Id", hidden: true },
                { xtype: "textfield", name: "ExamineTaskId", id: "ExamineTaskId", hidden: true },
                { xtype: "textfield", name: "ShenChaUserId", id: "ShenChaUserId", hidden: true },
                { xtype: "textfield", name: "FuHeUserId", id: "FuHeUserId", hidden: true },
                { layout: 'column', border: 0, items: [ZiXunCode, ProjectName] },
                { layout: 'column', border: 0, items: [ZhuCeUsers, SheJiUsers] },
                { xtype: 'textfield', fieldLabel: '审查阶段', labelAlign: 'right', readOnly: true, margin: '3', labelWidth: 130, name: 'Stage', anchor: '50%', id: 'Stage' },
                { layout: 'column', border: 0, items: [StartTime, EndTime] },
                { layout: 'column', border: 0, items: [MajorName, JiangZhuSheJi] },
                { layout: 'column', border: 0, items: [FangHuo, SheBei] },
                { layout: 'column', border: 0, items: [JiChu, JiGouSheJi] },
                { layout: 'column', border: 0, items: [KangZhenSheJi, JiaGu] },
                { layout: 'column', border: 0, items: [QiangTiao, ShenChaUserName] },
                { layout: 'column', border: 0, items: [FuHeUserName, ShenChaOrganization] },
                ExamineOpinions
            ],
                buttons: [
                { text: '保 存', handler: function () {
                    if (formpanel.getForm().isValid()) {
                        var json = formpanel.getForm().getValues();
                        Ext.Ajax.request({
                            url: 'ExamineOpinionView.aspx?action=saveopinion&id=' + id,
                            params: { formdata: Ext.encode(json) },
                            success: function (response) {
                                Ext.MessageBox.alert('提示', '保存成功！');
                            }
                        })
                    }
                }
                },
                { text: '导出到WORD', handler: function () {
                    Ext.Ajax.request({
                        url: 'ExamineOpinionView.aspx?action=export_shenchajilu',
                        params: { id: id },
                        success: function (response, opts) {
                            Ext.MessageBox.alert('提示', '导出成功!');
                        },
                        failure: function (response, opts) {
                            Ext.MessageBox.alert('提示', '导出失败!');
                        }
                    })
                }
                }, { text: '删 除', handler: function () {

                    var ExamineOpinionId = Ext.getCmp('Id').getValue();
                    var ExamineTaskId = Ext.getCmp('ExamineTaskId').getValue();
                    Ext.MessageBox.alert('提示', '确定删除吗？', function (str) {
                        if (str == 'ok') {
                            Ext.Ajax.request({
                                url: 'ExamineOpinionView.aspx',
                                params: { action: 'delete', ExamineOpinionId: ExamineOpinionId, ExamineTaskId: ExamineTaskId },
                                success: function (response, opts) {
                                    var json = Ext.decode(response.responseText);
                                    if (json.ExamineOpinionCount > 0) {
                                        window.location.reload();
                                    }
                                    else {
                                        window.close();
                                    }
                                }
                            });
                        }
                    });




                }
                }
                ],
                buttonAlign: 'center'
            });
            var panel = Ext.create('Ext.panel.Panel', {
                region: 'north',
                height: 30,
                html: '<div id="div1"></div>'
            })
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [panel, formpanel]
            })
            Ext.Ajax.request({
                url: 'ExamineOpinionView.aspx?action=loadtimes',
                params: { ExamineTaskId: ExamineTaskId },
                success: function (response) {
                    var json = Ext.decode(response.responseText);
                    var radioarray = [];
                    id = json.rows[0].Id
                    for (var i = 0; i < json.rows.length; i++) {
                        radioarray.push({ labelWidth: 90, margin: '0 10', boxLabel: json.rows[i].Stage, inputValue: json.rows[i].Id, name: 'rg', checked: i == 0 })
                    }
                    var radiogroup = Ext.create('Ext.form.RadioGroup', {
                        items: radioarray,
                        renderTo: 'div1',
                        listeners: {
                            change: function (rg, newValue, oldValue, eOpts) {
                                id = newValue.rg;
                                Ext.Ajax.request({
                                    url: 'ExamineOpinionView.aspx?action=loadopinion',
                                    params: { id: id },
                                    success: function (response) {
                                        var json = Ext.decode(response.responseText);
                                        formpanel.getForm().setValues(json.formdata);
                                    }
                                })
                            }
                        }
                    })
                    formpanel.getForm().setValues(json.formdata);
                }
            })
        })
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
        function doprint(url) {
            try {
                var LODOP = document.getElementById("LODOP"); //这行语句是为了符合DTD规范
                LODOP.PRINT_INIT("");
                LODOP.NewPage();
                // LODOP.ADD_PRINT_URL(20, 18, 750, 1050, url);
                LODOP.ADD_PRINT_URL(20, 18, 750, 1050, url);
                LODOP.PREVIEW();
            }
            catch (ex) {
                alert("未安装打印控件，请安装打印控件");
                window.open("/install_lodop.rar", "print", "");
            }
        } 
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0"
            height="0">
        </object>
    </div>
    </form>
</body>
</html>
