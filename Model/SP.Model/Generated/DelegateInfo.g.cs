// Business class DelegateInfo generated from DelegateInfo
// Creator: Ray
// Created Date: [2015-01-08]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("DelegateInfo")]
	public partial class DelegateInfo : SPModelBase<DelegateInfo>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_DelegateCode = "DelegateCode";
		public static string Prop_DengJiBenNo = "DengJiBenNo";
		public static string Prop_DelegateName = "DelegateName";
		public static string Prop_Address = "Address";
		public static string Prop_DelegateHead = "DelegateHead";
		public static string Prop_Telephone = "Telephone";
		public static string Prop_Email = "Email";
		public static string Prop_Remark = "Remark";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _delegateCode;
		private string _dengJiBenNo;
		private string _delegateName;
		private string _address;
		private string _delegateHead;
		private string _telephone;
		private string _email;
		private string _remark;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public DelegateInfo()
		{
		}

		public DelegateInfo(
			string p_id,
			string p_delegateCode,
			string p_dengJiBenNo,
			string p_delegateName,
			string p_address,
			string p_delegateHead,
			string p_telephone,
			string p_email,
			string p_remark,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_delegateCode = p_delegateCode;
			_dengJiBenNo = p_dengJiBenNo;
			_delegateName = p_delegateName;
			_address = p_address;
			_delegateHead = p_delegateHead;
			_telephone = p_telephone;
			_email = p_email;
			_remark = p_remark;
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
			set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("DelegateCode", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string DelegateCode
		{
			get { return _delegateCode; }
			set
			{
				if ((_delegateCode == null) || (value == null) || (!value.Equals(_delegateCode)))
				{
                    object oldValue = _delegateCode;
					_delegateCode = value;
					RaisePropertyChanged(DelegateInfo.Prop_DelegateCode, oldValue, value);
				}
			}

		}

		[Property("DengJiBenNo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string DengJiBenNo
		{
			get { return _dengJiBenNo; }
			set
			{
				if ((_dengJiBenNo == null) || (value == null) || (!value.Equals(_dengJiBenNo)))
				{
                    object oldValue = _dengJiBenNo;
					_dengJiBenNo = value;
					RaisePropertyChanged(DelegateInfo.Prop_DengJiBenNo, oldValue, value);
				}
			}

		}

		[Property("DelegateName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string DelegateName
		{
			get { return _delegateName; }
			set
			{
				if ((_delegateName == null) || (value == null) || (!value.Equals(_delegateName)))
				{
                    object oldValue = _delegateName;
					_delegateName = value;
					RaisePropertyChanged(DelegateInfo.Prop_DelegateName, oldValue, value);
				}
			}

		}

		[Property("Address", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string Address
		{
			get { return _address; }
			set
			{
				if ((_address == null) || (value == null) || (!value.Equals(_address)))
				{
                    object oldValue = _address;
					_address = value;
					RaisePropertyChanged(DelegateInfo.Prop_Address, oldValue, value);
				}
			}

		}

		[Property("DelegateHead", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string DelegateHead
		{
			get { return _delegateHead; }
			set
			{
				if ((_delegateHead == null) || (value == null) || (!value.Equals(_delegateHead)))
				{
                    object oldValue = _delegateHead;
					_delegateHead = value;
					RaisePropertyChanged(DelegateInfo.Prop_DelegateHead, oldValue, value);
				}
			}

		}

		[Property("Telephone", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Telephone
		{
			get { return _telephone; }
			set
			{
				if ((_telephone == null) || (value == null) || (!value.Equals(_telephone)))
				{
                    object oldValue = _telephone;
					_telephone = value;
					RaisePropertyChanged(DelegateInfo.Prop_Telephone, oldValue, value);
				}
			}

		}

		[Property("Email", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Email
		{
			get { return _email; }
			set
			{
				if ((_email == null) || (value == null) || (!value.Equals(_email)))
				{
                    object oldValue = _email;
					_email = value;
					RaisePropertyChanged(DelegateInfo.Prop_Email, oldValue, value);
				}
			}

		}

		[Property("Remark", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string Remark
		{
			get { return _remark; }
			set
			{
				if ((_remark == null) || (value == null) || (!value.Equals(_remark)))
				{
                    object oldValue = _remark;
					_remark = value;
					RaisePropertyChanged(DelegateInfo.Prop_Remark, oldValue, value);
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
					RaisePropertyChanged(DelegateInfo.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(DelegateInfo.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(DelegateInfo.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // DelegateInfo
}

