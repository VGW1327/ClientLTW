


//hbm.Engine.Network.Events.ItemAddedEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;
    import hbm.Engine.Actors.ItemData;

    public class ItemAddedEvent extends Event 
    {

        public static const ON_ITEM_ADDED:String = "ON_ITEM_ADDED";

        public var Item:ItemData;

        public function ItemAddedEvent(_arg_1:ItemData)
        {
            super(ON_ITEM_ADDED);
            this.Item = _arg_1;
        }

    }
}//package hbm.Engine.Network.Events

