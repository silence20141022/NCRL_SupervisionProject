using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Aim.Data;
using Aim;
using SP.Model;
using Newtonsoft.Json.Linq;

namespace SP.Web.DailyManage
{
    public partial class ProjectAttendanceCard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            string id = Request["id"];
            string userid = Request["userid"];
            string sql = "";
            DataTable dt = null;
            ProjectAttendance paEnt = null;
            IList<ProjectUser> puEnts = null;
            if (!string.IsNullOrEmpty(id))
            {
                paEnt = ProjectAttendance.Find(id);
            }
            switch (action)
            {
                case "loadproject":
                    sql = @"select Id as ProjectId,PManagerId,ProjectName,PManagerName,BelongDeptId,BelongDeptName from NCRL_SP..Project";
                    dt = DataHelper.QueryDataTable(sql);
                    string data_prj = JsonHelper.GetJsonString(dt);
                    sql = "select value as year from NCRL_Portal..SysEnumeration where ParentId='058fbee9-0a9a-4b25-b343-ea8c05396632' order by SortIndex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    string data_year = JsonHelper.GetJsonString(dt);
                    sql = "select value as month from NCRL_Portal..SysEnumeration where ParentId='b25e537b-34e3-4437-87af-692e00facd73' order by SortIndex asc";
                    dt = DataHelper.QueryDataTable(sql);
                    string data_month = JsonHelper.GetJsonString(dt);
                    Response.Write("{'rows':" + data_prj + ",year:" + data_year + ",month:" + data_month + "}");
                    Response.End();
                    break;
                case "save":
                    JObject jo = JsonHelper.GetObject<JObject>(Request["formdata"]);
                    //有可能具体该年月的项目考勤主表已经存在
                    sql = "select * from NCRL_SP..ProjectAttendance where ProjectId='{0}' and Year='{1}' and Month='{2}'";
                    sql = string.Format(sql, jo.Value<string>("ProjectId"), jo.Value<string>("Year"), jo.Value<string>("Month"));
                    dt = DataHelper.QueryDataTable(sql);
                    if (dt.Rows.Count > 0)
                    {
                        paEnt = ProjectAttendance.Find(dt.Rows[0]["Id"]);
                        paEnt.Remark = jo.Value<string>("Remark");
                        paEnt.DoUpdate();
                    }
                    else
                    {
                        paEnt = JsonHelper.GetObject<ProjectAttendance>(Request["formdata"]);
                        paEnt.DoCreate();
                    }
                    //创建完项目阶段考勤后 自动创建本阶段项目所属部门考勤和公司考勤                   
                    //IList<CmpAttendance> caEnts = CmpAttendance.FindAllByProperties(CmpAttendance.Prop_Year, paEnt.Year, CmpAttendance.Prop_Month, paEnt.Month);
                    //if (caEnts.Count == 0)
                    //{
                    //    CmpAttendance caEnt = new CmpAttendance();
                    //    caEnt.Year = paEnt.Year;
                    //    caEnt.Month = paEnt.Month;
                    //    caEnt.DoCreate();
                    //}
                    //表单信息创建或者更新完毕后调取考核明细 
                    sql = "select * from  NCRL_SP..PrjAttendanceDetail  where ProjectAttendanceId='" + paEnt.Id + "' order by UserId asc";
                    dt = DataHelper.QueryDataTable(sql);
                    if (dt.Rows.Count == 0)
                    {
                        //如果是首次创建没有考勤明细的时候
                        sql = "select UserId,UserName from NCRL_SP..ProjectUser where ProjectId='" + paEnt.ProjectId + "' order by UserId asc";
                        dt = DataHelper.QueryDataTable(sql);
                    }
                    string title = paEnt.ProjectName + paEnt.Year + "年" + paEnt.Month + "月考勤表";
                    int runyear = 0;
                    if ((paEnt.Year % 4 == 0 && paEnt.Year % 100 != 0) || paEnt.Year % 400 == 0)
                    {
                        runyear = 1;
                    }
                    Response.Write("{success:true,month:'" + paEnt.Month + "',runyear:" + runyear + ",Id:'" + paEnt.Id + "',detail:" + JsonHelper.GetJsonStringFromDataTable(dt) + ",title:'" + title + "'}");
                    Response.End();
                    break;
                case "loadform":
                    paEnt = ProjectAttendance.Find(id);
                    Response.Write("{success:true,data:" + JsonHelper.GetJsonString(paEnt) + "}");
                    Response.End();
                    break;
                case "updatedetail":
                    string result = Request["SignType"];
                    paEnt = ProjectAttendance.Find(id);
                    sql = "select * from NCRL_SP..PrjAttendanceDetail where ProjectAttendanceId='" + paEnt.Id + "' and UserId='" + Request["UserId"] + "'";
                    dt = DataHelper.QueryDataTable(sql);
                    if (dt.Rows.Count == 0)
                    {
                        sql = "insert into NCRL_SP..PrjAttendanceDetail (Id,ProjectAttendanceId,UserId,UserName,Year,Month," + Request["day"] + ") values('" + Guid.NewGuid() + "','" + paEnt.Id + "','" + Request["UserId"] + "','" + Request["UserName"] + "','" + paEnt.Year + "','" + paEnt.Month + "','" + Request["SignType"] + "')";
                    }
                    else
                    {
                        //如果先前同一个字段标记的是正常上班，再次点正常上班时，清空该字段
                        if (dt.Rows[0][Request["day"]] + "" == Request["SignType"])
                        {
                            sql = "update NCRL_SP..PrjAttendanceDetail set " + Request["day"] + "=null where Id='" + dt.Rows[0]["Id"] + "'";
                            result = "";
                        }
                        else
                        {
                            sql = "update NCRL_SP..PrjAttendanceDetail set " + Request["day"] + "='" + Request["SignType"] + "' where Id='" + dt.Rows[0]["Id"] + "'";
                            result = Request["SignType"];
                        }
                    }
                    DataHelper.ExecSql(sql);
                    //插入考勤日志,为生成人员月度考勤提供基础数据
                    sql = "insert into NCRL_SP..AttendanceLog (Id,ProjectAttendanceId,UserId,UserName,Field,AttendanceType,CreateId,CreateName,CreateTime) values ('{0}','{1}','{2}','{3}','{4}','{5}','{6}','{7}',GETDATE()) ";
                    sql = string.Format(sql, Guid.NewGuid(), paEnt.Id, Request["UserId"], Request["UserName"], Request["day"], result, Aim.Portal.PortalService.CurrentUserInfo.UserID, Aim.Portal.PortalService.CurrentUserInfo.Name);
                    DataHelper.ExecSql(sql);

                    Response.Write("{success:true,result:'" + result + "'}");
                    Response.End();
                    break;
                case "delete":
                    sql = "delete NCRL_SP..ProjectAttendanceDetail where UserId='{0}' and ProjectAttendanceId='{1}' ";
                    sql = string.Format(sql, userid, id);
                    DataHelper.ExecSql(sql);
                    puEnts = ProjectUser.FindAllByProperties(ProjectUser.Prop_UserId, userid, ProjectUser.Prop_ProjectId, paEnt.ProjectId);
                    if (puEnts.Count > 0)
                    {
                        puEnts[0].DoDelete();
                    }
                    break;
                case "updateprojectuser":
                    puEnts = ProjectUser.FindAllByProperties(ProjectUser.Prop_UserId, userid, ProjectUser.Prop_ProjectId, paEnt.ProjectId);
                    if (puEnts.Count == 0)
                    {
                        ProjectUser puEnt = new ProjectUser();
                        puEnt.UserId = userid;
                        puEnt.UserName = Request["username"];
                        puEnt.ProjectId = paEnt.ProjectId;
                        puEnt.DoCreate();
                    }
                    break;
            }
        }
    }
}