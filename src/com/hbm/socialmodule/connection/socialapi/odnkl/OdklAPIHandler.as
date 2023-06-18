


//com.hbm.socialmodule.connection.socialapi.odnkl.OdklAPIHandler

package com.hbm.socialmodule.connection.socialapi.odnkl
{
    import flash.events.EventDispatcher;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import com.hbm.socialmodule.connection.socialapi.ExtVarsAdapter;
    import com.odnoklassniki.Odnoklassniki;
    import com.adobe.serialization.json.JSON2;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import com.odnoklassniki.events.ApiCallbackEvent;
    import com.hbm.socialmodule.connection.socialapi.AccessSettings;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.SpendMoneyHandler;

    public class OdklAPIHandler extends EventDispatcher implements NetworkAPIHandler 
    {

        private static const logger:ILogger = getLogger(OdklAPIHandler);
        private static const STREAM_PUBLISH:String = "stream.publish";

        private var _httpHandler:OdklHTTPHandler;
        private var _accessSettings:OdklAccessSettings;
        private var _appVars:Object;
        private var _externalVars:ExtVarsAdapter;
        private var _requestWall:Object;
        private var _lastMethod:String;

        public function OdklAPIHandler(_arg_1:Object, _arg_2:String)
        {
            this._appVars = _arg_1;
            Odnoklassniki.initialize(this._appVars);
            this._httpHandler = new OdklHTTPHandler(this._appVars, _arg_2);
            this._accessSettings = new OdklAccessSettings();
            this.SetListeners();
        }

        private static function onStreamPublish(_arg_1:Object):void
        {
            logger.debug(("stream.publish end " + JSON2.encode(_arg_1).toString()));
        }


        private function SetListeners():void
        {
            this._httpHandler.addEventListener(ResponseEvent.GET_FRIENDS, this.RedispatchEvent);
            this._httpHandler.addEventListener(ResponseEvent.GET_USER_INFO, this.RedispatchEvent);
            this._httpHandler.addEventListener(ResponseEvent.GET_PROFILES, this.RedispatchEvent);
            Odnoklassniki.addEventListener(ApiCallbackEvent.CALL_BACK, this.onApiCallBack);
        }

        private function RedispatchEvent(_arg_1:ResponseEvent):void
        {
            dispatchEvent(_arg_1.clone());
        }

        private function OnApiEvent(_arg_1:ApiCallbackEvent):void
        {
            var _local_2:Object;
            if (_arg_1.method == "showPayment")
            {
                _local_2 = JSON.parse(_arg_1.data);
                dispatchEvent(new ResponseEvent(ResponseEvent.ONLINE_BILLING, _local_2));
            };
        }

        public function GetFriends():void
        {
            this._httpHandler.GetFriends();
        }

        public function GetUserInfo():void
        {
            this._httpHandler.GetUserInfo();
        }

        public function GetProfiles(_arg_1:Array):void
        {
            this._httpHandler.GetProfiles(_arg_1);
        }

        public function GetExternalVars():ExtVarsAdapter
        {
            var _local_1:Object;
            if (this._externalVars == null)
            {
                _local_1 = this.CreateKeysForAppVars();
                this._externalVars = new ExtVarsAdapter(this._appVars, _local_1);
            };
            return (this._externalVars);
        }

        private function CreateKeysForAppVars():Object
        {
            var _local_1:Object = new Object();
            _local_1.apiId = "application_key";
            _local_1.viewerId = "logged_user_id";
            _local_1.isAppInstalled = "authorized";
            _local_1.authenticationKey = "auth_sig";
            _local_1.sessionKey = "session_key";
            _local_1.referrerType = "refplace";
            return (_local_1);
        }

        public function GetAccessSettings():AccessSettings
        {
            return (this._accessSettings);
        }

        public function GetGamePassword():String
        {
            return (this._externalVars.sessionKey);
        }

        public function CallInviteBox():void
        {
            Odnoklassniki.showInvite();
        }

        public function CallInstallBox():void
        {
        }

        public function CallSettingsBox():void
        {
        }

        public function get Result():Object
        {
            return (this._httpHandler.response);
        }

        private function OnApplicationAdded(_arg_1:Event):void
        {
            dispatchEvent(new Event(ResponseEvent.INSTALLED));
        }

        private function OnSettingsChanged(_arg_1:Event):void
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
            return (null);
        }

        public function PerformPayment(_arg_1:SpendMoneyHandler):void
        {
            _arg_1.OpenOdnoklDialog();
        }

        public function GetInviterId():String
        {
            return ("0");
        }

        public function WallPost(_arg_1:Object=null):void
        {
            var _local_2:Object;
            var _local_3:Object;
            if (_arg_1)
            {
                this._lastMethod = STREAM_PUBLISH;
                this._requestWall = {"method":STREAM_PUBLISH};
                if (((_arg_1.url) && (_arg_1.message)))
                {
                    this._requestWall.message = ((_arg_1.message + " ") + _arg_1.url);
                }
                else
                {
                    if (_arg_1.message)
                    {
                        this._requestWall.message = _arg_1.message;
                    };
                };
                if (_arg_1.image)
                {
                    _local_2 = {};
                    _local_2.src = _arg_1.image;
                    _local_2.type = "image";
                    _local_3 = {};
                    _local_3.media = [_local_2];
                    this._requestWall.attachment = JSON2.encode(_local_3);
                };
                if (_arg_1.target_id)
                {
                    this._requestWall.uid = _arg_1.target_id;
                };
                this._requestWall = Odnoklassniki.getSignature(this._requestWall, true);
                logger.debug(("stream.publish start, request: " + JSON2.encode(this._requestWall)));
                Odnoklassniki.showConfirmation(STREAM_PUBLISH, _arg_1.message, this._requestWall["sig"]);
            };
        }

        private function onApiCallBack(_arg_1:ApiCallbackEvent):void
        {
            var _local_2:Object;
            if (_arg_1.method == "showPayment")
            {
                _local_2 = JSON.parse(_arg_1.data);
                dispatchEvent(new ResponseEvent(ResponseEvent.ONLINE_BILLING, _local_2));
                return;
            };
            if (_arg_1.method == "showConfirmation")
            {
                switch (_arg_1.result)
                {
                    case "ok":
                        this._requestWall["resig"] = _arg_1.data;
                        logger.debug(("callRestApi stream.publish start, request: " + JSON2.encode(this._requestWall)));
                        Odnoklassniki.callRestApi(STREAM_PUBLISH, onStreamPublish, this._requestWall);
                        return;
                    case "cancel":
                        logger.debug("stream.publish: has been canceled");
                        return;
                };
            };
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.odnkl

