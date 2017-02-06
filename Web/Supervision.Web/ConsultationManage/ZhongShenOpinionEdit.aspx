<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ZhongShenOpinionEdit.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ZhongShenOpinionEdit" %>

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
            var ProjectName = {
                name: "ProjectName",
                fieldLabel: "项目名称"
            }
            var MajorName = {
                name: "MajorName",
                fieldLabel: "专业名称"
            }
            var field_ZhongShenOpinion = Ext.create('Ext.form.field.TextArea', {
                name: "ZhongShenOpinion",
                fieldLabel: "终审意见",
                id: "ZhongShenOpinion",
                labelAlign: 'right',
                readOnly: false,
                height: 200
            })
            var ShenChaName = {
                name: "ShenChaName",
                fieldLabel: "审查人"
            }
            var FuHeName = {
                name: "FuHeName",
                fieldLabel: "复核人"
            }
            var formPanel = Ext.create("Ext.form.Panel", {
                region: "center",
                title: "审查终审意见表",
                defaults: { labelAlign: "right", xtype: "textfield", margin: "15", anchor: "80%", readOnly: true },
                items: [
                    ProjectName, MajorName, field_ZhongShenOpinion,
                    ShenChaName, FuHeName
                ],
                buttons: [
                { text: "保 存", handler: function () {
                    var str = formPanel.getForm().getValues();
                    Ext.Ajax.request({
                        url: "ZhongShenOpinionEdit.aspx?action=update",
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
                        url: "ProjectList.aspx?action=export_zhongshenyijianbiao",
                        params: { id: ProjectId },
                        success: function (response, opts) {
                            Ext.MessageBox.alert('提示', '导出成功!');
                        },
                        failure: function (response, opts) {
                            Ext.MessageBox.alert('提示', '导出失败!');
                        }
                    });
                }
                }
                ],
                buttonAlign: "center"
            })
            var viewport = Ext.create("Ext.container.Viewport", {
                layout: "border",
                items: [formPanel]
            });
            formPanel.getForm().load({
                url: "ZhongShenOpinionEdit.aspx?action=loadform",
                params: { ProjectId: ProjectId },
                success: function (form, action) {
                }
            });
        });       
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    </div>
    </form>
</body>
</html>
