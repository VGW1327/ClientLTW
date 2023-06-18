


//hbm.Game.GUI.Craft.ArrowsListDialog

package hbm.Game.GUI.Craft
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JPanel;
    import hbm.Application.ClientApplication;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.FlowLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.BorderLayout;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.GridLayout;
    import org.aswing.JScrollPane;
    import org.aswing.Container;
    import org.aswing.event.AWEvent;
    import flash.events.Event;
    import hbm.Engine.Actors.ItemData;

    public class ArrowsListDialog extends CustomWindow 
    {

        private const _width:int = 465;
        private const _height:int = 185;

        private var _itemsPanel:JPanel;

        public function ArrowsListDialog(_arg_1:Array=null)
        {
            super(null, ClientApplication.Localization.CRAFT_LIST_TITLE, true, this._width, this._height, true);
            var _local_2:CustomButton = new CustomButton(ClientApplication.Localization.BUTTON_CLOSE);
            _local_2.setToolTipText(ClientApplication.Instance.GetPopupText(2));
            _local_2.addActionListener(this.OnCloseButtonPressed, 0, true);
            var _local_3:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 6, 0, false));
            _local_3.setBorder(new EmptyBorder(null, new Insets(6, 0, 0, 0)));
            _local_3.append(_local_2);
            var _local_4:JPanel = new JPanel(new BorderLayout());
            _local_4.setBorder(new EmptyBorder(null, new Insets(6, 4, 4, 4)));
            _local_4.append(this.CreateArrowsListPanel(), BorderLayout.CENTER);
            _local_4.append(_local_3, BorderLayout.PAGE_END);
            MainPanel.append(_local_4, BorderLayout.CENTER);
            addEventListener(CustomWindow.CUSTOM_WINDOW_CLOSED, this.OnClose, false, 0, true);
            pack();
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
            if (_arg_1 != null)
            {
                this.Revalidate(_arg_1);
            };
        }

        private function CreateArrowsListPanel():Container
        {
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            this._itemsPanel = new JPanel(new GridLayout(0, 1, 4, 4));
            var _local_2:JScrollPane = new JScrollPane(this._itemsPanel, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_NEVER);
            _local_2.setPreferredHeight(180);
            _local_2.setPreferredWidth(460);
            _local_2.setBorder(_local_1);
            return (_local_2);
        }

        private function OnCloseButtonPressed(_arg_1:AWEvent):void
        {
            dispose();
            ClientApplication.Instance.LocalGameClient.SendArrowSelect();
        }

        private function OnClose(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendArrowSelect();
        }

        public function Revalidate(_arg_1:Array):void
        {
            var _local_2:ItemData;
            this._itemsPanel.removeAll();
            for each (_local_2 in _arg_1)
            {
                this._itemsPanel.append(new ArrowItemPanel(_local_2, this));
            };
        }


    }
}//package hbm.Game.GUI.Craft

