


//de.nulldesign.nd2d.utils.NumberUtil

package de.nulldesign.nd2d.utils
{
    public class NumberUtil 
    {


        public static function rnd0_1():Number
        {
            return (Math.random());
        }

        public static function rndMinus1_1():Number
        {
            return (Math.random() - Math.random());
        }

        public static function rndMinMax(_arg_1:Number, _arg_2:Number):Number
        {
            return (_arg_1 + (Math.random() * (_arg_2 - _arg_1)));
        }

        public static function rndMinMaxInt(_arg_1:int, _arg_2:int):int
        {
            return (Math.round(rndMinMax(_arg_1, _arg_2)));
        }

        public static function sin0_1(_arg_1:Number):Number
        {
            return (0.5 + (Math.sin(_arg_1) * 0.5));
        }


    }
}//package de.nulldesign.nd2d.utils

