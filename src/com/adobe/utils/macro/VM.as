


//com.adobe.utils.macro.VM

package com.adobe.utils.macro
{
    import flash.utils.Dictionary;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class VM 
    {

        public var vars:Dictionary = new Dictionary();
        public var stack:Array = new Array();
        private var m_ifIsTrue:Vector.<Boolean> = new Vector.<Boolean>();
        private var m_ifWasTrue:Vector.<Boolean> = new Vector.<Boolean>();


        public function pushIf():void
        {
            this.m_ifIsTrue.push(false);
            this.m_ifWasTrue.push(false);
        }

        public function popEndif():void
        {
            this.m_ifIsTrue.pop();
            this.m_ifWasTrue.pop();
        }

        public function setIf(_arg_1:Number):void
        {
            this.m_ifIsTrue[(this.m_ifIsTrue.length - 1)] = (!(_arg_1 == 0));
            this.m_ifWasTrue[(this.m_ifIsTrue.length - 1)] = (!(_arg_1 == 0));
        }

        public function ifWasTrue():Boolean
        {
            return (this.m_ifWasTrue[(this.m_ifIsTrue.length - 1)]);
        }

        public function ifIsTrue():Boolean
        {
            if (this.m_ifIsTrue.length == 0)
            {
                return (true);
            };
            var _local_1:int;
            while (_local_1 < this.m_ifIsTrue.length)
            {
                if (!this.m_ifIsTrue[_local_1])
                {
                    return (false);
                };
                _local_1++;
            };
            return (true);
        }


    }
}//package com.adobe.utils.macro

