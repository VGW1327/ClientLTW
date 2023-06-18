


//hbm.Engine.Network.Events.UpdatePremiumEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class UpdatePremiumEvent extends Event 
    {

        public static const ON_PREMIUM_UPDATED:String = "ON_PREMIUM_UPDATED";

        public function UpdatePremiumEvent()
        {
            super(ON_PREMIUM_UPDATED);
        }

    }
}//package hbm.Engine.Network.Events

