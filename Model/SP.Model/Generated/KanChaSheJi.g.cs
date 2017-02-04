// Business class KanChaSheJi generated from KanChaSheJi
// Creator: Ray
// Created Date: [2014-05-07]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("KanChaSheJi")]
    public partial class KanChaSheJi : SPModelBase<KanChaSheJi>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectId = "ProjectId";
		public static string Prop_UserName = "UserName";
		public static string Prop_ShenFenZhengNo = "ShenFenZhengNo";
		public static string Prop_MajorCode = "MajorCode";
		public static string Prop_MajorName = "MajorName";
		public static string Prop_Position = "Position";
		public static string Prop_SealNo = "SealNo";

		#endregion

		#region Private_Variables

		private string _id;
		private string _projectId;
		private string _userName;
		private string _shenFenZhengNo;
		private string _majorCode;
		private string _majorName;
		private string _position;
		private string _sealNo;


		#endregion

		#region Constructors

		public KanChaSheJi()
		{
		}

		public KanChaSheJi(
			string p_id,
			string p_projectId,
			string p_userName,
			string p_shenFenZhengNo,
			string p_majorCode,
			string p_majorName,
			string p_position,
			string p_sealNo)
		{
			_id = p_id;
			_projectId = p_projectId;
			_userName = p_userName;
			_shenFenZhengNo = p_shenFenZhengNo;
			_majorCode = p_majorCode;
			_majorName = p_majorName;
			_position = p_position;
			_sealNo = p_sealNo;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

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
					RaisePropertyChanged(KanChaSheJi.Prop_ProjectId, oldValue, value);
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
					RaisePropertyChanged(KanChaSheJi.Prop_UserName, oldValue, value);
				}
			}

		}

		[Property("ShenFenZhengNo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ShenFenZhengNo
		{
			get { return _shenFenZhengNo; }
			set
			{
				if ((_shenFenZhengNo == null) || (value == null) || (!value.Equals(_shenFenZhengNo)))
				{
                    object oldValue = _shenFenZhengNo;
					_shenFenZhengNo = value;
					RaisePropertyChanged(KanChaSheJi.Prop_ShenFenZhengNo, oldValue, value);
				}
			}

		}

		[Property("MajorCode", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string MajorCode
		{
			get { return _majorCode; }
			set
			{
				if ((_majorCode == null) || (value == null) || (!value.Equals(_majorCode)))
				{
                    object oldValue = _majorCode;
					_majorCode = value;
					RaisePropertyChanged(KanChaSheJi.Prop_MajorCode, oldValue, value);
				}
			}

		}

		[Property("MajorName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string MajorName
		{
			get { return _majorName; }
			set
			{
				if ((_majorName == null) || (value == null) || (!value.Equals(_majorName)))
				{
                    object oldValue = _majorName;
					_majorName = value;
					RaisePropertyChanged(KanChaSheJi.Prop_MajorName, oldValue, value);
				}
			}

		}

		[Property("Position", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Position
		{
			get { return _position; }
			set
			{
				if ((_position == null) || (value == null) || (!value.Equals(_position)))
				{
                    object oldValue = _position;
					_position = value;
					RaisePropertyChanged(KanChaSheJi.Prop_Position, oldValue, value);
				}
			}

		}

		[Property("SealNo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string SealNo
		{
			get { return _sealNo; }
			set
			{
				if ((_sealNo == null) || (value == null) || (!value.Equals(_sealNo)))
				{
                    object oldValue = _sealNo;
					_sealNo = value;
					RaisePropertyChanged(KanChaSheJi.Prop_SealNo, oldValue, value);
				}
			}

		}

		#endregion
	} // KanChaSheJi
}

