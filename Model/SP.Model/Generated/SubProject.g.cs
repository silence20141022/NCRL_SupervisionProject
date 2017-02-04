// Business class SubProject generated from SubProject
// Creator: Ray
// Created Date: [2015-01-08]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("SubProject")]
	public partial class SubProject : SPModelBase<SubProject>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectId = "ProjectId";
		public static string Prop_SubName = "SubName";
		public static string Prop_UpperLayers = "UpperLayers";
		public static string Prop_DownLayers = "DownLayers";
		public static string Prop_BuildingArea = "BuildingArea";
		public static string Prop_Height = "Height";
		public static string Prop_StructureType = "StructureType";
		public static string Prop_JiChuXingShi = "JiChuXingShi";
		public static string Prop_EngineeringLevel = "EngineeringLevel";
		public static string Prop_Description = "Description";

		#endregion

		#region Private_Variables

		private string _id;
		private string _projectId;
		private string _subName;
		private string _upperLayers;
		private string _downLayers;
		private string _buildingArea;
		private string _height;
		private string _structureType;
		private string _jiChuXingShi;
		private string _engineeringLevel;
		private string _description;


		#endregion

		#region Constructors

		public SubProject()
		{
		}

		public SubProject(
			string p_id,
			string p_projectId,
			string p_subName,
			string p_upperLayers,
			string p_downLayers,
			string p_buildingArea,
			string p_height,
			string p_structureType,
			string p_jiChuXingShi,
			string p_engineeringLevel,
			string p_description)
		{
			_id = p_id;
			_projectId = p_projectId;
			_subName = p_subName;
			_upperLayers = p_upperLayers;
			_downLayers = p_downLayers;
			_buildingArea = p_buildingArea;
			_height = p_height;
			_structureType = p_structureType;
			_jiChuXingShi = p_jiChuXingShi;
			_engineeringLevel = p_engineeringLevel;
			_description = p_description;
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
					RaisePropertyChanged(SubProject.Prop_ProjectId, oldValue, value);
				}
			}

		}

		[Property("SubName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string SubName
		{
			get { return _subName; }
			set
			{
				if ((_subName == null) || (value == null) || (!value.Equals(_subName)))
				{
                    object oldValue = _subName;
					_subName = value;
					RaisePropertyChanged(SubProject.Prop_SubName, oldValue, value);
				}
			}

		}

		[Property("UpperLayers", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string UpperLayers
		{
			get { return _upperLayers; }
			set
			{
				if ((_upperLayers == null) || (value == null) || (!value.Equals(_upperLayers)))
				{
                    object oldValue = _upperLayers;
					_upperLayers = value;
					RaisePropertyChanged(SubProject.Prop_UpperLayers, oldValue, value);
				}
			}

		}

		[Property("DownLayers", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string DownLayers
		{
			get { return _downLayers; }
			set
			{
				if ((_downLayers == null) || (value == null) || (!value.Equals(_downLayers)))
				{
                    object oldValue = _downLayers;
					_downLayers = value;
					RaisePropertyChanged(SubProject.Prop_DownLayers, oldValue, value);
				}
			}

		}

		[Property("BuildingArea", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string BuildingArea
		{
			get { return _buildingArea; }
			set
			{
				if ((_buildingArea == null) || (value == null) || (!value.Equals(_buildingArea)))
				{
                    object oldValue = _buildingArea;
					_buildingArea = value;
					RaisePropertyChanged(SubProject.Prop_BuildingArea, oldValue, value);
				}
			}

		}

		[Property("Height", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Height
		{
			get { return _height; }
			set
			{
				if ((_height == null) || (value == null) || (!value.Equals(_height)))
				{
                    object oldValue = _height;
					_height = value;
					RaisePropertyChanged(SubProject.Prop_Height, oldValue, value);
				}
			}

		}

		[Property("StructureType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string StructureType
		{
			get { return _structureType; }
			set
			{
				if ((_structureType == null) || (value == null) || (!value.Equals(_structureType)))
				{
                    object oldValue = _structureType;
					_structureType = value;
					RaisePropertyChanged(SubProject.Prop_StructureType, oldValue, value);
				}
			}

		}

		[Property("JiChuXingShi", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string JiChuXingShi
		{
			get { return _jiChuXingShi; }
			set
			{
				if ((_jiChuXingShi == null) || (value == null) || (!value.Equals(_jiChuXingShi)))
				{
                    object oldValue = _jiChuXingShi;
					_jiChuXingShi = value;
					RaisePropertyChanged(SubProject.Prop_JiChuXingShi, oldValue, value);
				}
			}

		}

		[Property("EngineeringLevel", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string EngineeringLevel
		{
			get { return _engineeringLevel; }
			set
			{
				if ((_engineeringLevel == null) || (value == null) || (!value.Equals(_engineeringLevel)))
				{
                    object oldValue = _engineeringLevel;
					_engineeringLevel = value;
					RaisePropertyChanged(SubProject.Prop_EngineeringLevel, oldValue, value);
				}
			}

		}

		[Property("Description", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 1000)]
		public string Description
		{
			get { return _description; }
			set
			{
				if ((_description == null) || (value == null) || (!value.Equals(_description)))
				{
                    object oldValue = _description;
					_description = value;
					RaisePropertyChanged(SubProject.Prop_Description, oldValue, value);
				}
			}

		}

		#endregion
	} // SubProject
}

