


//com.adobe.serialization.json.JSONTokenizer

package com.adobe.serialization.json
{
    public class JSONTokenizer 
    {

        private var strict:Boolean;
        private var obj:Object;
        private var jsonString:String;
        private var loc:int;
        private var ch:String;
        private  const controlCharsRegExp:RegExp = /[\x00-\x1F]/;

        public function JSONTokenizer(s:String, strict:Boolean)
        {
            jsonString = s;
            strict = strict;
            loc = 0;
            nextChar();
        }

        public function getNextToken():JSONToken
        {
            var token:JSONToken = new JSONToken();
            skipIgnored();
            switch (ch)
            {
                case "{":
                    token.type = JSONTokenType.LEFT_BRACE;
                    token.value = "{";
                    nextChar();
                    break;
                case "}":
                    token.type = JSONTokenType.RIGHT_BRACE;
                    token.value = "}";
                    nextChar();
                    break;
                case "[":
                    token.type = JSONTokenType.LEFT_BRACKET;
                    token.value = "[";
                    nextChar();
                    break;
                case "]":
                    token.type = JSONTokenType.RIGHT_BRACKET;
                    token.value = "]";
                    nextChar();
                    break;
                case ",":
                    token.type = JSONTokenType.COMMA;
                    token.value = ",";
                    nextChar();
                    break;
                case ":":
                    token.type = JSONTokenType.COLON;
                    token.value = ":";
                    nextChar();
                    break;
                case "t":
                    var possibleTrue:String = "t" + nextChar() + nextChar() + nextChar();
                    if (possibleTrue == "true")
                    {
                        token.type = JSONTokenType.TRUE;
                        token.value = true;
                        nextChar();
                    }
                    else
                    {
                        parseError("Expecting 'true' but found " + possibleTrue);
                    }
                    break;
                case "f":
                    var possibleFalse:String = "f" + nextChar() + nextChar() + nextChar() + nextChar();
                    if (possibleFalse == "false")
                    {
                        token.type = JSONTokenType.FALSE;
                        token.value = false;
                        nextChar();
                    }
                    else
                    {
                        parseError("Expecting 'false' but found " + possibleFalse);
                    }
                    break;
                case "n":
                    var possibleNull:String = "n" + nextChar() + nextChar() + nextChar();
                    if (possibleNull == "null")
                    {
                        token.type = JSONTokenType.NULL;
                        token.value = null;
                        nextChar();
                    }
                    else
                    {
                        parseError("Expecting 'null' but found " + possibleNull);
                    }
                    break;
                case "N":
                    var possibleNaN:String = "N" + nextChar() + nextChar();
                    if (possibleNaN == "NaN")
                    {
                        token.type = JSONTokenType.NAN;
                        token.value = NaN;
                        nextChar();
                    }
                    else
                    {
                        parseError("Expecting 'NaN' but found " + possibleNaN);
                    };
                    break;
                case '"':
                    token = readString();
                    break;
                default:
                    if ( isDigit( ch ) || ch == '-' )
                    {
                        token = readNumber();
                    }
                    else if (ch == '')
                    {
                        return null;
                    }
					else
					{
                        parseError( "Unexpected " + ch + " encountered" );
                    }
            };
            return token;
        }

        private function readString():JSONToken
        {
            var _local_3:int;
            var _local_4:int;
            var _local_1:int = this.loc;
            do 
            {
                _local_1 = this.jsonString.indexOf('"', _local_1);
                if (_local_1 >= 0)
                {
                    _local_3 = 0;
                    _local_4 = (_local_1 - 1);
                    while (this.jsonString.charAt(_local_4) == "\\")
                    {
                        _local_3++;
                        _local_4--;
                    };
                    if ((_local_3 % 2) == 0) break;
                    _local_1++;
                }
                else
                {
                    this.parseError("Unterminated string literal");
                };
            } while (true);
            var _local_2:JSONToken = new JSONToken();
            _local_2.type = JSONTokenType.STRING;
            _local_2.value = this.unescapeString(this.jsonString.substr(this.loc, (_local_1 - this.loc)));
            this.loc = (_local_1 + 1);
            this.nextChar();
            return (_local_2);
        }

        public function unescapeString(_arg_1:String):String
        {
            var _local_6:int;
            var _local_7:String;
            var _local_8:String;
            var _local_9:int;
            var _local_10:String;
            if (((this.strict) && (this.controlCharsRegExp.test(_arg_1))))
            {
                this.parseError("String contains unescaped control character (0x00-0x1F)");
            };
            var _local_2:* = "";
            var _local_3:int;
            var _local_4:int;
            var _local_5:int = _arg_1.length;
            do 
            {
                _local_3 = _arg_1.indexOf("\\", _local_4);
                if (_local_3 >= 0)
                {
                    _local_2 = (_local_2 + _arg_1.substr(_local_4, (_local_3 - _local_4)));
                    _local_4 = (_local_3 + 2);
                    _local_6 = (_local_3 + 1);
                    _local_7 = _arg_1.charAt(_local_6);
                    switch (_local_7)
                    {
                        case '"':
                            _local_2 = (_local_2 + '"');
                            break;
                        case "\\":
                            _local_2 = (_local_2 + "\\");
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
                            _local_8 = "";
                            if ((_local_4 + 4) > _local_5)
                            {
                                this.parseError("Unexpected end of input.  Expecting 4 hex digits after \\u.");
                            };
                            _local_9 = _local_4;
                            while (_local_9 < (_local_4 + 4))
                            {
                                _local_10 = _arg_1.charAt(_local_9);
                                if (!this.isHexDigit(_local_10))
                                {
                                    this.parseError(("Excepted a hex digit, but found: " + _local_10));
                                };
                                _local_8 = (_local_8 + _local_10);
                                _local_9++;
                            };
                            _local_2 = (_local_2 + String.fromCharCode(parseInt(_local_8, 16)));
                            _local_4 = (_local_4 + 4);
                            break;
                        case "f":
                            _local_2 = (_local_2 + "\f");
                            break;
                        case "/":
                            _local_2 = (_local_2 + "/");
                            break;
                        case "b":
                            _local_2 = (_local_2 + "\b");
                            break;
                        default:
                            _local_2 = (_local_2 + ("\\" + _local_7));
                    };
                }
                else
                {
                    _local_2 = (_local_2 + _arg_1.substr(_local_4));
                    break;
                };
            } while (_local_4 < _local_5);
            return (_local_2);
        }

        private function readNumber():JSONToken
        {
            var _local_3:JSONToken;
            var _local_1:* = "";
            if (this.ch == "-")
            {
                _local_1 = (_local_1 + "-");
                this.nextChar();
            };
            if (!this.isDigit(this.ch))
            {
                this.parseError("Expecting a digit");
            };
            if (this.ch == "0")
            {
                _local_1 = (_local_1 + this.ch);
                this.nextChar();
                if (this.isDigit(this.ch))
                {
                    this.parseError("A digit cannot immediately follow 0");
                }
                else
                {
                    if (((!(this.strict)) && (this.ch == "x")))
                    {
                        _local_1 = (_local_1 + this.ch);
                        this.nextChar();
                        if (this.isHexDigit(this.ch))
                        {
                            _local_1 = (_local_1 + this.ch);
                            this.nextChar();
                        }
                        else
                        {
                            this.parseError('Number in hex format require at least one hex digit after "0x"');
                        };
                        while (this.isHexDigit(this.ch))
                        {
                            _local_1 = (_local_1 + this.ch);
                            this.nextChar();
                        };
                    };
                };
            }
            else
            {
                while (this.isDigit(this.ch))
                {
                    _local_1 = (_local_1 + this.ch);
                    this.nextChar();
                };
            };
            if (this.ch == ".")
            {
                _local_1 = (_local_1 + ".");
                this.nextChar();
                if (!this.isDigit(this.ch))
                {
                    this.parseError("Expecting a digit");
                };
                while (this.isDigit(this.ch))
                {
                    _local_1 = (_local_1 + this.ch);
                    this.nextChar();
                };
            };
            if (((this.ch == "e") || (this.ch == "E")))
            {
                _local_1 = (_local_1 + "e");
                this.nextChar();
                if (((this.ch == "+") || (this.ch == "-")))
                {
                    _local_1 = (_local_1 + this.ch);
                    this.nextChar();
                };
                if (!this.isDigit(this.ch))
                {
                    this.parseError("Scientific notation number needs exponent value");
                };
                while (this.isDigit(this.ch))
                {
                    _local_1 = (_local_1 + this.ch);
                    this.nextChar();
                };
            };
            var _local_2:Number = Number(_local_1);
            if (((isFinite(_local_2)) && (!(isNaN(_local_2)))))
            {
                _local_3 = new JSONToken();
                _local_3.type = JSONTokenType.NUMBER;
                _local_3.value = _local_2;
                return (_local_3);
            };
            this.parseError((("Number " + _local_2) + " is not valid!"));
            return (null);
        }

        private function nextChar():String
        {
            return (this.ch = this.jsonString.charAt(this.loc++));
        }

        private function skipIgnored():void
        {
            var _local_1:int;
            do 
            {
                _local_1 = this.loc;
                this.skipWhite();
                this.skipComments();
            } while (_local_1 != this.loc);
        }

        private function skipComments():void
        {
            if (this.ch == "/")
            {
                this.nextChar();
                switch (this.ch)
                {
                    case "/":
                        do 
                        {
                            this.nextChar();
                        } while (((!(this.ch == "\n")) && (!(this.ch == ""))));
                        this.nextChar();
                        return;
                    case "*":
                        this.nextChar();
                        while (true)
                        {
                            if (this.ch == "*")
                            {
                                this.nextChar();
                                if (this.ch == "/")
                                {
                                    this.nextChar();
                                    break;
                                };
                            }
                            else
                            {
                                this.nextChar();
                            };
                            if (this.ch == "")
                            {
                                this.parseError("Multi-line comment not closed");
                            };
                        };
                        return;
                    default:
                        this.parseError((("Unexpected " + this.ch) + " encountered (expecting '/' or '*' )"));
                };
            };
        }

        private function skipWhite():void
        {
            while (this.isWhiteSpace(this.ch))
            {
                this.nextChar();
            };
        }

        private function isWhiteSpace(_arg_1:String):Boolean
        {
            if (((((_arg_1 == " ") || (_arg_1 == "\t")) || (_arg_1 == "\n")) || (_arg_1 == "\r")))
            {
                return (true);
            };
            if (((!(this.strict)) && (_arg_1.charCodeAt(0) == 160)))
            {
                return (true);
            };
            return (false);
        }

        private function isDigit(_arg_1:String):Boolean
        {
            return ((_arg_1 >= "0") && (_arg_1 <= "9"));
        }

        private function isHexDigit(_arg_1:String):Boolean
        {
            return (((this.isDigit(_arg_1)) || ((_arg_1 >= "A") && (_arg_1 <= "F"))) || ((_arg_1 >= "a") && (_arg_1 <= "f")));
        }

        public function parseError(_arg_1:String):void
        {
            throw (new JSONParseError(_arg_1, this.loc, this.jsonString));
        }


    }
}//package com.adobe.serialization.json

