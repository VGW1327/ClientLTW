


//hbm.Game.Renderer.SkillUnitObject

package hbm.Game.Renderer
{
    import hbm.Engine.Renderer.RenderObject;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.text.TextField;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Engine.Renderer.RenderSystem;
    import flash.display.Bitmap;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Renderer.Camera;

    public class SkillUnitObject extends RenderObject 
    {

        private var _resourceName:String = null;
        private var _drawRectangle:Rectangle = null;
        private var _objectBitmapData:BitmapData = null;
        private var _statusType:int;
        private var _nullPoint:Point;
        private var _infoText:TextField;
        private var _lastDrawRect:Rectangle = null;

        public function SkillUnitObject(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String)
        {
            this._statusType = _arg_3;
            Position = new Point(((_arg_1 - 1) * CharacterStorage.CELL_SIZE), (RenderSystem.Instance.MainCamera.MaxHeight - ((_arg_2 + 1) * CharacterStorage.CELL_SIZE)));
            Priority = Position.y;
            this._nullPoint = new Point(0, 0);
            this._lastDrawRect = new Rectangle();
            this._resourceName = _arg_4;
        }

        public function get StatusType():int
        {
            return (this._statusType);
        }

        public function IsCollided(_arg_1:Point):Boolean
        {
            var _local_2:Boolean;
            if (this._lastDrawRect != null)
            {
                _local_2 = this._lastDrawRect.containsPoint(_arg_1);
            };
            return (_local_2);
        }

        override public function Draw(_arg_1:Camera, _arg_2:BitmapData):void
        {
            var _local_3:Number;
            var _local_4:Number;
            var _local_6:Bitmap;
            if (this._objectBitmapData == null)
            {
                _local_6 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetBitmapAsset(this._resourceName);
                if (_local_6 == null)
                {
                    return;
                };
                this._objectBitmapData = _local_6.bitmapData;
                this._drawRectangle = new Rectangle(0, 0, this._objectBitmapData.width, this._objectBitmapData.height);
                Priority = (Priority + ((this._objectBitmapData.height / 2) + 10));
            };
            if (((this._objectBitmapData == null) || (this._drawRectangle == null)))
            {
                return;
            };
            _local_3 = _arg_1.TopLeftPoint.x;
            _local_4 = _arg_1.TopLeftPoint.y;
            var _local_5:Point = new Point((Position.x - _local_3), (Position.y - _local_4));
            _arg_2.copyPixels(this._objectBitmapData, this._drawRectangle, _local_5, this._objectBitmapData, this._nullPoint, true);
            this._lastDrawRect.x = _local_5.x;
            this._lastDrawRect.y = _local_5.y;
            this._lastDrawRect.width = this._drawRectangle.width;
            this._lastDrawRect.height = this._drawRectangle.height;
        }


    }
}//package hbm.Game.Renderer

