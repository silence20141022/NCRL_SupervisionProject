// Business class ShenChaReport generated from ShenChaReport
// Creator: Ray
// Created Date: [2014-08-07]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;

namespace SP.Model
{
    [ActiveRecord("ShenChaReport")]
    public partial class ShenChaReport : SPModelBase<ShenChaReport>
    {
        #region Property_Names

        public static string Prop_Id = "Id";
        public static string Prop_ProjectId = "ProjectId";
        public static string Prop_ShenChaNo = "ShenChaNo";
        public static string Prop_Opinion1 = "Opinion1";
        public static string Prop_Opinion1ShenChaName = "Opinion1ShenChaName";
        public static string Prop_Opinion1CreateTime = "Opinion1CreateTime";
        public static string Prop_Opinion2 = "Opinion2";
        public static string Prop_Opinion2ShenChaName = "Opinion2ShenChaName";
        public static string Prop_Opinion2CreateTime = "Opinion2CreateTime";
        public static string Prop_Opinion3 = "Opinion3";
        public static string Prop_Opinion3ShenChaName = "Opinion3ShenChaName";
        public static string Prop_Opinion3CreateTime = "Opinion3CreateTime";
        public static string Prop_Opinion4 = "Opinion4";
        public static string Prop_Opinion4ShenChaName = "Opinion4ShenChaName";
        public static string Prop_Opinion4CreateTime = "Opinion4CreateTime";
        public static string Prop_Opinion5 = "Opinion5";
        public static string Prop_Opinion5ShenChaName = "Opinion5ShenChaName";
        public static string Prop_Opinion5CreateTime = "Opinion5CreateTime";
        public static string Prop_Opinion6 = "Opinion6";
        public static string Prop_Opinion6ShenChaName = "Opinion6ShenChaName";
        public static string Prop_Opinion6CreateTime = "Opinion6CreateTime";
        public static string Prop_FuZeName = "FuZeName";
        public static string Prop_Opinion7 = "Opinion7";
        public static string Prop_Opinion7ShenChaName = "Opinion7ShenChaName";
        public static string Prop_Opinion7CreateTime = "Opinion7CreateTime";
        public static string Prop_ReportSubmitTime = "ReportSubmitTime";
        public static string Prop_CreateId = "CreateId";
        public static string Prop_CreateName = "CreateName";
        public static string Prop_CreateTime = "CreateTime";

        #endregion

        #region Private_Variables

        private string _id;
        private string _projectId;
        private string _shenChaNo;
        private string _opinion1;
        private string _opinion1ShenChaName;
        private DateTime? _opinion1CreateTime;
        private string _opinion2;
        private string _opinion2ShenChaName;
        private DateTime? _opinion2CreateTime;
        private string _opinion3;
        private string _opinion3ShenChaName;
        private DateTime? _opinion3CreateTime;
        private string _opinion4;
        private string _opinion4ShenChaName;
        private DateTime? _opinion4CreateTime;
        private string _opinion5;
        private string _opinion5ShenChaName;
        private DateTime? _opinion5CreateTime;
        private string _opinion6;
        private string _opinion6ShenChaName;
        private DateTime? _opinion6CreateTime;
        private string _fuZeName;
        private string _opinion7;
        private string _opinion7ShenChaName;
        private DateTime? _opinion7CreateTime;
        private DateTime? _reportSubmitTime;
        private string _createId;
        private string _createName;
        private DateTime? _createTime;


        #endregion

        #region Constructors

        public ShenChaReport()
        {
        }

