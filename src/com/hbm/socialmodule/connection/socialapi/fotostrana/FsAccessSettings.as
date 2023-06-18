


//com.hbm.socialmodule.connection.socialapi.fotostrana.FsAccessSettings

package com.hbm.socialmodule.connection.socialapi.fotostrana
{
    import com.hbm.socialmodule.connection.socialapi.AccessSettings;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import com.hbm.socialmodule.connection.socialapi.*;

    public class FsAccessSettings implements AccessSettings 
    {

        private static const logger:ILogger = getLogger(FsAccessSettings);

        private const _notify:uint = 32;
        private const _silent_billing:uint = 64;
        private const _userwall:uint = 2;
        private const _usercommunities:uint = 4;
        private const _userphoto:uint = 128;
        private const _usermail:uint = 0x0200;

        private var _appVars:Object;
        private var _preferredSettings:uint = 0;
        private var _currentSettings:uint;

        public function FsAccessSettings(_arg_1:Object)
        {
            this._appVars = _arg_1;
            this._preferredSettings = (this._notify | this._userwall);
            this._currentSettings = _arg_1["apiSettings"];
            logger.debug(("_currentSettings " + this._currentSettings));
        }

        public function FriendListAccess():Boolean
        {
            return (true);
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
            return (!((this._appVars["apiSettings"] & this._userwall) == 0));
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.fotostrana

