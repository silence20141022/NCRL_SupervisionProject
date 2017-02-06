<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectFileZXEdit.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ProjectFileZXEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var ProjectId = getQueryString("ProjectId");
        var ProjectName = getQueryString("ProjectName");
        Ext.onReady(function () {
            var file = Ext.create("Ext.form.field.File", {
                name: "File",
                fieldLabel: "上传文件",
                msgTarget: "under",
                margin: "10",
                labelAlign: "right",
                allowBlank: false,
                emptyText: "请选择文件",
                blankText: "上传文件不能为空!",
                buttonText: "浏览...",
                anchor: "90%"
            });
            var formpanel = Ext.create("Ext.form.Panel", {
                title: "文件上传",
                frame: true,
                layout: "anchor",
                region: "center",
                defaults: { labelAlign: "right", xtype: "textfield", msgTarget: "under", margin: "10" },
                items: [
                { name: "ProjectId", hidden: true, id: "ProjectId" },
                { name: "Name", anchor: "90%", id: "Name", fieldLabel: "项目名称" },
                file,
                { name: "FullId", anchor: "90%", height: 150, fieldLabel: "描述", xtype: "textarea"}//将文件表的FullId存储备注信息
              ],
                buttons: [{ text: "上 传", handler: function () {
                    if (formpanel.getForm().isValid()) {
                        var formdata = formpanel.getForm().getValues();
                        formpanel.getForm().submit({
                            url: "ProjectFileZXEdit.aspx",
                            params: { action: "upload", json: Ext.encode(formdata) },
                            waitMsg: "文件上传中", //提示等待信息  
                            success: function () {
                                Ext.MessageBox.alert("提示", "文件上传成功", function () {
                                    window.opener.store.load();
                                    window.close();
                                });
                            }
                        });
                    }
                }
                }, { text: "取 消", handler: function () {
                    window.close();
                }
                }],
                buttonAlign: "center"
            });

            var viewport = Ext.create("Ext.container.Viewport", {
                layout: "border",
                items: [formpanel]
            });
            Ext.getCmp("Name").setValue(ProjectName);
            Ext.getCmp("ProjectId").setValue(ProjectId);
        });
        function SetPage() {


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
