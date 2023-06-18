


//hbm.Engine.Network.Events.RefineResultEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;
    import hbm.Engine.Actors.ItemData;

    public class RefineResultEvent extends Event 
    {

        public static const ON_REFINE_ITEM_UPDATE:String = "ON_REFINE_ITEM_UPDATE";
        public static const ON_REFINE_RESPONSE:String = "ON_REFINE_RESPONSE";

        public var ItemId:int;
        public var Result:int;
        public var Item:ItemData;

        public function RefineResultEvent(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:ItemData=null)
        {
            super(_arg_1);
            this.ItemId = _arg_2;
            this.Result = _arg_3;
            this.Item = _arg_4;
        }

    }
}//package hbm.Engine.Network.Events

