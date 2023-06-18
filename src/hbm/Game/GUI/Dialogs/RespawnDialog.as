


//hbm.Game.GUI.Dialogs.RespawnDialog

package hbm.Game.GUI.Dialogs
{
    import flash.events.EventDispatcher;
    import hbm.Game.GUI.Tools.CustomWindow;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Application.ClientApplication;
    import hbm.Game.Character.Character;
    import org.aswing.AsWingManager;
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import org.aswing.JLabel;
    import org.aswing.AttachIcon;
    import org.aswing.FlowWrapLayout;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.ASColor;
    import hbm.Engine.Renderer.RenderSystem;
    import flash.events.Event;

    public class RespawnDialog extends EventDispatcher 
    {

        public static const ON_RESPAWN_CONFIRMED:String = "ON_RESPAWN_CONFIRMED";

        private var _window:CustomWindow;
        private var _buttonOk:CustomButton;

        public function RespawnDialog(_arg_1:Boolean=false)
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:String;
            var _local_12:CharacterInfo;
            var _local_13:Boolean;
            super();
            if (!_arg_1)
            {
                _local_2 = ClientApplication.Localization.DLG_RESPAWN_TITLE1;
                _local_12 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                _local_13 = ((_local_12.clothesColor) && (!(Character.IsBabyClass(_local_12.jobId))));
                _local_3 = ((_local_13) ? ClientApplication.Localization.DLG_RESPAWN_YOUREDEAD2 : ClientApplication.Localization.DLG_RESPAWN_YOUREDEAD1);
                _local_4 = ((_local_13) ? ClientApplication.Localization.DLG_RESPAWN_BUTTON12 : ClientApplication.Localization.DLG_RESPAWN_BUTTON11);
            }
            else
            {
                _local_2 = ClientApplication.Localization.DLG_RESPAWN_TITLE2;
                _local_3 = ClientApplication.Localization.DLG_RESPAWN_GVG;
                _local_4 = ClientApplication.Localization.DLG_RESPAWN_BUTTON2;
            };
            var _local_5:DeathIcon;
            this._window = new CustomWindow(AsWingManager.getRoot(), _local_2, true, 400, 115, false);
            var _local_6:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 5));
            var _local_7:JLabel = new JLabel("", new AttachIcon("DeathIcon"), JLabel.LEFT);
            var _local_8:JPanel = new JPanel(new FlowWrapLayout(320, FlowWrapLayout.CENTER));
            _local_7.setText(_local_3);
            this._buttonOk = new CustomButton(_local_4);
            var _local_9:CustomToolTip = new CustomToolTip(this._buttonOk, ClientApplication.Instance.GetPopupText(145), 250, 40);
            _local_8.append(this._buttonOk);
            _local_7.setBorder(new EmptyBorder(null, new Insets(12, 20, 12, 20)));
            _local_6.append(_local_7);
            _local_6.append(_local_8);
            this._window.MainPanel.append(_local_6);
            this._window.pack();
            this._window.setDefaultButton(this._buttonOk);
            this._window.setMideground(new ASColor(0xFFCC00, 1));
            var _local_10:int = int(((RenderSystem.Instance.ScreenWidth - this._window.width) / 2));
            var _local_11:int = int(((600 - this._window.height) / 2));
            this._window.setLocationXY(_local_10, _local_11);
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
            dispatchEvent(new Event(ON_RESPAWN_CONFIRMED));
        }

        public function get IsShowing():Boolean
        {
            return ((!(this._window == null)) && (this._window.isShowing()));
        }


    }
}//package hbm.Game.GUI.Dialogs

