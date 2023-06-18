


//hbm.Engine.Network.Events.SkillUnitEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class SkillUnitEvent extends Event 
    {

        public static const ON_SKILL_UNIT:String = "ON_SKILL_UNIT";

        public var UnitId:int;
        public var GroupSourceCharacterId:int;
        public var X:int;
        public var Y:int;
        public var Flag:int;
        public var Flag2:int;

        public function SkillUnitEvent()
        {
            super(ON_SKILL_UNIT);
        }

    }
}//package hbm.Engine.Network.Events

