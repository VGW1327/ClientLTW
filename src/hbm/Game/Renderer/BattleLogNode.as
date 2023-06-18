


//hbm.Game.Renderer.BattleLogNode

package hbm.Game.Renderer
{
    import mx.core.BitmapAsset;
    import flash.geom.Matrix;
    import flash.text.TextField;
    import flash.geom.Point;
    import mx.controls.Image;
    import hbm.Game.Utility.HtmlText;
    import flash.text.TextFieldAutoSize;
    import flash.text.AntiAliasType;
    import flash.text.GridFitType;
    import caurina.transitions.Tweener;
    import flash.display.Bitmap;
    import hbm.Engine.Renderer.Camera;
    import flash.display.BitmapData;

    public class BattleLogNode 
    {

        private var _textColor:uint = 0;
        private var _lifeTime:Number = 1;
        private var _message:String = null;
        private var _bitmap:BitmapAsset = null;
        private var _drawMatrix:Matrix;
        private var _textMessage:TextField = null;
        private var _position:Point = new Point(0, 0);
        private var _image:Image = null;
        private var _topLeftDrawPosition:Point;

        public function BattleLogNode(_arg_1:String, _arg_2:Number, _arg_3:Point, _arg_4:Point, _arg_5:uint=0, _arg_6:uint=0, _arg_7:BitmapAsset=null)
        {
            this._message = _arg_1;
            this._lifeTime = _arg_2;
            this._textColor = _arg_5;
            this._position = _arg_3;
            this._bitmap = _arg_7;
            this._drawMatrix = new Matrix();
            this._topLeftDrawPosition = new Point(0, 0);
            if (this._message)
            {
                this._textMessage = new TextField();
                this._textMessage.x = _arg_3.x;
                this._textMessage.y = _arg_3.y;
                this._textMessage.textColor = this._textColor;
                this._textMessage.htmlText = HtmlText.update(_arg_1, false, ((_arg_6 == 0) ? 9 : 20));
                this._textMessage.autoSize = TextFieldAutoSize.CENTER;
                this._textMessage.antiAliasType = AntiAliasType.ADVANCED;
                this._textMessage.gridFitType = GridFitType.PIXEL;
                this._textMessage.sharpness = -400;
                this._textMessage.selectable = false;
                this._textMessage.filters = [HtmlText.glow];
                if (_arg_6 == 0)
                {
                    Tweener.addTween(this._textMessage, {
                        "x":_arg_4.x,
                        "time":1,
                        "transition":"easeOutCubic"
                    });
                    Tweener.addTween(this._textMessage, {
                        "y":_arg_4.y,
                        "time":1,
                        "transition":"easeOutExpo"
                    });
                    Tweener.addTween(this._textMessage, {
                        "scaleX":3,
                        "scaleY":3,
                        "time":0.5,
                        "transition":"linear"
                    });
                }
                else
                {
                    this._textMessage.autoSize = TextFieldAutoSize.LEFT;
                    Tweener.addTween(this._textMessage, {
                        "y":_arg_4.y,
                        "time":1,
                        "transition":"linear"
                    });
                };
            }
            else
            {
                if (this._bitmap)
                {
                    this._image = new Image();
                    this._image.x = _arg_3.x;
                    this._image.y = _arg_3.y;
                    this._image.width = 32;
                    this._image.height = 32;
                    this._image.addChild(new Bitmap(this._bitmap.bitmapData));
                    Tweener.addTween(this._image, {
                        "y":_arg_4.y,
                        "time":1,
                        "transition":"linear"
                    });
                };
            };
        }

        public function get Message():String
        {
            return (this._message);
        }

        public function get LifeTime():Number
        {
            return (this._lifeTime);
        }

        public function Update(_arg_1:Number):void
        {
            this._lifeTime = (this._lifeTime - _arg_1);
        }

        public function Draw(_arg_1:Camera, _arg_2:BitmapData):void
        {
            if (this._message)
            {
                this._drawMatrix.tx = ((this._textMessage.x - _arg_1.TopLeftPoint.x) - (this._textMessage.textWidth / 2));
                this._drawMatrix.ty = ((_arg_1.MaxHeight - this._textMessage.y) - _arg_1.TopLeftPoint.y);
                this._drawMatrix.a = this._textMessage.scaleX;
                this._drawMatrix.d = this._textMessage.scaleY;
                if (this._textColor != 0)
                {
                    this._textMessage.textColor = this._textColor;
                }
                else
                {
                    this._textMessage.textColor = 16313655;
                };
                _arg_2.draw(this._textMessage, this._drawMatrix);
            }
            else
            {
                if (this._image)
                {
                    this._drawMatrix.tx = ((this._image.x - _arg_1.TopLeftPoint.x) - (this._image.width / 2));
                    this._drawMatrix.ty = ((_arg_1.MaxHeight - this._image.y) - _arg_1.TopLeftPoint.y);
                    this._drawMatrix.a = this._image.scaleX;
                    this._drawMatrix.d = this._image.scaleY;
                    _arg_2.draw(this._image, this._drawMatrix);
                };
            };
        }

        public function get Position():Point
        {
            return (this._position);
        }

        public function set Position(_arg_1:Point):void
        {
            this._position = _arg_1;
        }


    }
}//package hbm.Game.Renderer

