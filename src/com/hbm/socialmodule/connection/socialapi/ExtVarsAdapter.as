


//com.hbm.socialmodule.connection.socialapi.ExtVarsAdapter

package com.hbm.socialmodule.connection.socialapi
{
    public class ExtVarsAdapter 
    {

        private var _externalVars:Object;
        private var _keys:Object;

        public function ExtVarsAdapter(_arg_1:Object, _arg_2:Object)
        {
            this._keys = _arg_2;
            this._externalVars = _arg_1;
        }

        public function get apiId():String
        {
            return (this._externalVars[this._keys.apiId]);
        }

        public function get viewerId():String
        {
            return (this._externalVars[this._keys.viewerId]);
        }

        public function get isAppInstalled():Boolean
        {
            return (this._externalVars[this._keys.isAppInstalled] == "1");
        }

        public function get authenticationKey():String
        {
            return (this._externalVars[this._keys.authenticationKey]);
        }

        public function get sessionKey():String
        {
            var _local_1:String = this._keys.sessionKey;
            return (this.GetUnreliableValue(_local_1));
        }

        private function GetUnreliableValue(_arg_1:String):String
        {
            return ((_arg_1) ? this._externalVars[_arg_1] : null);
        }

        public function get referrerType():String
        {
            return (this.GetUnreliableValue(this._keys.referrerType));
        }


    }
}//package com.hbm.socialmodule.connection.socialapi

