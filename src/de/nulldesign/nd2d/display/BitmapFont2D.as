


//de.nulldesign.nd2d.display.BitmapFont2D

package de.nulldesign.nd2d.display
{
    import de.nulldesign.nd2d.materials.texture.SpriteSheet;
    import de.nulldesign.nd2d.materials.texture.Texture2D;
    import flashx.textLayout.formats.TextAlign;

    public class BitmapFont2D extends Sprite2DCloud 
    {

        private var charString:String;
        private var charSpacing:Number;
        private var textChanged:Boolean = false;
        private var _text:String;
        private var _textAlign:String = "left";

        public function BitmapFont2D(_arg_1:Texture2D, _arg_2:Number, _arg_3:Number, _arg_4:String, _arg_5:Number, _arg_6:uint, _arg_7:Boolean=false)
        {
            this.charString = _arg_4;
            this.charSpacing = _arg_5;
            super(_arg_6, _arg_1);
            setSpriteSheet(new SpriteSheet(_arg_1.bitmapWidth, _arg_1.bitmapHeight, _arg_2, _arg_3, 1, _arg_7));
        }

        public function get text():String
        {
            return (this._text);
        }

        public function set text(_arg_1:String):void
        {
            if (this.text != _arg_1)
            {
                this._text = _arg_1;
                this.textChanged = true;
            };
        }

        public function get textAlign():String
        {
            return (this._textAlign);
        }

        public function set textAlign(_arg_1:String):void
        {
            this._textAlign = _arg_1;
            this.textChanged = true;
        }

        override protected function step(_arg_1:Number):void
        {
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:Sprite2D;
            var _local_5:String;
            var _local_6:int;
            var _local_7:uint;
            var _local_8:Number;
            var _local_9:int;
            if (this.textChanged)
            {
                this.textChanged = false;
                _local_2 = (this.text.split(" ").length - 1);
                _local_3 = (this.text.length - _local_2);
                while (((numChildren < maxCapacity) && (numChildren < _local_3)))
                {
                    addChild(new Sprite2D());
                };
                while (numChildren > _local_3)
                {
                    removeChildAt(0);
                };
                _local_7 = 0;
                _local_8 = (spriteSheet.spriteWidth >> 1);
                switch (this.textAlign)
                {
                    case TextAlign.CENTER:
                        _local_8 = (_local_8 - ((this.text.length * spriteSheet.spriteWidth) >> 1));
                        break;
                    case TextAlign.RIGHT:
                        _local_8 = (_local_8 + -(this.text.length * spriteSheet.spriteWidth));
                        break;
                };
                _local_9 = 0;
                while (_local_9 < this.text.length)
                {
                    _local_5 = this.text.charAt(_local_9);
                    _local_6 = Math.max(0, this.charString.indexOf(_local_5));
                    _local_4 = Sprite2D(children[_local_7]);
                    _local_4.spriteSheet.frame = _local_6;
                    _local_4.x = (_local_8 + (this.charSpacing * _local_9));
                    _local_4.y = 0;
                    if (_local_5 != " ")
                    {
                        _local_7++;
                    };
                    _local_9++;
                };
                _width = (_local_4.x + spriteSheet.spriteWidth);
                _height = spriteSheet.spriteHeight;
            };
        }


    }
}//package de.nulldesign.nd2d.display

