


//com.hbm.socialmodule.utils.TaskScheduler

package com.hbm.socialmodule.utils
{
    import flash.events.EventDispatcher;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import flash.utils.setTimeout;

    public class TaskScheduler extends EventDispatcher 
    {

        public static const TIMEOUT:String = "schedule_timeout";
        public static const INTERRUPTED:String = "schedule_interrupted";
        private static const logger:ILogger = getLogger(TaskScheduler);

        private var _schedule:Array = [];
        private var _lock:Boolean = false;
        private var _timeout:uint = 0;
        private var _timer:Timer;
        private var _timestamp:uint = 0;
        private var _delay:uint = 0;
        private var _expectedEventType:String;
        private var _currentNotifier:Object;
        private var _currentTask:Object;

        public function TaskScheduler()
        {
            this._timer = new Timer(this._timeout, 1);
            this._timer.addEventListener(TimerEvent.TIMER, this.OnTimeout);
        }

        public function Schedule(_arg_1:Object, _arg_2:String, _arg_3:Object, _arg_4:Function, ... _args):void
        {
            if (!this._lock)
            {
                this.Execute(_arg_1, _arg_2, _arg_3, _arg_4, _args);
            }
            else
            {
                this._schedule.push({
                    "notifier":_arg_1,
                    "event":_arg_2,
                    "owner":_arg_3,
                    "callback":_arg_4,
                    "args":_args
                });
            };
        }

        private function Next(_arg_1:Event):void
        {
            this._currentNotifier.removeEventListener(this._expectedEventType, this.Next);
            if (this._schedule.length != 0)
            {
                this._currentTask = this._schedule.shift();
                this.Execute(this._currentTask.notifier, this._currentTask.event, this._currentTask.owner, this._currentTask.callback, this._currentTask.args);
            }
            else
            {
                this._lock = false;
                this._timer.reset();
            };
        }

        protected function Execute(_arg_1:Object, _arg_2:String, _arg_3:Object, _arg_4:Function, _arg_5:Array):void
        {
            this._lock = true;
            this._expectedEventType = _arg_2;
            this._currentNotifier = _arg_1;
            if (this._timeout > 0)
            {
                this._timer.reset();
                this._timer.start();
            };
            this._currentNotifier.addEventListener(_arg_2, this.Next);
            setTimeout(_arg_4.apply, this._delay, _arg_3, _arg_5);
        }

        public function Interrupt():void
        {
            logger.warn((this._expectedEventType + " expectation interrupted. Task schedule drop."));
            this._schedule = [];
            this._currentNotifier.removeEventListener(this._expectedEventType, this.Next);
            this._lock = false;
            this._timer.reset();
            dispatchEvent(new Event(TaskScheduler.INTERRUPTED));
        }

        private function OnTimeout(_arg_1:Event):void
        {
            this.Interrupt();
            dispatchEvent(new Event(TaskScheduler.TIMEOUT));
        }

        public function get timeout():uint
        {
            return (this._timeout);
        }

        public function set timeout(_arg_1:uint):void
        {
            this._timeout = _arg_1;
            this._timer.delay = this._timeout;
        }

        public function get delay():uint
        {
            return (this._delay);
        }

        public function set delay(_arg_1:uint):void
        {
            this._delay = _arg_1;
        }


    }
}//package com.hbm.socialmodule.utils

