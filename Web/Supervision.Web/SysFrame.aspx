<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SysFrame.aspx.cs" Inherits="SP.Web.SysFrame" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="/Extjs42/resources/css/ext-all-neptune.css" rel="stylesheet" type="text/css" />
    <script src="/Extjs42/bootstrap.js" type="text/javascript"></script>
    <script src="/js/lib/jquery-1.7.1.js" type="text/javascript"></script>
    <link href="font-awesome41/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        a
        {
            cursor: pointer;
            text-decoration: none;
        }
    </style>
    <script type="text/javascript">
        Ext.onReady(function () {
            Ext.regModel("Model", { fields: ['id', 'name', 'leaf', 'url'] });
            var store = new Ext.data.TreeStore({
                model: 'Model',
                nodeParam: 'id',
                proxy: {
                    type: 'ajax',
                    url: 'SysFrame.aspx',
                    reader: 'json'
                },
                root: {
                    //expanded: true,
                    name: '功能菜单',
                    id: '-1'
                }
            });
            var treepanel = Ext.create('Ext.tree.Panel',
            {
                title: '功能菜单',
                useArrows: true,
                region: 'west',
                collapsible: true,
                hideHeaders: true,
                //frame: true,
                animate: true,
                rootVisible: false,
                // split: true,
                width: 200,
                store: store,
                columns: [
                { text: 'id', dataIndex: 'id', width: 100, hidden: true },
                { text: 'leaf', dataIndex: 'leaf', width: 100, hidden: true },
                { xtype: 'treecolumn', text: '名称', dataIndex: 'name', width: 270 }
                ],
                hrefTarget: 'mainContent',
                listeners: { itemclick: function (view, rec, item, index, e) {
                    Ext.getDom("contentIframe").src = rec.get("url");
                }
                }
            });
            var viewport = new Ext.container.Viewport({
                layout: 'border',
                items: [{
                    height: 80,
                    region: 'north',
                    html: '<table border="1" cellspacing="0"  style="width:100%; height:78px; background-image:url(images/head/lantp.png);border:none; position:absolute" ><tr ><td style="border:none;width:187px; height:78px "><img style="width:187px;height:56px;" src="../images/head/tlogo.png"/></td><td style="line-height:78px;height:78px;vertical-align:middle; border:none;font-size:35px; text-align:center; color:rgb(255,255,255);font-weight:bold">中国瑞林分子公司业务管理系统</td><td style="border:none;width:187px; height:78px"><a style="text-decoration:underline; font-size:17px;" id="logout"><img src="images/head/zx3.png"/></a></td></tr></table>'
                }, treepanel,
                { region: 'center',
                    layout: 'fit',
                    id: 'mainContent',
                    collasible: true,
                    margin: '-1 0 0 0',
                    contentEl: 'contentIframe'
                }]
            })
            treepanel.expandAll();

            $("#logout").click(function () {
                $.post("SysFrame.aspx?action=logout", {}, function (rtn) {
                    window.location.href = "Login.aspx";
                });
            });
        });

    </script>
</head>
<body>
    <iframe id="contentIframe" width="100%" height="100%" name="mainContent" frameborder="no"
        border="0" marginwidth="0" marginheight="0"></iframe>
</body>
</html>
