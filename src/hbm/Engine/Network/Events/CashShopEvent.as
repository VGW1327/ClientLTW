


//hbm.Engine.Network.Events.CashShopEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class CashShopEvent extends Event 
    {

        public static const ON_CASH_SHOP_CHANGE_PANEL:String = "ON_CASH_SHOP_CHANGE_PANEL";

        public var Type:int;

        public function CashShopEvent(_arg_1:String)
        {
            super(_arg_1, true);
        }

    }
}//package hbm.Engine.Network.Events

