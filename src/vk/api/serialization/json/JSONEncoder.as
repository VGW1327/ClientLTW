


//vk.api.serialization.json.JSONEncoder

package vk.api.serialization.json
{
    import flash.utils.describeType;

    public class JSONEncoder 
    {

        private var jsonString:String;

        public function JSONEncoder(_arg_1:*)
        {
            jsonString = convertToString(_arg_1);
        }

        private function escapeString(_arg_1:String):String
        {
            var _local_3:String;
            var _local_6:String;
            var _local_7:String;
            var _local_2:* = "";
            var _local_4:Number = _arg_1.length;
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _local_3 = _arg_1.charAt(_local_5);
                switch (_local_3)
                {
                    case '"':
                        _local_2 = (_local_2 + '\\"');
                        break;
                    case "\\":
                        _local_2 = (_local_2 + "\\\\");
                        break;
                    case "\b":
                        _local_2 = (_local_2 + "\\b");
                        break;
                    case "\f":
                        _local_2 = (_local_2 + "\\f");
                        break;
                    case "\n":
                        _local_2 = (_local_2 + "\\n");
                        break;
                    case "\r":
                        _local_2 = (_local_2 + "\\r");
                        break;
                    case "\t":
                        _local_2 = (_local_2 + "\\t");
                        break;
                    default:
                        if (_local_3 < " ")
                        {
                            _local_6 = _local_3.charCodeAt(0).toString(16);
                            _local_7 = ((_local_6.length == 2) ? "00" : "000");
                            _local_2 = (_local_2 + (("\\u" + _local_7) + _local_6));
                        }
                        else
                        {
                            _local_2 = (_local_2 + _local_3);
                        };
                };
                _local_5++;
            };
            return (('"' + _local_2) + '"');
        }

        private function arrayToString(_arg_1:Array):String
        {
            var _local_2:* = "";
            var _local_3:int;
            while (_local_3 < _arg_1.length)
            {
                if (_local_2.length > 0)
                {
                    _local_2 = (_local_2 + ",");
                };
                _local_2 = (_local_2 + convertToString(_arg_1[_local_3]));
                _local_3++;
            };
            return (("[" + _local_2) + "]");
        }

        public function getString():String
        {
            return (jsonString);
        }

        private function objectToString(o:Object):String
        {
            var value:Object;
            var key:String;
            var v:XML;
            var s:String = "";
            var classInfo:XML = describeType(o);
            if (classInfo.@name.toString() == "Object")
            {
                for (key in o)
                {
                    value = o[key];
                    if (!(value is Function))
                    {
                        if (s.length > 0)
                        {
                            s = (s + ",");
                        };
                        s = (s + ((escapeString(key) + ":") + convertToString(value)));
                    };
                };
            }
            else
            {
                for each (v in classInfo..*.((name() == "variable") || (name() == "accessor")))
                {
                    if (s.length > 0)
                    {
                        s = (s + ",");
                    };
                    s = (s + ((escapeString(v.@name.toString()) + ":") + convertToString(o[v.@name])));
                };
            };
            return (("{" + s) + "}");
        }

        private function convertToString(_arg_1:*):String
        {
            if ((_arg_1 is String))
            {
                return (escapeString((_arg_1 as String)));
            };
            if ((_arg_1 is Number))
            {
                return ((isFinite((_arg_1 as Number))) ? _arg_1.toString() : "null");
            };
            if ((_arg_1 is Boolean))
            {
                return ((_arg_1) ? "true" : "false");
            };
            if ((_arg_1 is Array))
            {
                return (arrayToString((_arg_1 as Array)));
            };
            if (((_arg_1 is Object) && (!(_arg_1 == null))))
            {
                return (objectToString(_arg_1));
            };
            return ("null");
        }


    }
}//package vk.api.serialization.json

