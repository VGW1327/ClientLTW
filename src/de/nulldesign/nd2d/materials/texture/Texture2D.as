


//de.nulldesign.nd2d.materials.texture.Texture2D

package de.nulldesign.nd2d.materials.texture
{
    import flash.display3D.textures.Texture;
    import flash.display.BitmapData;
    import flash.utils.ByteArray;
    import flash.geom.Point;
    import de.nulldesign.nd2d.utils.TextureHelper;
    import flash.display3D.Context3DTextureFormat;
    import flash.display3D.Context3D;

    public class Texture2D 
    {

        private var _textureOptions:uint = TextureOption.QUALITY_ULTRA;
        public var texture:Texture;
        public var bitmap:BitmapData;
        public var compressedBitmap:ByteArray;
        public var bitmapWidth:Number;
        public var bitmapHeight:Number;
        public var textureWidth:Number;
        public var textureHeight:Number;
        public var hasPremultipliedAlpha:Boolean = true;
        public var textureFilteringOptionChanged:Boolean = true;
        protected var autoCleanUpResources:Boolean;

        public function Texture2D(_arg_1:Boolean=false)
        {
            this.autoCleanUpResources = _arg_1;
        }

        public static function textureFromBitmapData(_arg_1:BitmapData, _arg_2:Boolean=false):Texture2D
        {
            var _local_4:Point;
            var _local_3:Texture2D = new Texture2D(_arg_2);
            if (_arg_1)
            {
                _local_3.bitmap = _arg_1;
                _local_3.bitmapWidth = _arg_1.width;
                _local_3.bitmapHeight = _arg_1.height;
                _local_4 = TextureHelper.getTextureDimensionsFromBitmap(_arg_1);
                _local_3.textureWidth = _local_4.x;
                _local_3.textureHeight = _local_4.y;
                _local_3.hasPremultipliedAlpha = true;
            };
            return (_local_3);
        }

        public static function textureFromATF(_arg_1:ByteArray, _arg_2:Boolean=false):Texture2D
        {
            var _local_4:int;
            var _local_5:int;
            var _local_3:Texture2D = new Texture2D(_arg_2);
            if (_arg_1)
            {
                _local_4 = Math.pow(2, _arg_1[7]);
                _local_5 = Math.pow(2, _arg_1[8]);
                _local_3.compressedBitmap = _arg_1;
                _local_3.textureWidth = (_local_3.bitmapWidth = _local_4);
                _local_3.textureHeight = (_local_3.bitmapHeight = _local_5);
                _local_3.hasPremultipliedAlpha = false;
            };
            return (_local_3);
        }

        public static function textureFromSize(_arg_1:uint, _arg_2:uint):Texture2D
        {
            var _local_3:Point = TextureHelper.getTextureDimensionsFromSize(_arg_1, _arg_2);
            var _local_4:Texture2D = new (Texture2D)();
            _local_4.textureWidth = _local_3.x;
            _local_4.textureHeight = _local_3.y;
            _local_4.bitmapWidth = _local_3.x;
            _local_4.bitmapHeight = _local_3.y;
            return (_local_4);
        }


        public function get textureOptions():uint
        {
            return (this._textureOptions);
        }

        public function set textureOptions(_arg_1:uint):void
        {
            if (this._textureOptions != _arg_1)
            {
                this._textureOptions = _arg_1;
                this.textureFilteringOptionChanged = true;
            };
        }

        public function getTexture(_arg_1:Context3D):Texture
        {
            var _local_2:Boolean;
            if (!this.texture)
            {
                if (this.compressedBitmap)
                {
                    this.texture = TextureHelper.generateTextureFromByteArray(_arg_1, this.compressedBitmap);
                }
                else
                {
                    if (this.bitmap)
                    {
                        _local_2 = (((this._textureOptions & TextureOption.MIPMAP_LINEAR) + (this._textureOptions & TextureOption.MIPMAP_NEAREST)) > 0);
                        this.texture = TextureHelper.generateTextureFromBitmap(_arg_1, this.bitmap, _local_2);
                    }
                    else
                    {
                        this.texture = _arg_1.createTexture(this.textureWidth, this.textureHeight, Context3DTextureFormat.BGRA, true);
                    };
                };
                if (this.autoCleanUpResources)
                {
                    if (this.bitmap)
                    {
                        this.bitmap.dispose();
                        this.bitmap = null;
                    };
                    this.compressedBitmap = null;
                };
            };
            return (this.texture);
        }

        public function dispose():void
        {
            if (this.texture)
            {
                this.texture.dispose();
                this.texture = null;
            };
        }


    }
}//package de.nulldesign.nd2d.materials.texture

