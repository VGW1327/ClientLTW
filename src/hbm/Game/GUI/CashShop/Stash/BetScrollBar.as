


//hbm.Game.GUI.CashShop.Stash.BetScrollBar

package hbm.Game.GUI.CashShop.Stash
{
    import org.aswing.JPanel;
    import flash.display.Bitmap;
    import org.aswing.JLabel;
    import org.aswing.geom.IntPoint;
    import org.aswing.EmptyLayout;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import org.aswing.CenterLayout;
    import org.aswing.AssetBackground;

    public class BetScrollBar extends JPanel 
    {

        private const EDGE_OFFSET:int = 10;

        private var _sliderAsset:Bitmap = null;
        private var _width:int = 100;
        private var _height:int = 20;
        private var _slider:JPanel = null;
        private var _amount:JLabel = null;
        private var _range:IntPoint = new IntPoint(0, 100);
        private var _slideValue:int = 0;
        private var _isDragging:Boolean = false;
        private var _mouseOffset:int = 0;
        private var _sliderWidth:int = 20;
        private var _sliderHeight:int = 20;
        private var _onStateListener:Function = null;

        public function BetScrollBar(_arg_1:int, _arg_2:int, _arg_3:Bitmap=null, _arg_4:IntPoint=null, _arg_5:int=0)
        {
            super(new EmptyLayout());
            this._sliderAsset = _arg_3;
            if (_arg_4)
            {
                this._range = _arg_4;
            };
            this.InitUI();
            setPreferredWidth((this._width = _arg_1));
            setPreferredHeight((this._height = _arg_2));
            this._slideValue = _arg_5;
            var _local_6:Number = (this._slideValue / (this._range.y - this._range.x));
            this._slider.setLocationXY(int((_local_6 * (this._width - this._sliderWidth))), 0);
            this._amount.setText(this._slideValue.toString());
            addEventListener(Event.ADDED_TO_STAGE, this.initHandlers);
        }

        public function get Value():int
        {
            return (this._slideValue);
        }

        public function SetStateListener(_arg_1:Function):void
        {
            this._onStateListener = _arg_1;
        }

        private function initHandlers(_arg_1:Event=null):void
        {
            this.removeEventListener(Event.ADDED_TO_STAGE, this.initHandlers);
            this._slider.addEventListener(MouseEvent.MOUSE_DOWN, this.OnMouseDown, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_UP, this.OnMouseUp, false, 0, true);
            this.addEventListener(MouseEvent.MOUSE_MOVE, this.OnMouseMove, false, 0, true);
            this.parent.addEventListener(MouseEvent.MOUSE_UP, this.OnMouseUp, false, 0, true);
            this.parent.addEventListener(MouseEvent.MOUSE_OUT, this.OnMouseUp, false, 0, true);
        }

        private function InitUI():void
        {
            this._slider = new JPanel(new CenterLayout());
            if (this._slider != null)
            {
                this._slider.setBackgroundDecorator(new AssetBackground(this._sliderAsset));
                this._slider.setWidth(this._sliderAsset.width);
                this._slider.setHeight(this._sliderAsset.height);
                this._sliderWidth = this._sliderAsset.width;
                this._sliderHeight = this._sliderAsset.height;
            };
            this._amount = new JLabel("");
            this._amount.setPreferredWidth(this._sliderWidth);
            this._amount.mouseEnabled = false;
            this._slider.append(this._amount);
            this._slider.buttonMode = true;
            append(this._slider);
        }

        private function OnMouseDown(_arg_1:MouseEvent):void
        {
            this._isDragging = true;
            this._mouseOffset = (_arg_1.target.parent.mouseX - this._slider.getLocation().x);
        }

        private function OnMouseUp(_arg_1:MouseEvent):void
        {
            this._isDragging = false;
        }

        private function OnMouseMove(_arg_1:MouseEvent):void
        {
            var _local_2:int;
            var _local_3:Number;
            if (this._isDragging)
            {
                _local_2 = (_arg_1.target.parent.mouseX - this._mouseOffset);
                if (_local_2 < 0)
                {
                    _local_2 = 0;
                }
                else
                {
                    if (_local_2 > (this._width - this._sliderWidth))
                    {
                        _local_2 = (this._width - this._sliderWidth);
                    };
                };
                this._slider.setLocationXY(_local_2, 0);
                _local_3 = (_local_2 / (this._width - this._sliderWidth));
                this._slideValue = (this._range.x + int(((this._range.y - this._range.x) * _local_3)));
                this._amount.setText(this._slideValue.toString());
                if (this._onStateListener != null)
                {
                    this._onStateListener(this._slideValue);
                };
            };
        }


    }
}//package hbm.Game.GUI.CashShop.Stash

