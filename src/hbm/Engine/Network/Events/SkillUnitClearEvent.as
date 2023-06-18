


//hbm.Engine.Network.Events.SkillUnitClearEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class SkillUnitClearEvent extends Event 
    {

        public static const ON_SKILL_UNIT_CLEAR:String = "ON_SKILL_UNIT_CLEAR";

        public var UnitId:int;

        public function SkillUnitClearEvent(_arg_1:int)
        {
            super(ON_SKILL_UNIT_CLEAR);
            this.UnitId = _arg_1;
        }

    }
}//package hbm.Engine.Network.Events

