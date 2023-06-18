


//hbm.Engine.Network.Events.SkillCastEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class SkillCastEvent extends Event 
    {

        public static const ON_SKILL_CAST:String = "ON_SKILL_CAST";

        public var SourceId:uint;
        public var TargetId:int;
        public var TargetX:int;
        public var TargetY:int;
        public var SkillId:int;
        public var TypeId:int;
        public var CastTime:int;

        public function SkillCastEvent()
        {
            super(ON_SKILL_CAST);
        }

    }
}//package hbm.Engine.Network.Events

