


//hbm.Engine.Network.Events.StorageEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class StorageEvent extends Event 
    {

        public static const ON_STORAGE_OPENED:String = "ON_STORAGE_OPENED";
        public static const ON_STORAGE_UPDATED:String = "ON_STORAGE_UPDATED";
        public static const ON_STORAGE_CLOSED:String = "ON_STORAGE_CLOSED";

        public function StorageEvent(_arg_1:String)
        {
            super(_arg_1);
        }

    }
}//package hbm.Engine.Network.Events

