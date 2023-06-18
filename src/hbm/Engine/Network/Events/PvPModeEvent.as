


//hbm.Engine.Network.Events.PvPModeEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class PvPModeEvent extends Event 
    {

        public static const ON_PVP_MODE_ACTION:String = "ON_PVP_MODE_ACTION";

        public var PvpMode:int;

        public function PvPModeEvent(_arg_1:int)
        {
            super(ON_PVP_MODE_ACTION);
            this.PvpMode = _arg_1;
        }

    }
}//package hbm.Engine.Network.Events

