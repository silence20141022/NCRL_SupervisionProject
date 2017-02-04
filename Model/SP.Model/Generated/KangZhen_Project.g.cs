// Business class KangZhen_Project generated from KangZhen_Project
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
	[ActiveRecord("KangZhen_Project")]
	public partial class KangZhen_Project : SPModelBase<KangZhen_Project>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectId = "ProjectId";
		public static string Prop_ZhuCeJieGouShi = "ZhuCeJieGouShi";
		public static string Prop_DiCengHeight = "DiCengHeight";
		public static string Prop_CengShu = "CengShu";
		public static string Prop_YanKouHeight = "YanKouHeight";
		public static string Prop_IfChangDiCeDing = "IfChangDiCeDing";
		public static string Prop_ShangBuJieGou = "ShangBuJieGou";
		public static string Prop_ChangDiTuLeiBie = "ChangDiTuLeiBie";
		public static string Prop_KangZhenDengJi = "KangZhenDengJi";
		public static string Prop_ZhuanXiangShenChaOpinion = "ZhuanXiangShenChaOpinion";
		public static string Prop_BuMenJianGuanOpinion = "BuMenJianGuanOpinion";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _projectId;
		private string _zhuCeJieGouShi;
		private string _diCengHeight;
		private string _cengShu;
		private string _yanKouHeight;
		private string _ifChangDiCeDing;
		private string _shangBuJieGou;
		private string _changDiTuLeiBie;
		private string _kangZhenDengJi;
		private string _zhuanXiangShenChaOpinion;
		private string _buMenJianGuanOpinion;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public KangZhen_Project()
		{
		}

		public KangZhen_Project(
			string p_id,
			string p_projectId,
			string p_zhuCeJieGouShi,
			string p_diCengHeight,
			string p_cengShu,
			string p_yanKouHeight,
			string p_ifChangDiCeDing,
			string p_shangBuJieGou,
			string p_changDiTuLeiBie,
			string p_kangZhenDengJi,
			string p_zhuanXiangShenChaOpinion,
			string p_buMenJianGuanOpinion,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_projectId = p_projectId;
			_zhuCeJieGouShi = p_zhuCeJieGouShi;
			_diCengHeight = p_diCengHeight;
			_cengShu = p_cengShu;
			_yanKouHeight = p_yanKouHeight;
			_ifChangDiCeDing = p_ifChangDiCeDing;
			_shangBuJieGou = p_shangBuJieGou;
			_changDiTuLeiBie = p_changDiTuLeiBie;
			_kangZhenDengJi = p_kangZhenDengJi;
			_zhuanXiangShenChaOpinion = p_zhuanXiangShenChaOpinion;
			_buMenJianGuanOpinion = p_buMenJianGuanOpinion;
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
					RaisePropertyChanged(KangZhen_Project.Prop_ProjectId, oldValue, value);
				}
			}

		}

		[Property("ZhuCeJieGouShi", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ZhuCeJieGouShi
		{
			get { return _zhuCeJieGouShi; }
			set
			{
				if ((_zhuCeJieGouShi == null) || (value == null) || (!value.Equals(_zhuCeJieGouShi)))
				{
                    object oldValue = _zhuCeJieGouShi;
					_zhuCeJieGouShi = value;
					RaisePropertyChanged(KangZhen_Project.Prop_ZhuCeJieGouShi, oldValue, value);
				}
			}

		}

		[Property("DiCengHeight", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string DiCengHeight
		{
			get { return _diCengHeight; }
			set
			{
				if ((_diCengHeight == null) || (value == null) || (!value.Equals(_diCengHeight)))
				{
                    object oldValue = _diCengHeight;
					_diCengHeight = value;
					RaisePropertyChanged(KangZhen_Project.Prop_DiCengHeight, oldValue, value);
				}
			}

		}

		[Property("CengShu", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string CengShu
		{
			get { return _cengShu; }
			set
			{
				if ((_cengShu == null) || (value == null) || (!value.Equals(_cengShu)))
				{
                    object oldValue = _cengShu;
					_cengShu = value;
					RaisePropertyChanged(KangZhen_Project.Prop_CengShu, oldValue, value);
				}
			}

		}

		[Property("YanKouHeight", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string YanKouHeight
		{
			get { return _yanKouHeight; }
			set
			{
				if ((_yanKouHeight == null) || (value == null) || (!value.Equals(_yanKouHeight)))
				{
                    object oldValue = _yanKouHeight;
					_yanKouHeight = value;
					RaisePropertyChanged(KangZhen_Project.Prop_YanKouHeight, oldValue, value);
				}
			}

		}

		[Property("IfChangDiCeDing", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string IfChangDiCeDing
		{
			get { return _ifChangDiCeDing; }
			set
			{
				if ((_ifChangDiCeDing == null) || (value == null) || (!value.Equals(_ifChangDiCeDing)))
				{
                    object oldValue = _ifChangDiCeDing;
					_ifChangDiCeDing = value;
					RaisePropertyChanged(KangZhen_Project.Prop_IfChangDiCeDing, oldValue, value);
				}
			}

		}

		[Property("ShangBuJieGou", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ShangBuJieGou
		{
			get { return _shangBuJieGou; }
			set
			{
				if ((_shangBuJieGou == null) || (value == null) || (!value.Equals(_shangBuJieGou)))
				{
                    object oldValue = _shangBuJieGou;
					_shangBuJieGou = value;
					RaisePropertyChanged(KangZhen_Project.Prop_ShangBuJieGou, oldValue, value);
				}
			}

		}

		[Property("ChangDiTuLeiBie", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ChangDiTuLeiBie
		{
			get { return _changDiTuLeiBie; }
			set
			{
				if ((_changDiTuLeiBie == null) || (value == null) || (!value.Equals(_changDiTuLeiBie)))
				{
                    object oldValue = _changDiTuLeiBie;
					_changDiTuLeiBie = value;
					RaisePropertyChanged(KangZhen_Project.Prop_ChangDiTuLeiBie, oldValue, value);
				}
			}

		}

		[Property("KangZhenDengJi", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string KangZhenDengJi
		{
			get { return _kangZhenDengJi; }
			set
			{
				if ((_kangZhenDengJi == null) || (value == null) || (!value.Equals(_kangZhenDengJi)))
				{
                    object oldValue = _kangZhenDengJi;
					_kangZhenDengJi = value;
					RaisePropertyChanged(KangZhen_Project.Prop_KangZhenDengJi, oldValue, value);
				}
			}

		}

		[Property("ZhuanXiangShenChaOpinion", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string ZhuanXiangShenChaOpinion
		{
			get { return _zhuanXiangShenChaOpinion; }
			set
			{
				if ((_zhuanXiangShenChaOpinion == null) || (value == null) || (!value.Equals(_zhuanXiangShenChaOpinion)))
				{
                    object oldValue = _zhuanXiangShenChaOpinion;
					_zhuanXiangShenChaOpinion = value;
					RaisePropertyChanged(KangZhen_Project.Prop_ZhuanXiangShenChaOpinion, oldValue, value);
				}
			}

		}

		[Property("BuMenJianGuanOpinion", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string BuMenJianGuanOpinion
		{
			get { return _buMenJianGuanOpinion; }
			set
			{
				if ((_buMenJianGuanOpinion == null) || (value == null) || (!value.Equals(_buMenJianGuanOpinion)))
				{
                    object oldValue = _buMenJianGuanOpinion;
					_buMenJianGuanOpinion = value;
					RaisePropertyChanged(KangZhen_Project.Prop_BuMenJianGuanOpinion, oldValue, value);
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
					RaisePropertyChanged(KangZhen_Project.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(KangZhen_Project.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(KangZhen_Project.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // KangZhen_Project
}

