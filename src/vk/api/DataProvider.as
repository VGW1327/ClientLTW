


//vk.api.DataProvider

package vk.api
{
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.net.URLVariables;
    import flash.net.URLRequestMethod;
    import flash.net.URLLoaderDataFormat;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.events.Event;
    import vk.api.serialization.json.JSON;
    import flash.events.*;
    import flash.net.*;
    import vk.api.serialization.json.*;
    import flash.errors.*;

    public class DataProvider 
    {

        private var _global_options:Object;
        private var _viewer_id:Number;
        private var _api_url:String = "http://api.vkontakte.ru/api.php";
        private var _api_sid:String;
        private var _api_secret:String;
        private var _request_params:Array;
        private var _api_id:Number;

        public function DataProvider(_arg_1:String, _arg_2:Number, _arg_3:String, _arg_4:String, _arg_5:Number)
        {
            _api_secret = _arg_4;
            _api_sid = _arg_3;
            _api_url = _arg_1;
            _api_id = _arg_2;
            _viewer_id = _arg_5;
        }

        private function _generate_signature(_arg_1:Object):String
        {
            var _local_4:String;
            var _local_2:* = "";
            var _local_3:Array = new Array();
            for (_local_4 in _arg_1)
            {
                _local_3.push(((_local_4 + "=") + _arg_1[_local_4]));
            };
            _local_3.sort();
            for (_local_4 in _local_3)
            {
                _local_2 = (_local_2 + _local_3[_local_4]);
            };
            if (_viewer_id > 0)
            {
                _local_2 = (_viewer_id.toString() + _local_2);
            };
            _local_2 = (_local_2 + _api_secret);
            return (MD5.encrypt(_local_2));
        }

        public function request(_arg_1:String, _arg_2:Object=null):void
        {
            var _local_3:Function;
            var _local_4:Function;
            if (_arg_2 == null)
            {
                _arg_2 = new Object();
            };
            _arg_2.onComplete = ((_arg_2.onComplete) ? _arg_2.onComplete : ((_global_options.onComplete) ? _global_options.onComplete : null));
            _arg_2.onError = ((_arg_2.onError) ? _arg_2.onError : ((_global_options.onError) ? _global_options.onError : null));
            _sendRequest(_arg_1, _arg_2);
        }

        private function _sendRequest(method:String, options:Object):void
        {
            var j:String;
            var request:URLRequest;
            var loader:URLLoader;
            var i:String;
            var self:Object = this;
            var request_params:Object = {"method":method};
            request_params.api_id = _api_id;
            request_params.format = "JSON";
            request_params.v = "3.0";
            if (options.params)
            {
                for (i in options.params)
                {
                    request_params[i] = options.params[i];
                };
            };
            var variables:URLVariables = new URLVariables();
            for (j in request_params)
            {
                variables[j] = request_params[j];
            };
            variables["sig"] = _generate_signature(request_params);
            variables["sid"] = _api_sid;
            request = new URLRequest();
            request.url = _api_url;
            request.method = URLRequestMethod.POST;
            request.data = variables;
            loader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.TEXT;
            if (options.onError)
            {
                loader.addEventListener(IOErrorEvent.IO_ERROR, function ():void
                {
                    options.onError("Connection error occured");
                });
                loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, function ():void
                {
                    options.onError("Security error occured");
                });
            };
            loader.addEventListener(Event.COMPLETE, function (_arg_1:Event):void
            {
                var _local_2:URLLoader = URLLoader(_arg_1.target);
                trace(_local_2.data);
                var _local_3:Object = vk.api.serialization.json.JSON.decode(_local_2.data);
                if (_local_3.error)
                {
                    options.onError(_local_3.error);
                }
                else
                {
                    if (((options.onComplete) && (_local_3.response)))
                    {
                        options.onComplete(_local_3.response);
                    };
                };
            });
            try
            {
                loader.load(request);
            }
            catch(error:Error)
            {
                options.onError(error);
            };
        }

        public function setup(_arg_1:Object):void
        {
            _global_options = _arg_1;
        }


    }
}//package vk.api

