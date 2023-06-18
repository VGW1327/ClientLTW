


//com.hbm.socialmodule.utils.Utilities

package com.hbm.socialmodule.utils
{
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import com.hbm.socialmodule.connection.crypto.Sha512;
    import com.hbm.socialmodule.connection.crypto.MD5;

    public class Utilities 
    {

        private static const logger:ILogger = getLogger(Utilities);


        public static function dumpObject(_arg_1:*, _arg_2:int=0, _arg_3:String=""):*
        {
            var _local_6:*;
            var _local_7:String;
            var _local_4:* = "";
            var _local_5:int;
            while (_local_5 < _arg_2)
            {
                _local_5++;
                _local_4 = (_local_4 + "\t");
            };
            for (_local_6 in _arg_1)
            {
                _arg_3 = (_arg_3 + ((((_local_4 + "[") + _local_6) + "] => ") + _arg_1[_local_6]));
                _local_7 = dumpObject(_arg_1[_local_6], (_arg_2 + 1));
                if (_local_7 != "")
                {
                    _arg_3 = (_arg_3 + (((" {\n" + _local_7) + _local_4) + "}"));
                };
                _arg_3 = (_arg_3 + "\n");
            };
            if (_arg_2 == 0)
            {
                logger.debug(_arg_3);
            };
            return (_arg_3);
        }

        public static function parseServerAdditionalData(_arg_1:String):Object
        {
            var _local_4:String;
            var _local_5:Array;
            var _local_2:Array = _arg_1.split(",,");
            var _local_3:Object = {};
            for (_local_4 in _local_2)
            {
                _local_5 = _local_2[_local_4].split("::");
                _local_3[_local_5[0]] = _local_5[1];
            };
            return (_local_3);
        }

        public static function B64Sha512(_arg_1:String):String
        {
            var _local_2:Sha512 = new Sha512();
            var _local_3:String = _local_2.b64_sha512(_arg_1);
            return (checkHashOrder(_local_3));
        }

        public static function B64Md5(_arg_1:String):String
        {
            var _local_2:String = MD5.b64_md5(_arg_1);
            return (checkHashOrder(_local_2));
        }

        protected static function checkHashOrder(_arg_1:String):String
        {
            var _local_4:int;
            var _local_5:int;
            var _local_2:int = (_arg_1.length % 8);
            var _local_3:String = _arg_1;
            if (_local_2 != 0)
            {
                _local_4 = (8 - _local_2);
                _local_5 = 0;
                while (_local_5 < _local_4)
                {
                    _local_3 = (_local_3 + "=");
                    _local_5++;
                };
            };
            return (_local_3);
        }


    }
}//package com.hbm.socialmodule.utils

