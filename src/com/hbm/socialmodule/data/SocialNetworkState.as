


//com.hbm.socialmodule.data.SocialNetworkState

package com.hbm.socialmodule.data
{
    public class SocialNetworkState 
    {

        public static const VKONTAKTE_API:uint = 1;
        public static const MAILRU_API:uint = 2;
        public static const ODNOKL_API:uint = 3;
        public static const FACEBOOK_API:uint = 4;
        public static const WEB_API:uint = 5;
        public static const FOTOSTRANA_API:uint = 6;
        private static var _instance:SocialNetworkState;

        private var _socialNetworkType:uint;
        private var _idPrefixMap:Array;

        public function SocialNetworkState()
        {
            this.DefinePrefixMap();
        }

        public static function get Instance():SocialNetworkState
        {
            if (!_instance)
            {
                _instance = new (SocialNetworkState)();
            };
            return (_instance);
        }


        private function DefinePrefixMap():void
        {
            this._idPrefixMap = [];
            this._idPrefixMap[VKONTAKTE_API] = "vk";
            this._idPrefixMap[MAILRU_API] = "mm";
            this._idPrefixMap[ODNOKL_API] = "ok";
            this._idPrefixMap[FACEBOOK_API] = "fb";
            this._idPrefixMap[FOTOSTRANA_API] = "fs";
            this._idPrefixMap[WEB_API] = "";
        }

        public function SetNetworkType(_arg_1:uint):void
        {
            this._socialNetworkType = _arg_1;
        }

        public function get ServerIdPrefix():String
        {
            return (this._idPrefixMap[this._socialNetworkType]);
        }


    }
}//package com.hbm.socialmodule.data

