using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using Aim.Data;
using Aim.Portal.Model;

namespace SP.Web
{
    public class PhoneMessage
    {
        public static string connectingsstring = ConfigurationManager.ConnectionStrings["PhoneMessageConn"].ConnectionString;
        public static string connectingsstringMail = ConfigurationManager.ConnectionStrings["MailMessageConn"].ConnectionString;
        public static string mailAccount = SysParameter.FindAllByProperties("Code", "MailAccount")[0].Value;
        public static string mailPass = SysParameter.FindAllByProperties("Code", "MailPassword")[0].Value;
        public static string mailServer = SysParameter.FindAllByProperties("Code", "MailSmtpServer")[0].Value;
        public static string mailSenderAddress = SysParameter.FindAllByProperties("Code", "MailSenderAddress")[0].Value;
        public static void SendMessage(string sender, string receiverMobile, string message)
        {
            if (string.IsNullOrEmpty(receiverMobile) || receiverMobile.Length != 11) return;
            //return;
            try
            {
                string sql = @"INSERT INTO [dbo].[outbox1]
           ([ID],[Sender]
           ,[ReceiverMobileNo]
           ,[Msg]
           ,[SendTime])
     VALUES
           ('{4}','{0}'
           ,'{1}'
           ,'{2}'
           ,'{3}')";
                sql = string.Format(sql, sender, receiverMobile, message, DateTime.Now.ToString(), getNumRandom());
                SqlConnection con = new SqlConnection(connectingsstring);
                DataHelper.ExecSql(sql, con);
            }
            catch (Exception ex)
            {

            }
        }
        public static string getNumRandom()
        {
            Random ro = new Random();
            int iResult;
            int iUp = 999;
            int iDown = 100;
            iResult = ro.Next(iDown, iUp);
            return DateTime.Now.ToString("yyyyMMddHHmmssfff") + iResult.ToString().Trim();
        }
        public static void SendMessage(string receiverMobile, string message)
        {
            SendMessage("", receiverMobile, message);
        }
        public static void SendMessageByUser(string userId, string message)
        {
            SysUser user = SysUser.Find(userId);//user.Phone
            SendMessage("14782178734", message);
            if (!string.IsNullOrEmpty(user.Email))
            {
                SendMessageServices(mailSenderAddress, "108948450@qq.com", "中国瑞林咨询公司审图系统提醒", message, mailAccount, mailPass, mailServer);
            }
        }
        public static void SendMessageByPhoneAndEmail(string phone, string email, string message)
        {
            SendMessage(phone, message);
            if (!string.IsNullOrEmpty(email))
            {
                SendMessageServices(mailSenderAddress, email, "中国瑞林咨询公司审图系统提醒", message, mailAccount, mailPass, mailServer);
            }
        }
        public static void SendMessageServices(string mailSenderAddress, string mailto, string title, string body, string mailAccount, string mailPass, string mailServer)
        {
            try
            {
                string sql = @"INSERT INTO [ServiceDataStore].[dbo].[MailToSend]
           ([Id]
           ,[SenderAddress]
           ,[SendToAddress]
           ,[Title]
           ,[Body]
           ,[SendAccount]
           ,[SendPassword]
           ,[SendServer])
     VALUES
           ('{0}'
           ,'{1}'
           ,'{2}'
           ,'{3}'
           ,'{4}'
           ,'{5}'
           ,'{6}'
           ,'{7}')";
                sql = string.Format(sql, System.Guid.NewGuid().ToString(), mailSenderAddress, mailto, title, body, mailAccount, mailPass, mailServer);
                SqlConnection con = new SqlConnection(connectingsstringMail);
                DataHelper.ExecSql(sql, con);
            }
            catch (Exception ex)
            {

            }
        }

        public static void SendWebMail(string mailSenderAddress, string mailto, string title, string body, string mailAccount, string mailPass, string mailServer)
        {
            SendMessageServices(mailSenderAddress, mailto, title, body, mailAccount, mailPass, mailServer);
            return;
            //实例化MailMessage对象 
            System.Web.Mail.MailMessage mail = new System.Web.Mail.MailMessage();
            //定义邮件的发送地址 , 可以随便填一个不存在的地址
            mail.From = mailSenderAddress;
            //定义邮件的接收地址 
            //设置以分号分隔的收件人电子邮件地址列表 
            mail.To = mailto;
            //定义邮件的暗送地址 
            //设置以分号分隔的电子邮件地址列表 
            //mail.Bcc="ddd@sina.com"; 
            //定义邮件的抄送地址 
            //设置以分号分隔的电子邮件地址列表 
            //mail.Cc="ddd@x.cn;ddd@eyou.com 
            //定义邮件的主题 
            mail.Subject = title;
            //设置电子邮件正文的内容类型 
            //在这里我们以HTML的格式发送 
            mail.BodyFormat = System.Web.Mail.MailFormat.Html;
            //设置电子邮件的正文 
            mail.Body = body;
            mail.BodyEncoding = System.Text.Encoding.UTF8;
            //SMTP服务器 ，因为用的是本机架设的，所以写127.0.0.1 , 如果连接的是其他服务器的话，像163邮箱，要写smpt.163.com
            System.Web.Mail.SmtpMail.SmtpServer = mailServer;
            //说是许多SMTP服务器都需要身份验证 ，防止垃圾邮件，好像叫做扩展smpt协议什么的。
            //但这里连接的是自己的smpt服务器，简单的smpt，所以也没有什么验证了。
            //至于从本机的SMPT服务器再把邮件发送到163或者其他邮箱 的时候要不要验证就不知道了， 实测时邮件时可以发到
            //@163.com , @eyou.com,@x.cn的，也不用什么验证。
            //验证 
            mail.Fields.Add("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate", "1");
            //登陆名 
            mail.Fields.Add("http://schemas.microsoft.com/cdo/configuration/sendusername", mailAccount);
            //登陆密码 
            mail.Fields.Add("http://schemas.microsoft.com/cdo/configuration/sendpassword", mailPass);
            //发送 
            System.Web.Mail.SmtpMail.Send(mail);
        }
    }

}
