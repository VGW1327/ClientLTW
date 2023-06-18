


//hbm.Game.Utility.CharacterMenu

package hbm.Game.Utility
{
    import org.aswing.JPopupMenu;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Application.ClientApplication;
    import flash.events.Event;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import hbm.Game.GUI.NewChat.LeftChatBar;
    import hbm.Engine.Actors.PartyMember;
    import hbm.Engine.Actors.PartyInfo;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Game.Character.Character;
    import flash.desktop.Clipboard;
    import flash.desktop.ClipboardFormats;

    public class CharacterMenu 
    {

        private static var _singletone:Boolean = false;
        private static const _instance:CharacterMenu = new (CharacterMenu)();

        private var _characterId:uint = 0;
        private var _characterName:String = "";
        private var _needInviteToGroup:Boolean = false;
        private var _inviteToGroupId:int = -1;
        private var _menu:JPopupMenu;

        public function CharacterMenu()
        {
            if (_singletone)
            {
                throw ("Can't create class CharacterMenu, this is static class!");
            };
            _singletone = true;
        }

        public static function ShowUserMenu(_arg_1:uint, _arg_2:String=null, _arg_3:Boolean=false, _arg_4:Boolean=false):void
        {
            var _local_5:CharacterInfo;
            var _local_9:CharacterInfo;
            _instance._characterId = _arg_1;
            if (_arg_1 < 1)
            {
                return;
            };
            _local_5 = ClientApplication.Instance.LocalGameClient.ActorList.actors[_arg_1];
            var _local_6:String = ((_local_5) ? _local_5.name : "");
            _instance._characterName = ((_arg_2) || (_local_6));
            if (_instance._menu)
            {
                _instance._menu.dispose();
            };
            _instance._menu = new JPopupMenu();
            var _local_7:JPopupMenu = _instance._menu;
            var _local_8:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            if (_arg_1 == _local_8.characterId)
            {
                if (_local_8.Party == null)
                {
                    _local_7.addMenuItem(ClientApplication.Localization.CHAT_MENU_CREATE_GROUP).addActionListener(_instance.OnGroupCreate, 0, true);
                }
                else
                {
                    _local_7.addMenuItem(ClientApplication.Localization.PARTY_MENU_LEAVE_GROUP).addActionListener(_instance.OnGroupLeave, 0, true);
                };
                _local_7.addMenuItem(ClientApplication.Localization.CHAT_MENU_CREATE_DUEL).addActionListener(_instance.OnDuelCreate, 0, true);
                _local_7.addMenuItem(ClientApplication.Localization.CHAT_MENU_LEAVE_DUEL).addActionListener(_instance.OnDuelLeave, 0, true);
            }
            else
            {
                _local_7.addMenuItem(ClientApplication.Localization.CHAT_MENU_SEND_PRIVATE_MESSAGE).addActionListener(_instance.OnPrivateMessage, 0, true);
                _local_7.addMenuItem(ClientApplication.Localization.CHAT_MENU_SUGGEST_FRIENDSHIP).addActionListener(_instance.OnFriendship, 0, true);
                _local_7.addMenuItem(ClientApplication.Localization.CHAT_MENU_INVITE_TO_PARTY).addActionListener(_instance.OnAddToGroup, 0, true);
                if (_local_8.Guild != null)
                {
                    if (_local_8.Guild.CanInvite)
                    {
                        _local_9 = ClientApplication.Instance.LocalGameClient.ActorList.GetActor(_arg_1);
                        if (_local_9.guildName != null)
                        {
                            if (_local_9.guildName != _local_8.Guild.Name)
                            {
                                _local_7.addMenuItem(ClientApplication.Localization.CHAT_MENU_INVITE_TO_ALLY).addActionListener(_instance.OnAddToAllies, 0, true);
                            };
                        }
                        else
                        {
                            _local_7.addMenuItem(ClientApplication.Localization.CHAT_MENU_INVITE_TO_GUILD).addActionListener(_instance.OnAddToClan, 0, true);
                        };
                    };
                };
                if (((!(_local_5 == null)) && (_instance._characterName == _local_6)))
                {
                    _local_7.addMenuItem(ClientApplication.Localization.CHAT_MENU_SUGGEST_DUEL).addActionListener(_instance.OnDuelInvite, 0, true);
                    _local_7.addMenuItem(ClientApplication.Localization.CHAT_MENU_SUGGEST_TRADE).addActionListener(_instance.OnTradeInvite, 0, true);
                    if (_arg_3)
                    {
                        _local_7.addMenuItem(ClientApplication.Localization.CHAT_MENU_SELECT).addActionListener(_instance.OnSelectUser, 0, true);
                    };
                };
            };
            _local_7.addMenuItem(ClientApplication.Localization.COPY_NAME).addActionListener(_instance.OnCopyUserName, 0, true);
            if (((_arg_4) && (_local_8.Support)))
            {
                _local_7.addMenuItem(ClientApplication.Localization.GM_CMD_MUTE).addActionListener(_instance.OnUserMute, 0, true);
                _local_7.addMenuItem(ClientApplication.Localization.GM_CMD_JAIL).addActionListener(_instance.OnUserJail, 0, true);
                _local_7.addMenuItem(ClientApplication.Localization.GM_CMD_BAN).addActionListener(_instance.OnUserBan, 0, true);
            };
            _local_7.show(null, (ClientApplication.Instance.stage.mouseX + 20), ClientApplication.Instance.mouseY);
        }

        public static function ValidatePartyCreate():void
        {
            if (_instance._needInviteToGroup)
            {
                ClientApplication.Instance.LocalGameClient.SendPartyJoinRequest(_instance._inviteToGroupId);
                _instance._needInviteToGroup = false;
                _instance._inviteToGroupId = -1;
            };
        }


        private function OnGroupCreate(_arg_1:Event):void
        {
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            this.OnGroupEntered(_local_2.name);
        }

        private function OnGroupEntered(_arg_1:String):void
        {
            var _local_2:RegExp;
            ClientApplication.Instance.SetShortcutsEnabled(true);
            if (_arg_1 == null)
            {
                return;
            };
            _local_2 = new RegExp(ClientApplication.Localization.PARTY_NAME_PATTERN);
            var _local_3:Array = _arg_1.match(_local_2);
            if (((!(_local_3 == null)) && (_local_3.length > 0)))
            {
                if (_local_3[0] === _arg_1)
                {
                    ClientApplication.Instance.LocalGameClient.SendPartyOrganize(_arg_1);
                    return;
                };
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_PARTY_NAME_ERROR_TITLE, ClientApplication.Localization.DLG_PARTY_NAME_ERROR_MSG, null, null, true, new AttachIcon("AchtungIcon")));
        }

        private function OnGroupLeave(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendPartyLeave();
        }

        private function OnDuelCreate(_arg_1:Event):void
        {
            ClientApplication.Instance.SetShortcutsEnabled(false);
            ClientApplication.Instance.CreateDuel(24);
        }

        private function OnDuelLeave(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendDuelLeave();
        }

        private function OnPrivateMessage(_arg_1:Event):void
        {
            ClientApplication.Instance.ChatHUD.GetLeftBar.SetFocus(LeftChatBar.PRIVATE_CHANNEL);
            ClientApplication.Instance.ChatHUD.GetLeftBar.PrivateChannel.TypeMessageTemplate(this._characterName);
        }

        private function OnFriendship(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendFriendListAdd(this._characterName);
        }

        private function OnDuelInvite(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendDuelInvite(this._characterName);
        }

        private function OnTradeInvite(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendTradeRequest(this._characterId);
        }

        private function OnAddToGroup(_arg_1:Event):void
        {
            var _local_2:CharacterInfo;
            var _local_5:PartyMember;
            _local_2 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_3:PartyInfo = _local_2.Party;
            var _local_4:Boolean;
            if (_local_3 != null)
            {
                for each (_local_5 in _local_3.PartyMembers)
                {
                    if (_local_5.Leader)
                    {
                        if (_local_5.CharacterId == _local_2.characterId)
                        {
                            _local_4 = true;
                        };
                        break;
                    };
                };
                if (_local_4)
                {
                    ClientApplication.Instance.LocalGameClient.SendPartyJoinRequest(this._characterId);
                }
                else
                {
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.PARTY_RESULT_NOT_LEADER, null, null, true, new AttachIcon("AchtungIcon")));
                };
            }
            else
            {
                this._needInviteToGroup = true;
                this._inviteToGroupId = this._characterId;
                this.OnGroupEntered(_local_2.name);
            };
        }

        private function OnAddToAllies(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendGuildSetAlly(this._characterId);
        }

        private function OnAddToClan(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendGuildJoinRequest(this._characterId);
        }

        private function OnSelectUser(_arg_1:Event):void
        {
            var _local_2:Character = CharacterStorage.Instance.GetCharacterData(this._characterId);
            if (((_local_2) && (_local_2.IsSelecting)))
            {
                CharacterStorage.Instance.SelectCharacter(_local_2);
            };
        }

        private function OnCopyUserName(_arg_1:Event):void
        {
            Clipboard.generalClipboard.clear();
            Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, this._characterName);
        }

        private function OnUserMute(_arg_1:Event):void
        {
            this.GMCommand("@mute", this._characterName);
        }

        private function OnUserJail(_arg_1:Event):void
        {
            this.GMCommand("@jailfor", this._characterName);
        }

        private function OnUserBan(_arg_1:Event):void
        {
            this.GMCommand("@ban", this._characterName);
        }

        private function GMCommand(_arg_1:String, _arg_2:String):void
        {
            if (((null == _arg_1) || (null == _arg_2)))
            {
                return;
            };
            ClientApplication.Instance.ChatHUD.GetLeftBar.SetFocus(LeftChatBar.PUBLIC_CHANNEL);
            ClientApplication.Instance.ChatHUD.GetLeftBar.PublicChannel.MessageTemplate(((_arg_1 + "  ") + _arg_2), (_arg_1.length + 1));
        }


    }
}//package hbm.Game.Utility

