<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChouJinPrint.aspx.cs" Inherits="SP.Web.ConsultationManage.ChouJinPrint" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../bootstrap32/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="panel panel-primary" style="margin-bottom: 0; padding-bottom: 0">
        <div class="panel-heading" style="text-align: center; padding-bottom: 0px">
            <strong style="font-size: 12px">
                <label runat="server" id="lbTitle">
                </label>
            </strong>
        </div>
        <div class="panel-body" style="padding-top: 2px; font-size: 11px; text-align: center">
            <table cellpadding="0" cellspacing="0" width="100%" class="table-bordered">
                <tr style="font-weight: bolder; font-size: 11px">
                    <td style="width: 12%">
                        序号
                    </td>
                    <td style="width: 12%">
                        姓名
                    </td>
                    <td>
                        酬金
                    </td>
                    <td style="width: 12%">
                        序号
                    </td>
                    <td style="width: 12%">
                        姓名
                    </td>
                    <td>
                        酬金
                    </td>
                </tr>
                <asp:Literal ID="lt" runat="server"></asp:Literal>
            </table>
            <div style="float: left; margin-left: 90px">
                法人代表：</div>
            <div style="float: left; margin-left: 180px">
                复核：</div>
            <div style="float: right; margin-right: 80px">
                制表：</div>
        </div>
    </div>
    </form>
</body>
</html>
