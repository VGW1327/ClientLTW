


//hbm.Game.Renderer.CharacterAnimationFrame

package hbm.Game.Renderer
{
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class CharacterAnimationFrame 
    {

        private var _textureIndex:int = -1;
        private var _hotSpot:Point = new Point(0, 0);
        private var _centerOffset:Point = new Point(0, 0);
        private var _textureFrame:Rectangle = new Rectangle(0, 0, 0, 0);

        public function CharacterAnimationFrame(_arg_1:Point, _arg_2:Point, _arg_3:int, _arg_4:Rectangle)
        {
            this._hotSpot = _arg_2;
            this._centerOffset = _arg_1;
            this._textureIndex = _arg_3;
            this._textureFrame = _arg_4;
        }

        public function get HotSpot():Point
        {
            return (this._hotSpot);
        }

        public function get CenterOffset():Point
        {
            return (this._centerOffset);
        }

        public function get TextureFrame():Rectangle
        {
            return (this._textureFrame);
        }

        public function get TextureIndex():int
        {
            return (this._textureIndex);
        }

        public function set HotSpot(_arg_1:Point):void
        {
            this._hotSpot = _arg_1;
        }

        public function set CenterOffset(_arg_1:Point):void
        {
            this._centerOffset = _arg_1;
        }

        public function set TextureFrame(_arg_1:Rectangle):void
        {
            this._textureFrame = _arg_1;
        }

        public function set TextureIndex(_arg_1:int):void
        {
            this._textureIndex = _arg_1;
        }


    }
}//package hbm.Game.Renderer

