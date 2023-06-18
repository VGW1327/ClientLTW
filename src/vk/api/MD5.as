


//vk.api.MD5

package vk.api
{
    public class MD5 
    {


        private static function HH(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int):int
        {
            _arg_1 = AddUnsigned(_arg_1, AddUnsigned(AddUnsigned(H(_arg_2, _arg_3, _arg_4), _arg_5), _arg_7));
            return (AddUnsigned(RotateLeft(_arg_1, _arg_6), _arg_2));
        }

        private static function ConvertToWordArray(_arg_1:String):Array
        {
            var _local_2:Number;
            var _local_3:Number = _arg_1.length;
            var _local_4:Number = (_local_3 + 8);
            var _local_5:Number = ((_local_4 - (_local_4 % 64)) / 64);
            var _local_6:Number = ((_local_5 + 1) * 16);
            var _local_7:Array = new Array((_local_6 - 1));
            var _local_8:Number = 0;
            var _local_9:Number = 0;
            while (_local_9 < _local_3)
            {
                _local_2 = ((_local_9 - (_local_9 % 4)) / 4);
                _local_8 = ((_local_9 % 4) * 8);
                _local_7[_local_2] = (_local_7[_local_2] | (_arg_1.charCodeAt(_local_9) << _local_8));
                _local_9++;
            };
            _local_2 = ((_local_9 - (_local_9 % 4)) / 4);
            _local_8 = ((_local_9 % 4) * 8);
            _local_7[_local_2] = (_local_7[_local_2] | (128 << _local_8));
            _local_7[(_local_6 - 2)] = (_local_3 << 3);
            _local_7[(_local_6 - 1)] = (_local_3 >>> 29);
            return (_local_7);
        }

        private static function RotateLeft(_arg_1:int, _arg_2:int):Number
        {
            return ((_arg_1 << _arg_2) | (_arg_1 >>> (32 - _arg_2)));
        }

        public static function encrypt(_arg_1:String):String
        {
            var _local_2:Array;
            var _local_3:Number;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:Number = 7;
            var _local_13:Number = 12;
            var _local_14:Number = 17;
            var _local_15:Number = 22;
            var _local_16:Number = 5;
            var _local_17:Number = 9;
            var _local_18:Number = 14;
            var _local_19:Number = 20;
            var _local_20:Number = 4;
            var _local_21:Number = 11;
            var _local_22:Number = 16;
            var _local_23:Number = 23;
            var _local_24:Number = 6;
            var _local_25:Number = 10;
            var _local_26:Number = 15;
            var _local_27:Number = 21;
            _arg_1 = Utf8Encode(_arg_1);
            _local_2 = ConvertToWordArray(_arg_1);
            _local_8 = 1732584193;
            _local_9 = 4023233417;
            _local_10 = 2562383102;
            _local_11 = 271733878;
            _local_3 = 0;
            while (_local_3 < _local_2.length)
            {
                _local_4 = _local_8;
                _local_5 = _local_9;
                _local_6 = _local_10;
                _local_7 = _local_11;
                _local_8 = FF(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 0)], _local_12, 3614090360);
                _local_11 = FF(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 1)], _local_13, 3905402710);
                _local_10 = FF(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 2)], _local_14, 606105819);
                _local_9 = FF(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 3)], _local_15, 3250441966);
                _local_8 = FF(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 4)], _local_12, 4118548399);
                _local_11 = FF(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 5)], _local_13, 1200080426);
                _local_10 = FF(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 6)], _local_14, 2821735955);
                _local_9 = FF(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 7)], _local_15, 4249261313);
                _local_8 = FF(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 8)], _local_12, 1770035416);
                _local_11 = FF(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 9)], _local_13, 2336552879);
                _local_10 = FF(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 10)], _local_14, 0xFFFF5BB1);
                _local_9 = FF(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 11)], _local_15, 2304563134);
                _local_8 = FF(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 12)], _local_12, 1804603682);
                _local_11 = FF(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 13)], _local_13, 4254626195);
                _local_10 = FF(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 14)], _local_14, 2792965006);
                _local_9 = FF(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 15)], _local_15, 1236535329);
                _local_8 = GG(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 1)], _local_16, 4129170786);
                _local_11 = GG(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 6)], _local_17, 3225465664);
                _local_10 = GG(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 11)], _local_18, 643717713);
                _local_9 = GG(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 0)], _local_19, 3921069994);
                _local_8 = GG(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 5)], _local_16, 3593408605);
                _local_11 = GG(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 10)], _local_17, 38016083);
                _local_10 = GG(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 15)], _local_18, 3634488961);
                _local_9 = GG(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 4)], _local_19, 3889429448);
                _local_8 = GG(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 9)], _local_16, 568446438);
                _local_11 = GG(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 14)], _local_17, 3275163606);
                _local_10 = GG(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 3)], _local_18, 4107603335);
                _local_9 = GG(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 8)], _local_19, 1163531501);
                _local_8 = GG(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 13)], _local_16, 2850285829);
                _local_11 = GG(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 2)], _local_17, 4243563512);
                _local_10 = GG(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 7)], _local_18, 1735328473);
                _local_9 = GG(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 12)], _local_19, 2368359562);
                _local_8 = HH(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 5)], _local_20, 4294588738);
                _local_11 = HH(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 8)], _local_21, 2272392833);
                _local_10 = HH(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 11)], _local_22, 1839030562);
                _local_9 = HH(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 14)], _local_23, 4259657740);
                _local_8 = HH(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 1)], _local_20, 2763975236);
                _local_11 = HH(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 4)], _local_21, 1272893353);
                _local_10 = HH(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 7)], _local_22, 4139469664);
                _local_9 = HH(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 10)], _local_23, 3200236656);
                _local_8 = HH(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 13)], _local_20, 681279174);
                _local_11 = HH(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 0)], _local_21, 3936430074);
                _local_10 = HH(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 3)], _local_22, 3572445317);
                _local_9 = HH(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 6)], _local_23, 76029189);
                _local_8 = HH(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 9)], _local_20, 3654602809);
                _local_11 = HH(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 12)], _local_21, 3873151461);
                _local_10 = HH(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 15)], _local_22, 530742520);
                _local_9 = HH(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 2)], _local_23, 3299628645);
                _local_8 = II(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 0)], _local_24, 4096336452);
                _local_11 = II(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 7)], _local_25, 1126891415);
                _local_10 = II(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 14)], _local_26, 2878612391);
                _local_9 = II(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 5)], _local_27, 4237533241);
                _local_8 = II(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 12)], _local_24, 1700485571);
                _local_11 = II(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 3)], _local_25, 2399980690);
                _local_10 = II(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 10)], _local_26, 4293915773);
                _local_9 = II(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 1)], _local_27, 2240044497);
                _local_8 = II(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 8)], _local_24, 1873313359);
                _local_11 = II(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 15)], _local_25, 4264355552);
                _local_10 = II(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 6)], _local_26, 2734768916);
                _local_9 = II(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 13)], _local_27, 1309151649);
                _local_8 = II(_local_8, _local_9, _local_10, _local_11, _local_2[(_local_3 + 4)], _local_24, 4149444226);
                _local_11 = II(_local_11, _local_8, _local_9, _local_10, _local_2[(_local_3 + 11)], _local_25, 3174756917);
                _local_10 = II(_local_10, _local_11, _local_8, _local_9, _local_2[(_local_3 + 2)], _local_26, 718787259);
                _local_9 = II(_local_9, _local_10, _local_11, _local_8, _local_2[(_local_3 + 9)], _local_27, 3951481745);
                _local_8 = AddUnsigned(_local_8, _local_4);
                _local_9 = AddUnsigned(_local_9, _local_5);
                _local_10 = AddUnsigned(_local_10, _local_6);
                _local_11 = AddUnsigned(_local_11, _local_7);
                _local_3 = (_local_3 + 16);
            };
            var _local_28:String = (((WordToHex(_local_8) + WordToHex(_local_9)) + WordToHex(_local_10)) + WordToHex(_local_11));
            return (_local_28.toLowerCase());
        }

        private static function F(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return ((_arg_1 & _arg_2) | ((~(_arg_1)) & _arg_3));
        }

        private static function GG(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int):int
        {
            _arg_1 = AddUnsigned(_arg_1, AddUnsigned(AddUnsigned(G(_arg_2, _arg_3, _arg_4), _arg_5), _arg_7));
            return (AddUnsigned(RotateLeft(_arg_1, _arg_6), _arg_2));
        }

        private static function H(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return ((_arg_1 ^ _arg_2) ^ _arg_3);
        }

        private static function I(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return (_arg_2 ^ (_arg_1 | (~(_arg_3))));
        }

        private static function G(_arg_1:int, _arg_2:int, _arg_3:int):int
        {
            return ((_arg_1 & _arg_3) | (_arg_2 & (~(_arg_3))));
        }

        private static function II(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int):Number
        {
            _arg_1 = AddUnsigned(_arg_1, AddUnsigned(AddUnsigned(I(_arg_2, _arg_3, _arg_4), _arg_5), _arg_7));
            return (AddUnsigned(RotateLeft(_arg_1, _arg_6), _arg_2));
        }

        private static function AddUnsigned(_arg_1:int, _arg_2:int):Number
        {
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            _local_5 = (_arg_1 & 0x80000000);
            _local_6 = (_arg_2 & 0x80000000);
            _local_3 = (_arg_1 & 0x40000000);
            _local_4 = (_arg_2 & 0x40000000);
            _local_7 = ((_arg_1 & 0x3FFFFFFF) + (_arg_2 & 0x3FFFFFFF));
            if ((_local_3 & _local_4))
            {
                return (((_local_7 ^ 0x80000000) ^ _local_5) ^ _local_6);
            };
            if ((_local_3 | _local_4))
            {
                if ((_local_7 & 0x40000000))
                {
                    return (((_local_7 ^ 0xC0000000) ^ _local_5) ^ _local_6);
                };
                return (((_local_7 ^ 0x40000000) ^ _local_5) ^ _local_6);
            };
            return ((_local_7 ^ _local_5) ^ _local_6);
        }

        private static function FF(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int):int
        {
            _arg_1 = AddUnsigned(_arg_1, AddUnsigned(AddUnsigned(F(_arg_2, _arg_3, _arg_4), _arg_5), _arg_7));
            return (AddUnsigned(RotateLeft(_arg_1, _arg_6), _arg_2));
        }

        private static function WordToHex(_arg_1:Number):String
        {
            var _local_4:Number;
            var _local_5:Number;
            var _local_2:* = "";
            var _local_3:* = "";
            _local_5 = 0;
            while (_local_5 <= 3)
            {
                _local_4 = ((_arg_1 >>> (_local_5 * 8)) & 0xFF);
                _local_3 = ("0" + _local_4.toString(16));
                _local_2 = (_local_2 + _local_3.substr((_local_3.length - 2), 2));
                _local_5++;
            };
            return (_local_2);
        }

        private static function Utf8Encode(_arg_1:String):String
        {
            var _local_4:Number;
            var _local_2:* = "";
            var _local_3:Number = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_4 = _arg_1.charCodeAt(_local_3);
                if (_local_4 < 128)
                {
                    _local_2 = (_local_2 + String.fromCharCode(_local_4));
                }
                else
                {
                    if (((_local_4 > 127) && (_local_4 < 0x0800)))
                    {
                        _local_2 = (_local_2 + String.fromCharCode(((_local_4 >> 6) | 0xC0)));
                        _local_2 = (_local_2 + String.fromCharCode(((_local_4 & 0x3F) | 0x80)));
                    }
                    else
                    {
                        _local_2 = (_local_2 + String.fromCharCode(((_local_4 >> 12) | 0xE0)));
                        _local_2 = (_local_2 + String.fromCharCode((((_local_4 >> 6) & 0x3F) | 0x80)));
                        _local_2 = (_local_2 + String.fromCharCode(((_local_4 & 0x3F) | 0x80)));
                    };
                };
                _local_3++;
            };
            return (_local_2);
        }


    }
}//package vk.api

