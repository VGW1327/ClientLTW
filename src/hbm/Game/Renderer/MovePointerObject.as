


//hbm.Game.Renderer.MovePointerObject

package hbm.Game.Renderer
{
    import hbm.Engine.Renderer.RenderObject;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import hbm.Engine.Utility.Vector2D;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Engine.Renderer.Camera;

    public class MovePointerObject extends RenderObject 
    {

        private var _nullPoint:Point;
        private var _currentPosition:Point;
        private var _topLeftDrawPosition:Point;
        private var _noMoveDrawRectangle:Rectangle;
        private var _aoeSkillDrawRectangle:Rectangle;
        private var _noMoveObjectBitmapData:BitmapData;
        private var _aoeSkillObjectBitmapData:BitmapData;
        private var _noMoveCursorResourceName:String;
        private var _aoeSkillCursorResourceName:String;

        public function MovePointerObject()
        {
            Priority = 1;
            Position = new Point(300, 300);
            this._nullPoint = new Point(0, 0);
            this._currentPosition = new Point(0, 0);
            this._topLeftDrawPosition = new Point(0, 0);
            this._noMoveCursorResourceName = "AdditionalData_Item_NoMovePointer";
            this._aoeSkillCursorResourceName = "AdditionalData_Item_AoeSkillPointer";
        }

        override public function Draw(_arg_1:Camera, _arg_2:BitmapData):void
        {
            var _local_5:Bitmap;
            var _local_6:Bitmap;
            var _local_7:Vector2D;
            var _local_8:Number;
            if (this._noMoveObjectBitmapData == null)
            {
                _local_5 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetBitmapAsset(this._noMoveCursorResourceName);
                if (_local_5 != null)
                {
                    this._noMoveObjectBitmapData = _local_5.bitmapData;
                    this._noMoveDrawRectangle = new Rectangle(0, 0, this._noMoveObjectBitmapData.width, this._noMoveObjectBitmapData.height);
                };
            };
            if (this._aoeSkillObjectBitmapData == null)
            {
                _local_6 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetBitmapAsset(this._aoeSkillCursorResourceName);
                if (_local_5 != null)
                {
                    this._aoeSkillObjectBitmapData = _local_6.bitmapData;
                    this._aoeSkillDrawRectangle = new Rectangle(0, 0, this._aoeSkillObjectBitmapData.width, this._aoeSkillObjectBitmapData.height);
                };
            };
            if (((((this._noMoveObjectBitmapData == null) || (this._aoeSkillObjectBitmapData == null)) || (this._noMoveDrawRectangle == null)) || (this._aoeSkillDrawRectangle == null)))
            {
                return;
            };
            var _local_3:Point = _arg_1.TopLeftPoint;
            this._currentPosition.x = CharacterStorage.Instance.MovePointerPosition.x;
            this._currentPosition.y = CharacterStorage.Instance.MovePointerPosition.y;
            var _local_4:int = CharacterStorage.Instance.MovePointerCollision;
            if (((CharacterStorage.Instance.SkillMode > 0) && (CharacterStorage.Instance.SkillCharacterId == -1)))
            {
                _local_7 = Vector2D.fromPoint(CharacterStorage.Instance.LocalPlayerCharacter.Position).divide(CharacterStorage.CELL_SIZE);
                _local_8 = Vector2D.distanceSquared(_local_7, Vector2D.fromPoint(this._currentPosition));
                this._currentPosition.x = ((this._currentPosition.x * CharacterStorage.CELL_SIZE) - (this._aoeSkillObjectBitmapData.width / 2));
                this._currentPosition.y = ((this._currentPosition.y * CharacterStorage.CELL_SIZE) + (this._aoeSkillObjectBitmapData.height / 2));
                this._topLeftDrawPosition.x = (this._currentPosition.x - _local_3.x);
                this._topLeftDrawPosition.y = ((_arg_1.MaxHeight - this._currentPosition.y) - _local_3.y);
                if (((!(_local_4 == 0)) || (_local_8 >= (CharacterStorage.Instance.SkillRangeSqr + 2))))
                {
                    _arg_2.copyPixels(this._noMoveObjectBitmapData, this._noMoveDrawRectangle, this._topLeftDrawPosition, this._noMoveObjectBitmapData, this._nullPoint, true);
                }
                else
                {
                    _arg_2.copyPixels(this._aoeSkillObjectBitmapData, this._aoeSkillDrawRectangle, this._topLeftDrawPosition, this._aoeSkillObjectBitmapData, this._nullPoint, true);
                };
            }
            else
            {
                this._currentPosition.x = ((this._currentPosition.x * CharacterStorage.CELL_SIZE) - (this._noMoveObjectBitmapData.width / 2));
                this._currentPosition.y = ((this._currentPosition.y * CharacterStorage.CELL_SIZE) + (this._noMoveObjectBitmapData.height / 2));
                this._topLeftDrawPosition.x = (this._currentPosition.x - _local_3.x);
                this._topLeftDrawPosition.y = ((_arg_1.MaxHeight - this._currentPosition.y) - _local_3.y);
                if (_local_4 != 0)
                {
                    _arg_2.copyPixels(this._noMoveObjectBitmapData, this._noMoveDrawRectangle, this._topLeftDrawPosition, this._noMoveObjectBitmapData, this._nullPoint, true);
                };
            };
        }


    }
}//package hbm.Game.Renderer

