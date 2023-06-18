


//hbm.Game.GUI.Friends.FriendsPanel

package hbm.Game.GUI.Friends
{
    import org.aswing.JPanel;
    import org.aswing.JTable;
    import hbm.Game.GUI.Tools.CustomTableModel;
    import org.aswing.JPopupMenu;
    import org.aswing.table.sorter.TableSorter;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.SoftBoxLayout;
    import org.aswing.JScrollPane;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.table.TableColumn;
    import hbm.Application.ClientApplication;
    import flash.events.MouseEvent;
    import org.aswing.FlowLayout;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.event.AWEvent;
    import hbm.Engine.Actors.FriendMember;
    import hbm.Engine.Actors.FriendInfo;
    import org.aswing.Component;
    import org.aswing.AttachIcon;
    import org.aswing.table.sorter.SortableTextHeaderCell;

    public class FriendsPanel extends JPanel 
    {

        private var _table:JTable;
        private var _tableModel:CustomTableModel;
        private var _menu:JPopupMenu;
        private var _sorter:TableSorter;
        private var _addFriendButton:CustomButton;
        private var _headerArray:Array;
        private var _stringComparator:Function;

        public function FriendsPanel()
        {
            super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            this.InitComparators();
            this.InitUI();
        }

        private function InitUI():void
        {
            var _local_2:*;
            var _local_3:JScrollPane;
            var _local_4:CustomToolTip;
            var _local_5:JPanel;
            var _local_6:JPanel;
            var _local_7:JPanel;
            var _local_8:TableColumn;
            this._tableModel = new CustomTableModel();
            this._tableModel.initWithRowcountColumncount(0, 0);
            this._table = new JTable(this._tableModel);
            this._sorter = new TableSorter(this._tableModel, this._table.getTableHeader());
            this._table.setModel(this._sorter);
            var _local_1:Array = [{
                "id":0,
                "title":ClientApplication.Localization.FRIEND_MEMBERS_HEADER[0],
                "resizable":true,
                "editable":false,
                "type":"String",
                "width":220
            }, {
                "id":1,
                "title":ClientApplication.Localization.FRIEND_MEMBERS_HEADER[1],
                "resizable":false,
                "editable":false,
                "type":"String",
                "width":20
            }];
            for each (_local_2 in _local_1)
            {
                _local_8 = new TableColumn(_local_2.id, _local_2.width);
                _local_8.setHeaderValue(_local_2.title);
                _local_8.setResizable(_local_2.resizable);
                this._table.addColumn(_local_8);
            };
            this._table.getTableHeader().addEventListener(MouseEvent.CLICK, this.OnHeaderClicked, false, 0, true);
            this._menu = new JPopupMenu();
            this._menu.setInvoker(this._table);
            this._menu.addMenuItem(ClientApplication.Localization.FRIEND_MENU_SEND_PRIVATE_MESSAGE).addActionListener(this.OnPrivateMessage, 0, true);
            this._menu.addMenuItem(ClientApplication.Localization.FRIEND_MENU_REMOVE_FRIENDSHIP).addActionListener(this.OnRemoveFriend, 0, true);
            this._table.addEventListener(MouseEvent.CLICK, this.OnUserSelected, false, 0, true);
            _local_3 = new JScrollPane(this._table);
            _local_3.setPreferredHeight(189);
            this._addFriendButton = new CustomButton(ClientApplication.Localization.FRIEND_ADD_FRIEND_BUTTON);
            _local_4 = new CustomToolTip(this._addFriendButton, ClientApplication.Instance.GetPopupText(184), 195, 30);
            this._addFriendButton.addActionListener(this.OnAddFriend, 0, true);
            _local_5 = new JPanel(new FlowLayout(FlowLayout.LEFT, 4));
            _local_5.append(this._addFriendButton);
            _local_6 = new JPanel(new BorderLayout());
            _local_6.append(_local_5, BorderLayout.WEST);
            _local_7 = new JPanel(new BorderLayout());
            _local_7.setBorder(new EmptyBorder(null, new Insets(6, 4, 0, 4)));
            _local_7.append(_local_3, BorderLayout.CENTER);
            _local_7.append(_local_6, BorderLayout.PAGE_END);
            setPreferredHeight(225);
            append(_local_7);
        }

        private function OnAddFriend(_arg_1:AWEvent):void
        {
            ClientApplication.Instance.SetShortcutsEnabled(false);
            new CustomOptionPane(JOptionPane.showInputDialog(ClientApplication.Localization.FRIEND_ADD_FRIEND_TITLE, ClientApplication.Localization.FRIEND_ADD_FRIEND_MESSAGE, this.OnFriendNameEntered, "", null, true));
        }

        private function OnFriendNameEntered(_arg_1:String):void
        {
            ClientApplication.Instance.SetShortcutsEnabled(true);
            if (_arg_1 != null)
            {
                ClientApplication.Instance.LocalGameClient.SendFriendListAdd(_arg_1.substr(0, 24));
            };
        }

        public function Revalidate():void
        {
            var friend:FriendMember;
            var friends:FriendInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Friends;
            if (friends == null)
            {
                return;
            };
            var members:Array = new Array();
            this._tableModel.clearRows();
            for each (friend in friends.friends)
            {
                members.push(friend);
            };
            members.sort(function (_arg_1:FriendMember, _arg_2:FriendMember):int
            {
                if (_arg_1.Online > _arg_2.Online)
                {
                    return (-1);
                };
                if (_arg_1.Online < _arg_2.Online)
                {
                    return (0);
                };
                return (1);
            });
            for each (friend in members)
            {
                this._tableModel.addRow(new Array(friend.Name, ((friend.Online) ? ClientApplication.Localization.YES : ClientApplication.Localization.NO)));
            };
        }

        private function Dumb(_arg_1:AWEvent):void
        {
            ClientApplication.Instance.ThisMethodIsDisabled();
        }

        private function OnUserSelected(_arg_1:MouseEvent):void
        {
            var _local_3:Component;
            var _local_2:int = this._table.getSelectedRow();
            if (_local_2 >= 0)
            {
                _local_3 = (_arg_1.target as Component);
                this._menu.show(_local_3, (_local_3.getMousePosition().x + 20), _local_3.getMousePosition().y);
            };
        }

        private function OnRemoveFriend(_arg_1:AWEvent):void
        {
            var _local_2:int;
            _local_2 = this._table.getSelectedRow();
            var _local_3:String = this._sorter.getValueAt(_local_2, 0);
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, (((ClientApplication.Localization.FRIEND_REMOVE_FRIEND_MESSAGE + " '") + _local_3) + "' ?"), this.OnRemoveFriendApproved, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
        }

        private function OnRemoveFriendApproved(_arg_1:int):void
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:FriendInfo;
            var _local_5:FriendMember;
            if (_arg_1 == JOptionPane.YES)
            {
                _local_2 = this._table.getSelectedRow();
                _local_3 = this._sorter.getValueAt(_local_2, 0);
                _local_4 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Friends;
                _local_5 = _local_4.FindMemberByName(_local_3);
                if (_local_5)
                {
                    ClientApplication.Instance.LocalGameClient.SendFriendRemove(_local_5.AccountId, _local_5.CharacterId);
                };
            };
        }

        private function OnPrivateMessage(_arg_1:AWEvent):void
        {
            var _local_2:int;
            _local_2 = this._table.getSelectedRow();
            var _local_3:String = this._sorter.getValueAt(_local_2, 0);
            ClientApplication.Instance.TypePrivateMessageTemplate(_local_3);
        }

        private function InitComparators():void
        {
            var str:String;
            this._headerArray = new Array();
            var i:int;
            for each (str in ClientApplication.Localization.FRIEND_MEMBERS_HEADER)
            {
                this._headerArray[str] = i++;
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
                    case 1:
                    default:
                        this._sorter.setColumnComparator(this._sorter.getColumnClass(_local_4), this._stringComparator);
                };
                this.Revalidate();
            };
        }


    }
}//package hbm.Game.GUI.Friends

