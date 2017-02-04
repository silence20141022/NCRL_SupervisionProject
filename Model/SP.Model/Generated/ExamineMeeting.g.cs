// Business class ExamineMeeting generated from ExamineMeeting
// Creator: Ray
// Created Date: [2014-11-28]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("ExamineMeeting")]
	public partial class ExamineMeeting : SPModelBase<ExamineMeeting>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_MeetingName = "MeetingName";
		public static string Prop_MeetingTime = "MeetingTime";
		public static string Prop_MeetingPlace = "MeetingPlace";
		public static string Prop_ContractAmount = "ContractAmount";
		public static string Prop_DistributeAmount = "DistributeAmount";
		public static string Prop_DistributePercent = "DistributePercent";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_Remark = "Remark";

		#endregion

		#region Private_Variables

		private string _id;
		private string _meetingName;
		private DateTime? _meetingTime;
		private string _meetingPlace;
		private System.Decimal? _contractAmount;
		private System.Decimal? _distributeAmount;
		private System.Decimal? _distributePercent;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _remark;


		#endregion

		#region Constructors

		public ExamineMeeting()
		{
		}

		public ExamineMeeting(
			string p_id,
			string p_meetingName,
			DateTime? p_meetingTime,
			string p_meetingPlace,
			System.Decimal? p_contractAmount,
			System.Decimal? p_distributeAmount,
			System.Decimal? p_distributePercent,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_remark)
		{
			_id = p_id;
			_meetingName = p_meetingName;
			_meetingTime = p_meetingTime;
			_meetingPlace = p_meetingPlace;
			_contractAmount = p_contractAmount;
			_distributeAmount = p_distributeAmount;
			_distributePercent = p_distributePercent;
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
			set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("MeetingName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string MeetingName
		{
			get { return _meetingName; }
			set
			{
				if ((_meetingName == null) || (value == null) || (!value.Equals(_meetingName)))
				{
                    object oldValue = _meetingName;
					_meetingName = value;
					RaisePropertyChanged(ExamineMeeting.Prop_MeetingName, oldValue, value);
				}
			}

		}

		[Property("MeetingTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? MeetingTime
		{
			get { return _meetingTime; }
			set
			{
				if (value != _meetingTime)
				{
                    object oldValue = _meetingTime;
					_meetingTime = value;
					RaisePropertyChanged(ExamineMeeting.Prop_MeetingTime, oldValue, value);
				}
			}

		}

		[Property("MeetingPlace", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string MeetingPlace
		{
			get { return _meetingPlace; }
			set
			{
				if ((_meetingPlace == null) || (value == null) || (!value.Equals(_meetingPlace)))
				{
                    object oldValue = _meetingPlace;
					_meetingPlace = value;
					RaisePropertyChanged(ExamineMeeting.Prop_MeetingPlace, oldValue, value);
				}
			}

		}

		[Property("ContractAmount", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? ContractAmount
		{
			get { return _contractAmount; }
			set
			{
				if (value != _contractAmount)
				{
                    object oldValue = _contractAmount;
					_contractAmount = value;
					RaisePropertyChanged(ExamineMeeting.Prop_ContractAmount, oldValue, value);
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
					RaisePropertyChanged(ExamineMeeting.Prop_DistributeAmount, oldValue, value);
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
					RaisePropertyChanged(ExamineMeeting.Prop_DistributePercent, oldValue, value);
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
					RaisePropertyChanged(ExamineMeeting.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(ExamineMeeting.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(ExamineMeeting.Prop_CreateTime, oldValue, value);
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
					RaisePropertyChanged(ExamineMeeting.Prop_Remark, oldValue, value);
				}
			}

		}

		#endregion
	} // ExamineMeeting
}

