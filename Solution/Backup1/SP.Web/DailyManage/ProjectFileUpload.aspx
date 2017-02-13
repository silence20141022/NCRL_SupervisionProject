<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectFileUpload.aspx.cs"
    Inherits="SP.Web.DailyManage.ProjectFileUpload" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../Extjs42/TreePicker.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var projectid = getQueryString("projectid");
        var groupid = getQueryString("groupid");
        var formpanel;
        Ext.onReady(function () {
            Ext.regModel('TreeModel', { fields: ['id', 'text', 'leaf', 'parentid'] })
            var treestore = Ext.create('Ext.data.TreeStore', {
                // fields: ['id', 'text', 'leaf', 'parentid'],
                model: 'TreeModel',
                root: {
                    text: '所有分类',
                    id: 'cf38bd7a-79d1-46fb-bf06-640b30f61654',
                    expanded: true
                },
                proxy: {
                    type: 'ajax',
                    url: 'ProjectFileUpload.aspx?action=loadfiletype',
                    reader: { type: 'json' }
                },
                nodeParam: 'id'
            })
            var fileType = Ext.create('Ext.ux.TreePicker', {
                name: 'SecondTypeId',
                fieldLabel: '文件类型',
                allowBlank: false,
                emptyText: '请选择文件类型',
                blankText: '文件类型为必选项!',
                msgTarget: 'under',
                labelAlign: 'right',
                valueField: 'id',
                displayField: 'text',
                forceSelection: true,
                editable: false,
                margin: '10',
                // minPickerHeight: 200,select( picker, record, eOpts )
                anchor: "50%",
                store: treestore,
                listeners: { select: function (picker, record, eOpts) {
                    if (record.get("leaf")) {
                        formpanel.getForm().findField("FirstTypeId").setValue(record.get("parentid"));
                    }
                    else {
                        alert("请选择二级文件类型!");
                        formpanel.getForm().findField("SecondTypeId").setValue("");
                    }
                }
                }
            });
            var file = Ext.create('Ext.form.field.File', {
                name: 'projectfile',
                fieldLabel: '上传文件',
                msgTarget: 'under',
                margin: '10',
                labelAlign: 'right',
                allowBlank: false,
                emptyText: '请选择文件',
                blankText: '上传文件为必选项!',
                buttonText: '浏览...',
                anchor: '90%'
            })
            formpanel = Ext.create('Ext.form.Panel', {
                title: '文件上传',
                frame: true,
                layout: 'anchor',
                region: 'center',
                items: [
                { xtype: 'textfield', fieldLabel: '所属部门', labelAlign: 'right', readOnly: true, name: 'GroupName', margin: '10', anchor: '50%' },
                { xtype: 'textfield', fieldLabel: '项目名称', labelAlign: 'right', readOnly: true, name: 'ProjectName', margin: '10', anchor: "50%" },
                fileType, file,
                { xtype: 'displayfield', fieldLabel: '说明', margin: '10', labelAlign: 'right', value: '上传文件主要分为部门文件和项目文件,根据父页面选中的节点系统自动判断' },
                { xtype: 'textfield', name: 'FirstTypeId', hidden: true}],
                buttons: [{ text: '上 传', handler: function () {
                    if (formpanel.getForm().isValid()) {
                        var formdata = formpanel.getForm().getValues();
                        formpanel.getForm().submit({
                            url: 'ProjectFileUpload.aspx?action=upload&groupid=' + groupid + '&projectid=' + projectid + "&formdata=" + Ext.encode(formdata),
                            waitMsg: '文件上传中...', //提示等待信息  
                            success: function () {
                                Ext.Msg.alert('提示', '文件上传成功', function () {
                                    window.close();
                                });
                            }
                        });
                    }
                }
                }, { text: '取 消', handler: function () {
                    window.close();
                }
                }],
                buttonAlign: 'center'
            })
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [formpanel]
            })
            //            treestore.addListener('load', function () {
            //                if (secondtypeid) {
            //                    alert(secondtypeid);
            //                    var treeobject = Ext.ModelMgr.create({ id: '2bb55d9c-2308-4c26-8fb1-d25d21e39fd4', text: '监理机构设置' }, 'TreeModel');
            //                    
            //                }
            //            });
            Ext.Ajax.request({
                url: 'ProjectFileUpload.aspx?action=getprojectname&projectid=' + projectid + "&groupid=" + groupid,
                method: 'POST',
                callback: function (options, success, response) {
                    var jo = Ext.decode(response.responseText);
                    if (jo.GroupName) {
                        formpanel.getForm().findField("GroupName").setValue(jo.GroupName);
                    }
                    if (jo.ProjectName) {
                        formpanel.getForm().findField("ProjectName").setValue(jo.ProjectName);
                    }
                    //{ id: '2bb55d9c-2308-4c26-8fb1-d25d21e39fd4', text: '监理机构设置' }
                    //                    fileType.setRawValue('监理机构设置');
                    //                    fileType.setValue('2bb55d9c-2308-4c26-8fb1-d25d21e39fd4');
                }
            })
        })
    </script>
</head>
<body>
</body>
</html>
