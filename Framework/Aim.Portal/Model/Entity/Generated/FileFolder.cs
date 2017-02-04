namespace Aim.Portal.Model
{
    // Business class FileFolder generated from FileFolder
    // Administrator [2010-04-08] Created

    using System;
    using System.ComponentModel;
    using Castle.ActiveRecord;
    using Aim.Data;

    [ActiveRecord("FileFolder")]
    public partial class FileFolder : EntityBase<FileFolder>
    {
        #region Property_Names

        public static string Prop_Id = "Id";
        public static string Prop_Name = "Name";
        public static string Prop_FolderKey = "FolderKey";
        public static string Prop_Path = "Path";
        public static string Prop_FullId = "FullId";
        public static string Prop_ParentId = "ParentId";
        public static string Prop_ModuleId = "ModuleId";
        public static string Prop_CreateTime = "CreateTime";
        public static string Prop_RootPath = "RootPath";

        #endregion

        #region Private_Variables

        private string _id;
        private string _name;
        private string _folderKey;
        private string _path;
        private string _fullId;
        private string _parentId;
        private string _moduleId;
        private DateTime? _createTime;
        private string _rootPath;


        #endregion

        #region Constructors

        public FileFolder()
        {
        }

        public FileFolder(
            string p_id,
            string p_name,
            string p_folderKey,
            string p_path,
            string p_fullId,
            string p_parentId,
            string p_moduleId,
            DateTime? p_createTime,
            string p_rootPath)
        {
            _id = p_id;
            _name = p_name;
            _folderKey = p_folderKey;
            _path = p_path;
            _fullId = p_fullId;
            _parentId = p_parentId;
            _moduleId = p_moduleId;
            _createTime = p_createTime;
            _rootPath = p_rootPath;
        }

        #endregion

        #region Properties

        [PrimaryKey("Id", Generator = PrimaryKeyType.Custom, CustomGenerator = typeof(AimIdentifierGenerator), Access = PropertyAccess.NosetterLowercaseUnderscore)]
        public string Id
        {
            get { return _id; }
            // set { _id = value; } // 处理列表编辑时去掉注释

        }

        [Property("Name", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 500)]
        public string Name
        {
            get { return _name; }
            set
            {
                if ((_name == null) || (value == null) || (!value.Equals(_name)))
                {
                    object oldValue = _name;
                    _name = value;
                    RaisePropertyChanged(FileFolder.Prop_Name, oldValue, value);
                }
            }

        }

        [Property("FolderKey", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string FolderKey
        {
            get { return _folderKey; }
            set
            {
                if ((_folderKey == null) || (value == null) || (!value.Equals(_folderKey)))
                {
                    object oldValue = _folderKey;
                    _folderKey = value;
                    RaisePropertyChanged(FileFolder.Prop_FolderKey, oldValue, value);
                }
            }

        }

        [Property("Path", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 800)]
        public string Path
        {
            get { return _path; }
            set
            {
                if ((_path == null) || (value == null) || (!value.Equals(_path)))
                {
                    object oldValue = _path;
                    _path = value;
                    RaisePropertyChanged(FileFolder.Prop_Path, oldValue, value);
                }
            }

        }

        [Property("FullId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
        public string FullId
        {
            get { return _fullId; }
            set
            {
                if ((_fullId == null) || (value == null) || (!value.Equals(_fullId)))
                {
                    object oldValue = _fullId;
                    _fullId = value;
                    RaisePropertyChanged(FileFolder.Prop_FullId, oldValue, value);
                }
            }

        }

        [Property("ParentId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string ParentId
        {
            get { return _parentId; }
            set
            {
                if ((_parentId == null) || (value == null) || (!value.Equals(_parentId)))
                {
                    object oldValue = _parentId;
                    _parentId = value;
                    RaisePropertyChanged(FileFolder.Prop_ParentId, oldValue, value);
                }
            }

        }

        [Property("ModuleId", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 50)]
        public string ModuleId
        {
            get { return _moduleId; }
            set
            {
                if ((_moduleId == null) || (value == null) || (!value.Equals(_moduleId)))
                {
                    object oldValue = _moduleId;
                    _moduleId = value;
                    RaisePropertyChanged(FileFolder.Prop_ModuleId, oldValue, value);
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
                    RaisePropertyChanged(FileFolder.Prop_CreateTime, oldValue, value);
                }
            }

        }

        [Property("RootPath", Access = PropertyAccess.NosetterCamelcaseUnderscore, Length = 200)]
        public string RootPath
        {
            get { return _rootPath; }
            set
            {
                if ((_rootPath == null) || (value == null) || (!value.Equals(_rootPath)))
                {
                    object oldValue = _rootPath;
                    _rootPath = value;
                    RaisePropertyChanged(FileFolder.Prop_RootPath, oldValue, value);
                }
            }

        }

        #endregion
    } // FileFolder
}

