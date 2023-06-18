


//hbm.Engine.Network.Events.ActorHpUpdateEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class ActorHpUpdateEvent extends Event 
    {

        public static const ON_ACTOR_HP_UPDATE:String = "ON_ACTOR_HP_UPDATE";

        public var CurrentHP:int;
        public var MaximumHP:int;
        public var CharacterId:uint;

        public function ActorHpUpdateEvent()
        {
            super(ON_ACTOR_HP_UPDATE);
        }

    }
}//package hbm.Engine.Network.Events