        public ShenChaReport(
            string p_id,
            string p_projectId,
            string p_shenChaNo,
            string p_opinion1,
            string p_opinion1ShenChaName,
            DateTime? p_opinion1CreateTime,
            string p_opinion2,
            string p_opinion2ShenChaName,
            DateTime? p_opinion2CreateTime,
            string p_opinion3,
            string p_opinion3ShenChaName,
            DateTime? p_opinion3CreateTime,
            string p_opinion4,
            string p_opinion4ShenChaName,
            DateTime? p_opinion4CreateTime,
            string p_opinion5,
            string p_opinion5ShenChaName,
            DateTime? p_opinion5CreateTime,
            string p_opinion6,
            string p_opinion6ShenChaName,
            DateTime? p_opinion6CreateTime,
            string p_fuZeName,
            string p_opinion7,
            string p_opinion7ShenChaName,
            DateTime? p_opinion7CreateTime,
            DateTime? p_reportSubmitTime,
            string p_createId,
            string p_createName,
            DateTime? p_createTime)
        {
            _id = p_id;
            _projectId = p_projectId;
            _shenChaNo = p_shenChaNo;
            _opinion1 = p_opinion1;
            _opinion1ShenChaName = p_opinion1ShenChaName;
            _opinion1CreateTime = p_opinion1CreateTime;
            _opinion2 = p_opinion2;
            _opinion2ShenChaName = p_opinion2ShenChaName;
            _opinion2CreateTime = p_opinion2CreateTime;
            _opinion3 = p_opinion3;
            _opinion3ShenChaName = p_opinion3ShenChaName;
            _opinion3CreateTime = p_opinion3CreateTime;
            _opinion4 = p_opinion4;
            _opinion4ShenChaName = p_opinion4ShenChaName;
            _opinion4CreateTime = p_opinion4CreateTime;
            _opinion5 = p_opinion5;
            _opinion5ShenChaName = p_opinion5ShenChaName;
            _opinion5CreateTime = p_opinion5CreateTime;
            _opinion6 = p_opinion6;
            _opinion6ShenChaName = p_opinion6ShenChaName;
            _opinion6CreateTime = p_opinion6CreateTime;
            _fuZeName = p_fuZeName;
            _opinion7 = p_opinion7;
            _opinion7ShenChaName = p_opinion7ShenChaName;
            _opinion7CreateTime = p_opinion7CreateTime;
            _reportSubmitTime = p_reportSubmitTime;
            _createId = p_createId;
            _createName = p_createName;
            _createTime = p_createTime;
        }

        #endregion

        #region Properties

