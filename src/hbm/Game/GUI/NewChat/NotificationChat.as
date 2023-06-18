


//hbm.Game.GUI.NewChat.NotificationChat

package hbm.Game.GUI.NewChat
{
    import org.aswing.JPanel;
    import org.aswing.BorderLayout;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.EmptyBorder;
    import flash.display.BitmapData;
    import org.aswing.JLabel;
    import org.aswing.geom.IntDimension;
    import org.aswing.AssetBackground;
    import flash.display.Bitmap;
    import caurina.transitions.Tweener;

    public class NotificationChat extends JPanel 
    {

        private static const MAX_HISTORY:uint = 8;
        private static const HIDE_DELAY_AFTER_SHOW:Number = 7;
        private static const HIDE_TIME:Number = 5;

        private var _chatArea:JPanel;
        private var _history:Array = [];

        public function NotificationChat(_arg_1:Number)
        {
            super(new BorderLayout());
            mouseChildren = false;
            setPreferredWidth(_arg_1);
            this._chatArea = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            this._chatArea.setBorder(new EmptyBorder());
            this._chatArea.pack();
            append(this._chatArea);
            pack();
        }

        public function AddNotification(_arg_1:InteractiveText):void
        {
            var _local_2:BitmapData;
            if (((!(visible)) || (_arg_1 == null)))
            {
                return;
            };
            if (this._history.length >= MAX_HISTORY)
            {
                this.OnLastDelete();
            };
            _arg_1.pack();
            _local_2 = _arg_1.GetBitmapData();
            var _local_3:JLabel = new JLabel();
            var _local_4:IntDimension = new IntDimension(_local_2.width, _local_2.height);
            _local_3.setPreferredSize(_local_4);
            _local_3.setMaximumSize(_local_4);
            _local_3.setSize(_local_4);
            _local_3.setBackgroundDecorator(new AssetBackground(new Bitmap(_local_2)));
            _local_3.setBorder(new EmptyBorder());
            _local_3.pack();
            this._chatArea.append(_local_3);
            this._chatArea.pack();
            setPreferredHeight(-1);
            pack();
            setLocationXY(0, -(getPreferredHeight()));
            Tweener.addTween(_local_3, {
                "alpha":0,
                "delay":HIDE_DELAY_AFTER_SHOW,
                "time":HIDE_TIME,
                "onComplete":this.OnLastDelete
            });
            this._history.push(_local_3);
        }

        public function Clear():void
        {
            var _local_1:JLabel;
            for each (_local_1 in this._history)
            {
                this.DeleteLabel(_local_1);
            };
            this._history = [];
            this._chatArea.removeAll();
            setPreferredHeight(-1);
            pack();
        }

        private function OnLastDelete():void
        {
            if (this._history.length < 1)
            {
                return;
            };
            var _local_1:JLabel = this._history.shift();
            this.DeleteLabel(_local_1);
            setPreferredHeight(-1);
            pack();
            setLocationXY(0, -(getPreferredHeight()));
        }

        private function DeleteLabel(_arg_1:JLabel):void
        {
            if (_arg_1 == null)
            {
                return;
            };
            if (Tweener.isTweening(_arg_1))
            {
                Tweener.removeTweens(_arg_1);
            };
            _arg_1.removeFromContainer();
        }


    }
}//package hbm.Game.GUI.NewChat

