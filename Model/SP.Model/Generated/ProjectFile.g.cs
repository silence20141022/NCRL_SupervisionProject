// Business class ProjectFile generated from ProjectFile
// Creator: Ray
// Created Date: [2014-11-16]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("ProjectFile")]
	public partial class ProjectFile : SPModelBase<ProjectFile>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Name = "Name";
		public static string Prop_ParentID = "ParentID";
		public static string Prop_ProjectID = "ProjectID";
		public static string Prop_IsDelete = "IsDelete";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_TypeID = "TypeID";

		#endregion

		#region Private_Variables

		private string _id;
		private string _name;
		private string _parentID;
		private string _projectID;
		private string _isDelete;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _typeID;


		#endregion

		#region Constructors

		public ProjectFile()
		{
		}

		public ProjectFile(
			string p_id,
			string p_name,
			string p_parentID,
			string p_projectID,
			string p_isDelete,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_typeID)
		{
			_id = p_id;
			_name = p_name;
			_parentID = p_parentID;
			_projectID = p_projectID;
			_isDelete = p_isDelete;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_typeID = p_typeID;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("Name", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string Name
		{
			get { return _name; }
			set
			{
				if ((_name == null) || (value == null) || (!value.Equals(_name)))
				{
                    object oldValue = _name;
					_name = value;
					RaisePropertyChanged(ProjectFile.Prop_Name, oldValue, value);
				}
			}

		}

		[Property("ParentID", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ParentID
		{
			get { return _parentID; }
			set
			{
				if ((_parentID == null) || (value == null) || (!value.Equals(_parentID)))
				{
                    object oldValue = _parentID;
					_parentID = value;
					RaisePropertyChanged(ProjectFile.Prop_ParentID, oldValue, value);
				}
			}

		}

		[Property("ProjectID", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ProjectID
		{
			get { return _projectID; }
			set
			{
				if ((_projectID == null) || (value == null) || (!value.Equals(_projectID)))
				{
                    object oldValue = _projectID;
					_projectID = value;
					RaisePropertyChanged(ProjectFile.Prop_ProjectID, oldValue, value);
				}
			}

		}

		[Property("IsDelete", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string IsDelete
		{
			get { return _isDelete; }
			set
			{
				if ((_isDelete == null) || (value == null) || (!value.Equals(_isDelete)))
				{
                    object oldValue = _isDelete;
					_isDelete = value;
					RaisePropertyChanged(ProjectFile.Prop_IsDelete, oldValue, value);
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
					RaisePropertyChanged(ProjectFile.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(ProjectFile.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(ProjectFile.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("TypeID", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string TypeID
		{
			get { return _typeID; }
			set
			{
				if ((_typeID == null) || (value == null) || (!value.Equals(_typeID)))
				{
                    object oldValue = _typeID;
					_typeID = value;
					RaisePropertyChanged(ProjectFile.Prop_TypeID, oldValue, value);
				}
			}

		}

		#endregion
	} // ProjectFile
}

