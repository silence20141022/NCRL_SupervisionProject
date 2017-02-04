// Business class ChouJin generated from ChouJin
// Creator: Ray
// Created Date: [2014-08-26]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;

namespace SP.Model
{
    [ActiveRecord("ChouJin")]
    public partial class ChouJin : SPModelBase<ChouJin>
    {
        #region Property_Names

        public static string Prop_Id = "Id";
        public static string Prop_BelongYear = "BelongYear";
        public static string Prop_BelongMonth = "BelongMonth";
        public static string Prop_ChouJinAmount = "ChouJinAmount";
        public static string Prop_Remark = "Remark";
        public static string Prop_CreateId = "CreateId";
        public static string Prop_CreateName = "CreateName";
        public static string Prop_CreateTime = "CreateTime";

        #endregion

        #region Private_Variables

        private string _id;
        private string _belongYear;
        private string _belongMonth;
        private System.Decimal? _chouJinAmount;
        private string _remark;
        private string _createId;
        private string _createName;
        private DateTime? _createTime;


        #endregion

        #region Constructors

        public ChouJin()
        {
        }

        public ChouJin(
            string p_id,
            string p_belongYear,
            string p_belongMonth,
            System.Decimal? p_chouJinAmount,
            string p_remark,
            string p_createId,
            string p_createName,
            DateTime? p_createTime)
        {
            _id = p_id;
            _belongYear = p_belongYear;
            _belongMonth = p_belongMonth;
            _chouJinAmount = p_chouJinAmount;
            _remark = p_remark;
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

        [Property("BelongYear", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string BelongYear
        {
            get { return _belongYear; }
            set
            {
                if ((_belongYear == null) || (value == null) || (!value.Equals(_belongYear)))
                {
                    object oldValue = _belongYear;
                    _belongYear = value;
                    RaisePropertyChanged(ChouJin.Prop_BelongYear, oldValue, value);
                }
            }

        }

        [Property("BelongMonth", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string BelongMonth
        {
            get { return _belongMonth; }
            set
            {
                if ((_belongMonth == null) || (value == null) || (!value.Equals(_belongMonth)))
                {
                    object oldValue = _belongMonth;
                    _belongMonth = value;
                    RaisePropertyChanged(ChouJin.Prop_BelongMonth, oldValue, value);
                }
            }

        }

        [Property("ChouJinAmount", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public System.Decimal? ChouJinAmount
        {
            get { return _chouJinAmount; }
            set
            {
                if (value != _chouJinAmount)
                {
                    object oldValue = _chouJinAmount;
                    _chouJinAmount = value;
                    RaisePropertyChanged(ChouJin.Prop_ChouJinAmount, oldValue, value);
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
                    RaisePropertyChanged(ChouJin.Prop_Remark, oldValue, value);
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
                    RaisePropertyChanged(ChouJin.Prop_CreateId, oldValue, value);
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
                    RaisePropertyChanged(ChouJin.Prop_CreateName, oldValue, value);
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
                    RaisePropertyChanged(ChouJin.Prop_CreateTime, oldValue, value);
                }
            }

        }

        #endregion
    } // ChouJin
}

