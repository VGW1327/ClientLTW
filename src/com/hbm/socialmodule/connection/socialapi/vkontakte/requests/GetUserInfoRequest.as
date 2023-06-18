


//com.hbm.socialmodule.connection.socialapi.vkontakte.requests.GetUserInfoRequest

package com.hbm.socialmodule.connection.socialapi.vkontakte.requests
{
    import com.hbm.socialmodule.data.UserObject;
    import com.adobe.crypto.MD5;
    import flash.events.Event;
    import com.hbm.socialmodule.connection.ResponseEvent;

    public class GetUserInfoRequest extends AbstractVkoRequest 
    {

        public const TMP_USER_INF:String = "temp_user_event";

        private var _user:UserObject;

        public function GetUserInfoRequest(_arg_1:Object)
        {
            super(_arg_1);
        }

        override protected function PrepareRequestData():void
        {
            RequestVariables.api_id = EnvironmentVarsMap["api_id"];
            RequestVariables.v = "3.0";
            RequestVariables.fields = "first_name,last_name,city,bdate,photo_rec,sex";
            RequestVariables.format = "JSON";
            RequestVariables.method = "getProfiles";
            RequestVariables.uids = EnvironmentVarsMap["viewer_id"];
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
            if ((_arg_1 is Array))
            {
                this._user = this.CreateUserObject(_arg_1[0]);
                if (this._user.City != "0")
                {
                    this.CallCityData(this._user.City);
                }
                else
                {
                    this._user.City = "null";
                    FinishRequest(this._user);
                };
            };
        }

        private function CreateUserObject(_arg_1:Object):UserObject
        {
            this._user = new UserObject();
            this._user.Name = _arg_1.first_name;
            this._user.LastName = _arg_1.last_name;
            this._user.Id = _arg_1.uid;
            this._user.Photo = _arg_1.photo_rec;
            this._user.BirthDate = _arg_1.bdate;
            this._user.City = _arg_1.city;
            this._user.Link = ("http://vkontakte.ru/id" + _arg_1.uid);
            this._user.BirthDate = this.CheckAndSetBirthDate(_arg_1.bdate);
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
                case "0":
                    return (UserObject.UNDEFINED_GENDER);
                case "1":
                    return (UserObject.FEMALE);
                case "2":
                    return (UserObject.MALE);
                default:
                    throw (new Error("Unknown gender code"));
            };
        }

        private function CallCityData(cityId:String):void
        {
            var _getCityNameHandler:GetCityRequest;
            _getCityNameHandler = new GetCityRequest(EnvironmentVarsMap, cityId);
            _getCityNameHandler.addEventListener(AbstractVkoRequest.FINISHED, function (_arg_1:Event):void
            {
                _user.City = String(_getCityNameHandler.Result);
                FinishRequest(_user);
            });
            _getCityNameHandler.SendRequest();
        }

        override public function get EventType():String
        {
            return (ResponseEvent.GET_USER_INFO);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.vkontakte.requests

