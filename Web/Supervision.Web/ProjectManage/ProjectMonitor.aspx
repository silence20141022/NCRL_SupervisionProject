<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectMonitor.aspx.cs"
    Inherits="SP.Web.ProjectManage.ProjectMonitor" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>项目监控</title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../Extjs42/TreePicker.js" type="text/javascript"></script>
    <script src="../echarts/build/dist/echarts-all.js" type="text/javascript"></script>
    <script type="text/javascript">
        var store, grid;
        var finished = 0;
        var undone = 0;
        var count = 0;
        Ext.onReady(function () {
            Ext.regModel("Project", { fields: ["ProjectName", "PManagerName", "Remark", "CreateTime"] });
            store = Ext.create("Ext.data.JsonStore", {
                model: "Project",
                proxy: {
                    url: "ProjectMonitor.aspx",
                    extraParams: { action: "async", FileTypeId: "", Years: "", State: "", ProjectName: "" },
                    type: "ajax",
                    reader: {
                        type: "json",
                        root: "rows"
                    }
                }
            });
            var store_filetype = Ext.create("Ext.data.TreeStore", {
                fields: ["id", "Name", 'leaf'],
                root: {
                    Name: "文件类型",
                    id: "cf38bd7a-79d1-46fb-bf06-640b30f61654",
                    expanded: true
                },
                proxy: {
                    type: "ajax",
                    url: "ProjectMonitor.aspx?action=loadFileType",
                    reader: { type: "json" }
                },
                nodeParam: "id"
            });

            var store_state = Ext.create("Ext.data.Store", {
                fields: ["state"],
                data: [{ "state": "已上传" }, { "state": "未上传"}]
            });

            var store_year = Ext.create("Ext.data.Store", {
                fields: ["year"],
                data: [{ "year": "2014" }, { "year": "2015"}]
            });

            var store_month = Ext.create("Ext.data.Store", {
                fields: ["month"],
                data: [{ "month": "1" }, { "month": "2"}]
            });

            var toolbar = Ext.create('Ext.toolbar.Toolbar', {
                items: [
                { xtype: "treepicker",
                    name: "FileTypeId",
                    id: "FileTypeId",
                    fieldLabel: "文件类型",
                    labelAlign: "right",
                    width: 350,
                    valueField: "Id",
                    displayField: 'Name',
                    store: store_filetype,
                    listeners: { select: function (picker, record, eOpts) {
                        if (!record.get("leaf")) {
                            Ext.getCmp("FileTypeId").setValue("");
                            Ext.Msg.alert("提示", "请选择二级类型");
                        }
                    }
                    },
                    forceSelection: true,
                    margin: "10 0 10 0",
                    editable: false
                },
                                { xtype: "combo",
                                    fieldLabel: "状态",
                                    labelWidth: 45,
                                    id: "state",
                                    labelAlign: "right",
                                    store: store_state,
                                    //        emptyText: "默认未上传",
                                    value: "未上传",
                                    displayField: "state",
                                    valueField: "state",
                                    margin: "10 0 10 0"
                                },
                {
                    xtype: "datefield",
                    fieldLabel: "年-月",
                    labelWidth: 45,
                    name: "Years",
                    id: "Years",
                    labelAlign: "right",
                    format: "Y-m",
                    margin: "10 0 10 0"

                },

                { margin: "10 10 10 10", text: '查 询', handler: function () {
                    var FileTypeId = Ext.getCmp("FileTypeId").getValue();
                    var Years = Ext.getCmp("Years").getValue();
                    var State = Ext.getCmp("state").getValue();
                    if (FileTypeId) {
                        store.getProxy().setExtraParam("FileTypeId", FileTypeId);
                        store.getProxy().setExtraParam("Years", Years);
                        store.getProxy().setExtraParam("State", State);
                        store.load(function (records, operation, success) {
                            var str = Ext.decode(operation.response.responseText).str[0].finished
                            var str1 = Ext.decode(operation.response.responseText).str[0].undone
                            if (str1) {
                                undone = str1;
                            } else {
                                undone = 0
                            }
                            if (str) {
                                finished = str;
                            } else {
                                finished = 0;
                            }
                            InitEcharts1();
                        });
                    } else {
                        InitEcharts2();
                    }
                }
                },
                { text: "发送提醒", handler: function () {

                }
                }
            ]
            })

            grid = Ext.create("Ext.grid.Panel", {
                title: "项目监控",
                store: store,
                region: "center",
                tbar: toolbar,
                selModel: { selType: "checkboxmodel" },
                columns: [
                            { xtype: "rownumberer", width: 35 },
                            { dataIndex: "ProjectName", header: "项目名称", width: 300 },
                            { dataIndex: "PManagerName", header: "项目总监", width: 200 },
                            { dataIndex: "Remark", header: "备注", flex: 1 }
                        ]
            });
            var formpanel = Ext.create("Ext.panel.Panel", {
                region: "south",
                height: 210,
                html: '<div id="divChart" style="height:210px;" ></div>'
            });

            var viewport = Ext.create("Ext.container.Viewport", {
                layout: "border",
                items: [grid, formpanel]
            });
            InitEcharts2();
        });
        function InitEcharts1() {

            var myChart = echarts.init(document.getElementById('divChart'));
            option = {
                title: {
                    text: '项目监控图展',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient: 'vertical',
                    x: 'left',
                    data: ['未上传', '已上传']
                },
                toolbox: {
                    show: true,
                    feature: {
                        mark: { show: true },
                        dataView: { show: true, readOnly: false },
                        restore: { show: true },
                        saveAsImage: { show: true }
                    }
                },
                calculable: true,
                series: [
                    {
                        name: '访问来源',
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', '55%'],
                        data: [
                            { value: finished, name: '已上传' },
                            { value: undone, name: '未上传' }
                        ]
                    }
                ]
            };
            myChart.setOption(option);
        }


        function InitEcharts2() {
            var data;
            var Years = Ext.getCmp("Years").getValue();
            Ext.Ajax.request({
                url: "ProjectMonitor.aspx",
                async: false,
                params: { action: "select", Years: Years },
                callback: function (option, success, response) {
                    var str = Ext.decode(response.responseText);
                    if (str) {
                        data = str;
                    }
                }
            });
            var years;
            var datetime;
            var days;
            if (Years) {
                datetime = new Date(Years);
                year = datetime.getFullYear();
                month = datetime.getMonth();
                month = month + 1;
                years = year + "-" + month;
                days = new Date(year, month, 0).getDate();
            } else {
                datetime = new Date();
                year = datetime.getFullYear();
                month = datetime.getMonth();
                month = month + 1;
                years = year + "-" + month;
                days = new Date(year, month, 0).getDate();
            }
            var myChart = echarts.init(document.getElementById('divChart'));
            option = {
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: [years + "文件上传统计"]
                },
                toolbox: {
                    show: true,
                    feature: {
                        mark: { show: true },
                        dataView: { show: true, readOnly: false },
                        magicType: { show: true, type: ['tiled', 'bar', 'stack', 'line'] },
                        restore: { show: true },
                        saveAsImage: { show: true }
                    }
                },
                calculable: true,
                xAxis: [
        {
            type: 'category',
            boundaryGap: false,
            data: function () {
                var list = [];
                for (var i = 1; i <= days; i++) {
                    list.push(i);
                }
                return list;
            } ()
        }
    ],
                yAxis: [
        {
            type: 'value'
        }
    ],
                series: [
                        {
                            name: years + "文件上传统计",
                            type: 'line',
                            stack: '总量',
                            itemStyle: {
                                normal: {
                                    color: '#8B008B'
                                }
                            },
                            data: [
                                                        data.count.day1, data.count.day2, data.count.day3, data.count.day4, data.count.day5, data.count.day6,
                                                        data.count.day7, data.count.day8, data.count.day9, data.count.day10, data.count.day11, data.count.day12,
                                                        data.count.day13, data.count.day14, data.count.day15, data.count.day16, data.count.day17, data.count.day18,
                                                        data.count.day19, data.count.day20, data.count.day21, data.count.day22, data.count.day23, data.count.day24,
                                                        data.count.day25, data.count.day26, data.count.day27, data.count.day28, data.count.day29, data.count.day30, data.count.day31
                                                        ]

                        }
    ]
            };
            myChart.setOption(option);

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
