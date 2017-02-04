// Business class SupervisionNotice generated from SupervisionNotice
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
	[ActiveRecord("SupervisionNotice")]
    public partial class SupervisionNotice : SPModelBase<SupervisionNotice>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Code = "Code";
		public static string Prop_BuildDept = "BuildDept";
		public static string Prop_ProjectId = "ProjectId";
		public static string Prop_ProjectName = "ProjectName";
		public static string Prop_PManagerId = "PManagerId";
		public static string Prop_PManagerName = "PManagerName";
		public static string Prop_ShiGongUnit = "ShiGongUnit";
		public static string Prop_NoticeDate = "NoticeDate";
		public static string Prop_NoticeContent = "NoticeContent";
		public static string Prop_State = "State";
		public static string Prop_FileId = "FileId";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_Remark = "Remark";

		#endregion

		#region Private_Variables

		private string _id;
		private string _code;
		private string _buildDept;
		private string _projectId;
		private string _projectName;
		private string _pManagerId;
		private string _pManagerName;
		private string _shiGongUnit;
		private DateTime? _noticeDate;
		private string _noticeContent;
		private string _state;
		private string _fileId;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _remark;


		#endregion

		#region Constructors

		public SupervisionNotice()
		{
		}

		public SupervisionNotice(
			string p_id,
			string p_code,
			string p_buildDept,
			string p_projectId,
			string p_projectName,
			string p_pManagerId,
			string p_pManagerName,
			string p_shiGongUnit,
			DateTime? p_noticeDate,
			string p_noticeContent,
			string p_state,
			string p_fileId,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_remark)
		{
			_id = p_id;
			_code = p_code;
			_buildDept = p_buildDept;
			_projectId = p_projectId;
			_projectName = p_projectName;
			_pManagerId = p_pManagerId;
			_pManagerName = p_pManagerName;
			_shiGongUnit = p_shiGongUnit;
			_noticeDate = p_noticeDate;
			_noticeContent = p_noticeContent;
			_state = p_state;
			_fileId = p_fileId;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_remark = p_remark;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("Code", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Code
		{
			get { return _code; }
			set
			{
				if ((_code == null) || (value == null) || (!value.Equals(_code)))
				{
                    object oldValue = _code;
					_code = value;
					RaisePropertyChanged(SupervisionNotice.Prop_Code, oldValue, value);
				}
			}

		}

		[Property("BuildDept", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string BuildDept
		{
			get { return _buildDept; }
			set
			{
				if ((_buildDept == null) || (value == null) || (!value.Equals(_buildDept)))
				{
                    object oldValue = _buildDept;
					_buildDept = value;
					RaisePropertyChanged(SupervisionNotice.Prop_BuildDept, oldValue, value);
				}
			}

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
					RaisePropertyChanged(SupervisionNotice.Prop_ProjectId, oldValue, value);
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
					RaisePropertyChanged(SupervisionNotice.Prop_ProjectName, oldValue, value);
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
					RaisePropertyChanged(SupervisionNotice.Prop_PManagerId, oldValue, value);
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
					RaisePropertyChanged(SupervisionNotice.Prop_PManagerName, oldValue, value);
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
					RaisePropertyChanged(SupervisionNotice.Prop_ShiGongUnit, oldValue, value);
				}
			}

		}

		[Property("NoticeDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? NoticeDate
		{
			get { return _noticeDate; }
			set
			{
				if (value != _noticeDate)
				{
                    object oldValue = _noticeDate;
					_noticeDate = value;
					RaisePropertyChanged(SupervisionNotice.Prop_NoticeDate, oldValue, value);
				}
			}

		}

		[Property("NoticeContent", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string NoticeContent
		{
			get { return _noticeContent; }
			set
			{
				if ((_noticeContent == null) || (value == null) || (!value.Equals(_noticeContent)))
				{
                    object oldValue = _noticeContent;
					_noticeContent = value;
					RaisePropertyChanged(SupervisionNotice.Prop_NoticeContent, oldValue, value);
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
					RaisePropertyChanged(SupervisionNotice.Prop_State, oldValue, value);
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
					RaisePropertyChanged(SupervisionNotice.Prop_FileId, oldValue, value);
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
					RaisePropertyChanged(SupervisionNotice.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(SupervisionNotice.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(SupervisionNotice.Prop_CreateTime, oldValue, value);
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
					RaisePropertyChanged(SupervisionNotice.Prop_Remark, oldValue, value);
				}
			}

		}

		#endregion
	} // SupervisionNotice
}

