


//vk.APIConnection

package vk
{
    import flash.events.EventDispatcher;
    import vk.api.DataProvider;
    import flash.net.LocalConnection;
    import flash.events.StatusEvent;
    import vk.events.CustomEvent;
    import flash.events.*;
    import vk.events.*;

    public class APIConnection extends EventDispatcher 
    {

        private var loaded:Boolean = false;
        private var connectionName:String;
        private var dp:DataProvider;
        private var sendingLC:LocalConnection;
        private var receivingLC:LocalConnection;
        private var pendingRequests:Array;

        public function APIConnection(... params)
        {
            var connectionName:String;
            var api_url:String;
            super();
            if (typeof(params[0]) == "string")
            {
                connectionName = params[0];
            }
            else
            {
                connectionName = params[0].lc_name;
                api_url = "http://api.vkontakte.ru/api.php";
                if (params[0].api_url)
                {
                    api_url = params[0].api_url;
                };
                dp = new DataProvider(api_url, params[0].api_id, params[0].sid, params[0].secret, params[0].viewer_id);
            };
            if (!connectionName)
            {
                return;
            };
            pendingRequests = new Array();
            this.connectionName = connectionName;
            sendingLC = new LocalConnection();
            sendingLC.allowDomain("*");
            receivingLC = new LocalConnection();
            receivingLC.allowDomain("*");
            receivingLC.client = {
                "initConnection":initConnection,
                "onBalanceChanged":onBalanceChanged,
                "onSettingsChanged":onSettingsChanged,
                "onLocationChanged":onLocationChanged,
                "onWindowResized":onWindowResized,
                "onApplicationAdded":onApplicationAdded,
                "onWindowBlur":onWindowBlur,
                "onWindowFocus":onWindowFocus,
                "onWallPostSave":onWallPostSave,
                "onWallPostCancel":onWallPostCancel,
                "onProfilePhotoSave":onProfilePhotoSave,
                "onProfilePhotoCancel":onProfilePhotoCancel,
                "onMerchantPaymentSuccess":onMerchantPaymentSuccess,
                "onMerchantPaymentCancel":onMerchantPaymentCancel,
                "onMerchantPaymentFail":onMerchantPaymentFail,
                "customEvent":customEvent
            };
            try
            {
                receivingLC.connect(("_out_" + connectionName));
            }
            catch(error:ArgumentError)
            {
                debug("Can't connect from App. The connection name is already being used by another SWF");
            };
            sendingLC.addEventListener(StatusEvent.STATUS, onInitStatus);
            sendingLC.send(("_in_" + connectionName), "initConnection");
        }

        private function onWindowResized(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("onWindowResized");
            customEvent.apply(this, _local_2);
        }

        private function onMerchantPaymentSuccess(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("onMerchantPaymentSuccess");
            customEvent.apply(this, _local_2);
        }

        private function initConnection():void
        {
            if (loaded)
            {
                return;
            };
            loaded = true;
            debug("Connection initialized.");
            dispatchEvent(new CustomEvent(CustomEvent.CONN_INIT));
            sendPendingRequests();
        }

        private function onApplicationAdded(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("onApplicationAdded");
            customEvent.apply(this, _local_2);
        }

        public function debug(_arg_1:*):void
        {
            if (((!(_arg_1)) || (!(_arg_1.toString))))
            {
                return;
            };
            sendData("debug", _arg_1.toString());
        }

        private function onMerchantPaymentFail(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("onMerchantPaymentFail");
            customEvent.apply(this, _local_2);
        }

        private function onMerchantPaymentCancel(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("onMerchantPaymentCancel");
            customEvent.apply(this, _local_2);
        }

        public function api(_arg_1:String, _arg_2:Object, _arg_3:Function=null, _arg_4:Function=null):void
        {
            var _local_5:Object = new Object();
            _local_5["params"] = _arg_2;
            _local_5["onComplete"] = _arg_3;
            _local_5["onError"] = _arg_4;
            dp.request(_arg_1, _local_5);
        }

        public function callMethod(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("callMethod");
            sendData.apply(this, _local_2);
        }

        private function onLocationChanged(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("onLocationChanged");
            customEvent.apply(this, _local_2);
        }

        private function sendData(... _args):void
        {
            var _local_2:Array = (_args as Array);
            if (loaded)
            {
                _local_2.unshift(("_in_" + connectionName));
                sendingLC.send.apply(null, _local_2);
            }
            else
            {
                pendingRequests.push(_local_2);
            };
        }

        private function onWallPostCancel(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("onWallPostCancel");
            customEvent.apply(this, _local_2);
        }

        private function onProfilePhotoSave(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("onProfilePhotoSave");
            customEvent.apply(this, _local_2);
        }

        private function onWallPostSave(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("onWallPostSave");
            customEvent.apply(this, _local_2);
        }

        private function onInitStatus(_arg_1:StatusEvent):void
        {
            debug(("StatusEvent: " + _arg_1.level));
            _arg_1.target.removeEventListener(_arg_1.type, onInitStatus);
            if (_arg_1.level == "status")
            {
                receivingLC.client.initConnection();
            };
        }

        private function onWindowFocus(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("onWindowFocus");
            customEvent.apply(this, _local_2);
        }

        private function sendPendingRequests():void
        {
            while (pendingRequests.length)
            {
                sendData.apply(this, pendingRequests.shift());
            };
        }

        public function customEvent(... _args):void
        {
            var _local_2:Array = (_args as Array);
            var _local_3:String = _local_2.shift();
            debug(_local_3);
            var _local_4:CustomEvent = new CustomEvent(_local_3);
            _local_4.params = _local_2;
            dispatchEvent(_local_4);
        }

        private function onProfilePhotoCancel(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("onProfilePhotoCancel");
            customEvent.apply(this, _local_2);
        }

        private function onSettingsChanged(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("onSettingsChanged");
            customEvent.apply(this, _local_2);
        }

        private function onBalanceChanged(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("onBalanceChanged");
            customEvent.apply(this, _local_2);
        }

        private function onWindowBlur(... _args):void
        {
            var _local_2:Array = (_args as Array);
            _local_2.unshift("onWindowBlur");
            customEvent.apply(this, _local_2);
        }


    }
}//package vk

