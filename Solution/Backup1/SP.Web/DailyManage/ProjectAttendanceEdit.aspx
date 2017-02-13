<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProjectAttendanceEdit.aspx.cs"
    Inherits="SP.Web.DailyManage.ProjectAttendanceEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="../Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="../js/pan.js" type="text/javascript"></script>
    <script src="groupuser.js" type="text/javascript"></script>
    <style type="text/css">
        .x-grid-cell-inner
        {
            overflow: visible;
        }
    </style>
    <script type="text/javascript">
        var yearcombo, monthcombo,ProjectNameCombo;
        var Grid,store,formpanel;
        var Year, Month;
        var action="FormLoad";
        var PManagerName,CreateName;
        var SignType = "正常上班";
        var ProjectId ;
        var columns = [];
        var Id=getQueryString("Id");
        Ext.onReady(function(){
            SetGrid();
            init();
            if(Id){
                PageLoad();
            }
        });
        function PageLoad(){
              formpanel.getForm().load({
                    url: 'ProjectAttendanceEdit.aspx',
                    params: { Id: Id,action:action },
                    method: 'POST', //请求方式      
                    success: function (form, action) {
                    var str=action.result.data.Attachment;
                     ProjectId =action.result.data.ProjectId;
                     Ext.getCmp("Attachment").setRawValue(str);
                    Ext.getCmp("ProjectName").disable();
                    Ext.getCmp("PManagerName").disable();
                    Ext.getCmp("CreateName").disable();
                    Ext.getCmp("year").disable();
                    Ext.getCmp("month").disable();
                    }
                });
        }
        function SetGrid(){
             Ext.regModel("ProjectAttendance", { fields: ["Id", "RowNumber", "UserId","UserName","SumDay",
            "c1", "c2", "c3", "c4", "c5", "c6", "c7", "c8", "c9", "c10", "c11", "c12", "c13", "c14", "c15", "c16", "c17",
             "c18", "c19", "c20", "c21", "c22", "c23", "c24", "c25", "c26", "c27", "c28", "c29", "c30", "c31"]
            });

            store = new Ext.data.JsonStore({
                model: 'ProjectAttendance',
                proxy: {
                    type: 'ajax',
                    url: "ProjectAttendanceEdit.aspx",
                    extraParams: { action: "DoGrid", Id: Id,Year:"",Month:"" },
                    reader: {
                        reader: "json",
                        root: 'rows',
                        totalProperty: "pageCount"
                    }
                },
                PageSize: 15,
                autoLoad: true
            });
            columns.push({ header: "标示", dataIndex: "Id", hidden: true });
            columns.push({ header: "标示", dataIndex: "UserId", hidden: true });
            columns.push(new Ext.grid.RowNumberer());
            columns.push({ header: "姓名", dataIndex: "UserName", width: 80 });
            for (var a = 26; a <= 31; a++) {
                columns.push({ header: "" + a, dataIndex: "c" + a, width: 37, renderer: RowRender });
            }
            for (var i = 1; i < 26; i++) {
                columns.push({ header: "" + i, dataIndex: "c" + i, width: 37, renderer: RowRender });
            }
            //columns.push({ header: "汇总天", dataIndex: "SumDay", width: 120 });
             var deleteuser = {
                xtype: 'button',
                width: 80,
                text: '删除人员 ',
                handler: function () {
                    var recs = Grid.getSelectionModel().getSelection();
                    if (!recs) { return; }
                    var jarray = [];
                   Ext.each(recs, function (rec) {
                        if (Ext.getCmp("Id").getValue()) {
                            jarray.push(rec.get("UserId"));
                        } else {
                            store.remove(rec);
                        }
                    });
                    if (jarray.length > 0) {
                        Ext.MessageBox.confirm("提示", "确定删除吗?", callBack);
                        function callBack(str) {
                            if (str != "yes") { return; }

                            var Id = Ext.getCmp("Id").getValue();
                            var ProjectId= ProjectNameCombo.getValue();
                            var requestConfig = {
                                url: "ProjectAttendanceEdit.aspx",
                                params: { jarray: jarray, action: "delete", Id: Id,ProjectId:ProjectId },
                                callback: function (option, success, response) {
                                store.remove(recs)
                                }
                            }
                            Ext.Ajax.request(requestConfig);
                        }
                    }
                }

            }
            var adduser = {
                xtype: 'button',
                width: 80,
                text: '添加人员 ',
                handler: function () {
                    Year = yearcombo.getRawValue();
                    Month = monthcombo.getRawValue();
                    var name = ProjectNameCombo.getValue();
                    if(!name){
                    Ext.Msg.alert("提示","项目名称不能为空");
                    return;
                    }
                    if (Year && Month) {
                    var win = showGroupUserWin();
                    win.show();
                    } else {
                        Ext.Msg.alert("提示", "请选择年份或月份!");
                    }

                }
            }
            var shangban = {
                xtype: 'button',
                width: 80,
                icon: "../images/shared/flag_green.gif",
                text: '正常上班 ',
                handler: function () {
                    SignType = "正常上班";
                }
            }
//            var xiujia = {
//                xtype: 'button',
//                width: 80,
//                icon: "../images/shared/flag_red.gif",
//                text: '休假 ',
//                handler: function () {
//                    SignType = "休假";
//                }
//            }
            var qingjia = {
                xtype: 'button',
                width: 80,
                icon: "../images/shared/exclam1.gif",
                text: '请假 ',
                handler: function () {
                    SignType = "请假";
                }
            }
            var qita = {
                xtype: 'button',
                width: 80,
                icon: "../images/shared/cross.gif",
                text: '其他',
                handler: function () {
                    SignType = "其他";
                }
            }
            
            var toolbar = Ext.create("Ext.toolbar.Toolbar", {
                items: [deleteuser,adduser,shangban,qingjia,qita]
            });
            
            
            Grid = Ext.create("Ext.grid.Panel", {
                store: store,
                 tbar: toolbar,
                region: "center",
                selModel: { selType: "checkboxmodel" },
                columns: columns

            });


            function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
                if (value == "正常上班") {
                    return '<img src="../images/shared/flag_green.gif" check="false"  onclick="checkclick(' + columnIndex + ',\'' + rowIndex + '\')"/>'
                } else if (value == "休假") {
                    return '<img src="../images/shared/flag_red.gif" check="false" onclick="checkclick(' + columnIndex + ',\'' + rowIndex + '\')"/>'
                } else if (value == "请假") {
                    return '<img src="../images/shared/exclam1.gif" check="false" onclick="checkclick(' + columnIndex + ',\'' + rowIndex + '\')" />'
                } else if (value == "其他") {
                    return '<img src="../images/shared/cross.gif" check="false" onclick="checkclick(' + columnIndex + ',\'' + rowIndex + '\')"/>'
                } else {
                    return '<input type="checkbox" onclick="checkclick(' + columnIndex + ',\'' + rowIndex + '\')"/>'
                }
            }
        }

       function checkclick(columnIndex, i) {
            var day = columns[columnIndex+1].dataIndex.replace("c", "");
            var recs = Grid.getSelectionModel().getSelection();
            var UserId = recs[0].get("UserId");
            var Attachment=Ext.getCmp("Attachment").getValue();
            var Remark=Ext.getCmp("Remark").getValue();
            var UserName = recs[0].get("UserName");
            if(!ProjectId){
             ProjectId= ProjectNameCombo.getValue();
            }
            var BelongDeptId=Ext.getCmp("BelongDeptId").getValue();
            var Year = yearcombo.getRawValue();
            var Month = monthcombo.getRawValue();
            var Id=Ext.getCmp("Id").getValue();
             Ext.Ajax.request({
                    url: "ProjectAttendanceEdit.aspx?action=create",
                    async: false,
                    params: { "Id":Id,"Year": Year, "Month": Month, "day": day, "SignType": SignType,"ProjectId":ProjectId,"UserId":UserId,"UserName":UserName,"Remark":Remark,"Attachment":Attachment },
                    callback: function (option, success, response) {
                    var json = Ext.decode(response.responseText);
                    if(json.id=="false"){
                        Ext.Msg.alert("提示","该人员该阶段的考勤已存在！");
                        return;
                    }
                    Ext.getCmp("Id").setValue(json.id);
                    day = "c" + day;
                    if (recs[0].get(day) == SignType) {
                        store.getAt(i).set(day, "");
                    }
                    else {
                        store.getAt(i).set(day, SignType);
                    }
                    Ext.getCmp("ProjectName").disable();
                    Ext.getCmp("PManagerName").disable();
                    Ext.getCmp("CreateName").disable();
                    Ext.getCmp("year").disable();
                    Ext.getCmp("Attachment").disable();
                    Ext.getCmp("Remark").disable();
                    Ext.getCmp("month").disable();
                    }
                });



        }


        function init() {
              var ProjectNameStore = Ext.create("Ext.data.JsonStore", {
                fields: ['ProjectName', 'ProjectId',"PManagerId","PManagerName","BelongDeptId","BelongDeptName","LogName"], 
                proxy: {
                    url: "ProjectAttendanceEdit.aspx?action=PNameCombo",
                    type: "ajax",
                    reader: {
                        type: "json",
                        root: "rows"
                    }
                }
            });

             ProjectNameCombo = Ext.create("Ext.form.ComboBox", {
                name: "ProjectName",
                id:"ProjectName",
                labelAlign: "right",
                store: ProjectNameStore,
                labelWidth: 100,
                queryParam: 'name',
                minChars: 1,
                emptyText: "请输入项目名称或编号...",
                fieldLabel: "项目名称",
                displayField: 'ProjectName',
                margin:"10 10 10 10",
                columnWidth: .5,
                hideTrigger: true,
               // pageSize: 8,
                valueField: "ProjectId",
                listeners:{
                 select:function(rec){
                 Ext.getCmp("PManagerId").setValue(rec.displayTplData[0].PManagerId);
                 Ext.getCmp("PManagerName").setValue(rec.displayTplData[0].PManagerName);
                 Ext.getCmp("CreateName").setValue(rec.displayTplData[0].LogName);
                 Ext.getCmp("BelongDeptId").setValue(rec.displayTplData[0].BelongDeptId);
                 Ext.getCmp("BelongDeptName").setValue(rec.displayTplData[0].BelongDeptName);
                Year = yearcombo.getRawValue();
                Month = monthcombo.getRawValue();
                var name = ProjectNameCombo.getValue();
                if (Year && Month && name) {
                    SelectData();
                }
                }
                }

        });

         PManagerName = Ext.create('Ext.form.field.Text', {
                fieldLabel: '项目总监',
                labelAlign: 'right',
                name: 'PManagerName',
                id:"PManagerName",
                columnWidth: .5,
                margin: '10',
                readOnly: true
            })
              CreateName = Ext.create('Ext.form.field.Text', {
                fieldLabel: '填报人',
                labelAlign: 'right',
                name: 'CreateName',
                id:"CreateName",
                columnWidth: .5,
                margin: '10',
                readOnly: true
            })
            var Remark= Ext.create('Ext.form.field.TextArea', {
               fieldLabel: '备注',
                labelAlign: 'right',
                name: 'Remark',
                id:"Remark",
                columnWidth: 1,
                margin: '10',
            })
        var yearstore = Ext.create("Ext.data.Store", {
            fields: ['Year'],
            data: [
                    { "Year": "2014" }, { "Year": "2015" }, { "Year": "2016" }, { "Year": "2017" }
                ]
        });
        yearcombo = Ext.create("Ext.form.ComboBox", {
            fieldLabel: '所属年份',
            labelAlign: 'right',
            store: yearstore,
            columnWidth: .5,
            margin:"10 10 10 10",
            name: 'Year',
            id: 'year',
            queryMode: 'local',
            displayField: 'Year',
            valueField: 'Year',
            listeners: { select: function () {
                Year = yearcombo.getRawValue();
                Month = monthcombo.getRawValue();
                var name = ProjectNameCombo.getRawValue();
                if (Year && Month && name) {
                    SelectData();
                }
            }
            }
        });
         var Attachment = Ext.create('Ext.form.field.File', {
            name: 'Attachment',
            id:"Attachment",
            fieldLabel: '上传文件',
            margin: '10 10 10 10',
            labelAlign: 'right',
            emptyText: '请选择文件',
            buttonText: '浏览...',
            columnWidth: .5
        });
      
        var monthstore = Ext.create("Ext.data.Store", {
            fields: ['Month'],
            data: [
                    { "Month": "1" }, { "Month": "2" }, { "Month": "3" }, { "Month": "4" },
                    { "Month": "5" }, { "Month": "6" }, { "Month": "7" }, { "Month": "8" },
                    { "Month": "9" }, { "Month": "10" }, { "Month": "11" }, { "Month": "12" }
                ]
        });
        monthcombo = Ext.create("Ext.form.ComboBox", {
            fieldLabel: '所属月份',
            labelAlign: 'right',
            store: monthstore,
            columnWidth: .5,
            margin:"10 10 10 10",
            name: 'Month',
            id: 'month',
            queryMode: 'local',
            displayField: 'Month',
            valueField: 'Month',
            listeners: { select: function () {
                Year = yearcombo.getRawValue();
                Month = monthcombo.getRawValue();
                var name = ProjectNameCombo.getRawValue();
                if (Year && Month && name) {
                    SelectData();
                }
            }
            }
        });
             formpanel = Ext.create('Ext.form.Panel', {
                title: '项目监理部考勤',
                region: 'north',
                items: [
                {xtype:"textfield",id:"PManagerId",name:"PManagerId",hidden:true},
                {xtype:"textfield",id:"Id",name:"Id",hidden:true},
                {xtype:"textfield",id:"BelongDeptId",name:"BelongDeptId",hidden:true},
                {xtype:"textfield",id:"BelongDeptName",name:"BelongDeptName",hidden:true},
                {layout: 'column', border: 0, items: [ProjectNameCombo,Attachment] },
                {layout: 'column', border: 0, items: [yearcombo, monthcombo] },
                {layout: 'column', border: 0, items: [PManagerName, CreateName] },
                {layout: 'column', border: 0, items: [Remark] }
            ]
            });
        var viewport = Ext.create('Ext.container.Viewport', {
                layout: 'border',
                items: [formpanel,Grid]
            })
    }
    function SelectData() {
     var ProjectId= ProjectNameCombo.getValue();
                Ext.Ajax.request({
                    url: "ProjectAttendanceEdit.aspx?action=CheckUser",
                    async: false,
                    params: { "ProjectId":ProjectId,"Year": Year, "Month": Month },
                    callback: function (option, success, response) {
                         var json = Ext.decode(response.responseText);
                         if(json.msg!="false"){
                         store.getProxy().setExtraParam("action", "SelectData");
                         store.getProxy().setExtraParam("ProjectId", ProjectId);
                         store.getProxy().setExtraParam("Year", Year);
                         store.getProxy().setExtraParam("Month", Month);
                         store.load();
                         }else{

                            Ext.Msg.alert("提示","已存在该阶段的考勤");
                             var recs = Grid.getSelectionModel().getSelection();
                             store.removeAll(recs);
                         }
                    }
                });


    }
    function GetUsers(recs) {
          Ext.each(recs, function (rec) {
          if (store.find("UserName", rec.get("Name")) == -1) {
             var row = store.data.length;
             store.insert(row, { UserId: rec.get("UserId"), UserName: rec.get("Name") });
          }
            });
          var ProjectUsers = Ext.encode(Ext.pluck(store.data.items, 'data'));
                    var ProjectId= ProjectNameCombo.getValue();
                    var requestConfig = {
                    url: "ProjectAttendanceEdit.aspx?action=ProjectUser",
                    params: {ProjectId:ProjectId, ProjectUsers: ProjectUsers },
                    callback: function (option, success, response) {
                    }
                }
                Ext.Ajax.request(requestConfig);

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
