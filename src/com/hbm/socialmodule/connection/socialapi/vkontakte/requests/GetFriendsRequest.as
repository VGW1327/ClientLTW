


//com.hbm.socialmodule.connection.socialapi.vkontakte.requests.GetFriendsRequest

package com.hbm.socialmodule.connection.socialapi.vkontakte.requests
{
    import com.adobe.crypto.MD5;
    import com.hbm.socialmodule.connection.ResponseEvent;

    public class GetFriendsRequest extends AbstractVkoRequest 
    {

        public function GetFriendsRequest(_arg_1:Object)
        {
            super(_arg_1);
        }

        override protected function PrepareRequestData():void
        {
            RequestVariables.api_id = EnvironmentVarsMap["api_id"];
            RequestVariables.v = "3.0";
            RequestVariables.format = "JSON";
            RequestVariables.method = "friends.getAppUsers";
            RequestVariables.sig = this.CreateSignatureString();
            RequestVariables.sid = EnvironmentVarsMap["sid"];
        }

        private function CreateSignatureString():String
        {
            var _local_1:String = (((((((((EnvironmentVarsMap["viewer_id"] + "api_id=") + RequestVariables.api_id) + "format=") + RequestVariables.format) + "method=") + RequestVariables.method) + "v=") + RequestVariables.v) + EnvironmentVarsMap["secret"]);
            return (MD5.hash(_local_1));
        }

        override protected function FormatAnswer(_arg_1:Object):void
        {
            FinishRequest((_arg_1 as Array));
        }

        override public function get EventType():String
        {
            return (ResponseEvent.GET_FRIENDS);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.vkontakte.requests

