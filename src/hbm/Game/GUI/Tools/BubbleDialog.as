


//hbm.Game.GUI.Tools.BubbleDialog

package hbm.Game.GUI.Tools
{
    import org.aswing.JPanel;
    import org.aswing.JScrollPane;
    import org.aswing.JTextArea;
    import org.aswing.EmptyLayout;
    import hbm.Game.Utility.AsWingUtil;
    import flash.text.TextField;
    import org.aswing.JScrollBar;
    import org.aswing.BorderLayout;
    import org.aswing.SoftBoxLayout;
    import org.aswing.ASColor;
    import org.aswing.ASFont;
    import hbm.Game.Utility.HtmlText;

    public class BubbleDialog extends JPanel 
    {

        public static const TAIL_DISABLE:uint = 0;
        public static const TAIL_ARROW_TOP:uint = 1;
        public static const TAIL_ARROW_MIDDLE:uint = 2;
        public static const TAIL_ARROW_BOTTOM:uint = 3;
        public static const TAIL_DREAM_TOP:uint = 4;
        public static const TAIL_DREAM_MIDDLE:uint = 5;
        public static const TAIL_DREAM_BOTTOM:uint = 6;

        private var _tail:uint = 0;
        private var _pivotTailY:int;
        private var _posX:int;
        private var _posY:int;
        private var _maxWidth:uint;
        private var _maxHeight:uint;
        private var _dialogPanel:JPanel;
        private var _scrollPane:JScrollPane;
        private var _textArea:JTextArea;
        private var _tailPanel:JPanel;
        private var _topPanel:JPanel;
        private var _leftPanel:JPanel;
        private var _bottomPanel:JPanel;
        private var _rightPanel:JPanel;

        public function BubbleDialog(_arg_1:uint, _arg_2:uint=0, _arg_3:String=null, _arg_4:uint=0)
        {
            super(new EmptyLayout());
            this._maxWidth = _arg_1;
            this._maxHeight = _arg_2;
            this._tail = _arg_4;
            this.InitUI();
            this.Text = _arg_3;
        }

        public function set Tail(_arg_1:uint):void
        {
            var _local_6:String;
            var _local_2:uint = this._dialogPanel.width;
            var _local_3:uint = this._dialogPanel.height;
            var _local_4:uint;
            var _local_5:uint;
            this._tail = _arg_1;
            switch (this._tail)
            {
                case TAIL_ARROW_TOP:
                    _local_5 = 32;
                    this._pivotTailY = 34;
                    _local_6 = "BubblePointerTalkToUp";
                    break;
                case TAIL_ARROW_MIDDLE:
                    _local_5 = 34;
                    _local_4 = uint((_local_3 / 2));
                    this._pivotTailY = -(_local_4 + 19);
                    _local_6 = "BubblePointerTalkToCenter";
                    break;
                case TAIL_ARROW_BOTTOM:
                    _local_5 = 32;
                    _local_4 = (_local_3 - 38);
                    this._pivotTailY = -(_local_3 - 24);
                    _local_6 = "BubblePointerTalkToDown";
                    break;
                case TAIL_DREAM_TOP:
                    _local_5 = 66;
                    this._pivotTailY = 0;
                    _local_6 = "BubblePointerThinkToUp";
                    break;
                case TAIL_DREAM_MIDDLE:
                    _local_5 = 58;
                    _local_4 = uint((_local_3 / 2));
                    this._pivotTailY = -(_local_4 + 36);
                    _local_6 = "BubblePointerThinkToCenter";
                    break;
                case TAIL_DREAM_BOTTOM:
                    _local_5 = 66;
                    _local_4 = (_local_3 - 66);
                    this._pivotTailY = -(_local_3 - 24);
                    _local_6 = "BubblePointerThinkToDown";
                    break;
                case TAIL_DISABLE:
            };
            if (_local_6)
            {
                AsWingUtil.SetBackgroundFromAsset(this._tailPanel, _local_6);
                this._tailPanel.setLocationXY(0, _local_4);
                append(this._tailPanel);
            }
            else
            {
                this._tailPanel.removeFromContainer();
            };
            this._dialogPanel.setLocationXY(_local_5, 0);
            AsWingUtil.SetSize(this, ((_local_2 + _local_5) + 4), _local_3);
            this.UpdatePosition();
        }

        public function SetPositionBubble(_arg_1:uint=0, _arg_2:uint=0):void
        {
            this._posX = _arg_1;
            this._posY = _arg_2;
            this.UpdatePosition();
        }

        public function get Text():String
        {
            return (this._textArea.getHtmlText());
        }

        public function set Text(_arg_1:String):void
        {
            var _local_2:TextField;
            this._textArea.setHtmlText(((_arg_1) || ("")));
            visible = ((!(_arg_1 == null)) && (_arg_1.length > 0));
            if (!visible)
            {
                return;
            };
            this._textArea.pack();
            _local_2 = this._textArea.getTextField();
            var _local_3:uint = (Math.min(_local_2.textHeight, ((this._maxHeight) || (_local_2.textHeight))) + 12);
            var _local_4:uint = (Math.min(_local_2.textWidth, this._maxWidth) + 20);
            AsWingUtil.SetSize(this._scrollPane, _local_4, _local_3);
            AsWingUtil.SetWidth(this._topPanel, _local_4);
            AsWingUtil.SetWidth(this._bottomPanel, _local_4);
            AsWingUtil.SetHeight(this._leftPanel, _local_3);
            AsWingUtil.SetHeight(this._rightPanel, _local_3);
            this._dialogPanel.pack();
            var _local_5:JScrollBar = this._scrollPane.getVerticalScrollBar();
            _local_5.setValues(this._textArea.height, 0, 0, this._textArea.height);
            this.Tail = this._tail;
        }

        private function UpdatePosition():void
        {
            setLocationXY(this._posX, (this._posY + this._pivotTailY));
        }

        private function InitUI():void
        {
            this._tailPanel = new JPanel(new BorderLayout());
            this._dialogPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            append(this._dialogPanel);
            var _local_1:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackgroundFromAsset(_local_1, "Bubble1LeftUp");
            this._topPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackgroundFromAsset(this._topPanel, "Bubble2Up");
            var _local_2:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackgroundFromAsset(_local_2, "Bubble3RightUp");
            var _local_3:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_3.appendAll(_local_1, this._topPanel, _local_2);
            this._leftPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackgroundFromAsset(this._leftPanel, "Bubble8Left");
            this._textArea = AsWingUtil.CreateTextArea("");
            this._textArea.setForeground(new ASColor(1125719));
            this._textArea.setFont(new ASFont(HtmlText.fontName, 14));
            AsWingUtil.SetWidth(this._textArea, this._maxWidth);
            this._scrollPane = new JScrollPane(this._textArea, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_NEVER);
            AsWingUtil.SetBackgroundFromAsset(this._scrollPane, "Bubble9Center");
            this._rightPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackgroundFromAsset(this._rightPanel, "Bubble4Right");
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_4.appendAll(this._leftPanel, this._scrollPane, this._rightPanel);
            var _local_5:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackgroundFromAsset(_local_5, "Bubble7LeftDown");
            this._bottomPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackgroundFromAsset(this._bottomPanel, "Bubble6Down");
            var _local_6:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackgroundFromAsset(_local_6, "Bubble5RightDown");
            var _local_7:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.LEFT));
            _local_7.appendAll(_local_5, this._bottomPanel, _local_6);
            this._dialogPanel.appendAll(_local_3, _local_4, _local_7);
            pack();
        }


    }
}//package hbm.Game.GUI.Tools

