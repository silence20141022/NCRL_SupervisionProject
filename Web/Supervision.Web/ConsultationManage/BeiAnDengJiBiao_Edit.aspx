<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BeiAnDengJiBiao_Edit.aspx.cs"
    Inherits="SP.Web.ConsultationManage.BeiAnDengJiBiao_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var ProjectId = getQueryString("ProjectId");
        Ext.onReady(function () {
            var field_ProjectName = Ext.create('Ext.form.field.Text', {
                fieldLabel: '项目名称',
                labelWidth: 150,
                anchor: '80%',
                labelAlign: 'right',
                readOnly: true,
                name: 'ProjectName'
            })
            var field_ZhuGuanDeptName = Ext.create('Ext.form.field.Text', {
                fieldLabel: '建设行政主管部门',
                labelWidth: 150,
                anchor: '80%',
                labelAlign: 'right',
                name: 'ZhuGuanDeptName'
            })
            var field_BeiAnNo = Ext.create('Ext.form.field.Text', {
                fieldLabel: '备案号码',
                labelAlign: 'right',
                labelWidth: 150,
                anchor: '80%',
                name: 'BeiAnNo'
            })
            var field_JingBanRenOpinion = Ext.create('Ext.form.field.TextArea', {
                fieldLabel: '经办人员意见',
                labelAlign: 'right',
                labelWidth: 150,
                anchor: '80%',
                height: 150,
                name: 'JingBanRenOpinion'
            })
            var field_FuZeRenOpinion = Ext.create('Ext.form.field.TextArea', {
                fieldLabel: '负责人意见',
                labelAlign: 'right',
                labelWidth: 150,
                anchor: '80%',
                height: 150,
                name: 'FuZeRenOpinion'
            })
            var formpanel = Ext.create('Ext.form.Panel', {
                title: '审查备案登记表',
                region: 'center',
                defaults: { margin: '15' },
                items: [
                field_ProjectName,
                field_ZhuGuanDeptName,
                field_BeiAnNo, field_JingBanRenOpinion, field_FuZeRenOpinion
            ],
                buttonAlign: 'center',
                buttons: [{ text: '保 存', handler: function () {
                    if (formpanel.getForm().isValid()) {
                        var json = Ext.encode(formpanel.getForm().getValues());
                        Ext.Ajax.request({
                            url: "BeiAnDengJiBiao_Edit.aspx?action=update",
                            params: { json: json, ProjectId: ProjectId },
                            success: function (option, success, response) {
                                Ext.Msg.alert("提示", "保存成功!");
                            }
                        });
                    }
                }
                }, { text: '导出到WORD', handler: function () {
                    Ext.Ajax.request({
                        url: "ProjectList.aspx?action=export_beiandengjibiao",
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
            })
            var viewport = Ext.create('Ext.container.Viewport', {
                items: [formpanel]
            })
            formpanel.getForm().load({
                url: "BeiAnDengJiBiao_Edit.aspx?action=loadform",
                params: { ProjectId: ProjectId },
                success: function (form, action) {
                    //                    if (!Ext.getCmp("Id").getValue()) {
                    //                        Ext.getCmp("Opinion3").setValue("未提供初步设计文件");
                    //                        Ext.getCmp("Opinion4").setValue(" 1.按审查意见修改后，基本达到建设部《市政公用工程设计文件编制深度规定》和省有关规定要求。<br/>2.施工图设计按规定盖有出图章和签署。")
                    //                        Ext.getCmp("Opinion5").setValue("符合公众利益。");
                    //                    }
                }
            });
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
