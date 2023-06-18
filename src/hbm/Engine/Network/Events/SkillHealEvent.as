


//hbm.Engine.Network.Events.SkillHealEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class SkillHealEvent extends Event 
    {

        public static const ON_SKILL_HEAL:String = "ON_SKILL_HEAL";

        public var Type:int;
        public var Value:int;

        public function SkillHealEvent(_arg_1:int, _arg_2:int)
        {
            super(ON_SKILL_HEAL);
            this.Type = _arg_1;
            this.Value = _arg_2;
        }

    }
}//package hbm.Engine.Network.Events

