


//hbm.Engine.Network.Events.UpdateQuestsEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class UpdateQuestsEvent extends Event 
    {

        public static const ON_QUESTS_UPDATED:String = "ON_QUESTS_UPDATED";

        public function UpdateQuestsEvent()
        {
            super(ON_QUESTS_UPDATED);
        }

    }
}//package hbm.Engine.Network.Events

