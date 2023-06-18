


//hbm.Game.GUI.CharacterStats.CharacterStatsButtonEvent

package hbm.Game.GUI.CharacterStats
{
    import flash.events.Event;

    public class CharacterStatsButtonEvent extends Event 
    {

        public static const ON_STAT_INCREASED:String = "ON_STR_INCREASED";

        private var _stat:int;

        public function CharacterStatsButtonEvent(_arg_1:int)
        {
            super(ON_STAT_INCREASED);
            this._stat = _arg_1;
        }

        override public function clone():Event
        {
            return (new CharacterStatsButtonEvent(this._stat));
        }

        public function get Stat():int
        {
            return (this._stat);
        }


    }
}//package hbm.Game.GUI.CharacterStats

