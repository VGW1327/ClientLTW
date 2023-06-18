


//com.adobe.utils.macro.Expression

package com.adobe.utils.macro
{
    public class Expression 
    {


        public function print(_arg_1:int):void
        {
            trace("top");
        }

        public function exec(_arg_1:VM):void
        {
            trace("WTF");
        }

        protected function spaces(_arg_1:int):String
        {
            var _local_2:* = "";
            var _local_3:int;
            while (_local_3 < _arg_1)
            {
                _local_2 = (_local_2 + "  ");
                _local_3++;
            };
            return (_local_2);
        }


    }
}//package com.adobe.utils.macro

