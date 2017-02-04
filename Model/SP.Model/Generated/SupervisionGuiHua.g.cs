// Business class SupervisionGuiHua generated from SupervisionGuiHua
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
	[ActiveRecord("SupervisionGuiHua")]
    public partial class SupervisionGuiHua : SPModelBase<SupervisionGuiHua>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectId = "ProjectId";
		public static string Prop_ProjectName = "ProjectName";
		public static string Prop_PManagerId = "PManagerId";
		public static string Prop_PManagerName = "PManagerName";
		public static string Prop_State = "State";
		public static string Prop_FileId = "FileId";
		public static string Prop_EngineerId = "EngineerId";
		public static string Prop_EngineerName = "EngineerName";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_ModifyId = "ModifyId";
		public static string Prop_ModifyName = "ModifyName";
		public static string Prop_ModifyTime = "ModifyTime";
		public static string Prop_ShiGongUnit = "ShiGongUnit";

		#endregion

		#region Private_Variables

		private string _id;
		private string _projectId;
		private string _projectName;
		private string _pManagerId;
		private string _pManagerName;
		private string _state;
		private string _fileId;
		private string _engineerId;
		private string _engineerName;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _modifyId;
		private string _modifyName;
		private DateTime? _modifyTime;
		private string _shiGongUnit;


		#endregion

		#region Constructors

		public SupervisionGuiHua()
		{
		}

		public SupervisionGuiHua(
			string p_id,
			string p_projectId,
			string p_projectName,
			string p_pManagerId,
			string p_pManagerName,
			string p_state,
			string p_fileId,
			string p_engineerId,
			string p_engineerName,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_modifyId,
			string p_modifyName,
			DateTime? p_modifyTime,
			string p_shiGongUnit)
		{
			_id = p_id;
			_projectId = p_projectId;
			_projectName = p_projectName;
			_pManagerId = p_pManagerId;
			_pManagerName = p_pManagerName;
			_state = p_state;
			_fileId = p_fileId;
			_engineerId = p_engineerId;
			_engineerName = p_engineerName;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_modifyId = p_modifyId;
			_modifyName = p_modifyName;
			_modifyTime = p_modifyTime;
			_shiGongUnit = p_shiGongUnit;
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
					RaisePropertyChanged(SupervisionGuiHua.Prop_ProjectId, oldValue, value);
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
					RaisePropertyChanged(SupervisionGuiHua.Prop_ProjectName, oldValue, value);
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
					RaisePropertyChanged(SupervisionGuiHua.Prop_PManagerId, oldValue, value);
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
					RaisePropertyChanged(SupervisionGuiHua.Prop_PManagerName, oldValue, value);
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
					RaisePropertyChanged(SupervisionGuiHua.Prop_State, oldValue, value);
				}
			}

		}

		[Property("FileId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string FileId
		{
			get { return _fileId; }
			set
			{
				if ((_fileId == null) || (value == null) || (!value.Equals(_fileId)))
				{
                    object oldValue = _fileId;
					_fileId = value;
					RaisePropertyChanged(SupervisionGuiHua.Prop_FileId, oldValue, value);
				}
			}

		}

		[Property("EngineerId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string EngineerId
		{
			get { return _engineerId; }
			set
			{
				if ((_engineerId == null) || (value == null) || (!value.Equals(_engineerId)))
				{
                    object oldValue = _engineerId;
					_engineerId = value;
					RaisePropertyChanged(SupervisionGuiHua.Prop_EngineerId, oldValue, value);
				}
			}

		}

		[Property("EngineerName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string EngineerName
		{
			get { return _engineerName; }
			set
			{
				if ((_engineerName == null) || (value == null) || (!value.Equals(_engineerName)))
				{
                    object oldValue = _engineerName;
					_engineerName = value;
					RaisePropertyChanged(SupervisionGuiHua.Prop_EngineerName, oldValue, value);
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
					RaisePropertyChanged(SupervisionGuiHua.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(SupervisionGuiHua.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(SupervisionGuiHua.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("ModifyId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ModifyId
		{
			get { return _modifyId; }
			set
			{
				if ((_modifyId == null) || (value == null) || (!value.Equals(_modifyId)))
				{
                    object oldValue = _modifyId;
					_modifyId = value;
					RaisePropertyChanged(SupervisionGuiHua.Prop_ModifyId, oldValue, value);
				}
			}

		}

		[Property("ModifyName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ModifyName
		{
			get { return _modifyName; }
			set
			{
				if ((_modifyName == null) || (value == null) || (!value.Equals(_modifyName)))
				{
                    object oldValue = _modifyName;
					_modifyName = value;
					RaisePropertyChanged(SupervisionGuiHua.Prop_ModifyName, oldValue, value);
				}
			}

		}

		[Property("ModifyTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? ModifyTime
		{
			get { return _modifyTime; }
			set
			{
				if (value != _modifyTime)
				{
                    object oldValue = _modifyTime;
					_modifyTime = value;
					RaisePropertyChanged(SupervisionGuiHua.Prop_ModifyTime, oldValue, value);
				}
			}

		}

		[Property("ShiGongUnit", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ShiGongUnit
		{
			get { return _shiGongUnit; }
			set
			{
				if ((_shiGongUnit == null) || (value == null) || (!value.Equals(_shiGongUnit)))
				{
                    object oldValue = _shiGongUnit;
					_shiGongUnit = value;
					RaisePropertyChanged(SupervisionGuiHua.Prop_ShiGongUnit, oldValue, value);
				}
			}

		}

		#endregion
	} // SupervisionGuiHua
}

