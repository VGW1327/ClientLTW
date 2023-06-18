


//com.hbm.socialmodule.connection.crypto.Int64

package com.hbm.socialmodule.connection.crypto
{
    public class Int64 
    {

        public var h:*;
        public var l:*;

        public function Int64(_arg_1:*, _arg_2:*)
        {
            this.h = _arg_1;
            this.l = _arg_2;
        }

        public function copy(_arg_1:*):*
        {
            this.h = _arg_1.h;
            this.l = _arg_1.l;
        }

        public function rrot(_arg_1:*, _arg_2:*):*
        {
            this.l = ((_arg_1.l >>> _arg_2) | (_arg_1.h << (32 - _arg_2)));
            this.h = ((_arg_1.h >>> _arg_2) | (_arg_1.l << (32 - _arg_2)));
        }

        public function revrrot(_arg_1:*, _arg_2:*):*
        {
            this.l = ((_arg_1.h >>> _arg_2) | (_arg_1.l << (32 - _arg_2)));
            this.h = ((_arg_1.l >>> _arg_2) | (_arg_1.h << (32 - _arg_2)));
        }

        public function shr(_arg_1:*, _arg_2:*):*
        {
            this.l = ((_arg_1.l >>> _arg_2) | (_arg_1.h << (32 - _arg_2)));
            this.h = (_arg_1.h >>> _arg_2);
        }

        public function add(_arg_1:*, _arg_2:*):*
        {
            var _local_3:* = ((_arg_1.l & 0xFFFF) + (_arg_2.l & 0xFFFF));
            var _local_4:* = (((_arg_1.l >>> 16) + (_arg_2.l >>> 16)) + (_local_3 >>> 16));
            var _local_5:* = (((_arg_1.h & 0xFFFF) + (_arg_2.h & 0xFFFF)) + (_local_4 >>> 16));
            var _local_6:* = (((_arg_1.h >>> 16) + (_arg_2.h >>> 16)) + (_local_5 >>> 16));
            this.l = ((_local_3 & 0xFFFF) | (_local_4 << 16));
            this.h = ((_local_5 & 0xFFFF) | (_local_6 << 16));
        }

        public function add4(_arg_1:*, _arg_2:*, _arg_3:*, _arg_4:*):*
        {
            var _local_5:* = ((((_arg_1.l & 0xFFFF) + (_arg_2.l & 0xFFFF)) + (_arg_3.l & 0xFFFF)) + (_arg_4.l & 0xFFFF));
            var _local_6:* = (((((_arg_1.l >>> 16) + (_arg_2.l >>> 16)) + (_arg_3.l >>> 16)) + (_arg_4.l >>> 16)) + (_local_5 >>> 16));
            var _local_7:* = (((((_arg_1.h & 0xFFFF) + (_arg_2.h & 0xFFFF)) + (_arg_3.h & 0xFFFF)) + (_arg_4.h & 0xFFFF)) + (_local_6 >>> 16));
            var _local_8:* = (((((_arg_1.h >>> 16) + (_arg_2.h >>> 16)) + (_arg_3.h >>> 16)) + (_arg_4.h >>> 16)) + (_local_7 >>> 16));
            this.l = ((_local_5 & 0xFFFF) | (_local_6 << 16));
            this.h = ((_local_7 & 0xFFFF) | (_local_8 << 16));
        }

        public function add5(_arg_1:*, _arg_2:*, _arg_3:*, _arg_4:*, _arg_5:*):*
        {
            var _local_6:* = (((((_arg_1.l & 0xFFFF) + (_arg_2.l & 0xFFFF)) + (_arg_3.l & 0xFFFF)) + (_arg_4.l & 0xFFFF)) + (_arg_5.l & 0xFFFF));
            var _local_7:* = ((((((_arg_1.l >>> 16) + (_arg_2.l >>> 16)) + (_arg_3.l >>> 16)) + (_arg_4.l >>> 16)) + (_arg_5.l >>> 16)) + (_local_6 >>> 16));
            var _local_8:* = ((((((_arg_1.h & 0xFFFF) + (_arg_2.h & 0xFFFF)) + (_arg_3.h & 0xFFFF)) + (_arg_4.h & 0xFFFF)) + (_arg_5.h & 0xFFFF)) + (_local_7 >>> 16));
            var _local_9:* = ((((((_arg_1.h >>> 16) + (_arg_2.h >>> 16)) + (_arg_3.h >>> 16)) + (_arg_4.h >>> 16)) + (_arg_5.h >>> 16)) + (_local_8 >>> 16));
            this.l = ((_local_6 & 0xFFFF) | (_local_7 << 16));
            this.h = ((_local_8 & 0xFFFF) | (_local_9 << 16));
        }


    }
}//package com.hbm.socialmodule.connection.crypto

