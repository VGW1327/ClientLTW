


//hbm.Game.GUI.NewChat.BroadcastChatChannel

package hbm.Game.GUI.NewChat
{
    import flash.display.MovieClip;
    import org.aswing.JTextField;
    import flash.events.MouseEvent;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Application.ClientApplication;
    import org.aswing.ASColor;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Game.Utility.HtmlText;
    import org.aswing.JPanel;
    import org.aswing.BorderLayout;
    import flash.events.FocusEvent;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import flash.events.Event;

    public class BroadcastChatChannel 
    {

        private var _broadcastMovie:MovieClip;
        protected var _messageField:JTextField;

        public function BroadcastChatChannel(_arg_1:MovieClip)
        {
            this._broadcastMovie = _arg_1;
            this._broadcastMovie.visible = false;
            this._broadcastMovie._closeButton.addEventListener(MouseEvent.CLICK, this.Close, false, 0, true);
            var _local_2:CustomToolTip = new CustomToolTip(this._broadcastMovie._closeButton, ClientApplication.Instance.GetPopupText(2), 150, 10);
            this._broadcastMovie._labelEnable._title.text = ClientApplication.Localization.CHAT_WORLD_MESSAGE_HELP;
            this._broadcastMovie._labelEnable._info.text = ClientApplication.Localization.CHAT_SEND_WORLD_MESSAGE_HELP;
            this._broadcastMovie._labelDisable._title.text = ClientApplication.Localization.CHAT_NOT_BULLHORN_HELP;
            this._broadcastMovie._labelDisable._info.text = ClientApplication.Localization.CHAT_NOTSEND_WORLD_MESSAGE_HELP;
            this._broadcastMovie._labelDisable._buttonBuy.addEventListener(MouseEvent.CLICK, this.OnBuyBroadcast, false, 0, true);
            var _local_3:CustomToolTip = new CustomToolTip(this._broadcastMovie._labelDisable._buttonBuy, ClientApplication.Instance.GetPopupText(0x0101), 200, 10);
            this._messageField = new JTextField();
            this._messageField.setMaxChars(200);
            this._messageField.setOpaque(false);
            this._messageField.setForeground(new ASColor(13421796));
            this._messageField.setBorder(new EmptyBorder(null, new Insets(4, 22, 2, 10)));
            this._messageField.filters = [HtmlText.shadow];
            this._messageField.setPreferredWidth(this._broadcastMovie.width);
            this._messageField.pack();
            var _local_4:CustomToolTip = new CustomToolTip(this._messageField, ClientApplication.Instance.GetPopupText(125), 200, 10);
            var _local_5:JPanel = new JPanel(new BorderLayout());
            _local_5.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            _local_5.setLocationXY(0, (this._broadcastMovie.height - this._messageField.height));
            _local_5.append(this._messageField, BorderLayout.CENTER);
            _local_5.pack();
            this._broadcastMovie.addChild(_local_5);
            this._messageField.addEventListener(FocusEvent.FOCUS_IN, this.OnFocusIn);
            this._messageField.addEventListener(FocusEvent.FOCUS_OUT, this.OnFocusOut);
            this._messageField.addActionListener(this.SendMessage, 0, true);
        }

        private function OnBuyBroadcast(_arg_1:MouseEvent):void
        {
            ClientApplication.Instance.SetAnaloguesId("22829");
            ClientApplication.Instance.OpenCashShop();
            this.Close();
        }

        public function Close(_arg_1:MouseEvent=null):void
        {
            this._messageField.setText("");
            this._broadcastMovie.visible = false;
            ClientApplication.Instance.SetShortcutsEnabled(true);
            ClientApplication.Instance.ChatHUD.GetLeftBar.StartAutoHideChat();
        }

        public function Show(_arg_1:Boolean=false):void
        {
            var _local_4:ItemData;
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_3:Boolean;
            for each (_local_4 in _local_2.Items)
            {
                if (((_local_4.NameId == 22828) && (_local_4.Amount > 0)))
                {
                    _local_3 = true;
                    break;
                };
            };
            this._broadcastMovie._labelDisable.visible = (!(_local_3));
            this._messageField.mouseEnabled = (this._messageField.mouseChildren = (this._broadcastMovie._labelEnable.visible = _local_3));
            this._broadcastMovie._labelEnable._info.visible = (this._broadcastMovie._labelDisable._info.visible = (this._messageField.getText().length < 1));
            this._broadcastMovie.visible = true;
            ClientApplication.Instance.SetShortcutsEnabled(false);
            if (((_arg_1) && (_local_3)))
            {
                this._messageField.makeFocus();
            };
            ClientApplication.Instance.ChatHUD.GetLeftBar.StopAutoHideChat();
        }

        public function get IsShowing():Boolean
        {
            return (this._broadcastMovie.visible);
        }

        private function OnFocusIn(_arg_1:FocusEvent):void
        {
            this._broadcastMovie._labelEnable._info.visible = false;
        }

        private function OnFocusOut(_arg_1:FocusEvent):void
        {
            if (this._messageField.getText().length < 1)
            {
                this._broadcastMovie._labelEnable._info.visible = true;
            };
        }

        protected function SendMessage(evt:Event):void
        {
            var filtered:String;
            var message:String = this._messageField.getText();
            if (message != "")
            {
                filtered = HtmlText.fixTags(message);
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, (((ClientApplication.Localization.CHAT_REQUEST_SEND_WORLD_MESSAGE_HELP + " '") + filtered) + "'?"), function OnAccepted (_arg_1:int):void
                {
                    if (_arg_1 == JOptionPane.YES)
                    {
                        ClientApplication.Instance.LocalGameClient.SendBroadcastMessage(filtered);
                        _messageField.setText("");
                        Close();
                    };
                }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            }
            else
            {
                this.Close();
            };
        }


    }
}//package hbm.Game.GUI.NewChat

