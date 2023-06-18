


//com.hbm.socialmodule.connection.socialapi.vkontakte.requests.GetCityRequest

package com.hbm.socialmodule.connection.socialapi.vkontakte.requests
{
    import com.adobe.crypto.MD5;

    public class GetCityRequest extends AbstractVkoRequest 
    {

        private var _cityId:String;

        public function GetCityRequest(_arg_1:Object, _arg_2:String)
        {
            super(_arg_1);
            this._cityId = _arg_2;
        }

        override protected function PrepareRequestData():void
        {
            RequestVariables.api_id = EnvironmentVarsMap["api_id"];
            RequestVariables.v = "3.0";
            RequestVariables.format = "JSON";
            RequestVariables.method = "places.getCityById";
            RequestVariables.cids = this._cityId;
            RequestVariables.sig = this.CreateSignatureString();
            RequestVariables.sid = EnvironmentVarsMap["sid"];
        }

        private function CreateSignatureString():String
        {
            var _local_1:String = EnvironmentVarsMap["secret"];
            var _local_2:String = (((((((((((EnvironmentVarsMap["viewer_id"] + "api_id=") + RequestVariables.api_id) + "cids=") + RequestVariables.cids) + "format=") + RequestVariables.format) + "method=") + RequestVariables.method) + "v=") + RequestVariables.v) + _local_1);
            return (MD5.hash(_local_2));
        }

        override protected function FormatAnswer(_arg_1:Object):void
        {
            var _local_2:* = "";
            if ((_arg_1 is Array))
            {
                _local_2 = _arg_1[0].name;
            }
            else
            {
                _local_2 = "null";
            };
            FinishRequest(_local_2);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.vkontakte.requests

