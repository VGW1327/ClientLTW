


//hbm.Game.GUI.Dialogs.ErrorDialog

package hbm.Game.GUI.Dialogs
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.AsWingManager;
    import hbm.Application.ClientApplication;
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import org.aswing.JLabel;
    import org.aswing.AttachIcon;
    import org.aswing.FlowWrapLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.ASColor;
    import flash.events.Event;

    public class ErrorDialog 
    {

        private var _window:CustomWindow;
        private var _buttonOk:CustomButton;
        private var _fullReload:Boolean;

        public function ErrorDialog(_arg_1:String, _arg_2:int, _arg_3:int, _arg_4:Boolean=true)
        {
            this._fullReload = _arg_4;
            this._window = new CustomWindow(AsWingManager.getRoot(), ClientApplication.Localization.DLG_ERROR_TITLE, true, _arg_2, _arg_3, true);
            var _local_5:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
            var _local_6:JLabel = new JLabel(_arg_1, new AttachIcon("StopIcon"), JLabel.LEFT);
            var _local_7:JPanel = new JPanel(new FlowWrapLayout(200, FlowWrapLayout.CENTER));
            this._buttonOk = new CustomButton(ClientApplication.Localization.DLG_ERROR_BUTTON);
            _local_7.append(this._buttonOk);
            _local_6.setBorder(new EmptyBorder(null, new Insets(12, 10, 12, 10)));
            _local_5.append(_local_6);
            _local_5.append(_local_7);
            this._window.MainPanel.append(_local_5);
            this._window.pack();
            this._window.setDefaultButton(this._buttonOk);
            this._window.setMideground(new ASColor(0xFFCC00, 1));
            this._window.setLocationXY(((ClientApplication.stageWidth - this._window.width) / 2), ((0x0300 - this._window.height) / 2));
            this._buttonOk.addActionListener(this.ButtonOk, 0, true);
        }

        public function Show():void
        {
            this._window.show();
        }

        public function Dispose():void
        {
            this._window.dispose();
        }

        private function ButtonOk(_arg_1:Event):void
        {
            this._window.dispose();
            ClientApplication.Instance.ReloadPage(this._fullReload);
        }

        public function isShowing():Boolean
        {
            return (this._window.isShowing());
        }


    }
}//package hbm.Game.GUI.Dialogs

