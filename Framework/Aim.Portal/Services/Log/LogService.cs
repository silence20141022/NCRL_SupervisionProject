﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using Aim.Portal.Model;

namespace Aim.Portal.Log
{
    // 日志类型
    public enum LogTypeEnum
    {
        Debug,
        Error,
        Fatal,
        Info,
        Warn,
        Custom
    }

    public class LogService
    {
        #region 公共方法

        /// <summary>
        /// 写日志
        /// </summary>
        /// <param name="msg"></param>
        /// <param name="logType"></param>
        public static void Log(string msg, string logType)
        {
            SysEvent evt = new SysEvent();

            if (PortalService.CurrentUserInfo != null)
            {
                evt.UserID = PortalService.CurrentUserInfo.UserID;
                evt.LoginName = PortalService.CurrentUserInfo.LoginName;
            }

            evt.IP = HttpContext.Current.Request.UserHostAddress;
            evt.Type = logType;
            evt.Record = msg;

            evt.DoCreate();
        }

        /// <summary>
        /// 写日志
        /// </summary>
        /// <param name="msg"></param>
        public static void Log(string msg, LogTypeEnum logType)
        {
            Log(msg, logType.ToString());
        }

        /// <summary>
        /// 根据LogContent写日志
        /// </summary>
        /// <param name="content"></param>
        public static void Log(LogContent content)
        {
            Log(content, LogTypeEnum.Info);
        }

        /// <summary>
        /// 根据LogContent写日志
        /// </summary>
        /// <param name="content"></param>
        public static void Log(LogContent content, LogTypeEnum logType)
        {
            Log(content.ToString(), logType.ToString());
        }

        /// <summary>
        /// 根据LogContent写日志
        /// </summary>
        /// <param name="content"></param>
        public static void Log(LogContent content, string logType)
        {
            Log(content.ToString(), logType);
        }

        /// <summary>
        /// 根据数组记录日志
        /// </summary>
        /// <param name="logType"></param>
        /// <param name="content"></param>
        public static void Log(string[] keyValues, LogTypeEnum logType)
        {
            LogContent cont = GetLogContent(keyValues);

            Log(keyValues, logType);
        }

        /// <summary>
        /// 根据数组记录日志
        /// </summary>
        /// <param name="logType"></param>
        /// <param name="content"></param>
        public static void Log(string[] keyValues)
        {
            LogContent cont = GetLogContent(keyValues);

            Log(keyValues, LogTypeEnum.Info);
        }

        /// <summary>
        /// 根据数组记录日志
        /// </summary>
        /// <param name="logType"></param>
        /// <param name="content"></param>
        public static void Log(string[] keyValues, string logType)
        {
            LogContent cont = GetLogContent(keyValues);

            Log(keyValues, logType);
        }

        /// <summary>
        /// 由键值获取日志内容
        /// </summary>
        /// <param name="keyValues"></param>
        public static LogContent GetLogContent(params object[] keyValues)
        {
            if (keyValues.Length % 2 != 0)
            {
                throw new Exception("参数数目不对");
            }

            LogContent cont = new LogContent();

            for (int i = 0; i < keyValues.Length; i = i + 2)
            {
                cont.Add(keyValues[i].ToString(), keyValues[(i + 1)]);
            }

            return cont;
        }

        #endregion
    }
}
