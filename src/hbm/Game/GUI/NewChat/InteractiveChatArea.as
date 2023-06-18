


//hbm.Game.GUI.NewChat.InteractiveChatArea

package hbm.Game.GUI.NewChat
{
    import org.aswing.JPanel;
    import org.aswing.JScrollPane;
    import org.aswing.BorderLayout;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.JScrollBar;

    public class InteractiveChatArea extends JPanel 
    {

        private static const MAX_HISTORY:uint = 50;

        private var _chatArea:JPanel;
        private var _chatScrollArea:JScrollPane;
        private var _history:Array = [];
        private var _heightMsg:Number = 0;
        private var _lock:Boolean = true;

        public function InteractiveChatArea(_arg_1:Number, _arg_2:Number)
        {
            super(new BorderLayout());
            setPreferredWidth(_arg_1);
            setPreferredHeight(_arg_2);
            this._chatArea = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            this._chatArea.setBorder(new EmptyBorder());
            this._chatArea.setPreferredHeight(_arg_2);
            this._chatScrollArea = new JScrollPane(this._chatArea, JScrollPane.SCROLLBAR_ALWAYS);
            this._chatScrollArea.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 5)));
            this._chatScrollArea.setPreferredWidth(_arg_1);
            this._chatScrollArea.setPreferredHeight(_arg_2);
            this._chatScrollArea.pack();
            append(this._chatScrollArea);
            pack();
        }

        public function Lock():void
        {
            var _local_1:InteractiveText;
            if (this._lock)
            {
                return;
            };
            for each (_local_1 in this._history)
            {
                _local_1.EnableSelect(false);
            };
            this._lock = true;
        }

        public function Unlock():void
        {
            var _local_1:InteractiveText;
            if (!this._lock)
            {
                return;
            };
            for each (_local_1 in this._history)
            {
                _local_1.EnableSelect(true);
            };
            this._lock = false;
        }

        public function AddText(_arg_1:InteractiveText):void
        {
            var _local_3:InteractiveText;
            if (_arg_1 == null)
            {
                return;
            };
            if (!this._lock)
            {
                _arg_1.EnableSelect(true);
            };
            if (this._history.length >= MAX_HISTORY)
            {
                _local_3 = this._history.shift();
                this._heightMsg = (this._heightMsg - _local_3.getPreferredHeight());
                _local_3.Destroy();
            };
            _arg_1.pack();
            this._heightMsg = (this._heightMsg + _arg_1.getPreferredHeight());
            this._chatArea.append(_arg_1);
            this._chatArea.pack();
            var _local_2:Number = (getPreferredHeight() - 30);
            if (this._heightMsg > _local_2)
            {
                this._chatArea.setPreferredHeight(-1);
            }
            else
            {
                this._chatArea.setPreferredHeight(getPreferredHeight());
            };
            this._history.push(_arg_1);
        }

        public function ScrollToTheEnd():void
        {
            this._chatArea.pack();
            var _local_1:JScrollBar = this._chatScrollArea.getVerticalScrollBar();
            _local_1.setValues(this._chatArea.height, 0, 0, this._chatArea.height);
        }

        public function Clear():void
        {
            this._chatArea.removeAll();
            this._history = [];
            this._heightMsg = 0;
        }


    }
}//package hbm.Game.GUI.NewChat

