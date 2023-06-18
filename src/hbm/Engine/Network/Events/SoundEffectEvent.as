


//hbm.Engine.Network.Events.SoundEffectEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class SoundEffectEvent extends Event 
    {

        public static const ON_SOUND_EFFECT:String = "ON_SOUND_EFFECT";

        public var Name:String;
        public var Type:uint;

        public function SoundEffectEvent(_arg_1:String, _arg_2:String, _arg_3:uint)
        {
            super(_arg_1);
            this.Name = _arg_2;
            this.Type = _arg_3;
        }

    }
}//package hbm.Engine.Network.Events

