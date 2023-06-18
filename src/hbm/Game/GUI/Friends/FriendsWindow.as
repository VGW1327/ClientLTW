


//hbm.Game.GUI.Friends.FriendsWindow

package hbm.Game.GUI.Friends
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import hbm.Application.ClientApplication;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.JPanel;
    import org.aswing.FlowLayout;
    import org.aswing.BorderLayout;
    import org.aswing.SoftBoxLayout;
    import org.aswing.JTabbedPane;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.event.AWEvent;

    public class FriendsWindow extends CustomWindow 
    {

        private const _width:int = 525;
        private const _height:int = 290;

        private var _friendsPanel:FriendsPanel;
        private var _ignorePanel:IgnoreListPanel;

        public function FriendsWindow(_arg_1:*=null)
        {
            super(_arg_1, ClientApplication.Localization.SOCIAL_WINDOW_TITLE, false, this._width, this._height, true);
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
            this.InitUI();
        }

        private function InitUI():void
        {
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            this._friendsPanel = new FriendsPanel();
            this._ignorePanel = new IgnoreListPanel();
            var _local_2:CustomButton = new CustomButton(ClientApplication.Localization.BUTTON_CLOSE);
            _local_2.setToolTipText(ClientApplication.Instance.GetPopupText(2));
            _local_2.addActionListener(this.OnCloseButtonPressed, 0, true);
            var _local_3:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
            _local_3.append(_local_2);
            var _local_4:JPanel = new JPanel(new BorderLayout());
            _local_4.append(_local_3, BorderLayout.EAST);
            var _local_5:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            var _local_6:JTabbedPane = new JTabbedPane();
            _local_6.setBorder(_local_1);
            _local_6.appendTab(this._friendsPanel, ClientApplication.Localization.SOCIAL_WINDOW_FRIENDS_TAB, null, null);
            _local_5.append(_local_6);
            var _local_7:JPanel = new JPanel(new BorderLayout());
            _local_7.setBorder(new EmptyBorder(null, new Insets(6, 4, 0, 4)));
            _local_7.append(_local_5, BorderLayout.CENTER);
            _local_7.append(_local_4, BorderLayout.PAGE_END);
            MainPanel.append(_local_7, BorderLayout.CENTER);
            pack();
        }

        private function OnCloseButtonPressed(_arg_1:AWEvent):void
        {
            dispose();
        }

        public function Revalidate():void
        {
            this._friendsPanel.Revalidate();
        }

        public function RevalidateIgnoreList():void
        {
            this._ignorePanel.Revalidate();
        }


    }
}//package hbm.Game.GUI.Friends

