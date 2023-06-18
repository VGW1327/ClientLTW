


//hbm.Engine.Network.Events.GiftItemEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class GiftItemEvent extends Event 
    {

        public static const ON_GIFT_ITEM:String = "ON_GIFT_ITEM";

        public var PremiumType:int;
        public var Day:int;
        public var NameId:int;
        public var Amount:int;

        public function GiftItemEvent(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int)
        {
            super(ON_GIFT_ITEM);
            this.PremiumType = _arg_1;
            this.Day = _arg_2;
            this.NameId = _arg_3;
            this.Amount = _arg_4;
        }

    }
}//package hbm.Engine.Network.Events

