// Business class ChouJinResult generated from ChouJinResult
// Creator: Ray
// Created Date: [2014-11-30]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("ChouJinResult")]
	public partial class ChouJinResult : SPModelBase<ChouJinResult>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ChouJinId = "ChouJinId";
		public static string Prop_StageAmount = "StageAmount";
		public static string Prop_ExpertId = "ExpertId";
		public static string Prop_UserName = "UserName";
		public static string Prop_AdjustAmount = "AdjustAmount";
		public static string Prop_Remark = "Remark";

		#endregion

		#region Private_Variables

		private string _id;
		private string _chouJinId;
		private System.Decimal? _stageAmount;
		private string _expertId;
		private string _userName;
		private System.Decimal? _adjustAmount;
		private string _remark;


		#endregion

		#region Constructors

		public ChouJinResult()
		{
		}

		public ChouJinResult(
			string p_id,
			string p_chouJinId,
			System.Decimal? p_stageAmount,
			string p_expertId,
			string p_userName,
			System.Decimal? p_adjustAmount,
			string p_remark)
		{
			_id = p_id;
			_chouJinId = p_chouJinId;
			_stageAmount = p_stageAmount;
			_expertId = p_expertId;
			_userName = p_userName;
			_adjustAmount = p_adjustAmount;
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

		[Property("ChouJinId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ChouJinId
		{
			get { return _chouJinId; }
			set
			{
				if ((_chouJinId == null) || (value == null) || (!value.Equals(_chouJinId)))
				{
                    object oldValue = _chouJinId;
					_chouJinId = value;
					RaisePropertyChanged(ChouJinResult.Prop_ChouJinId, oldValue, value);
				}
			}

		}

		[Property("StageAmount", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? StageAmount
		{
			get { return _stageAmount; }
			set
			{
				if (value != _stageAmount)
				{
                    object oldValue = _stageAmount;
					_stageAmount = value;
					RaisePropertyChanged(ChouJinResult.Prop_StageAmount, oldValue, value);
				}
			}

		}

		[Property("ExpertId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ExpertId
		{
			get { return _expertId; }
			set
			{
				if ((_expertId == null) || (value == null) || (!value.Equals(_expertId)))
				{
                    object oldValue = _expertId;
					_expertId = value;
					RaisePropertyChanged(ChouJinResult.Prop_ExpertId, oldValue, value);
				}
			}

		}

		[Property("UserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string UserName
		{
			get { return _userName; }
			set
			{
				if ((_userName == null) || (value == null) || (!value.Equals(_userName)))
				{
                    object oldValue = _userName;
					_userName = value;
					RaisePropertyChanged(ChouJinResult.Prop_UserName, oldValue, value);
				}
			}

		}

		[Property("AdjustAmount", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? AdjustAmount
		{
			get { return _adjustAmount; }
			set
			{
				if (value != _adjustAmount)
				{
                    object oldValue = _adjustAmount;
					_adjustAmount = value;
					RaisePropertyChanged(ChouJinResult.Prop_AdjustAmount, oldValue, value);
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
					RaisePropertyChanged(ChouJinResult.Prop_Remark, oldValue, value);
				}
			}

		}

		#endregion
	} // ChouJinResult
}

