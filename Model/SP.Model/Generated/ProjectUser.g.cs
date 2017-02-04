// Business class ProjectUser generated from ProjectUser
// Creator: Ray
// Created Date: [2014-08-04]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("ProjectUser")]
	public partial class ProjectUser : SPModelBase<ProjectUser>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectId = "ProjectId";
		public static string Prop_MajorCode = "MajorCode";
		public static string Prop_MajorName = "MajorName";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";
		public static string Prop_QianZhangId = "QianZhangId";
		public static string Prop_QianZhangName = "QianZhangName";
		public static string Prop_ShenHeId = "ShenHeId";
		public static string Prop_ShenHeName = "ShenHeName";
		public static string Prop_State = "State";
		public static string Prop_UserType = "UserType";
		public static string Prop_BelongDeptId = "BelongDeptId";
		public static string Prop_BelongDeptName = "BelongDeptName";
		public static string Prop_Unit = "Unit";
		public static string Prop_Position = "Position";
		public static string Prop_DistributeAmount = "DistributeAmount";
		public static string Prop_DistributePercent = "DistributePercent";
		public static string Prop_AcctualAmount = "AcctualAmount";

		#endregion

		#region Private_Variables

		private string _id;
		private string _projectId;
		private string _majorCode;
		private string _majorName;
		private string _userId;
		private string _userName;
		private string _qianZhangId;
		private string _qianZhangName;
		private string _shenHeId;
		private string _shenHeName;
		private string _state;
		private string _userType;
		private string _belongDeptId;
		private string _belongDeptName;
		private string _unit;
		private string _position;
		private System.Decimal? _distributeAmount;
		private System.Decimal? _distributePercent;
		private System.Decimal? _acctualAmount;


		#endregion

		#region Constructors

		public ProjectUser()
		{
		}

		public ProjectUser(
			string p_id,
			string p_projectId,
			string p_majorCode,
			string p_majorName,
			string p_userId,
			string p_userName,
			string p_qianZhangId,
			string p_qianZhangName,
			string p_shenHeId,
			string p_shenHeName,
			string p_state,
			string p_userType,
			string p_belongDeptId,
			string p_belongDeptName,
			string p_unit,
			string p_position,
			System.Decimal? p_distributeAmount,
			System.Decimal? p_distributePercent,
			System.Decimal? p_acctualAmount)
		{
			_id = p_id;
			_projectId = p_projectId;
			_majorCode = p_majorCode;
			_majorName = p_majorName;
			_userId = p_userId;
			_userName = p_userName;
			_qianZhangId = p_qianZhangId;
			_qianZhangName = p_qianZhangName;
			_shenHeId = p_shenHeId;
			_shenHeName = p_shenHeName;
			_state = p_state;
			_userType = p_userType;
			_belongDeptId = p_belongDeptId;
			_belongDeptName = p_belongDeptName;
			_unit = p_unit;
			_position = p_position;
			_distributeAmount = p_distributeAmount;
			_distributePercent = p_distributePercent;
			_acctualAmount = p_acctualAmount;
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
					RaisePropertyChanged(ProjectUser.Prop_ProjectId, oldValue, value);
				}
			}

		}

		[Property("MajorCode", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string MajorCode
		{
			get { return _majorCode; }
			set
			{
				if ((_majorCode == null) || (value == null) || (!value.Equals(_majorCode)))
				{
                    object oldValue = _majorCode;
					_majorCode = value;
					RaisePropertyChanged(ProjectUser.Prop_MajorCode, oldValue, value);
				}
			}

		}

		[Property("MajorName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string MajorName
		{
			get { return _majorName; }
			set
			{
				if ((_majorName == null) || (value == null) || (!value.Equals(_majorName)))
				{
                    object oldValue = _majorName;
					_majorName = value;
					RaisePropertyChanged(ProjectUser.Prop_MajorName, oldValue, value);
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
					RaisePropertyChanged(ProjectUser.Prop_UserId, oldValue, value);
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
					RaisePropertyChanged(ProjectUser.Prop_UserName, oldValue, value);
				}
			}

		}

		[Property("QianZhangId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string QianZhangId
		{
			get { return _qianZhangId; }
			set
			{
				if ((_qianZhangId == null) || (value == null) || (!value.Equals(_qianZhangId)))
				{
                    object oldValue = _qianZhangId;
					_qianZhangId = value;
					RaisePropertyChanged(ProjectUser.Prop_QianZhangId, oldValue, value);
				}
			}

		}

		[Property("QianZhangName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 10)]
		public string QianZhangName
		{
			get { return _qianZhangName; }
			set
			{
				if ((_qianZhangName == null) || (value == null) || (!value.Equals(_qianZhangName)))
				{
                    object oldValue = _qianZhangName;
					_qianZhangName = value;
					RaisePropertyChanged(ProjectUser.Prop_QianZhangName, oldValue, value);
				}
			}

		}

		[Property("ShenHeId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ShenHeId
		{
			get { return _shenHeId; }
			set
			{
				if ((_shenHeId == null) || (value == null) || (!value.Equals(_shenHeId)))
				{
                    object oldValue = _shenHeId;
					_shenHeId = value;
					RaisePropertyChanged(ProjectUser.Prop_ShenHeId, oldValue, value);
				}
			}

		}

		[Property("ShenHeName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ShenHeName
		{
			get { return _shenHeName; }
			set
			{
				if ((_shenHeName == null) || (value == null) || (!value.Equals(_shenHeName)))
				{
                    object oldValue = _shenHeName;
					_shenHeName = value;
					RaisePropertyChanged(ProjectUser.Prop_ShenHeName, oldValue, value);
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
					RaisePropertyChanged(ProjectUser.Prop_State, oldValue, value);
				}
			}

		}

		[Property("UserType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string UserType
		{
			get { return _userType; }
			set
			{
				if ((_userType == null) || (value == null) || (!value.Equals(_userType)))
				{
                    object oldValue = _userType;
					_userType = value;
					RaisePropertyChanged(ProjectUser.Prop_UserType, oldValue, value);
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
					RaisePropertyChanged(ProjectUser.Prop_BelongDeptId, oldValue, value);
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
					RaisePropertyChanged(ProjectUser.Prop_BelongDeptName, oldValue, value);
				}
			}

		}

		[Property("Unit", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 100)]
		public string Unit
		{
			get { return _unit; }
			set
			{
				if ((_unit == null) || (value == null) || (!value.Equals(_unit)))
				{
                    object oldValue = _unit;
					_unit = value;
					RaisePropertyChanged(ProjectUser.Prop_Unit, oldValue, value);
				}
			}

		}

		[Property("Position", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Position
		{
			get { return _position; }
			set
			{
				if ((_position == null) || (value == null) || (!value.Equals(_position)))
				{
                    object oldValue = _position;
					_position = value;
					RaisePropertyChanged(ProjectUser.Prop_Position, oldValue, value);
				}
			}

		}

		[Property("DistributeAmount", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? DistributeAmount
		{
			get { return _distributeAmount; }
			set
			{
				if (value != _distributeAmount)
				{
                    object oldValue = _distributeAmount;
					_distributeAmount = value;
					RaisePropertyChanged(ProjectUser.Prop_DistributeAmount, oldValue, value);
				}
			}

		}

		[Property("DistributePercent", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? DistributePercent
		{
			get { return _distributePercent; }
			set
			{
				if (value != _distributePercent)
				{
                    object oldValue = _distributePercent;
					_distributePercent = value;
					RaisePropertyChanged(ProjectUser.Prop_DistributePercent, oldValue, value);
				}
			}

		}

		[Property("AcctualAmount", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? AcctualAmount
		{
			get { return _acctualAmount; }
			set
			{
				if (value != _acctualAmount)
				{
                    object oldValue = _acctualAmount;
					_acctualAmount = value;
					RaisePropertyChanged(ProjectUser.Prop_AcctualAmount, oldValue, value);
				}
			}

		}

		#endregion
	} // ProjectUser
}

