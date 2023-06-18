


//com.odnoklassniki.events.ApiServerEvent

package com.odnoklassniki.events
{
    import flash.events.Event;

    public class ApiServerEvent extends Event 
    {

        public static const CONNECTED:String = "odnoklassniki_connected";
        public static const CONNECTION_ERROR:String = "odnoklassniki_connection_error";
        public static const PROXY_NOT_RESPONDING:String = "odnoklassniki_proxy_not_reponding";
        public static const NOT_YET_CONNECTED:String = "odnoklassniki_not_yet_connected";

        public var data:Object;

        public function ApiServerEvent(_arg_1:String, _arg_2:Object=null)
        {
            this.data = _arg_2;
            super(_arg_1);
        }

    }
}//package com.odnoklassniki.events

