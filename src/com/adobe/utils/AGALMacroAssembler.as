


//com.adobe.utils.AGALMacroAssembler

package com.adobe.utils
{
    import __AS3__.vec.Vector;
    import flash.utils.Dictionary;
    import com.adobe.utils.macro.AGALPreAssembler;
    import com.adobe.utils.macro.AGALVar;
    import flash.utils.getTimer;
    import flash.utils.ByteArray;
    import __AS3__.vec.*;
    import flash.utils.*;

    public class AGALMacroAssembler extends AGALMiniAssembler 
    {

        private static const REGEXP_LINE_BREAKER:RegExp = /[\f\n\r\v;]+/g;
        private static const COMMENT:RegExp = /\/\/[^\n]*\n/g;
        public static const IDENTIFIER:RegExp = /((2d)|(3d)|[_a-zA-Z])+([_a-zA-Z0-9.]*)/;
        public static const NUMBER:RegExp = /[0-9]+(?:\.[0-9]*)?/;
        public static const OPERATOR:RegExp = /(==)|(!=)|(<=)|(>=)|(&&)|(\|\|)|[*=+-\/()\[\]{}!<>&|]/;
        public static const SEPERATOR:RegExp = /\n/;
        public static const PREPROC:RegExp = /\#[a-z]+/;
        public static const TOKEN:RegExp = new RegExp(((((((((IDENTIFIER.source + "|") + NUMBER.source) + "|") + SEPERATOR.source) + "|") + OPERATOR.source) + "|") + PREPROC.source), "g");
        private static const MACRO:RegExp = /([\w.]+)(\s*)=(\s*)(\w+)(\s*)\(/;
        public static const STDLIB:String = ((((("macro mul3x3( vec, mat ) {" + "\tm33 out, vec, mat; ") + "}") + "macro mul4x4( vec, mat ) {") + "\tm44 out, vec, mat; ") + "}");

        public var asmCode:String = "";
        private var isFrag:Boolean = false;
        public var profile:Boolean = false;
        public var profileTrace:String = "";
        private var stages:Vector.<PerfStage> = null;
        private var macros:Dictionary = new Dictionary();
        public var aliases:Dictionary = new Dictionary();
        private var tokens:Vector.<String> = null;
        private var types:String = "";
        private var preproc:AGALPreAssembler = new AGALPreAssembler();
        private var emptyStringVector:Vector.<String> = new Vector.<String>(0, true);

        public function AGALMacroAssembler(_arg_1:Boolean=false):void
        {
            super(_arg_1);
        }

        public static function joinTokens(_arg_1:Vector.<String>):String
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:* = "";
            var _local_5:uint = _arg_1.length;
            while (_local_2 < _local_5)
            {
                if (_arg_1[_local_2] == "\n")
                {
                    _local_2++;
                }
                else
                {
                    _local_3 = _arg_1.indexOf("\n", (_local_2 + 1));
                    if (_local_3 < 0)
                    {
                        _local_3 = _local_5;
                    };
                    _local_4 = (_local_4 + _arg_1[_local_2++]);
                    if (((_local_2 < _local_5) && (!(_arg_1[_local_2] == "."))))
                    {
                        _local_4 = (_local_4 + " ");
                    };
                    while (_local_2 < _local_3)
                    {
                        _local_4 = (_local_4 + _arg_1[_local_2]);
                        if (_arg_1[_local_2] == ",")
                        {
                            _local_4 = (_local_4 + " ");
                        };
                        _local_2++;
                    };
                    _local_4 = (_local_4 + "\n");
                    _local_2 = (_local_3 + 1);
                };
            };
            return (_local_4);
        }


        private function cleanInput(_arg_1:String):String
        {
            var _local_3:int;
            var _local_2:int = _arg_1.indexOf("/*");
            while (_local_2 >= 0)
            {
                _local_3 = _arg_1.indexOf("*/", (_local_2 + 1));
                if (_local_3 < 0)
                {
                    throw (new Error("Comment end not found."));
                };
                _arg_1 = (_arg_1.substr(0, _local_2) + _arg_1.substr((_local_3 + 2)));
                _local_2 = _arg_1.indexOf("/*");
            };
            _arg_1 = _arg_1.replace(REGEXP_LINE_BREAKER, "\n");
            return (_arg_1.replace(COMMENT, ""));
        }

        private function tokenize(_arg_1:String):Vector.<String>
        {
            return (Vector.<String>(_arg_1.match(TOKEN)));
        }

        private function tokenizeTypes(_arg_1:Vector.<String>):String
        {
            var _local_5:String;
            var _local_2:* = "";
            var _local_3:uint = _arg_1.length;
            var _local_4:uint;
            while (_local_4 < _local_3)
            {
                _local_5 = _arg_1[_local_4];
                if (_local_5.search(IDENTIFIER) == 0)
                {
                    _local_2 = (_local_2 + "i");
                }
                else
                {
                    if (_local_5.search(NUMBER) == 0)
                    {
                        _local_2 = (_local_2 + "0");
                    }
                    else
                    {
                        if (_local_5.search(SEPERATOR) == 0)
                        {
                            _local_2 = (_local_2 + "n");
                        }
                        else
                        {
                            if (_local_5.search(OPERATOR) == 0)
                            {
                                if (_local_5.length == 1)
                                {
                                    _local_2 = (_local_2 + _local_5);
                                }
                                else
                                {
                                    _local_2 = (_local_2 + "2");
                                };
                            }
                            else
                            {
                                if (_local_5.search(PREPROC) == 0)
                                {
                                    _local_2 = (_local_2 + "#");
                                }
                                else
                                {
                                    throw (new Error(("Unrecognized token: " + _arg_1[_local_4])));
                                };
                            };
                        };
                    };
                };
                _local_4++;
            };
            if (_local_2.length != _arg_1.length)
            {
                throw (new Error("Tokens and types must have the same length."));
            };
            return (_local_2);
        }

        private function createMangledName(_arg_1:String, _arg_2:int):String
        {
            return ((_arg_1 + "-") + _arg_2);
        }

        private function splice(_arg_1:int, _arg_2:int, _arg_3:Vector.<String>, _arg_4:String):void
        {
            if (_arg_3 == null)
            {
                _arg_3 = this.emptyStringVector;
            };
            if (_arg_4 == null)
            {
                _arg_4 = "";
            };
            var _local_5:Vector.<String> = this.tokens.slice(0, _arg_1);
            _local_5 = _local_5.concat(_arg_3);
            _local_5 = _local_5.concat(this.tokens.slice((_arg_1 + _arg_2)));
            this.tokens = _local_5;
            this.types = ((this.types.substr(0, _arg_1) + _arg_4) + this.types.substr((_arg_1 + _arg_2)));
            if (this.types.length != this.tokens.length)
            {
                throw (new Error(((("AGAL.splice internal error. types.length=" + this.types.length) + " tokens.length=") + this.tokens.length)));
            };
        }

        private function basicOp(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:String):String
        {
            return ((((((_arg_1 + " ") + _arg_2) + ", ") + _arg_3) + ", ") + _arg_4);
        }

        private function convertMath(_arg_1:int):Boolean
        {
            var _local_5:Vector.<String>;
            var _local_6:String;
            var _local_2:int = this.types.indexOf("n", (_arg_1 + 1));
            if (_local_2 < (_arg_1 + 1))
            {
                throw (new Error("End of expression not found."));
            };
            var _local_3:* = "";
            var _local_4:String = this.types.substr(_arg_1, (_local_2 - _arg_1));
            switch (_local_4)
            {
                case "i=i":
                    _local_3 = ((("mov " + this.tokens[(_arg_1 + 0)]) + ", ") + this.tokens[(_arg_1 + 2)]);
                    break;
                case "i=i+i":
                    _local_3 = this.basicOp("add", this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 2)], this.tokens[(_arg_1 + 4)]);
                    break;
                case "i=i-i":
                    _local_3 = this.basicOp("sub", this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 2)], this.tokens[(_arg_1 + 4)]);
                    break;
                case "i=i*i":
                    _local_3 = this.basicOp("mul", this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 2)], this.tokens[(_arg_1 + 4)]);
                    break;
                case "i=i/i":
                    _local_3 = this.basicOp("div", this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 2)], this.tokens[(_arg_1 + 4)]);
                    break;
                case "i=-i":
                    _local_3 = ((("neg " + this.tokens[(_arg_1 + 0)]) + ", ") + this.tokens[(_arg_1 + 3)]);
                    break;
                case "i*=i":
                    _local_3 = this.basicOp("mul", this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 3)]);
                    break;
                case "i/=i":
                    _local_3 = this.basicOp("div", this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 3)]);
                    break;
                case "i+=i":
                    _local_3 = this.basicOp("add", this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 3)]);
                    break;
                case "i-=i":
                    _local_3 = this.basicOp("sub", this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 3)]);
                    break;
                case "i=i*i+i":
                    _local_3 = ((this.basicOp("mul", this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 2)], this.tokens[(_arg_1 + 4)]) + "\n") + this.basicOp("add", this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 6)]));
                    break;
                case "i=i+i*i":
                    _local_3 = ((this.basicOp("mul", this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 4)], this.tokens[(_arg_1 + 6)]) + "\n") + this.basicOp("add", this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 0)], this.tokens[(_arg_1 + 2)]));
                    break;
                default:
                    return (false);
            };
            if (_local_3.length > 0)
            {
                _local_5 = this.tokenize(_local_3);
                _local_6 = this.tokenizeTypes(_local_5);
                this.splice(_arg_1, (_local_2 - _arg_1), _local_5, _local_6);
            };
            return (true);
        }

        private function processMacro(_arg_1:int):void
        {
            var _local_2:int = 1;
            var _local_3:int = 2;
            var _local_4:int = 3;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            if (this.tokens[_arg_1] != "macro")
            {
                throw (new Error("Expected 'macro' not found."));
            };
            _local_5 = (_arg_1 + _local_3);
            if (this.tokens[_local_5] != "(")
            {
                throw (new Error("Macro open paren not found."));
            };
            _local_6 = this.types.indexOf(")", (_local_5 + 1));
            _local_7 = this.types.indexOf("{", (_local_6 + 1));
            _local_8 = this.types.indexOf("}", (_local_7 + 1));
            var _local_10:Macro = new Macro();
            _local_10.name = this.tokens[(_arg_1 + _local_2)];
            var _local_11:int;
            _local_9 = (_local_5 + 1);
            while (_local_9 < _local_6)
            {
                if (this.types.charAt(_local_9) == "i")
                {
                    _local_10.args.push(this.tokens[_local_9]);
                    _local_11++;
                };
                _local_9++;
            };
            _local_10.mangledName = this.createMangledName(_local_10.name, _local_11);
            _local_9 = (_local_7 + 1);
            while (_local_9 < _local_8)
            {
                _local_10.body.push(this.tokens[_local_9]);
                _local_9++;
            };
            _local_10.types = this.types.substr((_local_7 + 1), ((_local_8 - _local_7) - 1));
            this.splice(_arg_1, ((_local_8 - _arg_1) + 1), this.emptyStringVector, "");
            this.macros[_local_10.mangledName] = _local_10;
        }

        private function expandTexture(_arg_1:int):int
        {
            var _local_2:int = this.types.indexOf("(", _arg_1);
            var _local_3:int = this.types.indexOf(")", (_local_2 + 1));
            var _local_4:int = this.types.indexOf("<", _arg_1);
            var _local_5:int = this.types.indexOf(">", (_local_4 + 1));
            var _local_6:int = this.types.indexOf("n", _arg_1);
            if (_local_6 < 0)
            {
                _local_6 = this.types.length;
            };
            var _local_7:* = (((((((("tex " + this.tokens[_arg_1]) + ",") + this.tokens[(_local_2 + 1)]) + ",") + this.tokens[(_local_2 + 3)]) + "<") + this.tokens.slice((_local_4 + 1), _local_5).join("")) + ">;");
            var _local_8:Vector.<String> = this.tokenize(_local_7);
            var _local_9:String = this.tokenizeTypes(_local_8);
            this.splice(_arg_1, (_local_6 - _arg_1), _local_8, _local_9);
            return (_arg_1 + _local_9.length);
        }

        private function expandMacro(_arg_1:int):void
        {
            var _local_14:Boolean;
            var _local_15:int;
            var _local_2:int = 2;
            var _local_3:int = 3;
            var _local_4:int;
            var _local_5:uint;
            var _local_6:String = this.tokens[(_arg_1 + _local_2)];
            _local_4 = (this.types.indexOf(")", (_arg_1 + _local_3)) - _arg_1);
            var _local_7:int = int(((_local_4 - _local_3) / 2));
            var _local_8:String = this.createMangledName(_local_6, _local_7);
            if (this.macros[_local_8] == null)
            {
                throw (new Error((("Macro '" + _local_8) + "' not found.")));
            };
            var _local_9:Macro = this.macros[_local_8];
            var _local_10:String = this.tokens[_arg_1];
            var _local_11:Vector.<String> = this.tokens.slice(((_arg_1 + _local_3) + 1), (_arg_1 + _local_4));
            var _local_12:Vector.<String> = new Vector.<String>();
            var _local_13:uint = _local_9.body.length;
            _local_5 = 0;
            while (_local_5 < _local_13)
            {
                _local_14 = false;
                if (_local_9.types.charAt(_local_5) == "i")
                {
                    if (_local_9.body[_local_5].substr(0, 3) == "out")
                    {
                        _local_12.push((_local_10 + _local_9.body[_local_5].substr(3)));
                        _local_14 = true;
                    }
                    else
                    {
                        _local_15 = _local_9.args.indexOf(_local_9.body[_local_5]);
                        if (_local_15 >= 0)
                        {
                            _local_12.push(_local_11[(2 * _local_15)]);
                            _local_14 = true;
                        };
                    };
                };
                if (!_local_14)
                {
                    _local_12.push(_local_9.body[_local_5]);
                };
                _local_5++;
            };
            this.splice(_arg_1, (_local_4 + 1), _local_12, _local_9.types);
        }

        private function getConstant(_arg_1:String):String
        {
            var _local_3:AGALVar;
            var _local_2:Number = Number(_arg_1);
            for each (_local_3 in this.aliases)
            {
                if (_local_3.isConstant())
                {
                    if (_local_3.x == _local_2)
                    {
                        return (_local_3.target + ".x");
                    };
                    if (_local_3.y == _local_2)
                    {
                        return (_local_3.target + ".y");
                    };
                    if (_local_3.z == _local_2)
                    {
                        return (_local_3.target + ".z");
                    };
                    if (_local_3.w == _local_2)
                    {
                        return (_local_3.target + ".w");
                    };
                };
            };
            throw (new Error("Numeric constant used that is not declared in a constant register."));
        }

        private function readAlias(_arg_1:int):void
        {
            var _local_2:AGALVar;
            var _local_3:int;
            if (this.tokens[_arg_1] == "alias")
            {
                _local_2 = new AGALVar();
                _local_2.name = this.tokens[(_arg_1 + 3)];
                _local_2.target = this.tokens[(_arg_1 + 1)];
                this.aliases[_local_2.name] = _local_2;
                if (this.tokens[(_arg_1 + 4)] == "(")
                {
                    _local_3 = this.tokens.indexOf(")", (_arg_1 + 5));
                    if (_local_3 < 0)
                    {
                        throw (new Error("Closing paren of default alias value not found."));
                    };
                    _local_2.x = 0;
                    _local_2.y = 0;
                    _local_2.z = 0;
                    _local_2.w = 0;
                    if (_local_3 > (_arg_1 + 5))
                    {
                        _local_2.x = Number(this.tokens[(_arg_1 + 5)]);
                    };
                    if (_local_3 > (_arg_1 + 7))
                    {
                        _local_2.y = Number(this.tokens[(_arg_1 + 7)]);
                    };
                    if (_local_3 > (_arg_1 + 9))
                    {
                        _local_2.z = Number(this.tokens[(_arg_1 + 9)]);
                    };
                    if (_local_3 > (_arg_1 + 11))
                    {
                        _local_2.w = Number(this.tokens[(_arg_1 + 11)]);
                    };
                };
            };
        }

        private function processTokens(_arg_1:int, _arg_2:int):int
        {
            var _local_5:String;
            var _local_6:int;
            var _local_7:AGALVar;
            var _local_3:int;
            if (((this.types.length >= 4) && (this.types.substr(_arg_1, 4) == "i=i(")))
            {
                this.expandMacro(_arg_1);
                return (_arg_1);
            };
            if ((((this.types.length >= 4) && (this.types.substr(_arg_1, 4) == "i=i<")) && (this.tokens[(_arg_1 + 2)] == "tex")))
            {
                return (this.expandTexture(_arg_1));
            };
            if (this.tokens[_arg_1] == "alias")
            {
                this.readAlias(_arg_1);
                this.splice(_arg_1, ((_arg_2 - _arg_1) + 1), null, null);
                return (_arg_1);
            };
            if (this.tokens[_arg_1] == "macro")
            {
                this.processMacro(_arg_1);
                return (_arg_1);
            };
            var _local_4:int = _arg_1;
            while (_local_4 < _arg_2)
            {
                _local_5 = this.types.charAt(_local_4);
                if (_local_5 == "[")
                {
                    _local_3++;
                }
                else
                {
                    if (_local_5 == "]")
                    {
                        _local_3--;
                    }
                    else
                    {
                        if (_local_5 == "0")
                        {
                            if (_local_3 == 0)
                            {
                                this.tokens[_local_4] = this.getConstant(this.tokens[_local_4]);
                                this.types = ((this.types.substr(0, _local_4) + "i") + this.types.substr((_local_4 + 1)));
                            };
                        }
                        else
                        {
                            if (_local_5 == "i")
                            {
                                _local_6 = this.tokens[_local_4].indexOf(".");
                                if (_local_6 < 0)
                                {
                                    _local_6 = this.tokens[_local_4].length;
                                };
                                _local_7 = this.aliases[this.tokens[_local_4].substr(0, _local_6)];
                                if (_local_7 != null)
                                {
                                    this.tokens[_local_4] = (_local_7.target + this.tokens[_local_4].substr(_local_6));
                                };
                            };
                        };
                    };
                };
                _local_4++;
            };
            if (this.convertMath(_arg_1))
            {
                _arg_2 = this.types.indexOf("n", (_arg_1 + 1));
                if (_arg_2 < 0)
                {
                    _arg_2 = this.types.length;
                };
            };
            return (_arg_2 + 1);
        }

        private function mainLoop():void
        {
            var _local_4:String;
            var _local_1:int;
            var _local_2:int;
            var _local_3:Boolean = true;
            while (_local_1 < this.tokens.length)
            {
                while (((_local_1 < this.tokens.length) && (this.types.charAt(_local_1) == "n")))
                {
                    _local_1++;
                };
                if (_local_1 == this.tokens.length) break;
                _local_2 = this.types.indexOf("n", (_local_1 + 1));
                if (_local_2 < 0)
                {
                    _local_2 = this.types.length;
                };
                _local_4 = this.types.charAt(_local_1);
                if (_local_4 == "#")
                {
                    if (this.preproc == null)
                    {
                        this.preproc = new AGALPreAssembler();
                    };
                    _local_3 = this.preproc.processLine(this.tokens.slice(_local_1, _local_2), this.types.substr(_local_1, (_local_2 - _local_1)));
                    this.splice(_local_1, ((_local_2 - _local_1) + 1), null, null);
                }
                else
                {
                    if (_local_3)
                    {
                        _local_1 = this.processTokens(_local_1, _local_2);
                    }
                    else
                    {
                        this.splice(_local_1, ((_local_2 - _local_1) + 1), null, null);
                    };
                };
            };
        }

        override public function assemble(_arg_1:String, _arg_2:String):ByteArray
        {
            var _local_4:uint;
            var _local_5:int;
            var _local_6:String;
            if (this.profile)
            {
                _local_4 = getTimer();
                this.stages = new Vector.<PerfStage>();
                this.stages.push(new PerfStage("start"));
            };
            this.isFrag = (_arg_1 == "fragment");
            _arg_2 = (STDLIB + _arg_2);
            this.aliases = new Dictionary();
            _arg_2 = this.cleanInput(_arg_2);
            this.tokens = this.tokenize(_arg_2);
            this.types = this.tokenizeTypes(this.tokens);
            this.mainLoop();
            if (this.profile)
            {
                this.stages.push(new PerfStage("join"));
            };
            this.asmCode = joinTokens(this.tokens);
            if (this.profile)
            {
                this.stages.push(new PerfStage("mini"));
            };
            var _local_3:ByteArray = super.assemble(_arg_1, this.asmCode);
            if (this.profile)
            {
                this.stages.push(new PerfStage("end"));
                _local_5 = 0;
                while (_local_5 < (this.stages.length - 1))
                {
                    _local_6 = ((((this.stages[_local_5].name + " --> ") + this.stages[(_local_5 + 1)].name) + " = ") + ((this.stages[(_local_5 + 1)].time - this.stages[_local_5].time) / 1000));
                    trace(_local_6);
                    this.profileTrace = (this.profileTrace + (_local_6 + "\n"));
                    _local_5++;
                };
            };
            return (_local_3);
        }


    }
}//package com.adobe.utils

import __AS3__.vec.Vector;
import com.adobe.utils.AGALMacroAssembler;
import flash.utils.getTimer;
import __AS3__.vec.*;

class Macro 
{

    public var mangledName:String = "";
    public var name:String = "";
    public var args:Vector.<String> = new Vector.<String>();
    public var body:Vector.<String> = new Vector.<String>();
    public var types:String = "";


    public function traceMacro():void
    {
        trace((((("Macro: " + this.name) + " [") + this.mangledName) + "]"));
        trace(("  args: " + this.args));
        trace("<==");
        var _local_1:String = AGALMacroAssembler.joinTokens(this.body);
        trace(_local_1);
        trace("==>");
    }


}

class PerfStage 
{

    public var name:String;
    public var time:uint;

    public function PerfStage(_arg_1:String)
    {
        this.name = _arg_1;
        this.time = getTimer();
    }

}


