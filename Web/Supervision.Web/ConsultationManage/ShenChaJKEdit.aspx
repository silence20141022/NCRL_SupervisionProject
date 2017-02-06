
<%@ Page Title="基坑支护" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master" AutoEventWireup="true" CodeBehind="ShenChaJKEdit.aspx.cs" Inherits="SP.Web.ShenChaJKEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width="0"
        height="0">
    </object>
    <style type="text/css">
        *
        {
        	    font-family: "宋体";
	/* font-size: 14px; */
	color: #000000;
        	}

         body
        {
            padding: 0px;
            margin: 0px;
            background-color: #fff !important;
            border-bottom: 4px solid #157fcc;
            border-left: 4px solid #157fcc;
            border-right: 4px solid #157fcc;
          
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
            background-image: url(/images/btn-default-small-bg.gif);
            background-position-x: 0;
            background-position-y: top;
            border-style: none;
            font-weight: bold;
        }

        .submit, .cancel
        {
            padding-left: 20px;
            padding-right: 20px;
        }

        .aim-ui-table-edit
        {
            border-width: 0px;            
        }

        .aim-ui-button-panel
        {
            border:0px;
            background-color: rgb(223, 234, 242);
            height: 36px;
        }

   /*     .div1 {
	border: 1px solid #000000;
	padding-bottom:10px;
}
.span{
	text-decoration: underline;
}
*/
.title {
	letter-spacing: 0.2em;
}
.liftname {
	letter-spacing: 0.4em;
}
.sm {
letter-spacing: 0.1em;
	line-height: 1.5em;
	font-size: 18px;
	text-indent: 2pc;
}
.xh {
	text-decoration: underline;
}
.z {
	line-height: 1.2em;
}
.bg {
	font-size: 18px;
	line-height: 2em;
	border-right-width: 1px;
	border-right-style: solid;
	border-right-color: #000000;
}
 .span{
	        margin-bottom:5px;
	        border-bottom:1px solid #000;
	        font-size:18px;
        /*	text-decoration: underline;*/
        }
    </style>
    <script type="text/javascript">
           var id = $.getQueryString({ ID: 'id' });
           function onPgLoad() {
               $("#dy").hide();
            setPgUI();
        }

        function setPgUI() {
            if (pgOperation == "c" || pgOperation == "cs") {                
                $("#CreateName").val(AimState.UserInfo.Name);
                $("#CreateTime").val(jQuery.dateOnly(AimState.SystemInfo.Date));
            } else {
                $("#dy").show();
            }



            $("#ProjectId").val(id);
            
            //绑定按钮验证
            FormValidationBind('btnSubmit', SuccessSubmit);

            $("#btnCancel").click(function() {
                window.close();
            });

            $("#dy").click(function() {
                doprint(id, "ShenChaJKdy.aspx");
            });

            bindpro();
        }


        function doprint(id, url) {

            try {
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


        function bindpro() {
          var dat = AimState["pro"][0];
          $("#ProjectName").html("&nbsp;" + dat.ProjectName);     //项目名称
          $("#Investment").html("&nbsp;" + dat.Investment);   //投资额
          $("#BelongDeptName").html("&nbsp;" + dat.BelongDeptName);     //建设地点
          //$("#").html("&nbsp;" + dat.);   //设计等级
          $("#JianSheUnit").html("&nbsp;" + dat.JianSheUnit);     //建设单位
          $("#JianSheUnitHead").html("&nbsp;" + dat.JianSheUnitHead);     //建设单位负责人
          $("#KanChaUnit").html("&nbsp;" + dat.KanChaUnit);     //勘察单位
          $("#KanChaUnitHead").html("&nbsp;" + dat.KanChaUnitHead);     //勘察单位负责人
          $("#KanChaZZLevel").html("&nbsp;" + dat.KanChaZZLevel);     //勘察单位资质等级
          $("#EngineeringLevel").html(dat.EngineeringLevel);     //工程等级
          $("#SheJiUnit").html("&nbsp;" + dat.SheJiUnit);     //设计单位
          $("#SheJiUnitHead").html("&nbsp;" + dat.SheJiUnitHead);     //设计单位负责人
          $("#KanChaZZLevel").html("&nbsp;" + dat.KanChaZZLevel);     //设计单位资质等级
          $("#SheJiUnitZSNo").html("&nbsp;" + dat.SheJiUnitZSNo);  ///设计编号
          $("#SheJiUnitGrade").html("&nbsp;" + dat.SheJiUnitGrade);   //设计等级
          $("#KanChaUnitZSNo").html("&nbsp;" + dat.KanChaUnitZSNo);   //勘察编号

          
          // alert(dat.Id)
        }
        
        
        

        //验证成功执行保存方法
        function SuccessSubmit() {
            AimFrm.submit(pgAction, {}, null, SubFinish);
        }

        function SubFinish(args) {
            RefreshClose();
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header">
        <h1>
            审查报告</h1>
    </div>

    <div id="editDiv" align="center">
        <table class="aim-ui-table-edit">
           
                   <table width="770" border="0" height="1050" cellspacing="0" cellpadding="0"  style=" display:none">
  <tr>
    <td height="55" style=" padding-top:190px; font-size:28px;" colspan="2" align="center" valign="middle" class="title" ><h1>江西省深基坑支护工程施工图设计文件</h1></td>
  </tr>
  <tr>
    <td height="280" colspan="2" align="center" valign="top" style=" padding-top:50px; font-size:22px;"><h2>审 查 报 告</h2></td>
  </tr>
  <tr>
    <td  height="47" width="270" align="right" class="liftname"><h3>建筑工程名称:</h3></td>
    <td class="xh"  align="left">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp</td>
  </tr>
  <tr >
    <td  width="270"  height="47"  class="liftname"  align="right"><h3>建设单位名称:</h3></td>
     <td class="xh"  align="left">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <tr  height="47">
    <td width="270"  align="right"><h3>施工图审查机构名称:</h3></td>
    <td align="left"><span class="span">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;江西瑞林工程咨询有限公司&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
  </tr>
  <tr  height="170">
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr  height="55">
    <td colspan="2" align="center" style=" font-size:20px;">江西省住房与城乡建设厅制</td>
  </tr>
    <tr>
    <td colspan="2"></td>
  </tr>
</table>
<table width="770" border="0"   cellspacing="0" cellpadding="0" style=" padding-bottom:300px; margin-top:30px;">
  <tr>
    <td colspan="4" align="center" style=" font-size:22px;"><h2>江西省深基坑支护工程施工图设计文件</h2></td>
  </tr>
  <tr>
    <td colspan="4" align="center" style=" font-size:22px; padding-top:45px;"><h2>审 查 报 告</h2></td>
  </tr>
    <tr>
    
    <td  colspan="4" align="right" style="margin-right:40; padding-top:20px; padding-bottom:10px;">编号：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
 <table width="770" border="1" cellpadding="0" cellspacing="0">
  <tr>
     <td width="120" height="30">&nbsp;建设项目名称</td>
    <td width="190" id="ProjectName">&nbsp;</td>
    <td width="120">&nbsp; 投资额(万元)</td>
    <td width="190"  id="Investment">&nbsp;</td>
  </tr>
  <tr>
    <td height="30">&nbsp;建设地点</td>
    <td  id="BelongDeptName">&nbsp;</td>
    <td>&nbsp;设计等级</td>
    <td id="EngineeringLevel">&nbsp;</td>
  </tr>
  <tr>
     <td height="30">&nbsp;建设单位名称</td>
    <td id="JianSheUnit">&nbsp;</td>
    <td>&nbsp;项目负责人</td>
    <td id="JianSheUnitHead">&nbsp;</td>
  </tr>
  <tr>
       <td height="30">&nbsp;勘察单位名称</td>
    <td id="KanChaUnit">&nbsp;</td>
    <td>&nbsp;项目负责人</td>
    <td id="KanChaUnitHead">&nbsp;</td>
  </tr>
  <tr>
    <td height="30">&nbsp;资质等级</td>
    <td id="KanChaZZLevel">&nbsp;</td>
    <td>&nbsp;证书编号</td>
    <td id="KanChaUnitZSNo">&nbsp;</td>
  </tr>
  <tr>
    <td height="30">&nbsp;设计单位名称</td>
    <td id="SheJiUnit">&nbsp;</td>
    <td>&nbsp;项目负责人</td>
    <td id="SheJiUnitHead">&nbsp;</td>
  </tr>
  <tr>
    <td height="30">&nbsp;资质等级</td>
    <td id="SheJiUnitGrade">&nbsp;</td>
    <td>&nbsp;证书编号</td>
    <td id="SheJiUnitZSNo">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4"  height="50">&nbsp;1.是否按专家提出的设计方案审查意见进行施工图设计<br />
&nbsp;2.深基坑支护结构体系是否安全、可靠、无明显的不安全因素
<br />
</td>
  
  </tr>
  <tr height="170">
  <td colspan="4">
   <table width="100%"  cellspacing="0" cellpadding="0">
  <tr>
    <td width="30"  rowspan="3" align="center" class="bg">审查报告</td>
    
  </tr>
  <tr>
  	 <td height="150" valign="top">
           <textarea id="Opinion1" name="Opinion1" type="text"  style=" height:150px; width:100%" >1、本深基坑工程施工图设计是按专家提出的设计方案审查意见进行的。
2、深基坑支护工程结构设计安全、可靠，设计无不安全因素。	
</textarea></td>
  </tr>
  <tr>
    <td align="right" class="z" > 审查人员签章:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <br />
    年&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
</table>
</td>
  </tr>
  
</table>
</table>

<table width="770" border="1"  cellspacing="0" cellpadding="0" >
  <tr>
    <td height="40" colspan="2" >&nbsp;1. 是否达到建设部《建筑工程设计文件编制深度的规定》和省有关规定要求<br />
&nbsp;2. 施工图是否按规定盖有出图章和签署<br />
</td>
   
  </tr>
  <tr>
    <td colspan="2">
    <table width="100%"  cellspacing="0" cellpadding="0">
  <tr>
    <td width="30"  rowspan="3" align="center" class="bg">审查报告</td>
    
  </tr>
  <tr>
  	 <td height="150"><textarea id="Opinion2" name="Opinion2" type="text"  style=" height:150px; width:100%" >1、达到了建设部《建筑工程设计文件编制深度的规定》和本省有关规定要求，并已按施工图审查意见（详附件）要求整改完毕。
2、施工图已按规定盖有出图章和签署。
</textarea></td>
  </tr>
  <tr>
    <td align="right" class="z" > 审查人员签章:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <br />
    年&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
</table>
</td>
   
  </tr>
  <tr>
    <td height="50" colspan="2" >&nbsp;1.本深基坑工程是否进行抗震设计<br />
&nbsp;2.是否损害公众利益<br />
</td>
  </tr>
  <tr>
    <td colspan="2">
     <table width="100%"  cellspacing="0" cellpadding="0">
  <tr>
    <td width="30"  rowspan="3" align="center" class="bg">审查报告</td>
    
  </tr>
  <tr>
  	 <td height="150"><textarea id="Opinion3" name="Opinion3"  type="text"  style=" height:150px; width:100%" >1、本深基坑工程位于抗震设防区，已按规范要求进行六度抗震设防设计；
2、未损害公众利益。
</textarea></td>
  </tr>
  <tr>
    <td align="right" class="z" > 审查人员签章:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <br />
    年&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
</table>
    </td>
  </tr>
</table>






<table width="770" border="1" cellspacing="0" cellpadding="0">
  <tr>
    <td  height="30" colspan="2" align="center">施工图审查机构综合结论</td>
  </tr>
  <tr>
    <td colspan="2">
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="150"><textarea id="Opinion4" name="Opinion4" type="text"  style=" height:150px; width:100%" ></textarea></td>
  </tr>
   <tr>
    <td align="right" class="z" > 审查人员签章:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <br />
    年&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
</table>
    </td>
  </tr>
   <tr>
    <td  height="30" colspan="2" align="center">备   注</td>
  </tr>
  <tr>
    <td colspan="2" height="160">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="150"><textarea id="Opinion5" name="Opinion5" type="text"  style=" height:150px; width:100%" ></textarea></td>
  </tr>
   <tr>
    <td align="right" class="z" > 审查人员签章:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <br />
    年&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
</table>

    </td>
  </tr>
</table>

                </tr>
                <tr >
                <table border="0"   width="100%"  cellspacing="0" cellpadding="0"  style="">
                <tr>
                    <td class="aim-ui-button-panel" width="100%"  height="20"  style="border-top-width:0" >
                        <a id="btnSubmit" class="aim-ui-button submit">提交</a>
                        <a id="btnCancel" class="aim-ui-button cancel">取消</a>
                         <a id="dy" class="aim-ui-button cancel">打印</a>
                    </td>
                    </tr>
                    </table>
                </tr>
          
        </table>
    </div>
    <input type=hidden name="ProjectId" id="ProjectId" />
     <input id="Id" name="Id" type=hidden />
</asp:Content>


