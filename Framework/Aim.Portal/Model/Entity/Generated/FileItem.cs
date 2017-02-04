
namespace Aim.Portal.Model
{
    using System;
    using System.ComponentModel;
    using Castle.ActiveRecord;
    using Aim.Data;
    [ActiveRecord("FileItem")]
    public partial class FileItem : EntityBase<FileItem>
    {
        #region Property_Names

        public static string Prop_Id = "Id";
        public static string Prop_Name = "Name";
        public static string Prop_ExtName = "ExtName";
        public static string Prop_FileSize = "FileSize";
        public static string Prop_Path = "Path";
        public static string Prop_FullId = "FullId";
        public static string Prop_GroupId = "GroupId";
        public static string Prop_FolderId = "FolderId";
        public static string Prop_ModuleId = "ModuleId";
        public static string Prop_IsReference = "IsReference";
        public static string Prop_ReferenceId = "ReferenceId";
        public static string Prop_IsRelate = "IsRelate";
        public static string Prop_HasRelate = "HasRelate";
        public static string Prop_RelateType = "RelateType";
        public static string Prop_RelateId = "RelateId";
        public static string Prop_IsCompressed = "IsCompressed";
        public static string Prop_IsEncrypted = "IsEncrypted";
        public static string Prop_IsActiveVersion = "IsActiveVersion";
        public static string Prop_HasVersion = "HasVersion";
        public static string Prop_Version = "Version";
        public static string Prop_VersionMemo = "VersionMemo";
        public static string Prop_ProjectId = "ProjectId";
        public static string Prop_FirstTypeId = "FirstTypeId";
        public static string Prop_SecondTypeId = "SecondTypeId";
        public static string Prop_CreateTime = "CreateTime";
        public static string Prop_CreatorId = "CreatorId";
        public static string Prop_CreatorName = "CreatorName";

        #endregion

        #region Private_Variables

        private string _id;
        private string _name;
        private string _extName;
        private long? _fileSize;
        private string _path;
        private string _fullId;
        private string _groupId;
        private string _folderId;
        private string _moduleId;
        private bool? _isReference;
        private string _referenceId;
        private bool? _isRelate;
        private bool? _hasRelate;
        private string _relateType;
        private string _relateId;
        private bool? _isCompressed;
        private bool? _isEncrypted;
        private bool? _isActiveVersion;
        private bool? _hasVersion;
        private string _version;
        private string _versionMemo;
        private string _projectId;
        private string _firstTypeId;
        private string _secondTypeId;
        private DateTime? _createTime;
        private string _creatorId;
        private string _creatorName;


        #endregion

        #region Constructors

        public FileItem()
        {
        }

        public FileItem(
            string p_id,
            string p_name,
            string p_extName,
            long? p_fileSize,
            string p_path,
            string p_fullId,
            string p_groupId,
            string p_folderId,
            string p_moduleId,
            bool? p_isReference,
            string p_referenceId,
            bool? p_isRelate,
            bool? p_hasRelate,
            string p_relateType,
            string p_relateId,
            bool? p_isCompressed,
            bool? p_isEncrypted,
            bool? p_isActiveVersion,
            bool? p_hasVersion,
            string p_version,
            string p_versionMemo,
            string p_projectId,
            string p_firstTypeId,
            string p_secondTypeId,
            DateTime? p_createTime,
            string p_creatorId,
            string p_creatorName)
        {
            _id = p_id;
            _name = p_name;
            _extName = p_extName;
            _fileSize = p_fileSize;
            _path = p_path;
            _fullId = p_fullId;
            _groupId = p_groupId;
            _folderId = p_folderId;
            _moduleId = p_moduleId;
            _isReference = p_isReference;
            _referenceId = p_referenceId;
            _isRelate = p_isRelate;
            _hasRelate = p_hasRelate;
            _relateType = p_relateType;
            _relateId = p_relateId;
            _isCompressed = p_isCompressed;
            _isEncrypted = p_isEncrypted;
            _isActiveVersion = p_isActiveVersion;
            _hasVersion = p_hasVersion;
            _version = p_version;
            _versionMemo = p_versionMemo;
            _projectId = p_projectId;
            _firstTypeId = p_firstTypeId;
            _secondTypeId = p_secondTypeId;
            _createTime = p_createTime;
            _creatorId = p_creatorId;
            _creatorName = p_creatorName;
        }

        #endregion

