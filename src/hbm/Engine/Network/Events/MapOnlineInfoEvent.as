


//hbm.Engine.Network.Events.MapOnlineInfoEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class MapOnlineInfoEvent extends Event 
    {

        public static const ON_MAP_ONLINE_INFO_UPDATED:String = "ON_MAP_ONLINE_INFO_UPDATED";

        private var _mapname:String;
        private var _online:int;

        public function MapOnlineInfoEvent(_arg_1:String, _arg_2:String=null, _arg_3:int=0)
        {
            super(_arg_1);
            this._mapname = _arg_2;
            this._online = _arg_3;
        }

        public function get Mapname():String
        {
            return (this._mapname);
        }

        public function get Online():int
        {
            return (this._online);
        }


    }
}//package hbm.Engine.Network.Events

