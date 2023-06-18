


//hbm.Application.Social.FarmFriendWindow

package hbm.Application.Social
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.JPanel;
    import flash.display.Loader;
    import org.aswing.JButton;
    import org.aswing.JLabel;
    import hbm.Application.ClientApplication;
    import org.aswing.BorderLayout;
    import org.aswing.EmptyLayout;
    import hbm.Game.Utility.AsWingUtil;
    import flash.geom.Rectangle;
    import org.aswing.ASFont;
    import org.aswing.JTextArea;
    import org.aswing.Component;
    import hbm.Engine.Network.Events.FriendVisitEvent;
    import flash.events.Event;
    import hbm.Game.Utility.HtmlText;
    import hbm.Engine.Renderer.RenderSystem;
    import flash.net.URLRequest;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.Inventory.InventoryStoreItem;
    import flash.net.URLVariables;
    import flash.net.URLRequestMethod;
    import flash.net.sendToURL;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;

    public class FarmFriendWindow extends WindowPrototype 
    {

        private static const SCRIPT_EMAIL:String = "http://novo-play.ru/lnd/utils/call_player.php";

        private const WIDTH:int = 674;
        private const HEIGHT:int = 680;

        private var _friends:Array = [];
        private var _curFriendIndex:uint;
        private var _leftArrow:CustomButton;
        private var _rightArrow:CustomButton;
        private var _fakeAvatar:JPanel;
        private var _avatar:Loader;
        private var _farmButton:JButton;
        private var _rewardPanel:JPanel;
        private var _invitePanel:JPanel;
        private var _nameLabel:JLabel;
        private var _bgPanel:JPanel;
        private var _curBg:uint = 1;

        public function FarmFriendWindow(_arg_1:Array)
        {
            this._friends = _arg_1;
            super(owner, ClientApplication.Localization.FARM_FRIEND_WINDOW, true, this.WIDTH, this.HEIGHT, true, true);
        }

        override protected function InitUI():void
        {
            var _local_1:JPanel;
            super.InitUI();
            Body.setLayout(new BorderLayout());
            _local_1 = new JPanel(new EmptyLayout());
            AsWingUtil.SetSize(_local_1, 650, 552);
            this._bgPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAsset(this._bgPanel, "FF_Background1");
            this._bgPanel.setLocationXY(23, 0);
            _local_1.append(this._bgPanel);
            this._fakeAvatar = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAsset(this._fakeAvatar, "FF_NoAvatarUser");
            this._fakeAvatar.setLocationXY(60, 66);
            _local_1.append(this._fakeAvatar);
            this._avatar = new Loader();
            this._avatar.x = 60;
            this._avatar.y = 66;
            this._avatar.scrollRect = new Rectangle(0, 0, 50, 50);
            _local_1.addChild(this._avatar);
            var _local_2:JPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAsset(_local_2, "FF_CharacterFrame");
            _local_2.setLocationXY(53, 60);
            _local_1.append(_local_2);
            this._nameLabel = AsWingUtil.CreateLabel("", 16500537, new ASFont(getFont().getName(), 10, false));
            this._nameLabel.setHorizontalAlignment(JLabel.CENTER);
            AsWingUtil.SetBackgroundFromAsset(this._nameLabel, "FF_BGName");
            this._nameLabel.setLocationXY(48, 128);
            _local_1.append(this._nameLabel);
            this._leftArrow = AsWingUtil.CreateCustomButtonFromAsset("NCS_Left", "NCS_LeftOver", "NCS_LeftPress");
            this._leftArrow.addActionListener(this.OnScrollLeft, 0, true);
            this._leftArrow.setLocationXY(0, 200);
            _local_1.append(this._leftArrow);
            this._rightArrow = AsWingUtil.CreateCustomButtonFromAsset("NCS_Right", "NCS_RightOver", "NCS_RightPress");
            this._rightArrow.addActionListener(this.OnScrollRight, 0, true);
            this._rightArrow.setLocationXY(612, 200);
            _local_1.append(this._rightArrow);
            this._rewardPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAssetLocalization(this._rewardPanel, "FF_LookFoundBorder");
            this._rewardPanel.setLocationXY(31, 425);
            _local_1.append(this._rewardPanel);
            _local_1.append(this.CreateInvitePanel());
            this._farmButton = AsWingUtil.CreateButton(AsWingUtil.GetAssetLocalization("FF_LookBotton"), AsWingUtil.GetAssetLocalization("FF_LookBottonOver"), AsWingUtil.GetAssetLocalization("FF_LookBottonPress"), AsWingUtil.GetAssetLocalization("FF_LookBottonDisble"));
            this._farmButton.addActionListener(this.OnFarmFriend, 0, true);
            this._farmButton.setLocationXY(240, 495);
            _local_1.append(this._farmButton);
            Body.append(_local_1);
        }

        private function CreateInvitePanel():Component
        {
            this._invitePanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAsset(this._invitePanel, "FF_InviteFriendBorder");
            this._invitePanel.setLocationXY(31, 425);
            var _local_1:CustomButton = AsWingUtil.CreateCustomButtonFromAssetLocalization("FF_InviteButton", "FF_InviteButtonOver", "FF_InviteButtonPress");
            _local_1.addActionListener(this.OnInvite, 0, true);
            _local_1.setLocationXY(390, 18);
            this._invitePanel.append(_local_1);
            var _local_2:JTextArea = AsWingUtil.CreateTextArea(ClientApplication.Localization.FARM_FRIEND_TIME_ESCAPE_TEXT);
            AsWingUtil.SetSize(_local_2, 365, 50);
            _local_2.setLocationXY(30, 20);
            this._invitePanel.append(_local_2);
            return (this._invitePanel);
        }

        private function OnFarmFriend(_arg_1:Event):void
        {
            var _local_2:String = this._friends[this._curFriendIndex];
            this.UpdateCheckVisit(_local_2, FriendVisitEvent.RESULT_VISIT, this._curBg);
            this.EnableScroll(false);
            ClientApplication.Instance.LocalGameClient.SendVisitFriend(_local_2);
            ClientApplication.Instance.GetSocialFriends().CheckVisit([_local_2]);
        }

        private function OnScrollLeft(_arg_1:Event):void
        {
            if (this._curFriendIndex == 0)
            {
                this._curFriendIndex = (this._friends.length - 1);
            }
            else
            {
                this._curFriendIndex--;
            };
            this.UpdateFarm();
        }

        private function OnScrollRight(_arg_1:Event):void
        {
            this._curFriendIndex++;
            if (this._curFriendIndex >= this._friends.length)
            {
                this._curFriendIndex = 0;
            };
            this.UpdateFarm();
        }

        private function UpdateFarm():void
        {
            this._rewardPanel.visible = false;
            this._invitePanel.visible = false;
            var _local_1:String = this._friends[this._curFriendIndex];
            if (!_local_1)
            {
                return;
            };
            this.EnableScroll(false);
            ClientApplication.Instance.GetSocialFriends().RequestServer.SendRequestUsersInfo([_local_1]);
            ClientApplication.Instance.GetSocialFriends().CheckVisit([_local_1]);
        }

        private function EnableScroll(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                this._leftArrow.mouseEnabled = (this._rightArrow.mouseEnabled = true);
                this._leftArrow.filters = null;
                this._rightArrow.filters = null;
            }
            else
            {
                this._leftArrow.mouseEnabled = (this._rightArrow.mouseEnabled = false);
                this._leftArrow.filters = [HtmlText.gray];
                this._rightArrow.filters = [HtmlText.gray];
            };
        }

        override public function show():void
        {
            super.show();
            setLocationXY(((RenderSystem.Instance.ScreenWidth - width) / 2), ((RenderSystem.Instance.ScreenHeight - height) / 2));
        }

        public function UpdateAvatars(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            var _local_4:String = this._friends[this._curFriendIndex];
            if (_local_4 == _arg_1)
            {
                if (_arg_3)
                {
                    this._avatar.load(new URLRequest(unescape(_arg_3)));
                }
                else
                {
                    this._avatar.unload();
                };
                if (_arg_2)
                {
                    _arg_2 = _arg_2.replace(" ", "\n");
                    this._nameLabel.setText(_arg_2);
                }
                else
                {
                    this._nameLabel.setText("???");
                };
                pack();
            };
        }

        public function UpdateCheckVisit(_arg_1:String, _arg_2:uint, _arg_3:uint):void
        {
            var _local_4:String = this._friends[this._curFriendIndex];
            if (_local_4 == _arg_1)
            {
                this._farmButton.setEnabled((_arg_2 == FriendVisitEvent.RESULT_NOT_VISIT));
                this._farmButton.mouseEnabled = (this._farmButton.mouseChildren = (_arg_2 == FriendVisitEvent.RESULT_NOT_VISIT));
                this._invitePanel.visible = (_arg_2 == FriendVisitEvent.RESULT_TIME_ESCAPE);
                if (this._curBg != _arg_3)
                {
                    this._curBg = _arg_3;
                    AsWingUtil.SetBackgroundFromAsset(this._bgPanel, ("FF_Background" + this._curBg));
                };
                this.EnableScroll(true);
            };
        }

        public function ShowUser(_arg_1:String):void
        {
            this._curFriendIndex = this._friends.indexOf(_arg_1);
            this.show();
            this.UpdateFarm();
        }

        public function UpdateReward(_arg_1:Array):void
        {
            var _local_2:ItemData;
            var _local_3:InventoryStoreItem;
            var _local_4:JLabel;
            var _local_5:JButton;
            if (((_arg_1) && (_arg_1.length)))
            {
                this._rewardPanel.removeAll();
                this._rewardPanel.visible = true;
                _local_2 = _arg_1[0];
                _local_3 = new InventoryStoreItem(_local_2);
                AsWingUtil.SetSize(_local_3, 32, 32);
                _local_3.setLocationXY(282, 14);
                this._rewardPanel.append(_local_3);
                _local_4 = AsWingUtil.CreateLabel(("x" + _local_3.Item.Amount), 16772788, new ASFont(getFont().getName(), 18, true));
                AsWingUtil.SetSize(_local_4, 200, 40);
                _local_4.setHorizontalAlignment(JLabel.LEFT);
                _local_4.setLocationXY(330, 11);
                this._rewardPanel.append(_local_4);
                _local_5 = AsWingUtil.CreateButton(AsWingUtil.GetAsset("FF_CloseButton"), AsWingUtil.GetAsset("FF_CloseButtonOver"));
                _local_5.addActionListener(this.OnCloseReward, 0, true);
                _local_5.setLocationXY(564, 11);
                this._rewardPanel.append(_local_5);
            };
            this.EnableScroll(true);
        }

        private function OnCloseReward(_arg_1:Event):void
        {
            this._rewardPanel.visible = false;
        }

        private function OnCloseInvite(_arg_1:Event):void
        {
            this._invitePanel.visible = false;
        }

        private function OnInvite(_arg_1:Event):void
        {
            var _local_3:URLVariables;
            var _local_4:URLRequest;
            var _local_2:String = this._friends[this._curFriendIndex];
            if (_local_2.indexOf("wb") >= 0)
            {
                _local_3 = new URLVariables();
                _local_3.user_id = _local_2.replace("wb", "");
                _local_4 = new URLRequest(SCRIPT_EMAIL);
                _local_4.method = URLRequestMethod.POST;
                _local_4.data = _local_3;
                sendToURL(_local_4);
            }
            else
            {
                ClientApplication.Instance.GetSocialFriends().RequestServer.SendNotificationRequestUser(_local_2, 1);
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.FARM_NOTIFICATION_DIALOG, ClientApplication.Localization.FARM_NOTIFICATION_DIALOG_TEXT, null, null, true, new AttachIcon("AchtungIcon"), JOptionPane.OK));
        }


    }
}//package hbm.Application.Social

