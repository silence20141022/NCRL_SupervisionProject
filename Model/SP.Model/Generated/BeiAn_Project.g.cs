// Business class BeiAn_Project generated from BeiAn_Project
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
	[ActiveRecord("BeiAn_Project")]
	public partial class BeiAn_Project : SPModelBase<BeiAn_Project>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectId = "ProjectId";
		public static string Prop_ZhuGuanDeptName = "ZhuGuanDeptName";
		public static string Prop_BeiAnNo = "BeiAnNo";
		public static string Prop_JingBanRenOpinion = "JingBanRenOpinion";
		public static string Prop_FuZeRenOpinion = "FuZeRenOpinion";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _projectId;
		private string _zhuGuanDeptName;
		private string _beiAnNo;
		private string _jingBanRenOpinion;
		private string _fuZeRenOpinion;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public BeiAn_Project()
		{
		}

		public BeiAn_Project(
			string p_id,
			string p_projectId,
			string p_zhuGuanDeptName,
			string p_beiAnNo,
			string p_jingBanRenOpinion,
			string p_fuZeRenOpinion,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_projectId = p_projectId;
			_zhuGuanDeptName = p_zhuGuanDeptName;
			_beiAnNo = p_beiAnNo;
			_jingBanRenOpinion = p_jingBanRenOpinion;
			_fuZeRenOpinion = p_fuZeRenOpinion;
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
					RaisePropertyChanged(BeiAn_Project.Prop_ProjectId, oldValue, value);
				}
			}

		}

		[Property("ZhuGuanDeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string ZhuGuanDeptName
		{
			get { return _zhuGuanDeptName; }
			set
			{
				if ((_zhuGuanDeptName == null) || (value == null) || (!value.Equals(_zhuGuanDeptName)))
				{
                    object oldValue = _zhuGuanDeptName;
					_zhuGuanDeptName = value;
					RaisePropertyChanged(BeiAn_Project.Prop_ZhuGuanDeptName, oldValue, value);
				}
			}

		}

		[Property("BeiAnNo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string BeiAnNo
		{
			get { return _beiAnNo; }
			set
			{
				if ((_beiAnNo == null) || (value == null) || (!value.Equals(_beiAnNo)))
				{
                    object oldValue = _beiAnNo;
					_beiAnNo = value;
					RaisePropertyChanged(BeiAn_Project.Prop_BeiAnNo, oldValue, value);
				}
			}

		}

		[Property("JingBanRenOpinion", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string JingBanRenOpinion
		{
			get { return _jingBanRenOpinion; }
			set
			{
				if ((_jingBanRenOpinion == null) || (value == null) || (!value.Equals(_jingBanRenOpinion)))
				{
                    object oldValue = _jingBanRenOpinion;
					_jingBanRenOpinion = value;
					RaisePropertyChanged(BeiAn_Project.Prop_JingBanRenOpinion, oldValue, value);
				}
			}

		}

		[Property("FuZeRenOpinion", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string FuZeRenOpinion
		{
			get { return _fuZeRenOpinion; }
			set
			{
				if ((_fuZeRenOpinion == null) || (value == null) || (!value.Equals(_fuZeRenOpinion)))
				{
                    object oldValue = _fuZeRenOpinion;
					_fuZeRenOpinion = value;
					RaisePropertyChanged(BeiAn_Project.Prop_FuZeRenOpinion, oldValue, value);
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
					RaisePropertyChanged(BeiAn_Project.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(BeiAn_Project.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(BeiAn_Project.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // BeiAn_Project
}

