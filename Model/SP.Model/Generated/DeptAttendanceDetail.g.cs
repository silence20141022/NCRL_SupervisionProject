// Business class DeptAttendanceDetail generated from DeptAttendanceDetail
// Creator: Ray
// Created Date: [2014-05-05]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("DeptAttendanceDetail")]
    public partial class DeptAttendanceDetail : SPModelBase<DeptAttendanceDetail>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_DeptAttendanceId = "DeptAttendanceId";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";
		public static string Prop_AttendanceType = "AttendanceType";
		public static string Prop_AttendanceDate = "AttendanceDate";
		public static string Prop_ProjectIds = "ProjectIds";
		public static string Prop_ProjectNames = "ProjectNames";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _deptAttendanceId;
		private string _userId;
		private string _userName;
		private string _attendanceType;
		private DateTime? _attendanceDate;
		private string _projectIds;
		private string _projectNames;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public DeptAttendanceDetail()
		{
		}

		public DeptAttendanceDetail(
			string p_id,
			string p_deptAttendanceId,
			string p_userId,
			string p_userName,
			string p_attendanceType,
			DateTime? p_attendanceDate,
			string p_projectIds,
			string p_projectNames,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_deptAttendanceId = p_deptAttendanceId;
			_userId = p_userId;
			_userName = p_userName;
			_attendanceType = p_attendanceType;
			_attendanceDate = p_attendanceDate;
			_projectIds = p_projectIds;
			_projectNames = p_projectNames;
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

		[Property("DeptAttendanceId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string DeptAttendanceId
		{
			get { return _deptAttendanceId; }
			set
			{
				if ((_deptAttendanceId == null) || (value == null) || (!value.Equals(_deptAttendanceId)))
				{
                    object oldValue = _deptAttendanceId;
					_deptAttendanceId = value;
					RaisePropertyChanged(DeptAttendanceDetail.Prop_DeptAttendanceId, oldValue, value);
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
					RaisePropertyChanged(DeptAttendanceDetail.Prop_UserId, oldValue, value);
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
					RaisePropertyChanged(DeptAttendanceDetail.Prop_UserName, oldValue, value);
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
					RaisePropertyChanged(DeptAttendanceDetail.Prop_AttendanceType, oldValue, value);
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
					RaisePropertyChanged(DeptAttendanceDetail.Prop_AttendanceDate, oldValue, value);
				}
			}

		}

		[Property("ProjectIds", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string ProjectIds
		{
			get { return _projectIds; }
			set
			{
				if ((_projectIds == null) || (value == null) || (!value.Equals(_projectIds)))
				{
                    object oldValue = _projectIds;
					_projectIds = value;
					RaisePropertyChanged(DeptAttendanceDetail.Prop_ProjectIds, oldValue, value);
				}
			}

		}

		[Property("ProjectNames", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string ProjectNames
		{
			get { return _projectNames; }
			set
			{
				if ((_projectNames == null) || (value == null) || (!value.Equals(_projectNames)))
				{
                    object oldValue = _projectNames;
					_projectNames = value;
					RaisePropertyChanged(DeptAttendanceDetail.Prop_ProjectNames, oldValue, value);
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
					RaisePropertyChanged(DeptAttendanceDetail.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(DeptAttendanceDetail.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(DeptAttendanceDetail.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // DeptAttendanceDetail
}

