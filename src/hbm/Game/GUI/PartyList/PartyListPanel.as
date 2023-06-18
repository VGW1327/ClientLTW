


//hbm.Game.GUI.PartyList.PartyListPanel

package hbm.Game.GUI.PartyList
{
    import org.aswing.JPanel;
    import org.aswing.JPopupMenu;
    import org.aswing.JList;
    import org.aswing.SoftBoxLayout;
    import flash.events.MouseEvent;
    import hbm.Engine.Actors.PartyMember;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Actors.PartyInfo;
    import flash.events.Event;
    import hbm.Game.GUI.NewChat.LeftChatBar;
    import hbm.Game.Character.Character;
    import hbm.Game.Character.CharacterStorage;

    public class PartyListPanel extends JPanel 
    {

        private var _contextMenu:JPopupMenu;
        private var _playerList:JList;
        private var _memberCount:int = 0;

        public function PartyListPanel()
        {
            super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            setSizeWH(153, 1);
            this.InitUI();
        }

        private function InitUI():void
        {
            this._playerList = new JList();
            this._playerList.setCellFactory(new PartyListCellFactory());
            this._playerList.addEventListener(MouseEvent.CLICK, this.OnListClick);
            append(this._playerList);
        }

        private function OnListClick(_arg_1:Event):void
        {
            var _local_4:PartyMember;
            var _local_5:PartyMember;
            var _local_6:Boolean;
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_3:PartyInfo = _local_2.Party;
            if (_local_3)
            {
                this._contextMenu = new JPopupMenu();
                _local_4 = _local_3.PartyMembers[_local_2.characterId];
                _local_5 = this.SelectedMember;
                _local_6 = false;
                if ((((_local_5) && (_local_4)) && (_local_5.CharacterId == _local_4.CharacterId)))
                {
                    this._contextMenu.addMenuItem(ClientApplication.Localization.PARTY_MENU_LEAVE_GROUP).addActionListener(this.OnGroupLeave, 0, true);
                    _local_6 = true;
                }
                else
                {
                    if (((_local_5) && (_local_5.Online)))
                    {
                        this._contextMenu.addMenuItem(ClientApplication.Localization.PARTY_MENU_SEND_PRIVATE_MESSAGE).addActionListener(this.OnPrivateMessage, 0, true);
                        _local_6 = true;
                    };
                    if (((_local_4) && (_local_4.Leader)))
                    {
                        this._contextMenu.addMenuItem(ClientApplication.Localization.PARTY_MENU_KICK_FROM_GROUP).addActionListener(this.OnKickFromGroup, 0, true);
                        _local_6 = true;
                    };
                    if (_local_5.Online)
                    {
                        this._contextMenu.addMenuItem(ClientApplication.Localization.CHAT_MENU_SELECT).addActionListener(this.OnSelectUser, 0, true);
                        _local_6 = true;
                    };
                };
            }
            else
            {
                this._contextMenu = null;
            };
            if (((this._contextMenu) && (_local_6)))
            {
                this._contextMenu.show(null, stage.mouseX, stage.mouseY);
            };
        }

        public function SetData(_arg_1:Array):void
        {
            this._memberCount = _arg_1.length;
            setHeight((this._memberCount * PartyMemberPanel.ELEMENT_HEIGHT));
            this._playerList.setListData(_arg_1);
        }

        public function UpdateHpForCharacter(_arg_1:int):void
        {
            var _local_2:PartyListCell = this.GetCellByCharacter(_arg_1);
            if (_local_2)
            {
                _local_2.UpdateHP();
            };
        }

        private function GetCellByCharacter(_arg_1:int):PartyListCell
        {
            var _local_3:PartyListCell;
            var _local_4:PartyMember;
            var _local_2:int;
            while (_local_2 < this._memberCount)
            {
                _local_3 = PartyListCell(this._playerList.getCellByIndex(_local_2));
                _local_4 = PartyMember(_local_3.getCellValue());
                if (_local_4.CharacterId == _arg_1)
                {
                    return (_local_3);
                };
                _local_2++;
            };
            return (null);
        }

        public function get SelectedMember():PartyMember
        {
            return (PartyMember(this._playerList.getSelectedValue()));
        }

        public function UpdateLevelFor(_arg_1:int):void
        {
            var _local_2:PartyListCell = this.GetCellByCharacter(_arg_1);
            if (_local_2)
            {
                _local_2.UpdateTextFields();
            };
        }

        public function SetContextMenu(_arg_1:JPopupMenu):void
        {
            this._contextMenu = _arg_1;
        }

        private function OnPrivateMessage(_arg_1:Event):void
        {
            var _local_2:PartyMember = this.SelectedMember;
            if (_local_2)
            {
                ClientApplication.Instance.ChatHUD.GetLeftBar.SetFocus(LeftChatBar.PRIVATE_CHANNEL);
                ClientApplication.Instance.ChatHUD.GetLeftBar.PrivateChannel.TypeMessageTemplate(_local_2.Name);
            };
        }

        private function OnGroupLeave(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendPartyLeave();
        }

        private function OnKickFromGroup(_arg_1:Event):void
        {
            var _local_2:PartyMember = this.SelectedMember;
            if (_local_2)
            {
                ClientApplication.Instance.LocalGameClient.SendPartyKick(_local_2.CharacterId, _local_2.Name);
            };
        }

        private function OnSelectUser(_arg_1:Event):void
        {
            var _local_3:Character;
            var _local_2:PartyMember = this.SelectedMember;
            if (_local_2)
            {
                _local_3 = CharacterStorage.Instance.GetCharacterData(_local_2.CharacterId);
                if (((_local_3) && (_local_3.IsSelecting)))
                {
                    CharacterStorage.Instance.SelectCharacter(_local_3);
                };
            };
        }


    }
}//package hbm.Game.GUI.PartyList

