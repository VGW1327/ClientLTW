


//com.hbm.socialmodule.connection.socialapi.vkontakte.VkoHTTPHandler

package com.hbm.socialmodule.connection.socialapi.vkontakte
{
    import flash.events.EventDispatcher;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import com.hbm.socialmodule.utils.TaskScheduler;
    import com.hbm.socialmodule.connection.socialapi.vkontakte.requests.AbstractVkoRequest;
    import com.hbm.socialmodule.connection.socialapi.vkontakte.requests.GetFriendsRequest;
    import com.hbm.socialmodule.connection.socialapi.vkontakte.requests.GetUserInfoRequest;
    import com.hbm.socialmodule.connection.socialapi.vkontakte.requests.GetProfilesRequest;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;

    public class VkoHTTPHandler extends EventDispatcher 
    {

        private static const logger:ILogger = getLogger(VkoHTTPHandler);

        private var _scheduler:TaskScheduler = new TaskScheduler();
        private var _appVars:Object;
        private var _code:String;
        private var _result:Object;
        private var _currentRequest:AbstractVkoRequest;

        public function VkoHTTPHandler(_arg_1:Object, _arg_2:String)
        {
            this._appVars = _arg_1;
            this._code = _arg_2;
            this._scheduler.timeout = 30000;
            this._scheduler.delay = 1000;
            this._scheduler.addEventListener(TaskScheduler.TIMEOUT, this.OnTimeout);
        }

        public function GetFriends():void
        {
            this.SetTask(new GetFriendsRequest(this._appVars));
        }

        public function GetUserInfo():void
        {
            this.SetTask(new GetUserInfoRequest(this._appVars));
        }

        public function GetProfiles(_arg_1:Array):void
        {
            this.SetTask(new GetProfilesRequest(this._appVars, _arg_1));
        }

        private function SetTask(_arg_1:AbstractVkoRequest):void
        {
            this._scheduler.Schedule(_arg_1, AbstractVkoRequest.FINISHED, this, this.SendCurrentRequest, _arg_1);
        }

        private function SendCurrentRequest(_arg_1:AbstractVkoRequest):void
        {
            this._currentRequest = _arg_1;
            this._currentRequest.addEventListener(AbstractVkoRequest.FINISHED, this.HandleReply);
            this._currentRequest.addEventListener(AbstractVkoRequest.CONNECTION_ERROR, this.HandleConnectionError);
            this._currentRequest.addEventListener(AbstractVkoRequest.MESSAGE_ERROR, this.HandleMessageError);
            this._currentRequest.SendRequest();
        }

        protected function HandleReply(_arg_1:Event):void
        {
            this._result = this._currentRequest.Result;
            dispatchEvent(new ResponseEvent(this._currentRequest.EventType, this._result));
        }

        private function OnTimeout(event:Event):void
        {
            try
            {
                this._currentRequest.Close();
            }
            catch(e:Error)
            {
                logger.error(e.message);
            };
        }

        private function HandleMessageError(_arg_1:Event):void
        {
            this._scheduler.Interrupt();
        }

        private function HandleConnectionError(_arg_1:Event):void
        {
            this._scheduler.Interrupt();
            logger.error(_arg_1.type);
        }

        public function get Result():Object
        {
            return (this._result);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.vkontakte

