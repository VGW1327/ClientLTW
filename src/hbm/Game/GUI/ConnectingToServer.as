


//hbm.Game.GUI.ConnectingToServer

package hbm.Game.GUI
{
    import hbm.Game.GUI.Tools.CustomWindow2;
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Application.ClientApplication;

    public class ConnectingToServer extends CustomWindow2 
    {

        private const _width:int = 280;
        private const _height:int = 40;

        private var _info:PaddedValue;

        public function ConnectingToServer()
        {
            super(null, true, this._width, this._height, false);
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4, SoftBoxLayout.CENTER));
            _local_1.setBorder(new EmptyBorder(null, new Insets(3, 20, 0, 0)));
            this._info = new PaddedValue(ClientApplication.Localization.CONNECT_WINDOW_INFO, "", 260, 0, -1, 0xFFD700);
            _local_1.append(this._info);
            MainPanel.append(_local_1);
            pack();
            this.Center();
        }

        public function Center():void
        {
            setLocationXY(((ClientApplication.stageWidth / 2) - (this._width / 2)), 300);
        }


    }
}//package hbm.Game.GUI

