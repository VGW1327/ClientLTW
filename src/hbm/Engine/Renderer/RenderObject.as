


//hbm.Engine.Renderer.RenderObject

package hbm.Engine.Renderer
{
    import flash.geom.Point;
    import flash.display.BitmapData;

    public class RenderObject 
    {

        private var _priority:uint = 100;
        private var _isVisible:Boolean = true;
        private var _position:Point = new Point(0, 0);


        public function get Position():Point
        {
            return (this._position);
        }

        public function set Position(_arg_1:Point):void
        {
            this._position = _arg_1;
        }

        public function get X():Number
        {
            return (this._position.x);
        }

        public function get Y():Number
        {
            return (this._position.y);
        }

        public function get IsVisible():Boolean
        {
            return (this._isVisible);
        }

        public function Show():void
        {
            this._isVisible = true;
        }

        public function Hide():void
        {
            this._isVisible = false;
        }

        public function Draw(_arg_1:Camera, _arg_2:BitmapData):void
        {
        }

        public function get Priority():uint
        {
            return (this._priority);
        }

        public function set Priority(_arg_1:uint):void
        {
            this._priority = _arg_1;
        }


    }
}//package hbm.Engine.Renderer

