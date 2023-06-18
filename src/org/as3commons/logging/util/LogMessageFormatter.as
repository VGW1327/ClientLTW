


//org.as3commons.logging.util.LogMessageFormatter

package org.as3commons.logging.util
{
    public final class LogMessageFormatter 
    {

        private const STATIC_TYPE:int = 1;
        private const MESSAGE_TYPE:int = 2;
        private const MESSAGE_DQT_TYPE:int = 3;
        private const TIME_TYPE:int = 4;
        private const TIME_UTC_TYPE:int = 5;
        private const LOG_TIME_TYPE:int = 6;
        private const DATE_TYPE:int = 7;
        private const DATE_UTC_TYPE:int = 8;
        private const LOG_LEVEL_TYPE:int = 9;
        private const SWF_TYPE:int = 10;
        private const SHORT_SWF_TYPE:int = 11;
        private const NAME_TYPE:int = 12;
        private const SHORT_NAME_TYPE:int = 13;
        private const GMT_OFFSET_TYPE:int = 14;
        private const PERSON_TYPE:int = 15;
        private const AT_PERSON_TYPE:int = 16;
        private const TYPES:Object = {
            "message":MESSAGE_TYPE,
            "message_dqt":MESSAGE_DQT_TYPE,
            "time":TIME_TYPE,
            "timeUTC":TIME_UTC_TYPE,
            "logTime":LOG_TIME_TYPE,
            "date":DATE_TYPE,
            "dateUTC":DATE_UTC_TYPE,
            "logLevel":LOG_LEVEL_TYPE,
            "swf":SWF_TYPE,
            "shortSWF":SHORT_SWF_TYPE,
            "name":NAME_TYPE,
            "shortName":SHORT_NAME_TYPE,
            "gmt":GMT_OFFSET_TYPE,
            "person":PERSON_TYPE,
            "atPerson":AT_PERSON_TYPE
        };
        private const _now:Date = new Date();
        private const _braceRegexp:RegExp = /{(?P<field>[a-zA-Z_]+)}/g;

        private var _firstNode:FormatNode;

        public function LogMessageFormatter(_arg_1:String)
        {
            var _local_3:Object;
            var _local_4:FormatNode;
            var _local_5:FormatNode;
            var _local_6:String;
            var _local_7:int;
            var _local_8:FormatNode;
            super();
            var _local_2:int;
            while ((_local_3 = this._braceRegexp.exec(_arg_1)))
            {
                if ((_local_7 = this.TYPES[_local_3["field"]]))
                {
                    if (_local_2 != _local_3["index"])
                    {
                        _local_6 = _arg_1.substring(_local_2, _local_3["index"]);
                        _local_5 = new FormatNode();
                        _local_5.type = this.STATIC_TYPE;
                        _local_5.content = _local_6;
                        if (_local_4)
                        {
                            _local_4.next = _local_5;
                        }
                        else
                        {
                            this._firstNode = _local_5;
                        };
                        _local_4 = _local_5;
                    };
                    _local_8 = new FormatNode();
                    _local_8.type = _local_7;
                    _local_2 = (_local_3["index"] + _local_3[0]["length"]);
                    if (_local_4)
                    {
                        _local_4.next = _local_8;
                    }
                    else
                    {
                        this._firstNode = _local_8;
                    };
                    _local_4 = _local_8;
                };
            };
            if (_local_2 != _arg_1.length)
            {
                _local_6 = _arg_1.substring(_local_2);
                _local_5 = new FormatNode();
                _local_5.type = this.STATIC_TYPE;
                _local_5.content = _local_6;
                if (_local_4)
                {
                    _local_4.next = _local_5;
                }
                else
                {
                    this._firstNode = _local_5;
                };
            };
        }

        public function format(_arg_1:String, _arg_2:String, _arg_3:int, _arg_4:Number, _arg_5:String, _arg_6:Array, _arg_7:String):String
        {
            var _local_10:int;
            var _local_11:int;
            var _local_12:*;
            var _local_13:int;
            var _local_14:String;
            var _local_15:String;
            var _local_16:String;
            var _local_17:String;
            var _local_8:* = "";
            var _local_9:FormatNode = this._firstNode;
            if (_arg_5)
            {
                _local_10 = ((_arg_6) ? _arg_6.length : 0);
                _local_11 = 0;
                while (_local_11 < _local_10)
                {
                    _local_12 = _arg_6[_local_11];
                    _arg_5 = _arg_5.split((("{" + _local_11) + "}")).join(_local_12);
                    _local_11++;
                };
            };
            this._now.time = ((isNaN(_arg_4)) ? 0 : (START_TIME + _arg_4));
            while (_local_9)
            {
                _local_13 = _local_9.type;
                if (_local_13 < 7)
                {
                    if (_local_13 < 4)
                    {
                        if (_local_13 == this.STATIC_TYPE)
                        {
                            _local_8 = (_local_8 + _local_9.content);
                        }
                        else
                        {
                            if (_local_13 == this.MESSAGE_TYPE)
                            {
                                _local_8 = (_local_8 + _arg_5);
                            }
                            else
                            {
                                if (_arg_5)
                                {
                                    _local_8 = (_local_8 + _arg_5.replace('"', '\\"').replace("\n", "\\n"));
                                }
                                else
                                {
                                    _local_8 = (_local_8 + _arg_5);
                                };
                            };
                        };
                    }
                    else
                    {
                        if (_local_13 == this.TIME_TYPE)
                        {
                            _local_8 = (_local_8 + ((((((this._now.hours + ":") + this._now.minutes) + ":") + this._now.seconds) + ".") + this._now.milliseconds));
                        }
                        else
                        {
                            if (_local_13 == this.TIME_UTC_TYPE)
                            {
                                _local_8 = (_local_8 + ((((((this._now.hoursUTC + ":") + this._now.minutesUTC) + ":") + this._now.secondsUTC) + ".") + this._now.millisecondsUTC));
                            }
                            else
                            {
                                _local_14 = this._now.hoursUTC.toString();
                                if (_local_14.length == 1)
                                {
                                    _local_14 = ("0" + _local_14);
                                };
                                _local_15 = this._now.minutesUTC.toString();
                                if (_local_15.length == 1)
                                {
                                    _local_15 = ("0" + _local_15);
                                };
                                _local_16 = this._now.secondsUTC.toString();
                                if (_local_16.length == 1)
                                {
                                    _local_16 = ("0" + _local_16);
                                };
                                _local_17 = this._now.millisecondsUTC.toString();
                                if (_local_17.length == 1)
                                {
                                    _local_17 = ("00" + _local_17);
                                }
                                else
                                {
                                    if (_local_17.length == 2)
                                    {
                                        _local_17 = ("0" + _local_17);
                                    };
                                };
                                _local_8 = (_local_8 + ((((((_local_14 + ":") + _local_15) + ":") + _local_16) + ".") + _local_17));
                            };
                        };
                    };
                }
                else
                {
                    if (_local_13 < 13)
                    {
                        if (_local_13 < 10)
                        {
                            if (_local_13 == this.DATE_TYPE)
                            {
                                _local_8 = (_local_8 + ((((this._now.fullYear + "/") + (this._now.month + 1)) + "/") + this._now.date));
                            }
                            else
                            {
                                if (_local_13 == this.DATE_UTC_TYPE)
                                {
                                    _local_8 = (_local_8 + ((((this._now.fullYearUTC + "/") + (this._now.monthUTC + 1)) + "/") + this._now.dateUTC));
                                }
                                else
                                {
                                    if (_arg_3)
                                    {
                                        _local_8 = (_local_8 + ((LEVEL_NAMES[_arg_3]) || ("FATAL")));
                                    };
                                };
                            };
                        }
                        else
                        {
                            if (_local_13 == this.SWF_TYPE)
                            {
                                _local_8 = (_local_8 + SWF_URL);
                            }
                            else
                            {
                                if (_local_13 == this.SHORT_SWF_TYPE)
                                {
                                    _local_8 = (_local_8 + SWF_SHORT_URL);
                                }
                                else
                                {
                                    _local_8 = (_local_8 + _arg_1);
                                };
                            };
                        };
                    }
                    else
                    {
                        if (_local_13 == this.SHORT_NAME_TYPE)
                        {
                            _local_8 = (_local_8 + _arg_2);
                        }
                        else
                        {
                            if (_local_13 == this.GMT_OFFSET_TYPE)
                            {
                                _local_8 = (_local_8 + GMT);
                            }
                            else
                            {
                                if (_local_13 == this.PERSON_TYPE)
                                {
                                    if (_arg_7)
                                    {
                                        _local_8 = (_local_8 + _arg_7);
                                    };
                                }
                                else
                                {
                                    if (_arg_7)
                                    {
                                        _local_8 = (_local_8 + ("@" + _arg_7));
                                    };
                                };
                            };
                        };
                    };
                };
                _local_9 = _local_9.next;
            };
            return (_local_8);
        }


    }
}//package org.as3commons.logging.util

final class FormatNode 
{

    public var next:FormatNode;
    public var content:String;
    public var param:int;
    public var type:int;


}


