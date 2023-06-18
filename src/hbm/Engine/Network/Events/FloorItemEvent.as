


//hbm.Engine.Network.Events.FloorItemEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class FloorItemEvent extends Event 
    {

        public static const ON_FLOOR_ITEM_APPEARED:String = "ON_FLOOR_ITEM_APPEARED";
        public static const ON_GET_AREA_CHAR_ITEM:String = "ON_GET_AREA_CHAR_ITEM";
        public static const ON_FLOOR_ITEM_DISAPPEARED:String = "ON_FLOOR_ITEM_DISAPPEARED";
        public static const ON_FLOOR_ITEM_OVERWEIGHT:String = "ON_FLOOR_ITEM_OVERWEIGHT";

        public var ItemId:int;
        public var NameId:int;
        public var IdentifyFlag:int;
        public var PosX:int;
        public var PosY:int;
        public var SubX:int;
        public var SubY:int;
        public var Amount:int;
        public var OverWeight:Boolean;

        public function FloorItemEvent(_arg_1:String)
        {
            super(_arg_1);
        }

    }
}//package hbm.Engine.Network.Events

