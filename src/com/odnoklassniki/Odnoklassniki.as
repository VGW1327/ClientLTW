


//com.odnoklassniki.Odnoklassniki

package com.odnoklassniki
{
    import flash.events.EventDispatcher;
    import com.odnoklassniki.core.OdnoklassnikiSession;
    import flash.utils.Dictionary;
    import com.adobe.serialization.json.JSON2;
    import com.odnoklassniki.events.ApiServerEvent;
    import com.odnoklassniki.net.OdnoklassnikiRequest;

    public class Odnoklassniki extends EventDispatcher 
    {

        protected static var _instance:Odnoklassniki;
        protected static var _can_initiate:Boolean = false;
        public static var API_SERVER:String;

        public var session:OdnoklassnikiSession;
        protected var openRequests:Dictionary;

        public function Odnoklassniki()
        {
            if (_can_initiate == false)
            {
                throw (new Error("Odnoklassniki is an singleton! Call Odnoklassniki.getInstace() instead."));
            };
            this.openRequests = new Dictionary();
        }

        public static function initialize(_arg_1:Object):void
        {
            getInstance().session = new OdnoklassnikiSession(_arg_1.apiconnection);
            getInstance().session.sessionKey = _arg_1.session_key;
            getInstance().session.sessionSecretKey = _arg_1.session_secret_key;
            getInstance().session.uid = _arg_1.logged_user_id;
            getInstance().session.applicationKey = _arg_1.application_key;
            getInstance().session.secretKey = _arg_1.apiconnection;
            API_SERVER = _arg_1.api_server;
        }

        protected static function getInstance():Odnoklassniki
        {
            if (_instance == null)
            {
                _can_initiate = true;
                _instance = new (Odnoklassniki)();
                _can_initiate = false;
            };
            return (_instance);
        }

        public static function dispatchEvent(_arg_1:*):void
        {
            getInstance().dispatchEvent(_arg_1);
        }

        public static function addEventListener(_arg_1:String, _arg_2:Function, _arg_3:Boolean=false, _arg_4:int=0, _arg_5:Boolean=false):void
        {
            getInstance().addEventListener(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5);
        }

        public static function hasEventListener(_arg_1:String):Boolean
        {
            return (getInstance().hasEventListener(_arg_1));
        }

        public static function call(_arg_1:String, _arg_2:Array=null):void
        {
            getInstance().send(_arg_1, _arg_2);
        }

        public static function callRestApi(_arg_1:String, _arg_2:Function, _arg_3:Object=null, _arg_4:String="JSON", _arg_5:String="GET", _arg_6:String=null):void
        {
            getInstance().doCallRestApi(_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6);
        }

        public static function getSignature(_arg_1:Object, _arg_2:Boolean=false, _arg_3:String="JSON"):Object
        {
            return (getInstance().session.getSignature(_arg_1, _arg_2, _arg_3));
        }

        public static function get session():OdnoklassnikiSession
        {
            return (getInstance().session);
        }

        public static function showPermissions(... _args):void
        {
            getInstance().send("showPermissions", [JSON2.encode(_args)]);
        }

        public static function showInvite(_arg_1:String=null, _arg_2:String=null):void
        {
            getInstance().send("showInvite", [_arg_1, _arg_2]);
        }

        public static function showNotification(_arg_1:String, _arg_2:String=null):void
        {
            getInstance().send("showNotification", [_arg_1, _arg_2]);
        }

        public static function showPayment(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:int=-1, _arg_5:String=null, _arg_6:String=null, _arg_7:String=null, _arg_8:String="false"):void
        {
            getInstance().send("showPayment", [_arg_1, _arg_2, _arg_3, _arg_4, _arg_5, _arg_6, _arg_7, _arg_8]);
        }

        public static function showConfirmation(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            getInstance().send("showConfirmation", [_arg_1, _arg_2, _arg_3]);
        }

        public static function setWindowSize(_arg_1:int, _arg_2:int):void
        {
            getInstance().send("setWindowSize", [_arg_1.toString(), _arg_2.toString()]);
        }

        public static function getSendObject(_arg_1:Object):Object
        {
            var _local_3:String;
            var _local_2:Object = {};
            for (_local_3 in _arg_1)
            {
                if (_arg_1[_local_3])
                {
                    _local_2[_local_3] = _arg_1[_local_3];
                };
            };
            return (_local_2);
        }


        private function send(_arg_1:String, _arg_2:Array):void
        {
            if (getInstance().session.is_connected)
            {
                getInstance().session.connection.send.apply(getInstance().session.connection, [("_proxy_" + getInstance().session.connectionName), _arg_1].concat(_arg_2));
            }
            else
            {
                dispatchEvent(new ApiServerEvent(ApiServerEvent.NOT_YET_CONNECTED));
            };
        }

        private function doCallRestApi(_arg_1:String, _arg_2:Function, _arg_3:Object=null, _arg_4:String="JSON", _arg_5:String="GET", _arg_6:String=null):void
        {
            var _local_7:OdnoklassnikiRequest = new OdnoklassnikiRequest(API_SERVER, _arg_5);
            _local_7.call(_arg_1, _arg_3, this.handleRequestLoad, _arg_4, _arg_6);
            this.openRequests[_local_7] = _arg_2;
        }

        private function handleRequestLoad(_arg_1:OdnoklassnikiRequest):void
        {
            var _local_3:Object;
            var _local_2:Function = this.openRequests[_arg_1];
            if (_local_2 === null)
            {
                delete this.openRequests[_arg_1];
            };
            if (_arg_1.success)
            {
                _local_3 = _arg_1.data;
                (_local_2(_local_3));
            };
            delete this.openRequests[_arg_1];
        }


    }
}//package com.odnoklassniki

