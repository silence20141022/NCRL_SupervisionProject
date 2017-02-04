// Business class DeptAttendance generated from DeptAttendance
// Creator: Ray
// Created Date: [2015-09-19]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("DeptAttendance")]
	public partial class DeptAttendance : SPModelBase<DeptAttendance>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Year = "Year";
		public static string Prop_Month = "Month";
		public static string Prop_BelongDeptId = "BelongDeptId";
		public static string Prop_BelongDeptName = "BelongDeptName";
		public static string Prop_Status = "Status";
		public static string Prop_Remark = "Remark";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private int? _year;
		private int? _month;
		private string _belongDeptId;
		private string _belongDeptName;
		private string _status;
		private string _remark;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public DeptAttendance()
		{
		}

		public DeptAttendance(
			string p_id,
			int? p_year,
			int? p_month,
			string p_belongDeptId,
			string p_belongDeptName,
			string p_status,
			string p_remark,
			DateTime? p_createTime)
		{
			_id = p_id;
			_year = p_year;
			_month = p_month;
			_belongDeptId = p_belongDeptId;
			_belongDeptName = p_belongDeptName;
			_status = p_status;
			_remark = p_remark;
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
					RaisePropertyChanged(DeptAttendance.Prop_Year, oldValue, value);
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
					RaisePropertyChanged(DeptAttendance.Prop_Month, oldValue, value);
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
					RaisePropertyChanged(DeptAttendance.Prop_BelongDeptId, oldValue, value);
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
					RaisePropertyChanged(DeptAttendance.Prop_BelongDeptName, oldValue, value);
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
					RaisePropertyChanged(DeptAttendance.Prop_Status, oldValue, value);
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
					RaisePropertyChanged(DeptAttendance.Prop_Remark, oldValue, value);
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
					RaisePropertyChanged(DeptAttendance.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // DeptAttendance
}

