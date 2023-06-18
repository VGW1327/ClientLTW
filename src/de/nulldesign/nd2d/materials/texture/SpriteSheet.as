


//de.nulldesign.nd2d.materials.texture.SpriteSheet

package de.nulldesign.nd2d.materials.texture
{
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import de.nulldesign.nd2d.materials.*;
    import __AS3__.vec.*;

    public class SpriteSheet extends ASpriteSheetBase 
    {

        private var nullOffset:Point = new Point();

        public function SpriteSheet(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number, _arg_5:uint, _arg_6:Boolean=false)
        {
            this.fps = _arg_5;
            this.spritesPackedWithoutSpace = _arg_6;
            _spriteWidth = _arg_3;
            _spriteHeight = _arg_4;
            _sheetWidth = _arg_1;
            _sheetHeight = _arg_2;
            this.generateSheet();
        }

        private function generateSheet():void
        {
            var _local_4:uint;
            var _local_5:uint;
            var _local_1:int = int(Math.round((_sheetWidth / spriteWidth)));
            var _local_2:int = int(Math.round((_sheetHeight / spriteHeight)));
            var _local_3:int = (_local_1 * _local_2);
            uvRects = new Vector.<Rectangle>(_local_3, true);
            frames = new Vector.<Rectangle>();
            uvRects = new Vector.<Rectangle>(_local_3, true);
            var _local_6:int;
            while (_local_6 < _local_3)
            {
                _local_4 = (_local_6 % _local_1);
                _local_5 = uint(Math.floor((_local_6 / _local_1)));
                frames.push(new Rectangle((spriteWidth * _local_4), (spriteHeight * _local_5), _spriteWidth, _spriteHeight));
                _local_6++;
            };
            frame = 0;
        }

        override public function addAnimation(_arg_1:String, _arg_2:Array, _arg_3:Boolean):void
        {
            animationMap[_arg_1] = new SpriteSheetAnimation(_arg_2, _arg_3);
        }

        override public function getOffsetForFrame():Point
        {
            return (this.nullOffset);
        }

        override public function clone():ASpriteSheetBase
        {
            var _local_2:String;
            var _local_3:SpriteSheetAnimation;
            var _local_1:SpriteSheet = new SpriteSheet(_sheetWidth, _sheetHeight, _spriteWidth, _spriteHeight, fps, spritesPackedWithoutSpace);
            for (_local_2 in animationMap)
            {
                _local_3 = animationMap[_local_2];
                _local_1.addAnimation(_local_2, _local_3.frames.concat(), _local_3.loop);
            };
            _local_1.frame = frame;
            return (_local_1);
        }


    }
}//package de.nulldesign.nd2d.materials.texture

