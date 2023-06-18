


//hbm.Engine.Actors.CartData

package hbm.Engine.Actors
{
    import flash.utils.Dictionary;

    public class CartData 
    {

        public static const STATE_CLOSED:int = 0;
        public static const STATE_OPENED:int = 1;

        private var _state:int;
        private var _amount:int;
        private var _maxAmount:int;
        private var _weight:int;
        private var _maxWeight:int;
        private var _cart:Dictionary;


        public function Reset():void
        {
            this._cart = new Dictionary(true);
            this._amount = 0;
        }

        public function get Cart():Dictionary
        {
            if (this._cart == null)
            {
                this.Reset();
            };
            return (this._cart);
        }

        public function set Cart(_arg_1:Dictionary):void
        {
            this._cart = _arg_1;
        }

        public function get Amount():int
        {
            return (this._amount);
        }

        public function set Amount(_arg_1:int):void
        {
            this._amount = _arg_1;
        }

        public function get MaxAmount():int
        {
            return (this._maxAmount);
        }

        public function set MaxAmount(_arg_1:int):void
        {
            this._maxAmount = _arg_1;
        }

        public function get State():int
        {
            return (this._state);
        }

        public function set State(_arg_1:int):void
        {
            this._state = _arg_1;
        }

        public function get Weight():int
        {
            return (this._weight);
        }

        public function set Weight(_arg_1:int):void
        {
            this._weight = _arg_1;
        }

        public function get MaxWeight():int
        {
            return (this._maxWeight);
        }

        public function set MaxWeight(_arg_1:int):void
        {
            this._maxWeight = _arg_1;
        }


    }
}//package hbm.Engine.Actors

