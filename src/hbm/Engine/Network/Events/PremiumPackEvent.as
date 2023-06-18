


//hbm.Engine.Network.Events.PremiumPackEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class PremiumPackEvent extends Event 
    {

        public static const ON_PREMIUM_PACK:String = "ON_PREMIUM_PACK";

        private var _items:Array;
        private var _count:int;
        private var _type:int;

        public function PremiumPackEvent(_arg_1:String, _arg_2:int, _arg_3:Array, _arg_4:int)
        {
            super(_arg_1);
            this._type = _arg_2;
            this._items = _arg_3;
            this._count = _arg_4;
        }

        public function get Items():Array
        {
            return (this._items);
        }

        public function get Count():int
        {
            return (this._count);
        }

        public function get Type():int
        {
            return (this._type);
        }


    }
}//package hbm.Engine.Network.Events

