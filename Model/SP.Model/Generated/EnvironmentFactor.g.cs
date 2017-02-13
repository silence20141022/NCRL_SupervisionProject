// Business class EnvironmentFactor generated from EnvironmentFactor
// Creator: Ray
// Created Date: [2014-04-17]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;
	
namespace SP.Model
{
	[ActiveRecord("EnvironmentFactor")]
	public partial class EnvironmentFactor : SPModelBase<EnvironmentFactor>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_FactorName = "FactorName";
		public static string Prop_ControlMethod = "ControlMethod";

		#endregion

		#region Private_Variables

		private string _id;
		private string _factorName;
		private string _controlMethod;


		#endregion

		#region Constructors

		public EnvironmentFactor()
		{
		}

		public EnvironmentFactor(
			string p_id,
			string p_factorName,
			string p_controlMethod)
		{
			_id = p_id;
			_factorName = p_factorName;
			_controlMethod = p_controlMethod;
		}

		#endregion

		#region Properties

		[PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
		public string Id
		{
			get { return _id; }
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("FactorName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string FactorName
		{
			get { return _factorName; }
			set
			{
				if ((_factorName == null) || (value == null) || (!value.Equals(_factorName)))
				{
                    object oldValue = _factorName;
					_factorName = value;
					RaisePropertyChanged(EnvironmentFactor.Prop_FactorName, oldValue, value);
				}
			}

		}

		[Property("ControlMethod", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string ControlMethod
		{
			get { return _controlMethod; }
			set
			{
				if ((_controlMethod == null) || (value == null) || (!value.Equals(_controlMethod)))
				{
                    object oldValue = _controlMethod;
					_controlMethod = value;
					RaisePropertyChanged(EnvironmentFactor.Prop_ControlMethod, oldValue, value);
				}
			}

		}

		#endregion
	} // EnvironmentFactor
}

