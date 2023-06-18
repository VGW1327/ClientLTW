


//hbm.Engine.Network.Events.UpdateRouletteCashEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class UpdateRouletteCashEvent extends Event 
    {

        public static const ON_ROULETTE_CASH_UPDATED:String = "ON_ROULETTE_CASH_UPDATED";

        public var CashPoints:int;
        public var Result:int;

        public function UpdateRouletteCashEvent(_arg_1:int, _arg_2:int)
        {
            super(ON_ROULETTE_CASH_UPDATED);
            this.CashPoints = _arg_1;
            this.Result = _arg_2;
        }

    }
}//package hbm.Engine.Network.Events

