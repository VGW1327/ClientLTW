


//hbm.Engine.Network.Events.SkillCastNoDamage

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class SkillCastNoDamage extends Event 
    {

        public static const ON_SKILL_CAST_NODAMAGE:String = "ON_SKILL_CAST_NODAMAGE";

        public var SkillId:int;
        public var Heal:int;
        public var TargetId:uint;
        public var SourceId:uint;
        public var Fail:int;

        public function SkillCastNoDamage()
        {
            super(ON_SKILL_CAST_NODAMAGE);
        }

    }
}//package hbm.Engine.Network.Events

