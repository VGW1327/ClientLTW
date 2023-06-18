


//hbm.Game.GUI.Vender.ShopItemPanel

package hbm.Game.GUI.Vender
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Inventory.InventoryStoreItem;
    import org.aswing.JLabel;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import hbm.Application.ClientApplication;
    import org.aswing.BorderLayout;
    import org.aswing.event.DragAndDropEvent;
    import hbm.Game.GUI.Store.StorePanel;
    import org.aswing.SoftBoxLayout;
    import hbm.Engine.Actors.ItemData;
    import org.aswing.event.AWEvent;
    import org.aswing.dnd.DragManager;
    import hbm.Game.GUI.Store.*;

    public class ShopItemPanel extends JPanel 
    {

        private var _item:InventoryStoreItem;
        private var _priceLabel:JLabel;
        private var _descriptionLabel:JLabel;
        private var _mode:int;

        public function ShopItemPanel(_arg_1:ItemData, _arg_2:int)
        {
            var _local_4:String;
            var _local_5:CustomButton;
            var _local_11:CustomToolTip;
            super();
            this._item = new InventoryStoreItem(_arg_1);
            this._mode = _arg_2;
            var _local_3:LineBorder = new LineBorder(null, new ASColor(5333109), 1, 4);
            setBorder(_local_3);
            setPreferredWidth((240 + 60));
            var _local_6:Object = this._item.ServerItemDescription;
            if (_local_6 == null)
            {
                return;
            };
            var _local_7:int = int(_local_6["price_buy"]);
            var _local_8:int = int(_local_6["price_sell"]);
            if (_local_8 == 0)
            {
                _local_8 = int((_local_7 / 2));
            };
            switch (_arg_2)
            {
                case StorePanel.BUY_PANEL:
                    _local_4 = ((((ClientApplication.Localization.STORE_ITEM_PRICE_PART1 + ": ") + this._item.Item.Price) + " ") + ClientApplication.Localization.STORE_ITEM_PRICE_PART2);
                    _local_5 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_BUY);
                    _local_11 = new CustomToolTip(_local_5, ClientApplication.Instance.GetPopupText(126, this._item.Item.Price), 180, 10);
                    _local_5.setPreferredWidth(60);
                    _local_5.addActionListener(this.OnActionButtonPressed, 0, true);
                    append(_local_5, BorderLayout.EAST);
                    putClientProperty(ShopDnd.DND_TYPE, ShopDnd.BUY_ITEM);
                    setDragEnabled(true);
                    addEventListener(DragAndDropEvent.DRAG_RECOGNIZED, this.OnStartDrag, false, 0, true);
                    break;
                case StorePanel.SELL_PANEL:
                    _local_4 = ((ClientApplication.Localization.STORE_ITEM_AMOUNT + ": ") + this._item.Item.Amount);
                    putClientProperty(ShopDnd.DND_TYPE, ShopDnd.SELL_ITEM);
                    break;
            };
            var _local_9:String = ((this._item.Item.Identified == 1) ? this._item.Name : (this._item.Name + "?"));
            this._descriptionLabel = new JLabel(_local_9, null, JLabel.LEFT);
            this._descriptionLabel.setPreferredWidth(184);
            this._descriptionLabel.setMaximumWidth(184);
            this._priceLabel = new JLabel(_local_4, null, JLabel.LEFT);
            var _local_10:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0));
            _local_10.append(this._descriptionLabel);
            _local_10.append(this._priceLabel);
            append(this._item, BorderLayout.WEST);
            append(_local_10, BorderLayout.CENTER);
            pack();
        }

        public function get ShopItem():InventoryStoreItem
        {
            return (this._item);
        }

        private function OnActionButtonPressed(_arg_1:AWEvent):void
        {
            this._item.Action(this._item);
        }

        private function OnStartDrag(_arg_1:DragAndDropEvent):void
        {
            DragManager.startDrag(_arg_1.getDragInitiator(), null, null, new ShopDnd());
        }


    }
}//package hbm.Game.GUI.Vender

