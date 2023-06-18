


//hbm.Application.Social.SocialFriends

package hbm.Application.Social
{
    import com.hbm.socialmodule.SocialModule;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Network.Events.AccountFriendsEvent;
    import hbm.Engine.Network.Events.FriendVisitEvent;
    import hbm.Application.ClientConfig;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import com.hbm.socialmodule.data.SocialNetworkState;

    public class SocialFriends 
    {

        private var _socialModule:SocialModule;
        private var _friends:Array = [];
        private var _user:Object;
        private var _lastAccountId:uint;
        private var _friendsLoaded:Boolean = false;
        private var _friendRef:String;
        private var _requestServer:RequestSocialServer;
        private var _winFarm:FarmFriendWindow;
        private var _winCloudFarm:FarmCloudWindow;
        private var _friendsCheckVisit:Array = [];

        public function SocialFriends(_arg_1:SocialModule)
        {
            this._socialModule = _arg_1;
            this._requestServer = new RequestSocialServer(this._socialModule.ServerConnector, this._socialModule.NetworkApi);
        }

        public function InitFriends(_arg_1:String):void
        {
            var _local_2:uint = ClientApplication.Instance.LocalGameClient.CurrentLoginId;
            if (_local_2 != this._lastAccountId)
            {
                this._lastAccountId = _local_2;
                this._friendRef = _arg_1;
                ClientApplication.Instance.LocalGameClient.addEventListener(AccountFriendsEvent.ON_ACCOUNT_FRIENDS_UPDATE, this.OnUpdateAccountFriends, false, 0, true);
                ClientApplication.Instance.LocalGameClient.addEventListener(FriendVisitEvent.ON_CHECK_FRIEND_VISIT, this.OnCheckVisitFriends, false, 0, true);
                if (ClientApplication.fromPortal)
                {
                    if (((ClientApplication.Instance.Config.CurrentPlatformId == ClientConfig.WEB) || (ClientApplication.Instance.Config.CurrentPlatformId == ClientConfig.WEB_TEST)))
                    {
                        this._friends = [];
                        ClientApplication.Instance.LocalGameClient.SendCheckFriendsId(ClientApplication.fromPortal, ((this._friendRef) || ("")), "");
                    }
                    else
                    {
                        this._requestServer.addEventListener(ResponseEvent.GET_FRIENDS, this.OnCompleteInitFriends, false, 0, true);
                        this._requestServer.GetSocialFriends();
                    };
                }
                else
                {
                    this._socialModule.NetworkApi.addListener(ResponseEvent.GET_FRIENDS, this.OnCompleteInitFriends);
                    this._socialModule.NetworkApi.GetFriends();
                };
                ClientApplication.Instance.GetSocialFriends().RequestServer.SendRequestUsersInfo([ClientApplication.Instance.LocalGameClient.UserEmail]);
            };
        }

        public function get RequestServer():RequestSocialServer
        {
            return (this._requestServer);
        }

        public function ShowInviteBox():void
        {
            var _local_1:InviteFriendWindow;
            if (ClientApplication.fromPortal)
            {
                _local_1 = new InviteFriendWindow();
                _local_1.show();
            }
            else
            {
                this._socialModule.NetworkApi.CallInviteBox();
            };
        }

        public function ShowVisitWindow(_arg_1:String):void
        {
            this._winFarm = ((this._winFarm) || (new FarmFriendWindow(this._friends)));
            this._winFarm.ShowUser(_arg_1);
        }

        public function ShowCloudWindow():void
        {
            this._winCloudFarm = ((this._winCloudFarm) || (new FarmCloudWindow(this._user)));
            this._winCloudFarm.show();
        }

        public function CheckVisit(_arg_1:Array):void
        {
            var _local_2:String;
            for each (_local_2 in _arg_1)
            {
                this._friendsCheckVisit.push(_local_2);
                ClientApplication.Instance.LocalGameClient.SendCheckVisit(_local_2);
            };
        }

        private function OnCompleteInitFriends(_arg_1:ResponseEvent):void
        {
            var _local_2:Array;
            if (ClientApplication.fromPortal)
            {
                this._requestServer.removeEventListener(ResponseEvent.GET_FRIENDS, this.OnCompleteInitFriends);
                this._friends = ((_arg_1.data as Array) || ([]));
            }
            else
            {
                this._socialModule.NetworkApi.removeListener(ResponseEvent.GET_FRIENDS, this.OnCompleteInitFriends);
                this._friends = ((this._socialModule.NetworkApi.Result as Array) || ([]));
            };
            if (ClientApplication.fromPortal)
            {
                _local_2 = this._friends;
            }
            else
            {
                _local_2 = this._friends.map(this.CreateServerId);
                this._requestServer.UpdateFriends(_local_2);
            };
            var _local_3:String = _local_2.join(",");
            ClientApplication.Instance.LocalGameClient.SendCheckFriendsId(ClientApplication.fromPortal, ((this._friendRef) || ("")), _local_3);
        }

        private function OnUpdateAccountFriends(_arg_1:AccountFriendsEvent):void
        {
            this._friends = ((_arg_1.FriendsIds) || ([]));
            this._friendsLoaded = true;
            ClientApplication.Instance.LeftChatBarInstance.FriendsChannel.SetFriends(this._friends);
        }

        private function OnCheckVisitFriends(_arg_1:FriendVisitEvent):void
        {
            var _local_2:String = this._friendsCheckVisit.shift();
            if (((this._winFarm) && (this._winFarm.isShowing())))
            {
                this._winFarm.UpdateCheckVisit(_local_2, _arg_1.Result, _arg_1.BGIndex);
            };
            ClientApplication.Instance.LeftChatBarInstance.FriendsChannel.UpdateFriendsVisit(_local_2, (!(_arg_1.Result == FriendVisitEvent.RESULT_VISIT)));
        }

        private function CreateServerId(_arg_1:*, _arg_2:int, _arg_3:Array):String
        {
            var _local_4:String = SocialNetworkState.Instance.ServerIdPrefix;
            return (_local_4 + _arg_1);
        }

        public function UpdateFriendsInfo(_arg_1:Array):void
        {
            var _local_4:Object;
            var _local_2:Boolean = ((this._winFarm) && (this._winFarm.isShowing()));
            var _local_3:Boolean = ((this._winCloudFarm) && (this._winCloudFarm.isShowing()));
            for each (_local_4 in _arg_1)
            {
                if (_local_4.login == ClientApplication.Instance.LocalGameClient.UserEmail)
                {
                    this._user = _local_4;
                    if (_local_3)
                    {
                        this._winCloudFarm.UpdateUser(this._user);
                    };
                }
                else
                {
                    if (_local_2)
                    {
                        this._winFarm.UpdateAvatars(_local_4.login, _local_4.displayName, _local_4.avatar);
                    };
                };
            };
        }

        public function UpdateRewardVisitWindow(_arg_1:Array):void
        {
            if (((this._winFarm) && (this._winFarm.isShowing())))
            {
                this._winFarm.UpdateReward(_arg_1);
            };
        }


    }
}//package hbm.Application.Social

