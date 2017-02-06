<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShenChaReport_JiKeng.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ShenChaReport_JiKeng" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>基坑支护</title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var ProjectName, Investment, DetailLocation, EngineeringLevel, KanChaZZLevel, DetailLocation, GongChenLiang;
        var SheJiUnitHead, SheJiUnitGrade, Height, CengShu, BuildingArea, JianSheUnit, JianSheUnitHead;
        var ShenChaNo;
        var ShenCha;
        var ProjectId = getQueryString("ProjectId");
        Ext.onReady(function () {
            ShenChaNo = {
                xtype: "textfield",
                name: "ShenChaNo",
                fieldLabel: '审查报告编号',
                labelAlign: 'right',
                columnWidth: .5,
                msgTarget: 'under',
                labelWidth: 150,
                allowBlank: false,
                margin: '7',
                blankText: '审查报告编号不能为空!',
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
                        return "该编号页存在!";
                    } else {
                        return true;
                    }
                }
            }
            ProjectName = {
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
                id: "Opinion1",
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
            //---------------------------
            var Opinion2 = {
                xtype: 'htmleditor',
                name: "Opinion2",
                id: "Opinion2",
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
            //---------------------------
            var Opinion3 = {
                xtype: 'htmleditor',
                name: "Opinion3",
                id: "Opinion3",
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
            //---------------------------
            Opinion4 = {
                xtype: 'htmleditor',
                name: "Opinion4",
                id: "Opinion4",
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
            //---------------------------
            Opinion5 = {
                xtype: 'textarea',
                name: "Opinion5",
                id: "Opinion5",
                fieldLabel: '备注',
                labelAlign: 'right',
                height: 150,
                columnWidth: 1,
                margin: '7'
            }
            ShenCha = Ext.create("Ext.form.Panel", {
                title: '基坑支护审查报告',
                region: 'center',
                autoScroll: true,
                items: [
                {
                    xtype: 'fieldset',
                    title: '项目基本信息',
                    collapsible: true,
                    items: [
                        { layout: 'column', border: 0, items: [ShenChaNo, ProjectName] },
                        { xtype: 'textfield', hidden: true, name: 'Id', id: "Id" },
                        { xtype: "textfield", hidden: true, name: "ProjectId", id: "ProjectId" }
                        ]
                },
                 {
                     xtype: 'fieldset',
                     title: '1.是否按专家提出的设计方案审查意见进行施工图设计<br/>2.深基坑支护结构体系是否安全、可靠、无明显的不安全因素',
                     collapsible: true,
                     items: [
                        { layout: 'column', border: 0, items: [Opinion1] },
                        { layout: 'column', border: 0, items: [Opinion1ShenChaName, Opinion1CreateTime] }
                        ]
                 },
                    {
                        xtype: 'fieldset',
                        title: '1是否达到建设部《建筑工程设计文件编制深度的规定》和省有关规定要求<br/>2.施工图是否按规定盖有出图章和签署',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion2] },
                        { layout: 'column', border: 0, items: [Opinion2ShenChaName, Opinion2CreateTime] }
                        ]
                    },
                    {
                        xtype: 'fieldset',
                        title: '1.本深基坑工程是否进行坑震设计<br/>2.是否损害公众利益',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion3] },
                        { layout: 'column', border: 0, items: [Opinion3ShenChaName, Opinion3CreateTime] }
                        ]
                    },
                    {
                        xtype: 'fieldset',
                        title: '施工图审查机构综合结构 ',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion4] },
                        { layout: 'column', border: 0, items: [Opinion4ShenChaName, Opinion4CreateTime] }
                        ]
                    },
                    {
                        xtype: 'fieldset',
                        title: '备 注',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion5] }
                        ]
                    }
                ],
                buttonAlign: "center",
                buttons: [
                { text: '保 存', handler: create },
                { text: "导出到WORD", handler: function () {
                    Ext.Ajax.request({
                        url: "ProjectList.aspx?action=export_shenchabaogao",
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
              ]
            });
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [ShenCha]
            })
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
                    var ShenChaId = Ext.getCmp("Id").getValue();
                    if (!ShenChaId) {
                        Ext.getCmp("Opinion1").setValue(" 1.本深基坑工程施工图设计是按专家提出的设计方案审查意见进行的。<br/>2.深基坑支护结构体系是否安全、可靠、无明显的不安全因素。")
                        Ext.getCmp("Opinion2").setValue(" 1.达到建设部《建筑工程设计文件编制深度的规定》和省有关规定要求，并已按施工图审查意见（详附件）要求整改完毕。<br/>2.施工图设计按规定盖有出图章和签署。")
                        Ext.getCmp("Opinion3").setValue(" 1.本深基坑大程位于坑震设防区，已按规范要求进行六度坑震设防设计;<br/>2.未损害公众利益。");
                        Ext.getCmp("Opinion4").setValue("送审的施工图设计经整改后符合国家《工程建设标准强制性条文》（房屋建筑部分2009年版）及《建筑基坑支护技术规范》JGJ120--2012等国家和本省的各种建筑工程设计规范、标准的要求。");
                    }
                }
            });
        });
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
        <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0"
            height="0">
        </object>
    </div>
    </form>
</body>
</html>
