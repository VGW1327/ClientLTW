


//com.hbm.socialmodule.connection.socialapi.fotostrana.requests.GetUserInfoRequest

package com.hbm.socialmodule.connection.socialapi.fotostrana.requests
{
    import com.hbm.socialmodule.data.UserObject;
    import com.adobe.crypto.MD5;
    import com.hbm.socialmodule.connection.ResponseEvent;

    public class GetUserInfoRequest extends AbstractFsRequest 
    {

        private var _user:UserObject;

        public function GetUserInfoRequest(_arg_1:Object)
        {
            super(_arg_1);
        }

        override protected function PrepareRequestData():void
        {
            RequestVariables.appId = EnvironmentVarsMap.apiId;
            RequestVariables.format = "JSON";
            RequestVariables.fields = "user_name,user_lastname,city_name,birthday,photo_small,sex,user_link";
            RequestVariables.method = "User.getProfiles";
            RequestVariables.rand = (Math.random() * 1000);
            RequestVariables.timestamp = new Date().getTime();
            RequestVariables.userIds = EnvironmentVarsMap.viewerId;
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
            if (_arg_1)
            {
                for each (_local_2 in _arg_1)
                {
                    this._user = this.CreateUserObject(_local_2);
                    if (this._user)
                    {
                        FinishRequest(this._user);
                        break;
                    };
                };
            };
        }

        private function CreateUserObject(_arg_1:Object):UserObject
        {
            this._user = new UserObject();
            this._user.Name = _arg_1.user_name;
            this._user.LastName = _arg_1.user_lastname;
            this._user.Id = _arg_1.user_id;
            this._user.Photo = _arg_1.photo_small;
            this._user.City = _arg_1.city_name;
            this._user.Link = ("http://fotostrana.ru/user/" + _arg_1.user_id);
            this._user.BirthDate = this.CheckAndSetBirthDate(_arg_1.birthday);
            this._user.Sex = this.DefineAndSetSex(_arg_1.sex.toString());
            if (this._user.City == null)
            {
                this._user.City = "null";
            };
            return (this._user);
        }

        private function CheckAndSetBirthDate(_arg_1:String):String
        {
            var _local_2:* = "null";
            if (((!(_arg_1 == null)) && (_arg_1.length > 5)))
            {
                _local_2 = _arg_1;
            };
            return (_local_2);
        }

        private function DefineAndSetSex(_arg_1:String):String
        {
            switch (_arg_1)
            {
                case "f":
                    return (UserObject.FEMALE);
                case "m":
                    return (UserObject.MALE);
                default:
                    return (UserObject.UNDEFINED_GENDER);
            };
        }

        override public function get EventType():String
        {
            return (ResponseEvent.GET_USER_INFO);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.fotostrana.requests

