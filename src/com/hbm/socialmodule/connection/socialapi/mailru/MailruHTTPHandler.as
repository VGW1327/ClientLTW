


//com.hbm.socialmodule.connection.socialapi.mailru.MailruHTTPHandler

package com.hbm.socialmodule.connection.socialapi.mailru
{
    import flash.net.URLLoader;
    import org.as3commons.logging.api.ILogger;
    import org.as3commons.logging.api.getLogger;
    import com.hbm.socialmodule.utils.TaskScheduler;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.net.URLVariables;
    import com.adobe.crypto.MD5;
    import flash.net.URLRequest;
    import com.hbm.socialmodule.data.UserObject;

    public class MailruHTTPHandler extends URLLoader 
    {

        private static const logger:ILogger = getLogger(MailruHTTPHandler);

        private const _apiUrl:String = "http://www.appsmail.ru/platform/api";

        private var _scheduler:TaskScheduler = new TaskScheduler();
        private var _appVars:Object;
        private var _code:String;
        private var _expectedEventType:String = "";
        private var _answer:Object;

        public function MailruHTTPHandler(_arg_1:Object, _arg_2:String)
        {
            this._appVars = _arg_1;
            this._code = _arg_2;
            this._scheduler.timeout = 30000;
            this._scheduler.delay = 260;
            this._scheduler.addEventListener(TaskScheduler.TIMEOUT, this.OnTimeout);
            addEventListener(Event.COMPLETE, this.handleReply);
            addEventListener(IOErrorEvent.IO_ERROR, this.errorHandling);
        }

        public function GetFriends():void
        {
            this._scheduler.Schedule(this, ResponseEvent.GET_FRIENDS, this, this.GetFriendsSch);
        }

        public function GetUserInfo():void
        {
            this._scheduler.Schedule(this, ResponseEvent.GET_USER_INFO, this, this.GetUserInfoSch);
        }

        public function GetProfiles(_arg_1:Array):void
        {
            this._scheduler.Schedule(this, ResponseEvent.GET_PROFILES, this, this.GetProfilesSch, _arg_1);
        }

        private function GetFriendsSch():void
        {
            var _local_1:URLVariables = new URLVariables();
            _local_1.method = "friends.getAppUsers";
            _local_1.app_id = this._appVars["app_id"];
            _local_1.uid = this._appVars["vid"];
            var _local_2:String = (((((((this._appVars["vid"] + "app_id=") + _local_1.app_id) + "method=") + _local_1.method) + "uid=") + _local_1.uid) + this._code);
            _local_1.sig = MD5.hash(_local_2);
            this._expectedEventType = ResponseEvent.GET_FRIENDS;
            this.SendRequest(_local_1);
        }

        private function GetUserInfoSch():void
        {
            var _local_1:URLVariables = new URLVariables();
            _local_1.method = "users.getInfo";
            _local_1.app_id = this._appVars["app_id"];
            _local_1.uid = this._appVars["vid"];
            _local_1.uids = [this._appVars["vid"]];
            var _local_2:String = (((((((((this._appVars["vid"] + "app_id=") + _local_1.app_id) + "method=") + _local_1.method) + "uid=") + _local_1.uid) + "uids=") + _local_1.uids) + this._code);
            _local_1.sig = MD5.hash(_local_2);
            this._expectedEventType = ResponseEvent.GET_USER_INFO;
            this.SendRequest(_local_1);
        }

        private function GetProfilesSch(_arg_1:Array):void
        {
            var _local_4:String;
            var _local_5:String;
            var _local_2:URLVariables = new URLVariables();
            var _local_3:* = "";
            for each (_local_4 in _arg_1)
            {
                _local_3 = _local_3.concat(("," + _local_4));
            };
            _local_2.method = "users.getInfo";
            _local_2.app_id = this._appVars["app_id"];
            _local_2.uid = this._appVars["vid"];
            _local_2.uids = _local_3;
            _local_5 = (((((((((this._appVars["vid"] + "app_id=") + _local_2.app_id) + "method=") + _local_2.method) + "uid=") + _local_2.uid) + "uids=") + _local_2.uids) + this._code);
            _local_2.sig = MD5.hash(_local_5);
            this._expectedEventType = ResponseEvent.GET_PROFILES;
            this.SendRequest(_local_2);
        }

        protected function SendRequest(_arg_1:URLVariables):void
        {
            var _local_2:URLRequest = new URLRequest(this._apiUrl);
            _local_2.data = _arg_1;
            logger.debug(("to mail.ru: " + _local_2.data));
            load(_local_2);
        }

        public function get answer():Object
        {
            return (this._answer);
        }

        protected function handleReply(event:Event):void
        {
            var answer:Object;
            logger.debug(("fr mailru: " + data));
            try
            {
                answer = JSON.parse(data);
                if (answer.error != null)
                {
                    logger.error(((("Error " + answer.error.error_code) + ": ") + answer.error.error_msg));
                    this._scheduler.Interrupt();
                    dispatchEvent(new Event(TaskScheduler.INTERRUPTED));
                }
                else
                {
                    this._answer = this.PackData(answer);
                    dispatchEvent(new ResponseEvent(this._expectedEventType, this._answer));
                };
            }
            catch(e:Error)
            {
                logger.error(e.message);
            };
        }

        protected function PackData(_arg_1:Object):Object
        {
            var _local_2:Object;
            var _local_3:Array;
            var _local_4:Object;
            var _local_5:UserObject;
            var _local_6:UserObject;
            var _local_7:String;
            switch (this._expectedEventType)
            {
                case ResponseEvent.GET_PROFILES:
                    if ((_arg_1 is Array))
                    {
                        _local_3 = [];
                        for each (_local_4 in _arg_1)
                        {
                            _local_5 = new UserObject();
                            _local_5.Id = _local_4.uid;
                            _local_5.Name = _local_4.first_name;
                            _local_5.LastName = _local_4.last_name;
                            _local_5.Photo = _local_4.pic_small;
                            _local_5.Link = _local_4.Link;
                            _local_3.push(_local_5);
                        };
                        _local_2 = _local_3;
                    };
                    break;
                case ResponseEvent.GET_FRIENDS:
                    _local_2 = (_arg_1 as Array);
                    break;
                case ResponseEvent.GET_USER_INFO:
                    _local_6 = new UserObject();
                    _local_6.Id = _arg_1[0].uid;
                    _local_6.Name = _arg_1[0].first_name;
                    _local_6.LastName = _arg_1[0].last_name;
                    _local_6.Photo = _arg_1[0].pic_small;
                    _local_6.Link = _arg_1[0].link;
                    logger.debug(("link at json pack: " + _arg_1[0].link));
                    if (_arg_1[0].City == null)
                    {
                        _local_6.City = "null";
                    }
                    else
                    {
                        _local_6.City = _arg_1[0].city.name;
                    };
                    _local_7 = _arg_1[0].birthday;
                    if (((!(_local_7)) || (_local_7.length < 6)))
                    {
                        _local_7 = "null";
                    };
                    _local_6.BirthDate = _local_7;
                    switch (_arg_1[0].sex)
                    {
                        case 0:
                            _local_6.Sex = UserObject.MALE;
                            break;
                        case 1:
                            _local_6.Sex = UserObject.FEMALE;
                            break;
                        default:
                            throw (new Error("Unknown gender code"));
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

        protected function errorHandling(_arg_1:IOErrorEvent):void
        {
            logger.error(_arg_1.text);
        }


    }
}//package com.hbm.socialmodule.connection.socialapi.mailru

