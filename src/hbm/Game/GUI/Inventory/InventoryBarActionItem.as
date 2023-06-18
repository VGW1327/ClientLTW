


//hbm.Game.GUI.Inventory.InventoryBarActionItem

package hbm.Game.GUI.Inventory
{
    import flash.text.TextField;
    import flash.geom.Matrix;
    import org.aswing.AttachIcon;
    import flash.text.TextFormat;
    import flash.text.TextFormatAlign;
    import flash.text.TextFieldAutoSize;
    import flash.text.AntiAliasType;
    import flash.text.GridFitType;
    import hbm.Game.Utility.HtmlText;
    import hbm.Engine.Actors.ItemData;
    import hbm.Application.ClientApplication;
    import hbm.Game.Character.CharacterStorage;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import org.aswing.AssetIcon;

    public class InventoryBarActionItem extends InventoryItem 
    {

        private var _text:TextField = new TextField();
        private var _matrix:Matrix;
        private var _count:int = 0;
        private var _oldCount:int = -1;
        private var _nameId:int = -1;
        private var _countStr:String = "";
        private var _oldCountStr:String = "";
        private var _icon:AttachIcon;

        public function InventoryBarActionItem(_arg_1:ItemData)
        {
            this._text.x = 0;
            this._text.y = 0;
            this._text.width = 32;
            this._text.textColor = 0xFFFFFF;
            this._text.text = "";
            var _local_2:TextFormat = this._text.defaultTextFormat;
            _local_2.size = 12;
            _local_2.align = TextFormatAlign.CENTER;
            this._text.defaultTextFormat = _local_2;
            this._text.autoSize = TextFieldAutoSize.RIGHT;
            this._text.antiAliasType = AntiAliasType.ADVANCED;
            this._text.gridFitType = GridFitType.PIXEL;
            this._text.sharpness = -400;
            this._text.selectable = false;
            this._text.filters = [HtmlText.glow];
            this._matrix = new Matrix();
            this._matrix.tx = 0;
            this._matrix.ty = 15;
            super(_arg_1);
            this._icon = Icon;
            setDragEnabled(false);
        }

        override public function Revalidate():void
        {
            var _local_1:String;
            if (Item.NameId == 1)
            {
                setToolTipText(ClientApplication.Localization.INVENTORY_ITEM_FIST);
            }
            else
            {
                _local_1 = ((Item.Amount > 1) ? (" x" + Item.Amount.toString()) : "");
                setToolTipText(((Name + " ") + _local_1));
            };
        }

        override protected function OnInventoryButtonPressed(_arg_1:Event):void
        {
            if (ClientApplication.Instance.BottomHUD.InventoryBarInstance.DoCooldownSlot())
            {
                CharacterStorage.Instance.OnStartBaseAttack();
            };
        }

        public function get Count():int
        {
            return (this._count);
        }

        public function get SubNameId():int
        {
            return (this._nameId);
        }

        public function set SoulshotData(_arg_1:ItemData):void
        {
            var _local_2:DisplayObject;
            var _local_3:BitmapData;
            if (!_arg_1)
            {
                return;
            };
            this._oldCount = this._count;
            this._count = _arg_1.Amount;
            if (this._nameId != _arg_1.NameId)
            {
                this._nameId = _arg_1.NameId;
                this._icon = Icon;
            };
            if (this._oldCount != this._count)
            {
                if (this._count > 0)
                {
                    this._countStr = this.convertCount(this._count);
                    if (this._countStr != this._oldCountStr)
                    {
                        this._text.text = this._countStr;
                        this._oldCountStr = this._countStr;
                        _local_2 = this._icon.getAsset();
                        _local_3 = (_local_2 as Bitmap).bitmapData;
                        _local_3.draw(this._text, this._matrix);
                        setIcon(new AssetIcon((_local_2 as Bitmap)));
                    };
                }
                else
                {
                    setIcon(this._icon);
                };
            };
            pack();
        }

        private function convertCount(_arg_1:Number):String
        {
            var _local_2:* = "";
            if (_arg_1 > 999)
            {
                _local_2 = (Math.round((_arg_1 / 999)) + "k");
            }
            else
            {
                _local_2 = _arg_1.toString();
            };
            return (_local_2);
        }


    }
}//package hbm.Game.GUI.Inventory

