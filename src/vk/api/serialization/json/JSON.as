


//vk.api.serialization.json.JSON

package vk.api.serialization.json
{
    public class JSON 
    {


        public static function decode(_arg_1:String):*
        {
            var _local_2:JSONDecoder = new JSONDecoder(_arg_1);
            return (_local_2.getValue());
        }

        public static function encode(_arg_1:Object):String
        {
            var _local_2:JSONEncoder = new JSONEncoder(_arg_1);
            return (_local_2.getString());
        }


    }
}//package vk.api.serialization.json

