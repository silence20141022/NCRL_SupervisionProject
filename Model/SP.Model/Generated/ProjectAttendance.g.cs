// Business class ProjectAttendance generated from ProjectAttendance
// Creator: Ray
// Created Date: [2014-12-09]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("ProjectAttendance")]
	public partial class ProjectAttendance : SPModelBase<ProjectAttendance>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectId = "ProjectId";
		public static string Prop_ProjectName = "ProjectName";
		public static string Prop_Year = "Year";
		public static string Prop_Month = "Month";
		public static string Prop_Attachment = "Attachment";
		public static string Prop_PManagerName = "PManagerName";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_BelongDeptId = "BelongDeptId";
		public static string Prop_BelongDeptName = "BelongDeptName";
		public static string Prop_Remark = "Remark";
		public static string Prop_Status = "Status";

		#endregion

		#region Private_Variables

		private string _id;
		private string _projectId;
		private string _projectName;
		private int? _year;
		private int? _month;
		private string _attachment;
		private string _pManagerName;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _belongDeptId;
		private string _belongDeptName;
		private string _remark;
		private string _status;


		#endregion

		#region Constructors

		public ProjectAttendance()
		{
		}

		public ProjectAttendance(
			string p_id,
			string p_projectId,
			string p_projectName,
			int? p_year,
			int? p_month,
			string p_attachment,
			string p_pManagerName,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_belongDeptId,
			string p_belongDeptName,
			string p_remark,
			string p_status)
		{
			_id = p_id;
			_projectId = p_projectId;
			_projectName = p_projectName;
			_year = p_year;
			_month = p_month;
			_attachment = p_attachment;
			_pManagerName = p_pManagerName;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_belongDeptId = p_belongDeptId;
			_belongDeptName = p_belongDeptName;
			_remark = p_remark;
			_status = p_status;
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
					RaisePropertyChanged(ProjectAttendance.Prop_ProjectId, oldValue, value);
				}
			}

		}

		[Property("ProjectName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string ProjectName
		{
			get { return _projectName; }
			set
			{
				if ((_projectName == null) || (value == null) || (!value.Equals(_projectName)))
				{
                    object oldValue = _projectName;
					_projectName = value;
					RaisePropertyChanged(ProjectAttendance.Prop_ProjectName, oldValue, value);
				}
			}

		}

		[Property("Year", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? Year
		{
			get { return _year; }
			set
			{
				if (value != _year)
				{
                    object oldValue = _year;
					_year = value;
					RaisePropertyChanged(ProjectAttendance.Prop_Year, oldValue, value);
				}
			}

		}

		[Property("Month", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? Month
		{
			get { return _month; }
			set
			{
				if (value != _month)
				{
                    object oldValue = _month;
					_month = value;
					RaisePropertyChanged(ProjectAttendance.Prop_Month, oldValue, value);
				}
			}

		}

		[Property("Attachment", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string Attachment
		{
			get { return _attachment; }
			set
			{
				if ((_attachment == null) || (value == null) || (!value.Equals(_attachment)))
				{
                    object oldValue = _attachment;
					_attachment = value;
					RaisePropertyChanged(ProjectAttendance.Prop_Attachment, oldValue, value);
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
					RaisePropertyChanged(ProjectAttendance.Prop_PManagerName, oldValue, value);
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
					RaisePropertyChanged(ProjectAttendance.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(ProjectAttendance.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(ProjectAttendance.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("BelongDeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string BelongDeptId
		{
			get { return _belongDeptId; }
			set
			{
				if ((_belongDeptId == null) || (value == null) || (!value.Equals(_belongDeptId)))
				{
                    object oldValue = _belongDeptId;
					_belongDeptId = value;
					RaisePropertyChanged(ProjectAttendance.Prop_BelongDeptId, oldValue, value);
				}
			}

		}

		[Property("BelongDeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string BelongDeptName
		{
			get { return _belongDeptName; }
			set
			{
				if ((_belongDeptName == null) || (value == null) || (!value.Equals(_belongDeptName)))
				{
                    object oldValue = _belongDeptName;
					_belongDeptName = value;
					RaisePropertyChanged(ProjectAttendance.Prop_BelongDeptName, oldValue, value);
				}
			}

		}

		[Property("Remark", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string Remark
		{
			get { return _remark; }
			set
			{
				if ((_remark == null) || (value == null) || (!value.Equals(_remark)))
				{
                    object oldValue = _remark;
					_remark = value;
					RaisePropertyChanged(ProjectAttendance.Prop_Remark, oldValue, value);
				}
			}

		}

		[Property("Status", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Status
		{
			get { return _status; }
			set
			{
				if ((_status == null) || (value == null) || (!value.Equals(_status)))
				{
                    object oldValue = _status;
					_status = value;
					RaisePropertyChanged(ProjectAttendance.Prop_Status, oldValue, value);
				}
			}

		}

		#endregion
	} // ProjectAttendance
}

