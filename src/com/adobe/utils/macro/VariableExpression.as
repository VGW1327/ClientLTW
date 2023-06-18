


//com.adobe.utils.macro.VariableExpression

package com.adobe.utils.macro
{
    import com.adobe.utils.macro.Expression;
    import com.adobe.utils.macro.AGALPreAssembler;
    import com.adobe.utils.macro.VM;
    import com.adobe.utils.macro.*;

    internal class VariableExpression extends Expression 
    {

        public var name:String;

        public function VariableExpression(_arg_1:String)
        {
            this.name = _arg_1;
        }

        override public function print(_arg_1:int):void
        {
            trace(((spaces(_arg_1) + "variable=") + this.name));
        }

        override public function exec(_arg_1:VM):void
        {
            if (AGALPreAssembler.TRACE_VM)
            {
                trace(((("::VariableExpression push var " + this.name) + " value ") + _arg_1.vars[this.name]));
            };
            if (isNaN(_arg_1.vars[this.name]))
            {
                throw (new Error(("VariableExpression NaN. name=" + this.name)));
            };
            _arg_1.stack.push(_arg_1.vars[this.name]);
        }


    }
}//package com.adobe.utils.macro

