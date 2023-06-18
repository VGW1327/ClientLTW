


//hbm.Application.ClientConfig

package hbm.Application
{
    import hbm.Engine.Utility.JSONParser;
    import hbm.Engine.Resource.ResourceManager;

    public class ClientConfig 
    {

        public static const DEBUG:int = 0;
        public static const WEB:int = 1;
        public static const STANDALONE:int = 2;
        public static const VKONTAKTE:int = 3;
        public static const MAILRU:int = 4;
        public static const ODNOKLASSNIKI:int = 5;
        public static const TEST:int = 6;
        public static const FOTOSTRANA:int = 7;
        public static const FACEBOOK:int = 8;
        public static const WEB_TEST:int = 11;
        public static const VKONTAKTE_TEST:int = 13;
        public static const MAILRU_TEST:int = 14;
        public static const ODNOKLASSNIKI_TEST:int = 15;
        public static const FOTOSTRANA_TEST:int = 17;
        public static const FACEBOOK_TEST:int = 18;
        public static const DisableWallPost:Array = [ClientConfig.DEBUG, ClientConfig.FACEBOOK, ClientConfig.FACEBOOK_TEST, ClientConfig.STANDALONE, ClientConfig.TEST, ClientConfig.WEB, ClientConfig.WEB_TEST];

        private var _json:Object;
        private var _platform:Object;
        private var _server:Object;
        private var _currentPlatformId:int;

        public function ClientConfig(_arg_1:int)
        {
            var _local_2:Object;
            var _local_3:Object;
            var _local_4:Number;
            var _local_5:int;
            super();
            this._json = JSONParser.GetJSON(ConfigJSON.Config);
            for each (_local_2 in this._json["content_providers"])
            {
                _local_3 = _local_2["priority"];
                _local_4 = ((_local_3["0"]) || (0));
                _local_5 = 0;
                while (_local_5 <= 23)
                {
                    _local_3[_local_5] = Number(((_local_3[_local_5]) || (_local_4)));
                    _local_4 = _local_3[_local_5];
                    _local_5++;
                };
            };
            this._currentPlatformId = _arg_1;
            this._platform = this._json[_arg_1];
        }

        public function get CurrentPlatformId():int
        {
            return (this._currentPlatformId);
        }

        public function get LoginServers():Array
        {
            var _local_2:String;
            var _local_3:Object;
            if (this._platform == null)
            {
                return (null);
            };
            var _local_1:Array = new Array();
            for each (_local_2 in this._platform["login_servers"])
            {
                _local_3 = this._json["login_servers"][_local_2];
                _local_1.push(_local_3);
            };
            return ((_local_1.length > 0) ? _local_1 : null);
        }

        public function get GetPlatformStatistic():Object
        {
            return (this._platform["statistic"]);
        }

        public function SelectLoginServer(_arg_1:String):void
        {
            var _local_2:Object;
            for each (_local_2 in this.LoginServers)
            {
                if (_local_2["game"] == _arg_1)
                {
                    this._server = _local_2;
                    return;
                };
            };
            this._server = null;
        }

        public function get GetPlatformResolution():Object
        {
            return (this._platform["resolution"]);
        }

        public function get GetSocialAppID():String
        {
            return ((this._platform["social_app_id"]) || ("Undefined"));
        }

        public function get GetAppURL():String
        {
            return (this._platform["app_url"]);
        }

        public function get GetAppGroupURL():String
        {
            return (this._platform["app_group_url"]);
        }

        public function get GetSocialServerURL():String
        {
            return (this._platform["social_server_url"]);
        }

        public function get GetAppPrivateKey():String
        {
            return (this._platform["app_private_key"]);
        }

        public function get GetGATracker():String
        {
            return (this._platform["ga_tracker"]);
        }

        public function get IsPaymentsEnabled():Boolean
        {
            var _local_1:Object = ((this._platform["enable_payments"]) || (null));
            return ((_local_1 != null) ? _local_1 : false);
        }

        public function GetFileURL(_arg_1:String):String
        {
            var _local_4:Object;
            var _local_5:String;
            var _local_6:String;
            var _local_7:Object;
            var _local_8:Number;
            var _local_9:Number;
            if (this._server == null)
            {
                return ("");
            };
            var _local_2:int = new Date().hoursUTC;
            var _local_3:Number = 0;
            for each (_local_5 in this._server["content"])
            {
                _local_7 = this._json["content_providers"][_local_5];
                _local_8 = _local_7["priority"][_local_2];
                _local_9 = (Math.random() * _local_8);
                if (_local_3 < _local_9)
                {
                    _local_3 = _local_9;
                    _local_4 = _local_7;
                };
            };
            _local_6 = _local_4["host"];
            if (_local_6 != null)
            {
                return (_local_6 + ResourceManager.Instance.GetResourceFile((_arg_1 + ".swf")));
            };
            return (_local_4["files"][_arg_1]);
        }

        public function GetFileURLExt(_arg_1:String):String
        {
            var _local_4:Object;
            var _local_5:String;
            var _local_6:String;
            var _local_7:Object;
            var _local_8:Number;
            var _local_9:Number;
            if (this._server == null)
            {
                return ("");
            };
            var _local_2:int = new Date().hoursUTC;
            var _local_3:Number = 0;
            for each (_local_5 in this._server["content"])
            {
                _local_7 = this._json["content_providers"][_local_5];
                _local_8 = _local_7["priority"][_local_2];
                _local_9 = (Math.random() * _local_8);
                if (_local_3 < _local_9)
                {
                    _local_3 = _local_9;
                    _local_4 = _local_7;
                };
            };
            _local_6 = _local_4["host"];
            if (_local_6 != null)
            {
                return (_local_6 + ResourceManager.Instance.GetResourceFile(_arg_1));
            };
            return ("");
        }


    }
}//package hbm.Application

