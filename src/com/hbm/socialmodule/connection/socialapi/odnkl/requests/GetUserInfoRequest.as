


//com.hbm.socialmodule.connection.socialapi.odnkl.requests.GetUserInfoRequest

package com.hbm.socialmodule.connection.socialapi.odnkl.requests
{
    import com.hbm.socialmodule.connection.socialapi.SocialSystemRequest;
    import com.hbm.socialmodule.data.UserObject;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.net.URLVariables;

    public class GetUserInfoRequest extends AbstractOdklRequest implements SocialSystemRequest 
    {

        private var _user:UserObject;

        public function GetUserInfoRequest(_arg_1:Object)
        {
            super(_arg_1);
            this._user = new UserObject();
        }

        public function get EventType():String
        {
            return (ResponseEvent.GET_USER_INFO);
        }

        public function GetRequestVariables(_arg_1:String):URLVariables
        {
            this.SetRequesVars();
            var _local_2:String = this.ComposeStringToEncode(_arg_1);
            SetRequestCode(_local_2);
            return (_variables);
        }

        private function SetRequesVars():void
        {
            _variables.method = "users.getInfo";
            _variables.application_key = _flashVars["application_key"];
            _variables.fields = "first_name,last_name,location,birthday,gender,pic_1,url_profile";
            _variables.format = "JSON";
            _variables.session_key = _flashVars["session_key"];
            _variables.uids = _flashVars["logged_user_id"];
        }

        private function ComposeStringToEncode(_arg_1:String):String
        {
            return (((((((((((("application_key=" + _variables.application_key) + "fields=") + _variables.fields) + "format=") + _variables.format) + "method=") + _variables.method) + "session_key=") + _variables.session_key) + "uids=") + _variables.uids) + _arg_1);
        }

        public function ProcessResponse(_arg_1:Object):Object
        {
            if ((_arg_1 is Array))
            {
                this._user.Name = _arg_1[0].first_name;
                this._user.LastName = _arg_1[0].last_name;
                this._user.Id = _arg_1[0].uid;
                this._user.Photo = _arg_1[0].pic_1;
                this._user.City = _arg_1[0].location.city;
                this._user.BirthDate = _arg_1[0].birthday;
                this._user.Link = _arg_1[0].url_profile;
                this.CheckCityFormat();
                this.CheckBirthdateFormat();
                this.CheckGender(_arg_1[0].gender);
            };
            return (this._user);
        }

        private function CheckGender(_arg_1:String):void
        {
            switch (_arg_1)
            {
                case "male":
                    this._user.Sex = UserObject.MALE;
                    return;
                case "female":
                    this._user.Sex = UserObject.FEMALE;
                    return;
                default:
                    throw (new Error("Unknown gender code"));
            };
        }

        private function CheckBirthdateFormat():void
        {
            if (((!(this._user.BirthDate)) || (this._user.BirthDate.length < 6)))
            {
                this._user.BirthDate = "null";
            };
        }

        private function CheckCityFormat():void
        {
            if (this._user.City == null)
            {
                this._user.City = "null";
            };
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.odnkl.requests

