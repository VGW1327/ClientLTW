


//hbm.Engine.Network.Events.ActorChangeStatusEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class ActorChangeStatusEvent extends Event 
    {

        public static const ON_ACTOR_CHANGE_STATUS:String = "ON_ACTOR_CHANGE_STATUS";
        public static const OPTION_SIGHT:uint = 1;
        public static const OPTION_HIDE:uint = 2;
        public static const OPTION_CLOAK:uint = 4;
        public static const OPTION_CART1:uint = 8;
        public static const OPTION_FALCON:uint = 16;
        public static const OPTION_RIDING:uint = 32;
        public static const OPTION_INVISIBLE:uint = 64;
        public static const OPTION_CART2:uint = 128;
        public static const OPTION_CART3:uint = 0x0100;
        public static const OPTION_CART4:uint = 0x0200;
        public static const OPTION_CART5:uint = 0x0400;
        public static const OPTION_ORCISH:uint = 0x0800;
        public static const OPTION_WEDDING:uint = 0x1000;
        public static const OPTION_RUWACH:uint = 0x2000;
        public static const OPTION_CHASEWALK:uint = 0x4000;
        public static const OPTION1_STONE:uint = 1;
        public static const OPTION1_FREEZE:uint = 2;
        public static const OPTION1_STUN:uint = 3;
        public static const OPTION1_SLEEP:uint = 4;
        public static const OPTION1_STONEWAIT:uint = 6;
        public static const OPT2_POISON:uint = 1;
        public static const OPT2_CURSE:uint = 2;
        public static const OPT2_SILENCE:uint = 4;
        public static const OPT2_SIGNUMCRUCIS:uint = 8;
        public static const OPT2_BLIND:uint = 16;
        public static const OPT2_ANGELUS:uint = 32;
        public static const OPT2_BLEEDING:uint = 64;
        public static const OPT2_DPOISON:uint = 128;
        public static const OPT2_DEATHFEAR:uint = 0x0100;
        public static const OPT2_ROCKSKIN:uint = 0x0200;
        public static const OPT2_RAGETUDRAH:uint = 0x0400;
        public static const OPT2_FLAG:uint = 0x0800;
        public static const OPT2_FLAG2:uint = 0x1000;
        public static const OPT2_FLAG3:uint = 0x2000;
        public static const OPT2_FLAG4:uint = 0x4000;
        public static const OPT2_FLAG5:uint = 0x8000;

        public var characterId:uint;
        public var option1:int;
        public var option2:int;
        public var option:int;
        public var isPk:int;

        public function ActorChangeStatusEvent()
        {
            super(ON_ACTOR_CHANGE_STATUS);
        }

    }
}//package hbm.Engine.Network.Events

