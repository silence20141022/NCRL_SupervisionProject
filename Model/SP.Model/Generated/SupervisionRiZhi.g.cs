// Business class SupervisionRiZhi generated from SupervisionRiZhi
// Creator: Ray
// Created Date: [2014-04-15]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("SupervisionRiZhi")]
    public partial class SupervisionRiZhi : SPModelBase<SupervisionRiZhi>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectId = "ProjectId";
		public static string Prop_ProjectName = "ProjectName";
		public static string Prop_PManagerId = "PManagerId";
		public static string Prop_PManagerName = "PManagerName";
		public static string Prop_ShiGongUnit = "ShiGongUnit";
		public static string Prop_Weather = "Weather";
		public static string Prop_SupervisionDate = "SupervisionDate";
		public static string Prop_WorkRecord = "WorkRecord";
		public static string Prop_SafetySupervision = "SafetySupervision";
		public static string Prop_NextArrange = "NextArrange";
		public static string Prop_PManagerOpinion = "PManagerOpinion";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _projectId;
		private string _projectName;
		private string _pManagerId;
		private string _pManagerName;
		private string _shiGongUnit;
		private string _weather;
		private DateTime? _supervisionDate;
		private string _workRecord;
		private string _safetySupervision;
		private string _nextArrange;
		private string _pManagerOpinion;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public SupervisionRiZhi()
		{
		}

		public SupervisionRiZhi(
			string p_id,
			string p_projectId,
			string p_projectName,
			string p_pManagerId,
			string p_pManagerName,
			string p_shiGongUnit,
			string p_weather,
			DateTime? p_supervisionDate,
			string p_workRecord,
			string p_safetySupervision,
			string p_nextArrange,
			string p_pManagerOpinion,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_projectId = p_projectId;
			_projectName = p_projectName;
			_pManagerId = p_pManagerId;
			_pManagerName = p_pManagerName;
			_shiGongUnit = p_shiGongUnit;
			_weather = p_weather;
			_supervisionDate = p_supervisionDate;
			_workRecord = p_workRecord;
			_safetySupervision = p_safetySupervision;
			_nextArrange = p_nextArrange;
			_pManagerOpinion = p_pManagerOpinion;
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
			// set { _id = value; } // 处理列表编辑时去掉注释

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
					RaisePropertyChanged(SupervisionRiZhi.Prop_ProjectId, oldValue, value);
				}
			}

		}

		[Property("ProjectName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string ProjectName
		{
			get { return _projectName; }
			set
			{
				if ((_projectName == null) || (value == null) || (!value.Equals(_projectName)))
				{
                    object oldValue = _projectName;
					_projectName = value;
					RaisePropertyChanged(SupervisionRiZhi.Prop_ProjectName, oldValue, value);
				}
			}

		}

		[Property("PManagerId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string PManagerId
		{
			get { return _pManagerId; }
			set
			{
				if ((_pManagerId == null) || (value == null) || (!value.Equals(_pManagerId)))
				{
                    object oldValue = _pManagerId;
					_pManagerId = value;
					RaisePropertyChanged(SupervisionRiZhi.Prop_PManagerId, oldValue, value);
				}
			}

		}

		[Property("PManagerName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string PManagerName
		{
			get { return _pManagerName; }
			set
			{
				if ((_pManagerName == null) || (value == null) || (!value.Equals(_pManagerName)))
				{
                    object oldValue = _pManagerName;
					_pManagerName = value;
					RaisePropertyChanged(SupervisionRiZhi.Prop_PManagerName, oldValue, value);
				}
			}

		}

		[Property("ShiGongUnit", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string ShiGongUnit
		{
			get { return _shiGongUnit; }
			set
			{
				if ((_shiGongUnit == null) || (value == null) || (!value.Equals(_shiGongUnit)))
				{
                    object oldValue = _shiGongUnit;
					_shiGongUnit = value;
					RaisePropertyChanged(SupervisionRiZhi.Prop_ShiGongUnit, oldValue, value);
				}
			}

		}

		[Property("Weather", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string Weather
		{
			get { return _weather; }
			set
			{
				if ((_weather == null) || (value == null) || (!value.Equals(_weather)))
				{
                    object oldValue = _weather;
					_weather = value;
					RaisePropertyChanged(SupervisionRiZhi.Prop_Weather, oldValue, value);
				}
			}

		}

		[Property("SupervisionDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? SupervisionDate
		{
			get { return _supervisionDate; }
			set
			{
				if (value != _supervisionDate)
				{
                    object oldValue = _supervisionDate;
					_supervisionDate = value;
					RaisePropertyChanged(SupervisionRiZhi.Prop_SupervisionDate, oldValue, value);
				}
			}

		}

		[Property("WorkRecord", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string WorkRecord
		{
			get { return _workRecord; }
			set
			{
				if ((_workRecord == null) || (value == null) || (!value.Equals(_workRecord)))
				{
                    object oldValue = _workRecord;
					_workRecord = value;
					RaisePropertyChanged(SupervisionRiZhi.Prop_WorkRecord, oldValue, value);
				}
			}

		}

		[Property("SafetySupervision", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string SafetySupervision
		{
			get { return _safetySupervision; }
			set
			{
				if ((_safetySupervision == null) || (value == null) || (!value.Equals(_safetySupervision)))
				{
                    object oldValue = _safetySupervision;
					_safetySupervision = value;
					RaisePropertyChanged(SupervisionRiZhi.Prop_SafetySupervision, oldValue, value);
				}
			}

		}

		[Property("NextArrange", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string NextArrange
		{
			get { return _nextArrange; }
			set
			{
				if ((_nextArrange == null) || (value == null) || (!value.Equals(_nextArrange)))
				{
                    object oldValue = _nextArrange;
					_nextArrange = value;
					RaisePropertyChanged(SupervisionRiZhi.Prop_NextArrange, oldValue, value);
				}
			}

		}

		[Property("PManagerOpinion", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string PManagerOpinion
		{
			get { return _pManagerOpinion; }
			set
			{
				if ((_pManagerOpinion == null) || (value == null) || (!value.Equals(_pManagerOpinion)))
				{
                    object oldValue = _pManagerOpinion;
					_pManagerOpinion = value;
					RaisePropertyChanged(SupervisionRiZhi.Prop_PManagerOpinion, oldValue, value);
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
					RaisePropertyChanged(SupervisionRiZhi.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(SupervisionRiZhi.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(SupervisionRiZhi.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // SupervisionRiZhi
}

