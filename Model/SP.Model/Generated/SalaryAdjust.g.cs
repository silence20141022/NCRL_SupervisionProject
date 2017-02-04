// Business class SalaryAdjust generated from SalaryAdjust
// Creator: Ray
// Created Date: [2014-11-12]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("SalaryAdjust")]
	public partial class SalaryAdjust : SPModelBase<SalaryAdjust>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_StageId = "StageId";
		public static string Prop_UserId = "UserId";
		public static string Prop_PreStageId = "PreStageId";

		#endregion

		#region Private_Variables

		private string _id;
		private string _stageId;
		private string _userId;
		private string _preStageId;


		#endregion

		#region Constructors

		public SalaryAdjust()
		{
		}

		public SalaryAdjust(
			string p_id,
			string p_stageId,
			string p_userId,
			string p_preStageId)
		{
			_id = p_id;
			_stageId = p_stageId;
			_userId = p_userId;
			_preStageId = p_preStageId;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("StageId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string StageId
		{
			get { return _stageId; }
			set
			{
				if ((_stageId == null) || (value == null) || (!value.Equals(_stageId)))
				{
                    object oldValue = _stageId;
					_stageId = value;
					RaisePropertyChanged(SalaryAdjust.Prop_StageId, oldValue, value);
				}
			}

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
					RaisePropertyChanged(SalaryAdjust.Prop_UserId, oldValue, value);
				}
			}

		}

		[Property("PreStageId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
		public string PreStageId
		{
			get { return _preStageId; }
			set
			{
				if ((_preStageId == null) || (value == null) || (!value.Equals(_preStageId)))
				{
                    object oldValue = _preStageId;
					_preStageId = value;
					RaisePropertyChanged(SalaryAdjust.Prop_PreStageId, oldValue, value);
				}
			}

		}

		#endregion
	} // SalaryAdjust
}

