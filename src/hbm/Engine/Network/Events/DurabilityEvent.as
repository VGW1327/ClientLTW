


//hbm.Engine.Network.Events.DurabilityEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;
    import hbm.Engine.Actors.ItemData;

    public class DurabilityEvent extends Event 
    {

        public static const ON_REPAIR_LIST:String = "ON_REPAIR_LIST";
        public static const ON_REPAIR_TOTAL_PRICE:String = "ON_REPAIR_TOTAL_PRICE";
        public static const ON_REPAIR_ITEM:String = "ON_REPAIR_ITEM";
        public static const ON_LOW_DURABILITY:String = "ON_LOW_DURABILITY";

        public var RepairList:Array;
        public var Currency:int;
        public var TotalPrice:int;
        public var Item:ItemData;
        public var Durability:int;
        public var MaxDurability:int;

        public function DurabilityEvent(_arg_1:String)
        {
            super(_arg_1);
        }

    }
}//package hbm.Engine.Network.Events