        #region Properties

        [PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
        public string Id
        {
            get { return _id; }
            // set { _id = value; } // 处理列表编辑时去掉注释

        }

        [Property("Name", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 300)]
        public string Name
        {
            get { return _name; }
            set
            {
                if ((_name == null) || (value == null) || (!value.Equals(_name)))
                {
                    object oldValue = _name;
                    _name = value;
                    RaisePropertyChanged(FileItem.Prop_Name, oldValue, value);
                }
            }

        }

        [Property("ExtName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string ExtName
        {
            get { return _extName; }
            set
            {
                if ((_extName == null) || (value == null) || (!value.Equals(_extName)))
                {
                    object oldValue = _extName;
                    _extName = value;
                    RaisePropertyChanged(FileItem.Prop_ExtName, oldValue, value);
                }
            }

        }

        [Property("FileSize", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public long? FileSize
        {
            get { return _fileSize; }
            set
            {
                if (value != _fileSize)
                {
                    object oldValue = _fileSize;
                    _fileSize = value;
                    RaisePropertyChanged(FileItem.Prop_FileSize, oldValue, value);
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
                    RaisePropertyChanged(FileItem.Prop_Path, oldValue, value);
                }
            }

        }

        [Property("FullId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
        public string FullId
        {
            get { return _fullId; }
            set
            {
                if ((_fullId == null) || (value == null) || (!value.Equals(_fullId)))
                {
                    object oldValue = _fullId;
                    _fullId = value;
                    RaisePropertyChanged(FileItem.Prop_FullId, oldValue, value);
                }
            }

        }

        [Property("GroupId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string GroupId
        {
            get { return _groupId; }
            set
            {
                if ((_groupId == null) || (value == null) || (!value.Equals(_groupId)))
                {
                    object oldValue = _groupId;
                    _groupId = value;
                    RaisePropertyChanged(FileItem.Prop_GroupId, oldValue, value);
                }
            }

        }

        [Property("FolderId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string FolderId
        {
            get { return _folderId; }
            set
            {
                if ((_folderId == null) || (value == null) || (!value.Equals(_folderId)))
                {
                    object oldValue = _folderId;
                    _folderId = value;
                    RaisePropertyChanged(FileItem.Prop_FolderId, oldValue, value);
                }
            }

        }

        [Property("ModuleId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string ModuleId
        {
            get { return _moduleId; }
            set
            {
                if ((_moduleId == null) || (value == null) || (!value.Equals(_moduleId)))
                {
                    object oldValue = _moduleId;
                    _moduleId = value;
                    RaisePropertyChanged(FileItem.Prop_ModuleId, oldValue, value);
                }
            }

        }

        [Property("IsReference", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public bool? IsReference
        {
            get { return _isReference; }
            set
            {
                if (value != _isReference)
                {
                    object oldValue = _isReference;
                    _isReference = value;
                    RaisePropertyChanged(FileItem.Prop_IsReference, oldValue, value);
                }
            }

        }

        [Property("ReferenceId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string ReferenceId
        {
            get { return _referenceId; }
            set
            {
                if ((_referenceId == null) || (value == null) || (!value.Equals(_referenceId)))
                {
                    object oldValue = _referenceId;
                    _referenceId = value;
                    RaisePropertyChanged(FileItem.Prop_ReferenceId, oldValue, value);
                }
            }

        }

        [Property("IsRelate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public bool? IsRelate
        {
            get { return _isRelate; }
            set
            {
                if (value != _isRelate)
                {
                    object oldValue = _isRelate;
                    _isRelate = value;
                    RaisePropertyChanged(FileItem.Prop_IsRelate, oldValue, value);
                }
            }

        }

        [Property("HasRelate", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public bool? HasRelate
        {
            get { return _hasRelate; }
            set
            {
                if (value != _hasRelate)
                {
                    object oldValue = _hasRelate;
                    _hasRelate = value;
                    RaisePropertyChanged(FileItem.Prop_HasRelate, oldValue, value);
                }
            }

        }

        [Property("RelateType", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string RelateType
        {
            get { return _relateType; }
            set
            {
                if ((_relateType == null) || (value == null) || (!value.Equals(_relateType)))
                {
                    object oldValue = _relateType;
                    _relateType = value;
                    RaisePropertyChanged(FileItem.Prop_RelateType, oldValue, value);
                }
            }

        }

        [Property("RelateId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string RelateId
        {
            get { return _relateId; }
            set
            {
                if ((_relateId == null) || (value == null) || (!value.Equals(_relateId)))
                {
                    object oldValue = _relateId;
                    _relateId = value;
                    RaisePropertyChanged(FileItem.Prop_RelateId, oldValue, value);
                }
            }

        }

        [Property("IsCompressed", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public bool? IsCompressed
        {
            get { return _isCompressed; }
            set
            {
                if (value != _isCompressed)
                {
                    object oldValue = _isCompressed;
                    _isCompressed = value;
                    RaisePropertyChanged(FileItem.Prop_IsCompressed, oldValue, value);
                }
            }

        }

        [Property("IsEncrypted", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public bool? IsEncrypted
        {
            get { return _isEncrypted; }
            set
            {
                if (value != _isEncrypted)
                {
                    object oldValue = _isEncrypted;
                    _isEncrypted = value;
                    RaisePropertyChanged(FileItem.Prop_IsEncrypted, oldValue, value);
                }
            }

        }

        [Property("IsActiveVersion", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public bool? IsActiveVersion
        {
            get { return _isActiveVersion; }
            set
            {
                if (value != _isActiveVersion)
                {
                    object oldValue = _isActiveVersion;
                    _isActiveVersion = value;
                    RaisePropertyChanged(FileItem.Prop_IsActiveVersion, oldValue, value);
                }
            }

        }

        [Property("HasVersion", Access = PropertyAccess.NosetterCamelcaseUnderscore)]
        public bool? HasVersion
        {
            get { return _hasVersion; }
            set
            {
                if (value != _hasVersion)
                {
                    object oldValue = _hasVersion;
                    _hasVersion = value;
                    RaisePropertyChanged(FileItem.Prop_HasVersion, oldValue, value);
                }
            }

        }

        [Property("Version", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 20)]
        public string Version
        {
            get { return _version; }
            set
            {
                if ((_version == null) || (value == null) || (!value.Equals(_version)))
                {
                    object oldValue = _version;
                    _version = value;
                    RaisePropertyChanged(FileItem.Prop_Version, oldValue, value);
                }
            }

        }

        [Property("VersionMemo", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
        public string VersionMemo
        {
            get { return _versionMemo; }
            set
            {
                if ((_versionMemo == null) || (value == null) || (!value.Equals(_versionMemo)))
                {
                    object oldValue = _versionMemo;
                    _versionMemo = value;
                    RaisePropertyChanged(FileItem.Prop_VersionMemo, oldValue, value);
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
                    RaisePropertyChanged(FileItem.Prop_ProjectId, oldValue, value);
                }
            }

        }

        [Property("FirstTypeId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string FirstTypeId
        {
            get { return _firstTypeId; }
            set
            {
                if ((_firstTypeId == null) || (value == null) || (!value.Equals(_firstTypeId)))
                {
                    object oldValue = _firstTypeId;
                    _firstTypeId = value;
                    RaisePropertyChanged(FileItem.Prop_FirstTypeId, oldValue, value);
                }
            }

        }

        [Property("SecondTypeId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 36)]
        public string SecondTypeId
        {
            get { return _secondTypeId; }
            set
            {
                if ((_secondTypeId == null) || (value == null) || (!value.Equals(_secondTypeId)))
                {
                    object oldValue = _secondTypeId;
                    _secondTypeId = value;
                    RaisePropertyChanged(FileItem.Prop_SecondTypeId, oldValue, value);
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
                    RaisePropertyChanged(FileItem.Prop_CreateTime, oldValue, value);
                }
            }

        }

        [Property("CreatorId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string CreatorId
        {
            get { return _creatorId; }
            set
            {
                if ((_creatorId == null) || (value == null) || (!value.Equals(_creatorId)))
                {
                    object oldValue = _creatorId;
                    _creatorId = value;
                    RaisePropertyChanged(FileItem.Prop_CreatorId, oldValue, value);
                }
            }

        }

        [Property("CreatorName", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string CreatorName
        {
            get { return _creatorName; }
            set
            {
                if ((_creatorName == null) || (value == null) || (!value.Equals(_creatorName)))
                {
                    object oldValue = _creatorName;
                    _creatorName = value;
                    RaisePropertyChanged(FileItem.Prop_CreatorName, oldValue, value);
                }
            }

        }

        #endregion
    } // FileItem
}

