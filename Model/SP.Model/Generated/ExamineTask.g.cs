// Business class ExamineTask generated from ExamineTask
// Creator: Ray
// Created Date: [2014-08-21]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("ExamineTask")]
	public partial class ExamineTask : SPModelBase<ExamineTask>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectId = "ProjectId";
		public static string Prop_ProjectUserId = "ProjectUserId";
		public static string Prop_MajorName = "MajorName";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_PlanBackTime = "PlanBackTime";
		public static string Prop_State = "State";

		#endregion

		#region Private_Variables

		private string _id;
		private string _projectId;
		private string _projectUserId;
		private string _majorName;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private DateTime? _planBackTime;
		private string _state;


		#endregion

		#region Constructors

		public ExamineTask()
		{
		}

		public ExamineTask(
			string p_id,
			string p_projectId,
			string p_projectUserId,
			string p_majorName,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			DateTime? p_planBackTime,
			string p_state)
		{
			_id = p_id;
			_projectId = p_projectId;
			_projectUserId = p_projectUserId;
			_majorName = p_majorName;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_planBackTime = p_planBackTime;
			_state = p_state;
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
					RaisePropertyChanged(ExamineTask.Prop_ProjectId, oldValue, value);
				}
			}

		}

		[Property("ProjectUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ProjectUserId
		{
			get { return _projectUserId; }
			set
			{
				if ((_projectUserId == null) || (value == null) || (!value.Equals(_projectUserId)))
				{
                    object oldValue = _projectUserId;
					_projectUserId = value;
					RaisePropertyChanged(ExamineTask.Prop_ProjectUserId, oldValue, value);
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
					RaisePropertyChanged(ExamineTask.Prop_MajorName, oldValue, value);
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
					RaisePropertyChanged(ExamineTask.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(ExamineTask.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(ExamineTask.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("PlanBackTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? PlanBackTime
		{
			get { return _planBackTime; }
			set
			{
				if (value != _planBackTime)
				{
                    object oldValue = _planBackTime;
					_planBackTime = value;
					RaisePropertyChanged(ExamineTask.Prop_PlanBackTime, oldValue, value);
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
					RaisePropertyChanged(ExamineTask.Prop_State, oldValue, value);
				}
			}

		}

		#endregion
	} // ExamineTask
}

