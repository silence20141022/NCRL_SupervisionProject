using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Aim;
using Aim.Data;
using SP.Model;

namespace SP.Web.ConsultationManage
{
    public partial class ShenChaReport_FWJZ_Print : System.Web.UI.Page
    {
        string sql = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            string action = Request["action"];
            switch (action)
            {
                case "select":
                    Select();
                    break;
            }
        }
        private void Select()
        {
            string Id = Request["Id"];
            if (!string.IsNullOrEmpty(Id))
            {
                sql = @"select 
                P.ProjectName as ProjectName,P.Investment as Investment,P.DetailLocation as DetailLocation,P.EngineeringLevel as EngineeringLevel,P.Height as Height,P.UpperLayers as UpperLayers,P.BuildingArea as BuildingArea,P.JianSheUnit as JianSheUnit,P.JianSheUnitHead as JianSheUnitHead,P.KanChaUnit as KanChaUnit,P.KanChaUnitHead as KanChaUnitHead,P.KanChaZZLevel as KanChaZZLevel,P.KanChaUnitZSNo as KanChaUnitZSNo, P.SheJiUnit as SheJiUnit, P.SheJiUnitHead as SheJiUnitHead, P.SheJiUnitGrade as SheJiUnitGrade, P.SheJiUnitZSNo as SheJiUnitZSNo, P.IfChaoGao as IfChaoGao,P.DownLayers as DownLayers,P.GongChenLiang as GongChenLiang,
                S.Id as Id, S.ShenChaNo as ShenChaNo,S.ProjectId as ProjectId,
                S.Opinion1 as Opinion1, S.Opinion1ShenChaName as Opinion1ShenChaName,S.Opinion1CreateTime as Opinion1CreateTime, 
                S.Opinion2 as Opinion2, S.Opinion2ShenChaName as Opinion2ShenChaName,S.Opinion2CreateTime as Opinion2CreateTime, 
                S.Opinion3 as Opinion3, S.Opinion3ShenChaName as Opinion3ShenChaName,S.Opinion3CreateTime as Opinion3CreateTime, 
                S.Opinion4 as Opinion4, S.Opinion4ShenChaName as Opinion4ShenChaName,S.Opinion4CreateTime as Opinion4CreateTime, 
                S.Opinion5 as Opinion5, S.Opinion5ShenChaName as Opinion5ShenChaName,S.Opinion5CreateTime as Opinion5CreateTime, 
                S.Opinion6 as Opinion6, S.Opinion6ShenChaName as Opinion6ShenChaName,S.Opinion6CreateTime as Opinion6CreateTime, 
                S.Opinion7 as Opinion7, S.Opinion7ShenChaName as Opinion7ShenChaName,S.Opinion7CreateTime as Opinion7CreateTime 
                from NCRL_SP..Project as P left join NCRL_SP..ShenChaReport as S on P.ID =S.ProjectId  where S.Id='" + Id + "'";
                DataTable dt = DataHelper.QueryDataTable(sql);
                string str = JsonHelper.GetJsonString(dt);
                // string s = JsonHelper.GetJsonString(ShenChaReport.Find(Id));
                str = str.Replace("[", "").Replace("]", "");
                Response.Write(str);
                Response.End();
            }
        }
    }
}