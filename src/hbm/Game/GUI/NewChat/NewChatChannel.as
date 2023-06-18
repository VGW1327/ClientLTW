


//hbm.Game.GUI.NewChat.NewChatChannel

package hbm.Game.GUI.NewChat
{
    import org.aswing.JPanel;
    import org.aswing.JTextField;
    import flash.text.TextField;
    import org.aswing.JCheckBox;
    import hbm.Game.GUI.Inventory.InventoryItem;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Application.ClientApplication;
    import org.aswing.ASColor;
    import hbm.Game.Utility.HtmlText;
    import flash.events.FocusEvent;
    import flash.events.Event;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Game.Utility.CharacterMenu;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;

    public class NewChatChannel extends JPanel 
    {

        public static const WIDTH_CHAT:Number = 350;
        public static const HEIGHT_CHAT:Number = 90;
        public static const LINK_TAG:String = "|lnk|";
        public static const LINK_TAG_REG:RegExp = /\|lnk\|/g;

        protected var _chatArea:InteractiveChatArea;
        protected var _messageField:JTextField;
        protected var _infoMessageField:TextField;
        protected var _parent:LeftChatBar;
        protected var _index:int;
        protected var _chatPanel:JPanel;
        private var _unlockChat:JCheckBox;
        private var _linkItem:InventoryItem;
        private var _parseLinkName:String;
        private var _itemsLibrary:ItemsResourceLibrary;

        public function NewChatChannel(_arg_1:LeftChatBar, _arg_2:int)
        {
            var _local_4:JPanel;
            super(new BorderLayout());
            setOpaque(false);
            this._parent = _arg_1;
            this._index = _arg_2;
            this._chatPanel = new JPanel(new BorderLayout());
            this._chatPanel.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            this._unlockChat = new JCheckBox("");
            this._unlockChat.setVerticalAlignment(SoftBoxLayout.TOP);
            this._unlockChat.setHorizontalAlignment(SoftBoxLayout.LEFT);
            this._unlockChat.setSelected(true);
            this._unlockChat.setBorder(new EmptyBorder());
            this._unlockChat.addSelectionListener(this.OnUnLockChat);
            var _local_3:CustomToolTip = new CustomToolTip(this._unlockChat, ClientApplication.Instance.GetPopupText(0xFF), 240, 20);
            this._chatPanel.append(this._unlockChat, BorderLayout.WEST);
            this._chatArea = new InteractiveChatArea(WIDTH_CHAT, HEIGHT_CHAT);
            this._chatPanel.append(this._chatArea, BorderLayout.CENTER);
            _local_4 = new JPanel(new BorderLayout());
            _local_4.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            this._messageField = new JTextField();
            this._messageField.setMaxChars(200);
            this._messageField.setOpaque(false);
            this._messageField.setForeground(new ASColor(13421796));
            this._messageField.setBorder(new EmptyBorder(null, new Insets(4, 22, 2, 10)));
            this._messageField.filters = [HtmlText.shadow];
            var _local_5:CustomToolTip = new CustomToolTip(this._messageField, ClientApplication.Instance.GetPopupText(125), 200, 10);
            _local_4.append(this._messageField, BorderLayout.CENTER);
            this._messageField.addEventListener(FocusEvent.FOCUS_IN, this.OnFocusIn);
            this._messageField.addEventListener(FocusEvent.FOCUS_OUT, this.OnFocusOut);
            this._infoMessageField = new JTextField().getTextField();
            this._infoMessageField.alpha = 0.8;
            this._infoMessageField.htmlText = ClientApplication.Localization.CHAT_SEND_HELP;
            this._infoMessageField.selectable = false;
            this._infoMessageField.x = 18;
            this._infoMessageField.y = 4;
            this._infoMessageField.width = (this._infoMessageField.textWidth + 10);
            this._infoMessageField.mouseEnabled = false;
            _local_4.addChild(this._infoMessageField);
            _local_4.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            this._chatPanel.append(_local_4, BorderLayout.SOUTH);
            this._chatPanel.setFocusable(false);
            this._chatPanel.setBorder(new EmptyBorder(null, new Insets(-1, 0, 0, 0)));
            append(this._chatPanel, BorderLayout.CENTER);
            this.initHandlers();
        }

        private function OnFocusIn(_arg_1:FocusEvent):void
        {
            this._infoMessageField.visible = false;
            this._parent.StopAutoHideChat();
        }

        private function OnFocusOut(_arg_1:FocusEvent):void
        {
            if (this._messageField.getText().length < 1)
            {
                this._infoMessageField.visible = true;
            };
            this._parent.StartAutoHideChat();
        }

        private function OnUnLockChat(_arg_1:Event):void
        {
            if (this._unlockChat.isSelected())
            {
                this._chatArea.Lock();
            }
            else
            {
                this._chatArea.Unlock();
            };
        }

        private function initHandlers():void
        {
            this._messageField.addActionListener(this.SendMessage, 0, true);
        }

        public function SendItemLink(_arg_1:InventoryItem):void
        {
            if (null == _arg_1)
            {
                return;
            };
            this._linkItem = _arg_1;
            var _local_2:String = this._messageField.getText();
            if (((this._parseLinkName) && (_local_2.indexOf(this._parseLinkName) > -1)))
            {
                _local_2 = _local_2.replace(this._parseLinkName, "");
            };
            this._parseLinkName = this._linkItem.GetChatLinkName(false);
            this._messageField.setText(((_local_2 + " ") + this._parseLinkName));
            var _local_3:uint = (this._messageField.getText().length + 1);
            this._messageField.setSelection(_local_3, _local_3);
            this._messageField.makeFocus();
        }

        protected function PackItemLink(_arg_1:String):String
        {
            var _local_2:String;
            var _local_3:uint;
            if (_arg_1)
            {
                _arg_1 = _arg_1.replace(LINK_TAG_REG, "");
                if ((((this._linkItem) && (this._parseLinkName)) && (_arg_1.indexOf(this._parseLinkName) > -1)))
                {
                    _local_2 = (LINK_TAG + this._linkItem.Item.NameId);
                    if (this._linkItem.Item.Cards)
                    {
                        _local_3 = 0;
                        while (_local_3 < 4)
                        {
                            if (this._linkItem.Item.Cards.length > _local_3)
                            {
                                _local_2 = (_local_2 + ("," + this._linkItem.Item.Cards[_local_3]));
                            }
                            else
                            {
                                _local_2 = (_local_2 + ",0");
                            };
                            _local_3++;
                        };
                    }
                    else
                    {
                        _local_2 = (_local_2 + ",0,0,0,0");
                    };
                    _local_2 = (_local_2 + ("," + this._linkItem.Item.Attr));
                    _local_2 = (_local_2 + ("," + this._linkItem.Item.Upgrade));
                    _local_2 = (_local_2 + LINK_TAG);
                    _arg_1 = _arg_1.replace(this._parseLinkName, _local_2);
                };
            };
            this._linkItem = null;
            this._parseLinkName = null;
            return (_arg_1);
        }

        private function OnClickItemLink(_arg_1:InventoryItem):void
        {
            _arg_1.Action(_arg_1);
        }

        protected function UnpackItemLink(_arg_1:InteractiveText, _arg_2:String):String
        {
            var _local_4:Array;
            var _local_5:ItemData;
            var _local_6:Object;
            var _local_7:InventoryItem;
            var _local_8:String;
            if (((null == _arg_2) || (null == _arg_1)))
            {
                return (_arg_2);
            };
            var _local_3:Array = _arg_2.split(LINK_TAG);
            if (_local_3.length > 1)
            {
                _local_4 = _local_3[1].split(",");
                if (_local_4.length == 7)
                {
                    _local_5 = new ItemData();
                    _local_5.Identified = 1;
                    _local_5.Origin = ItemData.QUEST;
                    _local_5.NameId = int(_local_4.shift());
                    _local_5.Cards = new <int>[int(_local_4.shift()), int(_local_4.shift()), int(_local_4.shift()), int(_local_4.shift()), 0, 0, 0, 0, 0, 0];
                    _local_5.Attr = int(_local_4.shift());
                    _local_5.Upgrade = int(_local_4.shift());
                    this._itemsLibrary = ((this._itemsLibrary) || (ItemsResourceLibrary(ResourceManager.Instance.Library("Items"))));
                    _local_6 = ((this._itemsLibrary.GetServerDescriptionObject(_local_5.NameId)) || ({}));
                    _local_5.Type = _local_6["type"];
                    _local_7 = new InventoryItem(_local_5);
                    _local_8 = _local_7.GetChatLinkName();
                    _arg_1.AddText(_local_3[0]);
                    _arg_1.AddLinkText(_local_8, this.OnClickItemLink, _local_7);
                    _arg_1.AddText(_local_3[2]);
                    return ((_local_3[0] + _local_8) + _local_3[2]);
                };
            };
            _arg_1.AddText(_arg_2);
            return (_arg_2);
        }

        public function AddNotification(_arg_1:InteractiveText):void
        {
            this._chatArea.AddText(_arg_1);
            if (this === ClientApplication.Instance.ChatHUD.GetLeftBar.GetCurTab())
            {
                ClientApplication.Instance.ChatHUD.GetNotificationChat().AddNotification(_arg_1);
            };
        }

        public function AddCharacterMessage(_arg_1:uint, _arg_2:String, _arg_3:String, _arg_4:String):String
        {
            var _local_6:InteractiveText;
            var _local_5:* = (ClientApplication.Instance.ServerTimeString.substr(0, 5) + " ");
            _local_6 = new InteractiveText((WIDTH_CHAT - 30));
            _local_6.AddText(_local_5);
            _local_6.AddLinkText(_arg_3, CharacterMenu.ShowUserMenu, _arg_1, _arg_2, false, true);
            var _local_7:String = this.UnpackItemLink(_local_6, _arg_4);
            this.AddNotification(_local_6);
            if (CharacterStorage.Instance.IsEnableBlinking)
            {
                this._parent.RequestBlinking(this._index);
                if (ClientApplication.Instance.ChatHUD.IsChatHided)
                {
                    ClientApplication.Instance.ChatHUD.BlinkerChatButton.Start();
                };
            };
            this.ScrollToTheEnd();
            return (_local_7);
        }

        public function AddMessage(_arg_1:String):String
        {
            var _local_3:InteractiveText;
            var _local_2:* = (ClientApplication.Instance.ServerTimeString.substr(0, 5) + " ");
            _local_3 = new InteractiveText((WIDTH_CHAT - 30));
            _local_3.AddText(_local_2);
            var _local_4:String = this.UnpackItemLink(_local_3, _arg_1);
            this.AddNotification(_local_3);
            if (CharacterStorage.Instance.IsEnableBlinking)
            {
                this._parent.RequestBlinking(this._index);
                if (ClientApplication.Instance.ChatHUD.IsChatHided)
                {
                    ClientApplication.Instance.ChatHUD.BlinkerChatButton.Start();
                };
            };
            this.ScrollToTheEnd();
            return (_local_4);
        }

        protected function ScrollToTheEnd():void
        {
            this._chatArea.ScrollToTheEnd();
        }

        public function MessageTemplate(_arg_1:String, _arg_2:uint=0):void
        {
            this._messageField.makeFocus();
            this._messageField.setText(_arg_1);
            var _local_3:uint = ((_arg_2) || (Math.min(_arg_1.length, _arg_2)));
            this._messageField.setSelection(_local_3, _local_3);
        }

        protected function SendMessage(_arg_1:Event):void
        {
            var _local_3:String;
            var _local_4:Boolean;
            var _local_2:String = this.PackItemLink(this._messageField.getText());
            if (_local_2 != "")
            {
                _local_4 = false;
                if (((!(_local_2.indexOf("@") == 0)) && (!(_local_2.indexOf("#") == 0))))
                {
                    _local_3 = _local_2;
                }
                else
                {
                    _local_4 = true;
                    _local_3 = _local_2;
                };
                if (!_local_4)
                {
                    if (this._index == LeftChatBar.TRADE_CHANNEL)
                    {
                        _local_3 = ("/t " + _local_3);
                    };
                };
                ClientApplication.Instance.LocalGameClient.SendChatMessage(HtmlText.fixTags(_local_3));
                this._messageField.setText("");
            };
        }

        public function AddEmotion(_arg_1:int, _arg_2:String, _arg_3:int):void
        {
            var _local_4:AdditionalDataResourceLibrary;
            var _local_6:String;
            _local_4 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_5:Object = _local_4.GetEmotionData(_arg_1);
            if (((_local_5) && (_local_5.Message)))
            {
                _local_6 = (((((("*" + _arg_2) + "[") + _arg_3) + "]") + " ") + _local_5.Message);
                this.AddMessage(_local_6);
            };
        }

        public function AddPetEmotion(_arg_1:int, _arg_2:String):void
        {
            var _local_3:AdditionalDataResourceLibrary;
            var _local_5:String;
            _local_3 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_4:Object = _local_3.GetEmotionData(_arg_1);
            if (((_local_4) && (_local_4.Message)))
            {
                _local_5 = (("*" + _arg_2) + ": ");
                _local_5 = (_local_5 + _local_4.Message);
                this.AddMessage(_local_5);
            };
        }

        public function ClearChat(_arg_1:Event):void
        {
            this._chatArea.Clear();
        }

        public function SetFocus():void
        {
            this._messageField.requestFocus();
            this.ScrollToTheEnd();
        }

        public function RemoveFocus():void
        {
            this._chatArea.requestFocus();
            if (stage)
            {
                stage.focus = stage;
            };
        }

        public function IsFocused():Boolean
        {
            return (this._messageField.isFocusOwner());
        }

        public function SetChatEnabled(_arg_1:Boolean):void
        {
            this._messageField.setEnabled(_arg_1);
        }

        public function UpdateGraphics():void
        {
            pack();
            updateUI();
        }

        public function DisplayHint():void
        {
        }


    }
}//package hbm.Game.GUI.NewChat

