using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SP.Model;
using Aim;
using Aim.Data;

namespace SP.Web.ConsultationManage
{
    public partial class ChouJinPrint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string choujinid = Request["choujinid"];
            string sql = @"select Id ,UserName,(select top 1 AdjustAmount from NCRL_SP..ChouJinResult where ExpertId=a.Id and ChouJinId='{0}') AdjustAmount
                         from NCRL_SP..Expert a  Order by SortIndex asc";
            sql = string.Format(sql, choujinid);
            ChouJin ent = ChouJin.Find(choujinid);
            lbTitle.InnerText = ent.BelongYear + "年" + ent.BelongMonth + "月份专家酬金";
            IList<EasyDictionary> dics = DataHelper.QueryDictList(sql);
            lt.Text = "";
            int rows = (dics.Count % 2 == 0 ? dics.Count : (dics.Count + 1)) / 2;
            int j = rows + 1;
            for (int i = 0; i < rows; i++)
            {
                if (dics.Count % 2 == 0)
                {
                    lt.Text += "<tr><td>" + (i + 1) + "</td><td>" + dics[i].Get<string>("UserName") + "</td><td>" + dics[i].Get<string>("AdjustAmount") + "</td><td>" + (rows + i + 1) + "</td><td>" + dics[rows + i].Get<string>("UserName") + "</td><td>" + dics[rows + i].Get<string>("AdjustAmount") + "</td></tr>";
                }
                else
                {
                    if (i != rows - 1)
                    {
                        lt.Text += "<tr><td>" + (i + 1) + "</td><td>" + dics[i].Get<string>("UserName") + "</td><td>" + dics[i].Get<string>("AdjustAmount") + "</td><td>" + (rows + i + 1) + "</td><td>" + dics[rows + i].Get<string>("UserName") + "</td><td>" + dics[rows + i].Get<string>("AdjustAmount") + "</td></tr>";
                    }
                    else
                    {
                        lt.Text += "<tr><td>" + (i + 1) + "</td><td>" + dics[i].Get<string>("UserName") + "</td><td>" + dics[i].Get<string>("AdjustAmount") + "</td><td>" + (rows + i + 1) + "</td><td></td><td></td></tr>";
                    }
                }
            }
            sql = "select sum(AdjustAmount) from  NCRL_SP..ChouJinResult where ChouJinId='" + choujinid + "'";
            lt.Text += "<tr><td></td><td></td><td></td><td></td><td>合计：</td><td>" + DataHelper.QueryValue(sql) + "</td></tr>";
        }
    }
}