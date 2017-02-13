// Business class DangerSource generated from DangerSource
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
	[ActiveRecord("DangerSource")]
	public partial class DangerSource : SPModelBase<DangerSource>
	{
		#region Property_Names

		public static string Prop_Id = "Id";
		public static string Prop_DangerName = "DangerName";
		public static string Prop_ControlMethod = "ControlMethod";
		public static string Prop_CreateId = "CreateId";
		public static string Prop_CreateName = "CreateName";
		public static string Prop_CreateTime = "CreateTime";

		#endregion

		#region Private_Variables

		private string _id;
		private string _dangerName;
		private string _controlMethod;
		private string _createId;
		private string _createName;
		private DateTime? _createTime;


		#endregion

		#region Constructors

		public DangerSource()
		{
		}

		public DangerSource(
			string p_id,
			string p_dangerName,
			string p_controlMethod,
			string p_createId,
			string p_createName,
			DateTime? p_createTime)
		{
			_id = p_id;
			_dangerName = p_dangerName;
			_controlMethod = p_controlMethod;
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
			// set { _id = value; } // 处理列表编辑时去掉注释

		}

		[Property("DangerName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
		public string DangerName
		{
			get { return _dangerName; }
			set
			{
				if ((_dangerName == null) || (value == null) || (!value.Equals(_dangerName)))
				{
                    object oldValue = _dangerName;
					_dangerName = value;
					RaisePropertyChanged(DangerSource.Prop_DangerName, oldValue, value);
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
					RaisePropertyChanged(DangerSource.Prop_ControlMethod, oldValue, value);
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
					RaisePropertyChanged(DangerSource.Prop_CreateId, oldValue, value);
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
					RaisePropertyChanged(DangerSource.Prop_CreateName, oldValue, value);
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
					RaisePropertyChanged(DangerSource.Prop_CreateTime, oldValue, value);
				}
			}

		}

		#endregion
	} // DangerSource
}

