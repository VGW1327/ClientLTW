


//hbm.Game.Statistic.StatisticManager

package hbm.Game.Statistic
{
    public class StatisticManager 
    {

        private static const _instance:StatisticManager = new (StatisticManager)();
        private static var _singletone:Boolean = false;

        private var _controller:Netstat24;

        public function StatisticManager()
        {
            if (_singletone)
            {
                throw ("Can't create class StatisticManager!");
            };
            _singletone = true;
        }

        public static function get Instance():StatisticManager
        {
            return (_instance);
        }


        public function InitAPI(_arg_1:String, _arg_2:String):void
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return;
            };
            this._controller = new Netstat24(_arg_1, _arg_2, "0");
        }

        public function set UserID(_arg_1:String):void
        {
            if (this._controller)
            {
                this._controller.setViewerId(_arg_1);
            };
        }

        public function InstallApplication():void
        {
            if (this._controller)
            {
                this._controller.install("ad");
            };
        }

        public function VisitApplication():void
        {
            if (this._controller)
            {
                this._controller.visit("notification");
            };
        }

        public function SendEvent(_arg_1:String):void
        {
            if (this._controller)
            {
                this._controller.trackEvent(_arg_1);
            };
        }

        public function SendEventNum(_arg_1:String, _arg_2:Number):void
        {
            if (this._controller)
            {
                this._controller.trackNumber(_arg_1, _arg_2);
            };
        }

        public function SendEventValue(_arg_1:String, _arg_2:String):void
        {
            if (this._controller)
            {
                this._controller.trackValue(_arg_1, _arg_2);
            };
        }


    }
}//package hbm.Game.Statistic

