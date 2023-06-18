


//hbm.Engine.Network.Events.SkillPosEffectEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class SkillPosEffectEvent extends Event 
    {

        public static const ON_SKILL_POS_EFFECT:String = "ON_SKILL_POS_EFFECT";

        public var SkillId:int;
        public var SourceId:uint;
        public var Value:int;
        public var X:int;
        public var Y:int;
        public var Tick:int;

        public function SkillPosEffectEvent()
        {
            super(ON_SKILL_POS_EFFECT);
        }

    }
}//package hbm.Engine.Network.Events

