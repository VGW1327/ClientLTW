


//com.hbm.socialmodule.connection.socialapi.facebook.FacebookHTTPHandler

package com.hbm.socialmodule.connection.socialapi.facebook
{
    import flash.net.URLLoader;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import com.hbm.socialmodule.utils.TaskScheduler;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLVariables;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.net.URLRequest;
    import com.hbm.socialmodule.data.UserObject;
    import flash.events.ErrorEvent;

    public class FacebookHTTPHandler extends URLLoader 
    {

        private static const logger:ILogger = getLogger(FacebookHTTPHandler);

        private var _scheduler:TaskScheduler = new TaskScheduler();
        private var _apiUrl:String;
        private var _answer:Object;
        private var _appVars:Object;
        private var _variable:Object;
        private var _eventType:String = "";

        public function FacebookHTTPHandler(_arg_1:Object)
        {
            this._appVars = _arg_1;
            this._apiUrl = "https://graph.facebook.com/";
            this._scheduler.timeout = 30000;
            this._scheduler.delay = 260;
            this._scheduler.addEventListener(TaskScheduler.TIMEOUT, this.OnTimeout);
            addEventListener(Event.COMPLETE, this.handleReply);
            addEventListener(IOErrorEvent.IO_ERROR, this.errorHandling);
        }

        public function GetFriends():void
        {
            this._scheduler.Schedule(this, Event.COMPLETE, this, this.GetFriendsSch);
        }

        public function GetUserInfo():void
        {
            this._scheduler.Schedule(this, Event.COMPLETE, this, this.GetUserInfoSch);
        }

        public function GetProfiles(_arg_1:Array):void
        {
            this._scheduler.Schedule(this, Event.COMPLETE, this, this.GetProfilesSch, _arg_1);
        }

        private function GetFriendsSch():void
        {
            var _local_1:URLVariables = new URLVariables();
            _local_1.access_token = this._appVars["oauth_token"];
            _local_1.format = "JSON";
            this._eventType = ResponseEvent.GET_FRIENDS;
            this.SendRestRequest("friends.getAppUsers", _local_1);
        }

        private function GetUserInfoSch():void
        {
            var _local_1:URLVariables = new URLVariables();
            _local_1.access_token = this._appVars["oauth_token"];
            _local_1.format = "JSON";
            _local_1.locale = "en_US";
            _local_1.uids = this._appVars["user_id"];
            _local_1.fields = "first_name,last_name,pic_square,current_location,birthday,sex";
            this._eventType = ResponseEvent.GET_USER_INFO;
            this.SendRestRequest("users.getInfo", _local_1);
        }

        private function GetProfilesSch(_arg_1:Array):void
        {
            var _local_4:String;
            var _local_2:URLVariables = new URLVariables();
            var _local_3:* = "";
            for each (_local_4 in _arg_1)
            {
                _local_3 = _local_3.concat(("," + _local_4));
            };
            _local_3 = _local_3.slice(1);
            _local_2.access_token = this._appVars["oauth_token"];
            _local_2.uids = _local_3;
            _local_2.fields = "first_name,last_name,pic_square";
            _local_2.format = "JSON";
            this._eventType = ResponseEvent.GET_PROFILES;
            this.SendRestRequest("users.getInfo", _local_2);
        }

        protected function SendGraphRequest(_arg_1:URLVariables, _arg_2:String):void
        {
            var _local_3:URLRequest = new URLRequest((this._apiUrl + _arg_2));
            _local_3.data = _arg_1;
            load(_local_3);
        }

        protected function SendFQLRequest(_arg_1:String):void
        {
            var _local_2:URLRequest = new URLRequest("https://api.facebook.com/method/fql.query");
            var _local_3:URLVariables = new URLVariables();
            _local_3.query = _arg_1;
            _local_3.oauth_token = this._appVars["oauth_token"];
            _local_3.format = "JSON";
            _local_2.data = _local_3;
            load(_local_2);
        }

        protected function SendRestRequest(_arg_1:String, _arg_2:URLVariables):void
        {
            var _local_3:URLRequest = new URLRequest(("https://api.facebook.com/method/" + _arg_1));
            _local_3.data = _arg_2;
            logger.debug(((("to fbc: " + _local_3.url) + "?") + _local_3.data));
            load(_local_3);
        }

        protected function handleReply(event:Event):void
        {
            logger.debug(("fr fbc: " + data));
            try
            {
                this._answer = JSON.parse(data);
                if (this._answer.error_code != null)
                {
                    logger.error(((("Network error " + this._answer.error.error_code) + ": ") + this._answer.error.error_msg));
                    this._scheduler.Interrupt();
                    dispatchEvent(new Event(TaskScheduler.INTERRUPTED));
                }
                else
                {
                    this._variable = this.FormatData(this._answer);
                    dispatchEvent(new ResponseEvent(this._eventType, this._variable));
                };
            }
            catch(e:Error)
            {
                logger.error(e.message);
            };
        }

        protected function FormatData(_arg_1:Object):Object
        {
            var _local_2:Object;
            var _local_3:Array;
            var _local_4:Object;
            var _local_5:UserObject;
            var _local_6:UserObject;
            var _local_7:String;
            switch (this._eventType)
            {
                case ResponseEvent.GET_PROFILES:
                    _local_3 = [];
                    if ((_arg_1 is Array))
                    {
                        for each (_local_4 in _arg_1)
                        {
                            _local_5 = new UserObject();
                            _local_5.Name = _local_4.first_name;
                            _local_5.LastName = _local_4.last_name;
                            _local_5.Id = _local_4.uid;
                            _local_5.Photo = (("http://graph.facebook.com/" + _local_5.Id) + "/picture");
                            _local_5.Link = ("http://www.facebook.com/profile.php?id=" + _local_4.uid);
                            _local_3.push(_local_5);
                        };
                    };
                    _local_2 = _local_3;
                    break;
                case ResponseEvent.GET_FRIENDS:
                    _local_2 = (_arg_1.data as Array);
                    break;
                case ResponseEvent.GET_USER_INFO:
                    _local_6 = new UserObject();
                    _arg_1 = _arg_1[0];
                    _local_6.Name = _arg_1.first_name;
                    _local_6.LastName = _arg_1.last_name;
                    _local_6.Id = _arg_1.uid;
                    _local_6.Photo = (("http://graph.facebook.com/" + _local_6.Id) + "/picture");
                    _local_6.City = ((_arg_1.current_location != null) ? _arg_1.current_location.name : "null");
                    _local_6.Link = ("http://www.facebook.com/profile.php?id=" + _arg_1.uid);
                    _local_7 = _arg_1.birthday;
                    if (((!(_local_7)) || (_local_7.length < 6)))
                    {
                        _local_7 = "null";
                    };
                    _local_6.BirthDate = _local_7;
                    switch (_arg_1.Sex)
                    {
                        case "male":
                            _local_6.Sex = UserObject.MALE;
                            break;
                        case "female":
                            _local_6.Sex = UserObject.FEMALE;
                            break;
                        default:
                            _local_6.Sex = UserObject.UNDEFINED_GENDER;
                    };
                    _local_2 = _local_6;
                    break;
            };
            return (_local_2);
        }

        private function OnTimeout(event:Event):void
        {
            try
            {
                this.close();
            }
            catch(e:Error)
            {
                logger.error(e.message);
            };
        }

        protected function errorHandling(_arg_1:ErrorEvent):void
        {
            logger.error(((_arg_1.type + ": ") + _arg_1.text));
        }

        public function get response():Object
        {
            return (this._variable);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.facebook

