


//hbm.Engine.Network.Events.TradeEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;
    import hbm.Engine.Actors.ItemData;

    public class TradeEvent extends Event 
    {

        public static const ON_TRADE_REQUEST:String = "ON_TRADE_REQUEST";
        public static const ON_TRADE_START_REPLY:String = "ON_TRADE_START_REPLY";
        public static const ON_TRADE_ITEM_OK:String = "ON_TRADE_ITEM_OK";
        public static const ON_TRADE_ADD_ITEM:String = "ON_TRADE_ADD_ITEM";
        public static const ON_TRADE_ITEM_CANCEL:String = "ON_TRADE_ITEM_CANCEL";
        public static const ON_TRADE_DELETE_ITEM:String = "ON_TRADE_DELETE_ITEM";
        public static const ON_TRADE_ADD_ZENY:String = "ON_TRADE_ADD_ZENY";
        public static const ON_TRADE_COMPLITED:String = "ON_TRADE_COMPLITED";
        public static const ON_TRADE_DEAL_LOCKED:String = "ON_TRADE_DEAL_LOCKED";

        public var Result:int;
        public var CharacterId:int;
        public var CharacterName:String;
        public var Id:int;
        public var Item:ItemData;

        public function TradeEvent(_arg_1:String)
        {
            super(_arg_1);
        }

    }
}//package hbm.Engine.Network.Events

