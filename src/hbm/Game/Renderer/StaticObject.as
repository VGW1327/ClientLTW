


//hbm.Game.Renderer.StaticObject

package hbm.Game.Renderer
{
    import hbm.Engine.Renderer.RenderObject;
    import flash.geom.Point;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Engine.Renderer.Camera;

    public class StaticObject extends RenderObject 
    {

        private static const _defaultPoint:Point = new Point(0, 0);

        private var _objectBitmapData:BitmapData;
        private var _dataName:String = "Unknown object";
        private var _offset:Point;
        private var _drawPosition:Point;
        private var _drawRectangle:Rectangle;
        private var _collidedRectangle:Rectangle;
        private var _currentDrawRectangle:Rectangle;

        public function StaticObject(_arg_1:String, _arg_2:Point, _arg_3:Rectangle, _arg_4:BitmapData)
        {
            this._offset = _arg_2;
            this._dataName = _arg_1;
            this._drawRectangle = _arg_3;
            this._objectBitmapData = _arg_4;
            Position = new Point(0, 0);
            this._drawPosition = new Point(0, 0);
            this._collidedRectangle = new Rectangle();
            this._currentDrawRectangle = new Rectangle(0, 0, this._objectBitmapData.width, this._objectBitmapData.height);
        }

        public function Release():void
        {
            if (this._objectBitmapData != null)
            {
                this._objectBitmapData.dispose();
                this._objectBitmapData = null;
            };
        }

        override public function Draw(_arg_1:Camera, _arg_2:BitmapData):void
        {
            if (this._objectBitmapData == null)
            {
                return;
            };
            var _local_3:Number = _arg_1.TopLeftPoint.x;
            var _local_4:Number = _arg_1.TopLeftPoint.y;
            this._drawPosition.x = (Position.x - _local_3);
            this._drawPosition.y = (Position.y - _local_4);
            if (((this._drawPosition.x > _arg_2.width) || ((this._drawPosition.x + this._currentDrawRectangle.width) <= 0)))
            {
                return;
            };
            if (((this._drawPosition.y > _arg_2.height) || ((this._drawPosition.y + this._currentDrawRectangle.height) <= 0)))
            {
                return;
            };
            this._collidedRectangle.x = this._drawPosition.x;
            this._collidedRectangle.y = this._drawPosition.y;
            this._collidedRectangle.width = this._currentDrawRectangle.width;
            this._collidedRectangle.height = this._currentDrawRectangle.height;
            var _local_5:Boolean = CharacterStorage.Instance.IsCharacterIntersected(this._collidedRectangle);
            if (!_local_5)
            {
                return;
            };
            _arg_2.copyPixels(this._objectBitmapData, this._currentDrawRectangle, this._drawPosition, this._objectBitmapData, _defaultPoint, true);
        }


    }
}//package hbm.Game.Renderer

