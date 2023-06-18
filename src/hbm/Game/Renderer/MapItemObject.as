


//hbm.Game.Renderer.MapItemObject

package hbm.Game.Renderer
{
    import hbm.Engine.Renderer.RenderObject;
    import flash.geom.Point;
    import flash.filters.GlowFilter;
    import flash.filters.BitmapFilterQuality;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import flash.text.TextField;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Engine.Renderer.RenderSystem;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Application.ClientApplication;
    import hbm.Game.Utility.HtmlText;
    import flash.text.TextFieldAutoSize;
    import flash.text.AntiAliasType;
    import flash.text.GridFitType;
    import flash.display.Bitmap;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Renderer.Camera;
    import flash.geom.Matrix;

    public class MapItemObject extends RenderObject 
    {

        private static var _nullPoint:Point = new Point(0, 0);
        private static const _correctionPoint:Point = new Point(5, 5);
        private static var _glowFilter:GlowFilter = new GlowFilter(16771148, 0.9, 10, 10, 2, BitmapFilterQuality.LOW);

        private var _resourceName:String = null;
        private var _drawRectangle:Rectangle = null;
        private var _objectBitmapData:BitmapData = null;
        private var _subX:int;
        private var _subY:int;
        private var _itemId:int;
        private var _nameId:int;
        private var _amount:int;
        private var _positionX:int;
        private var _positionY:int;
        private var _identifyFlag:int;
        private var _internalPosition:Point;
        private var _infoText:TextField;
        private var _lastDrawRect:Rectangle = null;

        public function MapItemObject(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:int)
        {
            var _local_9:ItemsResourceLibrary;
            super();
            this._subX = _arg_6;
            this._subY = _arg_7;
            this._itemId = _arg_1;
            this._nameId = _arg_2;
            this._amount = _arg_8;
            this._positionX = _arg_4;
            this._positionY = _arg_5;
            this._identifyFlag = _arg_3;
            this._internalPosition = new Point(_arg_4, _arg_5);
            Position = new Point(((_arg_4 * CharacterStorage.CELL_SIZE) + this._subX), ((RenderSystem.Instance.MainCamera.MaxHeight - (_arg_5 * CharacterStorage.CELL_SIZE)) - this._subY));
            Priority = Position.y;
            this._lastDrawRect = new Rectangle();
            this._resourceName = "AdditionalData_Item_lootType";
            _local_9 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            var _local_10:Object = _local_9.GetServerDescriptionObject(_arg_2);
            var _local_11:int = 3;
            if (_local_10)
            {
                _local_11 = _local_10["type"];
            };
            var _local_12:* = "Unknown";
            switch (_local_11)
            {
                case 0:
                    _local_12 = ClientApplication.Localization.MAP_ITEM_POTION;
                    this._resourceName = "AdditionalData_Item_lootType0";
                    break;
                case 2:
                    _local_12 = ClientApplication.Localization.MAP_ITEM_USABLE;
                    this._resourceName = "AdditionalData_Item_lootType2";
                    break;
                case 4:
                    _local_12 = ClientApplication.Localization.MAP_ITEM_WEAPON;
                    this._resourceName = "AdditionalData_Item_lootType4";
                    break;
                case 5:
                    _local_12 = ClientApplication.Localization.MAP_ITEM_ARMOR;
                    this._resourceName = "AdditionalData_Item_lootType5";
                    break;
                case 6:
                    _local_12 = ClientApplication.Localization.MAP_ITEM_RUNE;
                    this._resourceName = "AdditionalData_Item_lootType6";
                    break;
                case 3:
                    if (_arg_2 == 1065)
                    {
                        _local_12 = ClientApplication.Localization.MAP_ITEM_TRAP;
                    }
                    else
                    {
                        _local_12 = ClientApplication.Localization.MAP_ITEM_OTHER;
                    };
                    this._resourceName = "AdditionalData_Item_lootType";
                    break;
                default:
                    _local_12 = ClientApplication.Localization.MAP_ITEM_OTHER;
                    this._resourceName = "AdditionalData_Item_lootType";
            };
            this._infoText = new TextField();
            this._infoText.x = 511;
            this._infoText.y = 150;
            this._infoText.textColor = 0xCCCCCC;
            if (_arg_8 > 1)
            {
                this._infoText.htmlText = HtmlText.update(((_local_12 + " x ") + _arg_8));
            }
            else
            {
                this._infoText.htmlText = HtmlText.update(_local_12);
            };
            this._infoText.autoSize = TextFieldAutoSize.LEFT;
            this._infoText.antiAliasType = AntiAliasType.ADVANCED;
            this._infoText.gridFitType = GridFitType.PIXEL;
            this._infoText.sharpness = -400;
            this._infoText.selectable = false;
            this._infoText.filters = [HtmlText.glow];
        }

        public function get InternalPosition():Point
        {
            return (this._internalPosition);
        }

        public function get ItemId():int
        {
            return (this._itemId);
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
            var _local_8:Bitmap;
            var _local_9:Rectangle;
            var _local_10:BitmapData;
            var _local_11:BitmapData;
            var _local_12:Point;
            if (this._objectBitmapData == null)
            {
                _local_8 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetBitmapAsset(this._resourceName);
                if (_local_8 != null)
                {
                    this._objectBitmapData = _local_8.bitmapData;
                    this._drawRectangle = new Rectangle(0, 0, this._objectBitmapData.width, this._objectBitmapData.height);
                };
            };
            if (((this._objectBitmapData == null) || (this._drawRectangle == null)))
            {
                return;
            };
            _local_3 = _arg_1.TopLeftPoint.x;
            _local_4 = _arg_1.TopLeftPoint.y;
            var _local_5:Point = new Point((Position.x - _local_3), (Position.y - _local_4));
            var _local_6:Boolean = CharacterStorage.Instance.IsEnableObjectsGlow;
            var _local_7:Boolean = this.IsCollided(CharacterStorage.Instance.LastPointerPosition);
            if (((_local_6) && (_local_7)))
            {
                _local_9 = new Rectangle(0, 0, (this._drawRectangle.width + 10), (this._drawRectangle.height + 10));
                _local_10 = new BitmapData(_local_9.width, _local_9.height, true, 0);
                _local_11 = new BitmapData(_local_9.width, _local_9.height, true, 0);
                _local_11.copyPixels(this._objectBitmapData, this._drawRectangle, _correctionPoint, this._objectBitmapData, this._drawRectangle.topLeft, true);
                _local_10.applyFilter(_local_11, _local_9, _nullPoint, _glowFilter);
                _local_12 = _local_5.clone();
                _local_12.offset(-5, -5);
                _arg_2.copyPixels(_local_10, _local_9, _local_12, _local_10, _nullPoint, true);
            }
            else
            {
                _arg_2.copyPixels(this._objectBitmapData, this._drawRectangle, _local_5, this._objectBitmapData, _nullPoint, true);
            };
            this._lastDrawRect.x = _local_5.x;
            this._lastDrawRect.y = _local_5.y;
            this._lastDrawRect.width = this._drawRectangle.width;
            this._lastDrawRect.height = this._drawRectangle.height;
            if (_local_7)
            {
                this.DrawInfo(_arg_1, _arg_2);
            };
        }

        public function DrawInfo(_arg_1:Camera, _arg_2:BitmapData):void
        {
            var _local_3:Matrix = new Matrix();
            _local_3.tx = ((this._lastDrawRect.x + (this._lastDrawRect.width / 2)) - (this._infoText.width / 2));
            _local_3.ty = ((this._lastDrawRect.y + this._lastDrawRect.height) - 5);
            this._infoText.textColor = 4106125;
            _arg_2.draw(this._infoText, _local_3);
        }


    }
}//package hbm.Game.Renderer

