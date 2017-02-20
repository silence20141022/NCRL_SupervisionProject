using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WinForm_SP
{
    public partial class Form1 : Form
    {
        bool working = false;
        bool working2 = false;
        bool working3 = false;
        bool working4 = false;
        DataTable dt_tmp;
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.timer1.Enabled = true;
            this.button1.Text = "运行中....";
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if (!working)
            {
                working = true;
                string sql = @"select top 100 * from ProjectAttendanceDetail where Description is null and ProjectAttendanceId in (
                select Id from ProjectAttendance)";
                DataTable dt = SqlHelper.GetDataTable(sql);
                foreach (DataRow dr in dt.Rows)
                {
                    string result = dr["AttendanceType"] + "";
                    if (result == "正常上班")
                    {
                        result = "√";
                    }
                    if (result == "其他")
                    {
                        result = "×";
                    }
                    if (result == "请假")
                    {
                        result = "!";
                    }
                    DataTable dt_pa = SqlHelper.GetDataTable("select * from ProjectAttendance where Id='" + dr["ProjectAttendanceId"] + "'");
                    //写入项目考勤新表
                    sql = "select * from PrjAttendanceDetail where ProjectAttendanceId='" + dr["ProjectAttendanceId"] + "' and UserId='" + dr["UserId"] + "'";
                    dt_tmp = SqlHelper.GetDataTable(sql);
                    if (dt_tmp.Rows.Count > 0)
                    {
                        sql = "update PrjAttendanceDetail set Date" + Convert.ToDateTime(dr["AttendanceDate"]).Day + "='" + result + "' where Id='" + dt_tmp.Rows[0]["Id"] + "'";
                    }
                    else
                    {
                        sql = "insert into PrjAttendanceDetail (Id,ProjectAttendanceId,UserId,UserName,Year,Month,Date" + Convert.ToDateTime(dr["AttendanceDate"]).Day + ") values('" + Guid.NewGuid() + "','" + dr["ProjectAttendanceId"] + "','" + dr["UserId"] + "','" + dr["UserName"] + "','" + dt_pa.Rows[0]["Year"] + "','" + dt_pa.Rows[0]["Month"] + "','" + result + "')";
                    }
                    SqlHelper.ExecuteNonQuery(sql);
                    //更新人员月度考勤
                    sql = "select * from MonAttendance where Year='" + dt_pa.Rows[0]["Year"] + "' and Month='" + dt_pa.Rows[0]["Month"] + "' and UserId='" + dr["UserId"] + "'";
                    DataTable dt_month = SqlHelper.GetDataTable(sql);
                    if (dt_month.Rows.Count > 0)
                    {
                        if ((dt_month.Rows[0]["ProjectIds"] + "").IndexOf(dt_pa.Rows[0]["ProjectId"] + "") >= 0)
                        {
                            sql = "update MonAttendance set Date" + Convert.ToDateTime(dr["AttendanceDate"]).Day + "='" + result + "' where Id='" + dt_month.Rows[0]["Id"] + "'";
                        }
                        else
                        {
                            string prjids = string.IsNullOrEmpty(dt_month.Rows[0]["ProjectIds"] + "") ? (dt_pa.Rows[0]["ProjectId"] + "") : (dt_month.Rows[0]["ProjectIds"] + "," + dt_pa.Rows[0]["ProjectId"]);
                            string prjnames = string.IsNullOrEmpty(dt_month.Rows[0]["ProjectNames"] + "") ? (dt_pa.Rows[0]["ProjectName"] + "") : (dt_month.Rows[0]["ProjectNames"] + "," + dt_pa.Rows[0]["ProjectName"]);
                            sql = "update MonAttendance set ProjectIds='" + prjids + "',ProjectNames='" + prjnames + "', Date" + Convert.ToDateTime(dr["AttendanceDate"]).Day + "='" + result + "' where Id='" + dt_month.Rows[0]["Id"] + "'";
                        }
                    }
                    else
                    {
                        sql = "insert into MonAttendance (Id,ProjectIds,ProjectNames,UserId,UserName,Year,Month,Date" + Convert.ToDateTime(dr["AttendanceDate"]).Day + ") values('" + Guid.NewGuid() + "','" + dt_pa.Rows[0]["ProjectId"] + "','" + dt_pa.Rows[0]["ProjectName"] + "','" + dr["UserId"] + "','" + dr["UserName"] + "','" + dt_pa.Rows[0]["Year"] + "','" + dt_pa.Rows[0]["Month"] + "','" + result + "')";
                    }
                    SqlHelper.ExecuteNonQuery(sql);


                    sql = "update ProjectAttendanceDetail set Description='1' where Id='" + dr["Id"] + "'";
                    SqlHelper.ExecuteNonQuery(sql);
                }
                working = false;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.timer2.Enabled = true;
            this.button2.Text = "运行中....";
        }

        private void timer2_Tick(object sender, EventArgs e)
        {
            if (!working2)
            {
                working2 = true;
                string sql = "select * from AttendanceLog where Sync is null order by CreateTime asc";//未同步的项目考勤日志
                DataTable dt = SqlHelper.GetDataTable(sql);
                if (dt.Rows.Count > 0)
                {
                    DataTable dt_pa = null;
                    DataTable dt_ma = null;
                    foreach (DataRow dr in dt.Rows)
                    {
                        dt_pa = SqlHelper.GetDataTable("select * from ProjectAttendance where Id='" + dr["ProjectAttendanceId"] + "'");
                        sql = @"select * from MonAttendance where UserId='" + dr["UserId"] + "' and Year='" + dt_pa.Rows[0]["Year"] + "' and Month='" + dt_pa.Rows[0]["Month"] + "'";
                        dt_ma = SqlHelper.GetDataTable(sql);
                        if (dt_ma.Rows.Count == 0)
                        {
                            sql = "insert into MonAttendance (Id,UserId,UserName,Year,Month," + dr["Field"] + ") values('" + Guid.NewGuid() + "','" + dr["UserId"] + "','" + dr["UserName"] + "','" + dt_pa.Rows[0]["Year"] + "','" + dt_pa.Rows[0]["Month"] + "','" + dr["AttendanceType"] + "')";
                            SqlHelper.ExecuteNonQuery(sql);
                        }
                        else
                        {
                            //项目信息
                            string projectids = "";
                            string projectnames = "";
                            if ((dt_ma.Rows[0]["ProjectIds"] + "").IndexOf(dt_pa.Rows[0]["ProjectId"] + "") >= 0)
                            {
                                projectids = dt_ma.Rows[0]["ProjectIds"] + "";
                                projectnames = dt_ma.Rows[0]["ProjectNames"] + "";
                            }
                            else
                            {
                                projectids = string.IsNullOrEmpty(dt_ma.Rows[0]["ProjectIds"] + "") ? (dt_pa.Rows[0]["ProjectId"] + "") : (dt_ma.Rows[0]["ProjectIds"] + "," + dt_pa.Rows[0]["ProjectId"]);
                                projectnames = string.IsNullOrEmpty(dt_ma.Rows[0]["ProjectIds"] + "") ? (dt_pa.Rows[0]["ProjectName"] + "") : (dt_ma.Rows[0]["ProjectNames"] + "," + dt_pa.Rows[0]["ProjectName"]);
                            }
                            //如果该人员在其他项目当天的考勤为正常上班则不予以更新
                            sql = "select * from PrjAttendanceDetail where ProjectAttendanceId!='{0}' and UserId='{1}' and Year='{2}' and Month='{3}' ";
                            sql = string.Format(sql, dr["ProjectAttendanceId"], dr["UserId"], dt_pa.Rows[0]["Year"], dt_pa.Rows[0]["Month"]);
                            DataTable dt_opa = SqlHelper.GetDataTable(sql);
                            if (dt_opa.Rows.Count > 0)
                            {
                                if (dt_opa.Rows[0][dr["Field"] + ""] + "" != "√")
                                {
                                    sql = "update MonAttendance set " + dr["Field"] + "='" + dr["AttendanceType"] + "',ProjectIds='" + projectids + "',ProjectNames='" + projectnames + "' where Id='" + dt.Rows[0]["Id"] + "'";
                                    SqlHelper.ExecuteNonQuery(sql);
                                }
                            }
                            else
                            {
                                sql = "update MonAttendance set " + dr["Field"] + "='" + dr["AttendanceType"] + "',ProjectIds='" + projectids + "',ProjectNames='" + projectnames + "' where Id='" + dt_ma.Rows[0]["Id"] + "'";
                                SqlHelper.ExecuteNonQuery(sql);
                            }
                        }
                        sql = "update AttendanceLog set Sync=1 where Id='" + dr["Id"] + "'";//未同步的项目考勤日志
                        SqlHelper.ExecuteNonQuery(sql);
                    }
                }
                working2 = false;
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.timer3.Enabled = true;
            this.button3.Text = "运行中....";
        }

        private void timer3_Tick(object sender, EventArgs e)
        {
            if (!working3)
            {
                working3 = true;
                DateTime datetime = DateTime.Now;
                string sql = "select * from NCRL_Portal..SysGroup where ParentId='228'";
                DataTable dt = SqlHelper.GetDataTable(sql);
                foreach (DataRow dr in dt.Rows)
                {
                    if (dr["GroupID"] + "" != "231" && dr["GroupID"] + "" != "232" && dr["GroupID"] + "" != "852")
                    {
                        sql = "select * from DeptAttendance where Year='{0}' and Month='{1}' and BelongDeptId='{2}'";
                        sql = string.Format(sql, datetime.Year, datetime.Month, dr["GroupID"]);
                        DataTable dt_da = SqlHelper.GetDataTable(sql);
                        if (dt_da.Rows.Count == 0)
                        {
                            sql = "insert into DeptAttendance (Id,Year,Month,BelongDeptId,BelongDeptName,CreateTime) values ('{0}','{1}','{2}','{3}','{4}',GETDATE())";
                            sql = string.Format(sql, Guid.NewGuid(), datetime.Year, datetime.Month, dr["GroupID"], (dr["Name"] + "").Replace("江西瑞林建设监理有限公司", ""));
                            SqlHelper.ExecuteNonQuery(sql);
                        }
                    }
                }
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            this.timer4.Enabled = true;
            this.button4.Text = "运行中....";
        }

        private void timer4_Tick(object sender, EventArgs e)
        {
            if (!working4)
            {
                working4 = true;
                string sql = @"select top 100 * from ProjectAttendanceDetail where Description is null and ProjectAttendanceId in (
                select Id from DeptAttendance)";
                DataTable dt = SqlHelper.GetDataTable(sql);
                foreach (DataRow dr in dt.Rows)
                {
                    string result = dr["AttendanceType"] + "";
                    if (result == "正常上班")
                    {
                        result = "√";
                    }
                    if (result == "其他")
                    {
                        result = "×";
                    }
                    if (result == "请假")
                    {
                        result = "!";
                    }
                    DataTable dt_da = SqlHelper.GetDataTable("select * from DeptAttendance where Id='" + dr["ProjectAttendanceId"] + "'");
                    //更新人员月度考勤
                    sql = "select * from MonAttendance where Year='" + dt_da.Rows[0]["Year"] + "' and Month='" + dt_da.Rows[0]["Month"] + "' and UserId='" + dr["UserId"] + "'";
                    DataTable dt_month = SqlHelper.GetDataTable(sql);
                    if (dt_month.Rows.Count > 0)
                    {
                        sql = "update MonAttendance set Date" + Convert.ToDateTime(dr["AttendanceDate"]).Day + "='" + result + "' where Id='" + dt_month.Rows[0]["Id"] + "'";
                    }
                    else
                    {
                        sql = "insert into MonAttendance (Id,UserId,UserName,Year,Month,Date" + Convert.ToDateTime(dr["AttendanceDate"]).Day + ") values('" + Guid.NewGuid() + "','" + dr["UserId"] + "','" + dr["UserName"] + "','" + dt_da.Rows[0]["Year"] + "','" + dt_da.Rows[0]["Month"] + "','" + result + "')";
                    }
                    SqlHelper.ExecuteNonQuery(sql);
                    sql = "update ProjectAttendanceDetail set Description='1' where Id='" + dr["Id"] + "'";
                    SqlHelper.ExecuteNonQuery(sql);
                    working4 = false;
                }
            }
        }
    }
}
