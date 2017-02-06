<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="KangZhenOpinion_Edit.aspx.cs"
    Inherits="SP.Web.ConsultationManage.KangZhenOpinion_Edit" %>

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
                name: "ProjectName",
                labelWidth: 160,
                labelAlign: 'right',
                margin: '10',
                fieldLabel: "项目名称",
                anchor: '80.5%',
                readOnly: true
            });
            var field_ProjectType = Ext.create('Ext.form.field.Text', {
                name: "ProjectType",
                fieldLabel: "建筑类别",
                labelAlign: 'right',
                labelWidth: 160,
                readOnly: true,
                columnWidth: .4
            });
            var field_KangZhenLieDu = Ext.create('Ext.form.field.Text', {
                name: "KangZhenLieDu",
                fieldLabel: "抗震设防烈度",
                readOnly: true,
                labelAlign: 'right',
                labelWidth: 160,
                columnWidth: .4
            });
            var field_ZhuCeJieGouShi = Ext.create('Ext.form.field.Text', {
                name: "ZhuCeJieGouShi",
                labelAlign: 'right',
                labelWidth: 160,
                margin: '10',
                readOnly: true,
                fieldLabel: "注册结构师",
                anchor: '41%'
            })
            var field_CengShu = Ext.create('Ext.form.field.Text', {
                name: "CengShu",
                fieldLabel: "层数",
                labelAlign: 'right',
                readOnly: true,
                labelWidth: 160,
                columnWidth: .4
            });
            var field_DiCengHeight = Ext.create('Ext.form.field.Text', {
                name: "DiCengHeight",
                fieldLabel: "底层层高",
                labelAlign: 'right',
                labelWidth: 160,
                columnWidth: .4
            });
            var field_YanKouHeight = Ext.create('Ext.form.field.Text', {
                name: "YanKouHeight",
                fieldLabel: "檐口高度",
                labelAlign: 'right',
                labelWidth: 160,
                columnWidth: .4
            });
            var store_ceding = Ext.create('Ext.data.JsonStore', {
                fields: ['name'],
                data: [{ name: '是' }, { name: '否'}]
            })
            var combo_IfChangDiCeDing = Ext.create('Ext.form.field.ComboBox', {
                store: store_ceding,
                valueField: 'name',
                displayField: 'name',
                labelAlign: 'right',
                labelWidth: 160,
                queryMode: 'local',
                fieldLabel: '是否进行场地性能测定',
                name: 'IfChangDiCeDing',
                columnWidth: .4
            })
            var field_ShangBuJieGou = Ext.create('Ext.form.field.Text', {
                name: "ShangBuJieGou",
                fieldLabel: "上部结构型式",
                labelAlign: 'right',
                labelWidth: 160,
                columnWidth: .4
            });
            var field_ChangDiTuLeiBie = Ext.create('Ext.form.field.Text', {
                name: "ChangDiTuLeiBie",
                fieldLabel: "场地土类别",
                labelAlign: 'right',
                labelWidth: 160,
                columnWidth: .4
            });
            var field_FoundationType = Ext.create('Ext.form.field.Text', {
                name: "FoundationType",
                fieldLabel: "基础型式",
                labelAlign: 'right',
                labelWidth: 160,
                readOnly: true,
                columnWidth: .4
            });
            var field_KangZhenDengJi = Ext.create('Ext.form.field.Text', {
                name: "KangZhenDengJi",
                fieldLabel: "抗震等级",
                labelAlign: 'right',
                labelWidth: 160,
                columnWidth: .4
            });
            var field_ZhuanXiangShenChaOpinion = Ext.create('Ext.form.field.TextArea', {
                name: "ZhuanXiangShenChaOpinion",
                fieldLabel: "抗震设防专项审查意见",
                labelAlign: 'right',
                labelWidth: 160,
                margin: '10',
                anchor: '80.5%',
                height: 130
            })
            var field_BuMenJianGuanOpinion = Ext.create('Ext.form.field.TextArea', {
                name: "BuMenJianGuanOpinion",
                fieldLabel: "抗震主管部门监管意见",
                labelAlign: 'right',
                labelWidth: 160,
                margin: '10',
                anchor: '80.5%',
                height: 130
            })
            var formPanel = Ext.create("Ext.form.Panel", {
                region: "center",
                title: "抗震设防专项审查监管表",
                items: [
                    field_ProjectName,
                    { layout: 'column', border: 0, margin: '10', items: [field_ProjectType, field_KangZhenLieDu] },
                    { layout: 'column', border: 0, margin: '10', items: [field_CengShu, field_DiCengHeight] },
                    { layout: 'column', border: 0, margin: '10', items: [field_YanKouHeight, combo_IfChangDiCeDing] },
                    { layout: 'column', border: 0, margin: '10', items: [field_ShangBuJieGou, field_ChangDiTuLeiBie] },
                    { layout: 'column', border: 0, margin: '10', items: [field_FoundationType, field_KangZhenDengJi] },
                    field_ZhuCeJieGouShi,
                    field_ZhuanXiangShenChaOpinion, field_BuMenJianGuanOpinion
                ],
                buttons: [
                { text: "保 存", handler: function () {
                    var str = formPanel.getForm().getValues();
                    Ext.Ajax.request({
                        url: "KangZhenOpinion_Edit.aspx?action=update",
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
                        url: "ProjectList.aspx?action=export_kangzhen",
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
                url: "KangZhenOpinion_Edit.aspx?action=loadform",
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
