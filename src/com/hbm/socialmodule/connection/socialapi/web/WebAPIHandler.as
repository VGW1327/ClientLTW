


//com.hbm.socialmodule.connection.socialapi.web.WebAPIHandler

package com.hbm.socialmodule.connection.socialapi.web
{
    import flash.events.EventDispatcher;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.socialapi.AccessSettings;
    import com.hbm.socialmodule.connection.socialapi.ExtVarsAdapter;
    import com.hbm.socialmodule.data.UserObject;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import com.hbm.socialmodule.rrhandlers.SpendMoneyHandler;

    public class WebAPIHandler extends EventDispatcher implements NetworkAPIHandler 
    {

        private const _hbmURL:String = "http://vkontakte.ru/club14353060";

        private var _accessSettings:AccessSettings;
        private var _appVars:Object;
        private var _externalVars:ExtVarsAdapter;
        private var _result:Object;

        public function WebAPIHandler(_arg_1:Object)
        {
            this._appVars = _arg_1;
            this._accessSettings = new WebAccessSettings();
        }

        public function GetFriends():void
        {
            throw (new Error("Method not supported on this social network type."));
        }

        public function GetUserInfo():void
        {
            var _local_1:UserObject = this.CreateUser(this._externalVars.viewerId);
            this._result = _local_1;
            dispatchEvent(new ResponseEvent(ResponseEvent.GET_USER_INFO, _local_1));
        }

        private function CreateUser(_arg_1:String):UserObject
        {
            return (new UserObject(null, null, _arg_1, null));
        }

        public function GetProfiles(_arg_1:Array):void
        {
            var _local_3:String;
            var _local_2:Array = [];
            for each (_local_3 in _arg_1)
            {
                _local_2.push(this.CreateUser(_local_3));
            };
            this._result = _local_2;
            dispatchEvent(new ResponseEvent(ResponseEvent.GET_PROFILES, _local_2));
        }

        public function GetExternalVars():ExtVarsAdapter
        {
            var _local_1:Object;
            if (this._externalVars == null)
            {
                this._appVars["login"] = (this._appVars["login"] as String).toLowerCase();
                _local_1 = new Object();
                _local_1.apiId = "";
                _local_1.viewerId = "login";
                _local_1.isAppInstalled = "";
                _local_1.authenticationKey = "auth_key";
                _local_1.referrerType = "referrer";
                this._externalVars = new ExtVarsAdapter(this._appVars, _local_1);
            };
            return (this._externalVars);
        }

        public function GetAccessSettings():AccessSettings
        {
            return (this._accessSettings);
        }

        public function CallInviteBox():void
        {
        }

        public function CallInstallBox():void
        {
        }

        public function CallSettingsBox():void
        {
        }

        public function get Result():Object
        {
            return (this._result);
        }

        public function GetHBMGroupURL():String
        {
            return (this._hbmURL);
        }

        public function GetGamePassword():String
        {
            return (this._appVars["passHash"]);
        }

        public function PerformPayment(_arg_1:SpendMoneyHandler):void
        {
            _arg_1.SendOnlineDengiRequest();
        }

        public function addListener(_arg_1:String, _arg_2:Function):void
        {
            addEventListener(_arg_1, _arg_2);
        }

        public function removeListener(_arg_1:String, _arg_2:Function):void
        {
            removeEventListener(_arg_1, _arg_2);
        }

        public function GetInviterId():String
        {
            return ("0");
        }

        public function WallPost(_arg_1:Object=null):void
        {
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.web

