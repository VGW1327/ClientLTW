


//com.hbm.socialmodule.connection.crypto.Sha512

package com.hbm.socialmodule.connection.crypto
{
    public class Sha512 
    {

        public var hexcase:* = 0;
        public var b64pad:* = "";
        internal var sha512_k:*;


        public function hex_sha512(_arg_1:*):*
        {
            return (this.rstr2hex(this.rstr_sha512(this.str2rstr_utf8(_arg_1))));
        }

        public function b64_sha512(_arg_1:*):*
        {
            return (this.rstr2b64(this.rstr_sha512(this.str2rstr_utf8(_arg_1))));
        }

        public function any_sha512(_arg_1:*, _arg_2:*):*
        {
            return (this.rstr2any(this.rstr_sha512(this.str2rstr_utf8(_arg_1)), _arg_2));
        }

        public function hex_hmac_sha512(_arg_1:*, _arg_2:*):*
        {
            return (this.rstr2hex(this.rstr_hmac_sha512(this.str2rstr_utf8(_arg_1), this.str2rstr_utf8(_arg_2))));
        }

        public function b64_hmac_sha512(_arg_1:*, _arg_2:*):*
        {
            return (this.rstr2b64(this.rstr_hmac_sha512(this.str2rstr_utf8(_arg_1), this.str2rstr_utf8(_arg_2))));
        }

        public function any_hmac_sha512(_arg_1:*, _arg_2:*, _arg_3:*):*
        {
            return (this.rstr2any(this.rstr_hmac_sha512(this.str2rstr_utf8(_arg_1), this.str2rstr_utf8(_arg_2)), _arg_3));
        }

        public function sha512_vm_test():*
        {
            return (this.hex_sha512("abc").toLowerCase() == ("ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a" + "2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f"));
        }

        private function rstr_sha512(_arg_1:*):*
        {
            return (this.binb2rstr(this.binb_sha512(this.rstr2binb(_arg_1), (_arg_1.length * 8))));
        }

        private function rstr_hmac_sha512(_arg_1:*, _arg_2:*):*
        {
            var _local_3:* = this.rstr2binb(_arg_1);
            if (_local_3.length > 32)
            {
                _local_3 = this.binb_sha512(_local_3, (_arg_1.length * 8));
            };
            var _local_4:* = new Array(32);
            var _local_5:* = new Array(32);
            var _local_6:* = 0;
            while (_local_6 < 32)
            {
                _local_4[_local_6] = (_local_3[_local_6] ^ 0x36363636);
                _local_5[_local_6] = (_local_3[_local_6] ^ 0x5C5C5C5C);
                _local_6++;
            };
            var _local_7:* = this.binb_sha512(_local_4.concat(this.rstr2binb(_arg_2)), (0x0400 + (_arg_2.length * 8)));
            return (this.binb2rstr(this.binb_sha512(_local_5.concat(_local_7), (0x0400 + 0x0200))));
        }

        private function rstr2hex(input:*):*
        {
            var x:* = undefined;
            try
            {
                this.hexcase;
            }
            catch(e:*)
            {
                hexcase = 0;
            };
            var hex_tab:* = ((this.hexcase) ? "0123456789ABCDEF" : "0123456789abcdef");
            var output:* = "";
            var i:* = 0;
            while (i < input.length)
            {
                x = input.charCodeAt(i);
                output = (output + (hex_tab.charAt(((x >>> 4) & 0x0F)) + hex_tab.charAt((x & 0x0F))));
                i++;
            };
            return (output);
        }

        private function rstr2b64(input:*):*
        {
            var triplet:* = undefined;
            var j:* = undefined;
            try
            {
                this.b64pad;
            }
            catch(e:*)
            {
                b64pad = "";
            };
            var tab:* = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
            var output:* = "";
            var len:* = input.length;
            var i:* = 0;
            while (i < len)
            {
                triplet = (((input.charCodeAt(i) << 16) | (((i + 1) < len) ? (input.charCodeAt((i + 1)) << 8) : 0)) | (((i + 2) < len) ? input.charCodeAt((i + 2)) : 0));
                j = 0;
                while (j < 4)
                {
                    if (((i * 8) + (j * 6)) > (input.length * 8))
                    {
                        output = (output + this.b64pad);
                    }
                    else
                    {
                        output = (output + tab.charAt(((triplet >>> (6 * (3 - j))) & 0x3F)));
                    };
                    j++;
                };
                i = (i + 3);
            };
            return (output);
        }

        private function rstr2any(_arg_1:*, _arg_2:*):*
        {
            var _local_4:*;
            var _local_5:*;
            var _local_6:*;
            var _local_7:*;
            var _local_8:*;
            var _local_3:* = _arg_2.length;
            var _local_9:* = new Array(Math.ceil((_arg_1.length / 2)));
            _local_4 = 0;
            while (_local_4 < _local_9.length)
            {
                _local_9[_local_4] = ((_arg_1.charCodeAt((_local_4 * 2)) << 8) | _arg_1.charCodeAt(((_local_4 * 2) + 1)));
                _local_4++;
            };
            var _local_10:* = Math.ceil(((_arg_1.length * 8) / (Math.log(_arg_2.length) / Math.log(2))));
            var _local_11:* = new Array(_local_10);
            _local_5 = 0;
            while (_local_5 < _local_10)
            {
                _local_8 = new Array();
                _local_7 = 0;
                _local_4 = 0;
                while (_local_4 < _local_9.length)
                {
                    _local_7 = ((_local_7 << 16) + _local_9[_local_4]);
                    _local_6 = Math.floor((_local_7 / _local_3));
                    _local_7 = (_local_7 - (_local_6 * _local_3));
                    if (((_local_8.length > 0) || (_local_6 > 0)))
                    {
                        _local_8[_local_8.length] = _local_6;
                    };
                    _local_4++;
                };
                _local_11[_local_5] = _local_7;
                _local_9 = _local_8;
                _local_5++;
            };
            var _local_12:* = "";
            _local_4 = (_local_11.length - 1);
            while (_local_4 >= 0)
            {
                _local_12 = (_local_12 + _arg_2.charAt(_local_11[_local_4]));
                _local_4--;
            };
            return (_local_12);
        }

        private function str2rstr_utf8(_arg_1:*):*
        {
            var _local_4:*;
            var _local_5:*;
            var _local_2:* = "";
            var _local_3:* = -1;
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

        private function str2rstr_utf16le(_arg_1:*):*
        {
            var _local_2:* = "";
            var _local_3:* = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_2 = (_local_2 + String.fromCharCode((_arg_1.charCodeAt(_local_3) & 0xFF), ((_arg_1.charCodeAt(_local_3) >>> 8) & 0xFF)));
                _local_3++;
            };
            return (_local_2);
        }

        private function str2rstr_utf16be(_arg_1:*):*
        {
            var _local_2:* = "";
            var _local_3:* = 0;
            while (_local_3 < _arg_1.length)
            {
                _local_2 = (_local_2 + String.fromCharCode(((_arg_1.charCodeAt(_local_3) >>> 8) & 0xFF), (_arg_1.charCodeAt(_local_3) & 0xFF)));
                _local_3++;
            };
            return (_local_2);
        }

        private function rstr2binb(_arg_1:*):*
        {
            var _local_3:*;
            var _local_2:* = new Array((_arg_1.length >> 2));
            _local_3 = 0;
            while (_local_3 < _local_2.length)
            {
                _local_2[_local_3] = 0;
                _local_3++;
            };
            _local_3 = 0;
            while (_local_3 < (_arg_1.length * 8))
            {
                _local_2[(_local_3 >> 5)] = (_local_2[(_local_3 >> 5)] | ((_arg_1.charCodeAt((_local_3 / 8)) & 0xFF) << (24 - (_local_3 % 32))));
                _local_3 = (_local_3 + 8);
            };
            return (_local_2);
        }

        private function binb2rstr(_arg_1:*):*
        {
            var _local_2:* = "";
            var _local_3:* = 0;
            while (_local_3 < (_arg_1.length * 32))
            {
                _local_2 = (_local_2 + String.fromCharCode(((_arg_1[(_local_3 >> 5)] >>> (24 - (_local_3 % 32))) & 0xFF)));
                _local_3 = (_local_3 + 8);
            };
            return (_local_2);
        }

        private function binb_sha512(_arg_1:*, _arg_2:*):*
        {
            var _local_21:*;
            var _local_22:*;
            if (this.sha512_k == undefined)
            {
                this.sha512_k = new Array(new Int64(1116352408, -685199838), new Int64(1899447441, 602891725), new Int64(-1245643825, -330482897), new Int64(-373957723, -2121671748), new Int64(961987163, -213338824), new Int64(1508970993, -1241133031), new Int64(-1841331548, -1357295717), new Int64(-1424204075, -630357736), new Int64(-670586216, -1560083902), new Int64(310598401, 1164996542), new Int64(607225278, 1323610764), new Int64(1426881987, -704662302), new Int64(1925078388, -226784913), new Int64(-2132889090, 991336113), new Int64(-1680079193, 633803317), new Int64(-1046744716, -815192428), new Int64(-459576895, -1628353838), new Int64(-272742522, 944711139), new Int64(264347078, -1953704523), new Int64(604807628, 2007800933), new Int64(770255983, 1495990901), new Int64(1249150122, 1856431235), new Int64(1555081692, -1119749164), new Int64(1996064986, -2096016459), new Int64(-1740746414, -295247957), new Int64(-1473132947, 766784016), new Int64(-1341970488, -1728372417), new Int64(-1084653625, -1091629340), new Int64(-958395405, 1034457026), new Int64(-710438585, -1828018395), new Int64(113926993, -536640913), new Int64(338241895, 168717936), new Int64(666307205, 1188179964), new Int64(773529912, 1546045734), new Int64(1294757372, 1522805485), new Int64(1396182291, -1651133473), new Int64(1695183700, -1951439906), new Int64(1986661051, 1014477480), new Int64(-2117940946, 1206759142), new Int64(-1838011259, 344077627), new Int64(-1564481375, 1290863460), new Int64(-1474664885, -1136513023), new Int64(-1035236496, -789014639), new Int64(-949202525, 106217008), new Int64(-778901479, -688958952), new Int64(-694614492, 1432725776), new Int64(-200395387, 1467031594), new Int64(275423344, 851169720), new Int64(430227734, -1194143544), new Int64(506948616, 1363258195), new Int64(659060556, -544281703), new Int64(883997877, -509917016), new Int64(958139571, -976659869), new Int64(1322822218, -482243893), new Int64(1537002063, 2003034995), new Int64(1747873779, -692930397), new Int64(1955562222, 1575990012), new Int64(2024104815, 1125592928), new Int64(-2067236844, -1578062990), new Int64(-1933114872, 442776044), new Int64(-1866530822, 593698344), new Int64(-1538233109, -561857047), new Int64(-1090935817, -1295615723), new Int64(-965641998, -479046869), new Int64(-903397682, -366583396), new Int64(-779700025, 566280711), new Int64(-354779690, -840897762), new Int64(-176337025, -294727304), new Int64(116418474, 1914138554), new Int64(174292421, -1563912026), new Int64(289380356, -1090974290), new Int64(460393269, 320620315), new Int64(685471733, 587496836), new Int64(852142971, 1086792851), new Int64(1017036298, 365543100), new Int64(1126000580, -1676669620), new Int64(1288033470, -885112138), new Int64(1501505948, -60457430), new Int64(1607167915, 987167468), new Int64(1816402316, 1246189591));
            };
            var _local_3:* = new Array(new Int64(1779033703, -205731576), new Int64(-1150833019, -2067093701), new Int64(1013904242, -23791573), new Int64(-1521486534, 1595750129), new Int64(1359893119, -1377402159), new Int64(-1694144372, 725511199), new Int64(528734635, -79577749), new Int64(1541459225, 327033209));
            var _local_4:* = new Int64(0, 0);
            var _local_5:* = new Int64(0, 0);
            var _local_6:* = new Int64(0, 0);
            var _local_7:* = new Int64(0, 0);
            var _local_8:* = new Int64(0, 0);
            var _local_9:* = new Int64(0, 0);
            var _local_10:* = new Int64(0, 0);
            var _local_11:* = new Int64(0, 0);
            var _local_12:* = new Int64(0, 0);
            var _local_13:* = new Int64(0, 0);
            var _local_14:* = new Int64(0, 0);
            var _local_15:* = new Int64(0, 0);
            var _local_16:* = new Int64(0, 0);
            var _local_17:* = new Int64(0, 0);
            var _local_18:* = new Int64(0, 0);
            var _local_19:* = new Int64(0, 0);
            var _local_20:* = new Int64(0, 0);
            var _local_23:* = new Array(80);
            _local_22 = 0;
            while (_local_22 < 80)
            {
                _local_23[_local_22] = new Int64(0, 0);
                _local_22++;
            };
            _arg_1[(_arg_2 >> 5)] = (_arg_1[(_arg_2 >> 5)] | (128 << (24 - (_arg_2 & 0x1F))));
            _arg_1[((((_arg_2 + 128) >> 10) << 5) + 31)] = _arg_2;
            _local_22 = 0;
            while (_local_22 < _arg_1.length)
            {
                _local_6.copy(_local_3[0]);
                _local_7.copy(_local_3[1]);
                _local_8.copy(_local_3[2]);
                _local_9.copy(_local_3[3]);
                _local_10.copy(_local_3[4]);
                _local_11.copy(_local_3[5]);
                _local_12.copy(_local_3[6]);
                _local_13.copy(_local_3[7]);
                _local_21 = 0;
                while (_local_21 < 16)
                {
                    _local_23[_local_21].h = _arg_1[(_local_22 + (2 * _local_21))];
                    _local_23[_local_21].l = _arg_1[((_local_22 + (2 * _local_21)) + 1)];
                    _local_21++;
                };
                _local_21 = 16;
                while (_local_21 < 80)
                {
                    _local_18.rrot(_local_23[(_local_21 - 2)], 19);
                    _local_19.revrrot(_local_23[(_local_21 - 2)], 29);
                    _local_20.shr(_local_23[(_local_21 - 2)], 6);
                    _local_15.l = ((_local_18.l ^ _local_19.l) ^ _local_20.l);
                    _local_15.h = ((_local_18.h ^ _local_19.h) ^ _local_20.h);
                    _local_18.rrot(_local_23[(_local_21 - 15)], 1);
                    _local_19.rrot(_local_23[(_local_21 - 15)], 8);
                    _local_20.shr(_local_23[(_local_21 - 15)], 7);
                    _local_14.l = ((_local_18.l ^ _local_19.l) ^ _local_20.l);
                    _local_14.h = ((_local_18.h ^ _local_19.h) ^ _local_20.h);
                    _local_23[_local_21].add4(_local_15, _local_23[(_local_21 - 7)], _local_14, _local_23[(_local_21 - 16)]);
                    _local_21++;
                };
                _local_21 = 0;
                while (_local_21 < 80)
                {
                    _local_16.l = ((_local_10.l & _local_11.l) ^ ((~(_local_10.l)) & _local_12.l));
                    _local_16.h = ((_local_10.h & _local_11.h) ^ ((~(_local_10.h)) & _local_12.h));
                    _local_18.rrot(_local_10, 14);
                    _local_19.rrot(_local_10, 18);
                    _local_20.revrrot(_local_10, 9);
                    _local_15.l = ((_local_18.l ^ _local_19.l) ^ _local_20.l);
                    _local_15.h = ((_local_18.h ^ _local_19.h) ^ _local_20.h);
                    _local_18.rrot(_local_6, 28);
                    _local_19.revrrot(_local_6, 2);
                    _local_20.revrrot(_local_6, 7);
                    _local_14.l = ((_local_18.l ^ _local_19.l) ^ _local_20.l);
                    _local_14.h = ((_local_18.h ^ _local_19.h) ^ _local_20.h);
                    _local_17.l = (((_local_6.l & _local_7.l) ^ (_local_6.l & _local_8.l)) ^ (_local_7.l & _local_8.l));
                    _local_17.h = (((_local_6.h & _local_7.h) ^ (_local_6.h & _local_8.h)) ^ (_local_7.h & _local_8.h));
                    _local_4.add5(_local_13, _local_15, _local_16, this.sha512_k[_local_21], _local_23[_local_21]);
                    _local_5.add(_local_14, _local_17);
                    _local_13.copy(_local_12);
                    _local_12.copy(_local_11);
                    _local_11.copy(_local_10);
                    _local_10.add(_local_9, _local_4);
                    _local_9.copy(_local_8);
                    _local_8.copy(_local_7);
                    _local_7.copy(_local_6);
                    _local_6.add(_local_4, _local_5);
                    _local_21++;
                };
                _local_3[0].add(_local_3[0], _local_6);
                _local_3[1].add(_local_3[1], _local_7);
                _local_3[2].add(_local_3[2], _local_8);
                _local_3[3].add(_local_3[3], _local_9);
                _local_3[4].add(_local_3[4], _local_10);
                _local_3[5].add(_local_3[5], _local_11);
                _local_3[6].add(_local_3[6], _local_12);
                _local_3[7].add(_local_3[7], _local_13);
                _local_22 = (_local_22 + 32);
            };
            var _local_24:* = new Array(16);
            _local_22 = 0;
            while (_local_22 < 8)
            {
                _local_24[(2 * _local_22)] = _local_3[_local_22].h;
                _local_24[((2 * _local_22) + 1)] = _local_3[_local_22].l;
                _local_22++;
            };
            return (_local_24);
        }


    }
}//package com.hbm.socialmodule.connection.crypto

