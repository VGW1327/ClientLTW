


//hbm.Engine.Network.Client.ClientTime

package hbm.Engine.Network.Client
{
    import flash.utils.getTimer;

    public class ClientTime 
    {

        private static var _singleton:ClientTime = null;
        private static var _isSingletonLock:Boolean = false;

        private var _lastServerTick:uint;
        private var _lastClientTick:uint;

        public function ClientTime()
        {
            if (!_isSingletonLock)
            {
                throw (new Error("Invalid Singleton access. Use ClientTime.Instance."));
            };
            this._lastServerTick = 0;
            this._lastClientTick = 0;
        }

        public static function get Instance():ClientTime
        {
            if (_singleton == null)
            {
                _isSingletonLock = true;
                _singleton = new (ClientTime)();
                _isSingletonLock = false;
            };
            return (_singleton);
        }


        public function ServerSync(_arg_1:uint):void
        {
            this._lastServerTick = _arg_1;
            this._lastClientTick = getTimer();
        }

        public function get CurrentTime():uint
        {
            return (this._lastServerTick + (getTimer() - this._lastClientTick));
        }


    }
}//package hbm.Engine.Network.Client

