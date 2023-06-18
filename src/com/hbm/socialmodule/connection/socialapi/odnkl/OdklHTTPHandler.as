


//com.hbm.socialmodule.connection.socialapi.odnkl.OdklHTTPHandler

package com.hbm.socialmodule.connection.socialapi.odnkl
{
    import flash.net.URLLoader;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import com.hbm.socialmodule.utils.TaskScheduler;
    import com.hbm.socialmodule.connection.socialapi.SocialSystemRequest;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import com.hbm.socialmodule.connection.socialapi.odnkl.requests.GetFriendsRequest;
    import com.hbm.socialmodule.connection.socialapi.odnkl.requests.GetUserInfoRequest;
    import com.hbm.socialmodule.connection.socialapi.odnkl.requests.GetProfilesRequest;
    import flash.net.URLRequest;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import com.hbm.socialmodule.connection.ProtocolError;

    public class OdklHTTPHandler extends URLLoader 
    {

        private static const logger:ILogger = getLogger(OdklHTTPHandler);

        private var _scheduler:TaskScheduler = new TaskScheduler();
        private var _apiUrl:String;
        private var _appVars:Object;
        private var _code:String;
        private var _variable:Object;
        private var _currentRequest:SocialSystemRequest;

        public function OdklHTTPHandler(_arg_1:Object, _arg_2:String)
        {
            this._appVars = _arg_1;
            this._apiUrl = (_arg_1["api_server"] + "fb.do");
            this._code = _arg_2;
            this._scheduler.timeout = 30000;
            this._scheduler.delay = 260;
            this._scheduler.addEventListener(TaskScheduler.TIMEOUT, this.OnTimeout);
            addEventListener(Event.COMPLETE, this.handleReply);
            addEventListener(IOErrorEvent.IO_ERROR, this.errorHandling);
        }

        public function GetFriends():void
        {
            this.MakeTask(new GetFriendsRequest(this._appVars));
        }

        public function GetUserInfo():void
        {
            this.MakeTask(new GetUserInfoRequest(this._appVars));
        }

        public function GetProfiles(_arg_1:Array):void
        {
            this.MakeTask(new GetProfilesRequest(this._appVars, _arg_1));
        }

        private function MakeTask(_arg_1:SocialSystemRequest):void
        {
            this._scheduler.Schedule(this, Event.COMPLETE, this, this.SendRequest, _arg_1);
        }

        protected function SendRequest(_arg_1:SocialSystemRequest):void
        {
            var _local_2:URLRequest = new URLRequest(this._apiUrl);
            _local_2.data = _arg_1.GetRequestVariables(this._appVars["session_secret_key"]);
            this._currentRequest = _arg_1;
            logger.debug(("to odkl: " + _local_2.data));
            load(_local_2);
        }

        protected function handleReply(event:Event):void
        {
            var answer:Object;
            logger.debug(("fr odkl: " + data));
            try
            {
                answer = JSON.parse(data);
                this.ProcessAnswer(answer);
            }
            catch(e:Error)
            {
                logger.error(e.message);
            };
        }

        private function ProcessAnswer(answer:Object):void
        {
            try
            {
                this.CheckForError(answer);
                this._variable = this._currentRequest.ProcessResponse(answer);
                dispatchEvent(new ResponseEvent(this._currentRequest.EventType, this._variable));
            }
            catch(e:ProtocolError)
            {
                HandleProtocolError(e.message);
            };
        }

        private function CheckForError(_arg_1:Object):void
        {
            if (_arg_1.error_msg != null)
            {
                throw (new ProtocolError(_arg_1.error_msg));
            };
        }

        private function HandleProtocolError(_arg_1:String):void
        {
            logger.error(("Error: " + _arg_1));
            this._scheduler.Interrupt();
            dispatchEvent(new Event(TaskScheduler.INTERRUPTED));
        }

        private function OnTimeout(event:Event):void
        {
            try
            {
                this.close();
            }
            catch(e:Error)
            {
                logger.error(e.message);
            };
        }

        protected function errorHandling(_arg_1:Event):void
        {
            logger.error(_arg_1.type);
        }

        public function get response():Object
        {
            return (this._variable);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.odnkl

