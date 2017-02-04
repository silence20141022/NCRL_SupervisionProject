// Business class CmpAttendanceDetail generated from CmpAttendanceDetail
// Creator: Ray
// Created Date: [2014-04-29]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("CmpAttendanceDetail")]
    public partial class CmpAttendanceDetail : SPModelBase<CmpAttendanceDetail>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_CmpAttendanceId = "CmpAttendanceId";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";
		public static string Prop_BelongDeptId = "BelongDeptId";
		public static string Prop_BelongDeptName = "BelongDeptName";
		public static string Prop_AttendanceType = "AttendanceType";
		public static string Prop_AttendanceDate = "AttendanceDate";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _cmpAttendanceId;
		private string _userId;
		private string _userName;
		private string _belongDeptId;
		private string _belongDeptName;
		private string _attendanceType;
		private DateTime? _attendanceDate;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public CmpAttendanceDetail()
		{
		}

		public CmpAttendanceDetail(
			string p_id,
			string p_cmpAttendanceId,
			string p_userId,
			string p_userName,
			string p_belongDeptId,
			string p_belongDeptName,
			string p_attendanceType,
			DateTime? p_attendanceDate,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_cmpAttendanceId = p_cmpAttendanceId;
			_userId = p_userId;
			_userName = p_userName;
			_belongDeptId = p_belongDeptId;
			_belongDeptName = p_belongDeptName;
			_attendanceType = p_attendanceType;
			_attendanceDate = p_attendanceDate;
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

		[Property("CmpAttendanceId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string CmpAttendanceId
		{
			get { return _cmpAttendanceId; }
			set
			{
				if ((_cmpAttendanceId == null) || (value == null) || (!value.Equals(_cmpAttendanceId)))
				{
                    object oldValue = _cmpAttendanceId;
					_cmpAttendanceId = value;
					RaisePropertyChanged(CmpAttendanceDetail.Prop_CmpAttendanceId, oldValue, value);
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
					RaisePropertyChanged(CmpAttendanceDetail.Prop_UserId, oldValue, value);
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
					RaisePropertyChanged(CmpAttendanceDetail.Prop_UserName, oldValue, value);
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
					RaisePropertyChanged(CmpAttendanceDetail.Prop_BelongDeptId, oldValue, value);
				}
			}

		}

		[Property("BelongDeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string BelongDeptName
		{
			get { return _belongDeptName; }
			set
			{
				if ((_belongDeptName == null) || (value == null) || (!value.Equals(_belongDeptName)))
				{
                    object oldValue = _belongDeptName;
					_belongDeptName = value;
					RaisePropertyChanged(CmpAttendanceDetail.Prop_BelongDeptName, oldValue, value);
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
					RaisePropertyChanged(CmpAttendanceDetail.Prop_AttendanceType, oldValue, value);
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
					RaisePropertyChanged(CmpAttendanceDetail.Prop_AttendanceDate, oldValue, value);
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
					RaisePropertyChanged(CmpAttendanceDetail.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(CmpAttendanceDetail.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(CmpAttendanceDetail.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // CmpAttendanceDetail
}

