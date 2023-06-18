


//hbm.Engine.Network.Events.CraftCardResultEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class CraftCardResultEvent extends Event 
    {

        public static const ON_CRAFTCARD_RESULT:String = "ON_CRAFTCARD_RESULT";

        public var Result:int;

        public function CraftCardResultEvent(_arg_1:int)
        {
            super(ON_CRAFTCARD_RESULT);
            this.Result = _arg_1;
        }

    }
}//package hbm.Engine.Network.Events

