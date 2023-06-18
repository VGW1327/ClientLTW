


//hbm.Engine.Network.Events.NpcStoreDealEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class NpcStoreDealEvent extends Event 
    {

        public static const ON_PLAYER_BUY:String = "ON_PLAYER_BUY";
        public static const ON_PLAYER_SELL:String = "ON_PLAYER_SELL";

        private var _reason:int;

        public function NpcStoreDealEvent(_arg_1:String, _arg_2:int)
        {
            super(_arg_1);
            this._reason = _arg_2;
        }

        public function get Reason():int
        {
            return (this._reason);
        }


    }
}//package hbm.Engine.Network.Events

