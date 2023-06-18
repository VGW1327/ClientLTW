


//com.hbm.socialmodule.connection.socialapi.mailru.MailruAPIHandler

package com.hbm.socialmodule.connection.socialapi.mailru
{
    import flash.net.URLLoader;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import com.hbm.socialmodule.connection.socialapi.ExtVarsAdapter;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.system.Security;
    import flash.external.ExternalInterface;
    import com.hbm.socialmodule.connection.socialapi.AccessSettings;
    import flash.events.Event;
    import com.hbm.socialmodule.rrhandlers.SpendMoneyHandler;
    import com.adobe.serialization.json.JSON2;
    import com.hbm.socialmodule.connection.socialapi.*;

    public class MailruAPIHandler extends URLLoader implements NetworkAPIHandler 
    {

        private static const logger:ILogger = getLogger(MailruAPIHandler);

        private var _requestHandler:MailruHTTPHandler;
        private var _accessSettings:MailruAccessSettings;
        private var _externalVars:ExtVarsAdapter;
        private var _appVars:Object;
        private var _isFrame:Boolean;

        public function MailruAPIHandler(_arg_1:Object, _arg_2:String)
        {
            this._appVars = _arg_1;
            this._requestHandler = new MailruHTTPHandler(this._appVars, _arg_2);
            this._accessSettings = new MailruAccessSettings(this._appVars);
            this._requestHandler.addEventListener(ResponseEvent.GET_FRIENDS, this.RedispatchEvent);
            this._requestHandler.addEventListener(ResponseEvent.GET_USER_INFO, this.RedispatchEvent);
            this._requestHandler.addEventListener(ResponseEvent.GET_PROFILES, this.RedispatchEvent);
            this._isFrame = (!(this._appVars["social_network"] == null));
            Security.allowDomain("*");
            MailruCall.init("flash-game", _arg_2);
            if (this._isFrame)
            {
                ExternalInterface.addCallback("SendApplicationAddedEvent", this.OnApplicationAdded);
                ExternalInterface.addCallback("SendSettingsChangedEvent", this.OnSettingsChanged);
            };
        }

        public function get Result():Object
        {
            return (this._requestHandler.answer);
        }

        public function GetExternalVars():ExtVarsAdapter
        {
            var _local_1:Object;
            if (this._externalVars == null)
            {
                _local_1 = new Object();
                _local_1.apiId = "app_id";
                _local_1.viewerId = "vid";
                _local_1.isAppInstalled = "is_app_user";
                _local_1.authenticationKey = "authentication_key";
                _local_1.referrerType = "referer_type";
                this._externalVars = new ExtVarsAdapter(this._appVars, _local_1);
            };
            return (this._externalVars);
        }

        public function GetAccessSettings():AccessSettings
        {
            return (this._accessSettings);
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

        public function GetGamePassword():String
        {
            return (this._externalVars.authenticationKey);
        }

        public function CallInviteBox():void
        {
            if (this._isFrame)
            {
                ExternalInterface.call("mailru.app.friends.invite()");
            }
            else
            {
                MailruCall.exec("mailru.app.friends.invite", this.OnApplicationInvite);
            };
        }

        public function CallInstallBox():void
        {
            if (this._isFrame)
            {
                ExternalInterface.call("mailru.app.users.requireInstallation()");
            }
            else
            {
                MailruCall.exec("mailru.app.users.requireInstallation", this.OnApplicationAdded);
            };
        }

        public function CallSettingsBox():void
        {
        }

        private function RedispatchEvent(_arg_1:ResponseEvent):void
        {
            dispatchEvent(_arg_1.clone());
        }

        private function OnApplicationAdded(_arg_1:Object):void
        {
            if (_arg_1.status == "succsess")
            {
                dispatchEvent(new Event(ResponseEvent.INSTALLED));
            };
        }

        private function OnSettingsChanged(_arg_1:Object):void
        {
            dispatchEvent(new Event(ResponseEvent.SETTINGS_CHANGED));
        }

        private function OnApplicationInvite(_arg_1:Object):void
        {
            dispatchEvent(new Event(ResponseEvent.INVITE));
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
            _arg_1.OpenMailRuDialog();
        }

        public function GetInviterId():String
        {
            return ("0");
        }

        public function WallPost(_arg_1:Object=null):void
        {
            var _local_2:Object = {};
            if (_arg_1)
            {
                if (_arg_1.message)
                {
                    _local_2.text = _arg_1.message;
                };
                if (_arg_1.image)
                {
                    _local_2.img_url = _arg_1.image;
                };
                if (_arg_1.url)
                {
                    _local_2.title = _arg_1.url;
                };
                if (_arg_1.target_id)
                {
                    _local_2.uid = _arg_1.target_id;
                };
                if (this._isFrame)
                {
                    if (_arg_1.target_id)
                    {
                        logger.debug(("ExternalInterface guestbook.post: " + JSON2.encode(_local_2).toString()));
                        ExternalInterface.call((("mailru.common.guestbook.post(" + JSON2.encode(_local_2).toString()) + ")"));
                    }
                    else
                    {
                        logger.debug(("ExternalInterface guestbook.post: " + JSON2.encode(_local_2).toString()));
                        ExternalInterface.call((("mailru.common.stream.post(" + JSON2.encode(_local_2).toString()) + ")"));
                    };
                }
                else
                {
                    if (_arg_1.target_id)
                    {
                        logger.debug("MailruCall guestbook.post");
                        MailruCall.exec("mailru.common.guestbook.post", null, _local_2);
                    }
                    else
                    {
                        logger.debug("MailruCall guestbook.post");
                        MailruCall.exec("mailru.common.stream.post", null, _local_2);
                    };
                };
            };
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.mailru

