// Business class WorkLianXi generated from WorkLianXi
// Creator: Ray
// Created Date: [2015-02-09]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("WorkLianXi")]
	public partial class WorkLianXi : SPModelBase<WorkLianXi>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Title = "Title";
		public static string Prop_JinJiDegree = "JinJiDegree";
		public static string Prop_SendUserId = "SendUserId";
		public static string Prop_SendUserName = "SendUserName";
		public static string Prop_ReceiveUserIds = "ReceiveUserIds";
		public static string Prop_ReceiveUserNames = "ReceiveUserNames";
		public static string Prop_ChaoSongUserIds = "ChaoSongUserIds";
		public static string Prop_ChaoSongUserNames = "ChaoSongUserNames";
		public static string Prop_YaoQiuFinishTime = "YaoQiuFinishTime";
		public static string Prop_WorkContent = "WorkContent";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_Status = "Status";
		public static string Prop_SendTime = "SendTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _title;
		private string _jinJiDegree;
		private string _sendUserId;
		private string _sendUserName;
		private string _receiveUserIds;
		private string _receiveUserNames;
		private string _chaoSongUserIds;
		private string _chaoSongUserNames;
		private DateTime? _yaoQiuFinishTime;
		private string _workContent;
		private DateTime? _createTime;
		private string _status;
		private DateTime? _sendTime;


		#endregion

		#region Constructors

		public WorkLianXi()
		{
		}

		public WorkLianXi(
			string p_id,
			string p_title,
			string p_jinJiDegree,
			string p_sendUserId,
			string p_sendUserName,
			string p_receiveUserIds,
			string p_receiveUserNames,
			string p_chaoSongUserIds,
			string p_chaoSongUserNames,
			DateTime? p_yaoQiuFinishTime,
			string p_workContent,
			DateTime? p_createTime,
			string p_status,
			DateTime? p_sendTime)
		{
			_id = p_id;
			_title = p_title;
			_jinJiDegree = p_jinJiDegree;
			_sendUserId = p_sendUserId;
			_sendUserName = p_sendUserName;
			_receiveUserIds = p_receiveUserIds;
			_receiveUserNames = p_receiveUserNames;
			_chaoSongUserIds = p_chaoSongUserIds;
			_chaoSongUserNames = p_chaoSongUserNames;
			_yaoQiuFinishTime = p_yaoQiuFinishTime;
			_workContent = p_workContent;
			_createTime = p_createTime;
			_status = p_status;
			_sendTime = p_sendTime;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("Title", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string Title
		{
			get { return _title; }
			set
			{
				if ((_title == null) || (value == null) || (!value.Equals(_title)))
				{
                    object oldValue = _title;
					_title = value;
					RaisePropertyChanged(WorkLianXi.Prop_Title, oldValue, value);
				}
			}

		}

		[Property("JinJiDegree", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string JinJiDegree
		{
			get { return _jinJiDegree; }
			set
			{
				if ((_jinJiDegree == null) || (value == null) || (!value.Equals(_jinJiDegree)))
				{
                    object oldValue = _jinJiDegree;
					_jinJiDegree = value;
					RaisePropertyChanged(WorkLianXi.Prop_JinJiDegree, oldValue, value);
				}
			}

		}

		[Property("SendUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string SendUserId
		{
			get { return _sendUserId; }
			set
			{
				if ((_sendUserId == null) || (value == null) || (!value.Equals(_sendUserId)))
				{
                    object oldValue = _sendUserId;
					_sendUserId = value;
					RaisePropertyChanged(WorkLianXi.Prop_SendUserId, oldValue, value);
				}
			}

		}

		[Property("SendUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string SendUserName
		{
			get { return _sendUserName; }
			set
			{
				if ((_sendUserName == null) || (value == null) || (!value.Equals(_sendUserName)))
				{
                    object oldValue = _sendUserName;
					_sendUserName = value;
					RaisePropertyChanged(WorkLianXi.Prop_SendUserName, oldValue, value);
				}
			}

		}

		[Property("ReceiveUserIds", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string ReceiveUserIds
		{
			get { return _receiveUserIds; }
			set
			{
				if ((_receiveUserIds == null) || (value == null) || (!value.Equals(_receiveUserIds)))
				{
                    object oldValue = _receiveUserIds;
					_receiveUserIds = value;
					RaisePropertyChanged(WorkLianXi.Prop_ReceiveUserIds, oldValue, value);
				}
			}

		}

		[Property("ReceiveUserNames", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string ReceiveUserNames
		{
			get { return _receiveUserNames; }
			set
			{
				if ((_receiveUserNames == null) || (value == null) || (!value.Equals(_receiveUserNames)))
				{
                    object oldValue = _receiveUserNames;
					_receiveUserNames = value;
					RaisePropertyChanged(WorkLianXi.Prop_ReceiveUserNames, oldValue, value);
				}
			}

		}

		[Property("ChaoSongUserIds", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string ChaoSongUserIds
		{
			get { return _chaoSongUserIds; }
			set
			{
				if ((_chaoSongUserIds == null) || (value == null) || (!value.Equals(_chaoSongUserIds)))
				{
                    object oldValue = _chaoSongUserIds;
					_chaoSongUserIds = value;
					RaisePropertyChanged(WorkLianXi.Prop_ChaoSongUserIds, oldValue, value);
				}
			}

		}

		[Property("ChaoSongUserNames", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string ChaoSongUserNames
		{
			get { return _chaoSongUserNames; }
			set
			{
				if ((_chaoSongUserNames == null) || (value == null) || (!value.Equals(_chaoSongUserNames)))
				{
                    object oldValue = _chaoSongUserNames;
					_chaoSongUserNames = value;
					RaisePropertyChanged(WorkLianXi.Prop_ChaoSongUserNames, oldValue, value);
				}
			}

		}

		[Property("YaoQiuFinishTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? YaoQiuFinishTime
		{
			get { return _yaoQiuFinishTime; }
			set
			{
				if (value != _yaoQiuFinishTime)
				{
                    object oldValue = _yaoQiuFinishTime;
					_yaoQiuFinishTime = value;
					RaisePropertyChanged(WorkLianXi.Prop_YaoQiuFinishTime, oldValue, value);
				}
			}

		}

		[Property("WorkContent", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string WorkContent
		{
			get { return _workContent; }
			set
			{
				if ((_workContent == null) || (value == null) || (!value.Equals(_workContent)))
				{
                    object oldValue = _workContent;
					_workContent = value;
					RaisePropertyChanged(WorkLianXi.Prop_WorkContent, oldValue, value);
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
					RaisePropertyChanged(WorkLianXi.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("Status", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Status
		{
			get { return _status; }
			set
			{
				if ((_status == null) || (value == null) || (!value.Equals(_status)))
				{
                    object oldValue = _status;
					_status = value;
					RaisePropertyChanged(WorkLianXi.Prop_Status, oldValue, value);
				}
			}

		}

		[Property("SendTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? SendTime
		{
			get { return _sendTime; }
			set
			{
				if (value != _sendTime)
				{
                    object oldValue = _sendTime;
					_sendTime = value;
					RaisePropertyChanged(WorkLianXi.Prop_SendTime, oldValue, value);
				}
			}

		}

		#endregion
	} // WorkLianXi
}

