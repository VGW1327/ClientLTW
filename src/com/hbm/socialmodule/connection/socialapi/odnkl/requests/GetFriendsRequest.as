


//com.hbm.socialmodule.connection.socialapi.odnkl.requests.GetFriendsRequest

package com.hbm.socialmodule.connection.socialapi.odnkl.requests
{
    import com.hbm.socialmodule.connection.socialapi.SocialSystemRequest;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.net.URLVariables;

    public class GetFriendsRequest extends AbstractOdklRequest implements SocialSystemRequest 
    {

        public function GetFriendsRequest(_arg_1:Object)
        {
            super(_arg_1);
        }

        public function get EventType():String
        {
            return (ResponseEvent.GET_FRIENDS);
        }

        public function GetRequestVariables(_arg_1:String):URLVariables
        {
            this.SetRequestVars();
            var _local_2:String = this.ComposeStringToEncode(_arg_1);
            SetRequestCode(_local_2);
            return (_variables);
        }

        public function ProcessResponse(_arg_1:Object):Object
        {
            var _local_2:Array = _arg_1.uids;
            if (((_local_2) && (_local_2 is Array)))
            {
                return (_local_2);
            };
            return ([]);
        }

        private function SetRequestVars():void
        {
            _variables.method = "friends.getAppUsers";
            _variables.application_key = _flashVars["application_key"];
            _variables.format = "JSON";
            _variables.session_key = _flashVars["session_key"];
        }

        private function ComposeStringToEncode(_arg_1:String):String
        {
            return (((((((("application_key=" + _variables.application_key) + "format=") + _variables.format) + "method=") + _variables.method) + "session_key=") + _variables.session_key) + _arg_1);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.odnkl.requests

