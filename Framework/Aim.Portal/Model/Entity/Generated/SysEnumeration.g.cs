﻿// Business class SysEnumeration generated from SysEnumeration
// Creator: Ray
// Created Date: [2014-11-23]

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using Newtonsoft.Json;
using Castle.ActiveRecord;
using Aim.Data;

namespace Aim.Portal.Model
{
    [ActiveRecord("SysEnumeration")]
    public partial class SysEnumeration : EntityBase<SysEnumeration>
    {
        #region Property_Names

        public static string Prop_EnumerationID = "EnumerationID";
        public static string Prop_Code = "Code";
        public static string Prop_Name = "Name";
        public static string Prop_Value = "Value";
        public static string Prop_ParentID = "ParentID";
        public static string Prop_Path = "Path";
        public static string Prop_PathLevel = "PathLevel";
        public static string Prop_IsLeaf = "IsLeaf";
        public static string Prop_SortIndex = "SortIndex";
        public static string Prop_EditStatus = "EditStatus";
        public static string Prop_Tag = "Tag";
        public static string Prop_Description = "Description";
        public static string Prop_CreaterID = "CreaterID";
        public static string Prop_CreaterName = "CreaterName";
        public static string Prop_LastModifiedDate = "LastModifiedDate";
        public static string Prop_CreatedDate = "CreatedDate";

        #endregion

        #region Private_Variables

        private string _enumerationid;
        private string _code;
        private string _name;
        private string _value;
        private string _parentID;
        private string _path;
        private int? _pathLevel;
        private bool? _isLeaf;
        private int? _sortIndex;
        private string _editStatus;
        private string _tag;
        private string _description;
        private string _createrID;
        private string _createrName;
        private DateTime? _lastModifiedDate;
        private DateTime? _createdDate;


        #endregion

        #region Constructors

        public SysEnumeration()
        {
        }

        public SysEnumeration(
            string p_enumerationid,
            string p_code,
            string p_name,
            string p_value,
            string p_parentID,
            string p_path,
            int? p_pathLevel,
            bool? p_isLeaf,
            int? p_sortIndex,
            string p_editStatus,
            string p_tag,
            string p_description,
            string p_createrID,
            string p_createrName,
            DateTime? p_lastModifiedDate,
            DateTime? p_createdDate)
        {
            _enumerationid = p_enumerationid;
            _code = p_code;
            _name = p_name;
            _value = p_value;
            _parentID = p_parentID;
            _path = p_path;
            _pathLevel = p_pathLevel;
            _isLeaf = p_isLeaf;
            _sortIndex = p_sortIndex;
            _editStatus = p_editStatus;
            _tag = p_tag;
            _description = p_description;
            _createrID = p_createrID;
            _createrName = p_createrName;
            _lastModifiedDate = p_lastModifiedDate;
            _createdDate = p_createdDate;
        }

        #endregion

        #region Properties

