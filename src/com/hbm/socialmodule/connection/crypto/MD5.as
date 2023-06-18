


//com.hbm.socialmodule.connection.crypto.MD5

package com.hbm.socialmodule.connection.crypto
{
    public class MD5 
    {

        public static const HEX_FORMAT_LOWERCASE:uint = 0;
        public static const HEX_FORMAT_UPPERCASE:uint = 1;
        public static const BASE64_PAD_CHARACTER_DEFAULT_COMPLIANCE:String = "";
        public static const BASE64_PAD_CHARACTER_RFC_COMPLIANCE:String = "=";
        public static var hexcase:uint = 0;
        public static var b64pad:String = "";


        public static function encrypt(_arg_1:String):String
        {
            return (hex_md5(_arg_1));
        }

        public static function hex_md5(_arg_1:String):String
        {
            return (rstr2hex(rstr_md5(str2rstr_utf8(_arg_1))));
        }

        public static function b64_md5(_arg_1:String):String
        {
            return (rstr2b64(rstr_md5(str2rstr_utf8(_arg_1))));
        }

        public static function any_md5(_arg_1:String, _arg_2:String):String
        {
            return (rstr2any(rstr_md5(str2rstr_utf8(_arg_1)), _arg_2));
        }

        public static function hex_hmac_md5(_arg_1:String, _arg_2:String):String
        {
            return (rstr2hex(rstr_hmac_md5(str2rstr_utf8(_arg_1), str2rstr_utf8(_arg_2))));
        }

        public static function b64_hmac_md5(_arg_1:String, _arg_2:String):String
        {
            return (rstr2b64(rstr_hmac_md5(str2rstr_utf8(_arg_1), str2rstr_utf8(_arg_2))));
        }

        public static function any_hmac_md5(_arg_1:String, _arg_2:String, _arg_3:String):String
        {
            return (rstr2any(rstr_hmac_md5(str2rstr_utf8(_arg_1), str2rstr_utf8(_arg_2)), _arg_3));
        }

        public static function md5_vm_test():Boolean
        {
            return (hex_md5("abc") == "900150983cd24fb0d6963f7d28e17f72");
        }

        public static function rstr_md5(_arg_1:String):String
        {
            return (binl2rstr(binl_md5(rstr2binl(_arg_1), (_arg_1.length * 8))));
        }

        public static function rstr_hmac_md5(key:String, data:String):String
        {
            var bkey:Array = rstr2binl(key);
            if (bkey.length > 16)
                bkey = binl_md5(bkey, key.length * 8);
				
            var ipad = Array(16);
            var opad = Array(16);
			for (var i:int = 0; i < 16; i++) 
			{
				ipad[i] = bkey[i] ^ 0x36363636;
                opad[i] = bkey[i] ^ 0x5C5C5C5C;
			}
            var hash:Array = binl_md5(ipad.concat(rstr2binl(data)), 0x0200 + (data.length * 8));
            return binl2rstr(binl_md5(opad.concat(hash), 0x0200 + 128));
        }

        public static function rstr2hex(_arg_1:String):String
        {
            var _local_4:Number;
            var _local_2:String = ((hexcase) ? "0123456789ABCDEF" : "0123456789abcdef");
            var _local_3:* = "";
            var _local_5:Number = 0;
            while (_local_5 < _arg_1.length)
            {
                _local_4 = _arg_1.charCodeAt(_local_5);
                _local_3 = (_local_3 + (_local_2.charAt(((_local_4 >>> 4) & 0x0F)) + _local_2.charAt((_local_4 & 0x0F))));
                _local_5++;
            };
            return (_local_3);
        }

        public static function rstr2b64(_arg_1:String):String
        {
            var _local_6:Number;
            var _local_7:Number;
            var _local_2:* = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            var _local_3:* = "";
            var _local_4:Number = _arg_1.length;
            var _local_5:Number = 0;
            while (_local_5 < _local_4)
            {
                _local_6 = (((_arg_1.charCodeAt(_local_5) << 16) | (((_local_5 + 1) < _local_4) ? (_arg_1.charCodeAt((_local_5 + 1)) << 8) : 0)) | (((_local_5 + 2) < _local_4) ? _arg_1.charCodeAt((_local_5 + 2)) : 0));
                _local_7 = 0;
                while (_local_7 < 4)
                {
                    if (((_local_5 * 8) + (_local_7 * 6)) > (_arg_1.length * 8))
                    {
                        _local_3 = (_local_3 + b64pad);
                    }
                    else
                    {
                        _local_3 = (_local_3 + _local_2.charAt(((_local_6 >>> (6 * (3 - _local_7))) & 0x3F)));
                    };
                    _local_7++;
                };
                _local_5 = (_local_5 + 3);
            };
            return (_local_3);
        }

        public static function rstr2any(_arg_1:String, _arg_2:String):String
        {
            var _local_5:Number;
            var _local_6:Number;
            var _local_7:Number;
            var _local_8:Array;
            var _local_3:Number = _arg_2.length;
            var _local_4:Array = [];
            var _local_9:Array = Array((_arg_1.length / 2));
            _local_5 = 0;
            while (_local_5 < _local_9.length)
            {
                _local_9[_local_5] = ((_arg_1.charCodeAt((_local_5 * 2)) << 8) | _arg_1.charCodeAt(((_local_5 * 2) + 1)));
                _local_5++;
            };
            while (_local_9.length > 0)
            {
                _local_8 = [];
                _local_7 = 0;
                _local_5 = 0;
                while (_local_5 < _local_9.length)
                {
                    _local_7 = ((_local_7 << 16) + _local_9[_local_5]);
                    _local_6 = Math.floor((_local_7 / _local_3));
                    _local_7 = (_local_7 - (_local_6 * _local_3));
                    if (((_local_8.length > 0) || (_local_6 > 0)))
                    {
                        _local_8[_local_8.length] = _local_6;
                    };
                    _local_5++;
                };
                _local_4[_local_4.length] = _local_7;
                _local_9 = _local_8;
            };
            var _local_10:* = "";
            _local_5 = (_local_4.length - 1);
            while (_local_5 >= 0)
            {
                _local_10 = (_local_10 + _arg_2.charAt(_local_4[_local_5]));
                _local_5--;
            };
            return (_local_10);
        }

        public static function str2rstr_utf8(_arg_1:String):String
        {
            var _local_4:Number;
            var _local_5:Number;
            var _local_2:* = "";
            var _local_3:Number = -1;
            while (++_local_3 < _arg_1.length)
            {
                _local_4 = _arg_1.charCodeAt(_local_3);
                _local_5 = (((_local_3 + 1) < _arg_1.length) ? _arg_1.charCodeAt((_local_3 + 1)) : 0);
                if (((((0xD800 <= _local_4) && (_local_4 <= 56319)) && (0xDC00 <= _local_5)) && (_local_5 <= 57343)))
                {
                    _local_4 = ((0x10000 + ((_local_4 & 0x03FF) << 10)) + (_local_5 & 0x03FF));
                    _local_3++;
                };
                if (_local_4 <= 127)
                {
                    _local_2 = (_local_2 + String.fromCharCode(_local_4));
                }
                else
                {
                    if (_local_4 <= 2047)
                    {
                        _local_2 = (_local_2 + String.fromCharCode((0xC0 | ((_local_4 >>> 6) & 0x1F)), (0x80 | (_local_4 & 0x3F))));
                    }
                    else
                    {
                        if (_local_4 <= 0xFFFF)
                        {
                            _local_2 = (_local_2 + String.fromCharCode((0xE0 | ((_local_4 >>> 12) & 0x0F)), (0x80 | ((_local_4 >>> 6) & 0x3F)), (0x80 | (_local_4 & 0x3F))));
                        }
                        else
                        {
                            if (_local_4 <= 2097151)
                            {
                                _local_2 = (_local_2 + String.fromCharCode((0xF0 | ((_local_4 >>> 18) & 0x07)), (0x80 | ((_local_4 >>> 12) & 0x3F)), (0x80 | ((_local_4 >>> 6) & 0x3F)), (0x80 | (_local_4 & 0x3F))));
                            };
                        };
                    };
                };
            };
            return (_local_2);
        }

        public static function str2rstr_utf16le(_arg_1:String):String
        {
            var _local_2:* = "";
            var _local_3:Number = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_2 = (_local_2 + String.fromCharCode((_arg_1.charCodeAt(_local_3) & 0xFF), ((_arg_1.charCodeAt(_local_3) >>> 8) & 0xFF)));
                _local_3++;
            };
            return (_local_2);
        }

        public static function str2rstr_utf16be(_arg_1:String):String
        {
            var _local_2:* = "";
            var _local_3:Number = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_2 = (_local_2 + String.fromCharCode(((_arg_1.charCodeAt(_local_3) >>> 8) & 0xFF), (_arg_1.charCodeAt(_local_3) & 0xFF)));
                _local_3++;
            };
            return (_local_2);
        }

        public static function rstr2binl(_arg_1:String):Array
        {
            var _local_3:Number;
            var _local_2:Array = Array((_arg_1.length >> 2));
            _local_3 = 0;
            while (_local_3 < _local_2.length)
            {
                _local_2[_local_3] = 0;
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < (_arg_1.length * 8))
            {
                _local_2[(_local_3 >> 5)] = (_local_2[(_local_3 >> 5)] | ((_arg_1.charCodeAt((_local_3 / 8)) & 0xFF) << (_local_3 % 32)));
                _local_3 = (_local_3 + 8);
            };
            return (_local_2);
        }

        public static function binl2rstr(_arg_1:Array):String
        {
            var _local_2:* = "";
            var _local_3:Number = 0;
            while (_local_3 < (_arg_1.length * 32))
            {
                _local_2 = (_local_2 + String.fromCharCode(((_arg_1[(_local_3 >> 5)] >>> (_local_3 % 32)) & 0xFF)));
                _local_3 = (_local_3 + 8);
            };
            return (_local_2);
        }

        public static function binl_md5(_arg_1:Array, _arg_2:Number):Array
        {
            var _local_8:Number;
            var _local_9:Number;
            var _local_10:Number;
            var _local_11:Number;
            _arg_1[(_arg_2 >> 5)] = (_arg_1[(_arg_2 >> 5)] | (128 << (_arg_2 % 32)));
            _arg_1[((((_arg_2 + 64) >>> 9) << 4) + 14)] = _arg_2;
            var _local_3:Number = 1732584193;
            var _local_4:Number = -271733879;
            var _local_5:Number = -1732584194;
            var _local_6:Number = 271733878;
            var _local_7:Number = 0;
            while (_local_7 < _arg_1.length)
            {
                _local_8 = _local_3;
                _local_9 = _local_4;
                _local_10 = _local_5;
                _local_11 = _local_6;
                _local_3 = md5_ff(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 0)], 7, -680876936);
                _local_6 = md5_ff(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 1)], 12, -389564586);
                _local_5 = md5_ff(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 2)], 17, 606105819);
                _local_4 = md5_ff(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 3)], 22, -1044525330);
                _local_3 = md5_ff(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 4)], 7, -176418897);
                _local_6 = md5_ff(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 5)], 12, 1200080426);
                _local_5 = md5_ff(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 6)], 17, -1473231341);
                _local_4 = md5_ff(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 7)], 22, -45705983);
                _local_3 = md5_ff(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 8)], 7, 1770035416);
                _local_6 = md5_ff(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 9)], 12, -1958414417);
                _local_5 = md5_ff(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 10)], 17, -42063);
                _local_4 = md5_ff(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 11)], 22, -1990404162);
                _local_3 = md5_ff(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 12)], 7, 1804603682);
                _local_6 = md5_ff(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 13)], 12, -40341101);
                _local_5 = md5_ff(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 14)], 17, -1502002290);
                _local_4 = md5_ff(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 15)], 22, 1236535329);
                _local_3 = md5_gg(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 1)], 5, -165796510);
                _local_6 = md5_gg(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 6)], 9, -1069501632);
                _local_5 = md5_gg(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 11)], 14, 643717713);
                _local_4 = md5_gg(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 0)], 20, -373897302);
                _local_3 = md5_gg(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 5)], 5, -701558691);
                _local_6 = md5_gg(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 10)], 9, 38016083);
                _local_5 = md5_gg(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 15)], 14, -660478335);
                _local_4 = md5_gg(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 4)], 20, -405537848);
                _local_3 = md5_gg(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 9)], 5, 568446438);
                _local_6 = md5_gg(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 14)], 9, -1019803690);
                _local_5 = md5_gg(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 3)], 14, -187363961);
                _local_4 = md5_gg(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 8)], 20, 1163531501);
                _local_3 = md5_gg(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 13)], 5, -1444681467);
                _local_6 = md5_gg(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 2)], 9, -51403784);
                _local_5 = md5_gg(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 7)], 14, 1735328473);
                _local_4 = md5_gg(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 12)], 20, -1926607734);
                _local_3 = md5_hh(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 5)], 4, -378558);
                _local_6 = md5_hh(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 8)], 11, -2022574463);
                _local_5 = md5_hh(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 11)], 16, 1839030562);
                _local_4 = md5_hh(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 14)], 23, -35309556);
                _local_3 = md5_hh(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 1)], 4, -1530992060);
                _local_6 = md5_hh(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 4)], 11, 1272893353);
                _local_5 = md5_hh(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 7)], 16, -155497632);
                _local_4 = md5_hh(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 10)], 23, -1094730640);
                _local_3 = md5_hh(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 13)], 4, 681279174);
                _local_6 = md5_hh(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 0)], 11, -358537222);
                _local_5 = md5_hh(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 3)], 16, -722521979);
                _local_4 = md5_hh(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 6)], 23, 76029189);
                _local_3 = md5_hh(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 9)], 4, -640364487);
                _local_6 = md5_hh(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 12)], 11, -421815835);
                _local_5 = md5_hh(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 15)], 16, 530742520);
                _local_4 = md5_hh(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 2)], 23, -995338651);
                _local_3 = md5_ii(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 0)], 6, -198630844);
                _local_6 = md5_ii(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 7)], 10, 1126891415);
                _local_5 = md5_ii(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 14)], 15, -1416354905);
                _local_4 = md5_ii(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 5)], 21, -57434055);
                _local_3 = md5_ii(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 12)], 6, 1700485571);
                _local_6 = md5_ii(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 3)], 10, -1894986606);
                _local_5 = md5_ii(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 10)], 15, -1051523);
                _local_4 = md5_ii(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 1)], 21, -2054922799);
                _local_3 = md5_ii(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 8)], 6, 1873313359);
                _local_6 = md5_ii(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 15)], 10, -30611744);
                _local_5 = md5_ii(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 6)], 15, -1560198380);
                _local_4 = md5_ii(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 13)], 21, 1309151649);
                _local_3 = md5_ii(_local_3, _local_4, _local_5, _local_6, _arg_1[(_local_7 + 4)], 6, -145523070);
                _local_6 = md5_ii(_local_6, _local_3, _local_4, _local_5, _arg_1[(_local_7 + 11)], 10, -1120210379);
                _local_5 = md5_ii(_local_5, _local_6, _local_3, _local_4, _arg_1[(_local_7 + 2)], 15, 718787259);
                _local_4 = md5_ii(_local_4, _local_5, _local_6, _local_3, _arg_1[(_local_7 + 9)], 21, -343485551);
                _local_3 = safe_add(_local_3, _local_8);
                _local_4 = safe_add(_local_4, _local_9);
                _local_5 = safe_add(_local_5, _local_10);
                _local_6 = safe_add(_local_6, _local_11);
                _local_7 = (_local_7 + 16);
            };
            return ([_local_3, _local_4, _local_5, _local_6]);
        }

        public static function md5_cmn(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number):Number
        {
            return (safe_add(bit_rol(safe_add(safe_add(_arg_2, _arg_1), safe_add(_arg_4, _arg_6)), _arg_5), _arg_3));
        }

        public static function md5_ff(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number):Number
        {
            return (md5_cmn(((_arg_2 & _arg_3) | ((~(_arg_2)) & _arg_4)), _arg_1, _arg_2, _arg_5, _arg_6, _arg_7));
        }

        public static function md5_gg(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number):Number
        {
            return (md5_cmn(((_arg_2 & _arg_4) | (_arg_3 & (~(_arg_4)))), _arg_1, _arg_2, _arg_5, _arg_6, _arg_7));
        }

        public static function md5_hh(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number):Number
        {
            return (md5_cmn(((_arg_2 ^ _arg_3) ^ _arg_4), _arg_1, _arg_2, _arg_5, _arg_6, _arg_7));
        }

        public static function md5_ii(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:Number, _arg_6:Number, _arg_7:Number):Number
        {
            return (md5_cmn((_arg_3 ^ (_arg_2 | (~(_arg_4)))), _arg_1, _arg_2, _arg_5, _arg_6, _arg_7));
        }

        public static function safe_add(_arg_1:Number, _arg_2:Number):Number
        {
            var _local_3:Number = ((_arg_1 & 0xFFFF) + (_arg_2 & 0xFFFF));
            var _local_4:Number = (((_arg_1 >> 16) + (_arg_2 >> 16)) + (_local_3 >> 16));
            return ((_local_4 << 16) | (_local_3 & 0xFFFF));
        }

        public static function bit_rol(_arg_1:Number, _arg_2:Number):Number
        {
            return ((_arg_1 << _arg_2) | (_arg_1 >>> (32 - _arg_2)));
        }


    }
}//package com.hbm.socialmodule.connection.crypto

