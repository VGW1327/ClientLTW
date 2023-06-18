


//hbm.Game.Statistic.Netstat24

package hbm.Game.Statistic
{
    import flash.events.EventDispatcher;
    import flash.utils.Timer;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.net.URLRequest;
    import com.adobe.serialization.json.JSON_OLD;
    import flash.net.URLVariables;
    import flash.net.URLLoader;
    import flash.events.IOErrorEvent;

    public class Netstat24 extends EventDispatcher 
    {

        public static const IO_ERROR:String = "netstat_io_error";

        private var _viewer_id:String;
        private var _app_id:String;
        private var _token:String;
        private var _flush_interval:int;
        private var _flush_size:int;
        private var _flush_timer:Timer;
        private var _global_options:Object = new Object();
        private var _buffer:Array;

        public function Netstat24(app_id:String, token:String, viewer_id:String, flush_interval:Number=1000, flush_size:Number=10)
        {
            super();
            this._app_id = app_id;
            this._token = token;
            this._viewer_id = viewer_id;
            this._flush_interval = flush_interval;
            this._flush_size = flush_size;
            this._flush_timer = new Timer(this._flush_interval);
            this._global_options.onError = function (_arg_1:Event):void
            {
                dispatchEvent(new Event(IO_ERROR));
            };
            this._global_options.onComplete = function (_arg_1:Object):void
            {
            };
            this._flush_timer.addEventListener(TimerEvent.TIMER, this.onBufferTimerElapsed);
        }

        public function setViewerId(_arg_1:String):void
        {
            this._viewer_id = _arg_1;
        }

        public function trackEvent(_arg_1:String):void
        {
            var _local_2:Object = {
                "method":"track_event",
                "event":_arg_1
            };
            this.enqueueRequest(_local_2);
        }

        public function trackValue(_arg_1:String, _arg_2:String):void
        {
            var _local_3:Object = {
                "method":"track_value",
                "event":_arg_1,
                "value":_arg_2
            };
            this.enqueueRequest(_local_3);
        }

        public function trackNumber(_arg_1:String, _arg_2:Number):void
        {
            var _local_3:Object = {
                "method":"track_number",
                "event":_arg_1,
                "value":_arg_2
            };
            this.enqueueRequest(_local_3);
        }

        public function userData(_arg_1:String, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number):void
        {
            var _local_6:Object = {
                "method":"user_data",
                "g":_arg_1,
                "a":_arg_2,
                "nfr":_arg_3,
                "nafr":_arg_4,
                "lvl":_arg_5
            };
            this.enqueueRequest(_local_6);
        }

        public function visit(_arg_1:String=null):void
        {
            var _local_2:Object = {
                "method":"visit",
                "value":_arg_1
            };
            this.enqueueRequest(_local_2);
        }

        public function install(_arg_1:String=null):void
        {
            var _local_2:Object = {
                "method":"install",
                "value":_arg_1
            };
            this.enqueueRequest(_local_2);
        }

        public function revenue(_arg_1:Number):void
        {
            var _local_2:Object = {
                "method":"revenue",
                "value":_arg_1
            };
            this.enqueueRequest(_local_2);
        }

        public function inviteSent():void
        {
            var _local_1:Object = {"method":"invite_sent"};
            this.enqueueRequest(_local_1);
        }

        public function flushBuffers():void
        {
            this._flushBuffer();
        }

        private function onBufferTimerElapsed(_arg_1:TimerEvent):void
        {
            this._flushBuffer();
        }

        private function _flushBuffer():void
        {
            var _local_1:URLRequest = this._getRequestObject2();
            _local_1.data["batch"] = JSON_OLD.encode(this._buffer);
            this._fireAndForget(_local_1);
            this._buffer = [];
            this._flush_timer.stop();
        }

        private function enqueueRequest(_arg_1:Object):void
        {
            if (!this._buffer)
            {
                this._buffer = [];
            };
            this._buffer.push(_arg_1);
            if (this._buffer.length >= this._flush_size)
            {
                this._flushBuffer();
            }
            else
            {
                this.startTimer();
            };
        }

        private function startTimer():void
        {
            if (!this._flush_timer.running)
            {
                this._flush_timer.start();
            };
        }

        private function _getRequestObject2(_arg_1:String="POST"):URLRequest
        {
            var _local_2:URLVariables = new URLVariables();
            _local_2["vid"] = this._viewer_id;
            _local_2["app_id"] = this._app_id;
            _local_2["access_token"] = this._token;
            var _local_3:* = "http://178.205.142.3/api/v2";
            var _local_4:URLRequest = new URLRequest(_local_3);
            _local_4.method = _arg_1;
            _local_4.data = _local_2;
            return (_local_4);
        }

        private function _fireAndForget(_arg_1:URLRequest):void
        {
            this._sendRequest(_arg_1, {
                "onComplete":this.do_nothing,
                "onError":this.do_nothing
            });
        }

        private function _sendRequest(request:URLRequest, options:Object=null):void
        {
            var handler:Function;
            var loader:URLLoader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, function (_arg_1:Event):void
            {
                var _local_2:Object = decodeResponse(_arg_1);
                if (((options) && (options.onComplete)))
                {
                    options.onComplete(_local_2);
                }
                else
                {
                    _global_options.onComplete(_local_2);
                };
            });
            loader.addEventListener(IOErrorEvent.IO_ERROR, function (_arg_1:IOErrorEvent):void
            {
                if (((options) && (options.onError)))
                {
                    options.onError(_arg_1);
                }
                else
                {
                    dispatchEvent(new Event(IO_ERROR));
                };
            });
            try
            {
                loader.load(request);
            }
            catch(error:Error)
            {
                handler = (((options) && (options.onError)) ? options.onError : _global_options.onError);
                (handler(error));
            };
        }

        private function decodeResponse(evt:Event):Object
        {
            var res:Object;
            if (((!(evt)) || (!(evt.target))))
            {
                return (null);
            };
            try
            {
                res = JSON_OLD.decode(evt.target.data);
            }
            catch(e:Error)
            {
                res = {};
            };
            return (res);
        }

        private function do_nothing(_arg_1:Object=null):void
        {
        }


    }
}//package hbm.Game.Statistic

