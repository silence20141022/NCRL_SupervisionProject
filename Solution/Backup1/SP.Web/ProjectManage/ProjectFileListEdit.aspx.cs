using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Aim.Data;
using Aim.Portal;
using Aim.Portal.Model;
using Aim.Portal.Web;
using Aim.Portal.Web.UI;
using SP.Model;
using System.Data;

namespace SP.Web
{
    public partial class ProjectFileListEdit : BasePage
    {
        #region 变量

        string op = String.Empty; // 用户编辑操作
        string id = String.Empty;   // 对象id
        string type = String.Empty; // 对象类型

        #endregion

        #region ASP.NET 事件

        protected void Page_Load(object sender, EventArgs e)
        {
            op = RequestData.Get<string>("op");
            id = RequestData.Get<string>("id");
            type = RequestData.Get<string>("type");

            ProjectFile ent = null;

            switch (this.RequestAction)
            {
                case RequestActionEnum.Update:
                    ent = this.GetMergedData<ProjectFile>();
                    ent.DoUpdate();
                    this.SetMessage("修改成功！");
                    break;
                case RequestActionEnum.Insert:
                case RequestActionEnum.Create:
                    ent = this.GetPostedData<ProjectFile>();
                    //ent.CreateTime = DateTime.Now;
                    // DataTable dt = DataHelper.QueryDataTable("select case when TypeId is not null then TypeId+Id+',' else Id+',' end as typid from NCRL_SP..ProjectFile where Id='" + RequestData.Get<string>("id") + "'");
                    // if (dt.Rows.Count != 0)
                    // {
                    //     ent.TypeID =  dt.Rows[0]["typid"].ToString();
                    // }
                    // ent.IsDelete = "0";
                   

                    ent.DoCreate();
                    this.SetMessage("新建成功！");
                    break;
                default:
                    if (RequestActionString == "createsub")
                    {
                      
                        ent = this.GetPostedData<ProjectFile>();
                        ent.CreateTime = DateTime.Now;
                        DataTable dt = DataHelper.QueryDataTable("select case when TypeId is not null then TypeId+Id+',' else Id+',' end as typid from NCRL_SP..ProjectFile where Id='" + RequestData.Get<string>("id") + "'");
                        if (dt.Rows.Count != 0)
                        {
                            ent.TypeID = dt.Rows[0]["typid"].ToString();
                            ent.ParentID = RequestData.Get<string>("id");
                        }
                        ent.IsDelete = "0";


                        ent.DoCreate();
                        this.SetMessage("新建成功！");
                    }
                    break;
            }

            if (op != "c" && op != "cs")
            {
                if (!String.IsNullOrEmpty(id))
                {
                    ent = ProjectFile.Find(id);
                }
                
                this.SetFormData(ent);
            }
        }

        #endregion
    }
}

