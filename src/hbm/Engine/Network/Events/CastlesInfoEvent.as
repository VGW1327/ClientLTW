


//hbm.Engine.Network.Events.CastlesInfoEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;
    import flash.utils.Dictionary;

    public class CastlesInfoEvent extends Event 
    {

        public static const ON_CASTLES_INFO_UPDATED:String = "ON_CASTLES_INFO_UPDATED";

        private var _castles:Dictionary;

        public function CastlesInfoEvent(_arg_1:String, _arg_2:Dictionary=null)
        {
            super(_arg_1);
            this._castles = _arg_2;
        }

        public function get Castles():Dictionary
        {
            return (this._castles);
        }


    }
}//package hbm.Engine.Network.Events

