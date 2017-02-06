using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Web.Script.Serialization;

using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using SP.Model;
using System.Data;

namespace SP.Web
{
    public partial class ProjectFileList : BaseListPage
    {
        private ProjectFile[] ents = null;
        string id = String.Empty;   // 对象id
        IList<string> ids = null;   // 节点列表
        IList<string> pids = null;   // 父节点列表 
        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            id = RequestData.Get<string>("id", String.Empty);
            ids = RequestData.GetList<string>("ids");
            pids = RequestData.GetList<string>("pids");
            switch (this.RequestAction)
            {
                case RequestActionEnum.Custom:
                    if (RequestActionString == "querychildren")
                    {
                        if (String.IsNullOrEmpty(id))
                        {
                           ents = ProjectFile.FindAll("FROM SysGroup as ent WHERE ParentId is null  Order By CreateTime desc");
                        }
                        else
                        {
                          ents = ProjectFile.FindAll("FROM ProjectFile as ent WHERE ParentId = '" + id + "' Order By CreateTime desc");
                        }

                        this.PageState.Add("DtList", ents);
                    }
                    else if (RequestActionString == "batchdelete")
                    {
                        IList<object> idList = RequestData.GetList<object>("IdList");
                        if (idList != null && idList.Count > 0)
                        {
                            ProjectFile.DoBatchDelete(idList.ToArray());
                        }
                    }
                    else if (RequestActionString == "c")
                    {
                        DoCreateSubByRole();
                    }
                    break;
                default:
                    ProjectFile[] grpList = ProjectFile.FindAll("From ProjectFile as ent where  (ParentID='' or ParentID is null)  and Id='D67ADFAA-CC13-4168-9588-B52D6BC555D3' Order By CreateTime Desc");
                    this.PageState.Add("DtList", grpList);
                    break;
            }
        }

        #endregion

        #region 私有方法

        [ActiveRecordTransaction]
        private void DoCreateSubByRole()
        {
            IList<string> idList = RequestData.GetList<string>("IdList");
            SysGroup tent = SysGroup.Find(id);

            if (idList != null && idList.Count > 0)
            {
                SysRole[] duties = SysRole.FindAllByPrimaryKeys(idList.ToArray());

                foreach (SysRole tduty in duties)
                {
                    if (!SysGroup.Exists("Name=? and Type=21 and ParentID = ?", tduty.Name, tent.ID))
                    {
                        SysGroup tgrp = new SysGroup()
                        {
                            Name = tduty.Name,
                            Code = tduty.Code,
                            Type = 3,   //角色
                            Status = 1,
                            SortIndex = 9999,
                            CreateDate = DateTime.Now
                        };

                        tgrp.CreateAsChild(tent);
                    }
                }
            }

        }

        #endregion
    }
}
