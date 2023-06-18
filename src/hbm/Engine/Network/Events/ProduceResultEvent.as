


//hbm.Engine.Network.Events.ProduceResultEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class ProduceResultEvent extends Event 
    {

        public static const ON_PRODUCE_RESULT:String = "ON_PRODUCE_RESULT";

        public var ItemId:int;
        public var Result:int;

        public function ProduceResultEvent(_arg_1:int, _arg_2:int)
        {
            super(ON_PRODUCE_RESULT);
            this.ItemId = _arg_1;
            this.Result = _arg_2;
        }

    }
}//package hbm.Engine.Network.Events

