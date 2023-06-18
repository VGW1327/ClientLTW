


//com.hbm.socialmodule.connection.socialapi.web.WebAccessSettings

package com.hbm.socialmodule.connection.socialapi.web
{
    import com.hbm.socialmodule.connection.socialapi.AccessSettings;

    public class WebAccessSettings implements AccessSettings 
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
}//package com.hbm.socialmodule.connection.socialapi.web

