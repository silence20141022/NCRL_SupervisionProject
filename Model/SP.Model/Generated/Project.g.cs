// Business class Project generated from Project
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
	[ActiveRecord("Project")]
	public partial class Project : SPModelBase<Project>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ProjectCode = "ProjectCode";
		public static string Prop_ProjectName = "ProjectName";
		public static string Prop_Zone = "Zone";
		public static string Prop_ZoneSecond = "ZoneSecond";
		public static string Prop_DetailLocation = "DetailLocation";
		public static string Prop_PManagerId = "PManagerId";
		public static string Prop_PManagerName = "PManagerName";
		public static string Prop_BelongDeptId = "BelongDeptId";
		public static string Prop_BelongDeptName = "BelongDeptName";
		public static string Prop_JianSheUnit = "JianSheUnit";
		public static string Prop_JianSheUnitHead = "JianSheUnitHead";
		public static string Prop_JianSheUnitHeadTel = "JianSheUnitHeadTel";
		public static string Prop_ProjectType = "ProjectType";
		public static string Prop_Property = "Property";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";
		public static string Prop_ShiGongUnit = "ShiGongUnit";
		public static string Prop_Status = "Status";
		public static string Prop_PMRenMingHanId = "PMRenMingHanId";
		public static string Prop_JianLiGuiHuaId = "JianLiGuiHuaId";
		public static string Prop_ConstructionUnitName = "ConstructionUnitName";
		public static string Prop_ConstructionUnitID = "ConstructionUnitID";
		public static string Prop_SheJiUnit = "SheJiUnit";
		public static string Prop_SheJiUnitHead = "SheJiUnitHead";
		public static string Prop_SheJiUnitGrade = "SheJiUnitGrade";
		public static string Prop_SheJiUnitZSNo = "SheJiUnitZSNo";
		public static string Prop_SheJiUnitBeiAnNo = "SheJiUnitBeiAnNo";
		public static string Prop_KanChaUnit = "KanChaUnit";
		public static string Prop_KanChaUnitHead = "KanChaUnitHead";
		public static string Prop_KanChaUnitZSNo = "KanChaUnitZSNo";
		public static string Prop_KanChaUnitBeiAnNo = "KanChaUnitBeiAnNo";
		public static string Prop_KanChaType = "KanChaType";
		public static string Prop_KanChaGCLevel = "KanChaGCLevel";
		public static string Prop_KanChaZZLevel = "KanChaZZLevel";
		public static string Prop_ZuanKongJinChi = "ZuanKongJinChi";
		public static string Prop_Height = "Height";
		public static string Prop_UpperLayers = "UpperLayers";
		public static string Prop_DownLayers = "DownLayers";
		public static string Prop_LuQiaoLength = "LuQiaoLength";
		public static string Prop_LuQiaoWidth = "LuQiaoWidth";
		public static string Prop_DiXiaMianJi = "DiXiaMianJi";
		public static string Prop_FoundationType = "FoundationType";
		public static string Prop_StructureType = "StructureType";
		public static string Prop_BuildingArea = "BuildingArea";
		public static string Prop_EngineeringLevel = "EngineeringLevel";
		public static string Prop_GongChengLeiXing = "GongChengLeiXing";
		public static string Prop_GongChengGuiMo = "GongChengGuiMo";
		public static string Prop_IfChaoBiao = "IfChaoBiao";
		public static string Prop_IfChaoGao = "IfChaoGao";
		public static string Prop_JianSheTingNo = "JianSheTingNo";
		public static string Prop_IfJieNeng = "IfJieNeng";
		public static string Prop_IfLvSe = "IfLvSe";
		public static string Prop_Investment = "Investment";
		public static string Prop_GongChenLiang = "GongChenLiang";
		public static string Prop_SongShenTime = "SongShenTime";
		public static string Prop_ZiXunCode = "ZiXunCode";
		public static string Prop_Remark = "Remark";
		public static string Prop_FangHuoLevel = "FangHuoLevel";
		public static string Prop_KangZhenLieDu = "KangZhenLieDu";
		public static string Prop_KangZhenType = "KangZhenType";
		public static string Prop_RenFangLevel = "RenFangLevel";
		public static string Prop_CaiNuanFuHe = "CaiNuanFuHe";
		public static string Prop_KongTiaoFuHe = "KongTiaoFuHe";
		public static string Prop_CaiNuanMethod = "CaiNuanMethod";
		public static string Prop_RiGongShuiLiang = "RiGongShuiLiang";
		public static string Prop_ShiNeiPaiShuiMethod = "ShiNeiPaiShuiMethod";
		public static string Prop_RuoDianContent = "RuoDianContent";
		public static string Prop_DongLiZongFuHe = "DongLiZongFuHe";
		public static string Prop_ZhaoMingDianFuHe = "ZhaoMingDianFuHe";
		public static string Prop_ShiWaiPaiShuiMethod = "ShiWaiPaiShuiMethod";
		public static string Prop_JiChuTypeMaiShen = "JiChuTypeMaiShen";
		public static string Prop_Wyjz = "Wyjz";
		public static string Prop_WyjzUser = "WyjzUser";
		public static string Prop_WyjzUnit = "WyjzUnit";
		public static string Prop_WyjzNo = "WyjzNo";
		public static string Prop_Wyjzifwfqt = "Wyjzifwfqt";
		public static string Prop_Wyjzifsmcl = "Wyjzifsmcl";
		public static string Prop_Ny = "Ny";
		public static string Prop_Nyifwfqt = "Nyifwfqt";
		public static string Prop_Nyifsmcl = "Nyifsmcl";
		public static string Prop_Wy = "Wy";
		public static string Prop_Wyifwfqt = "Wyifwfqt";
		public static string Prop_Wyifsmcl = "Wyifsmcl";
		public static string Prop_Structure = "Structure";
		public static string Prop_Building = "Building";
		public static string Prop_BelongCmp = "BelongCmp";
		public static string Prop_ContractAmount = "ContractAmount";
		public static string Prop_TaskQuan = "TaskQuan";
		public static string Prop_SubmitQuan = "SubmitQuan";
		public static string Prop_DelegateInfoId = "DelegateInfoId";
		public static string Prop_ChuangKouBiLi = "ChuangKouBiLi";
		public static string Prop_KanChaReportPrjName = "KanChaReportPrjName";

		#endregion

		#region Private_Variables

		private string _id;
		private string _projectCode;
		private string _projectName;
		private string _zone;
		private string _zoneSecond;
		private string _detailLocation;
		private string _pManagerId;
		private string _pManagerName;
		private string _belongDeptId;
		private string _belongDeptName;
		private string _jianSheUnit;
		private string _jianSheUnitHead;
		private string _jianSheUnitHeadTel;
		private string _projectType;
		private string _property;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;
		private string _shiGongUnit;
		private string _status;
		private string _pMRenMingHanId;
		private string _jianLiGuiHuaId;
		private string _constructionUnitName;
		private string _constructionUnitID;
		private string _sheJiUnit;
		private string _sheJiUnitHead;
		private string _sheJiUnitGrade;
		private string _sheJiUnitZSNo;
		private string _sheJiUnitBeiAnNo;
		private string _kanChaUnit;
		private string _kanChaUnitHead;
		private string _kanChaUnitZSNo;
		private string _kanChaUnitBeiAnNo;
		private string _kanChaType;
		private string _kanChaGCLevel;
		private string _kanChaZZLevel;
		private string _zuanKongJinChi;
		private string _height;
		private string _upperLayers;
		private string _downLayers;
		private System.Decimal? _luQiaoLength;
		private System.Decimal? _luQiaoWidth;
		private System.Decimal? _diXiaMianJi;
		private string _foundationType;
		private string _structureType;
		private string _buildingArea;
		private string _engineeringLevel;
		private string _gongChengLeiXing;
		private string _gongChengGuiMo;
		private string _ifChaoBiao;
		private string _ifChaoGao;
		private string _jianSheTingNo;
		private string _ifJieNeng;
		private string _ifLvSe;
		private System.Decimal? _investment;
		private string _gongChenLiang;
		private DateTime? _songShenTime;
		private string _ziXunCode;
		private string _remark;
		private string _fangHuoLevel;
		private string _kangZhenLieDu;
		private string _kangZhenType;
		private string _renFangLevel;
		private string _caiNuanFuHe;
		private string _kongTiaoFuHe;
		private string _caiNuanMethod;
		private string _riGongShuiLiang;
		private string _shiNeiPaiShuiMethod;
		private string _ruoDianContent;
		private string _dongLiZongFuHe;
		private string _zhaoMingDianFuHe;
		private string _shiWaiPaiShuiMethod;
		private string _jiChuTypeMaiShen;
		private string _wyjz;
		private string _wyjzUser;
		private string _wyjzUnit;
		private string _wyjzNo;
		private string _wyjzifwfqt;
		private string _wyjzifsmcl;
		private string _ny;
		private string _nyifwfqt;
		private string _nyifsmcl;
		private string _wy;
		private string _wyifwfqt;
		private string _wyifsmcl;
		private string _structure;
		private string _building;
		private string _belongCmp;
		private System.Decimal? _contractAmount;
		private int? _taskQuan;
		private int? _submitQuan;
		private string _delegateInfoId;
		private System.Decimal? _chuangKouBiLi;
		private string _kanChaReportPrjName;


		#endregion

		#region Constructors

		public Project()
		{
		}

		public Project(
			string p_id,
			string p_projectCode,
			string p_projectName,
			string p_zone,
			string p_zoneSecond,
			string p_detailLocation,
			string p_pManagerId,
			string p_pManagerName,
			string p_belongDeptId,
			string p_belongDeptName,
			string p_jianSheUnit,
			string p_jianSheUnitHead,
			string p_jianSheUnitHeadTel,
			string p_projectType,
			string p_property,
			string p_createId,
			string p_createName,
			DateTime? p_createTime,
			string p_shiGongUnit,
			string p_status,
			string p_pMRenMingHanId,
			string p_jianLiGuiHuaId,
			string p_constructionUnitName,
			string p_constructionUnitID,
			string p_sheJiUnit,
			string p_sheJiUnitHead,
			string p_sheJiUnitGrade,
			string p_sheJiUnitZSNo,
			string p_sheJiUnitBeiAnNo,
			string p_kanChaUnit,
			string p_kanChaUnitHead,
			string p_kanChaUnitZSNo,
			string p_kanChaUnitBeiAnNo,
			string p_kanChaType,
			string p_kanChaGCLevel,
			string p_kanChaZZLevel,
			string p_zuanKongJinChi,
			string p_height,
			string p_upperLayers,
			string p_downLayers,
			System.Decimal? p_luQiaoLength,
			System.Decimal? p_luQiaoWidth,
			System.Decimal? p_diXiaMianJi,
			string p_foundationType,
			string p_structureType,
			string p_buildingArea,
			string p_engineeringLevel,
			string p_gongChengLeiXing,
			string p_gongChengGuiMo,
			string p_ifChaoBiao,
			string p_ifChaoGao,
			string p_jianSheTingNo,
			string p_ifJieNeng,
			string p_ifLvSe,
			System.Decimal? p_investment,
			string p_gongChenLiang,
			DateTime? p_songShenTime,
			string p_ziXunCode,
			string p_remark,
			string p_fangHuoLevel,
			string p_kangZhenLieDu,
			string p_kangZhenType,
			string p_renFangLevel,
			string p_caiNuanFuHe,
			string p_kongTiaoFuHe,
			string p_caiNuanMethod,
			string p_riGongShuiLiang,
			string p_shiNeiPaiShuiMethod,
			string p_ruoDianContent,
			string p_dongLiZongFuHe,
			string p_zhaoMingDianFuHe,
			string p_shiWaiPaiShuiMethod,
			string p_jiChuTypeMaiShen,
			string p_wyjz,
			string p_wyjzUser,
			string p_wyjzUnit,
			string p_wyjzNo,
			string p_wyjzifwfqt,
			string p_wyjzifsmcl,
			string p_ny,
			string p_nyifwfqt,
			string p_nyifsmcl,
			string p_wy,
			string p_wyifwfqt,
			string p_wyifsmcl,
			string p_structure,
			string p_building,
			string p_belongCmp,
			System.Decimal? p_contractAmount,
			int? p_taskQuan,
			int? p_submitQuan,
			string p_delegateInfoId,
			System.Decimal? p_chuangKouBiLi,
			string p_kanChaReportPrjName)
		{
			_id = p_id;
			_projectCode = p_projectCode;
			_projectName = p_projectName;
			_zone = p_zone;
			_zoneSecond = p_zoneSecond;
			_detailLocation = p_detailLocation;
			_pManagerId = p_pManagerId;
			_pManagerName = p_pManagerName;
			_belongDeptId = p_belongDeptId;
			_belongDeptName = p_belongDeptName;
			_jianSheUnit = p_jianSheUnit;
			_jianSheUnitHead = p_jianSheUnitHead;
			_jianSheUnitHeadTel = p_jianSheUnitHeadTel;
			_projectType = p_projectType;
			_property = p_property;
			_createId = p_createId;
			_createName = p_createName;
			_createTime = p_createTime;
			_shiGongUnit = p_shiGongUnit;
			_status = p_status;
			_pMRenMingHanId = p_pMRenMingHanId;
			_jianLiGuiHuaId = p_jianLiGuiHuaId;
			_constructionUnitName = p_constructionUnitName;
			_constructionUnitID = p_constructionUnitID;
			_sheJiUnit = p_sheJiUnit;
			_sheJiUnitHead = p_sheJiUnitHead;
			_sheJiUnitGrade = p_sheJiUnitGrade;
			_sheJiUnitZSNo = p_sheJiUnitZSNo;
			_sheJiUnitBeiAnNo = p_sheJiUnitBeiAnNo;
			_kanChaUnit = p_kanChaUnit;
			_kanChaUnitHead = p_kanChaUnitHead;
			_kanChaUnitZSNo = p_kanChaUnitZSNo;
			_kanChaUnitBeiAnNo = p_kanChaUnitBeiAnNo;
			_kanChaType = p_kanChaType;
			_kanChaGCLevel = p_kanChaGCLevel;
			_kanChaZZLevel = p_kanChaZZLevel;
			_zuanKongJinChi = p_zuanKongJinChi;
			_height = p_height;
			_upperLayers = p_upperLayers;
			_downLayers = p_downLayers;
			_luQiaoLength = p_luQiaoLength;
			_luQiaoWidth = p_luQiaoWidth;
			_diXiaMianJi = p_diXiaMianJi;
			_foundationType = p_foundationType;
			_structureType = p_structureType;
			_buildingArea = p_buildingArea;
			_engineeringLevel = p_engineeringLevel;
			_gongChengLeiXing = p_gongChengLeiXing;
			_gongChengGuiMo = p_gongChengGuiMo;
			_ifChaoBiao = p_ifChaoBiao;
			_ifChaoGao = p_ifChaoGao;
			_jianSheTingNo = p_jianSheTingNo;
			_ifJieNeng = p_ifJieNeng;
			_ifLvSe = p_ifLvSe;
			_investment = p_investment;
			_gongChenLiang = p_gongChenLiang;
			_songShenTime = p_songShenTime;
			_ziXunCode = p_ziXunCode;
			_remark = p_remark;
			_fangHuoLevel = p_fangHuoLevel;
			_kangZhenLieDu = p_kangZhenLieDu;
			_kangZhenType = p_kangZhenType;
			_renFangLevel = p_renFangLevel;
			_caiNuanFuHe = p_caiNuanFuHe;
			_kongTiaoFuHe = p_kongTiaoFuHe;
			_caiNuanMethod = p_caiNuanMethod;
			_riGongShuiLiang = p_riGongShuiLiang;
			_shiNeiPaiShuiMethod = p_shiNeiPaiShuiMethod;
			_ruoDianContent = p_ruoDianContent;
			_dongLiZongFuHe = p_dongLiZongFuHe;
			_zhaoMingDianFuHe = p_zhaoMingDianFuHe;
			_shiWaiPaiShuiMethod = p_shiWaiPaiShuiMethod;
			_jiChuTypeMaiShen = p_jiChuTypeMaiShen;
			_wyjz = p_wyjz;
			_wyjzUser = p_wyjzUser;
			_wyjzUnit = p_wyjzUnit;
			_wyjzNo = p_wyjzNo;
			_wyjzifwfqt = p_wyjzifwfqt;
			_wyjzifsmcl = p_wyjzifsmcl;
			_ny = p_ny;
			_nyifwfqt = p_nyifwfqt;
			_nyifsmcl = p_nyifsmcl;
			_wy = p_wy;
			_wyifwfqt = p_wyifwfqt;
			_wyifsmcl = p_wyifsmcl;
			_structure = p_structure;
			_building = p_building;
			_belongCmp = p_belongCmp;
			_contractAmount = p_contractAmount;
			_taskQuan = p_taskQuan;
			_submitQuan = p_submitQuan;
			_delegateInfoId = p_delegateInfoId;
			_chuangKouBiLi = p_chuangKouBiLi;
			_kanChaReportPrjName = p_kanChaReportPrjName;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("ProjectCode", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ProjectCode
		{
			get { return _projectCode; }
			set
			{
				if ((_projectCode == null) || (value == null) || (!value.Equals(_projectCode)))
				{
                    object oldValue = _projectCode;
					_projectCode = value;
					RaisePropertyChanged(Project.Prop_ProjectCode, oldValue, value);
				}
			}

		}

		[Property("ProjectName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string ProjectName
		{
			get { return _projectName; }
			set
			{
				if ((_projectName == null) || (value == null) || (!value.Equals(_projectName)))
				{
                    object oldValue = _projectName;
					_projectName = value;
					RaisePropertyChanged(Project.Prop_ProjectName, oldValue, value);
				}
			}

		}

		[Property("Zone", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string Zone
		{
			get { return _zone; }
			set
			{
				if ((_zone == null) || (value == null) || (!value.Equals(_zone)))
				{
                    object oldValue = _zone;
					_zone = value;
					RaisePropertyChanged(Project.Prop_Zone, oldValue, value);
				}
			}

		}

		[Property("ZoneSecond", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ZoneSecond
		{
			get { return _zoneSecond; }
			set
			{
				if ((_zoneSecond == null) || (value == null) || (!value.Equals(_zoneSecond)))
				{
                    object oldValue = _zoneSecond;
					_zoneSecond = value;
					RaisePropertyChanged(Project.Prop_ZoneSecond, oldValue, value);
				}
			}

		}

		[Property("DetailLocation", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string DetailLocation
		{
			get { return _detailLocation; }
			set
			{
				if ((_detailLocation == null) || (value == null) || (!value.Equals(_detailLocation)))
				{
                    object oldValue = _detailLocation;
					_detailLocation = value;
					RaisePropertyChanged(Project.Prop_DetailLocation, oldValue, value);
				}
			}

		}

		[Property("PManagerId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string PManagerId
		{
			get { return _pManagerId; }
			set
			{
				if ((_pManagerId == null) || (value == null) || (!value.Equals(_pManagerId)))
				{
                    object oldValue = _pManagerId;
					_pManagerId = value;
					RaisePropertyChanged(Project.Prop_PManagerId, oldValue, value);
				}
			}

		}

		[Property("PManagerName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string PManagerName
		{
			get { return _pManagerName; }
			set
			{
				if ((_pManagerName == null) || (value == null) || (!value.Equals(_pManagerName)))
				{
                    object oldValue = _pManagerName;
					_pManagerName = value;
					RaisePropertyChanged(Project.Prop_PManagerName, oldValue, value);
				}
			}

		}

		[Property("BelongDeptId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string BelongDeptId
		{
			get { return _belongDeptId; }
			set
			{
				if ((_belongDeptId == null) || (value == null) || (!value.Equals(_belongDeptId)))
				{
                    object oldValue = _belongDeptId;
					_belongDeptId = value;
					RaisePropertyChanged(Project.Prop_BelongDeptId, oldValue, value);
				}
			}

		}

		[Property("BelongDeptName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string BelongDeptName
		{
			get { return _belongDeptName; }
			set
			{
				if ((_belongDeptName == null) || (value == null) || (!value.Equals(_belongDeptName)))
				{
                    object oldValue = _belongDeptName;
					_belongDeptName = value;
					RaisePropertyChanged(Project.Prop_BelongDeptName, oldValue, value);
				}
			}

		}

		[Property("JianSheUnit", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string JianSheUnit
		{
			get { return _jianSheUnit; }
			set
			{
				if ((_jianSheUnit == null) || (value == null) || (!value.Equals(_jianSheUnit)))
				{
                    object oldValue = _jianSheUnit;
					_jianSheUnit = value;
					RaisePropertyChanged(Project.Prop_JianSheUnit, oldValue, value);
				}
			}

		}

		[Property("JianSheUnitHead", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string JianSheUnitHead
		{
			get { return _jianSheUnitHead; }
			set
			{
				if ((_jianSheUnitHead == null) || (value == null) || (!value.Equals(_jianSheUnitHead)))
				{
                    object oldValue = _jianSheUnitHead;
					_jianSheUnitHead = value;
					RaisePropertyChanged(Project.Prop_JianSheUnitHead, oldValue, value);
				}
			}

		}

		[Property("JianSheUnitHeadTel", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string JianSheUnitHeadTel
		{
			get { return _jianSheUnitHeadTel; }
			set
			{
				if ((_jianSheUnitHeadTel == null) || (value == null) || (!value.Equals(_jianSheUnitHeadTel)))
				{
                    object oldValue = _jianSheUnitHeadTel;
					_jianSheUnitHeadTel = value;
					RaisePropertyChanged(Project.Prop_JianSheUnitHeadTel, oldValue, value);
				}
			}

		}

		[Property("ProjectType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ProjectType
		{
			get { return _projectType; }
			set
			{
				if ((_projectType == null) || (value == null) || (!value.Equals(_projectType)))
				{
                    object oldValue = _projectType;
					_projectType = value;
					RaisePropertyChanged(Project.Prop_ProjectType, oldValue, value);
				}
			}

		}

		[Property("Property", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Property
		{
			get { return _property; }
			set
			{
				if ((_property == null) || (value == null) || (!value.Equals(_property)))
				{
                    object oldValue = _property;
					_property = value;
					RaisePropertyChanged(Project.Prop_Property, oldValue, value);
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
					RaisePropertyChanged(Project.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(Project.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(Project.Prop_CreateTime, oldValue, value);
				}
			}

		}

		[Property("ShiGongUnit", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string ShiGongUnit
		{
			get { return _shiGongUnit; }
			set
			{
				if ((_shiGongUnit == null) || (value == null) || (!value.Equals(_shiGongUnit)))
				{
                    object oldValue = _shiGongUnit;
					_shiGongUnit = value;
					RaisePropertyChanged(Project.Prop_ShiGongUnit, oldValue, value);
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
					RaisePropertyChanged(Project.Prop_Status, oldValue, value);
				}
			}

		}

		[Property("PMRenMingHanId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string PMRenMingHanId
		{
			get { return _pMRenMingHanId; }
			set
			{
				if ((_pMRenMingHanId == null) || (value == null) || (!value.Equals(_pMRenMingHanId)))
				{
                    object oldValue = _pMRenMingHanId;
					_pMRenMingHanId = value;
					RaisePropertyChanged(Project.Prop_PMRenMingHanId, oldValue, value);
				}
			}

		}

		[Property("JianLiGuiHuaId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string JianLiGuiHuaId
		{
			get { return _jianLiGuiHuaId; }
			set
			{
				if ((_jianLiGuiHuaId == null) || (value == null) || (!value.Equals(_jianLiGuiHuaId)))
				{
                    object oldValue = _jianLiGuiHuaId;
					_jianLiGuiHuaId = value;
					RaisePropertyChanged(Project.Prop_JianLiGuiHuaId, oldValue, value);
				}
			}

		}

		[Property("ConstructionUnitName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ConstructionUnitName
		{
			get { return _constructionUnitName; }
			set
			{
				if ((_constructionUnitName == null) || (value == null) || (!value.Equals(_constructionUnitName)))
				{
                    object oldValue = _constructionUnitName;
					_constructionUnitName = value;
					RaisePropertyChanged(Project.Prop_ConstructionUnitName, oldValue, value);
				}
			}

		}

		[Property("ConstructionUnitID", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ConstructionUnitID
		{
			get { return _constructionUnitID; }
			set
			{
				if ((_constructionUnitID == null) || (value == null) || (!value.Equals(_constructionUnitID)))
				{
                    object oldValue = _constructionUnitID;
					_constructionUnitID = value;
					RaisePropertyChanged(Project.Prop_ConstructionUnitID, oldValue, value);
				}
			}

		}

		[Property("SheJiUnit", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string SheJiUnit
		{
			get { return _sheJiUnit; }
			set
			{
				if ((_sheJiUnit == null) || (value == null) || (!value.Equals(_sheJiUnit)))
				{
                    object oldValue = _sheJiUnit;
					_sheJiUnit = value;
					RaisePropertyChanged(Project.Prop_SheJiUnit, oldValue, value);
				}
			}

		}

		[Property("SheJiUnitHead", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string SheJiUnitHead
		{
			get { return _sheJiUnitHead; }
			set
			{
				if ((_sheJiUnitHead == null) || (value == null) || (!value.Equals(_sheJiUnitHead)))
				{
                    object oldValue = _sheJiUnitHead;
					_sheJiUnitHead = value;
					RaisePropertyChanged(Project.Prop_SheJiUnitHead, oldValue, value);
				}
			}

		}

		[Property("SheJiUnitGrade", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string SheJiUnitGrade
		{
			get { return _sheJiUnitGrade; }
			set
			{
				if ((_sheJiUnitGrade == null) || (value == null) || (!value.Equals(_sheJiUnitGrade)))
				{
                    object oldValue = _sheJiUnitGrade;
					_sheJiUnitGrade = value;
					RaisePropertyChanged(Project.Prop_SheJiUnitGrade, oldValue, value);
				}
			}

		}

		[Property("SheJiUnitZSNo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string SheJiUnitZSNo
		{
			get { return _sheJiUnitZSNo; }
			set
			{
				if ((_sheJiUnitZSNo == null) || (value == null) || (!value.Equals(_sheJiUnitZSNo)))
				{
                    object oldValue = _sheJiUnitZSNo;
					_sheJiUnitZSNo = value;
					RaisePropertyChanged(Project.Prop_SheJiUnitZSNo, oldValue, value);
				}
			}

		}

		[Property("SheJiUnitBeiAnNo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string SheJiUnitBeiAnNo
		{
			get { return _sheJiUnitBeiAnNo; }
			set
			{
				if ((_sheJiUnitBeiAnNo == null) || (value == null) || (!value.Equals(_sheJiUnitBeiAnNo)))
				{
                    object oldValue = _sheJiUnitBeiAnNo;
					_sheJiUnitBeiAnNo = value;
					RaisePropertyChanged(Project.Prop_SheJiUnitBeiAnNo, oldValue, value);
				}
			}

		}

		[Property("KanChaUnit", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string KanChaUnit
		{
			get { return _kanChaUnit; }
			set
			{
				if ((_kanChaUnit == null) || (value == null) || (!value.Equals(_kanChaUnit)))
				{
                    object oldValue = _kanChaUnit;
					_kanChaUnit = value;
					RaisePropertyChanged(Project.Prop_KanChaUnit, oldValue, value);
				}
			}

		}

		[Property("KanChaUnitHead", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string KanChaUnitHead
		{
			get { return _kanChaUnitHead; }
			set
			{
				if ((_kanChaUnitHead == null) || (value == null) || (!value.Equals(_kanChaUnitHead)))
				{
                    object oldValue = _kanChaUnitHead;
					_kanChaUnitHead = value;
					RaisePropertyChanged(Project.Prop_KanChaUnitHead, oldValue, value);
				}
			}

		}

		[Property("KanChaUnitZSNo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string KanChaUnitZSNo
		{
			get { return _kanChaUnitZSNo; }
			set
			{
				if ((_kanChaUnitZSNo == null) || (value == null) || (!value.Equals(_kanChaUnitZSNo)))
				{
                    object oldValue = _kanChaUnitZSNo;
					_kanChaUnitZSNo = value;
					RaisePropertyChanged(Project.Prop_KanChaUnitZSNo, oldValue, value);
				}
			}

		}

		[Property("KanChaUnitBeiAnNo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string KanChaUnitBeiAnNo
		{
			get { return _kanChaUnitBeiAnNo; }
			set
			{
				if ((_kanChaUnitBeiAnNo == null) || (value == null) || (!value.Equals(_kanChaUnitBeiAnNo)))
				{
                    object oldValue = _kanChaUnitBeiAnNo;
					_kanChaUnitBeiAnNo = value;
					RaisePropertyChanged(Project.Prop_KanChaUnitBeiAnNo, oldValue, value);
				}
			}

		}

		[Property("KanChaType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string KanChaType
		{
			get { return _kanChaType; }
			set
			{
				if ((_kanChaType == null) || (value == null) || (!value.Equals(_kanChaType)))
				{
                    object oldValue = _kanChaType;
					_kanChaType = value;
					RaisePropertyChanged(Project.Prop_KanChaType, oldValue, value);
				}
			}

		}

		[Property("KanChaGCLevel", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string KanChaGCLevel
		{
			get { return _kanChaGCLevel; }
			set
			{
				if ((_kanChaGCLevel == null) || (value == null) || (!value.Equals(_kanChaGCLevel)))
				{
                    object oldValue = _kanChaGCLevel;
					_kanChaGCLevel = value;
					RaisePropertyChanged(Project.Prop_KanChaGCLevel, oldValue, value);
				}
			}

		}

		[Property("KanChaZZLevel", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string KanChaZZLevel
		{
			get { return _kanChaZZLevel; }
			set
			{
				if ((_kanChaZZLevel == null) || (value == null) || (!value.Equals(_kanChaZZLevel)))
				{
                    object oldValue = _kanChaZZLevel;
					_kanChaZZLevel = value;
					RaisePropertyChanged(Project.Prop_KanChaZZLevel, oldValue, value);
				}
			}

		}

		[Property("ZuanKongJinChi", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string ZuanKongJinChi
		{
			get { return _zuanKongJinChi; }
			set
			{
				if ((_zuanKongJinChi == null) || (value == null) || (!value.Equals(_zuanKongJinChi)))
				{
                    object oldValue = _zuanKongJinChi;
					_zuanKongJinChi = value;
					RaisePropertyChanged(Project.Prop_ZuanKongJinChi, oldValue, value);
				}
			}

		}

		[Property("Height", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Height
		{
			get { return _height; }
			set
			{
				if ((_height == null) || (value == null) || (!value.Equals(_height)))
				{
                    object oldValue = _height;
					_height = value;
					RaisePropertyChanged(Project.Prop_Height, oldValue, value);
				}
			}

		}

		[Property("UpperLayers", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string UpperLayers
		{
			get { return _upperLayers; }
			set
			{
				if ((_upperLayers == null) || (value == null) || (!value.Equals(_upperLayers)))
				{
                    object oldValue = _upperLayers;
					_upperLayers = value;
					RaisePropertyChanged(Project.Prop_UpperLayers, oldValue, value);
				}
			}

		}

		[Property("DownLayers", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string DownLayers
		{
			get { return _downLayers; }
			set
			{
				if ((_downLayers == null) || (value == null) || (!value.Equals(_downLayers)))
				{
                    object oldValue = _downLayers;
					_downLayers = value;
					RaisePropertyChanged(Project.Prop_DownLayers, oldValue, value);
				}
			}

		}

		[Property("LuQiaoLength", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? LuQiaoLength
		{
			get { return _luQiaoLength; }
			set
			{
				if (value != _luQiaoLength)
				{
                    object oldValue = _luQiaoLength;
					_luQiaoLength = value;
					RaisePropertyChanged(Project.Prop_LuQiaoLength, oldValue, value);
				}
			}

		}

		[Property("LuQiaoWidth", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? LuQiaoWidth
		{
			get { return _luQiaoWidth; }
			set
			{
				if (value != _luQiaoWidth)
				{
                    object oldValue = _luQiaoWidth;
					_luQiaoWidth = value;
					RaisePropertyChanged(Project.Prop_LuQiaoWidth, oldValue, value);
				}
			}

		}

		[Property("DiXiaMianJi", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? DiXiaMianJi
		{
			get { return _diXiaMianJi; }
			set
			{
				if (value != _diXiaMianJi)
				{
                    object oldValue = _diXiaMianJi;
					_diXiaMianJi = value;
					RaisePropertyChanged(Project.Prop_DiXiaMianJi, oldValue, value);
				}
			}

		}

		[Property("FoundationType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string FoundationType
		{
			get { return _foundationType; }
			set
			{
				if ((_foundationType == null) || (value == null) || (!value.Equals(_foundationType)))
				{
                    object oldValue = _foundationType;
					_foundationType = value;
					RaisePropertyChanged(Project.Prop_FoundationType, oldValue, value);
				}
			}

		}

		[Property("StructureType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string StructureType
		{
			get { return _structureType; }
			set
			{
				if ((_structureType == null) || (value == null) || (!value.Equals(_structureType)))
				{
                    object oldValue = _structureType;
					_structureType = value;
					RaisePropertyChanged(Project.Prop_StructureType, oldValue, value);
				}
			}

		}

		[Property("BuildingArea", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string BuildingArea
		{
			get { return _buildingArea; }
			set
			{
				if ((_buildingArea == null) || (value == null) || (!value.Equals(_buildingArea)))
				{
                    object oldValue = _buildingArea;
					_buildingArea = value;
					RaisePropertyChanged(Project.Prop_BuildingArea, oldValue, value);
				}
			}

		}

		[Property("EngineeringLevel", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string EngineeringLevel
		{
			get { return _engineeringLevel; }
			set
			{
				if ((_engineeringLevel == null) || (value == null) || (!value.Equals(_engineeringLevel)))
				{
                    object oldValue = _engineeringLevel;
					_engineeringLevel = value;
					RaisePropertyChanged(Project.Prop_EngineeringLevel, oldValue, value);
				}
			}

		}

		[Property("GongChengLeiXing", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string GongChengLeiXing
		{
			get { return _gongChengLeiXing; }
			set
			{
				if ((_gongChengLeiXing == null) || (value == null) || (!value.Equals(_gongChengLeiXing)))
				{
                    object oldValue = _gongChengLeiXing;
					_gongChengLeiXing = value;
					RaisePropertyChanged(Project.Prop_GongChengLeiXing, oldValue, value);
				}
			}

		}

		[Property("GongChengGuiMo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string GongChengGuiMo
		{
			get { return _gongChengGuiMo; }
			set
			{
				if ((_gongChengGuiMo == null) || (value == null) || (!value.Equals(_gongChengGuiMo)))
				{
                    object oldValue = _gongChengGuiMo;
					_gongChengGuiMo = value;
					RaisePropertyChanged(Project.Prop_GongChengGuiMo, oldValue, value);
				}
			}

		}

		[Property("IfChaoBiao", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string IfChaoBiao
		{
			get { return _ifChaoBiao; }
			set
			{
				if ((_ifChaoBiao == null) || (value == null) || (!value.Equals(_ifChaoBiao)))
				{
                    object oldValue = _ifChaoBiao;
					_ifChaoBiao = value;
					RaisePropertyChanged(Project.Prop_IfChaoBiao, oldValue, value);
				}
			}

		}

		[Property("IfChaoGao", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string IfChaoGao
		{
			get { return _ifChaoGao; }
			set
			{
				if ((_ifChaoGao == null) || (value == null) || (!value.Equals(_ifChaoGao)))
				{
                    object oldValue = _ifChaoGao;
					_ifChaoGao = value;
					RaisePropertyChanged(Project.Prop_IfChaoGao, oldValue, value);
				}
			}

		}

		[Property("JianSheTingNo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string JianSheTingNo
		{
			get { return _jianSheTingNo; }
			set
			{
				if ((_jianSheTingNo == null) || (value == null) || (!value.Equals(_jianSheTingNo)))
				{
                    object oldValue = _jianSheTingNo;
					_jianSheTingNo = value;
					RaisePropertyChanged(Project.Prop_JianSheTingNo, oldValue, value);
				}
			}

		}

		[Property("IfJieNeng", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string IfJieNeng
		{
			get { return _ifJieNeng; }
			set
			{
				if ((_ifJieNeng == null) || (value == null) || (!value.Equals(_ifJieNeng)))
				{
                    object oldValue = _ifJieNeng;
					_ifJieNeng = value;
					RaisePropertyChanged(Project.Prop_IfJieNeng, oldValue, value);
				}
			}

		}

		[Property("IfLvSe", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string IfLvSe
		{
			get { return _ifLvSe; }
			set
			{
				if ((_ifLvSe == null) || (value == null) || (!value.Equals(_ifLvSe)))
				{
                    object oldValue = _ifLvSe;
					_ifLvSe = value;
					RaisePropertyChanged(Project.Prop_IfLvSe, oldValue, value);
				}
			}

		}

		[Property("Investment", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? Investment
		{
			get { return _investment; }
			set
			{
				if (value != _investment)
				{
                    object oldValue = _investment;
					_investment = value;
					RaisePropertyChanged(Project.Prop_Investment, oldValue, value);
				}
			}

		}

		[Property("GongChenLiang", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 2000)]
		public string GongChenLiang
		{
			get { return _gongChenLiang; }
			set
			{
				if ((_gongChenLiang == null) || (value == null) || (!value.Equals(_gongChenLiang)))
				{
                    object oldValue = _gongChenLiang;
					_gongChenLiang = value;
					RaisePropertyChanged(Project.Prop_GongChenLiang, oldValue, value);
				}
			}

		}

		[Property("SongShenTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? SongShenTime
		{
			get { return _songShenTime; }
			set
			{
				if (value != _songShenTime)
				{
                    object oldValue = _songShenTime;
					_songShenTime = value;
					RaisePropertyChanged(Project.Prop_SongShenTime, oldValue, value);
				}
			}

		}

		[Property("ZiXunCode", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ZiXunCode
		{
			get { return _ziXunCode; }
			set
			{
				if ((_ziXunCode == null) || (value == null) || (!value.Equals(_ziXunCode)))
				{
                    object oldValue = _ziXunCode;
					_ziXunCode = value;
					RaisePropertyChanged(Project.Prop_ZiXunCode, oldValue, value);
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
					RaisePropertyChanged(Project.Prop_Remark, oldValue, value);
				}
			}

		}

		[Property("FangHuoLevel", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string FangHuoLevel
		{
			get { return _fangHuoLevel; }
			set
			{
				if ((_fangHuoLevel == null) || (value == null) || (!value.Equals(_fangHuoLevel)))
				{
                    object oldValue = _fangHuoLevel;
					_fangHuoLevel = value;
					RaisePropertyChanged(Project.Prop_FangHuoLevel, oldValue, value);
				}
			}

		}

		[Property("KangZhenLieDu", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string KangZhenLieDu
		{
			get { return _kangZhenLieDu; }
			set
			{
				if ((_kangZhenLieDu == null) || (value == null) || (!value.Equals(_kangZhenLieDu)))
				{
                    object oldValue = _kangZhenLieDu;
					_kangZhenLieDu = value;
					RaisePropertyChanged(Project.Prop_KangZhenLieDu, oldValue, value);
				}
			}

		}

		[Property("KangZhenType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string KangZhenType
		{
			get { return _kangZhenType; }
			set
			{
				if ((_kangZhenType == null) || (value == null) || (!value.Equals(_kangZhenType)))
				{
                    object oldValue = _kangZhenType;
					_kangZhenType = value;
					RaisePropertyChanged(Project.Prop_KangZhenType, oldValue, value);
				}
			}

		}

		[Property("RenFangLevel", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string RenFangLevel
		{
			get { return _renFangLevel; }
			set
			{
				if ((_renFangLevel == null) || (value == null) || (!value.Equals(_renFangLevel)))
				{
                    object oldValue = _renFangLevel;
					_renFangLevel = value;
					RaisePropertyChanged(Project.Prop_RenFangLevel, oldValue, value);
				}
			}

		}

		[Property("CaiNuanFuHe", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string CaiNuanFuHe
		{
			get { return _caiNuanFuHe; }
			set
			{
				if ((_caiNuanFuHe == null) || (value == null) || (!value.Equals(_caiNuanFuHe)))
				{
                    object oldValue = _caiNuanFuHe;
					_caiNuanFuHe = value;
					RaisePropertyChanged(Project.Prop_CaiNuanFuHe, oldValue, value);
				}
			}

		}

		[Property("KongTiaoFuHe", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string KongTiaoFuHe
		{
			get { return _kongTiaoFuHe; }
			set
			{
				if ((_kongTiaoFuHe == null) || (value == null) || (!value.Equals(_kongTiaoFuHe)))
				{
                    object oldValue = _kongTiaoFuHe;
					_kongTiaoFuHe = value;
					RaisePropertyChanged(Project.Prop_KongTiaoFuHe, oldValue, value);
				}
			}

		}

		[Property("CaiNuanMethod", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string CaiNuanMethod
		{
			get { return _caiNuanMethod; }
			set
			{
				if ((_caiNuanMethod == null) || (value == null) || (!value.Equals(_caiNuanMethod)))
				{
                    object oldValue = _caiNuanMethod;
					_caiNuanMethod = value;
					RaisePropertyChanged(Project.Prop_CaiNuanMethod, oldValue, value);
				}
			}

		}

		[Property("RiGongShuiLiang", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string RiGongShuiLiang
		{
			get { return _riGongShuiLiang; }
			set
			{
				if ((_riGongShuiLiang == null) || (value == null) || (!value.Equals(_riGongShuiLiang)))
				{
                    object oldValue = _riGongShuiLiang;
					_riGongShuiLiang = value;
					RaisePropertyChanged(Project.Prop_RiGongShuiLiang, oldValue, value);
				}
			}

		}

		[Property("ShiNeiPaiShuiMethod", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ShiNeiPaiShuiMethod
		{
			get { return _shiNeiPaiShuiMethod; }
			set
			{
				if ((_shiNeiPaiShuiMethod == null) || (value == null) || (!value.Equals(_shiNeiPaiShuiMethod)))
				{
                    object oldValue = _shiNeiPaiShuiMethod;
					_shiNeiPaiShuiMethod = value;
					RaisePropertyChanged(Project.Prop_ShiNeiPaiShuiMethod, oldValue, value);
				}
			}

		}

		[Property("RuoDianContent", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string RuoDianContent
		{
			get { return _ruoDianContent; }
			set
			{
				if ((_ruoDianContent == null) || (value == null) || (!value.Equals(_ruoDianContent)))
				{
                    object oldValue = _ruoDianContent;
					_ruoDianContent = value;
					RaisePropertyChanged(Project.Prop_RuoDianContent, oldValue, value);
				}
			}

		}

		[Property("DongLiZongFuHe", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string DongLiZongFuHe
		{
			get { return _dongLiZongFuHe; }
			set
			{
				if ((_dongLiZongFuHe == null) || (value == null) || (!value.Equals(_dongLiZongFuHe)))
				{
                    object oldValue = _dongLiZongFuHe;
					_dongLiZongFuHe = value;
					RaisePropertyChanged(Project.Prop_DongLiZongFuHe, oldValue, value);
				}
			}

		}

		[Property("ZhaoMingDianFuHe", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ZhaoMingDianFuHe
		{
			get { return _zhaoMingDianFuHe; }
			set
			{
				if ((_zhaoMingDianFuHe == null) || (value == null) || (!value.Equals(_zhaoMingDianFuHe)))
				{
                    object oldValue = _zhaoMingDianFuHe;
					_zhaoMingDianFuHe = value;
					RaisePropertyChanged(Project.Prop_ZhaoMingDianFuHe, oldValue, value);
				}
			}

		}

		[Property("ShiWaiPaiShuiMethod", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ShiWaiPaiShuiMethod
		{
			get { return _shiWaiPaiShuiMethod; }
			set
			{
				if ((_shiWaiPaiShuiMethod == null) || (value == null) || (!value.Equals(_shiWaiPaiShuiMethod)))
				{
                    object oldValue = _shiWaiPaiShuiMethod;
					_shiWaiPaiShuiMethod = value;
					RaisePropertyChanged(Project.Prop_ShiWaiPaiShuiMethod, oldValue, value);
				}
			}

		}

		[Property("JiChuTypeMaiShen", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string JiChuTypeMaiShen
		{
			get { return _jiChuTypeMaiShen; }
			set
			{
				if ((_jiChuTypeMaiShen == null) || (value == null) || (!value.Equals(_jiChuTypeMaiShen)))
				{
                    object oldValue = _jiChuTypeMaiShen;
					_jiChuTypeMaiShen = value;
					RaisePropertyChanged(Project.Prop_JiChuTypeMaiShen, oldValue, value);
				}
			}

		}

		[Property("Wyjz", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Wyjz
		{
			get { return _wyjz; }
			set
			{
				if ((_wyjz == null) || (value == null) || (!value.Equals(_wyjz)))
				{
                    object oldValue = _wyjz;
					_wyjz = value;
					RaisePropertyChanged(Project.Prop_Wyjz, oldValue, value);
				}
			}

		}

		[Property("WyjzUser", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string WyjzUser
		{
			get { return _wyjzUser; }
			set
			{
				if ((_wyjzUser == null) || (value == null) || (!value.Equals(_wyjzUser)))
				{
                    object oldValue = _wyjzUser;
					_wyjzUser = value;
					RaisePropertyChanged(Project.Prop_WyjzUser, oldValue, value);
				}
			}

		}

		[Property("WyjzUnit", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string WyjzUnit
		{
			get { return _wyjzUnit; }
			set
			{
				if ((_wyjzUnit == null) || (value == null) || (!value.Equals(_wyjzUnit)))
				{
                    object oldValue = _wyjzUnit;
					_wyjzUnit = value;
					RaisePropertyChanged(Project.Prop_WyjzUnit, oldValue, value);
				}
			}

		}

		[Property("WyjzNo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string WyjzNo
		{
			get { return _wyjzNo; }
			set
			{
				if ((_wyjzNo == null) || (value == null) || (!value.Equals(_wyjzNo)))
				{
                    object oldValue = _wyjzNo;
					_wyjzNo = value;
					RaisePropertyChanged(Project.Prop_WyjzNo, oldValue, value);
				}
			}

		}

		[Property("Wyjzifwfqt", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Wyjzifwfqt
		{
			get { return _wyjzifwfqt; }
			set
			{
				if ((_wyjzifwfqt == null) || (value == null) || (!value.Equals(_wyjzifwfqt)))
				{
                    object oldValue = _wyjzifwfqt;
					_wyjzifwfqt = value;
					RaisePropertyChanged(Project.Prop_Wyjzifwfqt, oldValue, value);
				}
			}

		}

		[Property("Wyjzifsmcl", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Wyjzifsmcl
		{
			get { return _wyjzifsmcl; }
			set
			{
				if ((_wyjzifsmcl == null) || (value == null) || (!value.Equals(_wyjzifsmcl)))
				{
                    object oldValue = _wyjzifsmcl;
					_wyjzifsmcl = value;
					RaisePropertyChanged(Project.Prop_Wyjzifsmcl, oldValue, value);
				}
			}

		}

		[Property("Ny", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Ny
		{
			get { return _ny; }
			set
			{
				if ((_ny == null) || (value == null) || (!value.Equals(_ny)))
				{
                    object oldValue = _ny;
					_ny = value;
					RaisePropertyChanged(Project.Prop_Ny, oldValue, value);
				}
			}

		}

		[Property("Nyifwfqt", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Nyifwfqt
		{
			get { return _nyifwfqt; }
			set
			{
				if ((_nyifwfqt == null) || (value == null) || (!value.Equals(_nyifwfqt)))
				{
                    object oldValue = _nyifwfqt;
					_nyifwfqt = value;
					RaisePropertyChanged(Project.Prop_Nyifwfqt, oldValue, value);
				}
			}

		}

		[Property("Nyifsmcl", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Nyifsmcl
		{
			get { return _nyifsmcl; }
			set
			{
				if ((_nyifsmcl == null) || (value == null) || (!value.Equals(_nyifsmcl)))
				{
                    object oldValue = _nyifsmcl;
					_nyifsmcl = value;
					RaisePropertyChanged(Project.Prop_Nyifsmcl, oldValue, value);
				}
			}

		}

		[Property("Wy", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Wy
		{
			get { return _wy; }
			set
			{
				if ((_wy == null) || (value == null) || (!value.Equals(_wy)))
				{
                    object oldValue = _wy;
					_wy = value;
					RaisePropertyChanged(Project.Prop_Wy, oldValue, value);
				}
			}

		}

		[Property("Wyifwfqt", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Wyifwfqt
		{
			get { return _wyifwfqt; }
			set
			{
				if ((_wyifwfqt == null) || (value == null) || (!value.Equals(_wyifwfqt)))
				{
                    object oldValue = _wyifwfqt;
					_wyifwfqt = value;
					RaisePropertyChanged(Project.Prop_Wyifwfqt, oldValue, value);
				}
			}

		}

		[Property("Wyifsmcl", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Wyifsmcl
		{
			get { return _wyifsmcl; }
			set
			{
				if ((_wyifsmcl == null) || (value == null) || (!value.Equals(_wyifsmcl)))
				{
                    object oldValue = _wyifsmcl;
					_wyifsmcl = value;
					RaisePropertyChanged(Project.Prop_Wyifsmcl, oldValue, value);
				}
			}

		}

		[Property("Structure", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Structure
		{
			get { return _structure; }
			set
			{
				if ((_structure == null) || (value == null) || (!value.Equals(_structure)))
				{
                    object oldValue = _structure;
					_structure = value;
					RaisePropertyChanged(Project.Prop_Structure, oldValue, value);
				}
			}

		}

		[Property("Building", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Building
		{
			get { return _building; }
			set
			{
				if ((_building == null) || (value == null) || (!value.Equals(_building)))
				{
                    object oldValue = _building;
					_building = value;
					RaisePropertyChanged(Project.Prop_Building, oldValue, value);
				}
			}

		}

		[Property("BelongCmp", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string BelongCmp
		{
			get { return _belongCmp; }
			set
			{
				if ((_belongCmp == null) || (value == null) || (!value.Equals(_belongCmp)))
				{
                    object oldValue = _belongCmp;
					_belongCmp = value;
					RaisePropertyChanged(Project.Prop_BelongCmp, oldValue, value);
				}
			}

		}

		[Property("ContractAmount", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? ContractAmount
		{
			get { return _contractAmount; }
			set
			{
				if (value != _contractAmount)
				{
                    object oldValue = _contractAmount;
					_contractAmount = value;
					RaisePropertyChanged(Project.Prop_ContractAmount, oldValue, value);
				}
			}

		}

		[Property("TaskQuan", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? TaskQuan
		{
			get { return _taskQuan; }
			set
			{
				if (value != _taskQuan)
				{
                    object oldValue = _taskQuan;
					_taskQuan = value;
					RaisePropertyChanged(Project.Prop_TaskQuan, oldValue, value);
				}
			}

		}

		[Property("SubmitQuan", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? SubmitQuan
		{
			get { return _submitQuan; }
			set
			{
				if (value != _submitQuan)
				{
                    object oldValue = _submitQuan;
					_submitQuan = value;
					RaisePropertyChanged(Project.Prop_SubmitQuan, oldValue, value);
				}
			}

		}

		[Property("DelegateInfoId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string DelegateInfoId
		{
			get { return _delegateInfoId; }
			set
			{
				if ((_delegateInfoId == null) || (value == null) || (!value.Equals(_delegateInfoId)))
				{
                    object oldValue = _delegateInfoId;
					_delegateInfoId = value;
					RaisePropertyChanged(Project.Prop_DelegateInfoId, oldValue, value);
				}
			}

		}

		[Property("ChuangKouBiLi", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public System.Decimal? ChuangKouBiLi
		{
			get { return _chuangKouBiLi; }
			set
			{
				if (value != _chuangKouBiLi)
				{
                    object oldValue = _chuangKouBiLi;
					_chuangKouBiLi = value;
					RaisePropertyChanged(Project.Prop_ChuangKouBiLi, oldValue, value);
				}
			}

		}

		[Property("KanChaReportPrjName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
		public string KanChaReportPrjName
		{
			get { return _kanChaReportPrjName; }
			set
			{
				if ((_kanChaReportPrjName == null) || (value == null) || (!value.Equals(_kanChaReportPrjName)))
				{
                    object oldValue = _kanChaReportPrjName;
					_kanChaReportPrjName = value;
					RaisePropertyChanged(Project.Prop_KanChaReportPrjName, oldValue, value);
				}
			}

		}

		#endregion
	} // Project
}

