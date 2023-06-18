


//com.hbm.socialmodule.SocialModule

package com.hbm.socialmodule
{
    import flash.events.EventDispatcher;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import com.hbm.socialmodule.connection.socialapi.NetworkAPIHandler;
    import com.hbm.socialmodule.connection.Connector;
    import com.hbm.socialmodule.support.SupportServiceData;
    import com.hbm.socialmodule.connection.socialapi.ExtVarsAdapter;
    import com.hbm.socialmodule.connection.LoginSequence;
    import com.hbm.socialmodule.rrhandlers.ApplicationStatusHandler;
    import com.hbm.socialmodule.rrhandlers.BannerFeedbackHandler;
    import com.hbm.socialmodule.rrhandlers.BroadcastInfoHandler;
    import com.hbm.socialmodule.rrhandlers.CreateAccountHandler;
    import com.hbm.socialmodule.rrhandlers.LoadBannersHandler;
    import com.hbm.socialmodule.rrhandlers.LoadRatingHandler;
    import com.hbm.socialmodule.rrhandlers.LoginHandler;
    import com.hbm.socialmodule.rrhandlers.PerformBillPaymentHandler;
    import com.hbm.socialmodule.rrhandlers.RetrieveUserInfoHandler;
    import com.hbm.socialmodule.rrhandlers.SendGameSessionHandler;
    import com.hbm.socialmodule.rrhandlers.SendRatingHandler;
    import com.hbm.socialmodule.rrhandlers.SpendMoneyHandler;
    import com.hbm.socialmodule.rrhandlers.TopUsersHandler;
    import com.hbm.socialmodule.rrhandlers.UpdateFriendsHandler;
    import com.hbm.socialmodule.rrhandlers.GetPartnershipLinkHandler;
    import com.hbm.socialmodule.rrhandlers.GetUserVariableHandler;
    import com.hbm.socialmodule.rrhandlers.UserServerInfoHandler;
    import com.hbm.socialmodule.rrhandlers.GetAuthkeyHandler;
    import org.as3commons.logging.api.LOGGER_FACTORY;
    import org.as3commons.logging.setup.LevelTargetSetup;
    import org.as3commons.logging.setup.target.TraceTarget;
    import org.as3commons.logging.setup.LogSetupLevel;
    import com.hbm.socialmodule.data.SocialNetworkState;
    import com.hbm.socialmodule.connection.socialapi.APIHandlerFactory;
    import com.hbm.socialmodule.utils.TaskScheduler;
    import flash.events.ErrorEvent;
    import flash.events.Event;
    import flash.utils.ByteArray;
    import com.hbm.socialmodule.connection.crypto.Base64;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import com.hbm.socialmodule.rrhandlers.*;
    import org.as3commons.logging.api.*;
    import org.as3commons.logging.setup.*;

    public class SocialModule extends EventDispatcher 
    {

        private static const logger:ILogger = getLogger(SocialModule);

        private var _networkApi:NetworkAPIHandler;
        private var _serverConnector:Connector;
        private var _supportData:SupportServiceData;
        private var _apiVars:ExtVarsAdapter;
        private var _loggedIn:Boolean = false;
        private var _hiddenMode:Boolean = false;
        private var _loginSequence:LoginSequence;
        private var _applicationStatusHandler:ApplicationStatusHandler;
        private var _bannerFeedbackHandler:BannerFeedbackHandler;
        private var _broadcastInfoHandler:BroadcastInfoHandler;
        private var _createAccountHandler:CreateAccountHandler;
        private var _loadBannersHandler:LoadBannersHandler;
        private var _loadRatingHandler:LoadRatingHandler;
        private var _loginHandler:LoginHandler;
        private var _performBillPaymentHandler:PerformBillPaymentHandler;
        private var _retrieveUserInfoHandler:RetrieveUserInfoHandler;
        private var _sendGameSessionHandler:SendGameSessionHandler;
        private var _sendRatingHandler:SendRatingHandler;
        private var _spendMoneyHandler:SpendMoneyHandler;
        private var _topUsersHandler:TopUsersHandler;
        private var _updateFriendsHandler:UpdateFriendsHandler;
        private var _getPartnershipLinkHandler:GetPartnershipLinkHandler;
        private var _getUserVariableHandler:GetUserVariableHandler;
        private var _userServerInfoHandler:UserServerInfoHandler;
        private var _getAuthkeyHandler:GetAuthkeyHandler;

        public function SocialModule(_arg_1:Object, _arg_2:String, _arg_3:String, _arg_4:uint)
        {
            if (!LOGGER_FACTORY.setup)
            {
                LOGGER_FACTORY.setup = new LevelTargetSetup(new TraceTarget(), LogSetupLevel.ERROR);
            };
            SocialNetworkState.Instance.SetNetworkType(_arg_4);
            this._networkApi = APIHandlerFactory.CreateAPIHandler(_arg_1, _arg_3, _arg_4);
            this._networkApi.addListener(TaskScheduler.INTERRUPTED, this.OnSSRequestsDropped);
            this._apiVars = this._networkApi.GetExternalVars();
            this._serverConnector = new Connector(_arg_2);
            this._serverConnector.addEventListener(ErrorEvent.ERROR, this.OnConnectionError);
            this._supportData = new SupportServiceData(this._serverConnector, this._networkApi);
            this._supportData.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this.InitRRHandlers(this._serverConnector, this._networkApi);
            this._loginSequence = new LoginSequence(this._loginHandler, this._createAccountHandler, this._networkApi);
            this._loginSequence.addEventListener(Event.COMPLETE, this.OnLogin);
        }

        private function ParseParentUrl(_arg_1:String):Object
        {
            var _local_3:ByteArray;
            var _local_4:String;
            var _local_5:String;
            var _local_6:Array;
            var _local_7:int;
            var _local_8:Array;
            var _local_2:Object = new Object();
            if (((_arg_1) && (!(_arg_1 == ""))))
            {
                _local_3 = Base64.decode(_arg_1);
                _local_3.position = 0;
                _local_4 = _local_3.readUTFBytes(_local_3.length);
                _local_5 = _local_4.split("?", 2)[1];
                if (_local_5)
                {
                    _local_6 = _local_5.split("&");
                    _local_7 = 0;
                    while (_local_7 < _local_6.length)
                    {
                        _local_8 = _local_6[_local_7].split("=");
                        _local_2[_local_8[0]] = _local_8[1];
                        _local_7++;
                    };
                };
            };
            return (_local_2);
        }

        private function InitRRHandlers(_arg_1:RRLoader, _arg_2:NetworkAPIHandler):void
        {
            this._applicationStatusHandler = new ApplicationStatusHandler(_arg_1, _arg_2);
            this._bannerFeedbackHandler = new BannerFeedbackHandler(_arg_1, _arg_2);
            this._broadcastInfoHandler = new BroadcastInfoHandler(_arg_1, _arg_2);
            this._createAccountHandler = new CreateAccountHandler(_arg_1, _arg_2);
            this._loadBannersHandler = new LoadBannersHandler(_arg_1, _arg_2);
            this._loadRatingHandler = new LoadRatingHandler(_arg_1, _arg_2);
            this._loginHandler = new LoginHandler(_arg_1, _arg_2);
            this._performBillPaymentHandler = new PerformBillPaymentHandler(_arg_1, _arg_2);
            this._retrieveUserInfoHandler = new RetrieveUserInfoHandler(_arg_1, _arg_2);
            this._sendGameSessionHandler = new SendGameSessionHandler(_arg_1, _arg_2);
            this._sendRatingHandler = new SendRatingHandler(_arg_1, _arg_2);
            this._spendMoneyHandler = new SpendMoneyHandler(_arg_1, _arg_2);
            this._topUsersHandler = new TopUsersHandler(_arg_1, _arg_2);
            this._updateFriendsHandler = new UpdateFriendsHandler(_arg_1, _arg_2);
            this._getPartnershipLinkHandler = new GetPartnershipLinkHandler(_arg_1, _arg_2);
            this._getUserVariableHandler = new GetUserVariableHandler(_arg_1, _arg_2);
            this._userServerInfoHandler = new UserServerInfoHandler(_arg_1, _arg_2);
            this._getAuthkeyHandler = new GetAuthkeyHandler(_arg_1, _arg_2);
            this._applicationStatusHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._bannerFeedbackHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._broadcastInfoHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._createAccountHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._loadBannersHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._loadRatingHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._loginHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._performBillPaymentHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._retrieveUserInfoHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._sendGameSessionHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._sendRatingHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._spendMoneyHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._topUsersHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._updateFriendsHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._getPartnershipLinkHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._getUserVariableHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._userServerInfoHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
            this._getAuthkeyHandler.addEventListener(ErrorEvent.ERROR, this.RedispatchOnError);
        }

        protected function OnLogin(_arg_1:Event):void
        {
            if (!this._hiddenMode)
            {
                if (!this._networkApi.GetAccessSettings().CheckCurrentSettings())
                {
                    this._networkApi.addListener(ResponseEvent.SETTINGS_CHANGED, this.OnSettingsChanged);
                    this._networkApi.CallSettingsBox();
                };
            };
            this._loggedIn = true;
            dispatchEvent(new Event(Event.CONNECT));
        }

        public function get ApplicationStatus():ApplicationStatusHandler
        {
            return (this._applicationStatusHandler);
        }

        public function get BannerFeedback():BannerFeedbackHandler
        {
            return (this._bannerFeedbackHandler);
        }

        public function get BroadcastInfo():BroadcastInfoHandler
        {
            return (this._broadcastInfoHandler);
        }

        public function get CreateAccount():CreateAccountHandler
        {
            return (this._createAccountHandler);
        }

        public function get LoadBanners():LoadBannersHandler
        {
            return (this._loadBannersHandler);
        }

        public function get LoadRating():LoadRatingHandler
        {
            return (this._loadRatingHandler);
        }

        public function get Login():LoginHandler
        {
            return (this._loginHandler);
        }

        public function get PerformBillPayment():PerformBillPaymentHandler
        {
            return (this._performBillPaymentHandler);
        }

        public function get RetrieveUserInfo():RetrieveUserInfoHandler
        {
            return (this._retrieveUserInfoHandler);
        }

        public function get SendGameSession():SendGameSessionHandler
        {
            return (this._sendGameSessionHandler);
        }

        public function get SendRating():SendRatingHandler
        {
            return (this._sendRatingHandler);
        }

        public function get SpendMoney():SpendMoneyHandler
        {
            return (this._spendMoneyHandler);
        }

        public function get TopUsers():TopUsersHandler
        {
            return (this._topUsersHandler);
        }

        public function get UpdateFriends():UpdateFriendsHandler
        {
            return (this._updateFriendsHandler);
        }

        public function get GetPartnersLink():GetPartnershipLinkHandler
        {
            return (this._getPartnershipLinkHandler);
        }

        public function get GetServerVariable():GetUserVariableHandler
        {
            return (this._getUserVariableHandler);
        }

        public function get UserServerInfo():UserServerInfoHandler
        {
            return (this._userServerInfoHandler);
        }

        public function get GetAuthkey():GetAuthkeyHandler
        {
            return (this._getAuthkeyHandler);
        }

        private function OnSSRequestsDropped(_arg_1:Event):void
        {
            dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, "Social System Request failed."));
        }

        protected function OnSettingsChanged(_arg_1:Number):void
        {
        }

        protected function RedispatchOnError(_arg_1:ErrorEvent):void
        {
            dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, _arg_1.text));
        }

        private function OnConnectionError(_arg_1:ErrorEvent):void
        {
            logger.error(_arg_1.text);
        }

        public function IsFriendsAccessible():Boolean
        {
            return (this._networkApi.GetAccessSettings().FriendListAccess());
        }

        public function IsWallAccessible():Boolean
        {
            return (this._networkApi.GetAccessSettings().WallAccess());
        }

        public function get loggedIn():Boolean
        {
            return (this._loggedIn);
        }

        public function get NetworkApi():NetworkAPIHandler
        {
            return (this._networkApi);
        }

        public function get ServerConnector():Connector
        {
            return (this._serverConnector);
        }

        public function get SupportData():SupportServiceData
        {
            return (this._supportData);
        }

        public function get GamePassword():String
        {
            return (this._networkApi.GetGamePassword());
        }

        public function get hiddenMode():Boolean
        {
            return (this._hiddenMode);
        }

        public function set hiddenMode(_arg_1:Boolean):void
        {
            this._hiddenMode = _arg_1;
        }


    }
}//package com.hbm.socialmodule

