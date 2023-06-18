


//com.hbm.socialmodule.connection.socialapi.fotostrana.requests.WallPostRequest

package com.hbm.socialmodule.connection.socialapi.fotostrana.requests
{
    import com.adobe.crypto.MD5;
    import com.hbm.socialmodule.connection.ResponseEvent;

    public class WallPostRequest extends AbstractFsRequest 
    {

        private var _text:String;
        private var _image:String;
        private var _url:String;

        public function WallPostRequest(_arg_1:Object, _arg_2:String, _arg_3:String, _arg_4:String)
        {
            super(_arg_1);
            this._text = _arg_2;
            this._image = _arg_3;
            this._url = _arg_4;
        }

        override protected function PrepareRequestData():void
        {
            RequestVariables.appId = EnvironmentVarsMap.apiId;
            RequestVariables.format = "JSON";
            RequestVariables.imgUrl = this._image;
            RequestVariables.rand = (Math.random() * 1000);
            RequestVariables.timestamp = new Date().getTime();
            RequestVariables.method = "WallUser.appPostImage";
            RequestVariables.text = ((this._text + " ") + this._url);
            RequestVariables.sig = this.CreateSignatureString();
        }

        private function CreateSignatureString():String
        {
            var _local_1:String = (((((((((((((((EnvironmentVarsMap.viewerId + "appId=") + RequestVariables.appId) + "format=") + RequestVariables.format) + "imgUrl=") + RequestVariables.imgUrl) + "method=") + RequestVariables.method) + "rand=") + RequestVariables.rand) + "text=") + RequestVariables.text) + "timestamp=") + RequestVariables.timestamp) + EnvironmentVarsMap.clientSecret);
            return (MD5.hash(_local_1));
        }

        override protected function FormatAnswer(_arg_1:Object):void
        {
            FinishRequest((_arg_1 as Array));
        }

        override public function get EventType():String
        {
            return (ResponseEvent.WALL_POST);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.fotostrana.requests

