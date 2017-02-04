// Business class Invoice generated from Invoice
// Creator: Ray
// Created Date: [2014-09-05]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;

namespace SP.Model
{
    [ActiveRecord("Invoice")]
    public partial class Invoice : SPModelBase<Invoice>
    {
        #region Property_Names

        public static string Prop_Id = "Id";
        public static string Prop_InvoiceNo = "InvoiceNo";
        public static string Prop_InvoiceAmount = "InvoiceAmount";
        public static string Prop_ProjectId = "ProjectId";
        public static string Prop_KaiPiaoDate = "KaiPiaoDate";
        public static string Prop_Status = "Status";
        public static string Prop_CreateId = "CreateId";
        public static string Prop_CreateName = "CreateName";
        public static string Prop_CreateTime = "CreateTime";
        public static string Prop_Remark = "Remark";

        #endregion

        #region Private_Variables

        private string _id;
        private string _invoiceNo;
        private System.Decimal? _invoiceAmount;
        private string _projectId;
        private DateTime? _kaiPiaoDate;
        private string _status;
        private string _createId;
        private string _createName;
        private DateTime? _createTime;
        private string _remark;


        #endregion

        #region Constructors

        public Invoice()
        {
        }

        public Invoice(
            string p_id,
            string p_invoiceNo,
            System.Decimal? p_invoiceAmount,
            string p_projectId,
            DateTime? p_kaiPiaoDate,
            string p_status,
            string p_createId,
            string p_createName,
            DateTime? p_createTime,
            string p_remark)
        {
            _id = p_id;
            _invoiceNo = p_invoiceNo;
            _invoiceAmount = p_invoiceAmount;
            _projectId = p_projectId;
            _kaiPiaoDate = p_kaiPiaoDate;
            _status = p_status;
            _createId = p_createId;
            _createName = p_createName;
            _createTime = p_createTime;
            _remark = p_remark;
        }

        #endregion

        #region Properties

        [PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
        public string Id
        {
            get { return _id; }
            set { _id = value; } // 处理列表编辑时去掉注释

        }

        [Property("InvoiceNo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string InvoiceNo
        {
            get { return _invoiceNo; }
            set
            {
                if ((_invoiceNo == null) || (value == null) || (!value.Equals(_invoiceNo)))
                {
                    object oldValue = _invoiceNo;
                    _invoiceNo = value;
                    RaisePropertyChanged(Invoice.Prop_InvoiceNo, oldValue, value);
                }
            }

        }

        [Property("InvoiceAmount", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public System.Decimal? InvoiceAmount
        {
            get { return _invoiceAmount; }
            set
            {
                if (value != _invoiceAmount)
                {
                    object oldValue = _invoiceAmount;
                    _invoiceAmount = value;
                    RaisePropertyChanged(Invoice.Prop_InvoiceAmount, oldValue, value);
                }
            }

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
                    RaisePropertyChanged(Invoice.Prop_ProjectId, oldValue, value);
                }
            }

        }

        [Property("KaiPiaoDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? KaiPiaoDate
        {
            get { return _kaiPiaoDate; }
            set
            {
                if (value != _kaiPiaoDate)
                {
                    object oldValue = _kaiPiaoDate;
                    _kaiPiaoDate = value;
                    RaisePropertyChanged(Invoice.Prop_KaiPiaoDate, oldValue, value);
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
                    RaisePropertyChanged(Invoice.Prop_Status, oldValue, value);
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
                    RaisePropertyChanged(Invoice.Prop_CreateId, oldValue, value);
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
                    RaisePropertyChanged(Invoice.Prop_CreateName, oldValue, value);
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
                    RaisePropertyChanged(Invoice.Prop_CreateTime, oldValue, value);
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
                    RaisePropertyChanged(Invoice.Prop_Remark, oldValue, value);
                }
            }

        }

        #endregion
    } // Invoice
}

