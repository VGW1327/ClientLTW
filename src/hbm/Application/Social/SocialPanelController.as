


//hbm.Application.Social.SocialPanelController

package hbm.Application.Social
{
    import com.hbm.socialpanel.SocialPane;
    import com.hbm.socialmodule.data.UserObject;
    import hbm.Application.ClientApplication;
    import hbm.Application.ClientConfig;
    import com.hbm.socialmodule.data.SocialNetworkState;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import flash.events.Event;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import com.hbm.socialmodule.data.UserRating;
    import flash.events.ErrorEvent;
    import flash.display.LoaderInfo;
    import hbm.Application.*;
	

    public class SocialPanelController 
    {

        private var _socialPane:SocialPane;
        private var _user:UserObject;
        private var _networkApiType:uint;
        private var _xShift:int = 0;
        private var _yShift:int = 3;
        private var _gameStageWidth:int;
        private var _gameStageHeight:int;
        private var _socialFriends:SocialFriends;

        public function SocialPanelController(loaderInfo:LoaderInfo)
        {
            super();
            this._user = new UserObject();
            this._gameStageWidth = ClientApplication.Instance.GameStageWidth;
            this._gameStageHeight = ClientApplication.Instance.GameStageHeight;
            var config:ClientConfig = ClientApplication.Instance.Config;
            switch (config.CurrentPlatformId)
            {
                case ClientConfig.VKONTAKTE:
                case ClientConfig.VKONTAKTE_TEST:
                    this._networkApiType = SocialNetworkState.VKONTAKTE_API;
                    break;
                case ClientConfig.ODNOKLASSNIKI:
                case ClientConfig.ODNOKLASSNIKI_TEST:
                    this._networkApiType = SocialNetworkState.ODNOKL_API;
                    break;
                case ClientConfig.MAILRU:
                case ClientConfig.MAILRU_TEST:
                    this._networkApiType = SocialNetworkState.MAILRU_API;
                    break;
                case ClientConfig.FACEBOOK:
                case ClientConfig.FACEBOOK_TEST:
                    this._networkApiType = SocialNetworkState.FACEBOOK_API;
                    break;
                case ClientConfig.FOTOSTRANA:
                case ClientConfig.FOTOSTRANA_TEST:
                    this._networkApiType = SocialNetworkState.FOTOSTRANA_API;
                    break;
                case ClientConfig.WEB:
                case ClientConfig.WEB_TEST:
                default:
                    this._networkApiType = SocialNetworkState.WEB_API;
            };
            try
            {
                this._socialPane = new SocialPane(ClientApplication.flashVars, this._networkApiType, config.GetSocialServerURL, config.GetAppPrivateKey, this._gameStageWidth);
            }
            catch(e:*)
            {
                return;
            };
            this._socialPane.Data.NetworkApi.addListener(ResponseEvent.INSTALLED, function (_arg_1:ResponseEvent):void
            {
                _socialPane.Data.Login.SendRequest();
            });
            this._socialPane.Data.TopUsers.addEventListener(Event.COMPLETE, function (_arg_1:ResponseEvent):void
            {
            });
            this._socialPane.Data.BroadcastInfo.addEventListener(Event.COMPLETE, function (_arg_1:ResponseEvent):void
            {
            });
            this._socialPane.Data.SpendMoney.addEventListener(Event.COMPLETE, function (_arg_1:ResponseEvent):void
            {
                if (((_arg_1.data) && (_arg_1.data == "ok")))
                {
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_BUY_MONEY_TITLE, ClientApplication.Localization.DLG_BUY_MONEY_MESSAGE, null, null, true, new AttachIcon("AchtungIcon")));
                };
            });
            this._socialPane.Data.GetAuthkey.addEventListener(Event.COMPLETE, this.OnAuthkey);
            this._socialPane.Data.RetrieveUserInfo.addEventListener(Event.COMPLETE, function (_arg_1:ResponseEvent):void
            {
                var _local_2:UserObject = (_arg_1.data as UserObject);
                _user.Name = _local_2.Name;
                _user.LastName = _local_2.LastName;
                _user.BirthDate = _local_2.BirthDate;
                _user.Id = _local_2.Id;
                _user.Link = _local_2.Link;
                _user.Sex = _local_2.Sex;
                _user.Photo = _local_2.Photo;
            });
            this._socialPane.Data.LoadRating.addEventListener(Event.COMPLETE, function (_arg_1:ResponseEvent):void
            {
                var _local_3:UserRating;
                var _local_2:Array = (_arg_1.data as Array);
                for each (_local_3 in _local_2)
                {
                    _user.SetRating(_local_3);
                };
            });
            this._socialPane.Data.addEventListener(ErrorEvent.ERROR, function (_arg_1:ErrorEvent):void
            {
            });
            this._socialFriends = new SocialFriends(this._socialPane.Data);
            this._socialPane.Data.Login.addEventListener(Event.COMPLETE, function (_arg_1:ResponseEvent):void
            {
                _socialPane.Data.RetrieveUserInfo.SendRequest();
            });
            this.InitUI();
        }

        public function GetSocialFriends():SocialFriends
        {
            return (this._socialFriends);
        }

        public function ShowInviteBox():void
        {
            this._socialPane.Data.NetworkApi.CallInviteBox();
        }

        private function InitUI():void
        {
            this._socialPane.tabbedPane.SetSize(this._gameStageWidth, 190);
            this._socialPane.x = 0;
            this._socialPane.y = (this._gameStageHeight + 1);
            this._socialPane.graphics.beginFill(0xF8F8F8);
            this._socialPane.graphics.drawRect(0, 0, 810, (this._socialPane.height + 5));
        }

        private function OnAuthkey(_arg_1:ResponseEvent):void
        {
            if (_arg_1.data)
            {
                ClientApplication.Instance.OKAuthkeyLogin(_arg_1.data.toString());
            };
        }

        public function get SocialPanel():SocialPane
        {
            return (this._socialPane);
        }


    }
}//package hbm.Application.Social

