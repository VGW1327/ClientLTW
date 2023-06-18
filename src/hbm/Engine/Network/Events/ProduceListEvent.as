


//hbm.Engine.Network.Events.ProduceListEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class ProduceListEvent extends Event 
    {

        public static const ON_PRODUCE_LIST:String = "ON_PRODUCE_LIST";

        private var _list:Array;

        public function ProduceListEvent(_arg_1:Array)
        {
            super(ON_PRODUCE_LIST);
            this._list = _arg_1;
        }

        public function get List():Array
        {
            return (this._list);
        }


    }
}//package hbm.Engine.Network.Events

