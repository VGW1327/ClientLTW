


//de.nulldesign.nd2d.materials.texture.SpriteSheetAnimation

package de.nulldesign.nd2d.materials.texture
{
    public class SpriteSheetAnimation 
    {

        public var loop:Boolean;
        public var frames:Array;
        public var numFrames:uint;

        public function SpriteSheetAnimation(_arg_1:Array, _arg_2:Boolean)
        {
            this.loop = _arg_2;
            this.frames = _arg_1;
            this.numFrames = _arg_1.length;
        }

    }
}//package de.nulldesign.nd2d.materials.texture

