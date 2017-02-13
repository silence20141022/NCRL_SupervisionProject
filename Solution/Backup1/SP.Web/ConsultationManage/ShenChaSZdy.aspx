
<%@ Page Title="市政报告" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master" AutoEventWireup="true" CodeBehind="ShenChaSZdy.aspx.cs" Inherits="SP.Web.ShenChaSZdy" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
    <style type="text/css">
      *
        {
        	    font-family: "宋体";
	
	color: #000000;
        	}

        .aim-ui-td-caption
        {
            text-align: right;
        }
        body
        {
        	background-color: #fff;
            /* background-color: #F2F2F2;*/
        }
        fieldset
        {
            margin: 15px;
            width: 100%;
            padding: 5px;
        }
        fieldset legend
        {
            font-size: 12px;
            font-weight: bold;
        }
        .righttxt
        {
            text-align: right;
        }
        input
        {
            width: 90%;
        }
        select
        {
            width: 90%;
        }
        .x-superboxselect-display-btns
        {
            width: 90% !important;
        }
        .x-form-field-trigger-wrap
        {
            width: 100% !important;
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
	line-height: 2em;
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
        .Opinion
        {
        	padding:5px 5px 5px 5px;
        
        	}
    </style>
    <script type="text/javascript">
           var id = $.getQueryString({ ID: 'id' });
        function onPgLoad() {
            setPgUI();
        }

        function setPgUI() {
            if (pgOperation == "c" || pgOperation == "cs") {                
                $("#CreateName").val(AimState.UserInfo.Name);
                $("#CreateTime").val(jQuery.dateOnly(AimState.SystemInfo.Date));
            }

            
            if(pgOperation !="c"){
                $("#sOpinion1").html($("#Opinion1").val());
                $("#sOpinion2").html($("#Opinion2").val());
                $("#sOpinion3").html($("#Opinion3").val());
                $("#sOpinion4").html($("#Opinion4").val());
                $("#sOpinion5").html($("#Opinion5").val());
                $("#sOpinion6").html($("#Opinion6").val());
                $("#sOpinion7").html($("#Opinion7").val());
                //class="Opinion"
            }
            
            
            
            
            $("#ProjectId").val(id);
            
            //绑定按钮验证
            FormValidationBind('btnSubmit', SuccessSubmit);

            $("#btnCancel").click(function() {
                window.close();
            });

            bindpro();
        }





        function bindpro() {
          var dat = AimState["pro"][0];
          $("#ProjectName").html("&nbsp;" + dat.ProjectName);     //项目名称
          $("#Investment").html("&nbsp;" + dat.Investment);   //投资额
          $("#BelongDeptName").html("&nbsp;" + dat.BelongDeptName);     //建设地点
          $("#EngineeringLevel").html("&nbsp;" + dat.EngineeringLevel);   //规模等级
          $("#JianSheUnit").html("&nbsp;" + dat.JianSheUnit);     //建设单位
          $("#JianSheUnitHead").html(dat.JianSheUnitHead);     //建设单位负责人
          $("#KanChaUnit").html("&nbsp;" + dat.KanChaUnit);     //勘察单位
          $("#KanChaUnitHead").html("&nbsp;" + dat.KanChaUnitHead);     //勘察单位负责人
          $("#KanChaZZLevel").html("&nbsp;" + dat.KanChaZZLevel);     //勘察单位资质等级
          //$("#").html(dat.);     //勘察单位证书编号
          $("#SheJiUnit").html("&nbsp;" + dat.SheJiUnit);     //设计单位
          $("#SheJiUnitHead").html("&nbsp;" + dat.SheJiUnitHead);     //设计单位负责人
          $("#KanChaZZLevel").html("&nbsp;" + dat.KanChaZZLevel);     //设计单位资质等级
          //$("#").html(dat.);     //设计单位资质等级
          //$("#").html(dat.);     //设计单位证书编号
          
          
          
          
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
    <%--  <div id="header"><h1>标题</h1></div>
    --%>
    <div id="editDiv" align="center">
        <table class="aim-ui-table-edit">
           
                   <table width="770" border="0" height="1050" cellspacing="0" cellpadding="0">
  <tr>
    <td height="55" style=" padding-top:190px; font-size:28px;" colspan="2" align="center" valign="middle" class="title" ><h1>江西省市政基础设施工程施工图设计文件</h1></td>
  </tr>
  <tr>
    <td height="280" colspan="2" align="center" valign="top" style=" padding-top:50px; font-size:22px;"><h2>审 查 报 告</h2></td>
  </tr>
  <tr>
    <td  height="47" width="270" align="right" class="liftname"><h3>市政工程名称:</h3></td>
    <td class="xh"  align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
    <td colspan="2" align="center" style=" font-size:20px;">江 西 省 建 设 厅 制</td>
  </tr>
    <tr>
    <td colspan="2"></td>
  </tr>
</table>
<table width="770" border="0" height="1050" cellspacing="0" cellpadding="0">
  <tr height="100">
    <td align="center" style="font-size:28px;" ><h1>说    明</h1></td>
  </tr>
  <tr valign="top" height="420"  class="sm">
    <td><p>1、审查意见有经省建设厅考核认定的施工图审查人员认真填写，并签字、盖章。</p>
<p>2、审查结论由施工图审查机构负责人认真填写，并签字、盖章。</p>
<p>3、本《审查报告》系该工程项目施工图设计文件交付使用的法律凭证。</p>
<p>4、本《审查报告》一式三份，由建设单位（业主）、施工图审查机构和分管的建设行政主管部门各执一份。</p>
</td>
  </tr>
</table>

<table width="770" border="0"   cellspacing="0" cellpadding="0" style=" padding-bottom:300px; margin-top:30px;">
  <tr>
    <td colspan="4" align="center" style=" font-size:22px;"><h2>江西省市政基础设施工程施工图设计文件</h2></td>
  </tr>
  <tr>
    <td colspan="4" align="center" style=" font-size:22px; padding-top:45px;"><h2>审 查 报 告</h2></td>
  </tr>
    <tr>
    
    <td  colspan="4" align="right" style="margin-right:40; padding-top:20px; padding-bottom:10px;">编号：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
 <table width="770" border="1" cellpadding="0" cellspacing="0">
  <tr>
    <td width="120" height="52">&nbsp;建设项目名称</td>
    <td width="190" id="ProjectName">&nbsp;</td>
    <td width="120">&nbsp; 投资额(万元)</td>
    <td width="190"  id="Investment">&nbsp;</td>
  </tr>
  <tr>
    <td height="52">&nbsp;建设地点</td>
    <td  id="BelongDeptName">&nbsp;</td>
    <td>&nbsp;规模等级</td>
    <td id="EngineeringLevel">&nbsp;</td>
  </tr>
  <tr>
     <td height="52">&nbsp;建设单位名称</td>
    <td id="JianSheUnit">&nbsp;</td>
    <td>&nbsp;项目负责人</td>
    <td id="JianSheUnitHead">&nbsp;</td>
  </tr>
  <tr>
    <td height="52">&nbsp;勘察单位名称</td>
    <td id="KanChaUnit">&nbsp;</td>
    <td>&nbsp;项目负责人</td>
    <td id="KanChaUnitHead">&nbsp;</td>
  </tr>
  <tr>
    <td height="52">&nbsp;资质等级</td>
    <td id="KanChaZZLevel">&nbsp;</td>
    <td>&nbsp;证书编号</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="52">&nbsp;设计单位名称</td>
    <td id="SheJiUnit">&nbsp;</td>
    <td>&nbsp;项目负责人</td>
    <td id="SheJiUnitHead">&nbsp;</td>
  </tr>
  <tr>
    <td height="52">&nbsp;资质等级</td>
    <td id="">&nbsp;</td>
    <td>&nbsp;证书编号</td>
    <td id="">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="4"  height="70">&nbsp;1.	工程基础(含软基)处理是否安全、可靠。<br />
&nbsp;2.	工程结构体系是否安全、可靠。<br />
&nbsp;3.	工程配套结构（涵管、挡土墙等）是否安全、可靠。<br />
</td>
  
  </tr>
  <tr height="370">
  <td colspan="4">
   <table width="100%"  cellspacing="0" cellpadding="0">
  <tr>
    <td width="30"  rowspan="3" align="center" class="bg">审查报告</td>
    
  </tr>
  <tr>
  	 <td height="380" valign="top" id="sOpinion1" class="Opinion"></td>
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

<table width="770" border="1" height="1050" cellspacing="0" cellpadding="0" >
  <tr>
    <td height="50" colspan="2" align="center">是否符合有关工程强制性标准规范</td>
   
  </tr>
  <tr>
    <td colspan="2">
    <table width="100%"  cellspacing="0" cellpadding="0">
  <tr>
    <td width="30"  rowspan="3" align="center" class="bg">审查报告</td>
    
  </tr>
  <tr>
  	 <td height="230" valign="top"  id="sOpinion2" class="Opinion"></td>
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
    <td height="50" colspan="2" align="center">是否按批准的初步设计文件进行施工图设计</td>
  </tr>
  <tr>
    <td colspan="2">
     <table width="100%"  cellspacing="0" cellpadding="0">
  <tr>
    <td width="30"  rowspan="3" align="center" class="bg">审查报告</td>
    
  </tr>
  <tr>
  	 <td height="230" valign="top"  id="sOpinion3" class="Opinion"></td>
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
    <td  height="50" colspan="2" >&nbsp;1.是否达到建设部《市政公用工程设计文件编制深度的规定》和省有关规定要求；
    <br />
     &nbsp;2.施工图是否按规定盖有出图章和签署。
</td>
  </tr>
  <tr>
    <td colspan="2">
     <table width="100%"  cellspacing="0" cellpadding="0">
  <tr>
    <td width="30"  rowspan="3" align="center" class="bg">审查报告</td>
    
  </tr>
  <tr>
  	 <td height="230" valign="top"  id="sOpinion4" class="Opinion"></td>
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


<table width="770" border="1"  height="950" cellspacing="0" cellpadding="0">
  <tr>
    <td  height="30" colspan="2" align="center">是否损害公众利益</td>
   
  </tr>
  <tr>
    <td colspan="2">
         <table width="100%"  cellspacing="0" cellpadding="0">
  <tr>
    <td width="30"  rowspan="3" align="center" class="bg">审查报告</td>
    
  </tr>
  <tr>
  	 <td height="240" valign="top"  id="sOpinion5" class="Opinion"></td>
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
    <td  height="30" colspan="2" align="center">施工图审查机构综合结论</td>
  </tr>
  <tr>
    <td colspan="2">
         <table width="100%"  cellspacing="0" cellpadding="0">
  <tr>
    <td width="30"  rowspan="3" align="center" class="bg">审查报告</td>
    
  </tr>
  <tr>
  	 <td height="240" valign="top"  id="sOpinion6" class="Opinion"></td>
  </tr>
  <tr>
    <td align="right" class="z" > 负责人签字： &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    审查人员签章:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <br />
    年&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
</table>
    </td>
  </tr>
   <tr>
    <td  height="30" colspan="2" align="center">建设行政主管部门备案意见</td>
  </tr>
  <tr>
    <td colspan="2" height="230">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="230" valign="top"  id="sOpinion7" class="Opinion"></td>
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
        </table>
    </div>
    <input type=hidden name="ProjectId" id="ProjectId" />
     <input id="Id" name="Id" type=hidden />
    <%-- <input id="Opinion7" name="Opinion7" type=hidden/>--%>
     <input id="Opinion1" name="Opinion1" type="hidden"/>
     <input id="Opinion2" name="Opinion2" type="hidden"/>
     <input id="Opinion3" name="Opinion3" type="hidden"/>
     <input id="Opinion4" name="Opinion4" type="hidden"/>
     <input id="Opinion5" name="Opinion5" type="hidden"/>
     <input id="Opinion6" name="Opinion6" type="hidden"/>
     <input id="Opinion7" name="Opinion7" type="hidden"/>
</asp:Content>


