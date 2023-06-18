


//de.nulldesign.nd2d.materials.texture.ASpriteSheetBase

package de.nulldesign.nd2d.materials.texture
{
    import __AS3__.vec.Vector;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.utils.Dictionary;
    import __AS3__.vec.*;

    public class ASpriteSheetBase 
    {

        protected var frames:Vector.<Rectangle> = new Vector.<Rectangle>();
        protected var offsets:Vector.<Point> = new Vector.<Point>();
        protected var sourceSizes:Vector.<Point> = new Vector.<Point>();
        protected var sourceColorRects:Vector.<Rectangle> = new Vector.<Rectangle>();
        protected var frameNameToIndex:Dictionary = new Dictionary();
        protected var uvRects:Vector.<Rectangle>;
        protected var spritesPackedWithoutSpace:Boolean;
        protected var ctime:Number = 0;
        protected var otime:Number = 0;
        protected var interp:Number = 0;
        protected var frameIdx:uint = 0;
        protected var activeAnimation:SpriteSheetAnimation;
        protected var animationMap:Dictionary = new Dictionary();
        public var frameUpdated:Boolean = true;
        protected var fps:uint;
        protected var _spriteWidth:Number;
        protected var _spriteHeight:Number;
        protected var _sheetWidth:Number;
        protected var _sheetHeight:Number;
        protected var _frame:uint = 2147483647;


        public function get spriteWidth():Number
        {
            return (this._spriteWidth);
        }

        public function get spriteHeight():Number
        {
            return (this._spriteHeight);
        }

        public function get frame():uint
        {
            return (this._frame);
        }

        public function set frame(_arg_1:uint):void
        {
            if (this.frame != _arg_1)
            {
                this._frame = _arg_1;
                this.frameUpdated = true;
                if ((this.frames.length - 1) >= this._frame)
                {
                    this._spriteWidth = this.frames[this._frame].width;
                    this._spriteHeight = this.frames[this._frame].height;
                };
            };
        }

        public function update(_arg_1:Number):void
        {
            if (!this.activeAnimation)
            {
                return;
            };
            this.ctime = _arg_1;
            this.interp = (this.interp + (this.fps * (this.ctime - this.otime)));
            if (this.interp >= 1)
            {
                this.frameIdx++;
                this.interp = 0;
            };
            if (this.activeAnimation.loop)
            {
                this.frameIdx = (this.frameIdx % this.activeAnimation.numFrames);
            }
            else
            {
                this.frameIdx = Math.min(this.frameIdx, (this.activeAnimation.numFrames - 1));
            };
            this.frame = this.activeAnimation.frames[this.frameIdx];
            this.otime = this.ctime;
        }

        public function playAnimation(_arg_1:String, _arg_2:uint=0, _arg_3:Boolean=false):void
        {
            if (((_arg_3) || (!(this.activeAnimation == this.animationMap[_arg_1]))))
            {
                this.frameIdx = _arg_2;
                this.activeAnimation = this.animationMap[_arg_1];
            };
        }

        public function addAnimation(_arg_1:String, _arg_2:Array, _arg_3:Boolean):void
        {
        }

        public function clone():ASpriteSheetBase
        {
            return (null);
        }

        public function getOffsetForFrame():Point
        {
            return (this.offsets[this.frame]);
        }

        public function getDimensionForFrame():Rectangle
        {
            return (this.frames[this.frame]);
        }

        public function getUVRectForFrame(_arg_1:Number, _arg_2:Number):Rectangle
        {
            if (this.uvRects[this.frame])
            {
                return (this.uvRects[this.frame]);
            };
            var _local_3:Rectangle = this.frames[this.frame].clone();
            var _local_4:Point = new Point(((_arg_1 - this._sheetWidth) / 2), ((_arg_2 - this._sheetHeight) / 2));
            _local_3.x = (_local_3.x + _local_4.x);
            _local_3.y = (_local_3.y + _local_4.y);
            if (this.spritesPackedWithoutSpace)
            {
                _local_3.x = (_local_3.x + 0.5);
                _local_3.y = (_local_3.y + 0.5);
                _local_3.width--;
                _local_3.height--;
            };
            _local_3.x = (_local_3.x / _arg_1);
            _local_3.y = (_local_3.y / _arg_2);
            _local_3.width = (_local_3.width / _arg_1);
            _local_3.height = (_local_3.height / _arg_2);
            this.uvRects[this.frame] = _local_3;
            return (_local_3);
        }


    }
}//package de.nulldesign.nd2d.materials.texture

