


//hbm.Game.GUI.NewChat.ChatBar

package hbm.Game.GUI.NewChat
{
    import flash.display.Sprite;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Game.GUI.Tools.BlinkingIcon;
    import hbm.Engine.Renderer.RenderSystem;
    import flash.display.InteractiveObject;
    import flash.events.MouseEvent;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.CharacterInfo;

    public class ChatBar extends Sprite 
    {

        private var _leftHUD:LeftHUD;
        private var _rightHUD:RightHUD;
        private var _rightBar:RightChatBar;
        private var _leftBar:LeftChatBar;
        private var _broadcastBar:BroadcastChatChannel;
        private var _toolTips:Array;
        private var _hideChatTip:CustomToolTip;
        private var _blinkerChat:BlinkingIcon;
        private var _chatHided:Boolean = false;
        private var _chatListButtonHided:Boolean = false;
        private var _chatListPanelHided:Boolean = false;
        private var _partyListPanelHided:Boolean = false;
        private var _notificationChat:NotificationChat;

        public function ChatBar()
        {
            x = (RenderSystem.Instance.ScreenWidth / 2);
            y = 0;
            this._leftHUD = new LeftHUD();
            this._rightHUD = new RightHUD();
            tabEnabled = false;
            tabChildren = false;
            addChild(this._leftHUD);
            addChild(this._rightHUD);
            this._leftHUD.x = 0;
            this._leftHUD._chatPanel._backgrFriends.visible = false;
            this._rightHUD.x = RenderSystem.Instance.ScreenWidth;
            this._rightBar = new RightChatBar(this._rightHUD._chatListPanel.width, this._rightHUD._chatListPanel.height);
            this._leftBar = new LeftChatBar(this._leftHUD._chatPanel.width, this._leftHUD._chatPanel.height);
            this._blinkerChat = new BlinkingIcon(this._leftHUD._hideChatButton);
            this._toolTips = new Array();
            this._rightHUD._chatListPanel.addChild(this._rightBar);
            this._leftHUD._chatPanel.addChild(this._leftBar);
            this._notificationChat = new NotificationChat(350);
            var _local_1:Sprite = new Sprite();
            _local_1.x = 21;
            _local_1.y = 0;
            this._notificationChat.visible = false;
            _local_1.addChild(this._notificationChat);
            this._leftHUD.addChild(_local_1);
        }

        public function GetNotificationChat():NotificationChat
        {
            return (this._notificationChat);
        }

        public function get IsChatHided():Boolean
        {
            return (this._chatHided);
        }

        protected function AddToolTip(_arg_1:InteractiveObject, _arg_2:String, _arg_3:int=-1, _arg_4:int=-1):void
        {
            var _local_5:CustomToolTip = new CustomToolTip(_arg_1, _arg_2, _arg_3, _arg_4);
            this._toolTips.push(_local_5);
        }

        public function get GetLeftHUD():LeftHUD
        {
            return (this._leftHUD);
        }

        public function get GetLeftBar():LeftChatBar
        {
            return (this._leftBar);
        }

        public function get GetRightHUD():RightHUD
        {
            return (this._rightHUD);
        }

        public function get GetRightBar():RightChatBar
        {
            return (this._rightBar);
        }

        public function get BlinkerChatButton():BlinkingIcon
        {
            return (this._blinkerChat);
        }

        public function GetBroadcastChat():BroadcastChatChannel
        {
            return (this._broadcastBar);
        }

        public function InitializeChatPanels():void
        {
            this._broadcastBar = new BroadcastChatChannel(this._leftHUD._chatBroadcast);
            this._leftHUD._chatBroadcastButton.addEventListener(MouseEvent.CLICK, this.OnHideChatBroadcastButton, false, 0, true);
            var _local_1:CustomToolTip = new CustomToolTip(this._leftHUD._chatBroadcastButton, ClientApplication.Instance.GetPopupText(0x0100), 150, 10);
            this._leftHUD._clearChatButton.addEventListener(MouseEvent.CLICK, this.OnClearChat, false, 0, true);
            var _local_2:CustomToolTip = new CustomToolTip(this._leftHUD._clearChatButton, ClientApplication.Instance.GetPopupText(30), 250, 25);
            this._leftHUD._emotionButton.addEventListener(MouseEvent.CLICK, this.OnEmotion, false, 0, true);
            var _local_3:CustomToolTip = new CustomToolTip(this._leftHUD._emotionButton, ClientApplication.Instance.GetPopupText(156), 130, 25);
            this._leftHUD._hideChatButton.addEventListener(MouseEvent.CLICK, this.OnHideChat, false, 0, true);
            this._hideChatTip = new CustomToolTip(this._leftHUD._hideChatButton, ClientApplication.Instance.GetPopupText(210), 100, 25, false);
            this._rightHUD._chatListButton.addEventListener(MouseEvent.CLICK, this.OnHideChatList, false, 0, true);
            this._rightHUD._partyInfoPanel._partyButton.addEventListener(MouseEvent.CLICK, this.OnHidePartyList, false, 0, true);
        }

        private function OnHideChatList(_arg_1:MouseEvent):void
        {
            this._rightHUD._chatListPanel.visible = this._chatListPanelHided;
            this._rightHUD._chatListButton.scaleY = -(this._rightHUD._chatListButton.scaleY);
            this._rightHUD._chatListButton.y = (this._rightHUD._chatListButton.y + ((this._rightHUD._chatListButton.scaleY < 0) ? -(this._rightHUD._chatListButton.height) : this._rightHUD._chatListButton.height));
            this._chatListPanelHided = (!(this._chatListPanelHided));
        }

        private function OnHidePartyList(_arg_1:MouseEvent):void
        {
            ClientApplication.Instance.PartyList.GetUIComponent().visible = this._partyListPanelHided;
            this._partyListPanelHided = (!(this._partyListPanelHided));
        }

        public function RevalidatePartyPanel():void
        {
            var _local_1:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            this._rightHUD._partyInfoPanel.visible = (!(_local_1.Party == null));
        }

        private function OnHideChatBroadcastButton(_arg_1:MouseEvent):void
        {
            if (this._broadcastBar.IsShowing)
            {
                this._broadcastBar.Close();
            }
            else
            {
                if (!this._leftHUD._chatPanel.visible)
                {
                    this.OnHideChat(null);
                };
                this._broadcastBar.Show();
            };
        }

        private function OnClearChat(_arg_1:MouseEvent):void
        {
            this._leftBar.ClearChannel();
        }

        private function OnEmotion(_arg_1:MouseEvent):void
        {
            ClientApplication.Instance.ShowEmotionWindow();
        }

        public function OnHideChat(_arg_1:MouseEvent):void
        {
            if (this._chatHided)
            {
                ClientApplication.Instance.ChatHUD.BlinkerChatButton.Stop();
            };
            this._leftHUD._chatPanel.visible = this._chatHided;
            if (this._leftHUD._chatPanel.visible)
            {
                if (this._leftHUD._hideChatButton.scaleX != 1)
                {
                    this._leftHUD._hideChatButton.scaleX = 1;
                    this._leftHUD._hideChatButton.x = (this._leftHUD._hideChatButton.x - this._leftHUD._hideChatButton.width);
                };
                this._leftHUD._chatBroadcastButton.visible = (this._leftHUD._clearChatButton.visible = (this._leftHUD._emotionButton.visible = (!(this._leftBar.GetCurTab() == null))));
            }
            else
            {
                this._leftHUD._chatBroadcastButton.visible = (this._leftHUD._clearChatButton.visible = (this._leftHUD._emotionButton.visible = true));
                if (this._leftHUD._hideChatButton.scaleX != -1)
                {
                    this._leftHUD._hideChatButton.scaleX = -1;
                    this._leftHUD._hideChatButton.x = (this._leftHUD._hideChatButton.x + this._leftHUD._hideChatButton.width);
                };
            };
            this._chatHided = (!(this._chatHided));
            this._notificationChat.visible = this._chatHided;
            if (this._broadcastBar)
            {
                this._broadcastBar.Close();
            };
            if (this._chatHided)
            {
                this._hideChatTip.updateToolTip(ClientApplication.Instance.GetPopupText(264));
                this._leftBar.StopAutoHideChat();
            }
            else
            {
                this._hideChatTip.updateToolTip(ClientApplication.Instance.GetPopupText(210));
                this._leftBar.StartAutoHideChat();
            };
        }

        public function SetChatEnabled(_arg_1:Boolean):void
        {
            this._leftBar.PublicChannel.SetChatEnabled(_arg_1);
            this._leftBar.TradeChannel.SetChatEnabled(_arg_1);
            this._leftBar.GuildChannel.SetChatEnabled(_arg_1);
            this._leftBar.PartyChannel.SetChatEnabled(_arg_1);
            this._leftBar.PrivateChannel.SetChatEnabled(_arg_1);
            this._leftHUD._emotionButton.enabled = _arg_1;
            if (_arg_1)
            {
                this._leftHUD._emotionButton.addEventListener(MouseEvent.CLICK, this.OnEmotion, false, 0, true);
            }
            else
            {
                this._leftHUD._emotionButton.removeEventListener(MouseEvent.CLICK, this.OnEmotion);
            };
        }

        public function RevalidatePositions():void
        {
            var _local_1:int;
            _local_1 = RenderSystem.Instance.ScreenHeight;
            this._leftHUD.x = 0;
            this._leftHUD.y = (_local_1 - 160);
            this._rightHUD.x = RenderSystem.Instance.ScreenWidth;
            this._rightHUD._partyInfoPanel.y = 160;
            this._rightHUD._chatListPanel.y = ((_local_1 - 110) - 144);
            this._rightHUD._chatListButton.y = this._rightHUD._chatListPanel.y;
        }


    }
}//package hbm.Game.GUI.NewChat

