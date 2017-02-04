// Business class SendEmail generated from SendEmail
// Creator: Ray
// Created Date: [2014-05-09]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("SendEmail")]
    public partial class SendEmail : SPModelBase<SendEmail>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ExamineTaskId = "ExamineTaskId";
		public static string Prop_State = "State";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _examineTaskId;
		private string _state;
		private string _createId;
		private string _createName;
		private string _createTime;


		#endregion

		#region Constructors

		public SendEmail()
		{
		}

		public SendEmail(
			string p_id,
			string p_examineTaskId,
			string p_state,
			string p_createId,
			string p_createName,
			string p_createTime)
		{
			_id = p_id;
			_examineTaskId = p_examineTaskId;
			_state = p_state;
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

		[Property("ExamineTaskId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ExamineTaskId
		{
			get { return _examineTaskId; }
			set
			{
				if ((_examineTaskId == null) || (value == null) || (!value.Equals(_examineTaskId)))
				{
                    object oldValue = _examineTaskId;
					_examineTaskId = value;
					RaisePropertyChanged(SendEmail.Prop_ExamineTaskId, oldValue, value);
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
					RaisePropertyChanged(SendEmail.Prop_State, oldValue, value);
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
					RaisePropertyChanged(SendEmail.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(SendEmail.Prop_CreateName, oldValue, value);
				}
			}

		}

		[Property("CreateTime", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string CreateTime
		{
			get { return _createTime; }
			set
			{
				if ((_createTime == null) || (value == null) || (!value.Equals(_createTime)))
				{
                    object oldValue = _createTime;
					_createTime = value;
					RaisePropertyChanged(SendEmail.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // SendEmail
}

