<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShenChaReport_SZ.aspx.cs"
    Inherits="SP.Web.ConsultationManage.ShenChaReport_SZ" %>

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
            var ShenChaNo = Ext.create('Ext.form.field.Text', {
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
                        return "该编号页存在!";
                    } else {
                        return true;
                    }
                }
            })
            var ProjectName = Ext.create('Ext.form.field.Display', {
                name: "ProjectName",
                fieldLabel: '建设项目名称',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            });
            var Investment = Ext.create('Ext.form.field.Display', {
                name: "Investment",
                fieldLabel: '投资额(万元)',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            })
            var GongChenLiang = Ext.create('Ext.form.field.Display', {
                name: "GongChenLiang",
                fieldLabel: '工程量',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            })
            var DetailLocation = Ext.create('Ext.form.field.Display', {
                name: "DetailLocation",
                fieldLabel: '建设地点',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            })
            var EngineeringLevel = Ext.create('Ext.form.field.Display', {
                name: "EngineeringLevel",
                fieldLabel: '规模等级',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            })
            var JianSheUnit = Ext.create('Ext.form.field.Display', {
                name: "JianSheUnit",
                fieldLabel: '建设单位名称',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            })
            var JianSheUnitHead = Ext.create('Ext.form.field.Display', {
                name: "JianSheUnitHead",
                fieldLabel: '建设单位项目负责人',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            })
            var KanChaUnit = Ext.create('Ext.form.field.Display', {
                name: "KanChaUnit",
                fieldLabel: '勘察单位名称',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            })
            var KanChaUnitHead = Ext.create('Ext.form.field.Display', {
                name: "KanChaUnitHead",
                fieldLabel: '勘察单位项目负责人',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            })
            var KanChaZZLevel = Ext.create('Ext.form.field.Display', {
                name: "KanChaZZLevel",
                fieldLabel: '勘察单位资质等级',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            })
            var KanChaUnitZSNo = Ext.create('Ext.form.field.Display', {
                name: "KanChaUnitZSNo",
                fieldLabel: '勘察单位证书编号',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            })
            var SheJiUnit = Ext.create('Ext.form.field.Display', {
                name: "SheJiUnit",
                fieldLabel: '设计单位名称',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            })
            var SheJiUnitHead = Ext.create('Ext.form.field.Display', {
                name: "SheJiUnitHead",
                fieldLabel: '设计单位项目负责人',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            })
            var SheJiUnitGrade = Ext.create('Ext.form.field.Display', {
                name: "SheJiUnitGrade",
                fieldLabel: '设计单位资质等级',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            })
            var SheJiUnitZSNo = Ext.create('Ext.form.field.Display', {
                name: "SheJiUnitZSNo",
                fieldLabel: '设计单位证书编号',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                margin: '7'
            })
            var Opinion1 = {
                xtype: 'htmleditor',
                name: "Opinion1",
                fieldLabel: '审查报告',
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
                fieldLabel: '审查报告',
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
                fieldLabel: '审查报告',
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
            var Opinion4 = {
                xtype: 'htmleditor',
                name: "Opinion4",
                id: "Opinion4",
                fieldLabel: '审查报告',
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
            var Opinion5 = {
                xtype: 'htmleditor',
                name: "Opinion5",
                id: "Opinion5",
                fieldLabel: '审查报告',
                labelAlign: 'right',
                height: 150,
                columnWidth: 1,
                enableFont: false,
                margin: '7'
            }
            var Opinion5ShenChaName = {
                xtype: "textfield",
                name: "Opinion5ShenChaName",
                fieldLabel: '审查人员',
                labelAlign: 'right',
                columnWidth: .5,
                margin: '7'
            }
            var Opinion5CreateTime = {
                xtype: "datefield",
                name: "Opinion5CreateTime",
                id: "Opinion5CreateTime",
                fieldLabel: '审查时间',
                labelAlign: 'right',
                columnWidth: .5,
                margin: '7',
                format: 'Y-m-d',
                Value: new Date()
            }
            //---------------------------
            var Opinion6 = {
                xtype: 'htmleditor',
                name: "Opinion6",
                id: "Opinion6",
                fieldLabel: '审查报告',
                labelAlign: 'right',
                height: 150,
                columnWidth: 1,
                enableFont: false,
                margin: '7'
            }
            var Opinion6ShenChaName = {
                xtype: "textfield",
                name: "Opinion6ShenChaName",
                fieldLabel: '审查人员',
                labelAlign: 'right',
                columnWidth: .5,
                margin: '7'
            }
            var Opinion6CreateTime = {
                xtype: "datefield",
                name: "Opinion6CreateTime",
                id: "Opinion6CreateTime",
                fieldLabel: '审查时间',
                labelAlign: 'right',
                columnWidth: .5,
                margin: '7',
                format: 'Y-m-d',
                Value: new Date()
            }
            //---------------------------
            var Opinion7 = {
                xtype: 'htmleditor',
                name: "Opinion7",
                fieldLabel: '审查报告',
                labelAlign: 'right',
                height: 150,
                columnWidth: 1,
                enableFont: false,
                margin: '7'
            }
            var Opinion7ShenChaName = {
                xtype: "textfield",
                name: "Opinion7ShenChaName",
                fieldLabel: '审查人员',
                labelAlign: 'right',
                columnWidth: .5,
                margin: '7'
            }
            var Opinion7CreateTime = {
                xtype: "datefield",
                name: "Opinion7CreateTime",
                id: "Opinion7CreateTime",
                fieldLabel: '审查时间',
                labelAlign: 'right',
                columnWidth: .5,
                margin: '7',
                format: 'Y-m-d',
                Value: new Date()
            }
            var formpanel = Ext.create("Ext.form.Panel", {
                title: '市政工程审查报告',
                region: 'center',
                autoScroll: true,
                items: [
                {
                    xtype: 'fieldset', margin: '5',
                    title: '项目基本信息',
                    collapsible: true,
                    items: [
                        { layout: 'column', border: 0, items: [ShenChaNo, ProjectName] },
                    //                        { layout: 'column', border: 0, items: [Investment, GongChenLiang] },
                    //                        { layout: 'column', border: 0, items: [DetailLocation, EngineeringLevel] },
                    //                        { layout: 'column', border: 0, items: [JianSheUnit, JianSheUnitHead] },
                    //                        { layout: 'column', border: 0, items: [KanChaUnit, KanChaUnitHead] },
                    //                        { layout: 'column', border: 0, items: [KanChaZZLevel, KanChaUnitZSNo] },
                    //                        { layout: 'column', border: 0, items: [SheJiUnit, SheJiUnitHead] },
                    //                        { layout: 'column', border: 0, items: [SheJiUnitGrade, SheJiUnitZSNo] },
                        {xtype: 'textfield', hidden: true, name: 'Id', id: "Id" },
                        { xtype: "textfield", hidden: true, name: "ProjectId", id: "ProjectId" }
                        ]
                },
                    {
                        xtype: 'fieldset', margin: '5',
                        title: '1.工程基础(含软基)处理是否安全、可靠。<br/>2.工程结构体系是否安全、可靠。<br/>3.工程配套结构(涵管、档土墙)是否安全、可靠。',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion1] },
                        { layout: 'column', border: 0, items: [Opinion1ShenChaName, Opinion1CreateTime] }
                        ]
                    },
                    {
                        xtype: 'fieldset', margin: '5',
                        title: '是否符合有关工程强制性标准规范',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion2] },
                        { layout: 'column', border: 0, items: [Opinion2ShenChaName, Opinion2CreateTime] }
                        ]
                    },
                    {
                        xtype: 'fieldset', margin: '5',
                        title: '是否按批准的初步设计文件进行施工图设计',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion3] },
                        { layout: 'column', border: 0, items: [Opinion3ShenChaName, Opinion3CreateTime] }
                        ]
                    },
                    {
                        xtype: 'fieldset', margin: '5',
                        title: '1.是否达到建设部《市政公用工程设计文件编制深度的规定》和省有关规定要求；<br/>2.施工图是否按规定盖有出图章和签署。',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion4] },
                        { layout: 'column', border: 0, items: [Opinion4ShenChaName, Opinion4CreateTime] }
                        ]
                    }
                    ,
                    {
                        xtype: 'fieldset', margin: '5',
                        title: '是否损害公众利益',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion5] },
                        { layout: 'column', border: 0, items: [Opinion5ShenChaName, Opinion5CreateTime] }
                        ]
                    },
                    {
                        xtype: 'fieldset', margin: '5',
                        title: '施工图审查机构综合结论',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion6] },
                        { layout: 'column', border: 0, items: [Opinion6ShenChaName, Opinion6CreateTime] }
                        ]
                    },
                    {
                        xtype: 'fieldset', margin: '5',
                        title: '建设行政主管部门备案意见',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion7] },
                        { layout: 'column', border: 0, items: [Opinion7ShenChaName, Opinion7CreateTime] }
                        ]
                    }
                ],
                buttonAlign: "center",
                buttons: [
                { text: '保 存', handler: function () {
                    if (formpanel.getForm().isValid()) {
                        var ShenChaId = Ext.getCmp("Id").getValue();
                        var action = ShenChaId ? "Update" : "Create";
                        var json = Ext.encode(formpanel.getForm().getValues());
                        Ext.Ajax.request({
                            url: "ShenChaReport_FWJZ.aspx",
                            async: false,
                            params: { action: action, json: json, ProjectId: ProjectId },
                            callback: function (option, success, response) {
                                var json = Ext.decode(response.responseText);
                                Ext.getCmp("Id").setValue(ShenChaId);
                                Ext.Msg.alert("提示", "保存成功!");
                            }
                        });
                    }
                }
                },
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
                } ]
            });
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [formpanel]
            })
            formpanel.getForm().load({
                url: "ShenChaReport_FWJZ.aspx",
                params: { action: "SelectEdit", ProjectId: ProjectId },
                method: "POST",
                success: function (form, action) {
                    if (!Ext.getCmp("Id").getValue()) {
                        Ext.getCmp("Opinion4").setValue(" 1.按审查意见修改后，基本达到建设部《市政公用工程设计文件编制深度规定》和省有关规定要求。<br/>2.施工图设计按规定盖有出图章和签署。")
                        Ext.getCmp("Opinion3").setValue("未提供初步设计文件。");
                        Ext.getCmp("Opinion5").setValue("符合公共利益");
                    }
                }
            });
        })
        function doprint(url) {
            try {
                var LODOP = document.getElementById("LODOP"); //这行语句是为了符合DTD规范
                LODOP.PRINT_INIT("");
                LODOP.NewPage();
                LODOP.ADD_PRINT_URL(10, 10, 750, 1050, url);
                //  LODOP.ADD_PRINT_URL(20, 18, 750, 1050, 'CommissionHanDY.aspx?id=' + id);
                LODOP.PREVIEW();
            }
            catch (ex) {
                Ext.MessageBox.confirm("提示", "未安装打印控件，请安装打印控件", callBack);

            }
        }
        function callBack(str) {
            if (str == "yes") {
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
