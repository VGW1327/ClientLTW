


//hbm.Game.GUI.CashShop.Stash.SlotEvent

package hbm.Game.GUI.CashShop.Stash
{
    import flash.events.Event;

    public class SlotEvent extends Event 
    {

        public static const CRAFT_RUNE:int = 0;
        public static const CRAFT_ITEM:int = 1;
        public static const SLOT_EVENT:String = "SLOT_EVENT";

        public var slotType:int = 0;
        public var slotIndex:int = 0;
        public var itemInSlot:Boolean = false;

        public function SlotEvent(_arg_1:Boolean, _arg_2:int, _arg_3:int=0)
        {
            super("SLOT_EVENT", true, false);
            this.slotType = _arg_2;
            this.slotIndex = _arg_3;
            this.itemInSlot = _arg_1;
        }

    }
}//package hbm.Game.GUI.CashShop.Stash

