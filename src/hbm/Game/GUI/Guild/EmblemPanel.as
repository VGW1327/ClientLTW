


//hbm.Game.GUI.Guild.EmblemPanel

package hbm.Game.GUI.Guild
{
    import org.aswing.JPanel;
    import org.aswing.GridLayout;
    import org.aswing.FlowLayout;
    import org.aswing.geom.IntDimension;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;

    public class EmblemPanel extends JPanel 
    {

        protected var _emblemsCount:int;

        public function EmblemPanel()
        {
            super(new GridLayout(0, 8));
            this.Clear();
        }

        public function Clear():void
        {
            removeAll();
            this._emblemsCount = 0;
        }

        protected function CreateSlot():JPanel
        {
            var _local_3:FlowLayout;
            var _local_1:IntDimension = new IntDimension(30, 30);
            var _local_2:LineBorder = new LineBorder(null, new ASColor(5333109), 1, 4);
            _local_3 = new FlowLayout();
            _local_3.setMargin(false);
            var _local_4:JPanel = new JPanel(_local_3);
            _local_4.setBorder(_local_2);
            _local_4.setPreferredSize(_local_1);
            _local_4.setMaximumSize(_local_1);
            append(_local_4);
            return (_local_4);
        }

        public function AddEmblemItem(_arg_1:EmblemItem):void
        {
            this.CreateSlot().append(_arg_1);
            this._emblemsCount++;
        }


    }
}//package hbm.Game.GUI.Guild

