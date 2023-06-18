


//hbm.Engine.Network.Events.UpdateCashEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class UpdateCashEvent extends Event 
    {

        public static const ON_CASH_UPDATED:String = "ON_CASH_UPDATED";

        public var CashPoints:int;
        public var KafraPoints:int;

        public function UpdateCashEvent(_arg_1:int, _arg_2:int)
        {
            super(ON_CASH_UPDATED);
            this.CashPoints = _arg_1;
            this.KafraPoints = _arg_2;
        }

    }
}//package hbm.Engine.Network.Events

