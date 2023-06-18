


//hbm.Game.Renderer.FogObject

package hbm.Game.Renderer
{
    import hbm.Engine.Renderer.RenderObject;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Renderer.Camera;

    public class FogObject extends RenderObject 
    {

        private var _nullPoint:Point;
        private var _resourceName:String;
        private var _drawRectangle:Rectangle;
        private var _objectBitmapData:BitmapData;

        public function FogObject()
        {
            Priority = 100000;
            Position = new Point(0, 0);
            this._nullPoint = new Point(0, 0);
            this._resourceName = "AdditionalData_Item_Fog";
        }

        override public function Draw(_arg_1:Camera, _arg_2:BitmapData):void
        {
            var _local_3:Bitmap;
            if (((_arg_2.width > 800) || (_arg_2.height > 600)))
            {
                return;
            };
            if (this._objectBitmapData == null)
            {
                _local_3 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetBitmapAsset(this._resourceName);
                if (_local_3 != null)
                {
                    this._objectBitmapData = _local_3.bitmapData;
                    this._drawRectangle = new Rectangle(0, 0, this._objectBitmapData.width, this._objectBitmapData.height);
                };
            };
            if (((this._objectBitmapData == null) || (this._drawRectangle == null)))
            {
                return;
            };
            _arg_2.copyPixels(this._objectBitmapData, this._drawRectangle, Position, this._objectBitmapData, this._nullPoint, true);
        }


    }
}//package hbm.Game.Renderer

