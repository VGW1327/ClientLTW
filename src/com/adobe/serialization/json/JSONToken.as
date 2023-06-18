


//com.adobe.serialization.json.JSONToken

package com.adobe.serialization.json
{
    public class JSONToken 
    {

        private var _type:int;
        private var _value:Object;

        public function JSONToken(type:int=-1 /* JSONTokenType.UNKNOWN */, value:Object=null)
        {
            this._type = type;
            this._value = value;
        }

        public function get type():int
        {
            return this._type;
        }

        public function set type(type:int):void
        {
            this._type = type;
        }

        public function get value():Object
        {
            return this._value;
        }

        public function set value(value:Object):void
        {
            this._value = value;
        }


    }
}//package com.adobe.serialization.json

