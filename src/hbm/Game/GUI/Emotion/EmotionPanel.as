


//hbm.Game.GUI.Emotion.EmotionPanel

package hbm.Game.GUI.Emotion
{
    import org.aswing.JPanel;
    import org.aswing.GridLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.FlowLayout;
    import org.aswing.geom.IntDimension;

    public class EmotionPanel extends JPanel 
    {

        protected var _emotionsCount:int;

        public function EmotionPanel()
        {
            super(new GridLayout(0, 5));
            setBorder(new EmptyBorder(null, new Insets(2, 6, 2, 0)));
            this.Clear();
        }

        public function Clear():void
        {
            removeAll();
            this._emotionsCount = 0;
        }

        public function Refill():void
        {
            var _local_2:int;
            var _local_1:int = ((5 * 2) - this._emotionsCount);
            if (_local_1 > 0)
            {
                _local_2 = 0;
                while (_local_2 < _local_1)
                {
                    append(this.CreateSlot());
                    _local_2++;
                };
            };
        }

        protected function CreateSlot():JPanel
        {
            var _local_2:FlowLayout;
            var _local_1:IntDimension = new IntDimension(38, 38);
            _local_2 = new FlowLayout();
            _local_2.setMargin(false);
            var _local_3:JPanel = new JPanel(_local_2);
            _local_3.setBorder(new EmptyBorder());
            _local_3.setPreferredSize(_local_1);
            _local_3.setMaximumSize(_local_1);
            append(_local_3);
            return (_local_3);
        }

        public function AddEmotionItem(_arg_1:EmotionItem):void
        {
            this.CreateSlot().append(_arg_1);
            this._emotionsCount++;
        }


    }
}//package hbm.Game.GUI.Emotion

