


//com.hbm.socialmodule.connection.socialapi.vkontakte.requests.AbstractVkoRequest

package com.hbm.socialmodule.connection.socialapi.vkontakte.requests
{
    import flash.events.EventDispatcher;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import flash.net.URLLoader;
    import flash.net.URLVariables;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.StatusEvent;
    import flash.net.URLRequest;

    public class AbstractVkoRequest extends EventDispatcher 
    {

        private static const logger:ILogger = getLogger(AbstractVkoRequest);
        public static const FINISHED:String = "vko_request_done";
        public static const MESSAGE_ERROR:String = "vko_request_error";
        public static const CONNECTION_ERROR:String = "vko_connection_error";

        private var _requestLoader:URLLoader;
        private var _requestVars:URLVariables;
        private var _apiUrl:String;
        private var _environmentVars:Object;
        private var _result:Object;

        public function AbstractVkoRequest(_arg_1:Object)
        {
            this._requestLoader = new URLLoader();
            this._requestVars = new URLVariables();
            this._environmentVars = _arg_1;
            this._apiUrl = this.EnvironmentVarsMap["api_url"];
            this._requestLoader.addEventListener(Event.COMPLETE, this.HandleReply);
            this._requestLoader.addEventListener(IOErrorEvent.IO_ERROR, this.HandleConnectionError);
            this._requestLoader.addEventListener(StatusEvent.STATUS, this.HandleStatus);
        }

        public function SendRequest():void
        {
            this._result = null;
            this.PrepareRequestData();
            var _local_1:URLRequest = new URLRequest(this._apiUrl);
            _local_1.data = this.RequestVariables;
            logger.debug(("to vko: " + _local_1.data));
            this._requestLoader.load(_local_1);
        }

        protected function PrepareRequestData():void
        {
        }

        private function HandleReply(event:Event):void
        {
            var answer:Object;
            this._requestVars = new URLVariables();
            var answerData:String = this._requestLoader.data;
            logger.debug(("fr vko: " + answerData));
            try
            {
                answer = JSON.parse(answerData);
                this.CheckAndFormatAnswerData(answer);
            }
            catch(e:Error)
            {
                logger.error(e.message);
            };
        }

        private function CheckAndFormatAnswerData(_arg_1:Object):void
        {
            var _local_2:Object = _arg_1.response;
            if (_local_2 != null)
            {
                this.FormatAnswer(_local_2);
            }
            else
            {
                if (_arg_1.error != null)
                {
                    logger.error(((("Error " + _arg_1.error.error_code) + ": ") + _arg_1.error.error_msg));
                    dispatchEvent(new Event(MESSAGE_ERROR));
                };
            };
        }

        protected function FormatAnswer(_arg_1:Object):void
        {
        }

        protected function FinishRequest(_arg_1:Object):void
        {
            this.SetResult(_arg_1);
            dispatchEvent(new Event(AbstractVkoRequest.FINISHED));
        }

        protected function HandleConnectionError(_arg_1:Event):void
        {
            logger.error(_arg_1.type);
            dispatchEvent(new Event(CONNECTION_ERROR));
        }

        protected function HandleStatus(_arg_1:StatusEvent):void
        {
            logger.error(("http status: " + _arg_1.code));
        }

        protected function get EnvironmentVarsMap():Object
        {
            return (this._environmentVars);
        }

        protected function get RequestVariables():URLVariables
        {
            return (this._requestVars);
        }

        protected function SetResult(_arg_1:Object):void
        {
            this._result = _arg_1;
        }

        public function get Result():Object
        {
            return (this._result);
        }

        public function get EventType():String
        {
            return ("");
        }

        public function Close():void
        {
            this._requestLoader.close();
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.vkontakte.requests

