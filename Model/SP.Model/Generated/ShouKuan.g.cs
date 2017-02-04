// Business class ShouKuan generated from ShouKuan
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
	[ActiveRecord("ShouKuan")]
	public partial class ShouKuan : SPModelBase<ShouKuan>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectId = "ProjectId";
		public static string Prop_ShouKuanAmount = "ShouKuanAmount";
		public static string Prop_ShouKuanDate = "ShouKuanDate";
		public static string Prop_InvoiceId = "InvoiceId";
		public static string Prop_ShiJiShouFei = "ShiJiShouFei";
		public static string Prop_ChouJinAmount = "ChouJinAmount";
		public static string Prop_YiFenPercent = "YiFenPercent";
		public static string Prop_ChouJinId = "ChouJinId";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_Remark = "Remark";
		public static string Prop_Status = "Status";

		#endregion

		#region Private_Variables

		private string _id;
		private string _projectId;
		private System.Decimal? _shouKuanAmount;
		private DateTime? _shouKuanDate;
		private string _invoiceId;
		private System.Decimal? _shiJiShouFei;
		private System.Decimal? _chouJinAmount;
		private System.Decimal? _yiFenPercent;
		private string _chouJinId;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _remark;
		private string _status;


		#endregion

		#region Constructors

		public ShouKuan()
		{
		}

		public ShouKuan(
			string p_id,
			string p_projectId,
			System.Decimal? p_shouKuanAmount,
			DateTime? p_shouKuanDate,
			string p_invoiceId,
			System.Decimal? p_shiJiShouFei,
			System.Decimal? p_chouJinAmount,
			System.Decimal? p_yiFenPercent,
			string p_chouJinId,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_remark,
			string p_status)
		{
			_id = p_id;
			_projectId = p_projectId;
			_shouKuanAmount = p_shouKuanAmount;
			_shouKuanDate = p_shouKuanDate;
			_invoiceId = p_invoiceId;
			_shiJiShouFei = p_shiJiShouFei;
			_chouJinAmount = p_chouJinAmount;
			_yiFenPercent = p_yiFenPercent;
			_chouJinId = p_chouJinId;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_remark = p_remark;
			_status = p_status;
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
					RaisePropertyChanged(ShouKuan.Prop_ProjectId, oldValue, value);
				}
			}

		}

		[Property("ShouKuanAmount", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? ShouKuanAmount
		{
			get { return _shouKuanAmount; }
			set
			{
				if (value != _shouKuanAmount)
				{
                    object oldValue = _shouKuanAmount;
					_shouKuanAmount = value;
					RaisePropertyChanged(ShouKuan.Prop_ShouKuanAmount, oldValue, value);
				}
			}

		}

		[Property("ShouKuanDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? ShouKuanDate
		{
			get { return _shouKuanDate; }
			set
			{
				if (value != _shouKuanDate)
				{
                    object oldValue = _shouKuanDate;
					_shouKuanDate = value;
					RaisePropertyChanged(ShouKuan.Prop_ShouKuanDate, oldValue, value);
				}
			}

		}

		[Property("InvoiceId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string InvoiceId
		{
			get { return _invoiceId; }
			set
			{
				if ((_invoiceId == null) || (value == null) || (!value.Equals(_invoiceId)))
				{
                    object oldValue = _invoiceId;
					_invoiceId = value;
					RaisePropertyChanged(ShouKuan.Prop_InvoiceId, oldValue, value);
				}
			}

		}

		[Property("ShiJiShouFei", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? ShiJiShouFei
		{
			get { return _shiJiShouFei; }
			set
			{
				if (value != _shiJiShouFei)
				{
                    object oldValue = _shiJiShouFei;
					_shiJiShouFei = value;
					RaisePropertyChanged(ShouKuan.Prop_ShiJiShouFei, oldValue, value);
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
					RaisePropertyChanged(ShouKuan.Prop_ChouJinAmount, oldValue, value);
				}
			}

		}

		[Property("YiFenPercent", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? YiFenPercent
		{
			get { return _yiFenPercent; }
			set
			{
				if (value != _yiFenPercent)
				{
                    object oldValue = _yiFenPercent;
					_yiFenPercent = value;
					RaisePropertyChanged(ShouKuan.Prop_YiFenPercent, oldValue, value);
				}
			}

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
					RaisePropertyChanged(ShouKuan.Prop_ChouJinId, oldValue, value);
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
					RaisePropertyChanged(ShouKuan.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(ShouKuan.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(ShouKuan.Prop_CreateTime, oldValue, value);
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
					RaisePropertyChanged(ShouKuan.Prop_Remark, oldValue, value);
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
					RaisePropertyChanged(ShouKuan.Prop_Status, oldValue, value);
				}
			}

		}

		#endregion
	} // ShouKuan
}

