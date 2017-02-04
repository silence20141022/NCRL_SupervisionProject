<%@ Page Language="C#" MasterPageFile="~/Masters/Ext/Site.Master" AutoEventWireup="true"
    EnableEventValidation="false" CodeBehind="Default.aspx.cs" Inherits="SP.Web.Default"
    Title="�ۺϹ���ϵͳ" %>

<%@ Import Namespace="Aim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadHolder" runat="server">

    <script src="/js/ext/ux/TabScrollerMenu.js" type="text/javascript"></script>

    <style type="text/css">
        body
        {
            filter: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FAFBFF,endColorStr=#C7D7FF);
            color: #003399;
            font-family: Verdana, Arial, Helvetica, sans-serif;
        }
        #main
        {
        }
        .table_banner
        {
            filter: progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#E0F0F6,endColorStr=#A4C7E3);
        }
        .tab_item
        {
            font-size: 15;
            border: 0px;
            border-left: 1px solid;
            border-color: Gray;
            padding-right: 10px;
        }
        .x-tab-strip-text
        {
            color: Black !important; /*margin-left: 10px;*/
        }
        .x-tab-strip-active
        {
            height: 25;
            line-height: 25;
            border-bottom-style: solid;
            border-bottom-color: Red;
            border-bottom-width: 2;
        }
        .x-tab-strip-active .x-tab-strip-text
        {
            color: black !important;
        }
        .x-tab-panel-header
        {
            border: 0px;
            background-image: url() !important;
            background: Transparent;
        }
        .x-tab-panel-header .x-tab-strip
        {
            border: 0px;
            background: none;
            height: 28px;
        }
        .toolbar
        {
            border: 0px;
            background-image: url(/images/nportal/tdbg.jpg);
        }
    </style>

    <script type="text/javascript">
        var mdls, win1, win2;
        //, { Name: "�����Ż�", Url: "/Home.aspx?BlockType=DeptPortal", Code: "DeptPortal"}
        function onPgLoad() {
            mdls = [{ Name: "��˾�Ż�",cls:'aim-icon-home', Url: "/Home.aspx?BlockType=Portal", Code: "CompanyPortal" }, 
            { Name: "���ۺ�ϵͳ�Ż�", cls:'aim-icon-home',Url: "<%=Aim.Common.ConfigurationHosting.SystemConfiguration.AppSettings["GoodwayPortalUrl"].Replace("portal/Portal.aspx","") %>/portal/HomeboardNew.aspx?BlockType=Portal&TemplateId=PRO0001I&PassCode=<%=Session["PassCode"]%>", Code: "DeptPortal"}
           ,{ Name: "��ݵ���",cls:'', Url: "/MyShortCutList.aspx", Code: "MyQuick"}]; //AimState["Modules"] || []; , 
            setPgUI();
            //RefreshSession();
            window.setInterval(NewMessage, 60000);   
        }
        function RefreshSession() {
            $.ajax({
                type: "GET",
                url: "Default.aspx",
                data: "tag=Refresh",
                success: function(msg) {
                }
            });
            window.setTimeout("RefreshSession()", 900000);
        }
        function setPgUI() {
            var tabArr = new Array();
            var i = 0;
            var FrameHtml = "";
            $.each(mdls, function() {  // ����tab��ǩ 
                var tab = {
                    title: this["Name"],
                    href: this["Url"],
                    code: this["Code"],
                    listeners: { activate: handleActivate },
                    margins: '0 0 0 0',
                    border: false,
                    iconCls: this["cls"],
                    layout: 'border',
                    html: "<div style='display:none;'></div>"
                    /*items: [{ region: 'center', border: false,
                    html: "<div style='display:none;'></div>"
                    }]*/
                }
                tabArr.push(tab);
            });
            var scrollerMenu = new Ext.ux.TabScrollerMenu({  // ����tab����ʱ����
                menuPrefixText: '��Ŀ',
                maxText: 15,
                pageSize: 5
            });

            var tabPanel = new Ext.ux.AimTabPanel({
                enableTabScroll: true,
                border: true,
                defaults: { autoScroll: true },
                plugins: [scrollerMenu],
                region: 'north',
                margins: '50 200 0 165',
                activeTab: 0,
                listeners: { 'click': function() { handleActivate(); } },
                width: document.body.offsetWidth - 5,
                height: 10,
                items: tabArr/*,
                itemTpl: new Ext.XTemplate(
                '<li id="{id}" style="overflow:hidden" style="background-image: url(/images/shared/home2.png);background-repeat: no-repeat;background-position:left;">',
                    '<span class="tab_item" style="margin-top:5px;">',
                        '<span class="x-tab-strip-text" align="center">{text}</span>',
                    '</span>',
                '</li>'<img id='imgMessage' src='images/shared/email.gif' style='height: 15px' onclick='shownewmsg()'/>&nbsp;&nbsp;<img src='images/shared/group.png' onclick='showwin()' style='height: 15px' />
                )*/
            });
            var html = "<div style='font-size: 12px; margin: 0;padding:0px;'><table width=99%><tr><td style='font-size:12px;color:black;width:250px'>&nbsp;&nbsp;�Ϻ���Ϊ��Ϣ�Ƽ����޹�˾</td>";
            html+="<td align=center style='font-size:12px;'>����:<span id='auditCount' style='font-size:12px;color:red;cursor:hand;text-decoration: underline' onclick=\"opencenterwin2('/WorkFlow/TaskTab.aspx?tab=0', 'tasks', 1000, 550)\">"+AimState["NewTask"]+"</span>����������,";
            html+="<span id='msgCount' style='font-size:12px;color:red;text-decoration: underline;cursor:hand;' onclick=\"opencenterwin2('/Modules/office/SysMessageTab.aspx', 'messages', 800, 550)\">"+AimState["NewMessage"]+"</span>��δ����Ϣ</td>";
            html+="<td style='width:40px'><img id='imgMessage' src='images/shared/email.gif' alt='ϵͳ��Ϣ' style='height:18px;cursor:hand;' onclick='shownewmsg()'/>&nbsp;<img src='images/shared/message_edit.png' alt='��ǩ����' style='height:18px;cursor:hand;' onclick='showwin()' /></td></tr></table></div>";
            var bottomBar = new Ext.Toolbar({
                cls: "toolbar",
                region: 'south',
                bodyStyle: 'border:0px',
                width: document.body.offsetWidth - 5,
                html: html
            });
            var viewport = new Ext.ux.AimViewport({
                layout: 'border',
                items: [tabPanel, {
                    region: 'center',
                    margins: '-5 5 0 5',
                    cls: 'empty',
                    bodyStyle: 'border-top-width:0px;',
                    html: '<iframe width="100%" height="100%" id="frameContent" name="frameContent" frameborder="0"></iframe>'
                }, bottomBar]
            });
            var depts = AimState["Depts"];
            var dtpbtns = [];
            $.each(depts, function() {  // ����tab��ǩ background:#21acef
                var tab = {
                    text: this["DeptName"],
                    id: this["DeptId"],
                    icon: "/Images/shared/home2.png",
                    handler: function() {
                        frameContent.document.getElementById("subFrameContent").src = "/Home.aspx?IsManage=T&BlockType=DeptPortal&DeptId=" + this.id;
                    }
                }
                dtpbtns.push(tab);
            });
            var btn = new Ext.Button({
                renderTo: 'btnDeptArea',
                text: '�����Ż�',
                iconCls: "aim-icon-home",
                menu: dtpbtns
            });
            var btn = new Ext.Button({
                renderTo: 'btnArea',
                text: 'ע��',
                iconCls: 'aim-icon-cog',
                menu: [{ text: 'ע��', icon: "/Images/shared/trans.gif", handler: function() { document.getElementById("ctl00_BodyHolder_lnkRelogin").click(); } },
                    { text: '�˳�', icon: "/Images/shared/exit.png", handler: function() { document.getElementById("ctl00_BodyHolder_lnkExit").click(); } },
                    { text: '�޸�����', icon: "/Images/shared/key.png", handler: function() { OpenPwdChgPage(); } },
                    { text: '�ղ�', icon: "/Images/shared/feed_add.png", handler: function() { addfavor(window.location.href, "�ۺϹ���ϵͳ"); } }]
            });
            function handleActivate(tab) {
                tab = tab || tabPanel.getActiveTab();

                if (!tab) {
                    return;
                }

                var url = tab.href;
                // ��ҳ
                /*if (tab.code.toUpperCase() != "PORTAL") {
                url = $.combineQueryUrl("/SubPortal3.aspx", "mcode=" + tab.code);
                }*/
                if (document.getElementById("frameContent"))
                    frameContent.document.getElementById("subFrameContent").src = url;
                else {
                    window.setTimeout("LoadFirstTab('" + url + "');", 100);
                }
                return;
            }
        }
        function OpenPwdChgPage() {
            rtn = OpenWin("/Modules/SysApp/OrgMag/UsrChgPwd.aspx", "_blank", CenterWin("width=350,height=180,scrollbars=yes"));
        }
        function LoadFirstTab(url) {
            if (document.getElementById("frameContent"))
                frameContent.location.href = "SubPortalApp.aspx"//"SubPortalTree.aspx?id=f35cb450-cb38-4741-b8d7-9f726094b7ef";
            else
                window.setTimeout("LoadFirstTab('" + url + "');", 100);
        }

        function DoRelogin() {
            window.setTimeout("location.href = '../Login.aspx'", 200);
        }
        function opencenterwin(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //��ô��ڵĴ�ֱλ��;
            var iLeft = (window.screen.availWidth - 15 - iWidth); //��ô��ڵ�ˮƽλ��/ 2;
            return window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
        }
        function opencenterwin2(url, name, iWidth, iHeight) {
            var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //��ô��ڵĴ�ֱλ��;
            var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //��ô��ڵ�ˮƽλ��;
            return window.open(url, name, 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes');
        }
        function showwin() {
                win1 = opencenterwin("/LeaderBusinessTrip/LeaderCalendarView.aspx", "Organize", 800, 550);
            win1.focus();
        }
        function shownewmsg() {
            win2 = opencenterwin2("/Modules/Office/SysMessageTab.aspx", "MessageBox", 800, 550);
            win2.focus();
            $("#imgMessage").attr("src", "images/shared/email.gif");
        }
        function NewMessage() {
            jQuery.ajaxExec('unreadmessage', {}, function(rtn) {
                if (rtn.data.NewMessage) {
                if(parseInt(rtn.data.NewMessage)>0&&parseInt(rtn.data.NewMessage)>parseInt(document.getElementById("msgCount").innerText))
                    $("#imgMessage").attr("src", "../MessageManage/newMessage.gif");
                }
                document.getElementById("msgCount").innerText=rtn.data.NewMessage;
                document.getElementById("auditCount").innerText=rtn.data.NewTask;
            })
        }
        function addfavor(url, title) {
            if (confirm("��ȷ��Ҫ�ղ���?")) {
                var ua = navigator.userAgent.toLowerCase();
                if (ua.indexOf("msie 8") > -1) {
                    external.AddToFavoritesBar(url, title, '����ϵͳ'); //IE8
                } else {
                    try {
                        window.external.addFavorite(url, title);
                    } catch (e) {
                        try {
                            window.sidebar.addPanel(title, url, ""); //firefox
                        } catch (e) {
                            alert("�����ղ�ʧ�ܣ���ʹ��Ctrl+D�������");
                        }
                    }
                }
            }
            return false;
        }  
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyHolder" runat="server">
    <div id="main" style="text-align: center">
        <div align="center" align="center" />
        <table id="__01" width="100%" cellpadding="0" cellspacing="0" style="table-layout: fixed;
            background-color: White;">
            <tr>
                <td style="width: 5px; vertical-align: top">
                </td>
                <td>
                    <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" style="table-layout: fixed;">
                        <tr style="height: 55px; background: url(images/NPortal/ba1.jpg)">
                            <td align="center" width="265">
                                <img src="images/NPortal/logo3.png" alt="" />
                            </td>
                            <td align="center" >
                                <img src="images/NPortal/toop6.jpg" />
                            </td>
                            <td valign="middle" align="right" id="btnDeptArea" style="width: 85px">
                            </td>
                            <td style="width:5px">
                            </td>
                            <td valign="middle" align="left" style="repeat-x" id="btnArea" style="width: 60px">
                                <asp:LinkButton Visible="false" ID="lnkGoodway" Font-Size="12px" runat="server" ForeColor="White"
                                    OnClick="lnkGoodway_Click">�ۺϹ���ƽ̨</asp:LinkButton>
                                <asp:LinkButton ID="lnkRelogin" runat="server" OnClick="lnkRelogin_Click" ForeColor="White"
                                    Style="display: none;" Font-Size="12px">ע��</asp:LinkButton>
                                <asp:LinkButton ID="lnkExit" runat="server" OnClick="lnkExit_Click" ForeColor="White"
                                    Style="display: none;" Font-Size="12px">�˳�</asp:LinkButton>
                            </td>
                            <td style="width: 11px;">
                            </td>
                        </tr>
                        <tr style="height: 25px; background-color: #21acef">
                            <td align="left" width="250" style='font-size: 12px; color: #D3DF32;'>
                                &nbsp;&nbsp;<%=UserInfo.Name %>&nbsp;&nbsp;��ӭ��ʹ��ϵͳ&nbsp;!
                            </td>
                            <td>
                            </td>
                            <td align="right" colspan="3">
                                <span onclick="window.open('/Modules/Office/calendar.htm','_blank')" style='font-size: 12px;
                                    cursor: hand; color: white;'>������<%=String.Format("{0}��{1}��", DateTime.Now.Month, DateTime.Now.Day) %></span>
                            </td>
                            <td width="11">
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="width: 5px; vertical-align: top ;">
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
