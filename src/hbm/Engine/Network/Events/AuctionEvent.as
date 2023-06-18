


//hbm.Engine.Network.Events.AuctionEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class AuctionEvent extends Event 
    {

        public static const ON_AUCTION_ITEM_SET:String = "ON_AUCTION_ITEM_SET";
        public static const ON_AUCTION_LIST_RECEIVED:String = "ON_AUCTION_LIST_RECEIVED";
        public static const ON_AUCTION_MESSAGE:String = "ON_AUCTION_MESSAGE";

        private var _itemId:uint;
        private var _flag:uint;
        private var _auctionList:Array;
        private var _pages:int;

        public function AuctionEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
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

        public function set AuctionList(_arg_1:Array):void
        {
            this._auctionList = _arg_1;
        }

        public function get AuctionList():Array
        {
            return (this._auctionList);
        }

        public function get Pages():uint
        {
            return (this._pages);
        }

        public function set Pages(_arg_1:uint):void
        {
            this._pages = _arg_1;
        }


    }
}//package hbm.Engine.Network.Events

