


//hbm.Engine.Actors.StorageData

package hbm.Engine.Actors
{
    import flash.utils.Dictionary;

    public class StorageData 
    {

        public static const STATE_CLOSED:int = 0;
        public static const STATE_OPENED:int = 1;

        private var _state:int;
        private var _amount:int;
        private var _maxAmount:int;
        private var _storage:Dictionary;


        public function Reset():void
        {
            this._storage = new Dictionary(true);
            this._amount = 0;
        }

        public function get Storage():Dictionary
        {
            if (this._storage == null)
            {
                this.Reset();
            };
            return (this._storage);
        }

        public function set Storage(_arg_1:Dictionary):void
        {
            this._storage = _arg_1;
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


    }
}//package hbm.Engine.Actors

