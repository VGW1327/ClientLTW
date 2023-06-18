


//com.hbm.socialmodule.connection.socialapi.odnkl.OdklAccessSettings

package com.hbm.socialmodule.connection.socialapi.odnkl
{
    import com.hbm.socialmodule.connection.socialapi.AccessSettings;

    public class OdklAccessSettings implements AccessSettings 
    {

        public static var PUBLISH_TO_STREAM:String = "PUBLISH TO STREAM";
        public static var PHOTO_CONTENT:String = "PHOTO CONTENT";
        public static var SET_STATUS:String = "SET STATUS";
        public static var MESSAGING:String = "MESSAGING";

        private var _permissions:Array;


        public function FriendListAccess():Boolean
        {
            return (true);
        }

        public function CheckCurrentSettings():Boolean
        {
            return (true);
        }

        public function get permissions():Array
        {
            return (this._permissions);
        }

        public function set permissions(_arg_1:Array):void
        {
            this._permissions = _arg_1;
        }

        public function addPermission(_arg_1:String):void
        {
            if (!this.ifContains(_arg_1))
            {
                this._permissions.push(_arg_1);
            };
        }

        private function ifContains(_arg_1:String):Boolean
        {
            var _local_2:String;
            for (_local_2 in this._permissions)
            {
                if (_local_2 == _arg_1)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function WallAccess():Boolean
        {
            return (true);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.odnkl

