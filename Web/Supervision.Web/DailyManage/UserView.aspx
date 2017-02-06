<%@ Page Title="" Language="C#" MasterPageFile="~/Masters/Ext/formpage.Master" AutoEventWireup="True"
    CodeBehind="UserView.aspx.cs" Inherits="SP.Web.UserView" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadHolder" runat="server">

    <script type="text/javascript">
        var StatusEnum = { '1': '有效', '0': '无效' };

        var EditWinStyle = CenterWin("width=800,height=346,scrollbars=yes,resizable=yes");
        var EditPageUrl = " UserEdit.aspx";

        var viewport;
        var store;
        var grid, pgBar;
        var qtype, op, id, typname;
        var filemodule;
        function onPgLoad() {
            qtype = $.getQueryString({ "ID": "type" });
            op = $.getQueryString({ "ID": "op" });
            id = $.getQueryString({ "ID": "id" });
            typname = $.getQueryString({ "ID": "typname" });

            filemodule = AimState["filemodule"];

            setPgUI();
        }

        function setPgUI() {
            // 表格数据 
            var myData = {
                total: AimSearchCrit["RecordCount"],
                records: AimState["UsrList"] || []
            };

            // 表格数据源
            store = new Ext.ux.data.AimJsonStore({
                dsname: 'UsrList',
                idProperty: 'UserId',
                data: myData,
                fields: [
                { name: 'UserId' }, { name: 'GroupName' }, { name: 'GroupId' }, { name: 'Name' },
                { name: 'LoginName' }, { name: 'WorkNo' },
                { name: 'Status' },
                { name: 'Email' },
                { name: 'Remark' }, { name: 'UpFile' }, { name: 'UserType' },
                { name: 'CreateDate', type: 'date'}],
                proxy: new Ext.ux.data.AimRemotingProxy({
                    aimbeforeload: function(proxy, options) {
                        options.data = { type: qtype, id: id, op: op, typname: typname };
                    }
                })
            });

            // 分页栏
            pgBar = new Ext.ux.AimPagingToolbar({
                pageSize: AimSearchCrit["PageSize"],
                store: store
            });


            var schBar = new Ext.ux.AimSchPanel({
                store: store,
                collapsed: false,
                columns: 4,
                items: [
                    { fieldLabel: '姓名', id: 'Name', schopts: { qryopts: "{ mode: 'Like', field: 'Name' }"} },
                    { fieldLabel: '工号', id: 'WorkNo', schopts: { qryopts: "{ mode: 'Like', field: 'WorkNo' }"} },
                    { fieldLabel: '邮箱', id: 'Email', schopts: { qryopts: "{ mode: 'Like', field: 'Email' }"} }
                ]
            });
            // 工具栏
            var tlBar = new Ext.ux.AimToolbar({
                items: [{ text: '添加人员', iconCls: 'aim-icon-user-add',
                    handler: function() {

                        if (id == "A67ADFAA-CC13-4168-9588-B52D6BC555D3") {
                            AimDlg.show('请选择相应的部门添加人员', '提示', 'alert');
                            return;
                        } else {
                            openMdlWin(EditPageUrl, "c", EditWinStyle);
                        }
                        // ExtOpenGridEditWin(grid, EditPageUrl, "c", EditWinStyle);

                    }
                }, { text: '编辑人员', iconCls: 'aim-icon-user-edit',
                    handler: function() {

                        openMdlWin(EditPageUrl, "u", EditWinStyle);
                        // ExtOpenGridEditWin(grid, EditPageUrl, "u", EditWinStyle);
                    }
                }, { text: '移除人员', iconCls: 'aim-icon-user-delete', aimexecutable: true,
                    handler: function() {
                        var UserIds = []; var GroupIds = [];
                        var recs = grid.getSelectionModel().getSelections();
                        $.each(recs, function() {
                            UserIds.push(this.json.UserId);
                            GroupIds.push(this.json.GroupId);
                        })
                        $.ajaxExec("delete", { UserIds: UserIds, GroupIds: GroupIds }, function() { onExecuted(); });
                    }
}]
                });

                // 工具标题栏
                var titPanel = new Ext.Panel({
                    tbar: tlBar,
                    items: [schBar]
                });

                // 表格面板
                grid = new Ext.ux.grid.AimGridPanel({
                    store: store,
                    region: 'center',
                    columns: [
                { id: 'UserId', header: 'UserId', dataIndex: 'UserId', hidden: true },
                new Ext.ux.grid.AimRowNumberer(),
                new Ext.ux.grid.AimCheckboxSelectionModel(),
                { id: 'JC', dataIndex: 'UserId', header: '奖惩情况', width:70, renderer: linkRender },
                { id: 'Name', header: '姓名', width: 100, sortable: true, dataIndex: 'Name', renderer: linkRender }, //renderer: linkRender,
                {id: 'WorkNo', header: '工号', width: 100, sortable: true, dataIndex: 'WorkNo' },
                { id: 'Email', header: '邮箱', width: 150, sortable: true, dataIndex: 'Email' },
                { id: 'UserType', header: '人员类型', width: 100, sortable: true, dataIndex: 'UserType', renderer: linkRender },
                { id: 'UpFile', header: '附件', width: 200, sortable: true, dataIndex: 'UpFile', renderer: linkRender },
                    { id: 'GroupName', header: '部门/角色', width: 150, sortable: true, dataIndex: 'GroupName' }
            ],
                    bbar: pgBar,
                    tbar: titPanel,
                    autoExpandColumn: 'UpFile'
                });

                // 页面视图
                viewport = new Ext.ux.AimViewport({
                    items: [grid]
                });
            }

            // 链接渲染
            function linkRender(val, p, rec) {
                var rtn = val;
                switch (this.dataIndex) {
                    case "UserType":
                        rtn = val;
                        break;
                    case "UpFile":
                        if (rtn) {
                            var val1 = val.substring(0, val.length - 1);
                            val = val1.split('_')[0];
                            var name = val1.split('_')[1].substring(0, val.length - 1);
                            rtn = "<a href='#' onclick=opencenterwin('getpdf.aspx?id=" + val + "')>" + name + "</a>";
                            // rtn = "<a href='#' onclick=opencenterwin('" + filemodule + "')>" + val.substring(0, val.length - 1) + "</a>";
                        }
                        break;
                    case "UserId":
                        //if (rtn == "0e6c4f67-a27b-4b3f-8424-4904d5a16f0c") {

                        $.ajaxExecSync("gethp", { thisid: rtn }, function(ret) {
                        rtn = "";
                            var typ = ret.data.thishp.split("_");
                            $.each(typ, function(k, v) {

                                if (v == "奖励") {
                                    rtn += "<img src='/images/shared/flag.gif' width='18px' height='18px' />";  //奖励
                                } else if (v == "惩罚") {
                                    rtn += "<img src='/images/shared/exclam1.gif' width='18px' height='18px' />";   //惩罚
                                }
                            })
                        });
                        //   }
                        //                        if (rtn == "b7f5335e-6841-45b2-9e58-f582cbe3dca5") {
                        //                            rtn = "<img src='/images/shared/flag.gif' width='18px' height='18px' />";  //奖励
                        //                            // rtn = "<img src='/images/shared/exclam1.gif' width='18px' height='18px' />";   //惩罚
                        //                        }
                        //                        else {
                        //                            rtn = "";
                        //                        }
                      
                        break;
                    case "Status":
                        rtn = StatusEnum[val];
                        break;
                }

                return rtn;
            }



          

            function opencenterwin(url) {

                var iWidth = "1000", iHeight = "600";
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;

                window.open(url, '', 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes, resizable = no');
            }

            // 打开模态窗口
            function openMdlWin(url, op, style) {
                op = op || "r";
                var iHeight = "550";
                var iWidth = "675";
                var iTop = (window.screen.availHeight - 30 - iHeight) / 2; //获得窗口的垂直位置;
                var iLeft = (window.screen.availWidth - 10 - iWidth) / 2; //获得窗口的水平位置;
                style = style || 'height=' + iHeight + ',,innerHeight=' + iHeight + ',width=' + iWidth + ',innerWidth=' + iWidth + ',top=' + iTop + ',left=' + iLeft + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes,resizable=no';
                //  window.open(url, "_blank", style);
                var sels = grid.getSelectionModel().getSelections();

                var sel;
                if (sels.length > 0) sel = sels[0];

                var params = [];
                params[params.length] = "op=" + op;

                if (op !== "c") {
                    if (sel) {
                        if (url.indexOf("id=") < 0) {

                            params[params.length] = "id=" + sel.json.UserId;
                        }
                    } else {
                        AimDlg.show('请选择需要操作的行。', '提示', 'alert');
                        return;
                    }
                }

                url = $.combineQueryUrl(url, params)

                rtn = window.open(url + "&typeid=" + id + "&typename=" + typname, "_blank", style);
                if (rtn && rtn.result) {
                    if (rtn.result === 'success') {
                        store.reload();
                    }
                }
            }


            function onExecuted() {
                store.reload();
            }
    </script>

</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyHolder" runat="server">
    <div style="font-size: 14px;">
    </div>
</asp:Content>
