


//com.odnoklassniki.events.ApiCallbackEvent

package com.odnoklassniki.events
{
    import flash.events.Event;

    public class ApiCallbackEvent extends Event 
    {

        public static const CALL_BACK:String = "call_back_event";

        protected var _method:String;
        protected var _result:String;
        protected var _data:String;

        public function ApiCallbackEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false, _arg_4:String="null", _arg_5:String="", _arg_6:String="")
        {
            super(_arg_1, _arg_2, _arg_3);
            this._method = _arg_4;
            this._result = _arg_5;
            this._data = _arg_6;
        }

        public function get method():String
        {
            return (this._method);
        }

        public function get result():String
        {
            return (this._result);
        }

        public function get data():String
        {
            return (this._data);
        }

        override public function clone():Event
        {
            return (new ApiCallbackEvent(this.type, this.bubbles, this.cancelable, this.method, this.result, this.data));
        }


    }
}//package com.odnoklassniki.events

