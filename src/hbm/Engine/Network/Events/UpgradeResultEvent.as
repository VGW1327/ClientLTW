


//hbm.Engine.Network.Events.UpgradeResultEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class UpgradeResultEvent extends Event 
    {

        public static const ON_UPGRADE_RESULT:String = "ON_UPGRADE_RESULT";

        public var Type:int;
        public var ItemId:int;
        public var Result:int;

        public function UpgradeResultEvent(_arg_1:int, _arg_2:int, _arg_3:int)
        {
            super(ON_UPGRADE_RESULT);
            this.Type = _arg_1;
            this.ItemId = _arg_2;
            this.Result = _arg_3;
        }

    }
}//package hbm.Engine.Network.Events

