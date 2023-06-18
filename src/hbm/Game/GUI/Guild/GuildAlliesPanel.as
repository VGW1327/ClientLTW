


//hbm.Game.GUI.Guild.GuildAlliesPanel

package hbm.Game.GUI.Guild
{
    import org.aswing.JPanel;
    import org.aswing.JTable;
    import hbm.Game.GUI.Tools.CustomTableModel;
    import org.aswing.JPopupMenu;
    import org.aswing.SoftBoxLayout;
    import org.aswing.JScrollPane;
    import org.aswing.table.TableColumn;
    import hbm.Application.ClientApplication;
    import flash.events.MouseEvent;
    import hbm.Engine.Actors.GuildAllies;
    import hbm.Engine.Actors.GuildInfo;
    import org.aswing.event.AWEvent;
    import org.aswing.Component;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import hbm.Game.GUI.*;

    public class GuildAlliesPanel extends JPanel 
    {

        private var _table:JTable;
        private var _tableModel:CustomTableModel;
        private var _menu:JPopupMenu;

        public function GuildAlliesPanel()
        {
            super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            this.InitUI();
        }

        private function InitUI():void
        {
            var _local_2:*;
            var _local_3:JScrollPane;
            var _local_4:TableColumn;
            this._tableModel = new CustomTableModel();
            this._tableModel.initWithRowcountColumncount(0, 0);
            this._table = new JTable(this._tableModel);
            var _local_1:Array = [{
                "id":0,
                "title":ClientApplication.Localization.GUILD_WINDOW_TABLE_ALLY_HEADER[0],
                "resizable":true,
                "editable":false,
                "type":"String",
                "width":200
            }, {
                "id":1,
                "title":ClientApplication.Localization.GUILD_WINDOW_TABLE_ALLY_HEADER[1],
                "resizable":false,
                "editable":false,
                "type":"String",
                "width":50
            }];
            for each (_local_2 in _local_1)
            {
                _local_4 = new TableColumn(_local_2.id, _local_2.width);
                _local_4.setHeaderValue(_local_2.title);
                _local_4.setResizable(_local_2.resizable);
                this._table.addColumn(_local_4);
            };
            this._menu = new JPopupMenu();
            this._menu.setInvoker(this._table);
            this._menu.addMenuItem(ClientApplication.Localization.GUILD_WINDOW_MENU_KICK_FROM_ALLY).addActionListener(this.OnKickFromAlly, 0, true);
            this._table.addEventListener(MouseEvent.CLICK, this.OnUserSelected, false, 0, true);
            _local_3 = new JScrollPane(this._table);
            _local_3.setPreferredHeight(189);
            setPreferredHeight(190);
            append(_local_3);
        }

        public function Revalidate():void
        {
            var _local_2:GuildAllies;
            this._tableModel.clearRows();
            var _local_1:GuildInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Guild;
            for each (_local_2 in _local_1.Allies)
            {
                this._tableModel.addRow(new Array(_local_2.Name, ((_local_2.Opposition == 0) ? ClientApplication.Localization.GUILD_WINDOW_ALLY_STATUS[0] : ClientApplication.Localization.GUILD_WINDOW_ALLY_STATUS[1])));
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

        private function OnKickFromAlly(_arg_1:AWEvent):void
        {
            var _local_3:int;
            var _local_4:String;
            var _local_5:GuildAllies;
            var _local_2:GuildInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Guild;
            if (_local_2.IsGuildMaster)
            {
                _local_3 = this._table.getSelectedRow();
                if (_local_3 != -1)
                {
                    _local_4 = this._tableModel.getValueAt(_local_3, 0);
                    for each (_local_5 in _local_2.Allies)
                    {
                        if (_local_5.Name == _local_4)
                        {
                            ClientApplication.Instance.LocalGameClient.SendGuildBreakAlly(_local_5.GuildId, 0);
                            break;
                        };
                    };
                };
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.GUILD_KICK_FROM_ALLY_TITLE, (((ClientApplication.Localization.GUILD_KICK_FROM_ALLY_MESSAGE + " '") + _local_2.MasterName) + "'"), null, null, true, new AttachIcon("StopIcon")));
            };
        }


    }
}//package hbm.Game.GUI.Guild

