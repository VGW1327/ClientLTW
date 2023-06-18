


//com.hbm.socialmodule.connection.socialapi.fotostrana.FsHTTPHandler

package com.hbm.socialmodule.connection.socialapi.fotostrana
{
    import flash.events.EventDispatcher;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import com.hbm.socialmodule.utils.TaskScheduler;
    import com.hbm.socialmodule.connection.socialapi.fotostrana.requests.AbstractFsRequest;
    import com.hbm.socialmodule.connection.socialapi.fotostrana.requests.GetFriendsRequest;
    import com.hbm.socialmodule.connection.socialapi.fotostrana.requests.GetUserInfoRequest;
    import com.hbm.socialmodule.connection.socialapi.fotostrana.requests.GetProfilesRequest;
    import com.hbm.socialmodule.connection.socialapi.fotostrana.requests.WallPostRequest;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;

    public class FsHTTPHandler extends EventDispatcher 
    {

        private static const logger:ILogger = getLogger(FsHTTPHandler);

        private var _scheduler:TaskScheduler = new TaskScheduler();
        private var _appVars:Object;
        private var _code:String;
        private var _result:Object;
        private var _currentRequest:AbstractFsRequest;

        public function FsHTTPHandler(_arg_1:Object, _arg_2:String)
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

        public function WallPost(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            this.SetTask(new WallPostRequest(this._appVars, _arg_1, _arg_2, _arg_3));
        }

        private function SetTask(_arg_1:AbstractFsRequest):void
        {
            this._scheduler.Schedule(_arg_1, AbstractFsRequest.FINISHED, this, this.SendCurrentRequest, _arg_1);
        }

        private function SendCurrentRequest(_arg_1:AbstractFsRequest):void
        {
            this._currentRequest = _arg_1;
            this._currentRequest.addEventListener(AbstractFsRequest.FINISHED, this.HandleReply);
            this._currentRequest.addEventListener(AbstractFsRequest.CONNECTION_ERROR, this.HandleConnectionError);
            this._currentRequest.addEventListener(AbstractFsRequest.MESSAGE_ERROR, this.HandleMessageError);
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
}//package com.hbm.socialmodule.connection.socialapi.fotostrana

