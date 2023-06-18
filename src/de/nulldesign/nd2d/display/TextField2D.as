


//de.nulldesign.nd2d.display.TextField2D

package de.nulldesign.nd2d.display
{
    import flash.text.TextField;
    import de.nulldesign.nd2d.materials.texture.Texture2D;
    import flash.display.BitmapData;
    import flash.text.TextFormat;
    import flash.geom.Point;
    import flash.text.TextFormatAlign;
    import flash.text.TextFieldType;

    public class TextField2D extends Sprite2D 
    {

        protected var _nativeTextField:TextField = new TextField();
        protected var _textTexture:Texture2D;
        protected var _textBitmapData:BitmapData = new BitmapData(1, 1, true, 0);
        protected var _textFormat:TextFormat = new TextFormat();
        protected var _type:String = "dynamic";
        protected var _autoSize:String = "left";
        protected var _text:String = "";
        protected var _textColor:uint = 0xFFFFFF;
        protected var _textWidth:Number = 0;
        protected var _textHeight:Number = 0;
        protected var _border:Boolean = false;
        protected var _borderColor:uint = 0xFFFFFF;
        protected var _borderPadding:int = 1;
        protected var _background:Boolean = false;
        protected var _backgroundColor:uint = 0x888888;
        protected var _thickness:Number = 0;
        protected var _sharpness:Number = 0;
        protected var _gridFitType:String = "none";
        protected var _antiAliasType:String = "normal";
        protected var _autoWrap:Boolean = true;
        protected var _wordWrap:Boolean = false;
        protected var _embedFonts:Boolean = false;
        protected var _condenseWhite:Boolean = false;
        protected var _needsRedraw:Boolean = true;

        public function TextField2D()
        {
            super(Texture2D.textureFromBitmapData(this._textBitmapData));
        }

        public function get length():int
        {
            return (this._text.length);
        }

        public function get textFormat():TextFormat
        {
            return (this._textFormat);
        }

        public function set textFormat(_arg_1:TextFormat):void
        {
            this._textColor = ((_arg_1.color) ? uint(_arg_1.color) : this._textColor);
            this._textFormat = _arg_1;
            this._needsRedraw = true;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function set type(_arg_1:String):void
        {
            this._type = _arg_1;
            this._needsRedraw = true;
        }

        public function get autoSize():String
        {
            return (this._autoSize);
        }

        public function set autoSize(_arg_1:String):void
        {
            this._autoSize = _arg_1;
            this._needsRedraw = true;
        }

        public function get text():String
        {
            return (this._text);
        }

        public function set text(_arg_1:String):void
        {
            this._text = _arg_1;
            this._needsRedraw = true;
        }

        public function get textColor():uint
        {
            return (this._textColor);
        }

        public function set textColor(_arg_1:uint):void
        {
            this._textColor = _arg_1;
            this._needsRedraw = true;
        }

        public function get textWidth():int
        {
            return (this._textWidth);
        }

        public function set textWidth(_arg_1:int):void
        {
            this._textWidth = Math.max(0, _arg_1);
            if (this._autoWrap)
            {
                this._wordWrap = (this._textWidth > 0);
            };
            this._needsRedraw = true;
        }

        public function get textHeight():int
        {
            return (this._textHeight);
        }

        public function set textHeight(_arg_1:int):void
        {
            this._textHeight = Math.max(0, _arg_1);
            this._needsRedraw = true;
        }

        public function get border():Boolean
        {
            return (this._border);
        }

        public function set border(_arg_1:Boolean):void
        {
            this._border = _arg_1;
            this._needsRedraw = true;
        }

        public function get borderColor():uint
        {
            return (this._borderColor);
        }

        public function set borderColor(_arg_1:uint):void
        {
            this._borderColor = _arg_1;
            this._needsRedraw = true;
        }

        public function get background():Boolean
        {
            return (this._background);
        }

        public function set background(_arg_1:Boolean):void
        {
            this._background = _arg_1;
            this._needsRedraw = true;
        }

        public function get backgroundColor():uint
        {
            return (this._backgroundColor);
        }

        public function set backgroundColor(_arg_1:uint):void
        {
            this._backgroundColor = _arg_1;
            this._needsRedraw = true;
        }

        public function get wordWrap():Boolean
        {
            return (this._wordWrap);
        }

        public function set wordWrap(_arg_1:Boolean):void
        {
            this._wordWrap = _arg_1;
            this._needsRedraw = true;
        }

        public function get embedFonts():Boolean
        {
            return (this._embedFonts);
        }

        public function set embedFonts(_arg_1:Boolean):void
        {
            this._embedFonts = _arg_1;
            this._needsRedraw = true;
        }

        public function get condenseWhite():Boolean
        {
            return (this._condenseWhite);
        }

        public function set condenseWhite(_arg_1:Boolean):void
        {
            this._condenseWhite = _arg_1;
            this._needsRedraw = true;
        }

        public function get font():String
        {
            return (this._textFormat.font);
        }

        public function set font(_arg_1:String):void
        {
            this._textFormat.font = _arg_1;
            this._needsRedraw = true;
        }

        public function get size():Object
        {
            return (this._textFormat.size);
        }

        public function set size(_arg_1:Object):void
        {
            this._textFormat.size = _arg_1;
            this._needsRedraw = true;
        }

        public function get align():String
        {
            return (this._textFormat.align);
        }

        public function set align(_arg_1:String):void
        {
            this._textFormat.align = _arg_1;
            this._needsRedraw = true;
        }

        public function get bold():Boolean
        {
            return (this._textFormat.bold);
        }

        public function set bold(_arg_1:Boolean):void
        {
            this._textFormat.bold = _arg_1;
            this._needsRedraw = true;
        }

        public function get italic():Boolean
        {
            return (this._textFormat.italic);
        }

        public function set italic(_arg_1:Boolean):void
        {
            this._textFormat.italic = _arg_1;
            this._needsRedraw = true;
        }

        public function get underline():Boolean
        {
            return (this._textFormat.underline);
        }

        public function set underline(_arg_1:Boolean):void
        {
            this._textFormat.underline = _arg_1;
            this._needsRedraw = true;
        }

        protected function redraw():void
        {
            this._nativeTextField.defaultTextFormat = this._textFormat;
            this._nativeTextField.htmlText = this._text;
            this._nativeTextField.textColor = this._textColor;
            this._nativeTextField.border = this._border;
            this._nativeTextField.borderColor = this._borderColor;
            this._nativeTextField.background = this._background;
            this._nativeTextField.backgroundColor = this._backgroundColor;
            this._nativeTextField.thickness = this._thickness;
            this._nativeTextField.sharpness = this._sharpness;
            this._nativeTextField.gridFitType = this._gridFitType;
            this._nativeTextField.antiAliasType = this._antiAliasType;
            this._nativeTextField.type = this._type;
            this._nativeTextField.autoSize = this._autoSize;
            this._nativeTextField.wordWrap = this._wordWrap;
            this._nativeTextField.embedFonts = this._embedFonts;
            this._nativeTextField.condenseWhite = this._condenseWhite;
            this._nativeTextField.width = ((this._textWidth > 0) ? this._textWidth : this._nativeTextField.textWidth);
            this._nativeTextField.height = ((this._textHeight > 0) ? this._textHeight : this._nativeTextField.textHeight);
            switch (this._type)
            {
                case TextFieldType.DYNAMIC:
                    this._textBitmapData = new BitmapData((this._nativeTextField.width + this._borderPadding), (this._nativeTextField.height + this._borderPadding), true, 0);
                    this._textBitmapData.draw(this._nativeTextField);
                    this._textTexture = Texture2D.textureFromBitmapData(this._textBitmapData);
                    setTexture(this._textTexture);
                    switch (this.align)
                    {
                        case TextFormatAlign.LEFT:
                            pivot = new Point(int((-(this._nativeTextField.width) / 2)), 0);
                            break;
                        case TextFormatAlign.CENTER:
                            pivot = new Point(0, 0);
                            break;
                        case TextFormatAlign.RIGHT:
                            pivot = new Point(int((this._nativeTextField.width / 2)), 0);
                            break;
                    };
                    return;
                case TextFieldType.INPUT:
                    return;
                default:
                    throw (new Error("The type specified is not a member of flash.text.TextFieldType"));
            };
        }

        override protected function step(_arg_1:Number):void
        {
            if (this._needsRedraw)
            {
                this.redraw();
                this._needsRedraw = false;
            };
            super.step(_arg_1);
        }

        override public function dispose():void
        {
            this._textTexture.dispose();
            this._textTexture = null;
            this._textBitmapData.dispose();
            this._textBitmapData = null;
            this._textFormat = null;
            super.dispose();
        }


    }
}//package de.nulldesign.nd2d.display

