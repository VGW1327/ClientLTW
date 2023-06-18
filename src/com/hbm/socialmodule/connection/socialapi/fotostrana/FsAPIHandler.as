


//com.hbm.socialmodule.connection.socialapi.fotostrana.FsAPIHandler

package com.hbm.socialmodule.connection.socialapi.fotostrana
{
    import flash.events.EventDispatcher;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.socialapi.ExtVarsAdapter;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.external.ExternalInterface;
    import com.hbm.socialmodule.connection.socialapi.AccessSettings;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.SpendMoneyHandler;
    import com.hbm.socialmodule.connection.*;
    import com.hbm.socialmodule.connection.socialapi.*;

    public class FsAPIHandler extends EventDispatcher implements NetworkAPIHandler 
    {

        private const _hbmURL:String = "";

        private var _appVars:Object;
        private var _externalVars:ExtVarsAdapter;
        private var _accessSettings:FsAccessSettings;
        private var _requestHandler:FsHTTPHandler;

        public function FsAPIHandler(_arg_1:Object, _arg_2:String)
        {
            this._appVars = _arg_1;
            this._requestHandler = new FsHTTPHandler(this._appVars, _arg_2);
            this._accessSettings = new FsAccessSettings(this._appVars);
            this._requestHandler.addEventListener(ResponseEvent.GET_FRIENDS, this.RedispatchEvent);
            this._requestHandler.addEventListener(ResponseEvent.GET_USER_INFO, this.RedispatchEvent);
            this._requestHandler.addEventListener(ResponseEvent.GET_PROFILES, this.RedispatchEvent);
        }

        public function GetExternalVars():ExtVarsAdapter
        {
            var _local_1:Object;
            if (this._externalVars == null)
            {
                _local_1 = new Object();
                _local_1.apiId = "apiId";
                _local_1.viewerId = "viewerId";
                _local_1.isAppInstalled = "isAppUser";
                _local_1.authenticationKey = "authKey";
                _local_1.referrerType = "referrer";
                _local_1.clientSecret = "clientSecret";
                this._externalVars = new ExtVarsAdapter(this._appVars, _local_1);
            };
            return (this._externalVars);
        }

        public function GetFriends():void
        {
            this._requestHandler.GetFriends();
        }

        public function GetUserInfo():void
        {
            this._requestHandler.GetUserInfo();
        }

        public function GetProfiles(_arg_1:Array):void
        {
            this._requestHandler.GetProfiles(_arg_1);
        }

        public function CallInviteBox():void
        {
            ExternalInterface.call("invite");
        }

        public function CallInstallBox():void
        {
        }

        public function CallSettingsBox():void
        {
            ExternalInterface.call("settings");
        }

        public function GetAccessSettings():AccessSettings
        {
            return (this._accessSettings);
        }

        public function get Result():Object
        {
            return (this._requestHandler.Result);
        }

        public function GetGamePassword():String
        {
            return (this._externalVars.authenticationKey);
        }

        private function RedispatchEvent(_arg_1:ResponseEvent):void
        {
            dispatchEvent(_arg_1.clone());
        }

        private function OnApplicationAdded():void
        {
            dispatchEvent(new Event(ResponseEvent.INSTALLED));
        }

        private function OnSettingsChanged():void
        {
            dispatchEvent(new Event(ResponseEvent.SETTINGS_CHANGED));
        }

        public function addListener(_arg_1:String, _arg_2:Function):void
        {
            addEventListener(_arg_1, _arg_2);
        }

        public function removeListener(_arg_1:String, _arg_2:Function):void
        {
            removeEventListener(_arg_1, _arg_2);
        }

        public function GetHBMGroupURL():String
        {
            return (this._hbmURL);
        }

        public function PerformPayment(_arg_1:SpendMoneyHandler):void
        {
            _arg_1.OpenFotostranaPaymentDialog();
        }

        public function GetInviterId():String
        {
            return ("0");
        }

        public function WallPost(_arg_1:Object=null):void
        {
            if (((((_arg_1) && (_arg_1.message)) && (_arg_1.image)) && (_arg_1.url)))
            {
                this._requestHandler.WallPost(_arg_1.message, _arg_1.image, _arg_1.url);
            };
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.fotostrana

