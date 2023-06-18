


//hbm.Engine.Network.Events.MailEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;
    import hbm.Engine.Actors.MailHeaderData;
    import hbm.Engine.Actors.ItemData;

    public class MailEvent extends Event 
    {

        public static const ON_MAIL_LIST:String = "ON_MAIL_LIST";
        public static const ON_MAIL_READ:String = "ON_MAIL_READ";
        public static const ON_MAIL_GET_ATTACH_RESULT:String = "ON_MAIL_GET_ATTACH_RESULT";
        public static const ON_MAIL_NEW:String = "ON_MAIL_NEW";
        public static const ON_MAIL_DELETE_RESULT:String = "ON_MAIL_DELETE_RESULT";
        public static const ON_MAIL_RETURN_RESULT:String = "ON_MAIL_RETURN_RESULT";
        public static const ON_MAIL_SEND_RESULT:String = "ON_MAIL_SEND_RESULT";

        private var _itemId:uint;
        private var _flag:uint;
        private var _mailList:Array;
        private var _pages:int;
        private var _header:MailHeaderData;
        private var _item:ItemData;
        private var _message:String;

        public function MailEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        public function get ItemID():uint
        {
            return (this._itemId);
        }

        public function set ItemID(_arg_1:uint):void
        {
            this._itemId = _arg_1;
        }

        public function get Flag():uint
        {
            return (this._flag);
        }

        public function set Flag(_arg_1:uint):void
        {
            this._flag = _arg_1;
        }

        public function set MailList(_arg_1:Array):void
        {
            this._mailList = _arg_1;
        }

        public function get MailList():Array
        {
            return (this._mailList);
        }

        public function get Pages():uint
        {
            return (this._pages);
        }

        public function set Pages(_arg_1:uint):void
        {
            this._pages = _arg_1;
        }

        public function get Header():MailHeaderData
        {
            return (this._header);
        }

        public function set Header(_arg_1:MailHeaderData):void
        {
            this._header = _arg_1;
        }

        public function get Item():ItemData
        {
            return (this._item);
        }

        public function set Item(_arg_1:ItemData):void
        {
            this._item = _arg_1;
        }

        public function get Message():String
        {
            return (this._message);
        }

        public function set Message(_arg_1:String):void
        {
            this._message = _arg_1;
        }


    }
}//package hbm.Engine.Network.Events

