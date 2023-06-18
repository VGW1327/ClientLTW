


//hbm.Game.GUI.Trade.TradePanel

package hbm.Game.GUI.Trade
{
    import org.aswing.JPanel;
    import flash.utils.Dictionary;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.GridLayout;
    import org.aswing.geom.IntDimension;
    import flash.display.Bitmap;
    import org.aswing.CenterLayout;
    import org.aswing.AssetBackground;
    import org.aswing.Container;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.DndTargets;

    public class TradePanel extends JPanel 
    {

        public static const BUY_PANEL:int = 0;
        public static const SELL_PANEL:int = 1;

        private var _tradeMode:int;
        private var _itemsCount:int;
        private var _items:Dictionary;
        private var _dataLibrary:AdditionalDataResourceLibrary = (ResourceManager.Instance.Library("AdditionalData") as AdditionalDataResourceLibrary);

        public function TradePanel(_arg_1:int)
        {
            super(new GridLayout(0, 2));
            this._tradeMode = _arg_1;
            removeAll();
            this.Refill();
            this.SetPanelProperties();
            var _local_2:IntDimension = new IntDimension(76, 190);
            setPreferredSize(_local_2);
            setSize(_local_2);
            setMinimumSize(_local_2);
            this._items = new Dictionary(true);
        }

        public function Refill():void
        {
            var _local_2:int;
            var _local_1:int = ((2 * 5) - this._itemsCount);
            if (_local_1 > 0)
            {
                _local_2 = 0;
                while (_local_2 < _local_1)
                {
                    append(this.CreateSlot());
                    _local_2++;
                };
            };
        }

        protected function CreateSlot():Container
        {
            var _local_1:Bitmap;
            _local_1 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_ItemExchangeSlotBack");
            var _local_2:IntDimension = new IntDimension(_local_1.width, _local_1.height);
            var _local_3:JPanel = new JPanel(new CenterLayout());
            _local_3.setBackgroundDecorator(new AssetBackground(_local_1));
            _local_3.setPreferredSize(_local_2);
            _local_3.setMaximumSize(_local_2);
            return (_local_3);
        }

        public function LoadItem(_arg_1:ItemData):void
        {
            var _local_2:ItemData;
            if (_arg_1)
            {
                _local_2 = this._items[_arg_1.Id];
                if (((_local_2) && (_local_2.NameId == _arg_1.NameId)))
                {
                    _local_2.Amount = (_local_2.Amount + _arg_1.Amount);
                    return;
                };
                this._itemsCount++;
                this._items[_arg_1.Id] = _arg_1;
            };
        }

        public function RemoveItem(_arg_1:ItemData):void
        {
            var _local_2:ItemData;
            if (_arg_1)
            {
                _local_2 = this._items[_arg_1.Id];
                if ((((_local_2) && (_local_2.Id == _arg_1.Id)) && (_local_2.Amount >= _arg_1.Amount)))
                {
                    _local_2.Amount = (_local_2.Amount - _arg_1.Amount);
                    if (_local_2.Amount == 0)
                    {
                        this._items[_arg_1.Id] = null;
                        delete this._items[_arg_1.Id];
                        this._itemsCount--;
                    };
                };
            };
        }

        public function Revalidate():void
        {
            var _local_1:ItemData;
            var _local_2:InventoryTradeItem;
            var _local_3:Container;
            removeAll();
            for each (_local_1 in this._items)
            {
                if (_local_1.Amount != 0)
                {
                    _local_2 = new InventoryTradeItem(_local_1, (!(this._tradeMode == TradePanel.SELL_PANEL)));
                    _local_2.putClientProperty(DndTargets.DND_TYPE, DndTargets.SAFE_TRADE_PANEL);
                    _local_3 = this.CreateSlot();
                    _local_3.append(_local_2);
                    append(_local_3);
                };
            };
            this.Refill();
        }

        private function SetPanelProperties():void
        {
            if (this._tradeMode == TradePanel.SELL_PANEL)
            {
                putClientProperty(DndTargets.DND_TYPE, DndTargets.SAFE_TRADE_PANEL);
                setDropTrigger(true);
            }
            else
            {
                setDropTrigger(false);
                setDragEnabled(false);
            };
        }

        public function CheckItem(_arg_1:ItemData):Boolean
        {
            var _local_2:ItemData = this._items[_arg_1.Id];
            return (!(((_local_2) && (_local_2.Id == _arg_1.Id)) && (((_local_2.Type == ItemData.IT_ARMOR) || (_local_2.Type == ItemData.IT_WEAPON)) || (_local_2.Type == ItemData.IT_AMMO))));
        }

        public function LockPanel():void
        {
            setDropTrigger(false);
            setDragEnabled(false);
        }


    }
}//package hbm.Game.GUI.Trade

