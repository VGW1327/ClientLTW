


//com.hbm.socialmodule.connection.LoginSequence

package com.hbm.socialmodule.connection
{
    import flash.events.EventDispatcher;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import com.hbm.socialmodule.rrhandlers.LoginHandler;
    import com.hbm.socialmodule.rrhandlers.CreateAccountHandler;
    import com.hbm.socialmodule.connection.socialapi.ExtVarsAdapter;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import com.hbm.socialmodule.data.UserObject;

    public class LoginSequence extends EventDispatcher 
    {

        private static const logger:ILogger = getLogger(LoginSequence);

        private var _login:LoginHandler;
        private var _create:CreateAccountHandler;
        private var _vars:ExtVarsAdapter;
        private var _network:NetworkAPIHandler;

        public function LoginSequence(_arg_1:LoginHandler, _arg_2:CreateAccountHandler, _arg_3:NetworkAPIHandler)
        {
            this._login = _arg_1;
            this._create = _arg_2;
            this._vars = _arg_3.GetExternalVars();
            this._network = _arg_3;
            this.InitLoginSequence();
        }

        private function InitLoginSequence():void
        {
            this._login.addEventListener(ErrorEvent.ERROR, this.OnLoginFailed);
            this._create.addEventListener(Event.COMPLETE, this.OnCreationComplete);
            this._login.addEventListener(Event.COMPLETE, this.OnLogin);
        }

        private function OnLoginFailed(_arg_1:ErrorEvent):void
        {
            if (_arg_1.text == "wrongAuthorization")
            {
                logger.info("Unable to authorize. Creating new account.");
                this.BeginCreatingAccount();
            };
        }

        private function BeginCreatingAccount():void
        {
            logger.debug("Requesting user info...");
            this._network.addListener(ResponseEvent.GET_USER_INFO, this.OnUserInfoReceived);
            this._network.GetUserInfo();
        }

        private function OnUserInfoReceived(_arg_1:ResponseEvent):void
        {
            logger.debug("Got user info. Creating account.");
            this._network.removeListener(ResponseEvent.GET_USER_INFO, this.OnUserInfoReceived);
            var _local_2:UserObject = UserObject(_arg_1.data);
            this._create.SendRequest(((_local_2.Name + " ") + _local_2.LastName), _local_2.Sex, _local_2.BirthDate, _local_2.City, this._vars.referrerType);
        }

        private function OnCreationComplete(_arg_1:Event):void
        {
            logger.info("Account created. Trying to log in.");
            this._login.SendRequest();
        }

        private function OnLogin(_arg_1:ResponseEvent):void
        {
            dispatchEvent(new Event(Event.COMPLETE));
        }


    }
}//package com.hbm.socialmodule.connection

