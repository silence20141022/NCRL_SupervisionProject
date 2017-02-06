<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChouJinCard.aspx.cs" Inherits="SP.Web.ConsultationManage.ChouJinCard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script type="text/javascript">
        var id = getQueryString("id");
        var store_choujin, shoukuanid;
        Ext.onReady(function () {
            var store_year = Ext.create('Ext.data.JsonStore', {
                fields: ['year'],
                proxy: {
                    type: 'ajax',
                    url: 'ChouJinCard.aspx?action=loadyear',
                    reader: {
                        root: 'rows',
                        type: 'json'
                    }
                },
                autoLoad: true
            })
            var combo_year = Ext.create('Ext.form.field.ComboBox', {
                displayField: 'year',
                valueField: 'year',
                name: 'BelongYear',
                store: store_year,
                editable: false,
                fieldLabel: '所属年份',
                labelAlign: 'right',
                anchor: '30%',
                readOnly: id,
                margin: '10',
                allowBlank: false,
                blankText: '所属年份不能为空',
                msgTarget: 'under'
            })
            var store_month = Ext.create('Ext.data.JsonStore', {
                fields: ['month'],
                proxy: {
                    type: 'ajax',
                    url: 'ChouJinCard.aspx?action=loadmonth',
                    reader: {
                        root: 'rows',
                        type: 'json'
                    }
                },
                autoLoad: true
            })
            var combo_month = Ext.create('Ext.form.field.ComboBox', {
                fieldLabel: '所属月份',
                labelAlign: 'right',
                store: store_month,
                anchor: '30%',
                displayField: 'month',
                valueField: 'month',
                editable: false,
                readOnly: id,
                allowBlank: false,
                margin: '10',
                blankText: '所属月份不能为空',
                msgTarget: 'under',
                name: 'BelongMonth'
            })
            var field_remark = Ext.create('Ext.form.field.TextArea', {
                fieldLabel: '备注',
                labelAlign: 'right',
                name: 'Remark',
                margin: '10',
                anchor: '50%'
            })
            var formpanel = Ext.create('Ext.form.Panel', {
                title: '1 基本信息',
                id: 'form_choujin',
                items: [
                        combo_year, combo_month, { xtype: 'hidden', name: 'Id' },
                       { xtype: 'displayfield', fieldLabel: '酬金总金额', labelAlign: 'right', name: 'ChouJinAmount', margin: '10' }, field_remark
                ]
            })
            Ext.regModel('ShouKuan', { fields: ['Id', 'ProjectName', 'InvoiceNo', 'ShouKuanAmount', 'ShouKuanDate', 'YiFenPercent', 'ChouJinAmount']
            })
            var store_shoukuan = Ext.create('Ext.data.JsonStore', {
                model: 'ShouKuan',
                proxy: {
                    url: 'ChouJinCard.aspx?action=loadshoukuan',
                    type: 'ajax',
                    reader: {
                        root: 'rows',
                        type: 'json'
                    }
                }
            })
            var toolbar_shoukuan = Ext.create('Ext.toolbar.Toolbar', {
                items: [{ text: '添 加', handler: function () {
                    store_shoukuansel.load({ callback: function () {
                        win.show();
                    }
                    });
                }
                }, '-', { text: '删 除', handler: function () {
                    var recs = grid_shoukuan.getSelectionModel().getSelection();
                    if (recs.length == 0) {
                        Ext.MessageBox.alert('提示', '请选择要删除的记录!');
                        return;
                    }
                    if (recs[0].get("YiFenPercent")) {
                        Ext.MessageBox.alert('提示', '已分配的收款记录不能删除!');
                        return;
                    }
                    store_shoukuan.remove(recs[0]);
                }
                }]
            })
            var grid_shoukuan = Ext.create('Ext.grid.Panel', {
                id: 'grid_shoukuan',
                title: '2 收款记录',
                tbar: toolbar_shoukuan,
                store: store_shoukuan,
                columns: [
                { xtype: 'rownumberer', width: 25 },
                { header: '项目名称', dataIndex: 'ProjectName', flex: 1 },
                { header: '收款日期', dataIndex: 'ShouKuanDate', xtype: 'datecolumn', format: 'Y-m-d', width: 100 },
                { header: '收款金额', dataIndex: 'ShouKuanAmount', xtype: 'numbercolumn', format: '0,000', width: 90 },
                { header: '发票号', dataIndex: 'InvoiceNo', width: 120 },
                { header: '已分比例', dataIndex: 'YiFenPercent', width: 80 },
                { header: '酬金金额', dataIndex: 'ChouJinAmount', xtype: 'numbercolumn', format: '0,000', width: 90 }
                ]
            })
            //所有未分配的收款记录，用于选择
            var store_shoukuansel = Ext.create('Ext.data.JsonStore', {
                fields: ['Id', 'ProjectName', 'InvoiceNo', 'ShouKuanAmount', 'ShiJiShouFei', 'ShouKuanDate', 'ChouJinAmount'],
                proxy: {
                    url: 'ChouJinCard.aspx?action=loadshoukuan_unfenpei',
                    type: 'ajax',
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            })
            var grid_shoukuansel = Ext.create('Ext.grid.Panel', {
                store: store_shoukuansel,
                selModel: { selType: "checkboxmodel" },
                region: 'center',
                columns: [
                { xtype: "rownumberer", width: 35 },
                { header: '项目名称', dataIndex: 'ProjectName', flex: 1 },
                { header: '收款日期', dataIndex: 'ShouKuanDate', xtype: 'datecolumn', format: 'Y-m-d', width: 100 },
                { header: '收款金额', dataIndex: 'ShouKuanAmount', xtype: 'numbercolumn', format: '0,000', width: 90 },
                { header: '发票号', dataIndex: 'InvoiceNo', width: 120 },
                { header: '实际收费', dataIndex: 'ShiJiShouFei', xtype: 'numbercolumn', width: 90, format: '0,000' },
                { header: '酬金金额', dataIndex: 'ChouJinAmount', xtype: 'numbercolumn', format: '0,000', width: 90}]
            })
            var win = Ext.create('Ext.window.Window', {
                height: 450,
                width: 800,
                layout: 'border',
                closeAction: 'hide',
                items: [grid_shoukuansel],
                buttonAlign: 'center',
                buttons: [{ text: '确 定', handler: function () {
                    var recs = grid_shoukuansel.getSelectionModel().getSelection();
                    if (recs.length == 0) {
                        Ext.MessageBox.alert('提示', '请选择要参与分配的收款记录！');
                        return;
                    }
                    for (var i = 0; i < recs.length; i++) {
                        if (store_shoukuan.find("Id", recs[i].get("Id")) == -1) {
                            store_shoukuan.insert(store_shoukuan.data.length, recs[i]);
                        }
                    }
                    win.close();
                }
                }, { text: '取 消', handler: function () {
                    win.close();
                }
                }]
            })
            Ext.regModel('ChouJinDetail', { fields: [] });
            var editor = Ext.create('Ext.grid.plugin.CellEditing', {
                clicksToEdit: 1,
                listeners: {
                    beforeedit: function (editor, e, eOpts) {
                        shoukuanid = e.field.slice(0, 36); //记住 beforeedit事件无e.originalValue 对象
                        var yifenpercent = (store_choujin.getAt(4).get(shoukuanid + "@A") ? store_choujin.getAt(4).get(shoukuanid + "@A") : 0); //项目已分配的百分比存在第5行项目第一列;这是我定义的规则
                        var max = 100 - parseFloat(yifenpercent) + parseFloat(e.value ? e.value : 0);
                        Ext.getCmp(e.field.slice(0, 36) + "_numberfield").setMaxValue(parseFloat(max));
                        if (!e.record.get("UserId")) {
                            return false;
                        }
                    },
                    edit: function (editor, e, eOpts) {
                        shoukuanid = e.field.slice(0, 36);
                        var pct = e.value ? e.value : 0;
                        var rec4 = store_choujin.getAt(3);
                        var rec5 = store_choujin.getAt(4);
                        var totalchoujin = store_choujin.getAt(3).get(shoukuanid + "@C"); //项目可分配酬金
                        var choujin_shoukuan = Math.round((parseFloat(pct) / 100) * (parseFloat(totalchoujin)) * 100) / 100;
                        var choujinstage_origi = e.record.get("StageAmount") ? parseFloat(e.record.get("StageAmount")) : 0;
                        var StageAmount = parseFloat(choujinstage_origi) + parseFloat(choujin_shoukuan) - (e.originalValue ? parseFloat(e.record.get(shoukuanid + "@C")) : 0);
                        e.record.set("StageAmount", (Math.round(parseFloat(StageAmount) * 100) / 100 > 0 ? Math.round(parseFloat(StageAmount) * 100) / 100 : '')); //累加该人员总酬金
                        e.record.set(shoukuanid + "@C", choujin_shoukuan > 0 ? choujin_shoukuan : '');
                        e.record.set(e.field, pct > 0 ? pct : '');
                        var yifenpercent = (rec5.get(shoukuanid + "@A") ? parseFloat(rec5.get(shoukuanid + "@A")) : 0) + parseFloat(pct) - (e.originalValue ? parseFloat(e.originalValue) : 0);
                        rec5.set(shoukuanid + "@A", yifenpercent);
                        Ext.Ajax.request({
                            url: 'ChouJinCard.aspx?action=savechoujindetail',
                            params: { shoukuanid: shoukuanid, expertid: e.record.get("UserId"), username: e.record.get("UserName"),
                                choujinpercent: pct, choujinamount: choujin_shoukuan, id: id, yifenpercent: yifenpercent,
                                ifcanyu: e.record.get(shoukuanid + "@A"), stageamount: StageAmount
                            }
                        });
                    }
                }
            })
            var grid_choujin = Ext.create('Ext.grid.Panel', {
                title: '3 酬金分配',
                id: 'choujindetail',
                columnLines: true,
                enableColumnHide: false,
                plugins: [editor],
                columns: [
                ]
            })
            Ext.regModel("ChouJinResult", { fields: ['ChouJinId', 'ExpertId', 'UserName', 'StageAmount', 'AdjustAmount', 'Remark'] })
            var store_result = Ext.create('Ext.data.JsonStore', {
                model: 'ChouJinResult',
                proxy: {
                    url: 'ChouJinCard.aspx?action=loadchoujinresult',
                    type: 'ajax',
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                }
            })
            var tbar_result = Ext.create('Ext.toolbar.Toolbar', {
                items: [{ text: '打 印', handler: function () {
                    url = "ChouJinPrint.aspx?choujinid=" + id;
                    doprint(url);
                    //opencenterwin("ChouJinPrint.aspx?choujinid=" + id, 1000, 500);
                }
                }]
            })
            var grid_result = Ext.create('Ext.grid.Panel', {
                title: '4 酬金调整',
                enableColumnHide: false,
                columnLines: true,
                tbar: tbar_result,
                features: [{ ftype: 'summary'}],
                store: store_result,
                plugins: [Ext.create('Ext.grid.plugin.CellEditing', {
                    clicksToEdit: 1,
                    listeners: { edit: function (editor, e, eOpts) {
                        Ext.Ajax.request({
                            url: 'ChouJinCard.aspx?action=adjustresult',
                            params: { id: id, expertid: e.record.get("ExpertId"), adjustamount: e.record.get("AdjustAmount"), remark: e.record.get("Remark")
                            }
                        })
                    }
                    }
                })],
                columns: [
                    { header: "<div id='divTitle'>专家酬金</div>", columns: [
                    { xtype: 'rownumberer', width: 50 },
                    { dataIndex: 'ExperId', header: 'ExperId', hidden: true },
                    { dataIndex: 'UserName', header: '姓名', width: 90, sortable: false, summaryRenderer: function (v, params, data) { return "合计:" } },
                    { dataIndex: 'StageAmount', header: '计算金额(￥)', width: 120, summaryType: 'sum', summaryRenderer: function (v, params, data) { return Math.round(v * 100) / 100 } },
                    { dataIndex: 'AdjustAmount', header: '<font style="color:red">调整金额(￥)</font>', width: 120, summaryType: 'sum', summaryRenderer: function (v, params, data) { return Math.round(v * 100) / 100 },
                        editor: { xtype: 'numberfield', minValue: 0, allowBlank: false }
                    },
                    { dataIndex: 'Remark', header: '备注', editor: { xtype: 'textarea', allowBlank: false }, width: 500 }
                ]
                    }
                ]
            })
            var store_preview = Ext.create('Ext.data.JsonStore', {
                fields: ['SortIndex1', 'UserName1', 'Amount1', 'SortIndex2', 'UserName2', 'Amount2'],
                proxy: {
                    url: 'ChouJinCard.aspx?action=choujinpreview',
                    type: 'ajax',
                    reader: {
                        type: 'json',
                        root: 'rows'
                    }
                },
                autoLoad: true
            })
            //            var grid_preview = Ext.create('Ext.grid.Panel', {
            //            store:store_preview,
            //            title:'5 酬金预览',

            //            })
            var panel = Ext.create('Ext.panel.Panel', {
                layout: 'card',
                region: 'center',
                items: [formpanel, grid_shoukuan, grid_choujin, grid_result],
                buttonAlign: 'center',
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
                    text: '下一步',
                    handler: function (btn) {
                        var layout = panel.getLayout();  //navigate(btn.up("panel"), "next");
                        switch (layout.getActiveItem().id) {
                            case "form_choujin":
                                if (formpanel.getForm().isValid()) {
                                    var action = id ? 'update' : 'create';
                                    Ext.Ajax.request({
                                        url: 'ChouJinCard.aspx?action=' + action + '&formdata=' + Ext.encode(formpanel.getForm().getValues()),
                                        method: 'POST',
                                        success: function (response, opts) {
                                            var json = Ext.decode(response.responseText);
                                            if (json.id) {
                                                id = json.id;
                                                formpanel.getForm().findField("Id").setValue(id);
                                                layout.next(); //获得当前active的component的后台一个component 或false
                                                Ext.getCmp('move-next').setDisabled(!layout.getNext());
                                                Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
                                                store_shoukuan.load({ params: { id: id} });
                                            }
                                        }
                                    })
                                }
                                break;
                            case "grid_shoukuan":
                                if (store_shoukuan.data.length == 0) {
                                    Ext.MessageBox.alert('提示', '参与酬金分配的收款记录不能为空!');
                                    return
                                }
                                var shoukuanids = "";
                                Ext.each(store_shoukuan.getRange(), function (rec) {
                                    shoukuanids += rec.get("Id") + ",";
                                })
                                Ext.Ajax.request({
                                    url: 'ChouJinCard.aspx?action=updateshoukuan&shoukuanids=' + shoukuanids + '&id=' + id,
                                    method: 'POST',
                                    success: function (response, opts) {
                                        var json = Ext.decode(response.responseText);
                                        var filedarray = [];
                                        var columnarray = [{ xtype: 'rownumberer', width: 50}];
                                        var i = 0;
                                        var subarray = [];
                                        for (var key in json.rows[0]) {
                                            filedarray.push(key);
                                            switch (key) {
                                                case "UserName":
                                                    columnarray.push({ header: '项目名称', dataIndex: key, width: 100, sortable: false });
                                                    break;
                                                case "StageAmount":
                                                    columnarray.push({ header: '酬金合计', dataIndex: key, width: 90, sortable: false });
                                                    break;
                                                case "UserId":
                                                    columnarray.push({ header: key, dataIndex: key, hidden: true, sortable: false });
                                                    break;
                                                default:
                                                    if (key.indexOf("@A") > 0) {
                                                        subarray.push({ header: '参与审查', dataIndex: key, width: 90, sortable: false, renderer: function (value, metadata, record, rowindex, colIndex) { return rowindex == 0 ? null : value; } });
                                                    }
                                                    if (key.indexOf("@B") > 0) {
                                                        subarray.push({ header: '<span style="color:red">分配比例</span>', dataIndex: key, width: 90, allowBlank: false, maxText: '剩余最大比例是{0}', mstTarget: 'under', sortable: false,
                                                            editor: { xtype: 'numberfield', allowDecimal: 2, minValue: 0, id: key.slice(0, 36) + '_numberfield' },
                                                            renderer: function (value, metadata, record, rowindex, colIndex) { return rowindex == 1 ? null : value; }
                                                        });
                                                    }
                                                    if (key.indexOf("@C") > 0) {
                                                        subarray.push({ header: '分配金额', dataIndex: key, width: 90, sortable: false });
                                                    }
                                                    if (i > 2 && i % 3 == 2) {
                                                        var header = key.slice(0, 36) + "@A";
                                                        columnarray.push({ header: json.rows[0][header], columns: subarray });
                                                        subarray = [];
                                                    }
                                            }
                                            i++;
                                        }
                                        ChouJinDetail.setFields(filedarray); //Model构建完毕
                                        store_choujin = Ext.create('Ext.data.JsonStore',
                                        {
                                            model: 'ChouJinDetail',
                                            data: json.rows
                                        })
                                        grid_choujin.reconfigure(store_choujin, columnarray);
                                        layout.next(); //获得当前active的component的后台一个component 或false
                                        Ext.getCmp('move-next').setDisabled(!layout.getNext());
                                        Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
                                    }
                                })
                                break;
                            case "choujindetail":
                                layout.next(); //获得当前active的component的后台一个component 或false
                                Ext.getCmp('move-next').setDisabled(!layout.getNext());
                                Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
                                store_result.load({ params: { id: id },
                                    callback: function (records, operation, success) {
                                        var json = Ext.decode(operation.response.responseText);
                                        Ext.get('divTitle').setHTML('<font style="color:blue;font-size:18px"><b>' + json.title + '</b></font>');
                                    }
                                });
                                break;
                        }
                    }
                }]
            })
            var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [panel]
            })
            if (id) {
                formpanel.getForm().load({
                    url: 'ChouJinCard.aspx?action=loadform&id=' + id,
                    method: 'POST', //请求方式   
                    success: function (form, action) {
                        //                        if (action.result.data.KaiPiaoDate) {
                        //                            var str = new Date(action.result.data.KaiPiaoDate);
                        //                            Ext.getCmp("KaiPiaoDate").setValue(str);
                        //                        }
                    }
                });
            }
            var layout = panel.getLayout();
            Ext.getCmp('move-next').setDisabled(!layout.getNext());
            Ext.getCmp('move-prev').setDisabled(!layout.getPrev());
        })
        function doprint(url) {
            try {
                var LODOP = document.getElementById("LODOP"); //这行语句是为了符合DTD规范
                LODOP.PRINT_INIT("");
                LODOP.NewPage();
                //  LODOP.ADD_PRINT_URL(20, 18, 750, 1050, url);
                LODOP.ADD_PRINT_URL(6, 10, 720, 1075, url);
                LODOP.PREVIEW();
            }
            catch (ex) {
                alert("未安装打印控件，请安装打印控件");
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
