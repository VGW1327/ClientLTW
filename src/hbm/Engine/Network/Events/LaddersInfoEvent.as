


//hbm.Engine.Network.Events.LaddersInfoEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class LaddersInfoEvent extends Event 
    {

        public static const ON_LADDERS_INFO_UPDATED:String = "ON_LADDERS_INFO_UPDATED";

        private var _ladders:Array;

        public function LaddersInfoEvent(_arg_1:String, _arg_2:Array=null)
        {
            super(_arg_1);
            this._ladders = _arg_2;
        }

        public function get Ladders():Array
        {
            return (this._ladders);
        }


    }
}//package hbm.Engine.Network.Events

