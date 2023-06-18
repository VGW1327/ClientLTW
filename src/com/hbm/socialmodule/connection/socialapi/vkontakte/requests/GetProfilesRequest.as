


//com.hbm.socialmodule.connection.socialapi.vkontakte.requests.GetProfilesRequest

package com.hbm.socialmodule.connection.socialapi.vkontakte.requests
{
    import com.adobe.crypto.MD5;
    import com.hbm.socialmodule.data.UserObject;
    import com.hbm.socialmodule.connection.ResponseEvent;

    public class GetProfilesRequest extends AbstractVkoRequest 
    {

        private var _idList:Array;
        private var _users:Array;

        public function GetProfilesRequest(_arg_1:Object, _arg_2:Array)
        {
            super(_arg_1);
            this._users = [];
            this._idList = _arg_2;
        }

        override protected function PrepareRequestData():void
        {
            var _local_2:String;
            var _local_1:* = "";
            for each (_local_2 in this._idList)
            {
                _local_1 = _local_1.concat(("," + _local_2));
            };
            _local_1 = _local_1.slice(1);
            RequestVariables.api_id = EnvironmentVarsMap["api_id"];
            RequestVariables.v = "3.0";
            RequestVariables.fields = "first_name,last_name,photo_rec";
            RequestVariables.format = "JSON";
            RequestVariables.method = "getProfiles";
            RequestVariables.uids = _local_1;
            RequestVariables.sig = this.CreateSignatureString();
            RequestVariables.sid = EnvironmentVarsMap["sid"];
        }

        private function CreateSignatureString():String
        {
            var _local_1:String = (((((((((((((EnvironmentVarsMap["viewer_id"] + "api_id=") + RequestVariables.api_id) + "fields=") + RequestVariables.fields) + "format=") + RequestVariables.format) + "method=") + RequestVariables.method) + "uids=") + RequestVariables.uids) + "v=") + RequestVariables.v) + EnvironmentVarsMap["secret"]);
            return (MD5.hash(_local_1));
        }

        override protected function FormatAnswer(_arg_1:Object):void
        {
            var _local_2:Object;
            var _local_3:UserObject;
            if ((_arg_1 is Array))
            {
                for each (_local_2 in _arg_1)
                {
                    _local_3 = this.CreateUserObject(_local_2);
                    this._users.push(_local_3);
                };
            };
            FinishRequest(this._users);
        }

        private function CreateUserObject(_arg_1:Object):UserObject
        {
            var _local_2:UserObject = new UserObject();
            _local_2.Name = _arg_1.first_name;
            _local_2.LastName = _arg_1.last_name;
            _local_2.Id = _arg_1.uid;
            _local_2.Photo = _arg_1.photo_rec;
            _local_2.Link = ("http://vkontakte.ru/id" + _arg_1.uid);
            return (_local_2);
        }

        override public function get EventType():String
        {
            return (ResponseEvent.GET_PROFILES);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.vkontakte.requests

