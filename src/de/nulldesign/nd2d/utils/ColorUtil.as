


//de.nulldesign.nd2d.utils.ColorUtil

package de.nulldesign.nd2d.utils
{
    public class ColorUtil 
    {


        public static function hex2rgb(_arg_1:uint):Object
        {
            return ({
                "r":(_arg_1 >> 16),
                "g":((_arg_1 >> 8) & 0xFF),
                "b":(_arg_1 & 0xFF)
            });
        }

        public static function rgb2hex(_arg_1:uint, _arg_2:uint, _arg_3:uint):Number
        {
            return (((_arg_1 << 16) | (_arg_2 << 8)) | _arg_3);
        }

        public static function mixColors(_arg_1:Number, _arg_2:Number, _arg_3:Number):Number
        {
            _arg_3 = Math.max(0, _arg_3);
            _arg_3 = Math.min(1, _arg_3);
            var _local_4:Object = hex2rgb(_arg_1);
            var _local_5:Object = hex2rgb(_arg_2);
            return (rgb2hex(((_local_4.r * (1 - _arg_3)) + (_local_5.r * _arg_3)), ((_local_4.g * (1 - _arg_3)) + (_local_5.g * _arg_3)), ((_local_4.b * (1 - _arg_3)) + (_local_5.b * _arg_3))));
        }

        public static function r(_arg_1:Number):Number
        {
            return ((_arg_1 >> 16) / 0xFF);
        }

        public static function g(_arg_1:Number):Number
        {
            return (((_arg_1 >> 8) & 0xFF) / 0xFF);
        }

        public static function b(_arg_1:Number):Number
        {
            return ((_arg_1 & 0xFF) / 0xFF);
        }

        public static function colorWithAlphaFromColor(_arg_1:uint, _arg_2:Number):uint
        {
            return (_arg_1 | ((_arg_2 * 0xFF) << 24));
        }


    }
}//package de.nulldesign.nd2d.utils

