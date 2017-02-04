// Business class Expert generated from Expert
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
	[ActiveRecord("Expert")]
	public partial class Expert : SPModelBase<Expert>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_UserId = "UserId";
		public static string Prop_UserName = "UserName";
		public static string Prop_Sex = "Sex";
		public static string Prop_Email = "Email";
		public static string Prop_Phone = "Phone";
		public static string Prop_IdCard = "IdCard";
		public static string Prop_SealNumber = "SealNumber";
		public static string Prop_MajorCode = "MajorCode";
		public static string Prop_MajorName = "MajorName";
		public static string Prop_ProfessionType = "ProfessionType";
		public static string Prop_RegisteredNo = "RegisteredNo";
		public static string Prop_RegisteredDate = "RegisteredDate";
		public static string Prop_StampNo = "StampNo";
		public static string Prop_StampDate = "StampDate";
		public static string Prop_RegistrationCategories = "RegistrationCategories";
		public static string Prop_Files = "Files";
		public static string Prop_Burthen = "Burthen";
		public static string Prop_HomeAddress = "HomeAddress";
		public static string Prop_Remark = "Remark";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_SortIndex = "SortIndex";
		public static string Prop_Status = "Status";

		#endregion

		#region Private_Variables

		private string _id;
		private string _userId;
		private string _userName;
		private string _sex;
		private string _email;
		private string _phone;
		private string _idCard;
		private string _sealNumber;
		private string _majorCode;
		private string _majorName;
		private string _professionType;
		private string _registeredNo;
		private DateTime? _registeredDate;
		private string _stampNo;
		private DateTime? _stampDate;
		private string _registrationCategories;
		private string _files;
		private int? _burthen;
		private string _homeAddress;
		private string _remark;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private int? _sortIndex;
		private string _status;


		#endregion

		#region Constructors

		public Expert()
		{
		}

		public Expert(
			string p_id,
			string p_userId,
			string p_userName,
			string p_sex,
			string p_email,
			string p_phone,
			string p_idCard,
			string p_sealNumber,
			string p_majorCode,
			string p_majorName,
			string p_professionType,
			string p_registeredNo,
			DateTime? p_registeredDate,
			string p_stampNo,
			DateTime? p_stampDate,
			string p_registrationCategories,
			string p_files,
			int? p_burthen,
			string p_homeAddress,
			string p_remark,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			int? p_sortIndex,
			string p_status)
		{
			_id = p_id;
			_userId = p_userId;
			_userName = p_userName;
			_sex = p_sex;
			_email = p_email;
			_phone = p_phone;
			_idCard = p_idCard;
			_sealNumber = p_sealNumber;
			_majorCode = p_majorCode;
			_majorName = p_majorName;
			_professionType = p_professionType;
			_registeredNo = p_registeredNo;
			_registeredDate = p_registeredDate;
			_stampNo = p_stampNo;
			_stampDate = p_stampDate;
			_registrationCategories = p_registrationCategories;
			_files = p_files;
			_burthen = p_burthen;
			_homeAddress = p_homeAddress;
			_remark = p_remark;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_sortIndex = p_sortIndex;
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

		[Property("UserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string UserId
		{
			get { return _userId; }
			set
			{
				if ((_userId == null) || (value == null) || (!value.Equals(_userId)))
				{
                    object oldValue = _userId;
					_userId = value;
					RaisePropertyChanged(Expert.Prop_UserId, oldValue, value);
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
					RaisePropertyChanged(Expert.Prop_UserName, oldValue, value);
				}
			}

		}

		[Property("Sex", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Sex
		{
			get { return _sex; }
			set
			{
				if ((_sex == null) || (value == null) || (!value.Equals(_sex)))
				{
                    object oldValue = _sex;
					_sex = value;
					RaisePropertyChanged(Expert.Prop_Sex, oldValue, value);
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
					RaisePropertyChanged(Expert.Prop_Email, oldValue, value);
				}
			}

		}

		[Property("Phone", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Phone
		{
			get { return _phone; }
			set
			{
				if ((_phone == null) || (value == null) || (!value.Equals(_phone)))
				{
                    object oldValue = _phone;
					_phone = value;
					RaisePropertyChanged(Expert.Prop_Phone, oldValue, value);
				}
			}

		}

		[Property("IdCard", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public string IdCard
		{
			get { return _idCard; }
			set
			{
				if ((_idCard == null) || (value == null) || (!value.Equals(_idCard)))
				{
                    object oldValue = _idCard;
					_idCard = value;
					RaisePropertyChanged(Expert.Prop_IdCard, oldValue, value);
				}
			}

		}

		[Property("SealNumber", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string SealNumber
		{
			get { return _sealNumber; }
			set
			{
				if ((_sealNumber == null) || (value == null) || (!value.Equals(_sealNumber)))
				{
                    object oldValue = _sealNumber;
					_sealNumber = value;
					RaisePropertyChanged(Expert.Prop_SealNumber, oldValue, value);
				}
			}

		}

		[Property("MajorCode", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string MajorCode
		{
			get { return _majorCode; }
			set
			{
				if ((_majorCode == null) || (value == null) || (!value.Equals(_majorCode)))
				{
                    object oldValue = _majorCode;
					_majorCode = value;
					RaisePropertyChanged(Expert.Prop_MajorCode, oldValue, value);
				}
			}

		}

		[Property("MajorName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string MajorName
		{
			get { return _majorName; }
			set
			{
				if ((_majorName == null) || (value == null) || (!value.Equals(_majorName)))
				{
                    object oldValue = _majorName;
					_majorName = value;
					RaisePropertyChanged(Expert.Prop_MajorName, oldValue, value);
				}
			}

		}

		[Property("ProfessionType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ProfessionType
		{
			get { return _professionType; }
			set
			{
				if ((_professionType == null) || (value == null) || (!value.Equals(_professionType)))
				{
                    object oldValue = _professionType;
					_professionType = value;
					RaisePropertyChanged(Expert.Prop_ProfessionType, oldValue, value);
				}
			}

		}

		[Property("RegisteredNo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string RegisteredNo
		{
			get { return _registeredNo; }
			set
			{
				if ((_registeredNo == null) || (value == null) || (!value.Equals(_registeredNo)))
				{
                    object oldValue = _registeredNo;
					_registeredNo = value;
					RaisePropertyChanged(Expert.Prop_RegisteredNo, oldValue, value);
				}
			}

		}

		[Property("RegisteredDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? RegisteredDate
		{
			get { return _registeredDate; }
			set
			{
				if (value != _registeredDate)
				{
                    object oldValue = _registeredDate;
					_registeredDate = value;
					RaisePropertyChanged(Expert.Prop_RegisteredDate, oldValue, value);
				}
			}

		}

		[Property("StampNo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string StampNo
		{
			get { return _stampNo; }
			set
			{
				if ((_stampNo == null) || (value == null) || (!value.Equals(_stampNo)))
				{
                    object oldValue = _stampNo;
					_stampNo = value;
					RaisePropertyChanged(Expert.Prop_StampNo, oldValue, value);
				}
			}

		}

		[Property("StampDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? StampDate
		{
			get { return _stampDate; }
			set
			{
				if (value != _stampDate)
				{
                    object oldValue = _stampDate;
					_stampDate = value;
					RaisePropertyChanged(Expert.Prop_StampDate, oldValue, value);
				}
			}

		}

		[Property("RegistrationCategories", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string RegistrationCategories
		{
			get { return _registrationCategories; }
			set
			{
				if ((_registrationCategories == null) || (value == null) || (!value.Equals(_registrationCategories)))
				{
                    object oldValue = _registrationCategories;
					_registrationCategories = value;
					RaisePropertyChanged(Expert.Prop_RegistrationCategories, oldValue, value);
				}
			}

		}

		[Property("Files", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string Files
		{
			get { return _files; }
			set
			{
				if ((_files == null) || (value == null) || (!value.Equals(_files)))
				{
                    object oldValue = _files;
					_files = value;
					RaisePropertyChanged(Expert.Prop_Files, oldValue, value);
				}
			}

		}

		[Property("Burthen", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? Burthen
		{
			get { return _burthen; }
			set
			{
				if (value != _burthen)
				{
                    object oldValue = _burthen;
					_burthen = value;
					RaisePropertyChanged(Expert.Prop_Burthen, oldValue, value);
				}
			}

		}

		[Property("HomeAddress", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 300)]
		public string HomeAddress
		{
			get { return _homeAddress; }
			set
			{
				if ((_homeAddress == null) || (value == null) || (!value.Equals(_homeAddress)))
				{
                    object oldValue = _homeAddress;
					_homeAddress = value;
					RaisePropertyChanged(Expert.Prop_HomeAddress, oldValue, value);
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
					RaisePropertyChanged(Expert.Prop_Remark, oldValue, value);
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
					RaisePropertyChanged(Expert.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(Expert.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(Expert.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("SortIndex", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? SortIndex
		{
			get { return _sortIndex; }
			set
			{
				if (value != _sortIndex)
				{
                    object oldValue = _sortIndex;
					_sortIndex = value;
					RaisePropertyChanged(Expert.Prop_SortIndex, oldValue, value);
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
					RaisePropertyChanged(Expert.Prop_Status, oldValue, value);
				}
			}

		}

		#endregion
	} // Expert
}

