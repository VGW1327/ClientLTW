


//com.hbm.socialmodule.connection.socialapi.facebook.FacebookAPIHandler

package com.hbm.socialmodule.connection.socialapi.facebook
{
    import flash.events.EventDispatcher;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.socialapi.ExtVarsAdapter;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import com.hbm.socialmodule.connection.socialapi.AccessSettings;
    import flash.external.ExternalInterface;
    import com.hbm.socialmodule.rrhandlers.SpendMoneyHandler;

    public class FacebookAPIHandler extends EventDispatcher implements NetworkAPIHandler 
    {

        private const _hbmURL:String = "";

        private var _appVars:Object;
        private var _externalVars:ExtVarsAdapter;
        private var _accessSettings:FacebookAccessSettings;
        private var _requestHandler:FacebookHTTPHandler;

        public function FacebookAPIHandler(_arg_1:Object)
        {
            this._appVars = _arg_1;
            this._requestHandler = new FacebookHTTPHandler(this._appVars);
            this._accessSettings = new FacebookAccessSettings();
            this._requestHandler.addEventListener(ResponseEvent.GET_FRIENDS, this.RedispatchEvent);
            this._requestHandler.addEventListener(ResponseEvent.GET_USER_INFO, this.RedispatchEvent);
            this._requestHandler.addEventListener(ResponseEvent.GET_PROFILES, this.RedispatchEvent);
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

        public function GetExternalVars():ExtVarsAdapter
        {
            var _local_1:Object;
            if (this._externalVars == null)
            {
                _local_1 = new Object();
                _local_1.apiId = "api_id";
                _local_1.viewerId = "user_id";
                _local_1.isAppInstalled = "is_app_user";
                _local_1.authenticationKey = "auth_key";
                this._externalVars = new ExtVarsAdapter(this._appVars, _local_1);
            };
            return (this._externalVars);
        }

        public function GetAccessSettings():AccessSettings
        {
            return (this._accessSettings);
        }

        public function GetGamePassword():String
        {
            return (this._externalVars.authenticationKey);
        }

        public function CallInviteBox():void
        {
            ExternalInterface.call("callInvites()");
        }

        public function CallInstallBox():void
        {
        }

        public function CallSettingsBox():void
        {
        }

        public function get Result():Object
        {
            return (this._requestHandler.response);
        }

        private function RedispatchEvent(_arg_1:ResponseEvent):void
        {
            dispatchEvent(_arg_1.clone());
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
        }

        public function GetInviterId():String
        {
            return ("0");
        }

        public function WallPost(_arg_1:Object=null):void
        {
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.facebook

