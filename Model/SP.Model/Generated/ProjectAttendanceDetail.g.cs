// Business class ProjectAttendanceDetail generated from ProjectAttendanceDetail
// Creator: Ray
// Created Date: [2014-04-28]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("ProjectAttendanceDetail")]
    public partial class ProjectAttendanceDetail : SPModelBase<ProjectAttendanceDetail>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectAttendanceId = "ProjectAttendanceId";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";
		public static string Prop_AttendanceType = "AttendanceType";
		public static string Prop_AttendanceDate = "AttendanceDate";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_Description = "Description";

		#endregion

		#region Private_Variables

		private string _id;
		private string _projectAttendanceId;
		private string _userId;
		private string _userName;
		private string _attendanceType;
		private DateTime? _attendanceDate;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _description;


		#endregion

		#region Constructors

		public ProjectAttendanceDetail()
		{
		}

		public ProjectAttendanceDetail(
			string p_id,
			string p_projectAttendanceId,
			string p_userId,
			string p_userName,
			string p_attendanceType,
			DateTime? p_attendanceDate,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_description)
		{
			_id = p_id;
			_projectAttendanceId = p_projectAttendanceId;
			_userId = p_userId;
			_userName = p_userName;
			_attendanceType = p_attendanceType;
			_attendanceDate = p_attendanceDate;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_description = p_description;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("ProjectAttendanceId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ProjectAttendanceId
		{
			get { return _projectAttendanceId; }
			set
			{
				if ((_projectAttendanceId == null) || (value == null) || (!value.Equals(_projectAttendanceId)))
				{
                    object oldValue = _projectAttendanceId;
					_projectAttendanceId = value;
					RaisePropertyChanged(ProjectAttendanceDetail.Prop_ProjectAttendanceId, oldValue, value);
				}
			}

		}

		[Property("UserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string UserId
		{
			get { return _userId; }
			set
			{
				if ((_userId == null) || (value == null) || (!value.Equals(_userId)))
				{
                    object oldValue = _userId;
					_userId = value;
					RaisePropertyChanged(ProjectAttendanceDetail.Prop_UserId, oldValue, value);
				}
			}

		}

		[Property("UserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string UserName
		{
			get { return _userName; }
			set
			{
				if ((_userName == null) || (value == null) || (!value.Equals(_userName)))
				{
                    object oldValue = _userName;
					_userName = value;
					RaisePropertyChanged(ProjectAttendanceDetail.Prop_UserName, oldValue, value);
				}
			}

		}

		[Property("AttendanceType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string AttendanceType
		{
			get { return _attendanceType; }
			set
			{
				if ((_attendanceType == null) || (value == null) || (!value.Equals(_attendanceType)))
				{
                    object oldValue = _attendanceType;
					_attendanceType = value;
					RaisePropertyChanged(ProjectAttendanceDetail.Prop_AttendanceType, oldValue, value);
				}
			}

		}

		[Property("AttendanceDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? AttendanceDate
		{
			get { return _attendanceDate; }
			set
			{
				if (value != _attendanceDate)
				{
                    object oldValue = _attendanceDate;
					_attendanceDate = value;
					RaisePropertyChanged(ProjectAttendanceDetail.Prop_AttendanceDate, oldValue, value);
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
					RaisePropertyChanged(ProjectAttendanceDetail.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(ProjectAttendanceDetail.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(ProjectAttendanceDetail.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("Description", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string Description
		{
			get { return _description; }
			set
			{
				if ((_description == null) || (value == null) || (!value.Equals(_description)))
				{
                    object oldValue = _description;
					_description = value;
					RaisePropertyChanged(ProjectAttendanceDetail.Prop_Description, oldValue, value);
				}
			}

		}

		#endregion
	} // ProjectAttendanceDetail
}

