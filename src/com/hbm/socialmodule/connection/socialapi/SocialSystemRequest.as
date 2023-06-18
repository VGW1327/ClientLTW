


//com.hbm.socialmodule.connection.socialapi.SocialSystemRequest

package com.hbm.socialmodule.connection.socialapi
{
    import flash.net.URLVariables;

    public interface SocialSystemRequest 
    {

        function get EventType():String;
        function GetRequestVariables(_arg_1:String):URLVariables;
        function ProcessResponse(_arg_1:Object):Object;

    }
}//package com.hbm.socialmodule.connection.socialapi

