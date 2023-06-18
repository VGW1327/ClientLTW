


//hbm.Engine.Network.Events.ActorActionEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class ActorActionEvent extends Event 
    {

        public static const ON_ACTOR_ACTION:String = "ON_ACTOR_ACTION";

        public var sourceID:uint;
        public var targetID:uint;
        public var tick:int;
        public var sourceDelay:int;
        public var targetDelay:int;
        public var damage:int;
        public var div:int;
        public var actionType:int;
        public var damage2:int;
        public var skillId:int = 0;

        public function ActorActionEvent()
        {
            super(ON_ACTOR_ACTION);
        }

    }
}//package hbm.Engine.Network.Events

