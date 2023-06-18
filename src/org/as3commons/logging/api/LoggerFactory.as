


//org.as3commons.logging.api.LoggerFactory

package org.as3commons.logging.api
{
    public class LoggerFactory 
    {

        private const _allLoggers:Array = [];
        private const _loggers:Object = {};
        private const _nullLogger:Object = {};

        private var _setup:ILogSetup;

        public function LoggerFactory(_arg_1:ILogSetup=null)
        {
            this.setup = _arg_1;
        }

        public function get setup():ILogSetup
        {
            return (this._setup);
        }

        public function set setup(_arg_1:ILogSetup):void
        {
            var _local_3:int;
            this._setup = _arg_1;
            var _local_2:int = this._allLoggers.length;
            _local_3 = 0;
            while (_local_3 < _local_2)
            {
                Logger(this._allLoggers[_local_3]).allTargets = null;
                _local_3++;
            };
            if (_arg_1)
            {
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _arg_1.applyTo(Logger(this._allLoggers[_local_3]));
                    _local_3++;
                };
            };
        }

        public function getNamedLogger(_arg_1:String, _arg_2:String=null):ILogger
        {
            var _local_3:Object;
            var _local_4:* = _arg_1;
            if (_local_4 === null)
            {
                _local_3 = this._nullLogger;
                _arg_1 = "null";
            }
            else
            {
                _local_3 = ((this._loggers[_arg_1]) || (this._loggers[_arg_1] = {}));
            };
            var _local_5:Logger = _local_3[_arg_2];
            if (!_local_5)
            {
                _local_5 = new Logger(_arg_1, _arg_2);
                _local_3[_arg_2] = _local_5;
                this._allLoggers[this._allLoggers.length] = _local_5;
                if (this._setup)
                {
                    this._setup.applyTo(_local_5);
                };
            };
            return (_local_5);
        }


    }
}//package org.as3commons.logging.api

