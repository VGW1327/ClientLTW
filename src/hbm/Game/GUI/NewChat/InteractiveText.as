


//hbm.Game.GUI.NewChat.InteractiveText

package hbm.Game.GUI.NewChat
{
    import org.aswing.JPanel;
    import org.aswing.JTextArea;
    import flash.display.BitmapData;
    import org.aswing.EmptyLayout;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.geom.Rectangle;
    import hbm.Game.Utility.HtmlText;

    public class InteractiveText extends JPanel 
    {

        private static const SPACE:Number = 4;

        private const _links:Array = [];

        private var _htmlText:String = "";
        private var _textArea:JTextArea;
        private var _bitmapData:BitmapData;
        private var _changed:Boolean = false;

        public function InteractiveText(_arg_1:Number)
        {
            super(new EmptyLayout());
            mouseChildren = false;
            this._textArea = new JTextArea();
            this._textArea.setEditable(false);
            this._textArea.setOpaque(false);
            this._textArea.setWordWrap(true);
            this._textArea.setPreferredWidth(_arg_1);
            this.EnableSelect(false);
            this._textArea.pack();
            append(this._textArea);
        }

        public function EnableSelect(_arg_1:Boolean):void
        {
            if (this._textArea.getTextField().selectable == _arg_1)
            {
                return;
            };
            this._textArea.getTextField().selectable = _arg_1;
            mouseChildren = _arg_1;
            if (_arg_1)
            {
                removeEventListener(MouseEvent.CLICK, this.OnClick);
                removeEventListener(MouseEvent.MOUSE_MOVE, this.OnMouseMove);
            }
            else
            {
                addEventListener(MouseEvent.CLICK, this.OnClick, false, 0, true);
                addEventListener(MouseEvent.MOUSE_MOVE, this.OnMouseMove, false, 0, true);
            };
        }

        public function AddText(_arg_1:String):void
        {
            if (((_arg_1 == null) || (_arg_1.length < 0)))
            {
                return;
            };
            this._htmlText = (this._htmlText + (_arg_1 + ((this._htmlText.charAt((this._htmlText.length - 1)) != " ") ? " " : "")));
            this._textArea.setHtmlText(this._htmlText);
            this._textArea.pack();
            this._changed = true;
        }

        public function AddLinkText(_arg_1:String, _arg_2:Function, ... _args):void
        {
            var _local_4:TextField;
            var _local_7:uint;
            var _local_10:Rectangle;
            var _local_11:Object;
            if ((((_arg_1 == null) || (_arg_1.length < 0)) || (_arg_2 == null)))
            {
                return;
            };
            _local_4 = this._textArea.getTextField();
            var _local_5:uint = _local_4.text.length;
            var _local_6:uint = _local_4.textHeight;
            _local_4.htmlText = (this._htmlText + _arg_1);
            if (((_local_6 > 0) && (_local_6 < _local_4.textHeight)))
            {
                this._htmlText = (this._htmlText + "<br>");
                _local_5++;
            };
            this._htmlText = (this._htmlText + (_arg_1 + ((this._htmlText.charAt((this._htmlText.length - 1)) != " ") ? " " : "")));
            this._textArea.setHtmlText(this._htmlText);
            this._textArea.pack();
            _local_7 = (_local_4.text.length - 2);
            var _local_8:Rectangle = _local_4.getCharBoundaries(_local_5);
            var _local_9:Rectangle = _local_4.getCharBoundaries(_local_7);
            if (((_local_8) && (_local_9)))
            {
                _local_10 = new Rectangle(_local_8.left, _local_8.top, (_local_9.right - _local_8.left), (_local_9.bottom - _local_8.top));
                _local_11 = {
                    "cb":_arg_2,
                    "args":((_args.concat()) || ([])),
                    "rect":_local_10
                };
                this._links.push(_local_11);
            };
            this._changed = true;
            this.ClearBitmap();
        }

        public function GetBitmapData():BitmapData
        {
            if (!this._bitmapData)
            {
                this._bitmapData = new BitmapData((this._textArea.getTextField().textWidth + SPACE), (this._textArea.getTextField().textHeight + SPACE), true, 0);
                this._bitmapData.draw(this._textArea.getTextField());
            };
            return (this._bitmapData);
        }

        override public function pack():void
        {
            if (!this._changed)
            {
                return;
            };
            setPreferredHeight((this._textArea.getTextField().textHeight + SPACE));
            setPreferredWidth(this._textArea.getPreferredWidth());
            this._textArea.getTextField().filters = [HtmlText.shadow];
            super.pack();
            this._changed = false;
        }

        private function OnMouseMove(_arg_1:MouseEvent):void
        {
            var _local_2:Object;
            for each (_local_2 in this._links)
            {
                if ((_local_2.rect as Rectangle).contains(_arg_1.localX, _arg_1.localY))
                {
                    buttonMode = true;
                    return;
                };
            };
            buttonMode = false;
        }

        private function OnClick(_arg_1:MouseEvent):void
        {
            var _local_2:Object;
            for each (_local_2 in this._links)
            {
                if ((_local_2.rect as Rectangle).contains(_arg_1.localX, _arg_1.localY))
                {
                    _local_2.cb.apply(_local_2.cb, _local_2.args);
                    return;
                };
            };
        }

        public function Destroy():void
        {
            removeAll();
            this.ClearBitmap();
            removeFromContainer();
            removeEventListener(MouseEvent.CLICK, this.OnClick);
            removeEventListener(MouseEvent.MOUSE_MOVE, this.OnMouseMove);
        }

        private function ClearBitmap():void
        {
            if (this._bitmapData)
            {
                this._bitmapData.dispose();
                this._bitmapData = null;
            };
        }


    }
}//package hbm.Game.GUI.NewChat

