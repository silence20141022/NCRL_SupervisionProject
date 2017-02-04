// Business class ChouJinDetail generated from ChouJinDetail
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
	[ActiveRecord("ChouJinDetail")]
	public partial class ChouJinDetail : SPModelBase<ChouJinDetail>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ChouJinId = "ChouJinId";
		public static string Prop_ExpertId = "ExpertId";
		public static string Prop_UserName = "UserName";
		public static string Prop_ShouKuanId = "ShouKuanId";
		public static string Prop_ChouJinPercent = "ChouJinPercent";
		public static string Prop_ChouJinAmount = "ChouJinAmount";
		public static string Prop_IfCanYu = "IfCanYu";

		#endregion

		#region Private_Variables

		private string _id;
		private string _chouJinId;
		private string _expertId;
		private string _userName;
		private string _shouKuanId;
		private System.Decimal? _chouJinPercent;
		private System.Decimal? _chouJinAmount;
		private string _ifCanYu;


		#endregion

		#region Constructors

		public ChouJinDetail()
		{
		}

		public ChouJinDetail(
			string p_id,
			string p_chouJinId,
			string p_expertId,
			string p_userName,
			string p_shouKuanId,
			System.Decimal? p_chouJinPercent,
			System.Decimal? p_chouJinAmount,
			string p_ifCanYu)
		{
			_id = p_id;
			_chouJinId = p_chouJinId;
			_expertId = p_expertId;
			_userName = p_userName;
			_shouKuanId = p_shouKuanId;
			_chouJinPercent = p_chouJinPercent;
			_chouJinAmount = p_chouJinAmount;
			_ifCanYu = p_ifCanYu;
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
					RaisePropertyChanged(ChouJinDetail.Prop_ChouJinId, oldValue, value);
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
					RaisePropertyChanged(ChouJinDetail.Prop_ExpertId, oldValue, value);
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
					RaisePropertyChanged(ChouJinDetail.Prop_UserName, oldValue, value);
				}
			}

		}

		[Property("ShouKuanId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ShouKuanId
		{
			get { return _shouKuanId; }
			set
			{
				if ((_shouKuanId == null) || (value == null) || (!value.Equals(_shouKuanId)))
				{
                    object oldValue = _shouKuanId;
					_shouKuanId = value;
					RaisePropertyChanged(ChouJinDetail.Prop_ShouKuanId, oldValue, value);
				}
			}

		}

		[Property("ChouJinPercent", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? ChouJinPercent
		{
			get { return _chouJinPercent; }
			set
			{
				if (value != _chouJinPercent)
				{
                    object oldValue = _chouJinPercent;
					_chouJinPercent = value;
					RaisePropertyChanged(ChouJinDetail.Prop_ChouJinPercent, oldValue, value);
				}
			}

		}

		[Property("ChouJinAmount", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? ChouJinAmount
		{
			get { return _chouJinAmount; }
			set
			{
				if (value != _chouJinAmount)
				{
                    object oldValue = _chouJinAmount;
					_chouJinAmount = value;
					RaisePropertyChanged(ChouJinDetail.Prop_ChouJinAmount, oldValue, value);
				}
			}

		}

		[Property("IfCanYu", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string IfCanYu
		{
			get { return _ifCanYu; }
			set
			{
				if ((_ifCanYu == null) || (value == null) || (!value.Equals(_ifCanYu)))
				{
                    object oldValue = _ifCanYu;
					_ifCanYu = value;
					RaisePropertyChanged(ChouJinDetail.Prop_IfCanYu, oldValue, value);
				}
			}

		}

		#endregion
	} // ChouJinDetail
}

