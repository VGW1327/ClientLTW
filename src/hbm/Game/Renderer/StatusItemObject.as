


//hbm.Game.Renderer.StatusItemObject

package hbm.Game.Renderer
{
    import hbm.Engine.Renderer.RenderObject;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.text.TextField;
    import flash.geom.ColorTransform;
    import flash.text.TextFormat;
    import flash.text.TextFieldAutoSize;
    import flash.text.AntiAliasType;
    import flash.text.GridFitType;
    import hbm.Game.Utility.HtmlText;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import flash.display.Bitmap;
    import flash.geom.Matrix;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Renderer.Camera;
    import hbm.Application.ClientApplication;

    public class StatusItemObject extends RenderObject 
    {

        private var _clothesColor:int;
        private var _resourceName:String = null;
        private var _drawRectangle:Rectangle = null;
        private var _objectBitmapData:BitmapData = null;
        private var _statusType:int;
        private var _needDrawTime:Boolean = true;
        private var _nullPoint:Point;
        private var _infoText:TextField;
        private var _typeEffect:int;
        private var _time:Number;
        private var _counter:int = 0;
        private var _colorTransform:ColorTransform = new ColorTransform();
        private var _warningEffects:Boolean = false;
        private var _rentStatusTypes:Array = new Array(317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361);
        private var _lastDrawRect:Rectangle = null;

        public function StatusItemObject(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int=0, _arg_5:int=-1)
        {
            this._clothesColor = _arg_1;
            this._statusType = _arg_2;
            this._time = _arg_5;
            Priority = 200000;
            Position = new Point(0, 0);
            this._nullPoint = new Point(0, 0);
            this._lastDrawRect = new Rectangle();
            this._resourceName = _arg_3;
            this._typeEffect = _arg_4;
            this._infoText = new TextField();
            this._infoText.x = 0;
            this._infoText.y = 0;
            this._infoText.width = 22;
            this._infoText.textColor = ((_arg_4 == 0) ? 0xFFFFFF : 16678012);
            this._infoText.text = "";
            var _local_6:TextFormat = this._infoText.defaultTextFormat;
            _local_6.size = 10;
            _local_6.align = TextFieldAutoSize.RIGHT;
            this._infoText.defaultTextFormat = _local_6;
            this._infoText.autoSize = TextFieldAutoSize.CENTER;
            this._infoText.antiAliasType = AntiAliasType.ADVANCED;
            this._infoText.gridFitType = GridFitType.PIXEL;
            this._infoText.sharpness = -400;
            this._infoText.selectable = false;
            this._infoText.filters = [HtmlText.glow];
            this.CheckWarningEffects();
        }

        public function get TypeEffect():int
        {
            return (this._typeEffect);
        }

        public function get TimeAmount():Number
        {
            return (this._time);
        }

        public function set TimeAmount(_arg_1:Number):void
        {
            this._time = _arg_1;
            if (this._time < 0)
            {
                this._time = 0;
            };
            if (this._warningEffects)
            {
                this.UpdateInfoColor();
            };
        }

        public function get StatusType():int
        {
            return (this._statusType);
        }

        public function set NeedDrawTime(_arg_1:Boolean):void
        {
            this._needDrawTime = _arg_1;
        }

        public function IsCollided(_arg_1:Point):Boolean
        {
            var _local_2:Boolean;
            if (this._lastDrawRect != null)
            {
                _local_2 = this._lastDrawRect.containsPoint(_arg_1);
            };
            return (_local_2);
        }

        override public function Draw(_arg_1:Camera, _arg_2:BitmapData):void
        {
            var _local_4:AdditionalDataResourceLibrary;
            var _local_5:Bitmap;
            var _local_6:Number;
            var _local_7:BitmapData;
            var _local_8:Matrix;
            if (this._objectBitmapData == null)
            {
                _local_4 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
                _local_5 = null;
                if (this._clothesColor)
                {
                    _local_5 = _local_4.GetBitmapAsset((this._resourceName + "c"));
                };
                if (_local_5 == null)
                {
                    _local_5 = _local_4.GetBitmapAsset(this._resourceName);
                };
                if (_local_5 == null)
                {
                    this._resourceName = "AdditionalData_Item_1000";
                    _local_5 = _local_4.GetBitmapAsset(this._resourceName);
                };
                if (_local_5 != null)
                {
                    _local_6 = 0.7;
                    _local_7 = new BitmapData((_local_5.bitmapData.width * _local_6), (_local_5.bitmapData.height * _local_6), true, 0);
                    _local_8 = new Matrix();
                    _local_8.scale(_local_6, _local_6);
                    _local_7.draw(_local_5.bitmapData, _local_8, this._colorTransform, null, null, true);
                    this._objectBitmapData = _local_7;
                    this._drawRectangle = new Rectangle(0, 0, this._objectBitmapData.width, this._objectBitmapData.height);
                };
            };
            if (((this._objectBitmapData == null) || (this._drawRectangle == null)))
            {
                return;
            };
            var _local_3:Point = new Point(Position.x, Position.y);
            _arg_2.copyPixels(this._objectBitmapData, this._drawRectangle, _local_3, this._objectBitmapData, this._nullPoint, true);
            this._lastDrawRect.x = _local_3.x;
            this._lastDrawRect.y = _local_3.y;
            this._lastDrawRect.width = this._drawRectangle.width;
            this._lastDrawRect.height = this._drawRectangle.height;
            if (((this._time > 0) && (this._needDrawTime)))
            {
                this.DrawInfo(_arg_1, _arg_2);
            };
        }

        public function DrawInfo(_arg_1:Camera, _arg_2:BitmapData):void
        {
            this._infoText.text = this.convertTime(this._time);
            var _local_3:Matrix = new Matrix();
            _local_3.tx = Position.x;
            _local_3.ty = (Position.y + 8);
            if (((this._warningEffects) && (this._time < 600)))
            {
                this._colorTransform.alphaMultiplier = (1 - (Number(this._counter) / 30));
                this._counter++;
                if (this._counter > 30)
                {
                    this._counter = 0;
                };
                _arg_2.draw(this._infoText, _local_3, this._colorTransform);
            }
            else
            {
                this._colorTransform.alphaMultiplier = 1;
                _arg_2.draw(this._infoText, _local_3, this._colorTransform);
            };
        }

        private function convertTime(_arg_1:Number):String
        {
            var _local_2:* = "";
            if (_arg_1 > 3600)
            {
                _local_2 = ((Math.round((_arg_1 / 3600)) + ClientApplication.Localization.TIME_HOURS) as String);
            }
            else
            {
                if (((((_arg_1 > 60) || (this._statusType == 310)) || (this._statusType == 400)) || (this._statusType == 404)))
                {
                    _local_2 = ((Math.round((_arg_1 / 60)) + ClientApplication.Localization.TIME_MINUTES) as String);
                }
                else
                {
                    _local_2 = ((Math.round(_arg_1) + ClientApplication.Localization.TIME_SECONDS) as String);
                };
            };
            return (_local_2);
        }

        private function UpdateInfoColor():void
        {
            var _local_1:int = int(((this._time / 3600) * 6));
            switch (_local_1)
            {
                case 0:
                    this._infoText.textColor = 0xFF0000;
                    return;
                case 1:
                    this._infoText.textColor = 16727871;
                    return;
                case 2:
                    this._infoText.textColor = 16678012;
                    return;
                case 3:
                    this._infoText.textColor = 16751772;
                    return;
                case 4:
                    this._infoText.textColor = 16502221;
                    return;
                case 5:
                    this._infoText.textColor = 16772846;
                    return;
                default:
                    this._infoText.textColor = 0xFFFFFF;
            };
        }

        private function CheckWarningEffects():void
        {
            var _local_1:int;
            for each (_local_1 in this._rentStatusTypes)
            {
                if (this._statusType == _local_1)
                {
                    this._warningEffects = true;
                };
            };
        }


    }
}//package hbm.Game.Renderer

