


//com.adobe.utils.macro.AGALPreAssembler

package com.adobe.utils.macro
{
    import __AS3__.vec.Vector;

    public class AGALPreAssembler 
    {

        public static const TRACE_VM:Boolean = false;
        public static const TRACE_AST:Boolean = false;
        public static const TRACE_PREPROC:Boolean = false;

        private var vm:VM = new VM();
        private var expressionParser:ExpressionParser = new ExpressionParser();


        public function processLine(_arg_1:Vector.<String>, _arg_2:String):Boolean
        {
            var _local_4:Number;
            var _local_6:Number;
            var _local_3:* = "";
            var _local_5:Expression;
            var _local_7:int;
            if (_arg_2.charAt(_local_7) == "#")
            {
                _local_3 = "";
                _local_4 = Number.NaN;
                if (_arg_1[_local_7] == "#define")
                {
                    if (((_arg_2.length >= 3) && (_arg_2.substr(_local_7, 3) == "#in")))
                    {
                        _local_3 = _arg_1[(_local_7 + 1)];
                        this.vm.vars[_local_3] = Number.NaN;
                        if (TRACE_PREPROC)
                        {
                            trace("#define #i");
                        };
                        _local_7 = (_local_7 + 3);
                    }
                    else
                    {
                        if (((_arg_2.length >= 3) && (_arg_2.substr(_local_7, 3) == "#i=")))
                        {
                            _local_5 = this.expressionParser.parse(_arg_1.slice(3), _arg_2.substr(3));
                            _local_5.exec(this.vm);
                            _local_6 = this.vm.stack.pop();
                            _local_3 = _arg_1[(_local_7 + 1)];
                            this.vm.vars[_local_3] = _local_6;
                            if (TRACE_PREPROC)
                            {
                                trace(((("#define= " + _local_3) + "=") + _local_6));
                            };
                        }
                        else
                        {
                            _local_5 = this.expressionParser.parse(_arg_1.slice(2), _arg_2.substr(2));
                            _local_5.exec(this.vm);
                            _local_6 = this.vm.stack.pop();
                            _local_3 = _arg_1[(_local_7 + 1)];
                            this.vm.vars[_local_3] = _local_6;
                            if (TRACE_PREPROC)
                            {
                                trace(((("#define " + _local_3) + "=") + _local_6));
                            };
                        };
                    };
                }
                else
                {
                    if (_arg_1[_local_7] == "#undef")
                    {
                        _local_3 = _arg_1[(_local_7 + 1)];
                        this.vm.vars[_local_3] = null;
                        if (TRACE_PREPROC)
                        {
                            trace("#undef");
                        };
                        _local_7 = (_local_7 + 3);
                    }
                    else
                    {
                        if (_arg_1[_local_7] == "#if")
                        {
                            _local_7++;
                            _local_5 = this.expressionParser.parse(_arg_1.slice(1), _arg_2.substr(1));
                            this.vm.pushIf();
                            _local_5.exec(this.vm);
                            _local_6 = this.vm.stack.pop();
                            this.vm.setIf(_local_6);
                            if (TRACE_PREPROC)
                            {
                                trace(("#if " + ((_local_6) ? "true" : "false")));
                            };
                        }
                        else
                        {
                            if (_arg_1[_local_7] == "#elif")
                            {
                                _local_7++;
                                _local_5 = this.expressionParser.parse(_arg_1.slice(1), _arg_2.substr(1));
                                _local_5.exec(this.vm);
                                _local_6 = this.vm.stack.pop();
                                this.vm.setIf(_local_6);
                                if (TRACE_PREPROC)
                                {
                                    trace(("#elif " + ((_local_6) ? "true" : "false")));
                                };
                            }
                            else
                            {
                                if (_arg_1[_local_7] == "#else")
                                {
                                    _local_7++;
                                    this.vm.setIf(((this.vm.ifWasTrue()) ? 0 : 1));
                                    if (TRACE_PREPROC)
                                    {
                                        trace(("#else " + ((this.vm.ifWasTrue()) ? "true" : "false")));
                                    };
                                }
                                else
                                {
                                    if (_arg_1[_local_7] == "#endif")
                                    {
                                        this.vm.popEndif();
                                        _local_7++;
                                        if (TRACE_PREPROC)
                                        {
                                            trace("#endif");
                                        };
                                    }
                                    else
                                    {
                                        throw (new Error("unrecognize processor directive."));
                                    };
                                };
                            };
                        };
                    };
                };
                while (((_local_7 < _arg_2.length) && (_arg_2.charAt(_local_7) == "n")))
                {
                    _local_7++;
                };
            }
            else
            {
                throw (new Error("PreProcessor called without pre processor directive."));
            };
            return (this.vm.ifIsTrue());
        }


    }
}//package com.adobe.utils.macro

