


//hbm.Game.GUI.Friends.IgnoreListPanel

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
    import hbm.Engine.Actors.IgnoreInfo;
    import org.aswing.Component;
    import org.aswing.AttachIcon;
    import org.aswing.table.sorter.SortableTextHeaderCell;

    public class IgnoreListPanel extends JPanel 
    {

        private var _table:JTable;
        private var _tableModel:CustomTableModel;
        private var _menu:JPopupMenu;
        private var _sorter:TableSorter;
        private var _addIgnoreButton:CustomButton;
        private var _headerArray:Array;
        private var _stringComparator:Function;

        public function IgnoreListPanel()
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
            this._menu.addMenuItem(ClientApplication.Localization.IGNORE_MENU_REMOVE_IGNORE).addActionListener(this.OnRemoveIgnore, 0, true);
            this._table.addEventListener(MouseEvent.CLICK, this.OnUserSelected, false, 0, true);
            _local_3 = new JScrollPane(this._table);
            _local_3.setPreferredHeight(189);
            this._addIgnoreButton = new CustomButton(ClientApplication.Localization.IGNORE_ADD_IGNORE_BUTTON);
            _local_4 = new CustomToolTip(this._addIgnoreButton, ClientApplication.Instance.GetPopupText(186), 250, 40);
            this._addIgnoreButton.addActionListener(this.OnAddIgnore, 0, true);
            _local_5 = new JPanel(new FlowLayout(FlowLayout.LEFT, 4));
            _local_5.append(this._addIgnoreButton);
            _local_6 = new JPanel(new BorderLayout());
            _local_6.append(_local_5, BorderLayout.WEST);
            _local_7 = new JPanel(new BorderLayout());
            _local_7.setBorder(new EmptyBorder(null, new Insets(6, 4, 0, 4)));
            _local_7.append(_local_3, BorderLayout.CENTER);
            _local_7.append(_local_6, BorderLayout.PAGE_END);
            setPreferredHeight(225);
            append(_local_7);
        }

        private function OnAddIgnore(_arg_1:AWEvent):void
        {
            ClientApplication.Instance.SetShortcutsEnabled(false);
            new CustomOptionPane(JOptionPane.showInputDialog(ClientApplication.Localization.IGNORE_ADD_IGNORE_TITLE, ClientApplication.Localization.IGNORE_ADD_IGNORE_MESSAGE, this.OnIgnoreNameEntered, "", null, true));
        }

        private function OnIgnoreNameEntered(_arg_1:String):void
        {
            ClientApplication.Instance.SetShortcutsEnabled(true);
            if (_arg_1 != null)
            {
                ClientApplication.Instance.LocalGameClient.SendPMIgnore(_arg_1, 0);
            };
        }

        public function Revalidate():void
        {
            var _local_2:String;
            var _local_1:IgnoreInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().IgnoreList;
            if (_local_1 == null)
            {
                return;
            };
            _local_1.ignore.sort();
            this._tableModel.clearRows();
            for each (_local_2 in _local_1.ignore)
            {
                this._tableModel.addRow(new Array(_local_2));
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

        private function OnRemoveIgnore(_arg_1:AWEvent):void
        {
            var _local_2:int;
            _local_2 = this._table.getSelectedRow();
            var _local_3:String = this._sorter.getValueAt(_local_2, 0);
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, (((ClientApplication.Localization.IGNORE_REMOVE_IGNORE_MESSAGE + " '") + _local_3) + "' ?"), this.OnRemoveIgnoreApproved, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
        }

        private function OnRemoveIgnoreApproved(_arg_1:int):void
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:IgnoreInfo;
            var _local_5:String;
            if (_arg_1 == JOptionPane.YES)
            {
                _local_2 = this._table.getSelectedRow();
                _local_3 = this._sorter.getValueAt(_local_2, 0);
                _local_4 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().IgnoreList;
                _local_5 = _local_4.FindIgnoreByName(_local_3);
                if (_local_5)
                {
                    ClientApplication.Instance.LocalGameClient.SendPMIgnore(_local_5, 1);
                };
            };
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
                    default:
                        this._sorter.setColumnComparator(this._sorter.getColumnClass(_local_4), this._stringComparator);
                };
                this.Revalidate();
            };
        }


    }
}//package hbm.Game.GUI.Friends

