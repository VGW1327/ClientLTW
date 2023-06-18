


//com.hbm.socialmodule.connection.socialapi.mailru.MailruAccessSettings

package com.hbm.socialmodule.connection.socialapi.mailru
{
    import com.hbm.socialmodule.connection.socialapi.AccessSettings;

    public class MailruAccessSettings implements AccessSettings 
    {

        private var _permissions:String;
        private var _preferredPermissions:Array = [];
        private var _appVars:Object;

        public function MailruAccessSettings(_arg_1:Object)
        {
            this._appVars = _arg_1;
            this._permissions = this._appVars["ext_perm"];
        }

        public function FriendListAccess():Boolean
        {
            return (true);
        }

        public function CheckCurrentSettings():Boolean
        {
            return (true);
        }

        public function get permissions():String
        {
            return (this._permissions);
        }

        public function set permissions(_arg_1:String):void
        {
            this._permissions = _arg_1;
        }

        public function get preferredPermissions():Array
        {
            return (this._preferredPermissions);
        }

        public function WallAccess():Boolean
        {
            return (true);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.mailru

