// Business class CmpAttendance generated from CmpAttendance
// Creator: Ray
// Created Date: [2014-04-15]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("CmpAttendance")]
    public partial class CmpAttendance : SPModelBase<CmpAttendance>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_Year = "Year";
		public static string Prop_Month = "Month";

		#endregion

		#region Private_Variables

		private string _id;
		private int? _year;
		private int? _month;


		#endregion

		#region Constructors

		public CmpAttendance()
		{
		}

		public CmpAttendance(
			string p_id,
			int? p_year,
			int? p_month)
		{
			_id = p_id;
			_year = p_year;
			_month = p_month;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

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
					RaisePropertyChanged(CmpAttendance.Prop_Year, oldValue, value);
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
					RaisePropertyChanged(CmpAttendance.Prop_Month, oldValue, value);
				}
			}

		}

		#endregion
	} // CmpAttendance
}

