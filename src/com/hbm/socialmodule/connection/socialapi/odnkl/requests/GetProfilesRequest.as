


//com.hbm.socialmodule.connection.socialapi.odnkl.requests.GetProfilesRequest

package com.hbm.socialmodule.connection.socialapi.odnkl.requests
{
    import com.hbm.socialmodule.connection.socialapi.SocialSystemRequest;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.net.URLVariables;
    import com.hbm.socialmodule.data.UserObject;

    public class GetProfilesRequest extends AbstractOdklRequest implements SocialSystemRequest 
    {

        private var _idList:Array;
        private var _users:Array;

        public function GetProfilesRequest(_arg_1:Object, _arg_2:Array)
        {
            super(_arg_1);
            this._idList = _arg_2;
            this._users = [];
        }

        public function get EventType():String
        {
            return (ResponseEvent.GET_PROFILES);
        }

        public function GetRequestVariables(_arg_1:String):URLVariables
        {
            this.SetRequestVars();
            var _local_2:String = this.ComposeStringtoEncode(_arg_1);
            SetRequestCode(_local_2);
            return (_variables);
        }

        private function SetRequestVars():void
        {
            _variables.method = "users.getInfo";
            _variables.application_key = _flashVars["application_key"];
            _variables.fields = "first_name,last_name,pic_1,url_profile";
            _variables.format = "JSON";
            _variables.session_key = _flashVars["session_key"];
            _variables.uids = this.ConvertUidsToString();
        }

        private function ConvertUidsToString():String
        {
            var _local_2:String;
            var _local_1:* = "";
            for each (_local_2 in this._idList)
            {
                _local_1 = _local_1.concat(("," + _local_2));
            };
            return (_local_1.slice(1));
        }

        private function ComposeStringtoEncode(_arg_1:String):String
        {
            return (((((((((((("application_key=" + _variables.application_key) + "fields=") + _variables.fields) + "format=") + _variables.format) + "method=") + _variables.method) + "session_key=") + _variables.session_key) + "uids=") + _variables.uids) + _arg_1);
        }

        public function ProcessResponse(_arg_1:Object):Object
        {
            if ((_arg_1 is Array))
            {
                this.ProcessDataArray((_arg_1 as Array));
            };
            return (this._users);
        }

        private function ProcessDataArray(_arg_1:Array):void
        {
            var _local_2:Object;
            var _local_3:UserObject;
            for each (_local_2 in _arg_1)
            {
                _local_3 = this.TransformProfileDataToUser(_local_2);
                this._users.push(_local_3);
            };
        }

        private function TransformProfileDataToUser(_arg_1:Object):UserObject
        {
            var _local_2:UserObject = new UserObject();
            _local_2.Name = _arg_1.first_name;
            _local_2.LastName = _arg_1.last_name;
            _local_2.Id = _arg_1.uid;
            _local_2.Photo = _arg_1.pic_1;
            _local_2.Link = _arg_1.url_profile;
            return (_local_2);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.odnkl.requests

