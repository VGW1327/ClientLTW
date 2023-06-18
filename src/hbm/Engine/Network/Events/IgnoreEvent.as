


//hbm.Engine.Network.Events.IgnoreEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class IgnoreEvent extends Event 
    {

        public static const ON_IGNORELIST_UPDATED:String = "ON_IGNORELIST_UPDATED";
        public static const ON_IGNORE_RESULT:String = "ON_IGNORE_RESULT";
        public static const ON_IGNOREALL_RESULT:String = "ON_IGNOREALL_RESULT";
        public static var CurrentCharacterId:int;
        public static var CurrentAccountId:int;

        public var Result:int;
        public var Type:int;

        public function IgnoreEvent(_arg_1:String)
        {
            super(_arg_1);
        }

    }
}//package hbm.Engine.Network.Events

