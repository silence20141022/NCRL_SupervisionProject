
<%@ Page Title="资料类别编辑" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master" AutoEventWireup="true" CodeBehind="ProjectFileListEdit.aspx.cs" Inherits=" SP.Web.ProjectFileListEdit" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">
  <style type="text/css">
        .aim-ui-td-caption
        {
            text-align: right;
        }
        body
        {
            background-color: #F2F2F2;
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
    </style>
    <script type="text/javascript">

      
        var id = null;

        function onPgLoad() {
            id = $.getQueryString({ ID: 'id' });
        
          //  if(op=="c")
            
            setPgUI();
        }

        function setPgUI() {            
            //绑定按钮验证
            FormValidationBind('btnSubmit', SuccessSubmit);

            $("#btnCancel").click(function() {
                window.close();
            });
            if ($.getQueryString({ ID: "op" }) == 'cs') {
                $("[class*=aim-ui-button submit]").show();
            }
        }

        //验证成功执行保存方法
        function SuccessSubmit() {
            AimFrm.submit(pgAction, { id: id }, null, SubFinish);
        }

        function SubFinish(args) {
            Aim.PopUp.ReturnValue({ id: id, op: pgOperation });
        }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="header"><h1>资料类别编辑</h1></div>
    
    <div id="editDiv" align="center">
        <table class="aim-ui-table-edit">
            <tbody>
                <tr style="display: none">
                    <td>
                        <input id="GroupID" name="GroupID" />
                    </td>
                </tr>
                <tr>
                    <td class="aim-ui-td-caption">
                        名称
                    </td>
                    <td class="aim-ui-td-data" colspan="3">
                        <input id="Name" name="Name" class="validate[required]" style=" width:95%" />
                    </td>
                   
                </tr>
                <tr>
                    <td class="aim-ui-button-panel" colspan="4">
                        <a id="btnSubmit" class="aim-ui-button submit">保存</a>
                        <a id="btnCancel" class="aim-ui-button cancel">取消</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <input type="hidden" id="TypeID" name="TypeID" />
    <input type=hidden id="IsDelete" name="IsDelete" />
</asp:Content>


