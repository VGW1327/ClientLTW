


//com.adobe.utils.macro.NumberExpression

package com.adobe.utils.macro
{
    import com.adobe.utils.macro.Expression;
    import com.adobe.utils.macro.AGALPreAssembler;
    import com.adobe.utils.macro.VM;

    internal class NumberExpression extends Expression 
    {

        private var value:Number;

        public function NumberExpression(_arg_1:Number)
        {
            this.value = _arg_1;
        }

        override public function print(_arg_1:int):void
        {
            trace(((spaces(_arg_1) + "number=") + this.value));
        }

        override public function exec(_arg_1:VM):void
        {
            if (AGALPreAssembler.TRACE_VM)
            {
                trace(("::NumberExpression push " + this.value));
            };
            if (isNaN(this.value))
            {
                throw (new Error("Pushing NaN to stack"));
            };
            _arg_1.stack.push(this.value);
        }


    }
}//package com.adobe.utils.macro

