


//de.nulldesign.nd2d.utils.TextureHelper

package de.nulldesign.nd2d.utils
{
    import flash.geom.Point;
    import flash.display.BitmapData;
    import flash.display3D.Context3DTextureFormat;
    import flash.display3D.textures.Texture;
    import flash.display3D.Context3D;
    import flash.utils.ByteArray;
    import flash.geom.Rectangle;
    import flash.geom.Matrix;
    import de.nulldesign.nd2d.geom.UV;
    import de.nulldesign.nd2d.geom.Vertex;
    import de.nulldesign.nd2d.geom.Face;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class TextureHelper 
    {


        public static function getTextureDimensionsFromSize(_arg_1:Number, _arg_2:Number):Point
        {
            var _local_3:Number = 2;
            var _local_4:Number = 2;
            while (_local_3 < _arg_1)
            {
                _local_3 = (_local_3 << 1);
            };
            while (_local_4 < _arg_2)
            {
                _local_4 = (_local_4 << 1);
            };
            return (new Point(_local_3, _local_4));
        }

        public static function getTextureDimensionsFromBitmap(_arg_1:BitmapData):Point
        {
            return (getTextureDimensionsFromSize(_arg_1.width, _arg_1.height));
        }

        public static function generateTextureFromByteArray(_arg_1:Context3D, _arg_2:ByteArray):Texture
        {
            var _local_3:int = Math.pow(2, _arg_2[7]);
            var _local_4:int = Math.pow(2, _arg_2[8]);
            var _local_5:String = ((_arg_2[6] == 2) ? Context3DTextureFormat.COMPRESSED : Context3DTextureFormat.BGRA);
            var _local_6:Texture = _arg_1.createTexture(_local_3, _local_4, _local_5, false);
            _local_6.uploadCompressedTextureFromByteArray(_arg_2, 0, false);
            return (_local_6);
        }

        public static function generateTextureFromBitmap(_arg_1:Context3D, _arg_2:BitmapData, _arg_3:Boolean):Texture
        {
            var _local_6:Rectangle;
            var _local_7:Point;
            var _local_4:Point = getTextureDimensionsFromBitmap(_arg_2);
            var _local_5:BitmapData = new BitmapData(_local_4.x, _local_4.y, true, 0);
            _local_6 = new Rectangle(0, 0, _arg_2.width, _arg_2.height);
            _local_7 = new Point(((_local_4.x * 0.5) - (_arg_2.width * 0.5)), ((_local_4.y * 0.5) - (_arg_2.height * 0.5)));
            _local_5.copyPixels(_arg_2, _local_6, _local_7);
            var _local_8:Texture = _arg_1.createTexture(_local_4.x, _local_4.y, Context3DTextureFormat.BGRA, false);
            if (_arg_3)
            {
                uploadTextureWithMipmaps(_local_8, _local_5);
            }
            else
            {
                _local_8.uploadFromBitmapData(_local_5);
            };
            return (_local_8);
        }

        public static function uploadTextureWithMipmaps(_arg_1:Texture, _arg_2:BitmapData):void
        {
            var _local_3:int = _arg_2.width;
            var _local_4:int = _arg_2.height;
            var _local_5:int;
            var _local_6:BitmapData = new BitmapData(_arg_2.width, _arg_2.height, true, 0);
            var _local_7:Matrix = new Matrix();
            while (((_local_3 >= 1) || (_local_4 >= 1)))
            {
                _local_6.fillRect(_local_6.rect, 0);
                _local_6.draw(_arg_2, _local_7, null, null, null, true);
                _arg_1.uploadFromBitmapData(_local_6, _local_5);
                _local_7.scale(0.5, 0.5);
                _local_5++;
                _local_3 = (_local_3 >> 1);
                _local_4 = (_local_4 >> 1);
            };
            _local_6.dispose();
        }

        public static function generateQuadFromDimensions(_arg_1:Number, _arg_2:Number):Vector.<Face>
        {
            var _local_6:UV;
            var _local_7:UV;
            var _local_8:UV;
            var _local_9:UV;
            var _local_10:Vertex;
            var _local_11:Vertex;
            var _local_12:Vertex;
            var _local_13:Vertex;
            var _local_3:Vector.<Face> = new Vector.<Face>(2, true);
            var _local_4:Number = (_arg_1 * 0.5);
            var _local_5:Number = (_arg_2 * 0.5);
            _local_6 = new UV(0, 0);
            _local_7 = new UV(1, 0);
            _local_8 = new UV(1, 1);
            _local_9 = new UV(0, 1);
            _local_10 = new Vertex(-(_local_4), -(_local_5), 0);
            _local_11 = new Vertex(_local_4, -(_local_5), 0);
            _local_12 = new Vertex(_local_4, _local_5, 0);
            _local_13 = new Vertex(-(_local_4), _local_5, 0);
            _local_3[0] = new Face(_local_10, _local_11, _local_12, _local_6, _local_7, _local_8);
            _local_3[1] = new Face(_local_10, _local_12, _local_13, _local_6, _local_8, _local_9);
            return (_local_3);
        }


    }
}//package de.nulldesign.nd2d.utils

