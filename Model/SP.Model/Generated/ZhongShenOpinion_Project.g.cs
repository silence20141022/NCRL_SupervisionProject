// Business class ZhongShenOpinion_Project generated from ZhongShenOpinion_Project
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
	[ActiveRecord("ZhongShenOpinion_Project")]
	public partial class ZhongShenOpinion_Project : SPModelBase<ZhongShenOpinion_Project>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectId = "ProjectId";
		public static string Prop_MajorName = "MajorName";
		public static string Prop_ZhongShenOpinion = "ZhongShenOpinion";
		public static string Prop_ShenChaName = "ShenChaName";
		public static string Prop_FuHeName = "FuHeName";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _projectId;
		private string _majorName;
		private string _zhongShenOpinion;
		private string _shenChaName;
		private string _fuHeName;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public ZhongShenOpinion_Project()
		{
		}

		public ZhongShenOpinion_Project(
			string p_id,
			string p_projectId,
			string p_majorName,
			string p_zhongShenOpinion,
			string p_shenChaName,
			string p_fuHeName,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_projectId = p_projectId;
			_majorName = p_majorName;
			_zhongShenOpinion = p_zhongShenOpinion;
			_shenChaName = p_shenChaName;
			_fuHeName = p_fuHeName;
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
					RaisePropertyChanged(ZhongShenOpinion_Project.Prop_ProjectId, oldValue, value);
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
					RaisePropertyChanged(ZhongShenOpinion_Project.Prop_MajorName, oldValue, value);
				}
			}

		}

		[Property("ZhongShenOpinion", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string ZhongShenOpinion
		{
			get { return _zhongShenOpinion; }
			set
			{
				if ((_zhongShenOpinion == null) || (value == null) || (!value.Equals(_zhongShenOpinion)))
				{
                    object oldValue = _zhongShenOpinion;
					_zhongShenOpinion = value;
					RaisePropertyChanged(ZhongShenOpinion_Project.Prop_ZhongShenOpinion, oldValue, value);
				}
			}

		}

		[Property("ShenChaName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string ShenChaName
		{
			get { return _shenChaName; }
			set
			{
				if ((_shenChaName == null) || (value == null) || (!value.Equals(_shenChaName)))
				{
                    object oldValue = _shenChaName;
					_shenChaName = value;
					RaisePropertyChanged(ZhongShenOpinion_Project.Prop_ShenChaName, oldValue, value);
				}
			}

		}

		[Property("FuHeName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string FuHeName
		{
			get { return _fuHeName; }
			set
			{
				if ((_fuHeName == null) || (value == null) || (!value.Equals(_fuHeName)))
				{
                    object oldValue = _fuHeName;
					_fuHeName = value;
					RaisePropertyChanged(ZhongShenOpinion_Project.Prop_FuHeName, oldValue, value);
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
					RaisePropertyChanged(ZhongShenOpinion_Project.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(ZhongShenOpinion_Project.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(ZhongShenOpinion_Project.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // ZhongShenOpinion_Project
}

