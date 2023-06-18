


//hbm.Engine.Network.Events.ActorViewIdEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;
    import hbm.Engine.Actors.CharacterInfo;

    public class ActorViewIdEvent extends Event 
    {

        public static const ON_ACTOR_VIEWID_UPDATE:String = "ON_ACTOR_VIEWID_UPDATE";

        private var _character:CharacterInfo;

        public function ActorViewIdEvent(_arg_1:CharacterInfo, _arg_2:String)
        {
            super(_arg_2);
            this._character = _arg_1;
        }

        public function get Character():CharacterInfo
        {
            return (this._character);
        }


    }
}//package hbm.Engine.Network.Events

