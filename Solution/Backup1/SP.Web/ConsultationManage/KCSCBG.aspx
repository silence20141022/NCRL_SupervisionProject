﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KCSCBG.aspx.cs" Inherits="SP.Web.ConsultationManage.KCSCBG" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>勘察审核报告</title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var ProjectName, Investment, DetailLocation, EngineeringLevel, KanChaZZLevel, DetailLocation, GongChenLiang;
        var SheJiUnitHead, SheJiUnitGrade, Height, CengShu, BuildingArea, JianSheUnit, JianSheUnitHead;
        var ShenChaNo;
        var ShenCha;
        var ProjectId = getQueryString("ProjectId");
        Ext.onReady(SetPage);
        function SetPage() {
            ProjectInfo();
            ShenCha();
            if (ProjectId) {
                Update();
            }
        }
        function Update() {
            ShenCha.getForm().load({
                url: "FWJZSCBG.aspx",
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
        function ShenCha() {
            var Opinion1 = {
                xtype: 'htmleditor',
                name: "Opinion1",
                id: "Opinion1",
                fieldLabel: '审查报告',
                labelAlign: 'right',
                height: 150,
                columnWidth: 1,
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
                fieldLabel: '审查报告',
                labelAlign: 'right',
                height: 150,
                columnWidth: 1,
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
                xtype: 'htmleditor',
                name: "Opinion5",
                id: "Opinion5",
                fieldLabel: '审查报告',
                labelAlign: 'right',
                height: 150,
                columnWidth: 1,
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

            ShenCha = Ext.create("Ext.form.Panel", {
                title: '勘察审核报告',
                region: 'center',
                autoScroll: true,
                items: [
                {
                    xtype: 'fieldset',
                    title: '项目基本信息',
                    collapsible: true,
                    items: [
                        { layout: 'column', border: 0, items: [ShenChaNo, ProjectName] },
                        { layout: 'column', border: 0, items: [Investment, GongChenLiang] },
                        { layout: 'column', border: 0, items: [DetailLocation, EngineeringLevel] },
                        { layout: 'column', border: 0, items: [JianSheUnit, JianSheUnitHead] },
                        { layout: 'column', border: 0, items: [KanChaUnit, KanChaUnitHead] },
                        { layout: 'column', border: 0, items: [KanChaZZLevel, KanChaUnitZSNo] },
                    //                        { layout: 'column', border: 0, items: [SheJiUnit, SheJiUnitHead] },
                    //                        { layout: 'column', border: 0, items: [SheJiUnitGrade, SheJiUnitZSNo] },
                        {xtype: 'textfield', hidden: true, name: 'Id', id: "Id" },
                        { xtype: "textfield", hidden: true, name: "ProjectId", id: "ProjectId" }
                        ]
                },


                 {
                     xtype: 'fieldset',
                     title: '1.勘察报告提供的数据是否真实可靠；<br/>2.报告手续是否齐全；<br/>3.是否按规定盖有出图章和签署，资质与项目规模是否匹配；<br/>4.工程基础（含软基）处理是否安全、可靠。（宏观、大的方面的审查）',
                     collapsible: true,
                     items: [
                        { layout: 'column', border: 0, items: [Opinion1] },
                        { layout: 'column', border: 0, items: [Opinion1ShenChaName, Opinion1CreateTime] }
                        ]
                 },
                    {
                        xtype: 'fieldset',
                        title: '是否符合有关工程强制性标准规范（违反强标方面的审查）',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion2] },
                        { layout: 'column', border: 0, items: [Opinion2ShenChaName, Opinion2CreateTime] }
                        ]
                    },
                    {
                        xtype: 'fieldset',
                        title: '按照建设部和省里的岩土工程勘察报告审查要点的审查',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion3] },
                        { layout: 'column', border: 0, items: [Opinion3ShenChaName, Opinion3CreateTime] }
                        ]
                    },
                    {
                        xtype: 'fieldset',
                        title: '施工图审查机构综合结论',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion4] },
                        { layout: 'column', border: 0, items: [Opinion4ShenChaName, Opinion4CreateTime] }
                        ]
                    }
                    ,
                    {
                        xtype: 'fieldset',
                        title: '备注',
                        collapsible: true,
                        items: [
                        { layout: 'column', border: 0, items: [Opinion5] }
                        ]
                    }



                ],
                buttonAlign: "center",
                buttons: [
                { text: '保 存', handler: create },
                { text: "打 印", handler: print },
                { text: '取 消', handler: function () {
                    window.close();
                }
                }]
            });
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [ShenCha]
            })
        }
        function create() {
            if (ShenCha.getForm().isValid()) {
                var ShenChaId = Ext.getCmp("Id").getValue();
                var action = ShenChaId ? "Update" : "Create";
                var str = ShenCha.getForm().getValues();
                var json = Ext.encode(str);
                Ext.Ajax.request({
                    url: "FWJZSCBG.aspx",
                    async: false,
                    params: { action: action, json: json, ProjectId: ProjectId },
                    callback: function (option, success, response) {
                        var json = Ext.JSON.decode(response.responseText);
                        var ShenChaId = json.ShenChaId;
                        if (ShenChaId) {
                            Ext.getCmp("Id").setValue(ShenChaId);
                            Ext.getCmp("ProjectId").setValue(ProjectId);
                            if (action == "Create") {
                                Ext.Msg.alert("提示", "创建成功");
                            } else {
                                Ext.Msg.alert("提示", "修改成功");
                            }
                        }
                    }
                });
            }
        }
        function print() {
            var ShenChaId = Ext.getCmp("Id").getValue();
            if (ShenChaId) {
                doprint("KCSCDY.aspx?Id=" + ShenChaId);
            }
            else {
                Ext.Msg.alert("提示", "请先保存审查报告!");
            }
        }
        function doprint(url) {
            try {
                var LODOP = document.getElementById("LODOP"); //这行语句是为了符合DTD规范
                LODOP.PRINT_INIT("");
                LODOP.NewPage();
                LODOP.ADD_PRINT_URL(0, 0, 750, 1050, url);
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

        function ProjectInfo() {
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
                blankText: '编号不能为空!',
                validateOnChange: true,
                validator: function (val) {
                    if (!val) {
                        return true;
                    }
                    var ischeck;
                    Ext.Ajax.request({
                        url: "FWJZSCBG.aspx",
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
            Investment = {
                xtype: "textfield",
                name: "Investment",
                fieldLabel: '投资额(万元)',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                readOnly: true,
                margin: '7'
            }
            GongChenLiang = {
                xtype: "textfield",
                name: "GongChenLiang",
                fieldLabel: '工程量',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                readOnly: true,
                margin: '7'
            }
            DetailLocation = {
                xtype: "textfield",
                name: "DetailLocation",
                fieldLabel: '建设地点',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                readOnly: true,
                margin: '7'
            }
            EngineeringLevel = {
                xtype: "textfield",
                name: "EngineeringLevel",
                fieldLabel: '设计规模',
                labelAlign: 'right',
                columnWidth: .5,
                readOnly: true,
                labelWidth: 150,
                margin: '7'
            }
            JianSheUnit = {
                xtype: "textfield",
                name: "JianSheUnit",
                fieldLabel: '建设单位名称',
                labelAlign: 'right',
                columnWidth: .5,
                readOnly: true,
                labelWidth: 150,
                margin: '7'
            }
            JianSheUnitHead = {
                xtype: "textfield",
                name: "JianSheUnitHead",
                fieldLabel: '建设单位项目负责人',
                labelAlign: 'right',
                columnWidth: .5,
                readOnly: true,
                labelWidth: 150,
                margin: '7'
            }

            KanChaUnit = {
                xtype: "textfield",
                name: "KanChaUnit",
                fieldLabel: '勘察单位名称',
                labelAlign: 'right',
                columnWidth: .5,
                readOnly: true,
                labelWidth: 150,
                margin: '7'
            }
            KanChaUnitHead = {
                xtype: "textfield",
                name: "KanChaUnitHead",
                fieldLabel: '勘察单位项目负责人',
                labelAlign: 'right',
                columnWidth: .5,
                readOnly: true,
                labelWidth: 150,
                margin: '7'
            }
            KanChaZZLevel = {
                xtype: "textfield",
                name: "KanChaZZLevel",
                fieldLabel: '勘察单位资质等级',
                labelAlign: 'right',
                columnWidth: .5,
                readOnly: true,
                labelWidth: 150,
                margin: '7'
            }
            KanChaUnitZSNo = {
                xtype: "textfield",
                name: "KanChaUnitZSNo",
                fieldLabel: '勘察单位证书编号',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                readOnly: true,
                margin: '7'
            }
            SheJiUnit = {
                xtype: "textfield",
                name: "SheJiUnit",
                fieldLabel: '设计单位名称',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                readOnly: true,
                margin: '7'
            }
            SheJiUnitHead = {
                xtype: "textfield",
                name: "SheJiUnitHead",
                fieldLabel: '设计单位项目负责人',
                labelAlign: 'right',
                columnWidth: .5,
                labelWidth: 150,
                readOnly: true,
                margin: '7'
            }

            SheJiUnitGrade = {
                xtype: "textfield",
                name: "SheJiUnitGrade",
                fieldLabel: '设计单位资质等级',
                labelAlign: 'right',
                columnWidth: .5,
                readOnly: true,
                labelWidth: 150,
                margin: '7'
            }
            SheJiUnitZSNo = {
                xtype: "textfield",
                name: "SheJiUnitZSNo",
                fieldLabel: '设计单位证书编号',
                labelAlign: 'right',
                columnWidth: .5,
                readOnly: true,
                labelWidth: 150,
                margin: '7'
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