        [PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
        public string Id
        {
            get { return _id; }
            set { _id = value; } // 处理列表编辑时去掉注释

        }

        [Property("ProjectId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string ProjectId
        {
            get { return _projectId; }
            set
            {
                if ((_projectId == null) || (value == null) || (!value.Equals(_projectId)))
                {
                    object oldValue = _projectId;
                    _projectId = value;
                    RaisePropertyChanged(ShenChaReport.Prop_ProjectId, oldValue, value);
                }
            }

        }

        [Property("ShenChaNo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string ShenChaNo
        {
            get { return _shenChaNo; }
            set
            {
                if ((_shenChaNo == null) || (value == null) || (!value.Equals(_shenChaNo)))
                {
                    object oldValue = _shenChaNo;
                    _shenChaNo = value;
                    RaisePropertyChanged(ShenChaReport.Prop_ShenChaNo, oldValue, value);
                }
            }

        }

        [Property("Opinion1", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string Opinion1
        {
            get { return _opinion1; }
            set
            {
                if ((_opinion1 == null) || (value == null) || (!value.Equals(_opinion1)))
                {
                    object oldValue = _opinion1;
                    _opinion1 = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion1, oldValue, value);
                }
            }

        }

        [Property("Opinion1ShenChaName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string Opinion1ShenChaName
        {
            get { return _opinion1ShenChaName; }
            set
            {
                if ((_opinion1ShenChaName == null) || (value == null) || (!value.Equals(_opinion1ShenChaName)))
                {
                    object oldValue = _opinion1ShenChaName;
                    _opinion1ShenChaName = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion1ShenChaName, oldValue, value);
                }
            }

        }

        [Property("Opinion1CreateTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? Opinion1CreateTime
        {
            get { return _opinion1CreateTime; }
            set
            {
                if (value != _opinion1CreateTime)
                {
                    object oldValue = _opinion1CreateTime;
                    _opinion1CreateTime = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion1CreateTime, oldValue, value);
                }
            }

        }

        [Property("Opinion2", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string Opinion2
        {
            get { return _opinion2; }
            set
            {
                if ((_opinion2 == null) || (value == null) || (!value.Equals(_opinion2)))
                {
                    object oldValue = _opinion2;
                    _opinion2 = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion2, oldValue, value);
                }
            }

        }

        [Property("Opinion2ShenChaName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string Opinion2ShenChaName
        {
            get { return _opinion2ShenChaName; }
            set
            {
                if ((_opinion2ShenChaName == null) || (value == null) || (!value.Equals(_opinion2ShenChaName)))
                {
                    object oldValue = _opinion2ShenChaName;
                    _opinion2ShenChaName = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion2ShenChaName, oldValue, value);
                }
            }

        }

        [Property("Opinion2CreateTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? Opinion2CreateTime
        {
            get { return _opinion2CreateTime; }
            set
            {
                if (value != _opinion2CreateTime)
                {
                    object oldValue = _opinion2CreateTime;
                    _opinion2CreateTime = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion2CreateTime, oldValue, value);
                }
            }

        }

        [Property("Opinion3", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string Opinion3
        {
            get { return _opinion3; }
            set
            {
                if ((_opinion3 == null) || (value == null) || (!value.Equals(_opinion3)))
                {
                    object oldValue = _opinion3;
                    _opinion3 = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion3, oldValue, value);
                }
            }

        }

        [Property("Opinion3ShenChaName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string Opinion3ShenChaName
        {
            get { return _opinion3ShenChaName; }
            set
            {
                if ((_opinion3ShenChaName == null) || (value == null) || (!value.Equals(_opinion3ShenChaName)))
                {
                    object oldValue = _opinion3ShenChaName;
                    _opinion3ShenChaName = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion3ShenChaName, oldValue, value);
                }
            }

        }

        [Property("Opinion3CreateTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? Opinion3CreateTime
        {
            get { return _opinion3CreateTime; }
            set
            {
                if (value != _opinion3CreateTime)
                {
                    object oldValue = _opinion3CreateTime;
                    _opinion3CreateTime = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion3CreateTime, oldValue, value);
                }
            }

        }

        [Property("Opinion4", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string Opinion4
        {
            get { return _opinion4; }
            set
            {
                if ((_opinion4 == null) || (value == null) || (!value.Equals(_opinion4)))
                {
                    object oldValue = _opinion4;
                    _opinion4 = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion4, oldValue, value);
                }
            }

        }

        [Property("Opinion4ShenChaName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string Opinion4ShenChaName
        {
            get { return _opinion4ShenChaName; }
            set
            {
                if ((_opinion4ShenChaName == null) || (value == null) || (!value.Equals(_opinion4ShenChaName)))
                {
                    object oldValue = _opinion4ShenChaName;
                    _opinion4ShenChaName = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion4ShenChaName, oldValue, value);
                }
            }

        }

        [Property("Opinion4CreateTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? Opinion4CreateTime
        {
            get { return _opinion4CreateTime; }
            set
            {
                if (value != _opinion4CreateTime)
                {
                    object oldValue = _opinion4CreateTime;
                    _opinion4CreateTime = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion4CreateTime, oldValue, value);
                }
            }

        }

        [Property("Opinion5", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string Opinion5
        {
            get { return _opinion5; }
            set
            {
                if ((_opinion5 == null) || (value == null) || (!value.Equals(_opinion5)))
                {
                    object oldValue = _opinion5;
                    _opinion5 = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion5, oldValue, value);
                }
            }

        }

        [Property("Opinion5ShenChaName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string Opinion5ShenChaName
        {
            get { return _opinion5ShenChaName; }
            set
            {
                if ((_opinion5ShenChaName == null) || (value == null) || (!value.Equals(_opinion5ShenChaName)))
                {
                    object oldValue = _opinion5ShenChaName;
                    _opinion5ShenChaName = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion5ShenChaName, oldValue, value);
                }
            }

        }

        [Property("Opinion5CreateTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? Opinion5CreateTime
        {
            get { return _opinion5CreateTime; }
            set
            {
                if (value != _opinion5CreateTime)
                {
                    object oldValue = _opinion5CreateTime;
                    _opinion5CreateTime = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion5CreateTime, oldValue, value);
                }
            }

        }

        [Property("Opinion6", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string Opinion6
        {
            get { return _opinion6; }
            set
            {
                if ((_opinion6 == null) || (value == null) || (!value.Equals(_opinion6)))
                {
                    object oldValue = _opinion6;
                    _opinion6 = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion6, oldValue, value);
                }
            }

        }

        [Property("Opinion6ShenChaName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string Opinion6ShenChaName
        {
            get { return _opinion6ShenChaName; }
            set
            {
                if ((_opinion6ShenChaName == null) || (value == null) || (!value.Equals(_opinion6ShenChaName)))
                {
                    object oldValue = _opinion6ShenChaName;
                    _opinion6ShenChaName = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion6ShenChaName, oldValue, value);
                }
            }

        }

        [Property("Opinion6CreateTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? Opinion6CreateTime
        {
            get { return _opinion6CreateTime; }
            set
            {
                if (value != _opinion6CreateTime)
                {
                    object oldValue = _opinion6CreateTime;
                    _opinion6CreateTime = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion6CreateTime, oldValue, value);
                }
            }

        }

        [Property("FuZeName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string FuZeName
        {
            get { return _fuZeName; }
            set
            {
                if ((_fuZeName == null) || (value == null) || (!value.Equals(_fuZeName)))
                {
                    object oldValue = _fuZeName;
                    _fuZeName = value;
                    RaisePropertyChanged(ShenChaReport.Prop_FuZeName, oldValue, value);
                }
            }

        }

        [Property("Opinion7", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
        public string Opinion7
        {
            get { return _opinion7; }
            set
            {
                if ((_opinion7 == null) || (value == null) || (!value.Equals(_opinion7)))
                {
                    object oldValue = _opinion7;
                    _opinion7 = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion7, oldValue, value);
                }
            }

        }

        [Property("Opinion7ShenChaName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string Opinion7ShenChaName
        {
            get { return _opinion7ShenChaName; }
            set
            {
                if ((_opinion7ShenChaName == null) || (value == null) || (!value.Equals(_opinion7ShenChaName)))
                {
                    object oldValue = _opinion7ShenChaName;
                    _opinion7ShenChaName = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion7ShenChaName, oldValue, value);
                }
            }

        }

        [Property("Opinion7CreateTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? Opinion7CreateTime
        {
            get { return _opinion7CreateTime; }
            set
            {
                if (value != _opinion7CreateTime)
                {
                    object oldValue = _opinion7CreateTime;
                    _opinion7CreateTime = value;
                    RaisePropertyChanged(ShenChaReport.Prop_Opinion7CreateTime, oldValue, value);
                }
            }

        }

        [Property("ReportSubmitTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? ReportSubmitTime
        {
            get { return _reportSubmitTime; }
            set
            {
                if (value != _reportSubmitTime)
                {
                    object oldValue = _reportSubmitTime;
                    _reportSubmitTime = value;
                    RaisePropertyChanged(ShenChaReport.Prop_ReportSubmitTime, oldValue, value);
                }
            }

        }

        [Property("CreateId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string CreateId
        {
            get { return _createId; }
            set
            {
                if ((_createId == null) || (value == null) || (!value.Equals(_createId)))
                {
                    object oldValue = _createId;
                    _createId = value;
                    RaisePropertyChanged(ShenChaReport.Prop_CreateId, oldValue, value);
                }
            }

        }

        [Property("CreateName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string CreateName
        {
            get { return _createName; }
            set
            {
                if ((_createName == null) || (value == null) || (!value.Equals(_createName)))
                {
                    object oldValue = _createName;
                    _createName = value;
                    RaisePropertyChanged(ShenChaReport.Prop_CreateName, oldValue, value);
                }
            }

        }

        [Property("CreateTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? CreateTime
        {
            get { return _createTime; }
            set
            {
                if (value != _createTime)
                {
                    object oldValue = _createTime;
                    _createTime = value;
                    RaisePropertyChanged(ShenChaReport.Prop_CreateTime, oldValue, value);
                }
            }

        }

        #endregion
    } // ShenChaReport
}

