<%@ Page Title="���ӹ�˾����ϵͳ" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs"
    Inherits="Aim.Portal.Web.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" " http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>���ӹ�˾����ϵͳ</title>
    <meta http-equiv="Content-Type" />
    <script src="/js/lib/jquery-1.4.2.min.js" type="text/javascript"></script>
    <script src="/js/common.js" type="text/javascript"></script>
    <script src="/js/pgform.js" type="text/javascript"></script>
    <script src="/js/lib/jquery.form.js" type="text/javascript"></script>
    <script src="/js/lib/jquery.plug-ins.js" type="text/javascript"></script>
    <link href="/css/login_pro.css" rel="stylesheet" type="text/css" />
    <link href="login_data/mini-pkg-min.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        #loading
        {
            width: 16px;
            height: 16px;
            margin-left: 80px;
        }
        .text-input
        {
            border: solid 1px #8FAACF;
        }
        .lbl-message
        {
            color: Red;
        }
    </style>
    <script language="javascript" type="text/javascript">
        var islogining = false;
        var newWin = null;
        function onPgLoad() {
            $(document).bind("keydown", function (e) {
                // �س�
                if (e.keyCode == 13 && !islogining) {
                    DoLogin();
                }
            });
            getCookie();    // ��ȡCookie 
            if (!$("#uname").val()) {
                $("#uname").focus();
            } else if (!$("#pwd").val()) {
                $("#pwd").focus();
            } else {
                $("#imgDoLogin").focus();
            }
            var body = document.getElementsByTagName("body");
            body[0].style.height = document.documentElement.clientHeight + "px";
            var foot = document.getElementById("foot");
            foot.style.position = "absolute";
            foot.style.top = (document.documentElement.clientHeight - 50) + "px";
        }
        window.onresize = function () {
            var body = document.getElementsByTagName("body");
            body[0].style.height = document.documentElement.clientHeight + "px";
            var foot = document.getElementById("foot");
            foot.style.position = "absolute";
            foot.style.top = (document.documentElement.clientHeight - 50) + "px";
        }
        function DoLogin() {
            if (islogining) {
                return;
            }
            setLoginStatus(true);
            if (!$("#uname").val()) {
                $("#message").text("��ʾ���������û�����");
                $("#uname").focus();
                setLoginStatus(false);
                return;
            } else {
                $("#message").text("");
            }
            if (!$("#pwd").val()) {
                $("#message").text("��ʾ�����벻��Ϊ��,�������Ϊ�������������롣�����ҳ��'�޸�����'�����޸�����!");
                $("#pwd").focus();
                setLoginStatus(false);
                return;
            }
            setCookie();    // ����Cookie
            var loginName = $("#uname").val();
            var id = null;
            try {
                id = $.getQueryString({ "ID": "id" }) || IA300_GetHardwareId();
            }
            catch (e) {
            }
            if (!id) {
                id = "";
            }
            $.ajax({
                type: "Get",
                url: "Login.aspx",
                data: "reqaction=checkneedkey&loginname=" + loginName + "&usbkey=" + id,
                success: function (msg) {
                    /*if (msg != "false") {
                    try {
                    if (IA300_GetInstance().IA300CheckExist() == "0") {
                    alert("���˻��������ר�����������ܵ�¼!");
                    setLoginStatus(false);
                    return;
                    }
                    else if (id != msg && id != "4035512c63c6c55db331b028f01e0f5c" && id != "6e555a82bb9c000859f385fdee50037e") {
                    alert("����������,��ʹ�ø��˻���ר����������¼!");
                    setLoginStatus(false);
                    return;
                    }
                    }
                    catch (e) {
                    alert("���˻��������ר�����������ܵ�¼!");
                    setLoginStatus(false);
                    return;
                    }
                    }*/
                    $("form").ajaxSubmit({ data: { 'reqaction': 'login', 'asyncreq': true }, success: function (resp) {
                        setLoginStatus(false);
                        if (resp) {
                            if (resp.indexOf("success") == 0) {
                                var redurl = resp.substr("success".length + 1);
                                if (window.parent && window.parent != window)
                                    window.location.href = redurl;
                                else {
                                    newWin = window.open(redurl, "OnControl_" + Math.round(Math.random() * 1000));
                                    window.setTimeout("DestroySelf('" + redurl + "')", 500);
                                }
                            } else {
                                $("#message").html("��ʾ��" + resp);
                            }
                        }
                    }
                    });
                }
            });
        }
        function DestroySelf(redurl) {
            if (newWin) {
                window.opener = null;
                window.open("", "_self");   //fix ie7 
                window.close();
            }
            else {
                alert("���ڱ���ֹ����,����������Ϸ�����ʾѡ����������ϵͳ��������,���߽���ϵͳ���뵽����վ����");
            }
        }
        function OpenPwdChgPage() {
            rtn = OpenWin("/Modules/SysApp/OrgMag/UsrChgPwd.aspx", "_blank", CenterWin("width=350,height=180,scrollbars=yes"));
        }
        function setLoginStatus(flag) {
            if (flag) {
                islogining = true;
                $("input").attr("disabled", true);
                $("#imgDoLogin").attr("disabled", true);

                $("#span-loading").css("display", ""); // ��ʾ������
            } else {
                islogining = false;
                $("input").attr("disabled", false);
                $("#imgDoLogin").attr("disabled", false);
                $("#span-loading").css("display", "none"); // ���ؽ�����
            }
        }

        function setCookie() {
            var isSaveAccount = $("#saveAcount").attr("checked");
            var isSavePassword = $("#savePassword").attr("checked");

            if (isSaveAccount) {
                SetCookie("uname", $("#uname").val());
                SetCookie("saveAcount", isSaveAccount);
            } else {
                SetCookie("uname", null, { expires: 300 });
                SetCookie("saveAcount", null, { expires: 300 });
            }

            if (isSavePassword) {
                SetCookie("pwd", $("#pwd").val());
                SetCookie("savePassword", isSavePassword);
            } else {
                SetCookie("pwd", null, { expires: 300 });
                SetCookie("savePassword", null, { expires: 300 });
            }
        }

        function getCookie() {
            var isSaveAccount = GetCookie("saveAcount");
            var isSavePassword = GetCookie("savePassword");
            if (isSaveAccount && isSaveAccount != "null") {
                $("#saveAcount").attr("checked", true);
                $("#uname").val(GetCookie("uname"));
            }

            if (isSavePassword && isSavePassword != "null") {
                $("#savePassword").attr("checked", true);
                $("#pwd").val(GetCookie("pwd"));
            }
        }
        function SetCookie(sName, sValue) {
            date = new Date();
            document.cookie = sName + "=" + escape(sValue) + "; expires=Fri, 31 Dec 2099 23:59:59 GMT;";
        }

        function GetCookie(sName) {
            var aCookie = document.cookie.split("; ");
            for (var i = 0; i < aCookie.length; i++) {
                // a name/value pair (a crumb) is separated by an equal sign 13818920945
                var aCrumb = aCookie[i].split("=");
                if (sName == aCrumb[0]) {
                    if (aCrumb[1])
                        return unescape(aCrumb[1]);
                    else
                        return "";
                }
            }

            // a cookie with the requested name does not exist
            return "";
        }		
    </script>
