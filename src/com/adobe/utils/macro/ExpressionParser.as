


//com.adobe.utils.macro.ExpressionParser

package com.adobe.utils.macro
{
    import __AS3__.vec.Vector;

    public class ExpressionParser 
    {

        private static const UNARY_PRECEDENCE:int = 5;

        private var pos:int = 0;
        private var newline:int = 0;
        private var tokens:Vector.<String>;
        private var types:String;


        private function expectTok(_arg_1:String):void
        {
            if (this.tokens[this.pos] != _arg_1)
            {
                throw (new Error("Unexpected token."));
            };
            this.pos++;
        }

        private function parseSingle(_arg_1:String, _arg_2:String):Expression
        {
            var _local_3:VariableExpression;
            var _local_4:NumberExpression;
            if (_arg_2 == "i")
            {
                return (new VariableExpression(_arg_1));
            };
            if (_arg_2 == "0")
            {
                _local_4 = new NumberExpression(Number(_arg_1));
                return (_local_4);
            };
            return (null);
        }

        private function parseChunk():Expression
        {
            var _local_1:UnaryExpression;
            var _local_2:Expression;
            var _local_3:VariableExpression;
            var _local_4:NumberExpression;
            if (this.pos == this.newline)
            {
                throw (new Error("parseBit out of tokens"));
            };
            if (this.tokens[this.pos] == "!")
            {
                _local_1 = new UnaryExpression();
                this.pos++;
                _local_1.right = this.parseExpression(UNARY_PRECEDENCE);
                return (_local_1);
            };
            if (this.tokens[this.pos] == "(")
            {
                this.pos++;
                _local_2 = this.parseExpression(0);
                this.expectTok(")");
                return (_local_2);
            };
            if (this.types.charAt(this.pos) == "i")
            {
                _local_3 = new VariableExpression(this.tokens[this.pos]);
                this.pos++;
                return (_local_3);
            };
            if (this.types.charAt(this.pos) == "0")
            {
                _local_4 = new NumberExpression(Number(this.tokens[this.pos]));
                this.pos++;
                return (_local_4);
            };
            throw (new Error(((("end of parseChunk: token=" + this.tokens[this.pos]) + " type=") + this.types.charAt(this.pos))));
        }

        private function parseExpression(_arg_1:int):Expression
        {
            var _local_4:BinaryExpression;
            var _local_2:Expression = this.parseChunk();
            if ((_local_2 is NumberExpression))
            {
                return (_local_2);
            };
            var _local_3:OpInfo = new OpInfo();
            if (this.pos < this.tokens.length)
            {
                this.calcOpInfo(this.tokens[this.pos], _local_3);
            };
            while (((_local_3.order == 2) && (_local_3.precedence >= _arg_1)))
            {
                _local_4 = new BinaryExpression();
                _local_4.op = this.tokens[this.pos];
                this.pos++;
                _local_4.left = _local_2;
                _local_4.right = this.parseExpression((1 + _local_3.precedence));
                _local_2 = _local_4;
                if (this.pos < this.tokens.length)
                {
                    this.calcOpInfo(this.tokens[this.pos], _local_3);
                }
                else
                {
                    break;
                };
            };
            return (_local_2);
        }

        public function parse(_arg_1:Vector.<String>, _arg_2:String):Expression
        {
            this.pos = 0;
            this.newline = _arg_2.indexOf("n", (this.pos + 1));
            if (this.newline < 0)
            {
                this.newline = _arg_2.length;
            };
            this.tokens = _arg_1;
            this.types = _arg_2;
            var _local_3:Expression = this.parseExpression(0);
            if (AGALPreAssembler.TRACE_AST)
            {
                _local_3.print(0);
            };
            if (this.pos != this.newline)
            {
                throw (new Error("parser didn't end"));
            };
            return (_local_3);
        }

        private function calcOpInfo(_arg_1:String, _arg_2:OpInfo):Boolean
        {
            var _local_5:Array;
            var _local_6:int;
            _arg_2.order = 0;
            _arg_2.precedence = -1;
            var _local_3:Array = [new Array("&&", "||"), new Array("==", "!="), new Array(">", "<", ">=", "<="), new Array("+", "-"), new Array("*", "/"), new Array("!")];
            var _local_4:int;
            while (_local_4 < _local_3.length)
            {
                _local_5 = _local_3[_local_4];
                _local_6 = _local_5.indexOf(_arg_1);
                if (_local_6 >= 0)
                {
                    _arg_2.order = ((_local_4 == UNARY_PRECEDENCE) ? 1 : 2);
                    _arg_2.precedence = _local_4;
                    return (true);
                };
                _local_4++;
            };
            return (false);
        }


    }
}//package com.adobe.utils.macro

class OpInfo 
{

    public var precedence:int;
    public var order:int;


}


