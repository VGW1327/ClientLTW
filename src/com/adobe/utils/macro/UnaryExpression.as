


//com.adobe.utils.macro.UnaryExpression

package com.adobe.utils.macro
{
    import com.adobe.utils.macro.Expression;
    import com.adobe.utils.macro.AGALPreAssembler;
    import com.adobe.utils.macro.VM;

    internal class UnaryExpression extends Expression 
    {

        public var right:Expression;


        override public function print(_arg_1:int):void
        {
            if (AGALPreAssembler.TRACE_VM)
            {
                trace((spaces(_arg_1) + "not"));
            };
            this.right.print((_arg_1 + 1));
        }

        override public function exec(_arg_1:VM):void
        {
            this.right.exec(_arg_1);
            var _local_2:Number = _arg_1.stack.pop();
            var _local_3:Number = ((_local_2 == 0) ? 1 : 0);
            if (AGALPreAssembler.TRACE_VM)
            {
                trace(("::NotExpression push " + _local_3));
            };
            if (isNaN(_local_2))
            {
                throw (new Error("UnaryExpression NaN"));
            };
            _arg_1.stack.push(_local_3);
        }


    }
}//package com.adobe.utils.macro

