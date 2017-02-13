// Business class SupervisionEC generated from SupervisionEC
// Creator: Ray
// Created Date: [2014-04-17]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("SupervisionEC")]
	public partial class SupervisionEC : SPModelBase<SupervisionEC>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectId = "ProjectId";
		public static string Prop_ProjectName = "ProjectName";
		public static string Prop_PManagerId = "PManagerId";
		public static string Prop_PManagerName = "PManagerName";
		public static string Prop_ShiGongUnit = "ShiGongUnit";
		public static string Prop_EnvironmentFactorIds = "EnvironmentFactorIds";
		public static string Prop_Remark = "Remark";
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
		private string _environmentFactorIds;
		private string _remark;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public SupervisionEC()
		{
		}

		public SupervisionEC(
			string p_id,
			string p_projectId,
			string p_projectName,
			string p_pManagerId,
			string p_pManagerName,
			string p_shiGongUnit,
			string p_environmentFactorIds,
			string p_remark,
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
			_environmentFactorIds = p_environmentFactorIds;
			_remark = p_remark;
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
					RaisePropertyChanged(SupervisionEC.Prop_ProjectId, oldValue, value);
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
					RaisePropertyChanged(SupervisionEC.Prop_ProjectName, oldValue, value);
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
					RaisePropertyChanged(SupervisionEC.Prop_PManagerId, oldValue, value);
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
					RaisePropertyChanged(SupervisionEC.Prop_PManagerName, oldValue, value);
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
					RaisePropertyChanged(SupervisionEC.Prop_ShiGongUnit, oldValue, value);
				}
			}

		}

		[Property("EnvironmentFactorIds", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string EnvironmentFactorIds
		{
			get { return _environmentFactorIds; }
			set
			{
				if ((_environmentFactorIds == null) || (value == null) || (!value.Equals(_environmentFactorIds)))
				{
                    object oldValue = _environmentFactorIds;
					_environmentFactorIds = value;
					RaisePropertyChanged(SupervisionEC.Prop_EnvironmentFactorIds, oldValue, value);
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
					RaisePropertyChanged(SupervisionEC.Prop_Remark, oldValue, value);
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
					RaisePropertyChanged(SupervisionEC.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(SupervisionEC.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(SupervisionEC.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // SupervisionEC
}

