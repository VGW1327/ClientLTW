


//com.adobe.utils.macro.BinaryExpression

package com.adobe.utils.macro
{
    import com.adobe.utils.macro.Expression;
    import com.adobe.utils.macro.AGALPreAssembler;
    import com.adobe.utils.macro.VM;
    import com.adobe.utils.macro.*;

    internal class BinaryExpression extends Expression 
    {

        public var op:String;
        public var left:Expression;
        public var right:Expression;


        override public function print(_arg_1:int):void
        {
            if (AGALPreAssembler.TRACE_VM)
            {
                trace(((spaces(_arg_1) + "binary op ") + this.op));
            };
            this.left.print((_arg_1 + 1));
            this.right.print((_arg_1 + 1));
        }

        override public function exec(_arg_1:VM):void
        {
            var _local_2:Number = Number.NaN;
            var _local_3:Number = Number.NaN;
            this.left.exec(_arg_1);
            _local_2 = _arg_1.stack.pop();
            this.right.exec(_arg_1);
            _local_3 = _arg_1.stack.pop();
            if (isNaN(_local_2))
            {
                throw (new Error((("Left side of binary expression (" + this.op) + ") is NaN")));
            };
            if (isNaN(_local_3))
            {
                throw (new Error((("Right side of binary expression (" + this.op) + ") is NaN")));
            };
            switch (this.op)
            {
                case "*":
                    _arg_1.stack.push((_local_2 * _local_3));
                    break;
                case "/":
                    _arg_1.stack.push((_local_2 / _local_3));
                    break;
                case "+":
                    _arg_1.stack.push((_local_2 + _local_3));
                    break;
                case "-":
                    _arg_1.stack.push((_local_2 - _local_3));
                    break;
                case ">":
                    _arg_1.stack.push(((_local_2 > _local_3) ? 1 : 0));
                    break;
                case "<":
                    _arg_1.stack.push(((_local_2 < _local_3) ? 1 : 0));
                    break;
                case ">=":
                    _arg_1.stack.push(((_local_2 >= _local_3) ? 1 : 0));
                    break;
                case ">=":
                    _arg_1.stack.push(((_local_2 <= _local_3) ? 1 : 0));
                    break;
                case "==":
                    _arg_1.stack.push(((_local_2 == _local_3) ? 1 : 0));
                    break;
                case "!=":
                    _arg_1.stack.push(((_local_2 != _local_3) ? 1 : 0));
                    break;
                case "&&":
                    _arg_1.stack.push((((Boolean(_local_2)) && (Boolean(_local_3))) ? 1 : 0));
                    break;
                case "||":
                    _arg_1.stack.push((((Boolean(_local_2)) || (Boolean(_local_3))) ? 1 : 0));
                    break;
                default:
                    throw (new Error("unimplemented BinaryExpression exec"));
            };
            if (AGALPreAssembler.TRACE_VM)
            {
                trace(((((((("::BinaryExpression op" + this.op) + " left=") + _local_2) + " right=") + _local_3) + " push ") + _arg_1.stack[(_arg_1.stack.length - 1)]));
            };
        }


    }
}//package com.adobe.utils.macro

