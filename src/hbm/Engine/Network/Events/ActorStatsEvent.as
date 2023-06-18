


//hbm.Engine.Network.Events.ActorStatsEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;
    import hbm.Engine.Actors.CharacterInfo;

    public class ActorStatsEvent extends Event 
    {

        public static const ON_LEVEL_UP:String = "ON_LEVEL_UP";
        public static const ON_JOB_LEVEL_UP:String = "ON_JOB_LEVEL_UP";
        public static const ON_REFINE_FAILED:String = "ON_REFINE_FAILED";
        public static const ON_REFINE_SUCCESS:String = "ON_REFINE_SUCCESS";
        public static const ID_LEVEL_UP:int = 0;
        public static const ID_JOB_LEVEL_UP:int = 1;
        public static const ID_REFINE_FAILED:int = 2;
        public static const ID_REFINE_SUCCESS:int = 3;

        private var _eventId:int;
        private var _actor:CharacterInfo;

        public function ActorStatsEvent(_arg_1:String, _arg_2:CharacterInfo, _arg_3:int)
        {
            super(_arg_1);
            this._eventId = _arg_3;
            this._actor = _arg_2;
        }

        public function get EventId():int
        {
            return (this._eventId);
        }

        public function get Actor():CharacterInfo
        {
            return (this._actor);
        }


    }
}//package hbm.Engine.Network.Events