</head>
<body onload="onPgLoad()">
    <form method="post" action="Login.aspx">
    <div id="header">
        <div id="head">
            <div class="logo">
                <a href="" target="_blank">
                    <img src="images/login/sysname1.jpg" alt="�й�����" style="border: 0pt none;" border="0" /></a></div>
        </div>
    </div>
    <!--ͷ��end-->
    <div class="clear">
    </div>
    <!-- ���� begin -->
    <div id="wrap">
        <div class="banner">
        </div>
        <div id="login-info">
            <div class="login_top">
            </div>
            <div class="login_middle">
                <div id="J_LoginBox" class="login-box simple no-longlogin no-dynamic  no-reg module-static">
                    <div class="bd">
                        <div id="J_Static" class="static safe_login">
                            <div class="field">
                                <label for="TPL_username_1">
                                    �˻���</label>
                                <span class="ph-label"></span>
                                <input id="uname" class="login-text J_UserName" maxlength="32" />
                            </div>
                            <div class="field">
                                <label id="password-label">
                                    �� ��</label>
                                <span id="J_StandardPwd">
                                    <input id="pwd" class="login-text" maxlength="10000" type="password" />
                                </span>
                            </div>
                            <div class="field hidden" id="l_f_code">
                            </div>
                            <div class="safe">
                                <input type="checkbox" name="saveAcountName" id="saveAcount" value="true" />
                                <label for="checkbox">
                                    �����ʺ�</label>
                                <input type="checkbox" name="savePassword" id="savePassword" value="true" />
                                <label for="checkbox">
                                    ��������</label>
                                <div id="span-loading" style="display: none;">
                                    <img src="/images/loading.gif" alt="" />
                                </div>
                            </div>
                            <div class="submit">
                                <button class="J_Submit" tabindex="5" type="button" onclick="DoLogin();">
                                    ��¼</button>
                                <a href="#" id="forget-pw-safe" class="forget-pw" tabindex="6" onclick="OpenPwdChgPage()">
                                    �޸�����</a>
                            </div>
                            <ul class="entries">
                            </ul>
                        </div>
                    </div>
                </div>
                <div id="form_text">
                    <div id="form_text2">
                        <div id="message" class="lbl-message">
                        </div>
                        <div id="login_table_notice">
                            ������������ϵ����Ա
                        </div>
                    </div>
                </div>
            </div>
            <div class="login_bottom">
            </div>
        </div>
        <!-- end of login-info -->
        <div class="login_img1">
        </div>
    </div>
    <!-- ���� end -->
    <div class="clear">
    </div>
    <!-- foot class -->
    <div id="foot">
        <div id="footer" style="width: 98%">
            <div style="float: left; text-align: left; width: 50%">
                �й����ֹ��̿Ƽ����޹�˾</div>
            <div style="float: left; text-align: right; width: 50%">
                �Ϻ���Ϊ��Ϣ�Ƽ����޹�˾</div>
        </div>
    </div>
    </form>
</body>
</html>
