


//hbm.Engine.Network.Events.StoreEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class StoreEvent extends Event 
    {

        public static const ON_NPC_STORE_BEGIN:String = "ON_NPC_STORE_BEGIN";
        public static const ON_NPC_BUY_LIST:String = "ON_NPC_BUY_LIST";
        public static const ON_VENDER_BUY_LIST:String = "ON_VENDER_BUY_LIST";
        public static const ON_VENDER_CLOSED:String = "ON_VENDER_CLOSED";
        public static const ON_VENDER_OPENED:String = "ON_VENDER_OPENED";
        public static const ON_VENDER_STARTED:String = "ON_VENDER_STARTED";
        public static const ON_CASH_BUY_LIST:String = "ON_CASH_BUY_LIST";
        public static const ON_CASH_BUY_RESULT:String = "ON_CASH_BUY_RESULT";
        public static const ON_PREMIUM_BUY_LIST:String = "ON_PREMIUM_BUY_LIST";
        public static const ON_PREMIUM_BUY_RESULT:String = "ON_PREMIUM_BUY_RESULT";

        private var _items:Array;
        private var _result:int;
        private var _shopType:int;
        private var _newStore:Boolean;
        private var _characterID:int;

        public function StoreEvent(_arg_1:String, _arg_2:int=-1, _arg_3:Array=null, _arg_4:int=0, _arg_5:Boolean=true)
        {
            super(_arg_1);
            this._items = _arg_3;
            this._result = _arg_4;
            this._shopType = _arg_2;
            this._newStore = _arg_5;
        }

        public function get Items():Array
        {
            return (this._items);
        }

        public function get ShopType():int
        {
            return (this._shopType);
        }

        public function get Result():int
        {
            return (this._result);
        }

        public function get IsNewStore():Boolean
        {
            return (this._newStore);
        }

        public function set CharacterID(_arg_1:int):void
        {
            this._characterID = _arg_1;
        }

        public function get CharacterID():int
        {
            return (this._characterID);
        }


    }
}//package hbm.Engine.Network.Events

