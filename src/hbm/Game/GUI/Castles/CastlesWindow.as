


//hbm.Game.GUI.Castles.CastlesWindow

package hbm.Game.GUI.Castles
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JPanel;
    import hbm.Application.ClientApplication;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.SoftBoxLayout;
    import org.aswing.JScrollPane;
    import org.aswing.geom.IntDimension;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import flash.utils.Dictionary;
    import org.aswing.event.AWEvent;

    public class CastlesWindow extends CustomWindow 
    {

        private const _width:int = 560;
        private const _height:int = 380;

        private var _castlesList:JPanel;

        public function CastlesWindow()
        {
            super(null, ClientApplication.Localization.CASTLES_TITLE, false, this._width, this._height, true);
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
            this.InitUI();
        }

        private function InitUI():void
        {
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            this._castlesList = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            var _local_2:JScrollPane = new JScrollPane(this._castlesList);
            _local_2.setBorder(_local_1);
            _local_2.setPreferredSize(new IntDimension((this._width - 5), (this._height - 5)));
            var _local_3:JPanel = new JPanel(new BorderLayout());
            _local_3.setBorder(new EmptyBorder(null, new Insets(6, 4, 4, 4)));
            _local_3.append(_local_2, BorderLayout.CENTER);
            MainPanel.append(_local_3, BorderLayout.CENTER);
            pack();
        }

        public function LoadCastles(_arg_1:Dictionary):void
        {
            var _local_3:int;
            var _local_2:Array = [5, 7, 9, 6, 11, 12, 0, 1, 2, 3, 4, 10, 8];
            this._castlesList.removeAll();
            for each (_local_3 in _local_2)
            {
                if (_arg_1[_local_3] != null)
                {
                    this._castlesList.append(new CastlePanel(_arg_1[_local_3]));
                };
            };
        }

        private function OnCloseButtonPressed(_arg_1:AWEvent):void
        {
            dispose();
        }


    }
}//package hbm.Game.GUI.Castles

