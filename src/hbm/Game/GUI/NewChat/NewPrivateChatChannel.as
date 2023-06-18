


//hbm.Game.GUI.NewChat.NewPrivateChatChannel

package hbm.Game.GUI.NewChat
{
    import hbm.Game.Utility.HtmlText;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.CharacterInfo;
    import flash.events.Event;

    public class NewPrivateChatChannel extends NewChatChannel 
    {

        public function NewPrivateChatChannel(_arg_1:LeftChatBar, _arg_2:int)
        {
            super(_arg_1, _arg_2);
        }

        public function AddMessageFrom(_arg_1:String, _arg_2:String):void
        {
            var _local_3:String;
            var _local_4:InteractiveText;
            if (_arg_1 != null)
            {
                _local_3 = _arg_1.concat();
                _local_4 = new InteractiveText((WIDTH_CHAT - 30));
                if (_arg_1 == ".")
                {
                    AddMessage(_arg_2);
                    return;
                };
                if (_arg_1.indexOf("-") >= 0)
                {
                    _local_3 = HtmlText.update(_arg_1, true, 12, HtmlText.fontName, "#33ff33");
                };
                _local_4.AddLinkText(_local_3, this.TypeMessageTemplate, _local_3);
                UnpackItemLink(_local_4, ("> " + _arg_2));
                AddNotification(_local_4);
                if (CharacterStorage.Instance.IsEnableBlinking)
                {
                    _parent.RequestBlinking(_index);
                    if (ClientApplication.Instance.ChatHUD.IsChatHided)
                    {
                        ClientApplication.Instance.ChatHUD.BlinkerChatButton.Start();
                    };
                };
                ScrollToTheEnd();
            };
        }

        public function TypeMessageTemplate(_arg_1:String):void
        {
            MessageTemplate((_arg_1 + " "));
        }

        override protected function SendMessage(_arg_1:Event):void
        {
            var _local_3:RegExp;
            var _local_4:Array;
            var _local_5:String;
            var _local_6:String;
            var _local_7:String;
            var _local_8:CharacterInfo;
            var _local_9:String;
            var _local_10:InteractiveText;
            var _local_2:String = PackItemLink(_messageField.getText());
            if (_local_2 != "")
            {
                if (((_local_2.indexOf("@") == 0) || (_local_2.indexOf("#") == 0)))
                {
                    ClientApplication.Instance.LocalGameClient.SendGuildChatMessage(_local_2);
                    _messageField.setText("");
                }
                else
                {
                    _local_3 = new RegExp((("(" + ClientApplication.Localization.PLAYER_NAME_PATTERN_FOR_PRIVATE) + ") (.*)"));
                    _local_4 = _local_3.exec(_local_2);
                    _messageField.setText("");
                    if (_local_4 == null)
                    {
                        this.ShowError();
                        return;
                    };
                    if (_local_4.length == 3)
                    {
                        _local_5 = _local_4[1];
                        _local_6 = _local_4[2];
                        if (_local_6 == "")
                        {
                            this.ShowError();
                            return;
                        };
                        _local_8 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                        if (_local_8.Support)
                        {
                            _local_7 = _local_6;
                        }
                        else
                        {
                            _local_7 = _local_6;
                        };
                        ClientApplication.Instance.LocalGameClient.SendPrivateMessage(_local_5, HtmlText.fixTags(_local_7));
                        if (_local_8.Support)
                        {
                            _local_9 = HtmlText.update(_local_8.name, true, 12, HtmlText.fontName, "#33ff33");
                        }
                        else
                        {
                            _local_9 = _local_8.name;
                        };
                        _local_10 = new InteractiveText((WIDTH_CHAT - 30));
                        _local_10.AddText((_local_9 + " :"));
                        _local_10.AddLinkText(_local_5, this.TypeMessageTemplate, _local_5);
                        UnpackItemLink(_local_10, (": " + _local_7.substr(0, 254)));
                        AddNotification(_local_10);
                        ScrollToTheEnd();
                    }
                    else
                    {
                        this.ShowError();
                    };
                };
            };
        }

        private function ShowError():void
        {
            AddMessage(ClientApplication.Localization.CHAT_PRIVATE_COMMAND_ERROR);
            AddMessage(ClientApplication.Localization.CHAT_PRIVATE_HELP);
        }

        override public function DisplayHint():void
        {
            ClearChat(null);
            AddMessage(ClientApplication.Localization.CHAT_PRIVATE_HELP);
        }


    }
}//package hbm.Game.GUI.NewChat

