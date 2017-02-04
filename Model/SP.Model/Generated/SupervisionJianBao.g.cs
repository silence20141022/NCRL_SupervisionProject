// Business class SupervisionJianBao generated from SupervisionJianBao
// Creator: Ray
// Created Date: [2014-05-04]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("SupervisionJianBao")]
    public partial class SupervisionJianBao : SPModelBase<SupervisionJianBao>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectId = "ProjectId";
		public static string Prop_ProjectName = "ProjectName";
		public static string Prop_PManagerId = "PManagerId";
		public static string Prop_PManagerName = "PManagerName";
		public static string Prop_ShiGongUnit = "ShiGongUnit";
		public static string Prop_WorkRecord = "WorkRecord";
		public static string Prop_Year = "Year";
		public static string Prop_Month = "Month";
		public static string Prop_FileId = "FileId";
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
		private string _workRecord;
		private int? _year;
		private int? _month;
		private string _fileId;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public SupervisionJianBao()
		{
		}

		public SupervisionJianBao(
			string p_id,
			string p_projectId,
			string p_projectName,
			string p_pManagerId,
			string p_pManagerName,
			string p_shiGongUnit,
			string p_workRecord,
			int? p_year,
			int? p_month,
			string p_fileId,
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
			_workRecord = p_workRecord;
			_year = p_year;
			_month = p_month;
			_fileId = p_fileId;
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
					RaisePropertyChanged(SupervisionJianBao.Prop_ProjectId, oldValue, value);
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
					RaisePropertyChanged(SupervisionJianBao.Prop_ProjectName, oldValue, value);
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
					RaisePropertyChanged(SupervisionJianBao.Prop_PManagerId, oldValue, value);
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
					RaisePropertyChanged(SupervisionJianBao.Prop_PManagerName, oldValue, value);
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
					RaisePropertyChanged(SupervisionJianBao.Prop_ShiGongUnit, oldValue, value);
				}
			}

		}

		[Property("WorkRecord", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string WorkRecord
		{
			get { return _workRecord; }
			set
			{
				if ((_workRecord == null) || (value == null) || (!value.Equals(_workRecord)))
				{
                    object oldValue = _workRecord;
					_workRecord = value;
					RaisePropertyChanged(SupervisionJianBao.Prop_WorkRecord, oldValue, value);
				}
			}

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
					RaisePropertyChanged(SupervisionJianBao.Prop_Year, oldValue, value);
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
					RaisePropertyChanged(SupervisionJianBao.Prop_Month, oldValue, value);
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
					RaisePropertyChanged(SupervisionJianBao.Prop_FileId, oldValue, value);
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
					RaisePropertyChanged(SupervisionJianBao.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(SupervisionJianBao.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(SupervisionJianBao.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // SupervisionJianBao
}

