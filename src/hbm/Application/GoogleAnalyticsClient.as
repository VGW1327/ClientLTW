package hbm.Application
{
    import com.google.analytics.GATracker;
    import flash.utils.Timer;
    import flash.events.TimerEvent;

    public class GoogleAnalyticsClient 
    {

        private static var _singleton:GoogleAnalyticsClient = null;
        private static var _isSingletonLock:Boolean = false;
        public static const RETRIES:int = 30;

        private var _enabled:Boolean;
        private var _google:GATracker;
        private var _pollTimer:Timer;
        private var _queue:Array;

        public function GoogleAnalyticsClient()
        {
            if (!_isSingletonLock)
            {
                throw (new Error("Invalid Singleton access."));
            }
            var _local_1:String = ClientApplication.Instance.Config.GetGATracker;
            this._enabled = (!(_local_1 == null));
            if (!this._enabled)
            {
                return;
            }
            this._google = new GATracker(ClientApplication.Instance.stage, _local_1, "AS3", false);
            this._queue = new Array();
            this._pollTimer = new Timer(1000, RETRIES);
            this._pollTimer.addEventListener(TimerEvent.TIMER, this.OnPollTimer);
            this._pollTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.OnPollTimerComplete);
            this._pollTimer.start();
        }

        public static function get Instance():GoogleAnalyticsClient
        {
            if (_singleton == null)
            {
                _isSingletonLock = true;
                _singleton = new (GoogleAnalyticsClient)();
                _isSingletonLock = false;
            }
            return (_singleton);
        }


        public function get Worker():GATracker
        {
            return (this._google);
        }

        public function trackPageview(_arg_1:String):void
        {
            if (!this._enabled)
            {
                return;
            }
            if (!this._google.isReady())
            {
                this._queue.push(_arg_1);
                return;
            }
            var _local_2:String = (("/" + ClientApplication.Instance.Config.CurrentPlatformId) + _arg_1);
            this._google.trackPageview(_local_2);
        }

        public function trackIngame(_arg_1:String):void
        {
            this.trackPageview(((("/" + ClientApplication.gameServerName) + "/") + _arg_1));
        }

        private function OnPollTimer(_arg_1:TimerEvent):void
        {
            var _local_2:String;
            if (!this._google.isReady())
            {
                return;
            }
            for each (_local_2 in this._queue)
            {
                this.trackPageview(_local_2);
            }
            this._pollTimer.stop();
        }

        private function OnPollTimerComplete(_arg_1:TimerEvent):void
        {
            if (this._pollTimer.repeatCount >= RETRIES)
            {
                this._enabled = false;
                this._queue = null;
            }
        }


    }
}