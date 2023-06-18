


//hbm.Game.GUI.NewChat.RightChatBar

package hbm.Game.GUI.NewChat
{
    import flash.display.Sprite;
    import org.aswing.JPanel;
    import org.aswing.JList;
    import org.aswing.VectorListModel;
    import org.aswing.JWindow;
    import org.aswing.geom.IntDimension;
    import org.aswing.BorderLayout;
    import org.aswing.FlowLayout;
    import org.aswing.event.ListItemEvent;
    import org.aswing.JScrollPane;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.GUI.PlayersListItem;
    import flash.utils.Dictionary;
    import hbm.Engine.Actors.Actors;
    import hbm.Game.Utility.CharacterMenu;

    public class RightChatBar extends Sprite 
    {

        private var _width:int;
        private var _height:int;
        private var _basePanel:JPanel;
        private var _namesList:JList;
        private var _usersList:VectorListModel;
        private var _lastCharacterId:int = -1;

        public function RightChatBar(_arg_1:int, _arg_2:int)
        {
            x = 0;
            y = 0;
            this._width = _arg_1;
            this._height = _arg_2;
            this._usersList = new VectorListModel();
            var _local_3:JWindow = new JWindow(this);
            _local_3.getContentPane().append(this.InitUI());
            _local_3.getContentPane().setFocusable(false);
            _local_3.setSize(new IntDimension(_arg_1, _arg_2));
            _local_3.setMaximumSize(new IntDimension(_arg_1, _arg_2));
            _local_3.setFocusable(false);
            _local_3.show();
        }

        public function InitUI():JPanel
        {
            this._basePanel = new JPanel(new BorderLayout());
            var _local_1:IntDimension = new IntDimension(this._width, this._height);
            this._basePanel.setSize(_local_1);
            this._basePanel.setPreferredSize(_local_1);
            this._basePanel.setMaximumSize(_local_1);
            var _local_2:FlowLayout = new FlowLayout();
            _local_2.setMargin(false);
            this._namesList = new JList(this._usersList);
            this._namesList.addEventListener(ListItemEvent.ITEM_CLICK, this.OnUserSelected, false, 0, true);
            this._namesList.setFocusable(false);
            var _local_3:JScrollPane = new JScrollPane(this._namesList);
            _local_3.setBorder(new EmptyBorder(null, new Insets(4, 4, 4, 4)));
            this._basePanel.append(_local_3, BorderLayout.CENTER);
            return (this._basePanel);
        }

        public function get GetChatListPanel():JPanel
        {
            return (this._basePanel);
        }

        public function RevalidateUsers(actors:Actors):void
        {
            var actor:CharacterInfo;
            var player:PlayersListItem;
            var actorsList:Dictionary = actors.actors;
            var players:Array = new Array();
            this._usersList.clear();
            for each (actor in actorsList)
            {
                if (actor != null)
                {
                    if (actor.characterId < 100000000)
                    {
                        if (actor.isNameLoaded)
                        {
                            if (actor.baseLevel >= 1)
                            {
                                players.push(new PlayersListItem(actor.name, actor.baseLevel, actor.characterId));
                            };
                        };
                    };
                };
            };
            players.sort(function (_arg_1:PlayersListItem, _arg_2:PlayersListItem):int
            {
                if (_arg_1.BaseLevel < _arg_2.BaseLevel)
                {
                    return (1);
                };
                if (_arg_1.BaseLevel > _arg_2.BaseLevel)
                {
                    return (-1);
                };
                if (_arg_1.Name < _arg_2.Name)
                {
                    return (-1);
                };
                if (_arg_1.Name > _arg_2.Name)
                {
                    return (1);
                };
                return (0);
            });
            for each (player in players)
            {
                this._usersList.append(player);
            };
        }

        private function OnUserSelected(_arg_1:ListItemEvent):void
        {
            var _local_2:PlayersListItem = this._usersList.get(this._namesList.getSelectedIndex());
            if (_local_2 == null)
            {
                return;
            };
            this._lastCharacterId = _local_2.CharacterId;
            CharacterMenu.ShowUserMenu(this._lastCharacterId, null, true);
        }


    }
}//package hbm.Game.GUI.NewChat

