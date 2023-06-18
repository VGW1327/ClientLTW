


//com.odnoklassniki.core.OdnoklassnikiSession

package com.odnoklassniki.core
{
    import flash.net.LocalConnection;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.StatusEvent;
    import com.odnoklassniki.Odnoklassniki;
    import com.odnoklassniki.events.ApiServerEvent;
    import com.odnoklassniki.events.ApiCallbackEvent;
    import com.adobe.crypto.MD5;

    public class OdnoklassnikiSession 
    {

        public var uid:String;
        public var user:Object;
        public var applicationKey:String;
        public var secretKey:String;
        public var sessionKey:String;
        public var sessionSecretKey:String;
        private var _is_connected:Boolean = false;
        private var _self_connected:Boolean = false;
        private var _connection_name:String;
        private var _connection:LocalConnection = new LocalConnection();
        private var _reconnect_timer:Timer = new Timer(200);

        public function OdnoklassnikiSession(_arg_1:String)
        {
            this._reconnect_timer.addEventListener(TimerEvent.TIMER, this.tryToConnect);
            this._connection.allowDomain("*");
            this._connection.addEventListener(StatusEvent.STATUS, this.handleOutStatus);
            this._connection.client = this;
            this._connection_name = _arg_1;
            this.tryToConnect();
        }

        public function get is_connected():Boolean
        {
            return (this._is_connected);
        }

        public function get connectionName():String
        {
            return (this._connection_name);
        }

        public function get connection():LocalConnection
        {
            return (this._connection);
        }

        private function tryToConnect(event:TimerEvent=null):void
        {
            var cc2:LocalConnection;
            var cc:LocalConnection;
            try
            {
                if (!this._self_connected)
                {
                    this._connection.connect(("_api_" + this._connection_name));
                    this._self_connected = true;
                };
            }
            catch(e:Error)
            {
                cc2 = new LocalConnection();
                cc2.addEventListener(StatusEvent.STATUS, this.handleOutStatusConcurrent, false, 0, true);
                cc2.send(("_api_" + this._connection_name), "closeConnection");
                this._reconnect_timer.start();
                return;
            };
            if (!this._is_connected)
            {
                if (event)
                {
                    this._reconnect_timer.reset();
                    cc = new LocalConnection();
                    cc.addEventListener(StatusEvent.STATUS, this.handleOutStatusReconnect, false, 0, true);
                    cc.send(("_proxy_" + this._connection_name), "makeReconnect");
                }
                else
                {
                    this._reconnect_timer.start();
                };
            };
        }

        private function handleOutStatus(_arg_1:StatusEvent):void
        {
            if (_arg_1.level != StatusEvent.STATUS)
            {
                Odnoklassniki.dispatchEvent(new ApiServerEvent(ApiServerEvent.CONNECTION_ERROR));
            };
        }

        private function handleOutStatusReconnect(_arg_1:StatusEvent):void
        {
            if (_arg_1.level != StatusEvent.STATUS)
            {
                Odnoklassniki.dispatchEvent(new ApiServerEvent(ApiServerEvent.PROXY_NOT_RESPONDING));
            };
        }

        private function handleOutStatusConcurrent(_arg_1:StatusEvent):void
        {
            if (_arg_1.level != StatusEvent.STATUS)
            {
                Odnoklassniki.dispatchEvent(new ApiServerEvent(ApiServerEvent.CONNECTION_ERROR));
            };
        }

        public function establishConnection():void
        {
            this._reconnect_timer.reset();
            if (!this._is_connected)
            {
                this._is_connected = true;
                Odnoklassniki.dispatchEvent(new ApiServerEvent(ApiServerEvent.CONNECTED));
            };
        }

        public function apiCallBack(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            Odnoklassniki.dispatchEvent(new ApiCallbackEvent(ApiCallbackEvent.CALL_BACK, false, false, _arg_1, _arg_2, _arg_3));
        }

        public function closeConnection():void
        {
            this._connection.close();
        }

        public function getSignature(_arg_1:Object, _arg_2:Boolean=false, _arg_3:String="JSON"):Object
        {
            var _local_6:String;
            var _local_7:int;
            var _local_8:int;
            _arg_1["format"] = _arg_3;
            _arg_1["application_key"] = this.applicationKey;
            if (((_arg_1["uid"] == undefined) || (_arg_2)))
            {
                _arg_1["session_key"] = this.sessionKey;
            };
            var _local_4:* = "";
            var _local_5:Array = [];
            for (_local_6 in _arg_1)
            {
                _local_5.push(_local_6);
            };
            _local_5.sort();
            _local_7 = 0;
            _local_8 = _local_5.length;
            while (_local_7 < _local_8)
            {
                _local_4 = (_local_4 + ((_local_5[_local_7] + "=") + _arg_1[_local_5[_local_7]]));
                _local_7++;
            };
            _local_4 = (_local_4 + (((!(_arg_1["uid"] == undefined)) && (!(_arg_2))) ? this.secretKey : this.sessionSecretKey));
            _arg_1["sig"] = MD5.hash(_local_4).toLowerCase();
            return (_arg_1);
        }


    }
}//package com.odnoklassniki.core

