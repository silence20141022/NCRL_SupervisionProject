﻿//------------------------------------------------------------------------------
// <auto-generated>
//     此代码由工具生成。
//     运行时版本:4.0.30319.1
//
//     对此文件的更改可能会导致不正确的行为，并且如果
//     重新生成代码，这些更改将会丢失。
// </auto-generated>
//------------------------------------------------------------------------------

// 
// 此源代码是由 Microsoft.VSDesigner 4.0.30319.1 版自动生成。
// 
#pragma warning disable 1591

namespace SP.Web.MsgService {
    using System;
    using System.Web.Services;
    using System.Diagnostics;
    using System.Web.Services.Protocols;
    using System.ComponentModel;
    using System.Xml.Serialization;
    
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="messagewebserverSoap", Namespace="http://tempuri.org/")]
    public partial class messagewebserver : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        private System.Threading.SendOrPostCallback CheckingClientOperationCompleted;
        
        private System.Threading.SendOrPostCallback CreateMessageServerOperationCompleted;
        
        private bool useDefaultCredentialsSetExplicitly;
        
        /// <remarks/>
        public messagewebserver() {
            this.Url = global::SP.Web.Properties.Settings.Default.Aim_Examining_Web_MsgService_messagewebserver;
            if ((this.IsLocalFileSystemWebService(this.Url) == true)) {
                this.UseDefaultCredentials = true;
                this.useDefaultCredentialsSetExplicitly = false;
            }
            else {
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        public new string Url {
            get {
                return base.Url;
            }
            set {
                if ((((this.IsLocalFileSystemWebService(base.Url) == true) 
                            && (this.useDefaultCredentialsSetExplicitly == false)) 
                            && (this.IsLocalFileSystemWebService(value) == false))) {
                    base.UseDefaultCredentials = false;
                }
                base.Url = value;
            }
        }
        
        public new bool UseDefaultCredentials {
            get {
                return base.UseDefaultCredentials;
            }
            set {
                base.UseDefaultCredentials = value;
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        /// <remarks/>
        public event CheckingClientCompletedEventHandler CheckingClientCompleted;
        
        /// <remarks/>
        public event CreateMessageServerCompletedEventHandler CreateMessageServerCompleted;
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/CheckingClient", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public string[] CheckingClient(string cuid, string pw, string ip) {
            object[] results = this.Invoke("CheckingClient", new object[] {
                        cuid,
                        pw,
                        ip});
            return ((string[])(results[0]));
        }
        
        /// <remarks/>
        public void CheckingClientAsync(string cuid, string pw, string ip) {
            this.CheckingClientAsync(cuid, pw, ip, null);
        }
        
        /// <remarks/>
        public void CheckingClientAsync(string cuid, string pw, string ip, object userState) {
            if ((this.CheckingClientOperationCompleted == null)) {
                this.CheckingClientOperationCompleted = new System.Threading.SendOrPostCallback(this.OnCheckingClientOperationCompleted);
            }
            this.InvokeAsync("CheckingClient", new object[] {
                        cuid,
                        pw,
                        ip}, this.CheckingClientOperationCompleted, userState);
        }
        
        private void OnCheckingClientOperationCompleted(object arg) {
            if ((this.CheckingClientCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.CheckingClientCompleted(this, new CheckingClientCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://tempuri.org/CreateMessageServer", RequestNamespace="http://tempuri.org/", ResponseNamespace="http://tempuri.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public void CreateMessageServer(string cuserid, string cusername, string cphone, string cip, string cmessagecontent, string coperatetype) {
            this.Invoke("CreateMessageServer", new object[] {
                        cuserid,
                        cusername,
                        cphone,
                        cip,
                        cmessagecontent,
                        coperatetype});
        }
        
        /// <remarks/>
        public void CreateMessageServerAsync(string cuserid, string cusername, string cphone, string cip, string cmessagecontent, string coperatetype) {
            this.CreateMessageServerAsync(cuserid, cusername, cphone, cip, cmessagecontent, coperatetype, null);
        }
        
        /// <remarks/>
        public void CreateMessageServerAsync(string cuserid, string cusername, string cphone, string cip, string cmessagecontent, string coperatetype, object userState) {
            if ((this.CreateMessageServerOperationCompleted == null)) {
                this.CreateMessageServerOperationCompleted = new System.Threading.SendOrPostCallback(this.OnCreateMessageServerOperationCompleted);
            }
            this.InvokeAsync("CreateMessageServer", new object[] {
                        cuserid,
                        cusername,
                        cphone,
                        cip,
                        cmessagecontent,
                        coperatetype}, this.CreateMessageServerOperationCompleted, userState);
        }
        
        private void OnCreateMessageServerOperationCompleted(object arg) {
            if ((this.CreateMessageServerCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.CreateMessageServerCompleted(this, new System.ComponentModel.AsyncCompletedEventArgs(invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        public new void CancelAsync(object userState) {
            base.CancelAsync(userState);
        }
        
        private bool IsLocalFileSystemWebService(string url) {
            if (((url == null) 
                        || (url == string.Empty))) {
                return false;
            }
            System.Uri wsUri = new System.Uri(url);
            if (((wsUri.Port >= 1024) 
                        && (string.Compare(wsUri.Host, "localHost", System.StringComparison.OrdinalIgnoreCase) == 0))) {
                return true;
            }
            return false;
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void CheckingClientCompletedEventHandler(object sender, CheckingClientCompletedEventArgs e);
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class CheckingClientCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        internal CheckingClientCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        /// <remarks/>
        public string[] Result {
            get {
                this.RaiseExceptionIfNecessary();
                return ((string[])(this.results[0]));
            }
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "4.0.30319.1")]
    public delegate void CreateMessageServerCompletedEventHandler(object sender, System.ComponentModel.AsyncCompletedEventArgs e);
}

#pragma warning restore 1591