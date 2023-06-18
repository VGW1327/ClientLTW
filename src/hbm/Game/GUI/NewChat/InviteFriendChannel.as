


//hbm.Game.GUI.NewChat.InviteFriendChannel

package hbm.Game.GUI.NewChat
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.BorderLayout;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.SoftBoxLayout;
    import hbm.Application.Social.SocialFriends;
    import hbm.Application.ClientApplication;
    import org.aswing.event.AWEvent;

    public class InviteFriendChannel extends JPanel 
    {

        private static const SLOTS_PER_PAGE:uint = 4;

        protected var _parent:LeftChatBar;
        protected var _index:int;
        private var _friendsPanel:JPanel;
        private var _btnLeft:CustomButton;
        private var _btnRight:CustomButton;
        private var _friends:Array = [];
        private var _friendsSlots:Object = {};
        private var _curPage:int;
        private var _maxPage:int;

        public function InviteFriendChannel(_arg_1:LeftChatBar, _arg_2:int)
        {
            super(new BorderLayout());
            setOpaque(false);
            this._parent = _arg_1;
            this._index = _arg_2;
        }

        public function SetFriends(_arg_1:Array):void
        {
            this._friends = _arg_1;
            this._curPage = 0;
            this._maxPage = Math.ceil((this._friends.length / SLOTS_PER_PAGE));
            this.UpdateSlots();
        }

        public function UpdateFriendsInfo(_arg_1:Array):void
        {
            var _local_2:Object;
            for each (_local_2 in _arg_1)
            {
                if ((_local_2.login in this._friendsSlots))
                {
                    this._friendsSlots[_local_2.login].UpdateSlot(_local_2.login, _local_2.displayName, _local_2.avatar);
                };
            };
        }

        public function UpdateFriendsVisit(_arg_1:String, _arg_2:Boolean):void
        {
            if ((_arg_1 in this._friendsSlots))
            {
                this._friendsSlots[_arg_1].UpdateVisit(_arg_2);
            };
        }

        public function UpdateGraphics():void
        {
            if (this._friendsPanel)
            {
                return;
            };
            var _local_1:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBorder(_local_1, 15, 0, 0, 0);
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5, SoftBoxLayout.TOP));
            var _local_3:CustomButton = AsWingUtil.CreateCustomButtonFromAssetLocalization("CHW_InviteButton", "CHW_InviteButtonOver");
            _local_3.addActionListener(this.OnInviteButton);
            _local_2.append(AsWingUtil.OffsetBorder(_local_3, 64));
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.TOP));
            this._btnLeft = AsWingUtil.CreateCustomButtonFromAsset("CHW_ArrowLeft", "CHW_ArrowLeftOver", "CHW_ArrowLeft");
            this._btnLeft.addActionListener(this.OnLeftButton);
            _local_4.append(this._btnLeft);
            this._friendsPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            this._friendsPanel.append(new FriendSlot());
            this._friendsPanel.append(new FriendSlot());
            this._friendsPanel.append(new FriendSlot());
            this._friendsPanel.append(new FriendSlot());
            _local_4.append(this._friendsPanel);
            this._btnRight = AsWingUtil.CreateCustomButtonFromAsset("CHW_ArrowRight", "CHW_ArrowRightOver", "CHW_ArrowRight");
            this._btnRight.addActionListener(this.OnRightButton);
            _local_4.append(this._btnRight);
            _local_2.append(AsWingUtil.OffsetBorder(_local_4, 10));
            _local_1.append(_local_2, BorderLayout.CENTER);
            append(_local_1, BorderLayout.CENTER);
            this.UpdateScrollArrows();
        }

        private function UpdateSlots():void
        {
            var _local_5:uint;
            var _local_6:String;
            var _local_7:FriendSlot;
            var _local_8:SocialFriends;
            this.UpdateScrollArrows();
            this._friendsPanel.removeAll();
            var _local_1:Array = [];
            var _local_2:Array = [];
            var _local_3:uint = this._friends.length;
            var _local_4:uint;
            while (_local_4 < SLOTS_PER_PAGE)
            {
                _local_5 = ((this._curPage * SLOTS_PER_PAGE) + _local_4);
                if (_local_5 < _local_3)
                {
                    _local_6 = this._friends[_local_5];
                    this._friendsSlots[_local_6] = ((this._friendsSlots[_local_6]) || (new FriendSlot()));
                    _local_7 = this._friendsSlots[_local_6];
                    this._friendsPanel.append(_local_7);
                    if (!_local_7.IsLoaded)
                    {
                        _local_1.push(_local_6);
                    };
                    _local_2.push(_local_6);
                }
                else
                {
                    this._friendsPanel.append(new FriendSlot());
                };
                _local_4++;
            };
            if (_local_1.length)
            {
                _local_8 = ClientApplication.Instance.GetSocialFriends();
                if (_local_8)
                {
                    _local_8.RequestServer.SendRequestUsersInfo(_local_1);
                    _local_8.CheckVisit(_local_2);
                };
            };
        }

        private function OnInviteButton(_arg_1:AWEvent):void
        {
            var _local_2:SocialFriends = ClientApplication.Instance.GetSocialFriends();
            if (_local_2)
            {
                _local_2.ShowInviteBox();
            };
        }

        private function OnLeftButton(_arg_1:AWEvent):void
        {
            this._curPage = Math.max(0, (this._curPage - 1));
            this.UpdateSlots();
        }

        private function OnRightButton(_arg_1:AWEvent):void
        {
            this._curPage = Math.min((this._maxPage - 1), (this._curPage + 1));
            this.UpdateSlots();
        }

        private function UpdateScrollArrows():void
        {
            this._btnLeft.alpha = (((this._curPage + 1) > 1) ? 1 : 0);
            this._btnRight.alpha = (((this._curPage + 1) < this._maxPage) ? 1 : 0);
            this._btnLeft.mouseEnabled = (this._btnLeft.alpha > 0);
            this._btnRight.mouseEnabled = (this._btnRight.alpha > 0);
        }


    }
}//package hbm.Game.GUI.NewChat

