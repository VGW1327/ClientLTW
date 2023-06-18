


//hbm.Game.GUI.Guild.GuildMembersPanel

package hbm.Game.GUI.Guild
{
    import org.aswing.JPanel;
    import org.aswing.JTable;
    import hbm.Game.GUI.Tools.CustomTableModel;
    import org.aswing.JPopupMenu;
    import org.aswing.table.sorter.TableSorter;
    import hbm.Engine.Actors.GuildInfo;
    import hbm.Engine.Actors.GuildMember;
    import org.aswing.SoftBoxLayout;
    import org.aswing.JScrollPane;
    import org.aswing.table.TableColumn;
    import hbm.Application.ClientApplication;
    import flash.events.MouseEvent;
    import hbm.Engine.Actors.Actors;
    import hbm.Game.Character.CharacterStorage;
    import org.aswing.event.AWEvent;
    import org.aswing.Component;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import org.aswing.JMenuItem;
    import flash.events.Event;
    import org.aswing.table.sorter.SortableTextHeaderCell;

    public class GuildMembersPanel extends JPanel 
    {

        private var _table:JTable;
        private var _tableModel:CustomTableModel;
        private var _menu:JPopupMenu;
        private var _sorter:TableSorter;
        private var _headerArray:Array;
        private var _titleComparator:Function;
        private var _jobComparator:Function;
        private var _statusComparator:Function;
        private var _stringComparator:Function;
        private var _numberComparator:Function;
        private var _clothesColor:int;
        private var _guild:GuildInfo;
        private var _cashDialog:GuildCashDialog;
        private var _selectedMember:GuildMember;

        public function GuildMembersPanel(_arg_1:int)
        {
            super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            this._clothesColor = _arg_1;
            this.InitComparators();
            this.InitUI();
        }

        private function InitUI():void
        {
            var _local_2:*;
            var _local_3:JScrollPane;
            var _local_4:TableColumn;
            this._tableModel = new CustomTableModel();
            this._tableModel.initWithRowcountColumncount(0, 0);
            this._table = new JTable();
            this._sorter = new TableSorter(this._tableModel, this._table.getTableHeader());
            this._table.setModel(this._sorter);
            var _local_1:Array = [{
                "id":0,
                "title":ClientApplication.Localization.GUILD_WINDOW_TABLE_MEMBERS_HEADER[0],
                "resizable":false,
                "editable":false,
                "type":"String",
                "width":100
            }, {
                "id":1,
                "title":ClientApplication.Localization.GUILD_WINDOW_TABLE_MEMBERS_HEADER[1],
                "resizable":true,
                "editable":false,
                "type":"String",
                "width":100
            }, {
                "id":2,
                "title":ClientApplication.Localization.GUILD_WINDOW_TABLE_MEMBERS_HEADER[2],
                "resizable":false,
                "editable":false,
                "type":"Int",
                "width":70
            }, {
                "id":3,
                "title":ClientApplication.Localization.GUILD_WINDOW_TABLE_MEMBERS_HEADER[3],
                "resizable":false,
                "editable":false,
                "type":"String",
                "width":70
            }, {
                "id":4,
                "title":ClientApplication.Localization.GUILD_WINDOW_TABLE_MEMBERS_HEADER[4],
                "resizable":false,
                "editable":false,
                "type":"String",
                "width":110
            }, {
                "id":5,
                "title":ClientApplication.Localization.GUILD_WINDOW_TABLE_MEMBERS_HEADER[5],
                "resizable":true,
                "editable":false,
                "type":"String",
                "width":130
            }];
            for each (_local_2 in _local_1)
            {
                _local_4 = new TableColumn(_local_2.id, _local_2.width);
                _local_4.setHeaderValue(_local_2.title);
                _local_4.setResizable(_local_2.resizable);
                this._table.addColumn(_local_4);
            };
            this._table.getTableHeader().addEventListener(MouseEvent.CLICK, this.OnHeaderClicked, false, 0, true);
            this._guild = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Guild;
            this._table.getCellPane().addEventListener(MouseEvent.CLICK, this.OnUserSelected, false, 0, true);
            _local_3 = new JScrollPane(this._table);
            _local_3.setPreferredHeight(189);
            setPreferredHeight(190);
            append(_local_3);
        }

        public function DefaultSort():void
        {
            var _local_1:int;
            if (this._sorter)
            {
                this._sorter.setColumnComparator(this._sorter.getColumnClass(5), this._statusComparator);
                _local_1 = 0;
                while (_local_1 < 5)
                {
                    this._sorter.setSortingStatus(_local_1, 0);
                    _local_1++;
                };
                this._sorter.setSortingStatus(5, 2);
            };
        }

        public function Revalidate():void
        {
            var _local_1:Actors;
            var _local_4:int;
            var _local_5:GuildMember;
            var _local_6:String;
            var _local_7:String;
            var _local_8:String;
            _local_1 = ClientApplication.Instance.LocalGameClient.ActorList;
            this._guild = _local_1.GetPlayer().Guild;
            var _local_2:int = _local_1.GetPlayerFraction();
            var _local_3:Array = new Array();
            this._tableModel.clearRows();
            _local_4 = 0;
            while (_local_4 < this._guild.members.length)
            {
                _local_3.push(this._guild.GetMember(_local_4));
                _local_4++;
            };
            for each (_local_5 in _local_3)
            {
                _local_6 = ((_local_5.baseExp < 10000) ? _local_5.baseExp.toString() : ((_local_5.baseExp < 1000000) ? (Number((_local_5.baseExp / 1000)).toFixed(1) + "k") : (Number((_local_5.baseExp / 1000000)).toFixed(1) + "m")));
                _local_7 = ClientApplication.Localization.LAST_TIME[15];
                if (((!(_local_5.online == 1)) && (_local_5.lastLogin > 0)))
                {
                    _local_7 = this.GetLastLogin(_local_5.lastLogin);
                };
                _local_8 = ((_local_5.online > 0) ? ((_local_5.online == 1) ? ClientApplication.Localization.LAST_TIME[0] : ClientApplication.Localization.LAST_TIME[1]) : _local_7);
                this._tableModel.addRow(new Array(this._guild.GetTitleByPosition(_local_5.position), _local_5.name, _local_5.lv, _local_6, CharacterStorage.Instance.GetJobName(((_local_2) ? 1 : 0), _local_5.jobId, true), _local_8));
            };
        }

        private function GetLastLogin(_arg_1:int):String
        {
            if (!ClientApplication.Instance.timeOnServerInited)
            {
                return ("-");
            };
            var _local_2:int = (ClientApplication.Instance.timeOnServer - _arg_1);
            if (_local_2 < 300)
            {
                return (ClientApplication.Localization.LAST_TIME[2]);
            };
            if (_local_2 >= 0x24EA00)
            {
                return (ClientApplication.Localization.LAST_TIME[15]);
            };
            if (_local_2 >= 0x127500)
            {
                return (ClientApplication.Localization.LAST_TIME[14]);
            };
            if (_local_2 >= 604800)
            {
                return (ClientApplication.Localization.LAST_TIME[13]);
            };
            if (_local_2 >= 345600)
            {
                return (ClientApplication.Localization.LAST_TIME[12]);
            };
            if (_local_2 >= 259200)
            {
                return (ClientApplication.Localization.LAST_TIME[11]);
            };
            if (_local_2 >= 172800)
            {
                return (ClientApplication.Localization.LAST_TIME[10]);
            };
            if (_local_2 >= 86400)
            {
                return (ClientApplication.Localization.LAST_TIME[9]);
            };
            if (_local_2 >= 36000)
            {
                return (ClientApplication.Localization.LAST_TIME[8]);
            };
            if (_local_2 >= 18000)
            {
                return (ClientApplication.Localization.LAST_TIME[7]);
            };
            if (_local_2 >= 3600)
            {
                return (ClientApplication.Localization.LAST_TIME[6]);
            };
            if (_local_2 >= 1800)
            {
                return (ClientApplication.Localization.LAST_TIME[5]);
            };
            if (_local_2 >= 600)
            {
                return (ClientApplication.Localization.LAST_TIME[4]);
            };
            if (_local_2 >= 300)
            {
                return (ClientApplication.Localization.LAST_TIME[3]);
            };
            return (ClientApplication.Localization.LAST_TIME[15]);
        }

        private function Dumb(_arg_1:AWEvent):void
        {
            ClientApplication.Instance.ThisMethodIsDisabled();
        }

        private function OnUserSelected(_arg_1:MouseEvent):void
        {
            var _local_3:Component;
            var _local_4:CharacterInfo;
            var _local_5:Boolean;
            var _local_2:int = this._table.getSelectedRow();
            if (_local_2 >= 0)
            {
                _local_3 = (_arg_1.target as Component);
                _local_4 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                _local_5 = (_local_4.name == name);
                this._menu = new JPopupMenu();
                this._menu.setInvoker(this._table);
                this._menu.addMenuItem(ClientApplication.Localization.GUILD_WINDOW_MENU_SEND_PRIVATE_MESSAGE).addActionListener(this.OnPrivateMessage, 0, true);
                if (this._guild.IsGuildMaster)
                {
                    this._menu.addMenuItem(ClientApplication.Localization.GUILD_WINDOW_MENU_CHANGE_TITLE).addActionListener(this.OnTitleChange, 0, true);
                    this._menu.addMenuItem(ClientApplication.Localization.GUILD_WINDOW_MENU_GRANT_CASH).addActionListener(this.OnGuildCash, 0, true);
                };
                if (((this._guild.CanKick) && (!(_local_5))))
                {
                    this._menu.addMenuItem(ClientApplication.Localization.GUILD_WINDOW_MENU_KICK_FROM_GUILD).addActionListener(this.OnKickFromGuild, 0, true);
                };
                if (_local_5)
                {
                    this._menu.addMenuItem(ClientApplication.Localization.GUILD_WINDOW_BUTTON_LEAVE).addActionListener(this.OnLeaveFromGuild, 0, true);
                };
                this._menu.show(_local_3, (_local_3.getMousePosition().x + 20), _local_3.getMousePosition().y);
            };
        }

        private function OnKickFromGuild(_arg_1:AWEvent):void
        {
            var _local_2:int;
            var _local_3:String;
            this._guild = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Guild;
            if (this._guild.CanKick)
            {
                _local_2 = this._table.getSelectedRow();
                _local_3 = this._sorter.getValueAt(_local_2, 1);
                ClientApplication.Instance.SetShortcutsEnabled(false);
                new CustomOptionPane(JOptionPane.showInputDialog(ClientApplication.Localization.GUILD_KICK_MEMBER_TITLE1, (((ClientApplication.Localization.GUILD_KICK_MEMBER_MESSAGE1 + " '") + _local_3) + "' ?"), this.OnKickApproved, ClientApplication.Localization.GUILD_KICK_MEMBER_DEFAULT_REASON, null, true, new AttachIcon("AchtungIcon")));
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.GUILD_KICK_MEMBER_TITLE2, ClientApplication.Localization.GUILD_KICK_MEMBER_MESSAGE2, null, null, true, new AttachIcon("StopIcon")));
            };
        }

        private function OnKickApproved(_arg_1:String):void
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:GuildMember;
            ClientApplication.Instance.SetShortcutsEnabled(true);
            if (_arg_1 != null)
            {
                this._guild = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Guild;
                _local_2 = this._table.getSelectedRow();
                _local_3 = this._sorter.getValueAt(_local_2, 1);
                _local_4 = this._guild.FindMemberByName(_local_3);
                ClientApplication.Instance.LocalGameClient.SendGuildMemberKick(this._guild.Id, _local_4.accountId, _local_4.characterId, _arg_1.substr(0, 36));
            };
        }

        private function OnPrivateMessage(_arg_1:AWEvent):void
        {
            var _local_2:int;
            _local_2 = this._table.getSelectedRow();
            var _local_3:String = this._sorter.getValueAt(_local_2, 1);
            ClientApplication.Instance.TypePrivateMessageTemplate(_local_3);
        }

        private function OnTitleChange(_arg_1:AWEvent):void
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:GuildMember;
            var _local_5:JPopupMenu;
            var _local_6:Object;
            var _local_7:JMenuItem;
            if (this._guild.IsGuildMaster)
            {
                _local_2 = this._table.getSelectedRow();
                _local_3 = this._sorter.getValueAt(_local_2, 1);
                _local_4 = this._guild.FindMemberByName(_local_3);
                if (_local_4.position == 0)
                {
                    return;
                };
                _local_5 = new JPopupMenu();
                for each (_local_6 in ClientApplication.Localization.GUILD_POSITIONS)
                {
                    if (!((_local_6.id == 0) || (_local_6.name == "")))
                    {
                        _local_7 = _local_5.addMenuItem(_local_6["name"]);
                        _local_7.putClientProperty("idx", _local_6["id"]);
                        _local_7.putClientProperty("member", _local_4);
                        _local_7.addActionListener(this.OnTitleChanged, 0, true);
                    };
                };
                _local_5.show(null, stage.mouseX, stage.mouseY);
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.GUILD_CHANGE_TITLE_TITLE, (((ClientApplication.Localization.GUILD_CHANGE_TITLE_MESSAGE + " '") + this._guild.MasterName) + "'"), null, null, true, new AttachIcon("StopIcon")));
            };
        }

        private function OnTitleChanged(_arg_1:AWEvent):void
        {
            var _local_2:JMenuItem;
            _local_2 = (_arg_1.target as JMenuItem);
            var _local_3:int = _local_2.getClientProperty("idx");
            var _local_4:GuildMember = _local_2.getClientProperty("member");
            ClientApplication.Instance.LocalGameClient.SendGuildChangeMemberPosition(_local_4.accountId, _local_4.characterId, _local_3);
        }

        private function OnLeaveFromGuild(_arg_1:AWEvent):void
        {
            this._guild = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Guild;
            if (((this._guild.IsGuildMaster) && (this._guild.Members > 1)))
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.ERR_CRITICAL_ERROR_TITLE, ClientApplication.Localization.GUILD_WINDOW_LEAVE_MESSAGE1, null, null, true, new AttachIcon("AchtungIcon")));
            }
            else
            {
                ClientApplication.Instance.SetShortcutsEnabled(false);
                new CustomOptionPane(JOptionPane.showInputDialog(ClientApplication.Localization.GUILD_WINDOW_LEAVE_TITLE2, ClientApplication.Localization.GUILD_WINDOW_LEAVE_MESSAGE2, this.OnLeaveGuildReasonEntered, "", null, true));
            };
        }

        private function OnLeaveGuildReasonEntered(_arg_1:String):void
        {
            ClientApplication.Instance.SetShortcutsEnabled(true);
            if (_arg_1 != null)
            {
                ClientApplication.Instance.LocalGameClient.SendGuildLeave(_arg_1.substr(0, 38));
            };
        }

        private function OnGuildCash(_arg_1:AWEvent):void
        {
            var _local_2:int;
            var _local_3:String;
            if (this._guild.IsGuildMaster)
            {
                _local_2 = this._table.getSelectedRow();
                _local_3 = this._sorter.getValueAt(_local_2, 1);
                this._selectedMember = this._guild.FindMemberByName(_local_3);
                this._cashDialog = new GuildCashDialog(_local_3, this._guild.GuildCash);
                this._cashDialog.addEventListener(GuildCashDialog.ON_INPUT_PRESSED, this.OnInputConfirmed, false, 0, true);
                this._cashDialog.show();
            };
        }

        private function OnInputConfirmed(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendGuildCash(this._guild.Id, this._selectedMember.accountId, this._selectedMember.characterId, this._cashDialog.GetInputNumber());
        }

        private function InitComparators():void
        {
            var titleArray:Array;
            var obj:Object;
            var i:int;
            var str:String;
            var jobArray:Array;
            var job:String;
            var statusArray:Array;
            var status:String;
            titleArray = new Array();
            for each (obj in ClientApplication.Localization.GUILD_POSITIONS)
            {
                if (!((obj.id == 0) || (obj.name == "")))
                {
                    titleArray[obj.name] = obj.id;
                };
            };
            this._headerArray = new Array();
            i = 0;
            for each (str in ClientApplication.Localization.GUILD_WINDOW_TABLE_MEMBERS_HEADER)
            {
                this._headerArray[str] = i++;
            };
            jobArray = new Array();
            i = 0;
            for each (job in ((this._clothesColor) ? ClientApplication.Localization.JOB_NAMES1 : ClientApplication.Localization.JOB_NAMES0))
            {
                if (job != "")
                {
                    jobArray[job] = i++;
                };
            };
            for each (job in ((this._clothesColor) ? ClientApplication.Localization.JOB_NAMES_ADV1 : ClientApplication.Localization.JOB_NAMES_ADV0))
            {
                if (job != "")
                {
                    jobArray[job] = i++;
                };
            };
            for each (job in ((this._clothesColor) ? ClientApplication.Localization.JOB_NAMES_BABY0 : ClientApplication.Localization.JOB_NAMES_BABY1))
            {
                if (job != "")
                {
                    jobArray[job] = i++;
                };
            };
            statusArray = new Array();
            i = 0;
            for each (status in ClientApplication.Localization.LAST_TIME)
            {
                statusArray[status] = i++;
            };
            statusArray["-"] = i;
            this._titleComparator = function (_arg_1:String, _arg_2:String):int
            {
                if ((((_arg_1 == null) && (_arg_2 == null)) || (_arg_1 == _arg_2)))
                {
                    return (0);
                };
                if (_arg_1 == null)
                {
                    return (-1);
                };
                if (_arg_2 == null)
                {
                    return (1);
                };
                var _local_3:int = titleArray[_arg_1];
                var _local_4:int = titleArray[_arg_2];
                if (_local_3 < _local_4)
                {
                    return (-1);
                };
                if (_local_3 > _local_4)
                {
                    return (1);
                };
                return (0);
            };
            this._jobComparator = function (_arg_1:String, _arg_2:String):int
            {
                if ((((_arg_1 == null) && (_arg_2 == null)) || (_arg_1 == _arg_2)))
                {
                    return (0);
                };
                if (_arg_1 == null)
                {
                    return (-1);
                };
                if (_arg_2 == null)
                {
                    return (1);
                };
                var _local_3:int = jobArray[_arg_1];
                var _local_4:int = jobArray[_arg_2];
                if (_local_3 < _local_4)
                {
                    return (-1);
                };
                if (_local_3 > _local_4)
                {
                    return (1);
                };
                return (0);
            };
            this._statusComparator = function (_arg_1:String, _arg_2:String):int
            {
                if ((((_arg_1 == null) && (_arg_2 == null)) || (_arg_1 == _arg_2)))
                {
                    return (0);
                };
                if (_arg_1 == null)
                {
                    return (-1);
                };
                if (_arg_2 == null)
                {
                    return (1);
                };
                var _local_3:int = statusArray[_arg_1];
                var _local_4:int = statusArray[_arg_2];
                if (_local_3 < _local_4)
                {
                    return (-1);
                };
                if (_local_3 > _local_4)
                {
                    return (1);
                };
                return (0);
            };
            this._stringComparator = function (_arg_1:String, _arg_2:String):int
            {
                if ((((_arg_1 == null) && (_arg_2 == null)) || (_arg_1 == _arg_2)))
                {
                    return (0);
                };
                if (((_arg_1 == null) || (_arg_1 < _arg_2)))
                {
                    return (-1);
                };
                if (((_arg_2 == null) || (_arg_1 > _arg_2)))
                {
                    return (1);
                };
                return (0);
            };
            this._numberComparator = function (_arg_1:String, _arg_2:String):int
            {
                if ((((_arg_1 == null) && (_arg_2 == null)) || (_arg_1 == _arg_2)))
                {
                    return (0);
                };
                if (_arg_1 == null)
                {
                    return (-1);
                };
                if (_arg_2 == null)
                {
                    return (1);
                };
                var _local_3:Number = ((_arg_1.indexOf("m") > 0) ? (Number(_arg_1.replace("m", "")) * 1000000) : ((_arg_1.indexOf("k") > 0) ? (Number(_arg_1.replace("k", "")) * 1000) : Number(_arg_1)));
                var _local_4:Number = ((_arg_2.indexOf("m") > 0) ? (Number(_arg_2.replace("m", "")) * 1000000) : ((_arg_2.indexOf("k") > 0) ? (Number(_arg_2.replace("k", "")) * 1000) : Number(_arg_2)));
                if (_local_3 < _local_4)
                {
                    return (-1);
                };
                if (_local_3 > _local_4)
                {
                    return (1);
                };
                return (0);
            };
        }

        private function OnHeaderClicked(_arg_1:MouseEvent):void
        {
            var _local_3:String;
            var _local_4:int;
            var _local_2:SortableTextHeaderCell = (_arg_1.target as SortableTextHeaderCell);
            if (_local_2)
            {
                _local_3 = _local_2.getText();
                _local_4 = this._headerArray[_local_3];
                switch (_local_4)
                {
                    case 0:
                        this._sorter.setColumnComparator(this._sorter.getColumnClass(_local_4), this._titleComparator);
                        break;
                    case 2:
                    case 3:
                        this._sorter.setColumnComparator(this._sorter.getColumnClass(_local_4), this._numberComparator);
                        break;
                    case 4:
                        this._sorter.setColumnComparator(this._sorter.getColumnClass(_local_4), this._jobComparator);
                        break;
                    case 5:
                        this._sorter.setColumnComparator(this._sorter.getColumnClass(_local_4), this._statusComparator);
                        break;
                    case 1:
                    default:
                        this._sorter.setColumnComparator(this._sorter.getColumnClass(_local_4), this._stringComparator);
                };
                this.Revalidate();
            };
        }


    }
}//package hbm.Game.GUI.Guild

