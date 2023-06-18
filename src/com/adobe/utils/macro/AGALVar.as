


//com.adobe.utils.macro.AGALVar

package com.adobe.utils.macro
{
    public class AGALVar 
    {

        public var name:String;
        public var target:String;
        public var x:Number = NaN;
        public var y:Number = NaN;
        public var z:Number = NaN;
        public var w:Number = NaN;


        public function isConstant():Boolean
        {
            return (!(isNaN(this.x)));
        }

        public function toString():String
        {
            if (this.isConstant())
            {
                return (((((((((((("alias " + this.target) + ", ") + this.name) + "( ") + this.x) + ", ") + this.y) + ", ") + this.z) + ", ") + this.w) + " )");
            };
            return ((("alias " + this.target) + ", ") + this.name);
        }


    }
}//package com.adobe.utils.macro

