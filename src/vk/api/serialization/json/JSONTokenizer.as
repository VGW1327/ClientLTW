


//vk.api.serialization.json.JSONTokenizer

package vk.api.serialization.json
{
    public class JSONTokenizer 
    {

        private var loc:int;
        private var ch:String;
        private var obj:Object;
        private var jsonString:String;

        public function JSONTokenizer(_arg_1:String)
        {
            jsonString = _arg_1;
            loc = 0;
            nextChar();
        }

        private function skipComments():void
        {
            if (ch == "/")
            {
                nextChar();
                switch (ch)
                {
                    case "/":
                        do 
                        {
                            nextChar();
                        } while (((!(ch == "\n")) && (!(ch == ""))));
                        nextChar();
                        return;
                    case "*":
                        nextChar();
                        while (true)
                        {
                            if (ch == "*")
                            {
                                nextChar();
                                if (ch == "/")
                                {
                                    nextChar();
                                    break;
                                };
                            }
                            else
                            {
                                nextChar();
                            };
                            if (ch == "")
                            {
                                parseError("Multi-line comment not closed");
                            };
                        };
                        return;
                    default:
                        parseError((("Unexpected " + ch) + " encountered (expecting '/' or '*' )"));
                };
            };
        }

        private function isDigit(_arg_1:String):Boolean
        {
            return ((_arg_1 >= "0") && (_arg_1 <= "9"));
        }

        private function readString():JSONToken
        {
            var _local_3:String;
            var _local_4:int;
            var _local_1:JSONToken = new JSONToken();
            _local_1.type = JSONTokenType.STRING;
            var _local_2:* = "";
            nextChar();
            while (((!(ch == '"')) && (!(ch == ""))))
            {
                if (ch == "\\")
                {
                    nextChar();
                    switch (ch)
                    {
                        case '"':
                            _local_2 = (_local_2 + '"');
                            break;
                        case "/":
                            _local_2 = (_local_2 + "/");
                            break;
                        case "\\":
                            _local_2 = (_local_2 + "\\");
                            break;
                        case "b":
                            _local_2 = (_local_2 + "\b");
                            break;
                        case "f":
                            _local_2 = (_local_2 + "\f");
                            break;
                        case "n":
                            _local_2 = (_local_2 + "\n");
                            break;
                        case "r":
                            _local_2 = (_local_2 + "\r");
                            break;
                        case "t":
                            _local_2 = (_local_2 + "\t");
                            break;
                        case "u":
                            _local_3 = "";
                            _local_4 = 0;
                            while (_local_4 < 4)
                            {
                                if (!isHexDigit(nextChar()))
                                {
                                    parseError((" Excepted a hex digit, but found: " + ch));
                                };
                                _local_3 = (_local_3 + ch);
                                _local_4++;
                            };
                            _local_2 = (_local_2 + String.fromCharCode(parseInt(_local_3, 16)));
                            break;
                        default:
                            _local_2 = (_local_2 + ("\\" + ch));
                    };
                }
                else
                {
                    _local_2 = (_local_2 + ch);
                };
                nextChar();
            };
            if (ch == "")
            {
                parseError("Unterminated string literal");
            };
            nextChar();
            _local_1.value = _local_2;
            return (_local_1);
        }

        private function nextChar():String
        {
            return (ch = jsonString.charAt(loc++));
        }

        public function getNextToken():JSONToken
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:String;
            var _local_1:JSONToken = new JSONToken();
            skipIgnored();
            switch (ch)
            {
                case "{":
                    _local_1.type = JSONTokenType.LEFT_BRACE;
                    _local_1.value = "{";
                    nextChar();
                    break;
                case "}":
                    _local_1.type = JSONTokenType.RIGHT_BRACE;
                    _local_1.value = "}";
                    nextChar();
                    break;
                case "[":
                    _local_1.type = JSONTokenType.LEFT_BRACKET;
                    _local_1.value = "[";
                    nextChar();
                    break;
                case "]":
                    _local_1.type = JSONTokenType.RIGHT_BRACKET;
                    _local_1.value = "]";
                    nextChar();
                    break;
                case ",":
                    _local_1.type = JSONTokenType.COMMA;
                    _local_1.value = ",";
                    nextChar();
                    break;
                case ":":
                    _local_1.type = JSONTokenType.COLON;
                    _local_1.value = ":";
                    nextChar();
                    break;
                case "t":
                    _local_2 = ((("t" + nextChar()) + nextChar()) + nextChar());
                    if (_local_2 == "true")
                    {
                        _local_1.type = JSONTokenType.TRUE;
                        _local_1.value = true;
                        nextChar();
                    }
                    else
                    {
                        parseError(("Expecting 'true' but found " + _local_2));
                    };
                    break;
                case "f":
                    _local_3 = (((("f" + nextChar()) + nextChar()) + nextChar()) + nextChar());
                    if (_local_3 == "false")
                    {
                        _local_1.type = JSONTokenType.FALSE;
                        _local_1.value = false;
                        nextChar();
                    }
                    else
                    {
                        parseError(("Expecting 'false' but found " + _local_3));
                    };
                    break;
                case "n":
                    _local_4 = ((("n" + nextChar()) + nextChar()) + nextChar());
                    if (_local_4 == "null")
                    {
                        _local_1.type = JSONTokenType.NULL;
                        _local_1.value = null;
                        nextChar();
                    }
                    else
                    {
                        parseError(("Expecting 'null' but found " + _local_4));
                    };
                    break;
                case '"':
                    _local_1 = readString();
                    break;
                default:
                    if (((isDigit(ch)) || (ch == "-")))
                    {
                        _local_1 = readNumber();
                    }
                    else
                    {
                        if (ch == "")
                        {
                            return (null);
                        };
                        parseError((("Unexpected " + ch) + " encountered"));
                    };
            };
            return (_local_1);
        }

        private function skipWhite():void
        {
            while (isWhiteSpace(ch))
            {
                nextChar();
            };
        }

        public function parseError(_arg_1:String):void
        {
            throw (new JSONParseError(_arg_1, loc, jsonString));
        }

        private function isWhiteSpace(_arg_1:String):Boolean
        {
            return (((_arg_1 == " ") || (_arg_1 == "\t")) || (_arg_1 == "\n"));
        }

        private function skipIgnored():void
        {
            skipWhite();
            skipComments();
            skipWhite();
        }

        private function isHexDigit(_arg_1:String):Boolean
        {
            var _local_2:String = _arg_1.toUpperCase();
            return ((isDigit(_arg_1)) || ((_local_2 >= "A") && (_local_2 <= "F")));
        }

        private function readNumber():JSONToken
        {
            var _local_1:JSONToken = new JSONToken();
            _local_1.type = JSONTokenType.NUMBER;
            var _local_2:* = "";
            if (ch == "-")
            {
                _local_2 = (_local_2 + "-");
                nextChar();
            };
            if (!isDigit(ch))
            {
                parseError("Expecting a digit");
            };
            if (ch == "0")
            {
                _local_2 = (_local_2 + ch);
                nextChar();
                if (isDigit(ch))
                {
                    parseError("A digit cannot immediately follow 0");
                };
            }
            else
            {
                while (isDigit(ch))
                {
                    _local_2 = (_local_2 + ch);
                    nextChar();
                };
            };
            if (ch == ".")
            {
                _local_2 = (_local_2 + ".");
                nextChar();
                if (!isDigit(ch))
                {
                    parseError("Expecting a digit");
                };
                while (isDigit(ch))
                {
                    _local_2 = (_local_2 + ch);
                    nextChar();
                };
            };
            if (((ch == "e") || (ch == "E")))
            {
                _local_2 = (_local_2 + "e");
                nextChar();
                if (((ch == "+") || (ch == "-")))
                {
                    _local_2 = (_local_2 + ch);
                    nextChar();
                };
                if (!isDigit(ch))
                {
                    parseError("Scientific notation number needs exponent value");
                };
                while (isDigit(ch))
                {
                    _local_2 = (_local_2 + ch);
                    nextChar();
                };
            };
            var _local_3:Number = Number(_local_2);
            if (((isFinite(_local_3)) && (!(isNaN(_local_3)))))
            {
                _local_1.value = _local_3;
                return (_local_1);
            };
            parseError((("Number " + _local_3) + " is not valid!"));
            return (null);
        }


    }
}//package vk.api.serialization.json

