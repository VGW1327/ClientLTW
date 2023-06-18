


//hbm.Game.GUI.ChangelogWindow

package hbm.Game.GUI
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import hbm.Application.ClientApplication;
    import org.aswing.JTextArea;
    import org.aswing.JScrollPane;
    import org.aswing.JPanel;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.FlowLayout;
    import hbm.Game.GUI.Tools.CustomButton;
    import flash.events.Event;

    public class ChangelogWindow extends CustomWindow 
    {

        private const _width:int = 650;
        private const _height:int = 400;

        private var _changelog:Object;

        public function ChangelogWindow(_arg_1:Object)
        {
            super(null, ClientApplication.Localization.CHANGELOG_WINDOW_TITLE, false, this._width, this._height, true);
            this._changelog = _arg_1;
            this.InitUI();
            pack();
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), (((0x0300 - this._height) / 2) - 50));
        }

        private function InitUI():void
        {
            var _local_6:JTextArea;
            var _local_7:String;
            var _local_8:JScrollPane;
            var _local_9:String;
            var _local_10:String;
            var _local_11:Array;
            var _local_12:String;
            var _local_1:JPanel = new JPanel(new BorderLayout());
            _local_1.setBorder(new EmptyBorder(null, new Insets(6, 6, 4, 4)));
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4, SoftBoxLayout.TOP));
            var _local_3:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            _local_2.setBorder(_local_3);
            _local_2.setPreferredWidth(this._width);
            if (this._changelog != null)
            {
                _local_6 = new JTextArea();
                _local_6.setEditable(false);
                _local_6.setWordWrap(true);
                _local_6.setBackgroundDecorator(null);
                _local_6.getTextField().selectable = false;
                for (_local_7 in this._changelog)
                {
                    _local_9 = this._changelog[_local_7]["version"];
                    _local_10 = this._changelog[_local_7]["date"];
                    _local_11 = this._changelog[_local_7]["changes"];
                    _local_6.appendText((_local_10 + ":\n"));
                    for each (_local_12 in _local_11)
                    {
                        _local_6.appendText((_local_12 + "\n"));
                    };
                    _local_6.appendText("\n");
                };
                _local_6.setHtmlText(_local_6.getText());
                _local_8 = new JScrollPane(_local_6);
                _local_8.setPreferredHeight((this._height - 30));
                _local_2.append(_local_8);
            };
            var _local_4:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
            var _local_5:CustomButton = new CustomButton(ClientApplication.Localization.BUTTON_CLOSE);
            _local_5.setToolTipText(ClientApplication.Instance.GetPopupText(2));
            _local_5.addActionListener(this.OnClose, 0, true);
            _local_4.append(_local_5);
            setDefaultButton(_local_5);
            _local_1.append(_local_2, BorderLayout.CENTER);
            _local_1.append(_local_4, BorderLayout.PAGE_END);
            MainPanel.append(_local_1, BorderLayout.CENTER);
        }

        private function OnClose(_arg_1:Event):void
        {
            dispose();
        }


    }
}//package hbm.Game.GUI

