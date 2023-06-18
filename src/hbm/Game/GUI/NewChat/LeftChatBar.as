


//hbm.Game.GUI.NewChat.LeftChatBar

package hbm.Game.GUI.NewChat
{
    import flash.display.Sprite;
    import flash.utils.Timer;
    import org.aswing.JWindow;
    import hbm.Game.GUI.Tools.CustomTabbedPane;
    import flash.events.Event;
    import org.aswing.geom.IntDimension;
    import flash.events.TimerEvent;
    import flash.events.MouseEvent;
    import hbm.Application.ClientApplication;
    import hbm.Game.Character.CharacterStorage;
    import caurina.transitions.Tweener;
    import org.aswing.JTabbedPane;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.JPanel;
    import org.aswing.BorderLayout;
    import org.aswing.event.AWEvent;
    import hbm.Game.GUI.Tools.BlinkingIcon;
    import hbm.Game.GUI.Inventory.InventoryItem;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.Bitmap;
    import org.aswing.AssetIcon;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class LeftChatBar extends Sprite 
    {

        private static const DELAY_AUTO_HIDE_CHAT:uint = 8;
        private static const TIME_HIDE_CHAT:uint = 4;
        public static const PUBLIC_CHANNEL:int = 0;
        public static const TRADE_CHANNEL:int = 1;
        public static const PARTY_CHANNEL:int = 2;
        public static const GUILD_CHANNEL:int = 3;
        public static const PRIVATE_CHANNEL:int = 4;
        public static const INVITE_CHANNEL:int = 5;
        private static const _city:Array = ["city00", "construct", "agarzuk", "un_shantum", "tu_city"];

        private const _timerAutoHide:Timer = new Timer((DELAY_AUTO_HIDE_CHAT * 1000), 1);

        private var _width:int;
        private var _height:int;
        private var _frame:JWindow;
        private var _tabbedPane:CustomTabbedPane;
        private var _publicChannel:NewChatChannel;
        private var _privateChannel:NewChatChannel;
        private var _partyChannel:NewChatChannel;
        private var _guildChannel:NewChatChannel;
        private var _tradeChannel:NewChatChannel;
        private var _inviteChannel:InviteFriendChannel;
        private var _blinkers:Array;

        public function LeftChatBar(_arg_1:int, _arg_2:int)
        {
            x = 0;
            y = 0;
            this._width = _arg_1;
            this._height = _arg_2;
            this._blinkers = new Array();
            addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
            this._frame = new JWindow(this);
            this._frame.getContentPane().append(this.CreatePanel());
            this._frame.getContentPane().setFocusable(false);
            this._frame.setSize(new IntDimension(_arg_1, _arg_2));
            this._frame.setMaximumSize(new IntDimension(_arg_1, _arg_2));
            this._frame.setFocusable(false);
            this._frame.setOpaque(false);
            this._frame.show();
            this._timerAutoHide.addEventListener(TimerEvent.TIMER_COMPLETE, this.OnAutoHideChat);
            addEventListener(MouseEvent.ROLL_OVER, this.OnOver, false, 0, true);
            addEventListener(MouseEvent.ROLL_OUT, this.OnOut, false, 0, true);
        }

        private function OnOver(_arg_1:MouseEvent):void
        {
            this.StopAutoHideChat();
        }

        private function OnOut(_arg_1:MouseEvent):void
        {
            var _local_2:NewChatChannel = this.GetCurTab();
            if (!(((_local_2) && (_local_2.IsFocused())) || (ClientApplication.Instance.ChatHUD.GetBroadcastChat().IsShowing)))
            {
                this.StartAutoHideChat();
            };
        }

        private function OnAutoHideChat(event:TimerEvent):void
        {
            var HideChat:Function;
            HideChat = function ():void
            {
                ClientApplication.Instance.ChatHUD.OnHideChat(null);
                ResetTweener();
            };
            if (!CharacterStorage.Instance.IsEnableChatHiding)
            {
                return;
            };
            Tweener.addTween(this, {
                "alpha":0.15,
                "time":TIME_HIDE_CHAT,
                "transition":"linear",
                "onComplete":HideChat
            });
            Tweener.addTween(ClientApplication.Instance.ChatHUD.GetLeftHUD._chatPanel, {
                "alpha":0.15,
                "time":TIME_HIDE_CHAT,
                "transition":"linear"
            });
        }

        public function StartAutoHideChat():void
        {
            var _local_1:String;
            if (!CharacterStorage.Instance.IsEnableChatHiding)
            {
                return;
            };
            this.ResetTweener();
            this._timerAutoHide.reset();
            _local_1 = ClientApplication.Instance.LocalGameClient.MapName.split(".")[0];
            var _local_2:int = _city.indexOf(_local_1);
            if (_local_2 >= 0)
            {
                return;
            };
            this._timerAutoHide.start();
        }

        public function StopAutoHideChat():void
        {
            if (!CharacterStorage.Instance.IsEnableChatHiding)
            {
                return;
            };
            this.ResetTweener();
            this._timerAutoHide.stop();
        }

        private function ResetTweener():void
        {
            Tweener.removeTweens(ClientApplication.Instance.ChatHUD.GetLeftHUD._chatPanel);
            Tweener.removeTweens(this);
            alpha = (ClientApplication.Instance.ChatHUD.GetLeftHUD._chatPanel.alpha = 1);
        }

        private function CreatePanel():JPanel
        {
            this._tabbedPane = new CustomTabbedPane();
            this._tabbedPane.setTabPlacement(JTabbedPane.TOP);
            this._tabbedPane.setFocusable(false);
            this._tabbedPane.setBorder(new EmptyBorder(null, new Insets(0, 2, 0, 4)));
            this._publicChannel = new NewChatChannel(this, PUBLIC_CHANNEL);
            this._tradeChannel = new NewTradeChatChannel(this, TRADE_CHANNEL);
            this._partyChannel = new NewPartyChatChannel(this, PARTY_CHANNEL);
            this._guildChannel = new NewGuildChatChannel(this, GUILD_CHANNEL);
            this._privateChannel = new NewPrivateChatChannel(this, PRIVATE_CHANNEL);
            this._tabbedPane.AppendCustomTab(this._publicChannel, null, null, ClientApplication.Instance.GetPopupText(22));
            this._tabbedPane.AppendCustomTab(this._tradeChannel, null, null, ClientApplication.Instance.GetPopupText(176));
            this._tabbedPane.AppendCustomTab(this._partyChannel, null, null, ClientApplication.Instance.GetPopupText(211));
            this._tabbedPane.AppendCustomTab(this._guildChannel, null, null, ClientApplication.Instance.GetPopupText(23));
            this._tabbedPane.AppendCustomTab(this._privateChannel, null, null, ClientApplication.Instance.GetPopupText(24));
            this._tabbedPane.addStateListener(this.OnTabChaged);
            var _local_1:JPanel = new JPanel(new BorderLayout());
            _local_1.append(this._tabbedPane, BorderLayout.CENTER);
            _local_1.setFocusable(false);
            return (_local_1);
        }

        public function GetCurTab():NewChatChannel
        {
            return (this._tabbedPane.getComponent(this._tabbedPane.getSelectedIndex()) as NewChatChannel);
        }

        private function OnTabChaged(_arg_1:AWEvent):void
        {
            var _local_2:Boolean;
            this.GetBlinkingIcon(this._tabbedPane.getSelectedIndex()).Stop();
            ClientApplication.Instance.ChatHUD.GetBroadcastChat().Close();
            _local_2 = (this._tabbedPane.getSelectedIndex() == INVITE_CHANNEL);
            ClientApplication.Instance.ChatHUD.GetLeftHUD._chatPanel._backgrFriends.visible = _local_2;
            if (_local_2)
            {
                this.StopAutoHideChat();
            };
            var _local_3:LeftHUD = ClientApplication.Instance.ChatHUD.GetLeftHUD;
            _local_3._chatBroadcastButton.visible = (_local_3._clearChatButton.visible = (_local_3._emotionButton.visible = (!(_local_2))));
        }

        public function get PublicChannel():NewChatChannel
        {
            return (this._publicChannel);
        }

        public function get GuildChannel():NewGuildChatChannel
        {
            return (this._guildChannel as NewGuildChatChannel);
        }

        public function get PartyChannel():NewPartyChatChannel
        {
            return (this._partyChannel as NewPartyChatChannel);
        }

        public function get PrivateChannel():NewPrivateChatChannel
        {
            return (this._privateChannel as NewPrivateChatChannel);
        }

        public function get TradeChannel():NewTradeChatChannel
        {
            return (this._tradeChannel as NewTradeChatChannel);
        }

        public function get FriendsChannel():InviteFriendChannel
        {
            return (this._inviteChannel);
        }

        public function RequestBlinking(_arg_1:int):void
        {
            var _local_2:BlinkingIcon;
            if (_arg_1 != this._tabbedPane.getSelectedIndex())
            {
                _local_2 = this.GetBlinkingIcon(_arg_1);
                if (_local_2 != null)
                {
                    _local_2.Start();
                };
            };
        }

        public function GetBlinkingIcon(_arg_1:int):BlinkingIcon
        {
            return (this._blinkers[_arg_1]);
        }

        public function IsFocused():Boolean
        {
            return (((((this._guildChannel.IsFocused()) || (this._privateChannel.IsFocused())) || (this._partyChannel.IsFocused())) || (this._publicChannel.IsFocused())) || (this._tradeChannel.IsFocused()));
        }

        public function SendItemLink(_arg_1:InventoryItem):void
        {
            if (ClientApplication.Instance.ChatHUD.GetBroadcastChat().IsShowing)
            {
                return;
            };
            this.GetCurTab().SendItemLink(_arg_1);
            this.SetFocus();
        }

        public function SetFocus(_arg_1:int=-1):void
        {
            if (ClientApplication.Instance.ChatHUD.GetBroadcastChat().IsShowing)
            {
                ClientApplication.Instance.ChatHUD.GetBroadcastChat().Show(true);
                return;
            };
            if (_arg_1 >= 0)
            {
                this._tabbedPane.setSelectedIndex(_arg_1);
            };
            if (ClientApplication.Instance.ChatHUD.IsChatHided)
            {
                ClientApplication.Instance.ChatHUD.OnHideChat(null);
            };
            var _local_2:NewChatChannel = (this._tabbedPane.getSelectedComponent() as NewChatChannel);
            if (_local_2)
            {
                _local_2.SetFocus();
            };
        }

        public function RemoveFocus():void
        {
            if (ClientApplication.Instance.ChatHUD.GetBroadcastChat().IsShowing)
            {
                ClientApplication.Instance.ChatHUD.GetBroadcastChat().Close();
                return;
            };
            var _local_1:NewChatChannel = (this._tabbedPane.getSelectedComponent() as NewChatChannel);
            if (_local_1)
            {
                _local_1.RemoveFocus();
            };
        }

        public function ClearChannel():void
        {
            var _local_1:NewChatChannel = (this._tabbedPane.getSelectedComponent() as NewChatChannel);
            if (_local_1)
            {
                _local_1.ClearChat(null);
            };
        }

        public function ClearAllChannels():void
        {
            this._publicChannel.ClearChat(null);
            this._tradeChannel.ClearChat(null);
            this._partyChannel.ClearChat(null);
            this._guildChannel.ClearChat(null);
            this._privateChannel.ClearChat(null);
        }

        private function OnAddedToStage(_arg_1:Event):void
        {
            this._guildChannel.DisplayHint();
            this._privateChannel.DisplayHint();
            this._tradeChannel.DisplayHint();
            this._partyChannel.DisplayHint();
            this.UpdateGraphics();
        }

        private function UpdateGraphics():void
        {
            var _local_1:AdditionalDataResourceLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._publicChannel.UpdateGraphics();
            this._guildChannel.UpdateGraphics();
            this._privateChannel.UpdateGraphics();
            this._tradeChannel.UpdateGraphics();
            this._partyChannel.UpdateGraphics();
            var _local_2:Bitmap = _local_1.GetBitmapAsset("AdditionalData_Item_ChatWindowPublicButtonActive");
            this._tabbedPane.SetActiveIconTo(new AssetIcon(_local_2), PUBLIC_CHANNEL);
            var _local_3:Bitmap = _local_1.GetBitmapAsset("AdditionalData_Item_ChatWindowTradeButtonActive");
            this._tabbedPane.SetActiveIconTo(new AssetIcon(_local_3), TRADE_CHANNEL);
            var _local_4:Bitmap = _local_1.GetBitmapAsset("AdditionalData_Item_ChatWindowPartyButtonActive");
            this._tabbedPane.SetActiveIconTo(new AssetIcon(_local_4), PARTY_CHANNEL);
            var _local_5:Bitmap = _local_1.GetBitmapAsset("AdditionalData_Item_ChatWindowGuildButtonActive");
            this._tabbedPane.SetActiveIconTo(new AssetIcon(_local_5), GUILD_CHANNEL);
            var _local_6:Bitmap = _local_1.GetBitmapAsset("AdditionalData_Item_ChatWindowPrivateButtonActive");
            this._tabbedPane.SetActiveIconTo(new AssetIcon(_local_6), PRIVATE_CHANNEL);
            this._blinkers = new Array();
            var _local_7:Bitmap = _local_1.GetBitmapAsset("AdditionalData_Item_ChatWindowPublicButtonInactive");
            this.SetInactiveAndBlinkIcon(_local_7, PUBLIC_CHANNEL);
            var _local_8:Bitmap = _local_1.GetBitmapAsset("AdditionalData_Item_ChatWindowTradeButtonInactive");
            this.SetInactiveAndBlinkIcon(_local_8, TRADE_CHANNEL);
            var _local_9:Bitmap = _local_1.GetBitmapAsset("AdditionalData_Item_ChatWindowPartyButtonInactive");
            this.SetInactiveAndBlinkIcon(_local_9, PARTY_CHANNEL);
            var _local_10:Bitmap = _local_1.GetBitmapAsset("AdditionalData_Item_ChatWindowGuildButtonInactive");
            this.SetInactiveAndBlinkIcon(_local_10, GUILD_CHANNEL);
            var _local_11:Bitmap = _local_1.GetBitmapAsset("AdditionalData_Item_ChatWindowPrivateButtonInactive");
            this.SetInactiveAndBlinkIcon(_local_11, PRIVATE_CHANNEL);
            this.InitInviteFriendsChanel(_local_1);
            this._tabbedPane.UpdateSelection();
        }

        private function InitInviteFriendsChanel(_arg_1:AdditionalDataResourceLibrary):void
        {
            this._inviteChannel = new InviteFriendChannel(this, INVITE_CHANNEL);
            this._tabbedPane.AppendCustomTab(this._inviteChannel, null, null, ClientApplication.Instance.GetPopupText(266));
            this._inviteChannel.UpdateGraphics();
            var _local_2:Bitmap = _arg_1.GetBitmapAsset("Localization_Item_ChatWindowInviteButton");
            this._tabbedPane.SetActiveIconTo(new AssetIcon(_local_2), INVITE_CHANNEL);
            var _local_3:Bitmap = _arg_1.GetBitmapAsset("Localization_Item_ChatWindowInviteButtonInactive");
            this.SetInactiveAndBlinkIcon(_local_3, INVITE_CHANNEL);
        }

        private function SetInactiveAndBlinkIcon(_arg_1:Bitmap, _arg_2:int):void
        {
            var _local_4:Number;
            var _local_3:Sprite = new Sprite();
            _local_3.addChild(_arg_1);
            _local_4 = 3;
            var _local_5:Bitmap = new Bitmap(new BitmapData(_arg_1.width, _local_4, true, 0));
            _local_5.y = (_arg_1.height - _local_4);
            _local_5.bitmapData.copyPixels(_arg_1.bitmapData, new Rectangle(0, _local_5.y, _arg_1.width, _local_4), new Point(0, 0));
            _local_3.addChild(_local_5);
            this._tabbedPane.SetInactiveIconTo(new AssetIcon(_local_3), _arg_2);
            this._blinkers.push(new BlinkingIcon(_arg_1));
        }


    }
}//package hbm.Game.GUI.NewChat

