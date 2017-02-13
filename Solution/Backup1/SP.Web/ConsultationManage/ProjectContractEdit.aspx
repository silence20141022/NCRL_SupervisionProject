<%@ Page Title="酬金分配" Language="C#" MasterPageFile="~/Masters/Ext/formpage.master" AutoEventWireup="true"
    CodeBehind="ProjectContractEdit.aspx.cs" Inherits="SP.Web.ConsultationManage.ProjectContractEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">
    <script src="../js/DatePicker/WdatePicker.js" type="text/javascript"></script>
    <title >酬金分配</title>
    <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0"
        height="0">
    </object>
    <style type="text/css">
        .aim-ui-td-caption1
        {
            width: 14%;
            border: 1px dotted #000000;  
        }
        .aim-ui-button-panel
        {
            border: 0px;
            background-color: rgb(223, 234, 242);
        }
        
        
        .lengenClass
        {
           
            font-size: 12;
            font-weight: bold;
        }
        
        td
        {
            height: 20px;
        }
     
    </style>
    <style type="text/css">
        body
        {
            padding: 0px;
            margin: 0px;
            background-color: #fff !important;
            border-bottom: 4px solid #157fcc;
            border-left: 4px solid #157fcc;
            border-right: 4px solid #157fcc;
            overflow: scroll;
        }
        #header
        {
            background-color: #157fcc;
            background-image: none;
            height: 36px;
        }
        #header h1
        {
            font-family: arial, helvetica, verdana, sans-serif;
            font-size: 15px;
            line-height: 36px;
            font-weight: bold;
            padding-left: 10px;
            padding-top: 0px;
            padding-bottom: 0px;
        }
        .aim-ui-button
        {
            height: 24px;
            line-height: 24px;
            background-image: url(../images/form/btn-default-small-bg.gif);
            background-position-x: 0;
            background-position-y: top;
            border-style: none;
            font-weight: bold;
        }
        
        .aim-ui-button1
        {
            height: 24px;
            line-height: 24px;
            background-image: url(../images/form/btn-default-small-bg.gif);
            background-position-x: 0;
            background-position-y: top;
            border-style: none;
            font-weight: bold;
        }
        .aim-ui-td-data
        {
             border: 1px dotted #000000;
            }
        
        .submit, .cancel
        {
            padding-left: 20px;
            padding-right: 20px;
             margin-bottom :10px;
          
        }
        .aim-ui-table-edit
        {
             margin: 10px;
            border-width: 0px;
        }
        .aim-ui-button-panel
        {
            border: 0px;
            background-color: rgb(223, 234, 242);
        }
        #man, #woman
        {
            border: none;
        }
        input
        {
            width: 100%;
        }
    </style>
    <script type="text/javascript">

      
        var ContractAmount; //合同金额
        var store, myData, grid2, store2;
        var id = $.getQueryString({ "ID": "id" });
        function onPgLoad() {
            setPgUI();
            bindpro();
            InitEditTableMajor();
        }

        function doprint(id, url) {
            try {
                // $("#btnSubmit").click();
                var LODOP = document.getElementById("LODOP"); //这行语句是为了符合DTD规范

                LODOP.PRINT_INIT("");

                LODOP.NewPage();

                LODOP.ADD_PRINT_URL(20, 18, 750, 1050, url + '?id=' + id);
                //  LODOP.ADD_PRINT_URL(20, 18, 750, 1050, 'CommissionHanDY.aspx?id=' + id);

                LODOP.PREVIEW();
            }
            catch (ex) {
                alert("未安装打印控件，请安装打印控件");
                window.open("/install_lodop.rar", "print", "");
            }
        }

        function FloatAdd(arg1, arg2) {
            var r1, r2, m;
            try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
            try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
            m = Math.pow(10, Math.max(r1, r2))
            return (arg1 * m + arg2 * m) / m
        }

        function print() {
            doprint(id, "ProjectConvertPrint.aspx");
        }

        function setPgUI() {
            $("#btncancel").click(function () {
                window.close();
            });
            //绑定按钮验证
           FormValidationBind('btnSubmit', SuccessSubmit);

            $("#btnPrint").click(function () {
                var recs = store.getRange();
                var dt = store.getModifiedDataStringArr(recs) || [];
                if (checkData()) {
                    AimFrm.submit(pgAction, { "projectUser": dt }, null, null);
                    if ($("#DistributeAmount").val() == "" || $("#DistributeAmount").val() == null) {
                        AimDlg.show("请输入合同金额分配金额");
                        return;
                    } else {
                        //print();
                        setTimeout("print()", 500);
                    }
                }
            });


            $("#DistributeAmount").keyup(function () {
                var totalAmout = $(this).val();
                if (parseFloat(ContractAmount) <= 0) {
                    $("#DistributePercent").val("0");
                } else {
                    if (totalAmout <= ContractAmount) {
                        $("#DistributePercent").val((parseFloat((totalAmout / ContractAmount)) * 100).toPrecision(3));
                       // $("#DistributePercent").val(parseFloat((totalAmout / ContractAmount)).toPrecision(2) * 100);
                    }
                    else {
                        AimDlg.show("请输入数字或者分配金额不能大于合同金额");
                        $(this).val("0");
                        $("#DistributePercent").val("0");
                    }
                }
            });

            $("#DistributePercent").keyup(function () {
                var totalPers = $(this).val();
                if (parseFloat(ContractAmount) <= 0) {
                    $("#DistributeAmount").val("0");
                } else {
                    if (totalPers < 101) {
                        $("#DistributeAmount").val(parseFloat(totalPers * ContractAmount * 0.01).toPrecision(2));
                    } else {
                        AimDlg.show("请输入数字或者输入比例不能超出100%");
                        $(this).val("0");
                        $("#DistributeAmount").val("0");
                    }
                }

            });
        }

        function checkData() {
            var recs = store.getRange();
            //如果存在明细的情形下  如果明细的金额和大于的金额。不允许提交
            var total = 0.00;
            var Amount = 0.00;
            if (store.getCount() > 0) {
                for (var i = 0; i < store.getCount(); i++) {
                    total = FloatAdd(total, recs[i].get("DistributeAmount"));
                    Amount = FloatAdd(Amount, recs[i].get("AcctualAmount"));
                }
                
                if (total > parseFloat($("#DistributeAmount").val()) * 10000) {
                    AimDlg.show("专家分配明细的总金额大于项目分配金额，请重新调整明细！");
                    return false;
                }
                if (total < parseFloat($("#DistributeAmount").val()) * 10000) {
                    AimDlg.show("专家分配明细的总金额小于项目分配金额，请重新调整明细！");
                    return false;
                }
                if (Amount > total) {
                    AimDlg.show("实际专家分配总金额不能大于分配金额，请重新调整实际分配金额明细！");
                    return false;
                }
                return true;

            }
            return true;
        }

        //验证成功执行保存方法
        function SuccessSubmit() {
            var recs = store.getRange();
            var dt = store.getModifiedDataStringArr(recs) || [];
            if (checkData()) {
                AimFrm.submit(pgAction, { "projectUser": dt }, null, SubFinish);
            }
            }

        function bindpro() {
            var dat = AimState["pro"][0];
            $("#ProjectCode").html("&nbsp;" + dat.ProjectCode);
            $("#ProjectName").html("&nbsp;" + dat.ProjectName);     //项目名称
            $("#Investment").html("&nbsp;" + isNull(dat.Investment));   //投资额
            $("#BelongDeptName").html("&nbsp;" + isNull(dat.BelongDeptName));     //建设地点
            $("#EngineeringLevel").html("&nbsp;" + isNull(dat.EngineeringLevel));   //工程等级
            $("#Height").html("&nbsp;" + isNullNumber(dat.Height));    //建筑高度 
            $("#UpperLayers").html("&nbsp;" + isNullNumber(dat.UpperLayers));     //楼层上层层数(㎡)
           
            $("#DownLayers").html("&nbsp;" + isNullNumber(dat.DownLayers));     //楼层下层层数(㎡)
            $("#Property").html("&nbsp;" + isNull(dat.Property));  ///工程性质
            $("#DetailLocation").html("&nbsp;" + isNull(dat.DetailLocation));
            $("#KanChaType").html("&nbsp;" + isNull(dat.KanChaType));
            $("#GongChenLiang").html("&nbsp;" + isNull(dat.GongChenLiang));
            $("#SheJiUnitBeiAnNo").html("&nbsp;" + isNull(dat.SheJiUnitBeiAnNo));
            $("#KanChaUnitBeiAnNo").html("&nbsp;" + isNull(dat.KanChaUnitBeiAnNo));
            $("#KanChaGCLevel").html("&nbsp;" + isNull(dat.KanChaGCLevel));
            $("#FoundationType").html("&nbsp;" + isNull(dat.FoundationType));
            $("#StructureType").html("&nbsp;" + isNull(dat.StructureType));
            $("#IfChaoBiao").html("&nbsp;" + dat.IfChaoBiao == "1" ? "是" : "否");
            $("#IfJieNeng").html("&nbsp;" + dat.IfJieNeng == "1" ? "是" : "否");
            $("#IfLvSe").html("&nbsp;" + dat.IfLvSe == "1" ? "是" : "否");
            $("#SubmitReportTime").html("&nbsp;" + isNull(dat.SubmitReportTime));
            $("#BuildingArea").html("&nbsp;" + isNull(dat.BuildingArea));     //建筑面积(㎡)
            $("#JianSheUnit").html("&nbsp;" + isNull(dat.JianSheUnit));     //建设单位
            $("#JianSheUnitHead").html("&nbsp;" + isNull(dat.JianSheUnitHead));     //建设单位负责人
            $("#KanChaUnit").html("&nbsp;" + isNull(dat.KanChaUnit));     //勘察单位
            $("#KanChaUnitHead").html("&nbsp;" + isNull(dat.KanChaUnitHead));     //勘察单位负责人
            $("#ZiXunCode").html("&nbsp;" + isNull(dat.ZiXunCode));     //咨询公司编号
            $("#SheJiUnit").html("&nbsp;" + isNull(dat.SheJiUnit));     //设计单位
            $("#SheJiUnitHead").html("&nbsp;" + isNull(dat.SheJiUnitHead));     //设计单位负责人
            $("#JianSheTingNo").html("&nbsp;" + isNull(dat.JianSheTingNo));     //建设厅编号
            $("#SongShenTime").html("&nbsp;" + isNull(dat.SongShenTime));     //送审日期
            $("#IfChaoGao").html("&nbsp;" + (dat.IfChaoGao == "1" ? "是" : "否"));     //超高建筑
            $("#ContractAmount").html("&nbsp;" + isNullNumber(dat.ContractAmount) + "");
            $("#SheJiUnitZSNo").html("&nbsp;" + isNull(dat.SheJiUnitZSNo));     //咨询公司编号
            $("#SheJiUnitGrade").html("&nbsp;" + isNull(dat.SheJiUnitGrade));     //设计单位
            $("#JianSheUnitHeadTel").html("&nbsp;" + isNull(dat.JianSheUnitHeadTel));     //设计单位负责人
            $("#KanChaUnitZSNo").html("&nbsp;" + isNull(dat.KanChaUnitZSNo));     //设计单位负责人
            $("#ProjectType").html("&nbsp;" + isNull(dat.name));
            
           // $("#KanChaZZLevel2").html(isNull(dat.KanChaZZLevel));     //勘察单位资质等级
            document.getElementById("KanChaZZLevel").innerHTML = dat.KanChaZZLevel;
            ContractAmount = isNullNumber(dat.ContractAmount);
        }

        function SubFinish(args) {
            RefreshClose();
        }

        ///责任人
        function InitEditTableMajor() {
            // 表格数据
            myDatasub = {
                records: AimState["DetailChildList"] || []
            };
            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'DetailChildList',
                data: myDatasub,
                idProperty: 'Id',
                fields: [{ name: 'Id' },
			    { name: 'UserId' },
                { name: 'UserName' },
                { name: 'State' },
                { name: 'MajorName' },
                { name: 'ShenHeUserId' },
                { name: 'ShenHeUserName' },
			    { name: 'MajorCode' },
                { name: 'DistributeAmount' },
                { name: 'DistributePercent' },
			    { name: 'AcctualAmount' }
                ]
            });




            grid2 = new Ext.ux.grid.AimEditorGridPanel({
                store: store,
                // cm: cmsub,
                height: 180,
                width: Ext.get("ChildrenSub").getWidth(),
                forceLayout: true,
                cm: new Ext.grid.ColumnModel({ columns: [
                  { id: 'Id', dataIndex: 'Id', header: '编号', hidden: true },
                  { id: 'MajorName', dataIndex: 'MajorName', header: '专业名称', sortable: true, width: 100 },
                  { id: 'UserName', dataIndex: 'UserName', header: '审查人', sortable: true, width: 100 },
                    { id: 'DistributeAmount', dataIndex: 'DistributeAmount', header: '酬金金额(元)', renderer: RowRender, width: 100, resizable: true, editor: { xtype: 'textfield'} },
                    { id: 'DistributePercent', dataIndex: 'DistributePercent', header: '酬金所占百分比%', renderer: RowRender, width: 100, resizable: true, editor: { xtype: 'textfield'} },
                    { id: 'AcctualAmount', dataIndex: 'AcctualAmount', header: '实际分配金额(元)', renderer: RowRender, editor: { xtype: 'textfield'} }
                ]
                }),
                columnLines: true,
                width: Ext.get("ChildrenSub").getWidth(),
                autoExpandColumn: 'Id',
                renderTo: "ChildrenSub",
                listeners: {//beforeedit
                    afteredit: function (val) {
                        if (val.field == "DistributeAmount") {
                            var result = val.record.get("DistributeAmount");
                            var amount = $("#DistributeAmount").val();
                            if (amount != "" && amount > 0) {

                                if (parseFloat(amount) >= 0 && (parseFloat(amount) * 10000) >= result) {

                                    val.record.set("DistributePercent", parseFloat((result / (amount * 100))));
                                    val.record.set("AcctualAmount", result);
                                } else {
                                    alert("【" + val.record.get('UserName') + "】审查人请输入金额超过限额");
                                    val.record.set("DistributeAmount", "0");
                                    val.record.set("DistributePercent", "0");
                                }
                            } else {

                                alert("【" + val.record.get('UserName') + "】审查人请输入酬金金额");
                                val.record.set("DistributeAmount", "0");
                                val.record.set("DistributePercent", "0");
                            }

                        }

                        if (val.field == "AcctualAmount") {
                            var AcctualAmount = val.record.get("AcctualAmount");
                            var DistributeAmount = val.record.get("DistributeAmount");
                            if (parseFloat(AcctualAmount) > parseFloat(DistributeAmount)) {
                                alert("【" + val.record.get('UserName') + "】审查人请输入实际金额不能大于评审金额");
                                val.record.set("AcctualAmount", "0");
                            }

                        }


                        if (val.field == "DistributePercent") {
                            var amount = $("#DistributeAmount").val();
                            var percent = val.record.get("DistributePercent");

                            if (parseFloat(percent) > 0 && parseFloat(percent) <= 100) {
                                val.record.set("DistributeAmount", parseFloat((percent * (amount * 10000)) * 0.01));
                                val.record.set("AcctualAmount", parseFloat((percent * (amount * 10000)) * 0.01));
                            } else {
                                alert("【" + val.record.get('UserName') + "】审查人请输入金额分配百分比100%");
                                val.record.set("DistributePercent", "0");
                            }
                        }
                    }
                }
            });
            window.onresize = function () {
                grid2.setWidth(0);
                grid2.setWidth(Ext.get("ChildrenSub").getWidth());
            };
        }

        function RowRender(value, cellmeta, record, rowIndex, columnIndex, store) {
            var rtn = "";
            switch (this.id) {
                case "AcctualAmount":
                    if (value) {
                        val = String(value);
                        var whole = val;
                        var r = /(\d+)(\d{3})/;
                        while (r.test(whole)) {
                            whole = whole.replace(r, '$1' + ',' + '$2');
                        }
                        rtn = "￥" + whole;
                    } else {
                        rtn = "￥" + "0";
                    }
                    break;
                case "DistributePercent":
                    if (value) {
                        val = String(value);
                        rtn = val + "%";
                    } else {
                        rtn = "0%";
                    }
                    break;
                case "DistributeAmount":
                    if (value) {
                        val = String(value);
                        var whole = val;
                        var r = /(\d+)(\d{3})/;
                        while (r.test(whole)) {
                            whole = whole.replace(r, '$1' + ',' + '$2');
                        }
                        rtn = "￥" + whole;
                    } else {
                        rtn = "￥" + "0";
                    }
                    break;
            }
            return rtn;
        }

        function AmountFormat(value) {
            val = String(value);
            var whole = val;
            var r = /(\d+)(\d{3})/;
            while (r.test(whole)) {
                whole = whole.replace(r, '$1' + ',' + '$2');
            }
            return "￥" + whole;
        }
        function onExecuted() {
            store.reload();

        };
        function isNull(values) {
            return values = values == null ? "" : values;
        }

        function isNullNumber(values) {
            return values = values == null ? "0" : values;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            酬金分配</h1>
    </div>
    <div id="editDiv">
        <fieldset style="margin: 5px">
            <legend class="lengenClass" >项目基本信息</legend>
            <table class="aim-ui-table-edit" style="margin:1px">
                <tbody>
                    <tr style="display: none">
                        <td>
                            <input id="Id" name="Id" />
                            <input id="UserId" name="UserId" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption1">
                            瑞林项目编号
                        </td>
                        <td class="aim-ui-td-data" style="width: 20%">
                            <label id="ProjectCode" name="ProjectCode" style="width: 80%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            咨询公司编号
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="ZiXunCode" name="ZiXunCode" style="width: 100%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            建设厅编号
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="JianSheTingNo" name="JianSheTingNo" style="width: 100%" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption1">
                            项目名称
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="ProjectName" name="ProjectName" style="width: 80%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            项目类别
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="ProjectType" name="ProjectType" style="width: 100%;" />
                        </td>
                         <td class="aim-ui-td-caption1">
                            送审时间
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="SongShenTime" name="SongShenTime" style="width: 100%" />
                        </td>
                       
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption1">
                            项目所在地区
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="BelongDeptName" name="BelongDeptName" style="width: 80%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            项目详细地址
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="DetailLocation" name="DetailLocation" style="width: 100%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            勘察类型
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="KanChaType" name="KanChaType" style="width: 100%" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption1">
                            投资金额(万元）
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="Investment" name="Investment" style="width: 80%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            工程性质
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="Property" name="Property" style="width: 100%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            工程量
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="GongChenLiang" name="GongChenLiang" style="width: 100%" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption1">
                            建设单位
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="JianSheUnit" name="JianSheUnit" style="width: 80%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            建设单位项目负责人
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="JianSheUnitHead" name="JianSheUnitHead" style="width: 100%" />
                        </td>
                         <td class="aim-ui-td-caption1">
                            建设项目负责人电话
                        </td>
                        <td class="aim-ui-td-data">
                           <label id="JianSheUnitHeadTel" name="JianSheUnitHeadTel" style="width: 100%;" />
                          
                        </td>
                       
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption1">
                            设计单位
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="SheJiUnit" name="SheJiUnit" style="width: 80%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            设计单位项目负责人
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="SheJiUnitHead" name="SheJiUnitHead" style="width: 100%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            设计单位进赣备案号
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="SheJiUnitBeiAnNo" name="SheJiUnitBeiAnNo" style="width: 100%" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption1">
                            设计单位证书编号
                        </td>
                         <td class="aim-ui-td-data">
                           <label id="SheJiUnitZSNo" name="SheJiUnitZSNo" style="width: 100%"   />
                       
                        </td>
                          <td class="aim-ui-td-caption1">
                            设计资质等级
                        </td>
                        <td class="aim-ui-td-data"> 
                            <label id="SheJiUnitGrade" name="SheJiUnitGrade" style="width:100%;"  />
                        </td>
                        <td class="aim-ui-td-caption1">
                            勘察单位证书编号
                        </td>
                         <td class="aim-ui-td-data">
                           <label id="KanChaUnitZSNo" name="KanChaUnitZSNo" style="width: 100%"   />
                       
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption1">
                            勘察单位
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="KanChaUnit" name="KanChaUnit" style="width: 80%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            勘察单位项目负责人
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="KanChaUnitHead" name="KanChaUnitHead" style="width: 100%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            勘察单位进赣备案号
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="KanChaUnitBeiAnNo" name="KanChaUnitBeiAnNo" style="width: 100%" />
                        </td>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption1">
                            工程勘察等级
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="KanChaGCLevel" name="KanChaGCLevel" style="width: 50%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            勘察资质等级
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="KanChaZZLevel" name="KanChaZZLevel" style="width: 100%" />
                        </td>
                           <td class="aim-ui-td-caption1">
                       提交审查报告时间
                    </td>
                     <td class="aim-ui-td-data">
                        <label id="SubmitReportTime" name="SubmitReportTime" style="width: 100%"   />
                    </td>
                        <%--<td class="aim-ui-td-caption1">
                            高度
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="Height" name="Height" style="width: 100%" />
                        </td>--%>
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption1">
                            基础形式
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="FoundationType" name="FoundationType " style="width: 50%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            结构类型
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="StructureType" name="StructureType" style="width: 100%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            工程等级
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="EngineeringLevel" name="EngineeringLevel" style="width: 100%" />
                        </td>
                    </tr>
                    <tr>
                      <td class="aim-ui-td-caption1">
                            楼层上层层数
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="UpperLayers" name="UpperLayers" style="width: 100%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            楼层下层层数
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="DownLayers" name="DownLayers " style="width: 50%" />
                        </td>
                        <td class="aim-ui-td-caption1">
                            建筑面积(㎡)
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="BuildingArea" name="BuildingArea" style="width: 100%" />
                        </td>
                       
                    </tr>
                    <tr>
                        <td class="aim-ui-td-caption1" style="color: red">
                            合同金额(万元)
                        </td>
                        <td class="aim-ui-td-data">
                            <label id="ContractAmount" name="ContractAmount " style="width: 50%" />
                        </td>
                        <td class="aim-ui-td-caption1" style="color: Red">
                            项目分配金额(万元)
                        </td>
                        <td class="aim-ui-td-data">
                            <input id="DistributeAmount" maxlength="6" name="DistributeAmount" style="width: 100" />
                        </td>
                        <td class="aim-ui-td-caption1" style="color: Red">
                            分配金额占合同(%)
                        </td>
                        <td class="aim-ui-td-data">
                            <input id="DistributePercent" maxlength="3" name="DistributePercent" style="width: 100" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </fieldset>
        <fieldset style="margin:2px" >
            <legend class="lengenClass" >专家分配情况 </legend>
            <div id="ChildrenSub" name="ChildrenSub" align="left" style="width: 100%;">
            </div>
        </fieldset>
        <table class="aim-ui-table-edit" id="btnSubmits">
            <tr>
                <td class="aim-ui-button-panel" colspan="4">
                    <a id="btnSubmit" class="aim-ui-button submit">提交</a>&nbsp; <a id="btnPrint" class="aim-ui-button cancel">
                        打印</a> &nbsp;<a id="btncancel" class="aim-ui-button cancel"> 取消</a>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
