// Business class SalaryStage generated from SalaryStage
// Creator: Ray
// Created Date: [2014-11-10]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("SalaryStage")]
	public partial class SalaryStage : SPModelBase<SalaryStage>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Year = "Year";
		public static string Prop_Month = "Month";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_Remark = "Remark";

		#endregion

		#region Private_Variables

		private string _id;
		private string _year;
		private string _month;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _remark;


		#endregion

		#region Constructors

		public SalaryStage()
		{
		}

		public SalaryStage(
			string p_id,
			string p_year,
			string p_month,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_remark)
		{
			_id = p_id;
			_year = p_year;
			_month = p_month;
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

		[Property("Year", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Year
		{
			get { return _year; }
			set
			{
				if ((_year == null) || (value == null) || (!value.Equals(_year)))
				{
                    object oldValue = _year;
					_year = value;
					RaisePropertyChanged(SalaryStage.Prop_Year, oldValue, value);
				}
			}

		}

		[Property("Month", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Month
		{
			get { return _month; }
			set
			{
				if ((_month == null) || (value == null) || (!value.Equals(_month)))
				{
                    object oldValue = _month;
					_month = value;
					RaisePropertyChanged(SalaryStage.Prop_Month, oldValue, value);
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
					RaisePropertyChanged(SalaryStage.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(SalaryStage.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(SalaryStage.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("Remark", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string Remark
		{
			get { return _remark; }
			set
			{
				if ((_remark == null) || (value == null) || (!value.Equals(_remark)))
				{
                    object oldValue = _remark;
					_remark = value;
					RaisePropertyChanged(SalaryStage.Prop_Remark, oldValue, value);
				}
			}

		}

		#endregion
	} // SalaryStage
}

