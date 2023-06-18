


//com.hbm.socialmodule.connection.socialapi.fotostrana.requests.GetProfilesRequest

package com.hbm.socialmodule.connection.socialapi.fotostrana.requests
{
    import com.adobe.crypto.MD5;
    import com.hbm.socialmodule.data.UserObject;
    import com.hbm.socialmodule.connection.ResponseEvent;

    public class GetProfilesRequest extends AbstractFsRequest 
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
            RequestVariables.appId = EnvironmentVarsMap.apiId;
            RequestVariables.format = "JSON";
            RequestVariables.fields = "user_name,user_lastname,photo_small,user_link";
            RequestVariables.method = "User.getProfiles";
            RequestVariables.rand = (Math.random() * 1000);
            RequestVariables.timestamp = new Date().getTime();
            RequestVariables.userIds = _local_1;
            RequestVariables.sig = this.CreateSignatureString();
        }

        private function CreateSignatureString():String
        {
            var _local_1:String = (((((((((((((((EnvironmentVarsMap.viewerId + "appId=") + RequestVariables.appId) + "fields=") + RequestVariables.fields) + "format=") + RequestVariables.format) + "method=") + RequestVariables.method) + "rand=") + RequestVariables.rand) + "timestamp=") + RequestVariables.timestamp) + "userIds=") + RequestVariables.userIds) + EnvironmentVarsMap.clientSecret);
            return (MD5.hash(_local_1));
        }

        override protected function FormatAnswer(_arg_1:Object):void
        {
            var _local_2:Object;
            var _local_3:UserObject;
            if (_arg_1)
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
            _local_2.Name = _arg_1.user_name;
            _local_2.LastName = _arg_1.user_lastname;
            _local_2.Id = _arg_1.user_id;
            _local_2.Photo = _arg_1.photo_small;
            _local_2.Link = ("http://fotostrana.ru/user/" + _arg_1.user_id);
            return (_local_2);
        }

        override public function get EventType():String
        {
            return (ResponseEvent.GET_PROFILES);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.fotostrana.requests

