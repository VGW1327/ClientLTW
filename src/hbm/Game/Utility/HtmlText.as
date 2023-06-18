


//hbm.Game.Utility.HtmlText

package hbm.Game.Utility
{
    import flash.filters.GlowFilter;
    import flash.filters.DropShadowFilter;
    import flash.filters.ColorMatrixFilter;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.filters.BitmapFilterQuality;

    public class HtmlText 
    {

        public static const glow:GlowFilter = getGlowFilter();
        public static const shadow:DropShadowFilter = getDropShadowFilter();
        public static const shadow2:DropShadowFilter = getDropShadow2Filter();
        public static const gray:ColorMatrixFilter = getGrayFilter();
        public static const fontName:String = "Tahoma";


        public static function declination(_arg_1:int, _arg_2:Array):String
        {
            if (((_arg_2 == null) || (_arg_2.length < 3)))
            {
                return ("");
            };
            var _local_3:int = (_arg_1 % 100);
            if (((_local_3 < 10) || (_local_3 > 20)))
            {
                _local_3 = (_arg_1 % 10);
                if (_local_3 == 0)
                {
                    return (_arg_2[0]);
                };
                if (_local_3 == 1)
                {
                    return (_arg_2[1]);
                };
                if (_local_3 < 5)
                {
                    return (_arg_2[2]);
                };
            };
            return (_arg_2[3]);
        }

        public static function update(_arg_1:String, _arg_2:Boolean=false, _arg_3:int=12, _arg_4:String="Tahoma", _arg_5:String="#CCCCE4"):String
        {
            var _local_6:* = "";
            if (_arg_2)
            {
                _local_6 = (_local_6 + "<b>");
            };
            _local_6 = (_local_6 + (((("<font face='" + _arg_4) + "' size = '") + _arg_3) + "'"));
            if (_arg_5)
            {
                _local_6 = (_local_6 + ((" color = '" + _arg_5) + "'"));
            };
            _local_6 = (_local_6 + ((">" + _arg_1) + "</font>"));
            if (_arg_2)
            {
                _local_6 = (_local_6 + "</b>");
            };
            return (_local_6);
        }

        public static function fixTags(_arg_1:String):String
        {
            var _local_2:* = "";
            return (_arg_1.replace(new RegExp("<", "g"), "&lt;").replace(new RegExp(">", "g"), "&gt;"));
        }

        public static function fixReservedSymbols(_arg_1:String):String
        {
            var _local_2:RegExp = /#([0-9]+)/g;
            return (_arg_1.replace(_local_2, "&#35;$1"));
        }

        public static function Localize(_arg_1:String):String
        {
            var _local_2:RegExp = /#([0-9]+)/g;
            return (_arg_1.replace(_local_2, replFN));
        }

        private static function replFN():String
        {
            var _local_5:AdditionalDataResourceLibrary;
            var _local_2:String = arguments[1];
            var _local_3:int = arguments[2];
            var _local_4:String = arguments[3];
            if (((((arguments.length - 3) == 1) && (_local_3 > 0)) && (_local_4.charAt((_local_4.indexOf(arguments[0]) - 1)) == "&")))
            {
                return (arguments[0]);
            };
            _local_5 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_6:Object = _local_5.GetAnnounceData(_local_2);
            return (((_local_6 != null) ? _local_6["message"] : "??") + " ");
        }

        private static function getGlowFilter():GlowFilter
        {
            var _local_1:Number = 0;
            var _local_2:Number = 1;
            var _local_3:Number = 2;
            var _local_4:Number = 2;
            var _local_5:Number = 10;
            var _local_6:Boolean;
            var _local_7:Boolean;
            var _local_8:Number = BitmapFilterQuality.LOW;
            return (new GlowFilter(_local_1, _local_2, _local_3, _local_4, _local_5, _local_8, _local_6, _local_7));
        }

        private static function getDropShadowFilter():DropShadowFilter
        {
            var _local_1:Number = 0;
            var _local_2:Number = 45;
            var _local_3:Number = 1;
            var _local_4:Number = 2;
            var _local_5:Number = 2;
            var _local_6:Number = 1.3;
            var _local_7:Number = 2;
            var _local_8:Boolean;
            var _local_9:Boolean;
            var _local_10:Number = BitmapFilterQuality.LOW;
            return (new DropShadowFilter(_local_6, _local_2, _local_1, _local_3, _local_4, _local_5, _local_7, _local_10, _local_8, _local_9));
        }

        private static function getDropShadow2Filter():DropShadowFilter
        {
            var _local_1:Number = 0;
            var _local_2:Number = 90;
            var _local_3:Number = 1;
            var _local_4:Number = 2.5;
            var _local_5:Number = 2.5;
            var _local_6:Number = 1.5;
            var _local_7:Number = 1.5;
            var _local_8:Boolean;
            var _local_9:Boolean;
            var _local_10:Number = BitmapFilterQuality.LOW;
            return (new DropShadowFilter(_local_6, _local_2, _local_1, _local_3, _local_4, _local_5, _local_7, _local_10, _local_8, _local_9));
        }

        private static function getGrayFilter():ColorMatrixFilter
        {
            var _local_1:Array = [0.33, 0.59, 0.11, 0, 0, 0.33, 0.59, 0.11, 0, 0, 0.33, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
            return (new ColorMatrixFilter(_local_1));
        }

        public static function combineRGB(_arg_1:Number, _arg_2:Number, _arg_3:Number):uint
        {
            if (_arg_1 > 0xFF)
            {
                _arg_1 = 0xFF;
            };
            if (_arg_2 > 0xFF)
            {
                _arg_2 = 0xFF;
            };
            if (_arg_3 > 0xFF)
            {
                _arg_3 = 0xFF;
            };
            if (_arg_1 < 0)
            {
                _arg_1 = 0;
            };
            if (_arg_2 < 0)
            {
                _arg_2 = 0;
            };
            if (_arg_3 < 0)
            {
                _arg_3 = 0;
            };
            return (((_arg_1 << 16) | (_arg_2 << 8)) | _arg_3);
        }

        public static function combineRGBFromHex(_arg_1:String):uint
        {
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            if (_arg_1.indexOf("#") == 0)
            {
                _local_2 = int(("0x" + _arg_1.substr(1, 2)));
                _local_3 = int(("0x" + _arg_1.substr(3, 2)));
                _local_4 = int(("0x" + _arg_1.substr(5, 2)));
            };
            if (_local_2 > 0xFF)
            {
                _local_2 = 0xFF;
            };
            if (_local_3 > 0xFF)
            {
                _local_3 = 0xFF;
            };
            if (_local_4 > 0xFF)
            {
                _local_4 = 0xFF;
            };
            if (_local_2 < 0)
            {
                _local_2 = 0;
            };
            if (_local_3 < 0)
            {
                _local_3 = 0;
            };
            if (_local_4 < 0)
            {
                _local_4 = 0;
            };
            return (((_local_2 << 16) | (_local_3 << 8)) | _local_4);
        }

        public static function getNumberAsHexString(_arg_1:uint, _arg_2:uint=1, _arg_3:Boolean=true):String
        {
            var _local_4:String = _arg_1.toString(16).toUpperCase();
            while (_arg_2 > _local_4.length)
            {
                _local_4 = ("0" + _local_4);
            };
            if (_arg_3)
            {
                _local_4 = ("0x" + _local_4);
            };
            return (_local_4);
        }

        public static function GetText(_arg_1:String, _arg_2:Object=null, _arg_3:Object=null, _arg_4:Object=null):String
        {
            if (_arg_2 != null)
            {
                _arg_1 = _arg_1.replace("%val1%", _arg_2.toString());
            };
            if (_arg_3 != null)
            {
                _arg_1 = _arg_1.replace("%val2%", _arg_3.toString());
            };
            if (_arg_4 != null)
            {
                _arg_1 = _arg_1.replace("%val3%", _arg_4.toString());
            };
            return (_arg_1);
        }

        public static function ConvertExp(_arg_1:int):String
        {
            var _local_7:int;
            var _local_2:String = _arg_1.toString();
            var _local_3:* = "";
            var _local_4:int = int((_local_2.length % 3));
            var _local_5:int;
            var _local_6:int;
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_3 = (_local_3 + _local_2.charAt(_local_5));
                _local_5++;
            };
            _local_5 = _local_4;
            while (_local_5 < _local_2.length)
            {
                _local_7 = (_local_6 % 3);
                if (_local_7 == 0)
                {
                    _local_3 = (_local_3 + ".");
                };
                _local_3 = (_local_3 + _local_2.charAt(_local_5));
                _local_6++;
                _local_5++;
            };
            if (_local_3.charAt(0) == ".")
            {
                _local_3 = _local_3.replace(".", "");
            };
            return (_local_3);
        }


    }
}//package hbm.Game.Utility

