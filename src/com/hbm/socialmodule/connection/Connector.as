


//com.hbm.socialmodule.connection.Connector

package com.hbm.socialmodule.connection
{
    import flash.events.EventDispatcher;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRLoader;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import com.hbm.socialmodule.utils.TaskScheduler;
    import flash.net.URLLoader;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandler;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.HTTPStatusEvent;
    import com.hbm.socialmodule.rrhandlers.abstracts.RRHandlerEvent;
    import flash.net.URLRequestMethod;
    import flash.events.ErrorEvent;

    public class Connector extends EventDispatcher implements RRLoader 
    {

        private static const _logger:ILogger = getLogger(Connector);

        private var _answer:Object;
        private var _scheduler:TaskScheduler = new TaskScheduler();
        private var _loader:URLLoader;
        private var _url:String;
        private var _currentRRHandler:RRHandler;
        private var _currentRequest:URLRequest;
        private var _currentStatus:int = 0;

        public function Connector(_arg_1:String)
        {
            this._loader = new URLLoader();
            this._url = _arg_1;
            this.Init();
        }

        public function Init():void
        {
            this._loader.addEventListener(Event.COMPLETE, this.HandleReply);
            this._loader.addEventListener(IOErrorEvent.IO_ERROR, this.HandleError);
            this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.HandleError);
            this._loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, this.HandleHTTPStatus);
            this._scheduler.timeout = 30000;
            this._scheduler.addEventListener(TaskScheduler.TIMEOUT, this.OnTimeout);
        }

        public function SendRequest(_arg_1:Object, _arg_2:RRHandler):void
        {
            var _local_3:URLRequest = this.CreateJSONRequest(_arg_1, _arg_2.MethodName, this._url);
            this._scheduler.Schedule(_arg_2, RRHandlerEvent.DONE, this, this.RunRequest, _local_3, _arg_2);
        }

        private function CreateJSONRequest(_arg_1:Object, _arg_2:String, _arg_3:String):URLRequest
        {
            var _local_4:URLRequest = new URLRequest(_arg_3);
            _local_4.method = URLRequestMethod.POST;
            _local_4.contentType = "application/json";
            var _local_5:Object = new Object();
            _local_5[_arg_2] = _arg_1;
            _local_4.data = JSON.stringify(_local_5);
            return (_local_4);
        }

        private function RunRequest(_arg_1:URLRequest, _arg_2:RRHandler):void
        {
            this._currentRRHandler = _arg_2;
            this._currentRequest = _arg_1;
            _logger.debug(("to server: " + _arg_1.data));
            this._loader.load(_arg_1);
        }

        private function HandleHTTPStatus(_arg_1:HTTPStatusEvent):void
        {
            this._currentStatus = _arg_1.status;
        }

        protected function HandleReply(event:Event):void
        {
            _logger.debug(("fr server: " + event.target.data));
            try
            {
                this._answer = JSON.parse(event.target.data);
                this._currentRRHandler.ProcessResponse(this._answer);
            }
            catch(e:Error)
            {
                _logger.error(e.message);
                _currentRRHandler.NotifyError(e);
            };
        }

        private function HandleError(_arg_1:ErrorEvent):void
        {
            if (this._currentStatus == 503)
            {
                _logger.debug("503. Sending request.");
                this._loader.load(this._currentRequest);
            }
            else
            {
                _logger.error(_arg_1.text);
                this._scheduler.Interrupt();
                dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, _arg_1.text));
            };
        }

        private function OnTimeout(event:Event):void
        {
            try
            {
                this._loader.close();
            }
            catch(e:Error)
            {
                _logger.error(e.message);
            };
            dispatchEvent(event);
        }

        public function get response():*
        {
            return (this._answer);
        }


    }
}//package com.hbm.socialmodule.connection

