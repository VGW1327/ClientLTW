


//com.adobe.utils.DictionaryUtil

package com.adobe.utils
{
    import flash.utils.Dictionary;

    public class DictionaryUtil 
    {


        public static function getKeys(_arg_1:Dictionary):Array
        {
            var _local_3:Object;
            var _local_2:Array = new Array();
            for (_local_3 in _arg_1)
            {
                _local_2.push(_local_3);
            };
            return (_local_2);
        }

        public static function getValues(_arg_1:Dictionary):Array
        {
            var _local_3:Object;
            var _local_2:Array = new Array();
            for each (_local_3 in _arg_1)
            {
                _local_2.push(_local_3);
            };
            return (_local_2);
        }


    }
}//package com.adobe.utils

