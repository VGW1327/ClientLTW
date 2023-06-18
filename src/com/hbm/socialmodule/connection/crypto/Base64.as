


//com.hbm.socialmodule.connection.crypto.Base64

package com.hbm.socialmodule.connection.crypto
{
    import flash.utils.ByteArray;

    public class Base64 
    {

        private static const encodeChars:Array = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "+", "/"];
        private static const decodeChars:Array = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 62, -1, -1, -1, 63, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, -1, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -1, -1, -1, -1, -1];


        public static function encode(_arg_1:ByteArray):String
        {
            var _local_7:int;
            var _local_2:Array = [];
            var _local_3:int;
            var _local_4:int;
            var _local_5:int = (_arg_1.length % 3);
            var _local_6:int = (_arg_1.length - _local_5);
            while (_local_3 < _local_6)
            {
                _local_7 = (((_arg_1[_local_3++] << 16) | (_arg_1[_local_3++] << 8)) | _arg_1[_local_3++]);
                var _local_8:* = _local_4++;
                _local_2[_local_8] = (((encodeChars[(_local_7 >> 18)] + encodeChars[((_local_7 >> 12) & 0x3F)]) + encodeChars[((_local_7 >> 6) & 0x3F)]) + encodeChars[(_local_7 & 0x3F)]);
            };
            if (_local_5 == 1)
            {
                _local_7 = _arg_1[_local_3++];
                _local_8 = _local_4++;
                _local_2[_local_8] = ((encodeChars[(_local_7 >> 2)] + encodeChars[((_local_7 & 0x03) << 4)]) + "==");
            }
            else
            {
                if (_local_5 == 2)
                {
                    _local_7 = ((_arg_1[_local_3++] << 8) | _arg_1[_local_3++]);
                    _local_8 = _local_4++;
                    _local_2[_local_8] = (((encodeChars[(_local_7 >> 10)] + encodeChars[((_local_7 >> 4) & 0x3F)]) + encodeChars[((_local_7 & 0x0F) << 2)]) + "=");
                };
            };
            return (_local_2.join(""));
        }

        public static function decode(_arg_1:String):ByteArray
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:ByteArray;
            _local_7 = _arg_1.length;
            _local_6 = 0;
            _local_8 = new ByteArray();
            while (_local_6 < _local_7)
            {
                do 
                {
                    _local_2 = decodeChars[(_arg_1.charCodeAt(_local_6++) & 0xFF)];
                } while (((_local_6 < _local_7) && (_local_2 == -1)));
                if (_local_2 == -1) break;
                do 
                {
                    _local_3 = decodeChars[(_arg_1.charCodeAt(_local_6++) & 0xFF)];
                } while (((_local_6 < _local_7) && (_local_3 == -1)));
                if (_local_3 == -1) break;
                _local_8.writeByte(((_local_2 << 2) | ((_local_3 & 0x30) >> 4)));
                do 
                {
                    _local_4 = (_arg_1.charCodeAt(_local_6++) & 0xFF);
                    if (_local_4 == 61)
                    {
                        return (_local_8);
                    };
                    _local_4 = decodeChars[_local_4];
                } while (((_local_6 < _local_7) && (_local_4 == -1)));
                if (_local_4 == -1) break;
                _local_8.writeByte((((_local_3 & 0x0F) << 4) | ((_local_4 & 0x3C) >> 2)));
                do 
                {
                    _local_5 = (_arg_1.charCodeAt(_local_6++) & 0xFF);
                    if (_local_5 == 61)
                    {
                        return (_local_8);
                    };
                    _local_5 = decodeChars[_local_5];
                } while (((_local_6 < _local_7) && (_local_5 == -1)));
                if (_local_5 == -1) break;
                _local_8.writeByte((((_local_4 & 0x03) << 6) | _local_5));
            };
            return (_local_8);
        }


    }
}//package com.hbm.socialmodule.connection.crypto

