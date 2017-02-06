<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectCard.aspx.cs" Inherits="SP.Web.ConsultationManage.ProjectCard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var id = getQueryString("id");
        var formpanel_baseinfo, formpanel_gaikuang, formpanel_unit, formpanel_standard, formpanel_other, grid_subprj, grid_kanchashejiuser, grid_expert, panel;
        var rowIdx, rawValue;
        Ext.onReady(function () {
            var store_xiangmuleibie = Ext.create('Ext.data.JsonStore', {
                fields: ['name'],
                proxy: {
                    url: 'ProjectCard.aspx?action=loadprojecttype',
                    type: 'ajax',
                    reader: {
                        root: 'rows',
                        type: 'json'
                    }
                },
                autoLoad: true
            })
            var combo_prjleibie = Ext.create('Ext.form.field.ComboBox', {
                store: store_xiangmuleibie,
                displayField: 'name',
                valueField: 'name',
                fieldLabel: '项目类别',
                allowBlank: false,
                editable: false,
                blankText: '项目类别不能为空',
                msgTarget: 'under',
                labelAlign: 'right',
                labelWidth: 170,
                columnWidth: .5,
                name: 'ProjectType',
                listeners: { select: function (combo, records, eOpts) {
                    combo_gongchengleixing.clearValue(); store_gongchengleixing.removeAll();
                }
                }
            })
            var store_gongchengleixing = Ext.create('Ext.data.JsonStore', {
                fields: ['name'],
                proxy: {
                    url: 'ProjectCard.aspx?action=loadgongchengleixing',
                    type: 'ajax',
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            })
            var combo_gongchengleixing = Ext.create('Ext.form.field.ComboBox', {
                store: store_gongchengleixing,
                queryMode: 'local',
                displayField: 'name',
                valueField: 'name',
                fieldLabel: '工程类型',
                labelAlign: 'right',
                name: 'GongChengLeiXing',
                editable: false,
                allowBlank: false,
                blankText: '工程类型不能为空',
                msgTarget: 'under',
                labelWidth: 170,
                columnWidth: .5,
                listeners: { focus: function () {
                    store_gongchengleixing.load({ params: { prjleibiename: combo_prjleibie.getValue()} })
                }
                }
            })
            var store_gongchengxingzhi = Ext.create('Ext.data.JsonStore', {
                fields: ['name'],
                data: [{ name: '新建' }, { name: '改建' }, { name: '扩建'}]
            })
            var combo_gongchengxingzhi = Ext.create('Ext.form.field.ComboBox', {
                store: store_gongchengxingzhi,
                displayField: 'name',
                valueField: 'name',
                queryMode: 'local',
                fieldLabel: '工程性质',
                labelWidth: 170,
                editable: false,
                columnWidth: .5,
                labelAlign: 'right',
                name: 'Property'
            })
            var store_gongchengdj = Ext.create('Ext.data.JsonStore', {
                fields: ['name'],
                data: [{ name: '一级' }, { name: '二级' }, { name: '三级'}]
            })
            var combo_gongchengdj = Ext.create('Ext.form.field.ComboBox', {
                store: store_gongchengdj,
                displayField: 'name',
                valueField: 'name',
                queryMode: 'local',
                editable: false,
                fieldLabel: '工程等级',
                name: 'EngineeringLevel',
                labelAlign: 'right',
                labelWidth: 170,
                columnWidth: .5
            })
            var store_di = Ext.create('Ext.data.JsonStore', {
                fields: ['id', 'name'],
                proxy: {
                    url: 'ProjectCard.aspx?action=loadlocationfirst',
                    type: 'ajax',
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            })
            var combo_di = Ext.create('Ext.form.field.ComboBox', {
                store: store_di,
                displayField: 'name',
                name: 'Zone',
                editable: false,
                valueField: 'name',
                listeners: { select: function (combo, records, eOpts) {
                    combo_qu.clearValue(); store_qu.removeAll(); //清空从动combo下拉选项中的值     
                }
                }
            })
            var store_qu = Ext.create('Ext.data.JsonStore', {
                fields: ['name'],
                proxy: {
                    url: 'ProjectCard.aspx?action=loadlocationsecond',
                    type: 'ajax',
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            })
            var combo_qu = Ext.create('Ext.form.field.ComboBox', {
                store: store_qu,
                margin: '0 0 0 5',
                queryMode: 'local',
                editable: false,
                displayField: 'name',
                valueField: 'name',
                name: 'ZoneSecond',
                listeners: { focus: function () {
                    store_qu.load({ params: { locationfirst: combo_di.getValue()} })
                }
                }
            })
            var container_suozaidiqu = Ext.create('Ext.form.FieldContainer', {
                fieldLabel: '项目所在地区',
                labelAlign: 'right',
                layout: 'hbox',
                columnWidth: .5,
                labelWidth: 170,
                items: [combo_di, combo_qu]
            })
            var store_chuangkou = Ext.create('Ext.data.JsonStore', {
                fields: ['id', 'name'],
                proxy: {
                    url: 'ProjectCard.aspx?action=loadchuangkou',
                    type: 'ajax',
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                },
                autoLoad: true
            })
            var combo_chuangkou = Ext.create('Ext.form.field.ComboBox', {
                store: store_chuangkou,
                displayField: 'name',
                valueField: 'id',
                fieldLabel: '承揽窗口',
                name: 'DelegateInfoId',
                labelAlign: 'right',
                labelWidth: 170,
                editable: false,
                columnWidth: .5
            })
            var field_ChuangKouBiLi = Ext.create('Ext.form.field.Number', { fieldLabel: '窗口酬金比例(%)', maxValue: 100, msgTarget: 'under',
                labelAlign: 'right', labelWidth: 170, columnWidth: .5, minValue: 0, name: 'ChuangKouBiLi'
            });
            var field_SongShenTime = Ext.create('Ext.form.field.Date', {
                fieldLabel: '送审时间',
                labelAlign: 'right',
                labelWidth: 170,
                columnWidth: .5,
                name: 'SongShenTime',
                id: 'SongShenTime',
                format: 'Y-m-d'
            })
            formpanel_baseinfo = Ext.create('Ext.form.Panel', {
                title: '1 项目基本信息',
                id: 'formpanel_baseinfo',
                items: [
                { layout: 'column', border: 0, margin: '10', items: [ //第1行
                {xtype: 'textfield', fieldLabel: '瑞林项目编号', labelAlign: 'right', name: 'ProjectCode', labelWidth: 170, columnWidth: .5 },
                { xtype: 'textfield', fieldLabel: '咨询公司项目编号', labelAlign: 'right', name: 'ZiXunCode', labelWidth: 170, columnWidth: .5 }
                ]
                },
                { layout: 'column', border: 0, margin: '10', items: [  //第2行
                {xtype: 'textfield', fieldLabel: '建设厅项目编号', labelAlign: 'right', labelWidth: 170, columnWidth: .5, name: 'JianSheTingNo' },
                { xtype: 'textfield', fieldLabel: '项目名称', labelAlign: 'right', labelWidth: 170, columnWidth: .5, allowBlank: false, blankText: '项目名称不能为空', msgTarget: 'under', name: 'ProjectName' }
                ]
                },
                { layout: 'column', border: 0, margin: '10', items: [combo_prjleibie, combo_gongchengleixing]   //第3行
                },  //第4行              
                {layout: 'column', border: 0, margin: '10', items: [combo_gongchengdj, combo_gongchengxingzhi]
            },
                { layout: 'column', border: 0, margin: '10', items: [  //第5行
                    {xtype: 'numberfield', fieldLabel: '项目投资金额(万元)', labelAlign: 'right', labelWidth: 170, columnWidth: .5, name: 'Investment' },
                    { xtype: 'numberfield', fieldLabel: '合同额(元）', labelAlign: 'right', labelWidth: 170, columnWidth: .5, name: 'ContractAmount'}]
                }, //第6行            
                {layout: 'column', border: 0, margin: '10', items: [container_suozaidiqu,
                   { xtype: 'textfield', fieldLabel: '项目详细地址', labelAlign: 'right', labelWidth: 170, columnWidth: .5, name: 'DetailLocation' }
                ]
            },  //第7行
                {layout: 'column', border: 0, margin: '10', items: [combo_chuangkou, field_ChuangKouBiLi
                ]
            },
            { layout: 'column', border: 0, margin: '10', items: [field_SongShenTime,
              { xtype: 'textfield', fieldLabel: '岩土工程勘察报告项目名称', labelAlign: 'right', labelWidth: 170, columnWidth: .5, name: 'KanChaReportPrjName'}]
            },
            { xtype: 'hidden', name: 'Id' },
            { xtype: 'textarea', labelAlign: 'right', fieldLabel: '备注', labelWidth: 170, margin: '10', height: 60, anchor: '100%', name: 'Remark' }
           ]
        })
        var store_gongchengguimo = Ext.create('Ext.data.JsonStore', {
            fields: ['name'],
            data: [{ 'name': '大型' }, { 'name': '中型' }, { 'name': '小型'}]
        })
        var combo_gongchengguimo = Ext.create('Ext.form.field.ComboBox', {
            store: store_gongchengguimo,
            displayField: 'name',
            valueField: 'name',
            editable: false,
            queryMode: 'local',
            fieldLabel: '工程规模',
            labelWidth: 120,
            labelAlign: 'right',
            name: 'GongChengGuiMo',
            columnWidth: .5
        })
        var store_jiegouleixing = Ext.create('Ext.data.JsonStore', {
            fields: ['name'],
            proxy: {
                url: 'ProjectCard.aspx?action=loadjiegouleixing', type: 'ajax',
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        })
        var combo_jiegouleixing = Ext.create('Ext.form.field.ComboBox', {
            store: store_jiegouleixing,
            displayField: 'name',
            valueField: 'name',
            editable: false,
            fieldLabel: '结构类型',
            id: 'StructureType',
            name: 'StructureType',
            labelWidth: 120,
            labelAlign: 'right',
            columnWidth: .5,
            multiSelect: true
        })
        formpanel_gaikuang = Ext.create('Ext.form.Panel', {//工程概况PANEL
            id: 'formpanel_gaikuang',
            title: '2 工程概况',
            items: [
            { layout: 'column', border: 0, margin: '10', items: [
            { xtype: 'numberfield', fieldLabel: '建筑面积(㎡)', labelWidth: 120, labelAlign: 'right', columnWidth: .5, name: 'BuildingArea' },
            { xtype: 'numberfield', fieldLabel: '其中地下面积(㎡)', labelWidth: 120, labelAlign: 'right', columnWidth: .5, name: 'DiXiaMianJi'}]
            },
             { layout: 'column', border: 0, margin: '10', items: [
             { xtype: 'textfield', fieldLabel: '建筑高度(m)', labelWidth: 120, labelAlign: 'right', columnWidth: .5, id: 'Height', name: 'Height' },
                combo_gongchengguimo]

             },
            { layout: 'column', border: 0, margin: '10', items: [
            { xtype: 'textfield', fieldLabel: '基础形式', labelWidth: 120, labelAlign: 'right', columnWidth: .5, name: 'FoundationType' },
            combo_jiegouleixing]
            },
            { layout: 'column', border: 0, margin: '10', items: [
            { xtype: 'textfield', fieldLabel: '地上层数', labelWidth: 120, labelAlign: 'right', columnWidth: .5, id: 'UpperLayers', name: 'UpperLayers' },
            { xtype: 'numberfield', fieldLabel: '地下层数', labelWidth: 120, labelAlign: 'right', columnWidth: .5, name: 'DownLayers' }
             ]
            },
             { layout: 'column', border: 0, margin: '10', items: [
            { xtype: 'numberfield', fieldLabel: '路(桥)长', labelWidth: 120, labelAlign: 'right', columnWidth: .5, name: 'LuQiaoLength' },
            { xtype: 'numberfield', fieldLabel: '路(桥)宽', labelWidth: 120, labelAlign: 'right', columnWidth: .5, name: 'LuQiaoWidth'}]
             },
            { xtype: 'textarea', anchor: '100%', margin: '10', fieldLabel: '工程量', height: 80, labelAlign: 'right', labelWidth: 120, name: 'GongChenLiang' }
                       ]
        })
        var store_shejiunitgrade = Ext.create('Ext.data.JsonStore', {
            fields: ['name'],
            data: [{ name: '甲级' }, { name: '乙级' }, { name: '丙级' }, { name: '丁级'}]
        })
        var combo_shejiunitgrade = Ext.create('Ext.form.field.ComboBox', {
            store: store_shejiunitgrade,
            displayField: 'name',
            editable: false,
            valueField: 'name',
            queryMode: 'local',
            fieldLabel: '设计资质等级',
            labelAlign: 'right',
            labelWidth: 150,
            name: 'SheJiUnitGrade',
            columnWidth: .5
        })
        var store_kanchagclevel = Ext.create('Ext.data.JsonStore', {
            fields: ['name'],
            data: [{ name: '甲级' }, { name: '乙级' }, { name: '丙级'}]
        })
        var combo_kanchagclevel = Ext.create('Ext.form.field.ComboBox', {
            store: store_kanchagclevel,
            displayField: 'name',
            valueField: 'name',
            editable: false,
            queryMode: 'local',
            fieldLabel: '工程勘察等级',
            labelAlign: 'right',
            labelWidth: 150,
            name: 'KanChaGCLevel',
            columnWidth: .5
        })
        var combo_kanchazzlevel = Ext.create('Ext.form.field.ComboBox', {
            store: store_shejiunitgrade,
            displayField: 'name',
            valueField: 'name',
            queryMode: 'local',
            editable: false,
            fieldLabel: '勘察资质等级',
            labelAlign: 'right',
            labelWidth: 150,
            name: 'KanChaZZLevel',
            columnWidth: .5
        })
        var store_kanchatype = Ext.create('Ext.data.JsonStore', {
            fields: ['name'],
            data: [{ name: '无需勘察' }, { name: '地基勘察' }, { name: '基坑支护' }, { name: '地基处理' }, { name: '城市勘察' }, { name: '其他'}]
        })
        var combo_kanchatype = Ext.create('Ext.form.field.ComboBox', {
            store: store_kanchatype,
            displayField: 'name',
            valueField: 'name',
            editable: false,
            fieldLabel: '勘察类型',
            labelAlign: 'right',
            labelWidth: 150,
            columnWidth: .5,
            queryMode: 'local',
            name: 'KanChaType'
        })
        formpanel_unit = Ext.create('Ext.form.Panel', {
            title: '3 建设单位 设计单位 勘察单位',
            id: 'formpanel_unit',
            items: [
            { xtype: 'fieldset', title: '建设单位', margin: '5', items: [
                { layout: 'column', border: 0, margin: '10', items: [
                { xtype: 'textfield', fieldLabel: '建设单位', labelAlign: 'right', labelWidth: 150, columnWidth: .5, name: 'JianSheUnit' },
                { xtype: 'textfield', fieldLabel: '建设单位项目负责人', labelAlign: 'right', labelWidth: 150, columnWidth: .5, name: 'JianSheUnitHead'}]
                },
                { xtype: 'textfield', fieldLabel: ' 建设项目负责人电话', labelAlign: 'right', margin: '10', labelWidth: 150, anchor: '51%', name: 'JianSheUnitHeadTel' }
            ]
            },
            { xtype: 'fieldset', title: '设计单位', margin: '5', items: [
            { layout: 'column', border: 0, margin: '10', items: [
            { xtype: 'textfield', fieldLabel: '设计单位', labelAlign: 'right', labelWidth: 150, columnWidth: .5, name: 'SheJiUnit' },
            { xtype: 'textfield', fieldLabel: '设计单位项目负责人', labelAlign: 'right', labelWidth: 150, columnWidth: .5, name: 'SheJiUnitHead' }
            ]
            },
            { layout: 'column', border: 0, margin: '10', items: [combo_shejiunitgrade,
              { xtype: 'textfield', fieldLabel: '设计单位证书编号', labelAlign: 'right', labelWidth: 150, columnWidth: .5, name: 'SheJiUnitZSNo' }
            ]
            },
             { layout: 'column', border: 0, margin: '10', items: [
            { xtype: 'textfield', fieldLabel: '设计单位进赣备案号', labelAlign: 'right', labelWidth: 150, columnWidth: .5, name: 'SheJiUnitBeiAnNo'}]
             }
            ]
            },
            { xtype: 'fieldset', title: '勘察单位', margin: '5', items: [
            { layout: 'column', border: 0, margin: '10', items: [
            { xtype: 'textfield', fieldLabel: '勘察单位', labelAlign: 'right', labelWidth: 150, columnWidth: .5, name: 'KanChaUnit' },
            { xtype: 'textfield', fieldLabel: '勘察单位项目负责人', labelAlign: 'right', labelWidth: 150, columnWidth: .5, name: 'KanChaUnitHead' }
            ]
            },
             { layout: 'column', border: 0, margin: '10', items: [combo_kanchatype,
             { xtype: 'textfield', fieldLabel: '勘察单位证书编号', labelAlign: 'right', labelWidth: 150, columnWidth: .5, name: 'KanChaUnitZSNo' }
            ]
             },
             { layout: 'column', border: 0, margin: '10', items: [combo_kanchazzlevel, combo_kanchagclevel]
             },
              { layout: 'column', border: 0, margin: '10', items: [
              { xtype: 'textfield', fieldLabel: '钻孔和进尺数', labelAlign: 'right', labelWidth: 150, columnWidth: .5, name: 'ZuanKongJinChi' },
              { xtype: 'textfield', fieldLabel: '勘察单位进赣备案号', labelAlign: 'right', labelWidth: 150, columnWidth: .5, name: 'KanChaUnitBeiAnNo' }
              ]
              }
            ]
            }
            ]
        })
        var store_ifhave = Ext.create('Ext.data.JsonStore', {
            fields: ['name'],
            data: [{ name: '有' }, { name: '无'}]
        })
        var combo_wyjz = Ext.create('Ext.form.field.ComboBox', {
            store: store_ifhave,
            queryMode: 'local',
            displayField: 'name',
            valueField: 'name',
            fieldLabel: '外业见证',
            labelAlign: 'right',
            labelWidth: 150,
            name: 'Wyjz',
            editable: false,
            columnWidth: .5
        })
        var store_ifnot = Ext.create('Ext.data.JsonStore', {
            fields: ['name'],
            data: [{ name: '是' }, { name: '否'}]
        })
        var combo_Wyjzifwfqt = Ext.create('Ext.form.field.ComboBox', {
            store: store_ifnot,
            queryMode: 'local',
            displayField: 'name',
            valueField: 'name',
            fieldLabel: '外业见证是否违反强条',
            labelAlign: 'right',
            labelWidth: 150,
            name: 'Wyjzifwfqt',
            editable: false,
            columnWidth: .5
        })
        var combo_Wyjzifsmcl = Ext.create('Ext.form.field.ComboBox', {
            store: store_ifnot,
            queryMode: 'local',
            displayField: 'name',
            valueField: 'name',
            fieldLabel: '外业见证是否有书面材料',
            labelAlign: 'right',
            editable: false,
            labelWidth: 150,
            name: 'Wyjzifsmcl',
            columnWidth: .5
        })
        var combo_Ny = Ext.create('Ext.form.field.ComboBox', {
            store: store_ifhave,
            queryMode: 'local',
            displayField: 'name',
            valueField: 'name',
            fieldLabel: '内业',
            labelAlign: 'right',
            labelWidth: 150,
            name: 'Ny',
            editable: false,
            columnWidth: .5
        })
        var combo_Nyifwfqt = Ext.create('Ext.form.field.ComboBox', {
            store: store_ifnot,
            queryMode: 'local',
            displayField: 'name',
            valueField: 'name',
            fieldLabel: '内业是否违反强条',
            labelAlign: 'right',
            labelWidth: 150,
            name: 'Nyifwfqt',
            editable: false,
            columnWidth: .5
        })
        var combo_Nyifsmcl = Ext.create('Ext.form.field.ComboBox', {
            store: store_ifnot,
            queryMode: 'local',
            displayField: 'name',
            valueField: 'name',
            fieldLabel: '内业是否有书面材料',
            labelAlign: 'right',
            labelWidth: 150,
            name: 'Nyifsmcl',
            editable: false,
            columnWidth: .5
        })
        var combo_Wy = Ext.create('Ext.form.field.ComboBox', {
            store: store_ifhave,
            queryMode: 'local',
            displayField: 'name',
            valueField: 'name',
            fieldLabel: '外业',
            labelAlign: 'right',
            labelWidth: 150,
            name: 'Wy',
            editable: false,
            columnWidth: .5
        })
        var combo_Wyifwfqt = Ext.create('Ext.form.field.ComboBox', {
            store: store_ifnot,
            queryMode: 'local',
            displayField: 'name',
            valueField: 'name',
            fieldLabel: '外业是否违反强条',
            labelAlign: 'right',
            labelWidth: 150,
            editable: false,
            name: 'Wyifwfqt',
            columnWidth: .5
        })
        var combo_Wyifsmcl = Ext.create('Ext.form.field.ComboBox', {
            store: store_ifnot,
            queryMode: 'local',
            displayField: 'name',
            valueField: 'name',
            fieldLabel: '外业是否有书面材料',
            labelAlign: 'right',
            labelWidth: 150,
            name: 'Wyifsmcl',
            editable: false,
            columnWidth: .5
        })
        formpanel_standard = Ext.create('Ext.form.Panel', {
            title: '4 勘察设计标准执行情况',
            id: 'formpanel_standard',
            items: [{ layout: 'column', border: 0, margin: '10', items: [combo_wyjz,
            { xtype: 'textfield', fieldLabel: '外业见证人员', labelAlign: 'right', labelWidth: 150, name: 'WyjzUser', columnWidth: .5}]
            },
            { layout: 'column', border: 0, margin: '10', items: [
             { xtype: 'textfield', fieldLabel: '外业见证单位', labelAlign: 'right', labelWidth: 150, name: 'WyjzUnit', columnWidth: .5 },
             { xtype: 'textfield', fieldLabel: '外业见证编号', labelAlign: 'right', labelWidth: 150, name: 'WyjzNo', columnWidth: .5}]
            },
            { layout: 'column', border: 0, margin: '10', items: [combo_Wyjzifwfqt, combo_Wyjzifsmcl] },
            { layout: 'column', border: 0, margin: '10', items: [combo_Ny, combo_Nyifwfqt] },
            { layout: 'column', border: 0, margin: '10', items: [combo_Nyifsmcl, combo_Wy] },
            { layout: 'column', border: 0, margin: '10', items: [combo_Wyifwfqt, combo_Wyifsmcl] },
            { layout: 'column', border: 0, margin: '10', items: [
            { xtype: 'textfield', fieldLabel: '结构', labelAlign: 'right', labelWidth: 150, name: 'Structure', columnWidth: .5 },
            { xtype: 'textfield', fieldLabel: '建筑', labelAlign: 'right', labelWidth: 150, name: 'Building', columnWidth: .5}]
            }
            ]
        })
        var combo_IfChaoBiao = Ext.create('Ext.form.field.ComboBox', {
            store: store_ifnot,
            queryMode: 'local',
            displayField: 'name',
            valueField: 'name',
            fieldLabel: '是否超标',
            labelAlign: 'right',
            labelWidth: 150,
            name: 'IfChaoBiao',
            columnWidth: .5
        })
        var combo_IfChaoGao = Ext.create('Ext.form.field.ComboBox', {
            store: store_ifnot,
            queryMode: 'local',
            displayField: 'name',
            valueField: 'name',
            fieldLabel: '是否超高',
            labelAlign: 'right',
            labelWidth: 150,
            name: 'IfChaoGao',
            columnWidth: .5
        })
        var combo_IfLvSe = Ext.create('Ext.form.field.ComboBox', {
            store: store_ifnot,
            queryMode: 'local',
            displayField: 'name',
            valueField: 'name',
            fieldLabel: '绿色建筑是否符合标准',
            labelAlign: 'right',
            labelWidth: 150,
            name: 'IfLvSe',
            columnWidth: .5
        })
        var combo_IfJieNeng = Ext.create('Ext.form.field.ComboBox', {
            store: store_ifnot,
            queryMode: 'local',
            displayField: 'name',
            valueField: 'name',
            fieldLabel: '建筑节能是否符合标准',
            labelAlign: 'right',
            labelWidth: 150,
            name: 'IfJieNeng',
            columnWidth: .5
        })
        formpanel_other = Ext.create('Ext.form.Panel', {
            id: 'formpanel_other',
            title: '5 其他项目信息',
            items: [
            { layout: 'column', border: 0, margin: '10', items: [
             { xtype: 'textfield', fieldLabel: '防火等级', labelAlign: 'right', labelWidth: 150, name: 'FangHuoLevel', columnWidth: .5 },
             { xtype: 'textfield', fieldLabel: '抗震设防烈度', labelAlign: 'right', labelWidth: 150, name: 'KangZhenLieDu', columnWidth: .5}]
            },
            { layout: 'column', border: 0, margin: '10', items: [
             { xtype: 'textfield', fieldLabel: '抗震设防类型', labelAlign: 'right', labelWidth: 150, name: 'KangZhenType', columnWidth: .5 },
             { xtype: 'textfield', fieldLabel: '人防等级', labelAlign: 'right', labelWidth: 150, name: 'RenFangLevel', columnWidth: .5}]
            },
             { layout: 'column', border: 0, margin: '10', items: [
             { xtype: 'textfield', fieldLabel: '采暖总负荷', labelAlign: 'right', labelWidth: 150, name: 'CaiNuanFuHe', columnWidth: .5 },
             { xtype: 'textfield', fieldLabel: '空调总负荷', labelAlign: 'right', labelWidth: 150, name: 'KongTiaoFuHe', columnWidth: .5}]
             },
             { layout: 'column', border: 0, margin: '10', items: [
             { xtype: 'textfield', fieldLabel: '采暖方式', labelAlign: 'right', labelWidth: 150, name: 'CaiNuanMethod', columnWidth: .5 },
             { xtype: 'textfield', fieldLabel: '日供水量', labelAlign: 'right', labelWidth: 150, name: 'RiGongShuiLiang', columnWidth: .5}]
             },
              { layout: 'column', border: 0, margin: '10', items: [
             { xtype: 'textfield', fieldLabel: '拟定基础类型及埋深', labelAlign: 'right', labelWidth: 150, name: 'JiChuTypeMaiShen', columnWidth: .5 },
             { xtype: 'textfield', fieldLabel: '室内排水方式', labelAlign: 'right', labelWidth: 150, name: 'ShiNeiPaiShuiMethod', columnWidth: .5}]
              },
             { layout: 'column', border: 0, margin: '10', items: [
             { xtype: 'textfield', fieldLabel: '弱电内容', labelAlign: 'right', labelWidth: 150, name: 'RuoDianContent', columnWidth: .5 },
             { xtype: 'textfield', fieldLabel: '动力总电负荷', labelAlign: 'right', labelWidth: 150, name: 'DongLiZongFuHe', columnWidth: .5}]
             },
             { layout: 'column', border: 0, margin: '10', items: [
             { xtype: 'textfield', fieldLabel: '照明电负荷', labelAlign: 'right', labelWidth: 150, name: 'ZhaoMingDianFuHe', columnWidth: .5 },
             { xtype: 'textfield', fieldLabel: '室外排水方式', labelAlign: 'right', labelWidth: 150, name: 'ShiWaiPaiShuiMethod', columnWidth: .5}]
             },
            { layout: 'column', border: 0, margin: '10', items: [combo_IfChaoBiao, combo_IfChaoGao] },
            { layout: 'column', border: 0, margin: '10', items: [combo_IfLvSe, combo_IfJieNeng] }
            ]
        })
        var store_subprj = Ext.create('Ext.data.JsonStore', {
            fields: ['Id', 'ProjectId', 'SubName', 'UpperLayers', 'DownLayers', 'BuildingArea', 'Height', 'StructureType', 'JiChuXingShi', 'EngineeringLevel', 'Description'],
            proxy: {
                url: 'ProjectCard.aspx?action=loadsubprj&id=' + id,
                type: 'ajax',
                reader: {
                    root: 'rows',
                    type: 'json'
                }
            },
            autoLoad: true
        });
        var combo_subprj_jiegouleixing = Ext.create('Ext.form.field.ComboBox', {
            store: store_jiegouleixing,
            displayField: 'name',
            valueField: 'name',
            multiSelect: true
        })
        var combo_subprj_gongchengdj = Ext.create('Ext.form.field.ComboBox', {
            store: store_gongchengdj,
            displayField: 'name',
            valueField: 'name',
            queryMode: 'local'
        })
        var editor_subprj = Ext.create('Ext.grid.plugin.CellEditing', {
            clicksToEdit: 1
        });
        var tbar_subprj = Ext.create('Ext.toolbar.Toolbar', {
            items: [{ text: '添 加', handler: function () {
                store_subprj.insert(store_subprj.data.length, {});
            }
            }, '-', { text: '删 除' },
            { text: '导出到WORD', handler: function () {
                Ext.Ajax.request({
                    url: 'ProjectList.aspx?action=export_subproject',
                    params: { id: id },
                    success: function (response, opts) {
                        Ext.MessageBox.alert('提示', '导出成功!');
                    },
                    failure: function (response, opts) {
                        Ext.MessageBox.alert('提示', '导出失败!');
                    }
                })
            }
            }]
        })
        grid_subprj = Ext.create('Ext.grid.Panel', {
            title: '6 工程涉及子项目信息',
            id: 'grid_subprj',
            enableColumnHide: false,
            tbar: tbar_subprj,
            plugins: [editor_subprj],
            height: 300,
            store: store_subprj,
            columns: [
            { xtype: 'rownumberer', width: 25 },
            { dataIndex: 'SubName', header: '子项目名称', editor: { xtype: 'textfield' }, flex: 1, sortable: false },
            { dataIndex: 'UpperLayers', header: '地上层数', editor: { xtype: 'numberfield', allowBlank: false }, width: 90, sortable: false },
            { dataIndex: 'DownLayers', header: '地下层数', editor: { xtype: 'numberfield', allowBlank: false }, width: 90, sortable: false },
            { dataIndex: 'BuildingArea', header: '建筑面积(㎡)', editor: { xtype: 'numberfield', allowBlank: false }, width: 100, sortable: false },
            { dataIndex: 'Height', header: '建筑高度(m)', editor: { xtype: 'numberfield' }, width: 100, sortable: false },
            { dataIndex: 'StructureType', header: '结构类型', editor: combo_subprj_jiegouleixing, width: 140, sortable: false },
            { dataIndex: 'JiChuXingShi', header: '基础形式', editor: { xtype: 'textfield' }, width: 140, sortable: false },
            { dataIndex: 'EngineeringLevel', header: '工程等级', editor: combo_subprj_gongchengdj, width: 90, sortable: false },
            { dataIndex: 'Description', header: '其他', editor: { xtype: 'textarea' }, width: 200, sortable: false }
            ]
        })
        var store_kanchashejiuser = Ext.create('Ext.data.JsonStore', {
            fields: ['Id', 'ProjectId', 'UserName', 'ShenFenZhengNo', 'MajorCode', 'MajorName', 'Position', 'SealNo'],
            proxy: {
                url: 'ProjectCard.aspx?action=loadkanchashejiuser&id=' + id,
                type: 'ajax',
                reader: {
                    root: 'rows',
                    type: 'json'
                }
            },
            autoLoad: true
        });
        var editor_kanchashejiuser = Ext.create('Ext.grid.plugin.CellEditing', {
            clicksToEdit: 1
        });
        var tbar_kanchashejiuser = Ext.create('Ext.toolbar.Toolbar', {
            items: [{ text: '添 加', handler: function () {
                store_kanchashejiuser.insert(store_kanchashejiuser.data.length, {});
            }
            }, '-', { text: '删 除'}]
        })
        var store_MajorName = Ext.create('Ext.data.JsonStore', {
            fields: ['name'],
            proxy: {
                url: 'ProjectCard.aspx?action=loadmajor',
                type: 'ajax',
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            },
            autoLoad: true
        })
        var combo_MajorName = Ext.create('Ext.form.field.ComboBox', {
            store: store_MajorName,
            displayField: 'name',
            valueField: 'name',
            multiSelect: true
        })
        var store_Position = Ext.create('Ext.data.JsonStore', {
            fields: ['name'],
            data: [{ name: '一级注册建筑师' }, { name: '二级注册建筑师' }, { name: '一级注册结构师' }, { name: '二级注册结构师' }, { name: '注册土木工程师(岩土)'}]
        })
        var combo_Position = Ext.create('Ext.form.field.ComboBox', {
            store: store_Position,
            displayField: 'name',
            valueField: 'name',
            queryMode: 'local'
        })
        grid_kanchashejiuser = Ext.create('Ext.grid.Panel', {
            title: '7 工程涉及勘察设计人员信息',
            id: 'grid_kanchashejiuser',
            enableColumnHide: false,
            tbar: tbar_kanchashejiuser,
            plugins: [editor_kanchashejiuser],
            height: 450,
            store: store_kanchashejiuser,
            columns: [
            { xtype: 'rownumberer', width: 25 },
            { dataIndex: 'id', hidden: true },
            { dataIndex: 'ProjectId', hidden: true },
            { dataIndex: 'MajorCode', header: 'MajorCode', hidden: true },
            { dataIndex: 'UserName', header: '人员姓名', editor: { xtype: 'textfield' }, width: 100, sortable: false },
            { dataIndex: 'ShenFenZhengNo', header: '身份证号码', editor: { xtype: 'textfield' }, width: 200, sortable: false },
            { dataIndex: 'MajorName', header: '专业名称', width: 200, editor: combo_MajorName, sortable: false },
            { dataIndex: 'Position', header: '注册类别|注册等级|技术职称 ', width: 200, editor: combo_Position, sortable: false },
            { dataIndex: 'SealNo', header: '执业印章号', editor: { xtype: 'textfield' }, width: 130, sortable: false }
            ]
        })
        var store_expert = Ext.create('Ext.data.JsonStore', {
            fields: ['Id', 'ProjectId', 'UserId', 'UserName', 'State', 'MajorName', 'QianZhangId', 'QianZhangName', 'ShenHeId', 'ShenHeName'],
            proxy: {
                url: 'ProjectCard.aspx?action=loadprojectuser&id=' + id,
                type: 'ajax',
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            },
            autoLoad: true
        })
        var combo_expertmajor = Ext.create('Ext.form.field.ComboBox', {
            store: store_MajorName,
            displayField: 'name',
            valueField: 'name'
        })
        var store_expert_shentu = Ext.create('Ext.data.JsonStore', {
            fields: ['UserId', 'UserName'],
            proxy: {
                url: 'ProjectCard.aspx?action=loadexpert_shentu',
                type: 'ajax',
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        })
        var combo_expert_shentu = Ext.create('Ext.form.field.ComboBox', {
            store: store_expert_shentu,
            displayField: 'UserName',
            valueField: 'UserId',
            queryMode: 'local',
            listeners: { select: function (combo, records, eOpts) {
                rawValue = combo_expert_shentu.getRawValue();
            }
            }
        })
        var store_expert_qianzhang = Ext.create('Ext.data.JsonStore', {
            fields: ['UserId', 'UserName'],
            proxy: {
                url: 'ProjectCard.aspx?action=loadexpert_qianzhang',
                type: 'ajax',
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        })
        var combo_expert_qianzhang = Ext.create('Ext.form.field.ComboBox', {
            store: store_expert_qianzhang,
            displayField: 'UserName',
            valueField: 'UserId',
            queryMode: 'local',
            listeners: { select: function (combo, records, eOpts) {
                rawValue = combo_expert_qianzhang.getRawValue();
            }
            }
        })
        var store_expert_shenhe = Ext.create('Ext.data.JsonStore', {
            fields: ['UserId', 'UserName'],
            proxy: {
                url: 'ProjectCard.aspx?action=loadexpert_shenhe',
                type: 'ajax',
                reader: {
                    type: 'json',
                    root: 'rows'
                }
            }
        })
        var combo_expert_shenhe = Ext.create('Ext.form.field.ComboBox', {
            store: store_expert_shenhe,
            displayField: 'UserName',
            valueField: 'UserId',
            queryMode: 'local',
            listeners: { select: function (combo, records, eOpts) {
                rawValue = combo_expert_shenhe.getRawValue();
            }
            }
        })
        var tbar_expert = Ext.create('Ext.toolbar.Toolbar', {
            items: [{ text: '添 加', handler: function () {
                store_expert.insert(store_expert.data.length, {});
            }
            }, { text: '删 除', handler: function () {
                var recs = grid_expert.getSelectionModel().getSelection();
                store_expert.remove(recs);
            }
            }]
        })
        var editor_expert = Ext.create('Ext.grid.plugin.CellEditing', {
            clicksToEdit: 1,
            listeners: { beforeedit: function (editor, e, eOpts) {
                rawValue = "";
                if (e.field == "UserName") {
                    combo_expert_shentu.clearValue();
                    store_expert_shentu.removeAll();
                    store_expert_shentu.load({ params: { majorname: e.record.get("MajorName")} });
                }
                if (e.field == "QianZhangName") {
                    combo_expert_qianzhang.clearValue();
                    store_expert_qianzhang.removeAll();
                    store_expert_qianzhang.load({ params: { majorname: e.record.get("MajorName")} });
                }
                if (e.field == "ShenHeName") {
                    combo_expert_shenhe.clearValue();
                    store_expert_shenhe.removeAll();
                    store_expert_shenhe.load({ params: { majorname: e.record.get("MajorName")} });
                }
            },
                edit: function (editor, e, eOpts) {
                    if (rawValue) {
                        if (e.field == "UserName") {
                            e.record.set("UserId", e.value);
                            e.record.set("UserName", rawValue);
                        }
                        if (e.field == "QianZhangName") {
                            e.record.set("QianZhangId", e.value);
                            e.record.set("QianZhangName", rawValue);
                        }
                        if (e.field == "ShenHeName") {
                            e.record.set("ShenHeId", e.value);
                            e.record.set("ShenHeName", rawValue);
                        }
                    }
                }
            }
        });
        grid_expert = Ext.create('Ext.grid.Panel', {
            tbar: tbar_expert,
            store: store_expert,
            title: '8 专家分配情况',
            plugins: [editor_expert],
            enableColumnHide: false,
            height: 450,
            id: 'grid_expert',
            columns: [
                    { dataIndex: 'Id', hidden: true },
                    { dataIndex: 'ProjectId', hidden: true },
                    { dataIndex: 'UserId', hidden: true },
                    { dataIndex: 'QianZhangId', hidden: true },
                    { dataIndex: 'ShenHeId', hidden: true },
                    { xtype: 'rownumberer', width: 25 },
                    { dataIndex: 'MajorName', header: '专业名称', editor: combo_expertmajor, width: 120, sortable: false },
                    { dataIndex: 'UserName', header: '审图专家', editor: combo_expert_shentu, width: 100 },
                    { dataIndex: 'QianZhangName', header: '签章专家', editor: combo_expert_qianzhang, width: 100 },
                    { dataIndex: 'ShenHeName', header: '审核专家', editor: combo_expert_shenhe, width: 100}]
        })
        var panel_end = Ext.create('Ext.panel.Panel', {
            title: '9 结束',
            height: 300,
            html: '<h2>项目信息更新结束<h2> '
        })
        panel = Ext.create('Ext.panel.Panel', {
            layout: 'card',
            region: 'center',
            items: [formpanel_baseinfo, formpanel_gaikuang, formpanel_unit, formpanel_standard, formpanel_other, grid_subprj, grid_kanchashejiuser, grid_expert, panel_end],
            buttons: [{
                id: 'move-prev',
                text: '上一步',
                handler: function () {
                    var layout = panel.getLayout();
                    layout.prev(); //设定当前active的component的前一个component可见
                    Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
                    Ext.getCmp('move-next').setDisabled(!layout.getNext()); //获得当前active的component的后一个component或false
                }
            }, {
                id: 'move-next',
                text: '下一步', handler: function (btn) {
                    var layout = panel.getLayout();  //navigate(btn.up("panel"), "next");
                    switch (layout.getActiveItem().id) {
                        case "formpanel_baseinfo":
                            formpanel_baseinfo_save();
                            break;
                        case "formpanel_gaikuang":
                            formpanel_gaikuang_save();
                            break;
                        case "formpanel_unit":
                            formpanel_unit_save();
                            break;
                        case "formpanel_standard":
                            formpanel_standard_save();
                            break;
                        case "formpanel_other":
                            formpanel_other_save();
                            break;
                        case "grid_subprj":
                            grid_subprj_save();
                            break;
                        case "grid_kanchashejiuser":
                            grid_kanchashejiuser_save();
                            break;
                        case "grid_expert":
                            grid_expert_save();
                            break;
                    }
                }
            }],
            buttonAlign: 'center'
        })
        var viewport = Ext.create('Ext.container.Viewport', {
            layout: 'border',
            items: [panel]
        })
        if (id) {
            Ext.Ajax.request({
                url: 'ProjectCard.aspx?action=loadform&id=' + id,
                success: function (response, opts) {
                    var json = Ext.decode(response.responseText);
                    formpanel_baseinfo.getForm().setValues(json.data);
                    if (json.data.SongShenTime) {
                        var str = new Date(json.data.SongShenTime);
                        Ext.getCmp("SongShenTime").setValue(str);
                    }
                    formpanel_gaikuang.getForm().setValues(json.data);
                    formpanel_unit.getForm().setValues(json.data);
                    formpanel_standard.getForm().setValues(json.data);
                    formpanel_other.getForm().setValues(json.data);
                }
            })
        }
        var layout = panel.getLayout(); //设定当前active的component的前一个component可见
        Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
        Ext.getCmp('move-next').setDisabled(!layout.getNext()); //获得当前active的component的后一个component或false
    })
    function formpanel_baseinfo_save() {
        if (formpanel_baseinfo.getForm().isValid()) {
            var action = id ? 'update' : 'create';
            Ext.Ajax.request({
                url: 'ProjectCard.aspx?action=' + action + '&formdata=' + Ext.encode(formpanel_baseinfo.getForm().getValues()),
                method: 'POST',
                success: function (response, opts) {
                    var json = Ext.decode(response.responseText);
                    id = json.data.Id;
                    formpanel_baseinfo.getForm().findField("Id").setValue(id);
                    var layout = panel.getLayout();
                    layout.next(); //获得当前active的component的后台一个component 或false
                    Ext.getCmp('move-next').setDisabled(!layout.getNext());
                    Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
                }
            })
        }
    }
    function formpanel_gaikuang_save() {
        if (formpanel_gaikuang.getForm().isValid()) {
            var structuretype = Ext.getCmp("StructureType").getValue();
            var temp = "";
            for (var i = 0; i < structuretype.length; i++) {
                temp += structuretype[i] + (i == structuretype.length - 1 ? "" : ",");
            }
            var formdata = formpanel_gaikuang.getForm().getValues();
            formdata.StructureType = temp;
            Ext.Ajax.request({
                url: 'ProjectCard.aspx?action=update_gaikuang',
                params: { id: id, formdata: Ext.encode(formdata) },
                success: function (response, opts) {
                    var layout = panel.getLayout();
                    layout.next();
                    Ext.getCmp('move-next').setDisabled(!layout.getNext());
                    Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
                }
            })
        }
    }
    function formpanel_unit_save() {
        if (formpanel_unit.getForm().isValid()) {
            Ext.Ajax.request({
                url: 'ProjectCard.aspx?action=update_unit',
                params: { id: id, formdata: Ext.encode(formpanel_unit.getForm().getValues()) },
                success: function (response, opts) {
                    var layout = panel.getLayout();
                    layout.next();
                    Ext.getCmp('move-next').setDisabled(!layout.getNext());
                    Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
                }
            })
        }
    }
    function formpanel_standard_save() {
        if (formpanel_standard.getForm().isValid()) {
            Ext.Ajax.request({
                url: 'ProjectCard.aspx?action=update_standard',
                params: { id: id, formdata: Ext.encode(formpanel_standard.getForm().getValues()) },
                success: function (response, opts) {
                    var layout = panel.getLayout();
                    layout.next();
                    Ext.getCmp('move-next').setDisabled(!layout.getNext());
                    Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
                }
            })
        }
    }
    function formpanel_other_save() {
        if (formpanel_other.getForm().isValid()) {
            Ext.Ajax.request({
                url: 'ProjectCard.aspx?action=update_other',
                params: { id: id, formdata: Ext.encode(formpanel_other.getForm().getValues()) },
                success: function (response, opts) {
                    var layout = panel.getLayout();
                    layout.next();
                    Ext.getCmp('move-next').setDisabled(!layout.getNext());
                    Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
                }
            })
        }
    }
    function grid_subprj_save() {
        var recs = grid_subprj.store.getRange();
        for (var j = 0; j < recs.length; j++) {
            if (recs[j].isModified("StructureType")) {
                var structuretype = recs[j].get("StructureType");
                var temp = "";
                for (var i = 0; i < structuretype.length; i++) {
                    temp += structuretype[i] + (i == structuretype.length - 1 ? "" : ",");
                }
                recs[j].set("StructureType", temp);
            }
        }
        var subprjs = Ext.encode(Ext.pluck(grid_subprj.store.data.items, 'data'));
        Ext.Ajax.request({
            url: 'ProjectCard.aspx?action=update_subprj',
            params: { id: id, subprjs: subprjs },
            success: function (response, opts) {
                grid_subprj.store.commitChanges();
                var layout = panel.getLayout();
                layout.next();
                Ext.getCmp('move-next').setDisabled(!layout.getNext());
                Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
            }
        })
    }
    function grid_kanchashejiuser_save() {
        var recs = grid_kanchashejiuser.store.getRange();
        for (var j = 0; j < recs.length; j++) {
            if (recs[j].isModified("MajorName")) {
                var majorname = recs[j].get("MajorName");
                var temp = "";
                for (var i = 0; i < majorname.length; i++) {
                    temp += majorname[i] + (i == majorname.length - 1 ? "" : ",");
                }
                recs[j].set("MajorName", temp);
            }
        }
        var kanchashejiuser = Ext.encode(Ext.pluck(grid_kanchashejiuser.store.data.items, 'data'));
        Ext.Ajax.request({
            url: 'ProjectCard.aspx?action=update_kanchashejiuser',
            params: { id: id, kanchashejiuser: kanchashejiuser },
            success: function (response, opts) {
                grid_kanchashejiuser.store.commitChanges();
                var layout = panel.getLayout();
                layout.next();
                Ext.getCmp('move-next').setDisabled(!layout.getNext());
                Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
            }
        })
    }
    function grid_expert_save() {
        var projectexpert = Ext.encode(Ext.pluck(grid_expert.store.data.items, 'data'));
        Ext.Ajax.request({
            url: 'ProjectCard.aspx?action=update_projectexpert',
            params: { id: id, projectexpert: projectexpert },
            success: function (response, opts) {
                grid_expert.store.commitChanges();
                var layout = panel.getLayout();
                layout.next();
                Ext.getCmp('move-next').setDisabled(!layout.getNext());
                Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
            }
        })
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
