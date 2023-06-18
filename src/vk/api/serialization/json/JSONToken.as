


//vk.api.serialization.json.JSONToken

package vk.api.serialization.json
{
    public class JSONToken 
    {

        private var _value:Object;
        private var _type:int;

        public function JSONToken(_arg_1:int=-1, _arg_2:Object=null)
        {
            _type = _arg_1;
            _value = _arg_2;
        }

        public function get value():Object
        {
            return (_value);
        }

        public function get type():int
        {
            return (_type);
        }

        public function set type(_arg_1:int):void
        {
            _type = _arg_1;
        }

        public function set value(_arg_1:Object):void
        {
            _value = _arg_1;
        }


    }
}//package vk.api.serialization.json

