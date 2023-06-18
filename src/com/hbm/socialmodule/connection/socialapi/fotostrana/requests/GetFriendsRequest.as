


//com.hbm.socialmodule.connection.socialapi.fotostrana.requests.GetFriendsRequest

package com.hbm.socialmodule.connection.socialapi.fotostrana.requests
{
    import com.adobe.crypto.MD5;
    import com.hbm.socialmodule.connection.ResponseEvent;

    public class GetFriendsRequest extends AbstractFsRequest 
    {

        public function GetFriendsRequest(_arg_1:Object)
        {
            super(_arg_1);
        }

        override protected function PrepareRequestData():void
        {
            RequestVariables.appId = EnvironmentVarsMap.apiId;
            RequestVariables.format = "JSON";
            RequestVariables.rand = (Math.random() * 1000);
            RequestVariables.timestamp = new Date().getTime();
            RequestVariables.method = "User.getAppFriends";
            RequestVariables.sig = this.CreateSignatureString();
        }

        private function CreateSignatureString():String
        {
            var _local_1:String = (((((((((((EnvironmentVarsMap.viewerId + "appId=") + RequestVariables.appId) + "format=") + RequestVariables.format) + "method=") + RequestVariables.method) + "rand=") + RequestVariables.rand) + "timestamp=") + RequestVariables.timestamp) + EnvironmentVarsMap.clientSecret);
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
}//package com.hbm.socialmodule.connection.socialapi.fotostrana.requests

