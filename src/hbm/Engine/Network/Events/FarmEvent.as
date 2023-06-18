


//hbm.Engine.Network.Events.FarmEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class FarmEvent extends Event 
    {

        public static const ON_UPDATE_CUSTOM_FARM:String = "ON_UPDATE_CUSTOM_FARM";
        public static const ON_UPDATE_CUSTOM_FARM_LIST:String = "ON_UPDATE_CUSTOM_FARM_LIST";

        private var _data:Object;

        public function FarmEvent(_arg_1:String, _arg_2:Object=null)
        {
            super(_arg_1);
            this._data = _arg_2;
        }

        public function get Data():Object
        {
            return (this._data);
        }


    }
}//package hbm.Engine.Network.Events