        [PrimaryKey("EnumerationID", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
        public string EnumerationID
        {
            get { return _enumerationid; }
            set { _enumerationid = value; } // 处理列表编辑时去掉注释

        }

        [Property("Code", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 150)]
        public string Code
        {
            get { return _code; }
            set
            {
                if ((_code == null) || (value == null) || (!value.Equals(_code)))
                {
                    object oldValue = _code;
                    _code = value;
                    RaisePropertyChanged(SysEnumeration.Prop_Code, oldValue, value);
                }
            }

        }

        [Property("Name", Access = PropertyAccess.NosetterCamelcaseUnderscore, NotNull = true, Length = 500)]
        public string Name
        {
            get { return _name; }
            set
            {
                if ((_name == null) || (value == null) || (!value.Equals(_name)))
                {
                    object oldValue = _name;
                    _name = value;
                    RaisePropertyChanged(SysEnumeration.Prop_Name, oldValue, value);
                }
            }

        }

        [Property("Value", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string Value
        {
            get { return _value; }
            set
            {
                if ((_value == null) || (value == null) || (!value.Equals(_value)))
                {
                    object oldValue = _value;
                    _value = value;
                    RaisePropertyChanged(SysEnumeration.Prop_Value, oldValue, value);
                }
            }

        }

        [Property("ParentID", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string ParentID
        {
            get { return _parentID; }
            set
            {
                if ((_parentID == null) || (value == null) || (!value.Equals(_parentID)))
                {
                    object oldValue = _parentID;
                    _parentID = value;
                    RaisePropertyChanged(SysEnumeration.Prop_ParentID, oldValue, value);
                }
            }

        }

        [Property("Path", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
        public string Path
        {
            get { return _path; }
            set
            {
                if ((_path == null) || (value == null) || (!value.Equals(_path)))
                {
                    object oldValue = _path;
                    _path = value;
                    RaisePropertyChanged(SysEnumeration.Prop_Path, oldValue, value);
                }
            }

        }

        [Property("PathLevel", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public int? PathLevel
        {
            get { return _pathLevel; }
            set
            {
                if (value != _pathLevel)
                {
                    object oldValue = _pathLevel;
                    _pathLevel = value;
                    RaisePropertyChanged(SysEnumeration.Prop_PathLevel, oldValue, value);
                }
            }

        }

        [Property("IsLeaf", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public bool? IsLeaf
        {
            get { return _isLeaf; }
            set
            {
                if (value != _isLeaf)
                {
                    object oldValue = _isLeaf;
                    _isLeaf = value;
                    RaisePropertyChanged(SysEnumeration.Prop_IsLeaf, oldValue, value);
                }
            }

        }

        [Property("SortIndex", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public int? SortIndex
        {
            get { return _sortIndex; }
            set
            {
                if (value != _sortIndex)
                {
                    object oldValue = _sortIndex;
                    _sortIndex = value;
                    RaisePropertyChanged(SysEnumeration.Prop_SortIndex, oldValue, value);
                }
            }

        }

        [Property("EditStatus", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string EditStatus
        {
            get { return _editStatus; }
            set
            {
                if ((_editStatus == null) || (value == null) || (!value.Equals(_editStatus)))
                {
                    object oldValue = _editStatus;
                    _editStatus = value;
                    RaisePropertyChanged(SysEnumeration.Prop_EditStatus, oldValue, value);
                }
            }

        }

        [Property("Tag", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
        public string Tag
        {
            get { return _tag; }
            set
            {
                if ((_tag == null) || (value == null) || (!value.Equals(_tag)))
                {
                    object oldValue = _tag;
                    _tag = value;
                    RaisePropertyChanged(SysEnumeration.Prop_Tag, oldValue, value);
                }
            }

        }

        [Property("Description", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
        public string Description
        {
            get { return _description; }
            set
            {
                if ((_description == null) || (value == null) || (!value.Equals(_description)))
                {
                    object oldValue = _description;
                    _description = value;
                    RaisePropertyChanged(SysEnumeration.Prop_Description, oldValue, value);
                }
            }

        }

        [Property("CreaterID", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string CreaterID
        {
            get { return _createrID; }
            set
            {
                if ((_createrID == null) || (value == null) || (!value.Equals(_createrID)))
                {
                    object oldValue = _createrID;
                    _createrID = value;
                    RaisePropertyChanged(SysEnumeration.Prop_CreaterID, oldValue, value);
                }
            }

        }

        [Property("CreaterName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string CreaterName
        {
            get { return _createrName; }
            set
            {
                if ((_createrName == null) || (value == null) || (!value.Equals(_createrName)))
                {
                    object oldValue = _createrName;
                    _createrName = value;
                    RaisePropertyChanged(SysEnumeration.Prop_CreaterName, oldValue, value);
                }
            }

        }

        [Property("LastModifiedDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? LastModifiedDate
        {
            get { return _lastModifiedDate; }
            set
            {
                if (value != _lastModifiedDate)
                {
                    object oldValue = _lastModifiedDate;
                    _lastModifiedDate = value;
                    RaisePropertyChanged(SysEnumeration.Prop_LastModifiedDate, oldValue, value);
                }
            }

        }

        [Property("CreatedDate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public DateTime? CreatedDate
        {
            get { return _createdDate; }
            set
            {
                if (value != _createdDate)
                {
                    object oldValue = _createdDate;
                    _createdDate = value;
                    RaisePropertyChanged(SysEnumeration.Prop_CreatedDate, oldValue, value);
                }
            }

        }

        #endregion
    } // SysEnumeration
}

