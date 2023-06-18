


//com.hbm.socialmodule.connection.socialapi.vkontakte.VkoAccessSettings

package com.hbm.socialmodule.connection.socialapi.vkontakte
{
    import com.hbm.socialmodule.connection.socialapi.AccessSettings;
    import com.hbm.socialmodule.connection.socialapi.*;

    public class VkoAccessSettings implements AccessSettings 
    {

        private const _messages:uint = 1;
        private const _friends:uint = 2;
        private const _photo:uint = 4;
        private const _audio:uint = 8;
        private const _video:uint = 16;
        private const _suggestions:uint = 32;
        private const _questions:uint = 64;
        private const _wiki:uint = 128;
        private const _linkInMain:uint = 0x0100;
        private const _status:uint = 0x0400;
        private const _notes:uint = 0x0800;
        private const _wall:uint = 0x2000;

        private var _appVars:Object;
        private var _preferredSettings:uint;
        private var _currentSettings:uint;

        public function VkoAccessSettings(_arg_1:Object)
        {
            this._appVars = _arg_1;
            this._preferredSettings = this._friends;
            this._currentSettings = _arg_1["api_settings"];
        }

        public function FriendListAccess():Boolean
        {
            return (!((this._appVars["api_settings"] & this._friends) == 0));
        }

        public function get PreferredSettings():uint
        {
            return (this._preferredSettings);
        }

        public function get currentSettings():uint
        {
            return (this._currentSettings);
        }

        public function set currentSettings(_arg_1:uint):void
        {
            this._currentSettings = _arg_1;
        }

        public function CheckCurrentSettings():Boolean
        {
            return ((this._currentSettings & this._preferredSettings) == this._preferredSettings);
        }

        public function WallAccess():Boolean
        {
            return (!((this._appVars["api_settings"] & this._wall) == 0));
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.vkontakte

