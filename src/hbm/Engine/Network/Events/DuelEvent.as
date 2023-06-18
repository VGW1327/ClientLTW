


//hbm.Engine.Network.Events.DuelEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class DuelEvent extends Event 
    {

        public static const ON_DUEL_JOIN_REQUEST:String = "ON_DUEL_JOIN_REQUEST";

        public var Result:int;
        public var CharacterId:int;
        public var CharacterName:String;

        public function DuelEvent(_arg_1:String)
        {
            super(_arg_1);
        }

    }
}//package hbm.Engine.Network.Events

