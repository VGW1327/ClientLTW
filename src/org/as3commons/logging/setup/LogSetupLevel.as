


//org.as3commons.logging.setup.LogSetupLevel

package org.as3commons.logging.setup
{
    import org.as3commons.logging.api.Logger;

    public final class LogSetupLevel 
    {

        private static const _levels:Array = [];
        public static const NONE:LogSetupLevel = getLevelByValue(1);
        public static const FATAL_ONLY:LogSetupLevel = getLevelByValue(2);
        public static const FATAL:LogSetupLevel = NONE.or(FATAL_ONLY);
        public static const ERROR_ONLY:LogSetupLevel = getLevelByValue(4);
        public static const ERROR:LogSetupLevel = FATAL.or(ERROR_ONLY);
        public static const WARN_ONLY:LogSetupLevel = getLevelByValue(8);
        public static const WARN:LogSetupLevel = ERROR.or(WARN_ONLY);
        public static const INFO_ONLY:LogSetupLevel = getLevelByValue(16);
        public static const INFO:LogSetupLevel = WARN.or(INFO_ONLY);
        public static const DEBUG_ONLY:LogSetupLevel = getLevelByValue(32);
        public static const DEBUG:LogSetupLevel = INFO.or(DEBUG_ONLY);
        public static const ALL:LogSetupLevel = DEBUG;

        private var _value:int;

        public function LogSetupLevel(_arg_1:int)
        {
            if (_levels[_arg_1])
            {
                throw (Error("LogTargetLevel exists already!"));
            };
            _levels[_arg_1] = this;
            this._value = _arg_1;
        }

        public static function getLevelByValue(_arg_1:int):LogSetupLevel
        {
            return ((_levels[_arg_1]) || (_levels[_arg_1] = new LogSetupLevel(_arg_1)));
        }


        public function applyTo(_arg_1:Logger, _arg_2:ILogTarget):void
        {
            if ((this._value & DEBUG_ONLY._value) == DEBUG_ONLY._value)
            {
                _arg_1.debugTarget = _arg_2;
            };
            if ((this._value & INFO_ONLY._value) == INFO_ONLY._value)
            {
                _arg_1.infoTarget = _arg_2;
            };
            if ((this._value & WARN_ONLY._value) == WARN_ONLY._value)
            {
                _arg_1.warnTarget = _arg_2;
            };
            if ((this._value & ERROR_ONLY._value) == ERROR_ONLY._value)
            {
                _arg_1.errorTarget = _arg_2;
            };
            if ((this._value & FATAL_ONLY._value) == FATAL_ONLY._value)
            {
                _arg_1.fatalTarget = _arg_2;
            };
        }

        public function or(_arg_1:LogSetupLevel):LogSetupLevel
        {
            return (getLevelByValue((this._value | _arg_1._value)));
        }

        public function valueOf():int
        {
            return (this._value);
        }


    }
}//package org.as3commons.logging.setup

