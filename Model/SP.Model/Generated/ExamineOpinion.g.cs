// Business class ExamineOpinion generated from ExamineOpinion
// Creator: Ray
// Created Date: [2014-12-17]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("ExamineOpinion")]
	public partial class ExamineOpinion : SPModelBase<ExamineOpinion>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_ExamineTaskId = "ExamineTaskId";
		public static string Prop_StartTime = "StartTime";
		public static string Prop_EndTime = "EndTime";
		public static string Prop_Stage = "Stage";
		public static string Prop_ExamineOpinions = "ExamineOpinions";
		public static string Prop_QiangTiao = "QiangTiao";
		public static string Prop_JiangZhuSheJi = "JiangZhuSheJi";
		public static string Prop_FangHuo = "FangHuo";
		public static string Prop_SheBei = "SheBei";
		public static string Prop_JiChu = "JiChu";
		public static string Prop_JiGouSheJi = "JiGouSheJi";
		public static string Prop_KangZhenSheJi = "KangZhenSheJi";
		public static string Prop_JiaGu = "JiaGu";
		public static string Prop_ShenChaUserId = "ShenChaUserId";
		public static string Prop_ShenChaUserName = "ShenChaUserName";
		public static string Prop_FuHeUserId = "FuHeUserId";
		public static string Prop_FuHeUserName = "FuHeUserName";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _examineTaskId;
		private DateTime? _startTime;
		private DateTime? _endTime;
		private string _stage;
		private string _examineOpinions;
		private int? _qiangTiao;
		private int? _jiangZhuSheJi;
		private int? _fangHuo;
		private int? _sheBei;
		private int? _jiChu;
		private int? _jiGouSheJi;
		private int? _kangZhenSheJi;
		private int? _jiaGu;
		private string _shenChaUserId;
		private string _shenChaUserName;
		private string _fuHeUserId;
		private string _fuHeUserName;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public ExamineOpinion()
		{
		}

		public ExamineOpinion(
			string p_id,
			string p_examineTaskId,
			DateTime? p_startTime,
			DateTime? p_endTime,
			string p_stage,
			string p_examineOpinions,
			int? p_qiangTiao,
			int? p_jiangZhuSheJi,
			int? p_fangHuo,
			int? p_sheBei,
			int? p_jiChu,
			int? p_jiGouSheJi,
			int? p_kangZhenSheJi,
			int? p_jiaGu,
			string p_shenChaUserId,
			string p_shenChaUserName,
			string p_fuHeUserId,
			string p_fuHeUserName,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_examineTaskId = p_examineTaskId;
			_startTime = p_startTime;
			_endTime = p_endTime;
			_stage = p_stage;
			_examineOpinions = p_examineOpinions;
			_qiangTiao = p_qiangTiao;
			_jiangZhuSheJi = p_jiangZhuSheJi;
			_fangHuo = p_fangHuo;
			_sheBei = p_sheBei;
			_jiChu = p_jiChu;
			_jiGouSheJi = p_jiGouSheJi;
			_kangZhenSheJi = p_kangZhenSheJi;
			_jiaGu = p_jiaGu;
			_shenChaUserId = p_shenChaUserId;
			_shenChaUserName = p_shenChaUserName;
			_fuHeUserId = p_fuHeUserId;
			_fuHeUserName = p_fuHeUserName;
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

		[Property("ExamineTaskId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ExamineTaskId
		{
			get { return _examineTaskId; }
			set
			{
				if ((_examineTaskId == null) || (value == null) || (!value.Equals(_examineTaskId)))
				{
                    object oldValue = _examineTaskId;
					_examineTaskId = value;
					RaisePropertyChanged(ExamineOpinion.Prop_ExamineTaskId, oldValue, value);
				}
			}

		}

		[Property("StartTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? StartTime
		{
			get { return _startTime; }
			set
			{
				if (value != _startTime)
				{
                    object oldValue = _startTime;
					_startTime = value;
					RaisePropertyChanged(ExamineOpinion.Prop_StartTime, oldValue, value);
				}
			}

		}

		[Property("EndTime", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public DateTime? EndTime
		{
			get { return _endTime; }
			set
			{
				if (value != _endTime)
				{
                    object oldValue = _endTime;
					_endTime = value;
					RaisePropertyChanged(ExamineOpinion.Prop_EndTime, oldValue, value);
				}
			}

		}

		[Property("Stage", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string Stage
		{
			get { return _stage; }
			set
			{
				if ((_stage == null) || (value == null) || (!value.Equals(_stage)))
				{
                    object oldValue = _stage;
					_stage = value;
					RaisePropertyChanged(ExamineOpinion.Prop_Stage, oldValue, value);
				}
			}

		}

		[Property("ExamineOpinions", Access = PropertyAccess.NosetterCamelcaseUnderscore, ColumnType = "StringClob")]
		public string ExamineOpinions
		{
			get { return _examineOpinions; }
			set
			{
				if ((_examineOpinions == null) || (value == null) || (!value.Equals(_examineOpinions)))
				{
                    object oldValue = _examineOpinions;
					_examineOpinions = value;
					RaisePropertyChanged(ExamineOpinion.Prop_ExamineOpinions, oldValue, value);
				}
			}

		}

		[Property("QiangTiao", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? QiangTiao
		{
			get { return _qiangTiao; }
			set
			{
				if (value != _qiangTiao)
				{
                    object oldValue = _qiangTiao;
					_qiangTiao = value;
					RaisePropertyChanged(ExamineOpinion.Prop_QiangTiao, oldValue, value);
				}
			}

		}

		[Property("JiangZhuSheJi", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? JiangZhuSheJi
		{
			get { return _jiangZhuSheJi; }
			set
			{
				if (value != _jiangZhuSheJi)
				{
                    object oldValue = _jiangZhuSheJi;
					_jiangZhuSheJi = value;
					RaisePropertyChanged(ExamineOpinion.Prop_JiangZhuSheJi, oldValue, value);
				}
			}

		}

		[Property("FangHuo", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? FangHuo
		{
			get { return _fangHuo; }
			set
			{
				if (value != _fangHuo)
				{
                    object oldValue = _fangHuo;
					_fangHuo = value;
					RaisePropertyChanged(ExamineOpinion.Prop_FangHuo, oldValue, value);
				}
			}

		}

		[Property("SheBei", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? SheBei
		{
			get { return _sheBei; }
			set
			{
				if (value != _sheBei)
				{
                    object oldValue = _sheBei;
					_sheBei = value;
					RaisePropertyChanged(ExamineOpinion.Prop_SheBei, oldValue, value);
				}
			}

		}

		[Property("JiChu", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? JiChu
		{
			get { return _jiChu; }
			set
			{
				if (value != _jiChu)
				{
                    object oldValue = _jiChu;
					_jiChu = value;
					RaisePropertyChanged(ExamineOpinion.Prop_JiChu, oldValue, value);
				}
			}

		}

		[Property("JiGouSheJi", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? JiGouSheJi
		{
			get { return _jiGouSheJi; }
			set
			{
				if (value != _jiGouSheJi)
				{
                    object oldValue = _jiGouSheJi;
					_jiGouSheJi = value;
					RaisePropertyChanged(ExamineOpinion.Prop_JiGouSheJi, oldValue, value);
				}
			}

		}

		[Property("KangZhenSheJi", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? KangZhenSheJi
		{
			get { return _kangZhenSheJi; }
			set
			{
				if (value != _kangZhenSheJi)
				{
                    object oldValue = _kangZhenSheJi;
					_kangZhenSheJi = value;
					RaisePropertyChanged(ExamineOpinion.Prop_KangZhenSheJi, oldValue, value);
				}
			}

		}

		[Property("JiaGu", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
		public int? JiaGu
		{
			get { return _jiaGu; }
			set
			{
				if (value != _jiaGu)
				{
                    object oldValue = _jiaGu;
					_jiaGu = value;
					RaisePropertyChanged(ExamineOpinion.Prop_JiaGu, oldValue, value);
				}
			}

		}

		[Property("ShenChaUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string ShenChaUserId
		{
			get { return _shenChaUserId; }
			set
			{
				if ((_shenChaUserId == null) || (value == null) || (!value.Equals(_shenChaUserId)))
				{
                    object oldValue = _shenChaUserId;
					_shenChaUserId = value;
					RaisePropertyChanged(ExamineOpinion.Prop_ShenChaUserId, oldValue, value);
				}
			}

		}

		[Property("ShenChaUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string ShenChaUserName
		{
			get { return _shenChaUserName; }
			set
			{
				if ((_shenChaUserName == null) || (value == null) || (!value.Equals(_shenChaUserName)))
				{
                    object oldValue = _shenChaUserName;
					_shenChaUserName = value;
					RaisePropertyChanged(ExamineOpinion.Prop_ShenChaUserName, oldValue, value);
				}
			}

		}

		[Property("FuHeUserId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string FuHeUserId
		{
			get { return _fuHeUserId; }
			set
			{
				if ((_fuHeUserId == null) || (value == null) || (!value.Equals(_fuHeUserId)))
				{
                    object oldValue = _fuHeUserId;
					_fuHeUserId = value;
					RaisePropertyChanged(ExamineOpinion.Prop_FuHeUserId, oldValue, value);
				}
			}

		}

		[Property("FuHeUserName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
		public string FuHeUserName
		{
			get { return _fuHeUserName; }
			set
			{
				if ((_fuHeUserName == null) || (value == null) || (!value.Equals(_fuHeUserName)))
				{
                    object oldValue = _fuHeUserName;
					_fuHeUserName = value;
					RaisePropertyChanged(ExamineOpinion.Prop_FuHeUserName, oldValue, value);
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
					RaisePropertyChanged(ExamineOpinion.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(ExamineOpinion.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(ExamineOpinion.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // ExamineOpinion
}

