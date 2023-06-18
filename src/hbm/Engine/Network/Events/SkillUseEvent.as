


//hbm.Engine.Network.Events.SkillUseEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class SkillUseEvent extends Event 
    {

        public static const ON_SKILL_USE:String = "ON_SKILL_USE";

        public var skillId:int;
        public var srcId:uint;
        public var dstId:uint;
        public var tick:int;
        public var sdelay:int;
        public var ddelay:int;
        public var damage:int;
        public var skillLevel:int;
        public var div:int;
        public var skillType:int;

        public function SkillUseEvent()
        {
            super(ON_SKILL_USE);
        }

    }
}//package hbm.Engine.Network.Events

