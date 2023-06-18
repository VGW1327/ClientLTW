


//hbm.Game.GUI.Dialogs.PartnerWindow

package hbm.Game.GUI.Dialogs
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import hbm.Application.ClientApplication;
    import org.aswing.AttachIcon;
    import org.aswing.JTextArea;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.JPanel;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.SoftBoxLayout;
    import org.aswing.JLabel;
    import org.aswing.geom.IntDimension;
    import org.aswing.JScrollPane;
    import org.aswing.FlowLayout;
    import hbm.Game.GUI.Tools.CustomButton;
    import flash.events.Event;

    public class PartnerWindow extends CustomWindow 
    {

        private const _width:int = 530;
        private const _height:int = 210;

        public function PartnerWindow()
        {
            super(null, ClientApplication.Localization.PARTNER_WINDOW_TITLE, true, this._width, this._height, true);
            this.InitUI();
            pack();
            setLocationXY(90, 120);
        }

        private function InitUI():void
        {
            var _local_5:String;
            var _local_6:AttachIcon;
            var _local_9:JTextArea;
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            var _local_2:JPanel = new JPanel(new BorderLayout());
            _local_2.setBorder(new EmptyBorder(null, new Insets(6, 6, 4, 4)));
            var _local_3:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4, SoftBoxLayout.TOP));
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4));
            _local_5 = "AdditionalData_Item_PartnerAdvt";
            _local_6 = new AttachIcon(_local_5);
            var _local_7:JLabel = new JLabel("", _local_6);
            _local_7.setBorder(new EmptyBorder(_local_1, new Insets(6, 0, 6, 0)));
            _local_7.setPreferredSize(new IntDimension(83, 83));
            _local_4.append(_local_7);
            var _local_8:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            _local_8.setBorder(null);
            _local_8.setPreferredWidth(383);
            _local_9 = new JTextArea(ClientApplication.Localization.PARTNER_WINDOW_DESCRIPTION);
            _local_9.setEditable(false);
            _local_9.setWordWrap(true);
            _local_9.setBackgroundDecorator(null);
            var _local_10:JScrollPane = new JScrollPane(_local_9);
            _local_10.setPreferredHeight(100);
            _local_8.append(_local_10);
            _local_4.append(_local_8);
            _local_4.setBorder(_local_1);
            var _local_11:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
            var _local_12:CustomButton = new CustomButton(ClientApplication.Localization.BUTTON_CLOSE);
            _local_12.setToolTipText(ClientApplication.Instance.GetPopupText(2));
            _local_12.addActionListener(this.OnClose, 0, true);
            _local_11.append(_local_12);
            setDefaultButton(_local_12);
            _local_3.append(_local_4);
            _local_2.append(_local_3, BorderLayout.CENTER);
            _local_2.append(_local_11, BorderLayout.PAGE_END);
            MainPanel.append(_local_2, BorderLayout.CENTER);
        }

        private function OnClose(_arg_1:Event):void
        {
            dispose();
        }

        private function OnCloseButtonPressed(_arg_1:Event):void
        {
            this.CloseWindow();
        }

        private function OnStart(_arg_1:Event):void
        {
            this.CloseWindow();
            dispose();
        }

        private function CloseWindow():void
        {
        }


    }
}//package hbm.Game.GUI.Dialogs

