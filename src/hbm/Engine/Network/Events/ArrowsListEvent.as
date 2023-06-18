


//hbm.Engine.Network.Events.ArrowsListEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class ArrowsListEvent extends Event 
    {

        public static const ON_ARROWS_LIST:String = "ON_ARROWS_LIST";

        private var _list:Array;

        public function ArrowsListEvent(_arg_1:Array)
        {
            super(ON_ARROWS_LIST);
            this._list = _arg_1;
        }

        public function get List():Array
        {
            return (this._list);
        }


    }
}//package hbm.Engine.Network.Events

