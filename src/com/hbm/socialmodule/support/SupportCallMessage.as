


//com.hbm.socialmodule.support.SupportCallMessage

package com.hbm.socialmodule.support
{
    public class SupportCallMessage 
    {

        private var _messageId:String;
        private var _date:String;
        private var _userId:String;
        private var _message:String;
        private var _file:Object;

        public function SupportCallMessage(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String, _arg_5:Object=null)
        {
            this._messageId = _arg_1;
            this._date = _arg_2;
            this._userId = _arg_3;
            this._message = _arg_4;
            this._file = _arg_5;
        }

        public function get messageId():String
        {
            return (this._messageId);
        }

        public function get date():String
        {
            return (this._date);
        }

        public function get user():String
        {
            return (this._userId);
        }

        public function get message():String
        {
            return (this._message);
        }

        public function get file():Object
        {
            return (this._file);
        }


    }
}//package com.hbm.socialmodule.support

