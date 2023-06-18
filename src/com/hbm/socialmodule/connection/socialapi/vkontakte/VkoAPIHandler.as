


//com.hbm.socialmodule.connection.socialapi.vkontakte.VkoAPIHandler

package com.hbm.socialmodule.connection.socialapi.vkontakte
{
    import flash.events.EventDispatcher;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import com.hbm.socialmodule.connection.socialapi.ExtVarsAdapter;
    import vk.APIConnection;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import flash.external.ExternalInterface;
    import com.hbm.socialmodule.connection.socialapi.AccessSettings;
    import com.hbm.socialmodule.rrhandlers.SpendMoneyHandler;
    import com.hbm.socialmodule.connection.*;
    import com.hbm.socialmodule.connection.socialapi.*;

    public class VkoAPIHandler extends EventDispatcher implements NetworkAPIHandler 
    {

        private static const logger:ILogger = getLogger(VkoAPIHandler);

        private const _hbmURL:String = "http://vkontakte.ru/club14353060";

        private var _appVars:Object;
        private var _externalVars:ExtVarsAdapter;
        private var _accessSettings:VkoAccessSettings;
        private var _requestHandler:VkoHTTPHandler;
        private var _apiConnection:APIConnection;
        private var _isFrameApp:Boolean = false;

        public function VkoAPIHandler(externalParameters:Object, secureCode:String)
        {
            super();
            this._appVars = externalParameters;
            this._requestHandler = new VkoHTTPHandler(this._appVars, secureCode);
            this._accessSettings = new VkoAccessSettings(this._appVars);
            this._requestHandler.addEventListener(ResponseEvent.GET_FRIENDS, this.RedispatchEvent);
            this._requestHandler.addEventListener(ResponseEvent.GET_USER_INFO, this.RedispatchEvent);
            this._requestHandler.addEventListener(ResponseEvent.GET_PROFILES, this.RedispatchEvent);
            this._isFrameApp = (!(this._appVars["social_network"] == null));
            if (!this._isFrameApp)
            {
                this._apiConnection = new APIConnection(this._appVars);
                this._apiConnection.addEventListener("onApplicationAdded", function (_arg_1:Event):void
                {
                    OnApplicationAdded();
                });
                this._apiConnection.addEventListener("onSettingsChanged", function (_arg_1:Event):void
                {
                    OnSettingsChanged();
                });
            }
            else
            {
                ExternalInterface.addCallback("SendApplicationAddedEvent", this.OnApplicationAdded);
                ExternalInterface.addCallback("SendSettingsChangedEvent", this.OnSettingsChanged);
            };
        }

        public function GetExternalVars():ExtVarsAdapter
        {
            var _local_1:Object;
            if (this._externalVars == null)
            {
                _local_1 = new Object();
                _local_1.apiId = "api_id";
                _local_1.viewerId = "viewer_id";
                _local_1.isAppInstalled = "is_app_user";
                _local_1.authenticationKey = "auth_key";
                _local_1.referrerType = "referrer";
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
            if (this._isFrameApp)
            {
                ExternalInterface.call('VK.callMethod( "showInviteBox" )');
            }
            else
            {
                this._apiConnection.callMethod("showInviteBox");
            };
        }

        public function CallInstallBox():void
        {
            if (this._isFrameApp)
            {
                ExternalInterface.call('VK.callMethod( "showInstallBox" )');
            }
            else
            {
                this._apiConnection.callMethod("showInstallBox");
            };
        }

        public function CallSettingsBox():void
        {
            if (this._isFrameApp)
            {
                ExternalInterface.call((('VK.callMethod( "showSettingsBox", ' + this._accessSettings.PreferredSettings) + " )"));
            }
            else
            {
                this._apiConnection.callMethod("showSettingsBox", this._accessSettings.PreferredSettings);
            };
        }

        public function WallPost(_arg_1:Object=null):void
        {
            var _local_2:Object = {};
            if (_arg_1)
            {
                if (((_arg_1.url) && (_arg_1.message)))
                {
                    _local_2.message = ((_arg_1.message + " ") + _arg_1.url);
                }
                else
                {
                    if (_arg_1.message)
                    {
                        _local_2.message = _arg_1.message;
                    };
                };
                if (((_arg_1.source_id) && (_arg_1.media_id)))
                {
                    _local_2.attachments = ((("photo" + _arg_1.source_id) + "_") + _arg_1.media_id);
                };
                if (_arg_1.image)
                {
                    _local_2.attachments = _arg_1.image;
                };
                if (_arg_1.target_id)
                {
                    _local_2.owner_id = _arg_1.target_id;
                };
            };
            if (this._isFrameApp)
            {
                logger.debug("ExternalInterface wall.post");
                ExternalInterface.call("VK.api", "wall.post", _local_2);
            }
            else
            {
                logger.debug("_apiConnection wall.post");
                this._apiConnection.api("wall.post", _local_2);
            };
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
            _arg_1.OpenVkontaktePaymentDialog();
        }

        public function GetInviterId():String
        {
            if ((((this._appVars["group_id"] == 0) && (this._appVars["viewer_type"] == 1)) && (!(this._appVars["user_id"] == 0))))
            {
                return (this._appVars["user_id"]);
            };
            return ("0");
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.vkontakte

