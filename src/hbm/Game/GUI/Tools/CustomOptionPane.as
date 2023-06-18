


//hbm.Game.GUI.Tools.CustomOptionPane

package hbm.Game.GUI.Tools
{
    import org.aswing.JFrame;
    import hbm.Application.ClientApplication;
    import org.aswing.Container;
    import org.aswing.JButton;
    import hbm.Engine.Renderer.RenderSystem;
    import org.aswing.JOptionPane;
    import flash.events.Event;

    public class CustomOptionPane extends CustomWindow 
    {

        public static const CUSTOM_OPTION_PANE_CLOSED:String = "CUSTOM_OPTION_PANE_CLOSED";

        public function CustomOptionPane(_arg_1:JOptionPane, _arg_2:String="-", _arg_3:String="-", _arg_4:String="-", _arg_5:String="-")
        {
            var _local_6:JFrame;
            if (_arg_2 == "-")
            {
                _arg_2 = ClientApplication.Localization.CUSTOM_OPTION_WINDOW_CANCEL;
            };
            if (_arg_3 == "-")
            {
                _arg_3 = ClientApplication.Localization.CUSTOM_OPTION_WINDOW_OK;
            };
            if (_arg_4 == "-")
            {
                _arg_4 = ClientApplication.Localization.CUSTOM_OPTION_WINDOW_YES;
            };
            if (_arg_5 == "-")
            {
                _arg_5 = ClientApplication.Localization.CUSTOM_OPTION_WINDOW_NO;
            };
            _local_6 = _arg_1.getFrame();
            var _local_7:String = _local_6.getTitle();
            var _local_8:Container = _local_6.getContentPane();
            var _local_9:int = (_local_6.width + 10);
            var _local_10:int = _local_6.height;
            _local_6.setModal(false);
            _local_6.setClosable(false);
            _local_6.setBackgroundDecorator(null);
            _local_6.setTitle("");
            var _local_11:JButton = _arg_1.getCancelButton();
            _local_11.setText(_arg_2);
            _local_11.addActionListener(this.OnButton, 0, true);
            _local_11.buttonMode = true;
            _local_11.useHandCursor = true;
            var _local_12:JButton = _arg_1.getOkButton();
            _local_12.setText(_arg_3);
            _local_12.addActionListener(this.OnButton, 0, true);
            _local_12.buttonMode = true;
            _local_12.useHandCursor = true;
            var _local_13:JButton = _arg_1.getYesButton();
            _local_13.setText(_arg_4);
            _local_13.addActionListener(this.OnButton, 0, true);
            _local_13.buttonMode = true;
            _local_13.useHandCursor = true;
            var _local_14:JButton = _arg_1.getNoButton();
            _local_14.setText(_arg_5);
            _local_14.addActionListener(this.OnButton, 0, true);
            _local_14.buttonMode = true;
            _local_14.useHandCursor = true;
            super(owner, _local_7, true, ((_local_9 < 300) ? 300 : _local_9), (_local_10 - 50), false, false);
            setLocationXY(((RenderSystem.Instance.ScreenWidth - _local_9) / 2), ((RenderSystem.Instance.ScreenHeight - _local_10) / 2));
            MainPanel.append(_local_8);
            show();
        }

        private function OnButton(_arg_1:Event):void
        {
            dispose();
        }


    }
}//package hbm.Game.GUI.Tools

