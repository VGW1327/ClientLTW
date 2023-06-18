


//com.hbm.socialmodule.connection.socialapi.facebook.FacebookAccessSettings

package com.hbm.socialmodule.connection.socialapi.facebook
{
    import com.hbm.socialmodule.connection.socialapi.AccessSettings;

    public class FacebookAccessSettings implements AccessSettings 
    {


        public function FriendListAccess():Boolean
        {
            return (true);
        }

        public function CheckCurrentSettings():Boolean
        {
            return (true);
        }

        public function WallAccess():Boolean
        {
            return (true);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.facebook

