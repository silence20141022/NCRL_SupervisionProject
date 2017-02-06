<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShenChaReport_KanCha_Edit.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ShenChaReport_KanCha_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>工程勘察审核报告</title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var Investment, DetailLocation, EngineeringLevel, KanChaZZLevel, DetailLocation, GongChenLiang;
        var SheJiUnitHead, SheJiUnitGrade, Height, CengShu, BuildingArea, JianSheUnit, JianSheUnitHead;
        var ProjectId = getQueryString("ProjectId");
        Ext.onReady(function () {
            var ShenChaNo = {
                xtype: "textfield",
                name: "ShenChaNo",
                fieldLabel: '审查报告编号',
                labelAlign: 'right',
                columnWidth: .5,
                msgTarget: 'under',
                labelWidth: 150,
                allowBlank: false,
                margin: '7',
                blankText: '编号不能为空!',
                validateOnChange: true,
                validator: function (val) {
                    if (!val) {
                        return true;
                    }
                    var ischeck;
                    Ext.Ajax.request({
                        url: "ShenChaReport_FWJZ.aspx",
                        async: false,
                        params: { action: "check", check: val, ProjectId: ProjectId },
                        callback: function (option, success, response) {
                            var JSONArr = Ext.decode(response.responseText);
                            ischeck = JSONArr.ischeck;
                        }
                    });
                    if (ischeck == 1) {
                        return "该编号已存在!";
                    } else {
                        return true;
                    }
                }
            }
            var ProjectName = {
                xtype: "textfield",
                name: "ProjectName",
                fieldLabel: '建设项目名称',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                readOnly: true,
                margin: '7'
            }
            var Opinion1 = {
                xtype: 'htmleditor',
                name: "Opinion1",
                fieldLabel: '审查意见',
                labelAlign: 'right',
                height: 150,
                columnWidth: 1,
                enableFont: false,
                margin: '7'
            }
            var Opinion1ShenChaName = {
                xtype: "textfield",
                name: "Opinion1ShenChaName",
                fieldLabel: '审查人员',
                labelAlign: 'right',
                columnWidth: .5,
                margin: '7'
            }
            var Opinion1CreateTime = {
                xtype: "datefield",
                name: "Opinion1CreateTime",
                id: "Opinion1CreateTime",
                fieldLabel: '审查时间',
                labelAlign: 'right',
                columnWidth: .5,
                margin: '7',
                format: 'Y-m-d',
                Value: new Date()
            }
            var Opinion2 = {
                xtype: 'htmleditor',
                name: "Opinion2",
                fieldLabel: '审查意见',
                labelAlign: 'right',
                height: 150,
                columnWidth: 1,
                enableFont: false,
                margin: '7'
            }
            var Opinion2ShenChaName = {
                xtype: "textfield",
                name: "Opinion2ShenChaName",
                fieldLabel: '审查人员',
                labelAlign: 'right',
                columnWidth: .5,
                margin: '7'
            }
            var Opinion2CreateTime = {
                xtype: "datefield",
                name: "Opinion2CreateTime",
                id: "Opinion2CreateTime",
                fieldLabel: '审查时间',
                labelAlign: 'right',
                columnWidth: .5,
                margin: '7',
                format: 'Y-m-d',
                Value: new Date()
            }
            var Opinion3 = {
                xtype: 'htmleditor',
                name: "Opinion3",
                fieldLabel: '审查意见',
                labelAlign: 'right',
                height: 150,
                columnWidth: 1,
                enableFont: false,
                margin: '7'
            }
            var Opinion3ShenChaName = {
                xtype: "textfield",
                name: "Opinion3ShenChaName",
                fieldLabel: '审查人员',
                labelAlign: 'right',
                columnWidth: .5,
                margin: '7'
            }
            var Opinion3CreateTime = {
                xtype: "datefield",
                name: "Opinion3CreateTime",
                id: "Opinion3CreateTime",
                fieldLabel: '审查时间',
                labelAlign: 'right',
                columnWidth: .5,
                margin: '7',
                format: 'Y-m-d',
                Value: new Date()
            }
            var Opinion4 = {
                xtype: 'htmleditor',
                name: "Opinion4",
                fieldLabel: '审查意见',
                labelAlign: 'right',
                height: 150,
                columnWidth: 1,
                enableFont: false,
                margin: '7'
            }
            var Opinion4ShenChaName = {
                xtype: "textfield",
                name: "Opinion4ShenChaName",
                fieldLabel: '审查人员',
                labelAlign: 'right',
                columnWidth: .5,
                margin: '7'
            }
            var Opinion4CreateTime = {
                xtype: "datefield",
                name: "Opinion4CreateTime",
                id: "Opinion4CreateTime",
                fieldLabel: '审查时间',
                labelAlign: 'right',
                columnWidth: .5,
                margin: '7',
                format: 'Y-m-d',
                Value: new Date()
            }
            var field_Remark = {
                xtype: 'textarea',
                name: "Remark",
                fieldLabel: '备注',
                labelAlign: 'right',
                height: 150,
                columnWidth: 1,
                margin: '7'
            }
            var ShenCha = Ext.create("Ext.form.Panel", {
                title: '工程勘察审核报告',
                region: 'center',
                autoScroll: true,
                items: [
                        { layout: 'column', border: 0, margin: '10', items: [ShenChaNo, ProjectName] },
                 {
                     xtype: 'fieldset',
                     title: '1.勘察报告提供的数据是否真实可靠；<br/>2.报告手续是否齐全；<br/>3.是否按规定盖有出图章和签署，资质与项目规模是否匹配；<br/>4.工程基础（含软基）处理是否安全、可靠。（宏观、大的方面的审查）',
                     collapsible: true,
                     margin: '10',
                     items: [
                        { layout: 'column', border: 0, items: [Opinion1] },
                        { layout: 'column', border: 0, items: [Opinion1ShenChaName, Opinion1CreateTime] }
                        ]
                 },
                    {
                        xtype: 'fieldset',
                        title: '是否符合有关工程强制性标准规范（违反强标方面的审查）',
                        collapsible: true,
                        margin: '10',
                        items: [
                        { layout: 'column', border: 0, items: [Opinion2] },
                        { layout: 'column', border: 0, items: [Opinion2ShenChaName, Opinion2CreateTime] }
                        ]
                    },
                    {
                        xtype: 'fieldset',
                        title: '按照建设部和省里的岩土工程勘察报告审查要点的审查',
                        margin: '10',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion3] },
                        { layout: 'column', border: 0, items: [Opinion3ShenChaName, Opinion3CreateTime] }
                        ]
                    },
                    {
                        xtype: 'fieldset',
                        title: '施工图审查机构综合结论',
                        margin: '10',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion4] },
                        { layout: 'column', border: 0, items: [Opinion4ShenChaName, Opinion4CreateTime] }
                        ]
                    },
                        { layout: 'column', border: 0, margin: '10', items: [field_Remark] }
                ],
                buttonAlign: "center",
                buttons: [
                { text: '保 存', handler: function () {
                    var str = ShenCha.getForm().getValues();
                    Ext.Ajax.request({
                        url: "ShenChaReport_KanCha_Edit.aspx?action=update",
                        params: { ProjectId: ProjectId, json: Ext.encode(str) },
                        success: function (response, opts) {
                            Ext.MessageBox.alert("提示", "保存成功!");
                        },
                        failure: function (response, opts) {
                            Ext.MessageBox.alert("提示", "保存失败!");
                        }
                    });
                }
                },
                { text: "导出到WORD", handler: function () {
                    Ext.Ajax.request({
                        url: "ProjectList.aspx?action=export_kanchashenchabaogao",
                        params: { id: ProjectId },
                        success: function (response, opts) {
                            Ext.MessageBox.alert('提示', '导出成功!');
                        },
                        failure: function (response, opts) {
                            Ext.MessageBox.alert('提示', '导出失败!');
                        }
                    });
                }
                }]
            });
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [ShenCha]
            })
            ShenCha.getForm().load({
                url: "ShenChaReport_KanCha_Edit.aspx?action=loadform",
                params: { ProjectId: ProjectId },
                success: function (form, action) {
                    if (action.result.data.Opinion1CreateTime) {
                        var str1 = new Date(action.result.data.Opinion1CreateTime);
                        Ext.getCmp("Opinion1CreateTime").setValue(str1);
                    }
                    if (action.result.data.Opinion2CreateTime) {
                        var str2 = new Date(action.result.data.Opinion2CreateTime);
                        Ext.getCmp("Opinion2CreateTime").setValue(str2);
                    }
                    if (action.result.data.Opinion3CreateTime) {
                        var str3 = new Date(action.result.data.Opinion3CreateTime);
                        Ext.getCmp("Opinion3CreateTime").setValue(str3);
                    }
                    if (action.result.data.Opinion4CreateTime) {
                        var str4 = new Date(action.result.data.Opinion4CreateTime);
                        Ext.getCmp("Opinion4CreateTime").setValue(str4);
                    }
                }
            });
        });
        function Update() {
            ShenCha.getForm().load({
                url: "ShenChaReport_FWJZ.aspx",
                params: { action: "SelectEdit", ProjectId: ProjectId },
                method: "POST",
                success: function (form, action) {
                    if (action.result.data.Opinion1CreateTime) {
                        var str1 = new Date(action.result.data.Opinion1CreateTime);
                        Ext.getCmp("Opinion1CreateTime").setValue(str1);
                    }
                    if (action.result.data.Opinion2CreateTime) {
                        var str2 = new Date(action.result.data.Opinion2CreateTime);
                        Ext.getCmp("Opinion2CreateTime").setValue(str2);
                    }

                    if (action.result.data.Opinion3CreateTime) {
                        var str3 = new Date(action.result.data.Opinion3CreateTime);
                        Ext.getCmp("Opinion3CreateTime").setValue(str3);
                    }

                    if (action.result.data.Opinion4CreateTime) {
                        var str4 = new Date(action.result.data.Opinion4CreateTime);
                        Ext.getCmp("Opinion4CreateTime").setValue(str4);

                    }
                    if (action.result.data.Opinion5CreateTime) {
                        var str5 = new Date(action.result.data.Opinion5CreateTime);
                        Ext.getCmp("Opinion5CreateTime").setValue(str5);
                    }
                    var ShenChaId = Ext.getCmp("Id").getValue();
                    if (!ShenChaId) {
                        Ext.getCmp("Opinion1").setValue("1、提供的有关设计参数稳妥可靠，能满足设计要求。<br/>2、按规定盖有出图章和签署，资质与项目规模匹配。<br/>3、有关场区工程地质条件评价较准确。<br/>4、结论及建议较完整、合理。 ")
                    }
                }
            });
        }
        function create() {
            if (ShenCha.getForm().isValid()) {
                var ShenChaId = Ext.getCmp("Id").getValue();
                var action = ShenChaId ? "Update" : "Create";
                var str = ShenCha.getForm().getValues();
                var json = Ext.encode(str);
                Ext.Ajax.request({
                    url: "ShenChaReport_FWJZ.aspx",
                    async: false,
                    params: { action: action, json: json, ProjectId: ProjectId },
                    callback: function (option, success, response) {
                        var json = Ext.JSON.decode(response.responseText);
                        var ShenChaId = json.ShenChaId;
                        if (ShenChaId) {
                            Ext.getCmp("Id").setValue(ShenChaId);
                            Ext.getCmp("ProjectId").setValue(ProjectId);
                            Ext.Msg.alert("提示", "保存成功!");
                        }
                    }
                });
            }
        } 
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div>
            <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0"
                height="0">
            </object>
        </div>
    </div>
    </form>
</body>
</html>
