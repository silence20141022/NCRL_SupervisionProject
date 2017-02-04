// Business class Salary generated from Salary
// Creator: Ray
// Created Date: [2014-11-11]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("Salary")]
	public partial class Salary : SPModelBase<Salary>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";
		public static string Prop_DeptId = "DeptId";
		public static string Prop_DeptName = "DeptName";
		public static string Prop_Job = "Job";
		public static string Prop_JobLevel = "JobLevel";
		public static string Prop_GangWeiSalary = "GangWeiSalary";
		public static string Prop_GongLingBuTie = "GongLingBuTie";
		public static string Prop_ZhuCeBuTie = "ZhuCeBuTie";
		public static string Prop_GangWeiBuTie = "GangWeiBuTie";
		public static string Prop_TeShuBuTie = "TeShuBuTie";
		public static string Prop_XianChangBuTie = "XianChangBuTie";
		public static string Prop_TotalSalary = "TotalSalary";
		public static string Prop_ModifyDate = "ModifyDate";
		public static string Prop_State = "State";
		public static string Prop_Remark = "Remark";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_StageId = "StageId";
		public static string Prop_SortIndex = "SortIndex";

		#endregion

		#region Private_Variables

		private string _id;
		private string _userId;
		private string _userName;
		private string _deptId;
		private string _deptName;
		private string _job;
		private string _jobLevel;
		private System.Decimal? _gangWeiSalary;
		private System.Decimal? _gongLingBuTie;
		private System.Decimal? _zhuCeBuTie;
		private System.Decimal? _gangWeiBuTie;
		private System.Decimal? _teShuBuTie;
		private System.Decimal? _xianChangBuTie;
		private System.Decimal? _totalSalary;
		private DateTime? _modifyDate;
		private string _state;
		private string _remark;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _stageId;
		private int? _sortIndex;


		#endregion

		#region Constructors

		public Salary()
		{
		}

		public Salary(
			string p_id,
			string p_userId,
			string p_userName,
			string p_deptId,
			string p_deptName,
			string p_job,
			string p_jobLevel,
			System.Decimal? p_gangWeiSalary,
			System.Decimal? p_gongLingBuTie,
			System.Decimal? p_zhuCeBuTie,
			System.Decimal? p_gangWeiBuTie,
			System.Decimal? p_teShuBuTie,
			System.Decimal? p_xianChangBuTie,
			System.Decimal? p_totalSalary,
			DateTime? p_modifyDate,
			string p_state,
			string p_remark,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_stageId,
			int? p_sortIndex)
		{
			_id = p_id;
			_userId = p_userId;
			_userName = p_userName;
			_deptId = p_deptId;
			_deptName = p_deptName;
			_job = p_job;
			_jobLevel = p_jobLevel;
			_gangWeiSalary = p_gangWeiSalary;
			_gongLingBuTie = p_gongLingBuTie;
			_zhuCeBuTie = p_zhuCeBuTie;
			_gangWeiBuTie = p_gangWeiBuTie;
			_teShuBuTie = p_teShuBuTie;
			_xianChangBuTie = p_xianChangBuTie;
			_totalSalary = p_totalSalary;
			_modifyDate = p_modifyDate;
			_state = p_state;
			_remark = p_remark;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_stageId = p_stageId;
			_sortIndex = p_sortIndex;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			set { _id = value; } // 处理列表编辑时去掉注释
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
					RaisePropertyChanged(Salary.Prop_UserId, oldValue, value);
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
					RaisePropertyChanged(Salary.Prop_UserName, oldValue, value);
				}
			}

		}

		[Property("DeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string DeptId
		{
			get { return _deptId; }
			set
			{
				if ((_deptId == null) || (value == null) || (!value.Equals(_deptId)))
				{
                    object oldValue = _deptId;
					_deptId = value;
					RaisePropertyChanged(Salary.Prop_DeptId, oldValue, value);
				}
			}

		}

		[Property("DeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string DeptName
		{
			get { return _deptName; }
			set
			{
				if ((_deptName == null) || (value == null) || (!value.Equals(_deptName)))
				{
                    object oldValue = _deptName;
					_deptName = value;
					RaisePropertyChanged(Salary.Prop_DeptName, oldValue, value);
				}
			}

		}

		[Property("Job", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Job
		{
			get { return _job; }
			set
			{
				if ((_job == null) || (value == null) || (!value.Equals(_job)))
				{
                    object oldValue = _job;
					_job = value;
					RaisePropertyChanged(Salary.Prop_Job, oldValue, value);
				}
			}

		}

		[Property("JobLevel", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string JobLevel
		{
			get { return _jobLevel; }
			set
			{
				if ((_jobLevel == null) || (value == null) || (!value.Equals(_jobLevel)))
				{
                    object oldValue = _jobLevel;
					_jobLevel = value;
					RaisePropertyChanged(Salary.Prop_JobLevel, oldValue, value);
				}
			}

		}

		[Property("GangWeiSalary", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? GangWeiSalary
		{
			get { return _gangWeiSalary; }
			set
			{
				if (value != _gangWeiSalary)
				{
                    object oldValue = _gangWeiSalary;
					_gangWeiSalary = value;
					RaisePropertyChanged(Salary.Prop_GangWeiSalary, oldValue, value);
				}
			}

		}

		[Property("GongLingBuTie", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? GongLingBuTie
		{
			get { return _gongLingBuTie; }
			set
			{
				if (value != _gongLingBuTie)
				{
                    object oldValue = _gongLingBuTie;
					_gongLingBuTie = value;
					RaisePropertyChanged(Salary.Prop_GongLingBuTie, oldValue, value);
				}
			}

		}

		[Property("ZhuCeBuTie", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? ZhuCeBuTie
		{
			get { return _zhuCeBuTie; }
			set
			{
				if (value != _zhuCeBuTie)
				{
                    object oldValue = _zhuCeBuTie;
					_zhuCeBuTie = value;
					RaisePropertyChanged(Salary.Prop_ZhuCeBuTie, oldValue, value);
				}
			}

		}

		[Property("GangWeiBuTie", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? GangWeiBuTie
		{
			get { return _gangWeiBuTie; }
			set
			{
				if (value != _gangWeiBuTie)
				{
                    object oldValue = _gangWeiBuTie;
					_gangWeiBuTie = value;
					RaisePropertyChanged(Salary.Prop_GangWeiBuTie, oldValue, value);
				}
			}

		}

		[Property("TeShuBuTie", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? TeShuBuTie
		{
			get { return _teShuBuTie; }
			set
			{
				if (value != _teShuBuTie)
				{
                    object oldValue = _teShuBuTie;
					_teShuBuTie = value;
					RaisePropertyChanged(Salary.Prop_TeShuBuTie, oldValue, value);
				}
			}

		}

		[Property("XianChangBuTie", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? XianChangBuTie
		{
			get { return _xianChangBuTie; }
			set
			{
				if (value != _xianChangBuTie)
				{
                    object oldValue = _xianChangBuTie;
					_xianChangBuTie = value;
					RaisePropertyChanged(Salary.Prop_XianChangBuTie, oldValue, value);
				}
			}

		}

		[Property("TotalSalary", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? TotalSalary
		{
			get { return _totalSalary; }
			set
			{
				if (value != _totalSalary)
				{
                    object oldValue = _totalSalary;
					_totalSalary = value;
					RaisePropertyChanged(Salary.Prop_TotalSalary, oldValue, value);
				}
			}

		}

		[Property("ModifyDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? ModifyDate
		{
			get { return _modifyDate; }
			set
			{
				if (value != _modifyDate)
				{
                    object oldValue = _modifyDate;
					_modifyDate = value;
					RaisePropertyChanged(Salary.Prop_ModifyDate, oldValue, value);
				}
			}

		}

		[Property("State", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string State
		{
			get { return _state; }
			set
			{
				if ((_state == null) || (value == null) || (!value.Equals(_state)))
				{
                    object oldValue = _state;
					_state = value;
					RaisePropertyChanged(Salary.Prop_State, oldValue, value);
				}
			}

		}

		[Property("Remark", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string Remark
		{
			get { return _remark; }
			set
			{
				if ((_remark == null) || (value == null) || (!value.Equals(_remark)))
				{
                    object oldValue = _remark;
					_remark = value;
					RaisePropertyChanged(Salary.Prop_Remark, oldValue, value);
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
					RaisePropertyChanged(Salary.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(Salary.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(Salary.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("StageId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string StageId
		{
			get { return _stageId; }
			set
			{
				if ((_stageId == null) || (value == null) || (!value.Equals(_stageId)))
				{
                    object oldValue = _stageId;
					_stageId = value;
					RaisePropertyChanged(Salary.Prop_StageId, oldValue, value);
				}
			}

		}

		[Property("SortIndex", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? SortIndex
		{
			get { return _sortIndex; }
			set
			{
				if (value != _sortIndex)
				{
                    object oldValue = _sortIndex;
					_sortIndex = value;
					RaisePropertyChanged(Salary.Prop_SortIndex, oldValue, value);
				}
			}

		}

		#endregion
	} // Salary
}

