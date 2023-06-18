


//hbm.Engine.Network.Events.ActorDisplayEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;
    import hbm.Engine.Actors.CharacterInfo;

    public class ActorDisplayEvent extends Event 
    {

        public static const ON_ACTOR_UPDATE_DIR:String = "ON_ACTOR_UPDATE_DIR";
        public static const ON_ACTOR_MOVES:String = "ON_ACTOR_MOVES";
        public static const ON_ACTOR_DISAPPEAR:String = "ON_ACTOR_DISAPPEAR";
        public static const ON_ACTOR_INTERRUPTED:String = "ON_ACTOR_INTERRUPTED";
        public static const ON_ACTOR_INFO_UPDATED:String = "ON_ACTOR_INFO_UPDATED";
        public static const ON_ACTOR_NAME_UPDATED:String = "ON_ACTOR_NAME_UPDATED";
        public static const ON_ACTOR_CAST_CANCELED:String = "ON_ACTOR_CAST_CANCELED";
        public static const ON_ACTOR_HAIR_COLOR_CHANGED:String = "ON_ACTOR_HAIR_COLOR_CHANGED";
        public static const ON_ACTOR_RESURRECTED:String = "ON_ACTOR_RESURRECTED";
        public static const MOVED_OUT_OF_SIGHT:int = 0;
        public static const DIED:int = 1;
        public static const RESPAWNED:int = 2;
        public static const TELEPORTED:int = 3;
        public static const DISPLAYED:int = 4;

        private var _charcter:CharacterInfo;
        private var _action:int;
        public var disguiseId:int = 0;
        public var option:uint = 0;
        public var option1:uint = 0;
        public var option2:uint = 0;
        public var option3:uint = 0;
        public var withOptions:Boolean = false;

        public function ActorDisplayEvent(_arg_1:CharacterInfo, _arg_2:String, _arg_3:int=0)
        {
            super(_arg_2);
            this._charcter = _arg_1;
            this._action = _arg_3;
        }

        public function get Character():CharacterInfo
        {
            return (this._charcter);
        }

        public function get Action():int
        {
            return (this._action);
        }


    }
}//package hbm.Engine.Network.Events

