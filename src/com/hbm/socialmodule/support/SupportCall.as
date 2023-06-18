


//com.hbm.socialmodule.support.SupportCall

package com.hbm.socialmodule.support
{
    public class SupportCall 
    {

        private var _id:String;
        private var _messages:Array;
        private var _date:String;
        private var _theme:String;
        private var _isProcessed:Boolean;
        private var _isReaded:Boolean;
        private var _file:Object;
        private var _text:String;
        private var _messageCount:String;

        public function SupportCall(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:Boolean, _arg_7:Boolean, _arg_8:Object=null)
        {
            this._id = _arg_1;
            this._date = _arg_2;
            this._theme = _arg_3;
            this._isProcessed = _arg_6;
            this._isReaded = _arg_7;
            this._file = _arg_8;
            this._text = _arg_4;
            this._messageCount = _arg_5;
        }

        public function set messages(_arg_1:Array):void
        {
            this._messages = _arg_1;
        }

        public function get id():String
        {
            return (this._id);
        }

        public function get messages():Array
        {
            return (this._messages);
        }

        public function get date():String
        {
            return (this._date);
        }

        public function get theme():String
        {
            return (this._theme);
        }

        public function get isProcessed():Boolean
        {
            return (this._isProcessed);
        }

        public function get isReaded():Boolean
        {
            return (this._isReaded);
        }

        public function get file():Object
        {
            return (this._file);
        }

        public function get messageCount():String
        {
            return (this._messageCount);
        }

        public function set messageCount(_arg_1:String):void
        {
            this._messageCount = _arg_1;
        }

        public function get text():String
        {
            return (this._text);
        }


    }
}//package com.hbm.socialmodule.support

