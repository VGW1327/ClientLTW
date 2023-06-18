


//hbm.Game.GUI.Store.StoreItemPanel

package hbm.Game.GUI.Store
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Inventory.InventoryStoreItem;
    import org.aswing.JLabel;
    import org.aswing.JCheckBox;
    import org.aswing.JAdjuster;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import hbm.Application.ClientApplication;
    import org.aswing.SoftBoxLayout;
    import org.aswing.BorderLayout;
    import org.aswing.event.DragAndDropEvent;
    import hbm.Engine.Actors.ItemData;
    import org.aswing.event.AWEvent;
    import org.aswing.dnd.DragManager;

    public class StoreItemPanel extends JPanel 
    {

        private var _item:InventoryStoreItem;
        private var _priceLabel:JLabel;
        private var _descriptionLabel:JLabel;
        private var _mode:int;
        private var _cBox:JCheckBox;
        private var _amountAdjuster:JAdjuster;
        private var _buyButton:CustomButton;

        public function StoreItemPanel(_arg_1:ItemData, _arg_2:int)
        {
            var _local_4:String;
            var _local_9:CustomToolTip;
            var _local_10:JPanel;
            super();
            this._item = new InventoryStoreItem(_arg_1);
            this._mode = _arg_2;
            var _local_3:LineBorder = new LineBorder(null, new ASColor(5333109), 1, 4);
            setBorder(_local_3);
            setPreferredWidth((240 + 60));
            var _local_5:int = int(((this._item.ServerItemDescription) ? this._item.ServerItemDescription["price_buy"] : 0));
            var _local_6:int = int(((this._item.ServerItemDescription) ? this._item.ServerItemDescription["price_sell"] : 0));
            if (_local_6 == 0)
            {
                _local_6 = int((_local_5 / 2));
            };
            switch (_arg_2)
            {
                case StorePanel.BUY_PANEL:
                    _local_4 = ((ClientApplication.Localization.STORE_ITEM_PRICE_PART1 + ": ") + this._item.Item.Price);
                    this._buyButton = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_BUY);
                    this._buyButton.setPreferredWidth(60);
                    this._buyButton.addActionListener(this.OnActionButtonPressed, 0, true);
                    _local_9 = new CustomToolTip(this._buyButton, ClientApplication.Instance.GetPopupText(126, this._item.Item.Price), 180, 10);
                    putClientProperty(StoreDnd.DND_TYPE, StoreDnd.BUY_ITEM);
                    break;
                case StorePanel.SELL_PANEL:
                    _local_4 = ((ClientApplication.Localization.STORE_ITEM_AMOUNT + ": ") + this._item.Item.Amount);
                    this._cBox = new JCheckBox();
                    this._cBox.setSelected(false);
                    this._cBox.setHorizontalAlignment(JLabel.RIGHT);
                    this._item.Item.Price = -(_local_6);
                    putClientProperty(StoreDnd.DND_TYPE, StoreDnd.SELL_ITEM);
                    break;
            };
            var _local_7:String = ((this._item.Item.Identified == 1) ? this._item.Name : (this._item.Name + "?"));
            this._descriptionLabel = new JLabel(_local_7, null, JLabel.LEFT);
            this._descriptionLabel.setPreferredWidth(184);
            this._descriptionLabel.setMaximumWidth(184);
            this._priceLabel = new JLabel(_local_4, null, JLabel.LEFT);
            var _local_8:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0));
            _local_8.append(this._descriptionLabel);
            _local_8.append(this._priceLabel);
            append(this._item, BorderLayout.WEST);
            append(_local_8, BorderLayout.CENTER);
            if (_arg_2 == StorePanel.BUY_PANEL)
            {
                append(this._buyButton, BorderLayout.EAST);
            }
            else
            {
                if (_arg_2 == StorePanel.SELL_PANEL)
                {
                    if (this._item.Item.Amount > 1)
                    {
                        this._amountAdjuster = new JAdjuster(3);
                        this._amountAdjuster.setEditable(false);
                        this._descriptionLabel.setPreferredWidth(160);
                        this._descriptionLabel.setMaximumWidth(160);
                        this._amountAdjuster.setValues(1, 1, 1, (this._item.Item.Amount + 1));
                        _local_10 = new JPanel(new BorderLayout());
                        _local_10.setPreferredWidth(80);
                        _local_10.setMaximumWidth(80);
                        _local_10.append(this._amountAdjuster, BorderLayout.WEST);
                        _local_10.append(this._cBox, BorderLayout.EAST);
                        append(_local_10, BorderLayout.EAST);
                    }
                    else
                    {
                        this._descriptionLabel.setPreferredWidth(223);
                        this._descriptionLabel.setMaximumWidth(223);
                        append(this._cBox, BorderLayout.EAST);
                    };
                };
            };
            setDragEnabled(true);
            addEventListener(DragAndDropEvent.DRAG_RECOGNIZED, this.OnStartDrag, false, 0, true);
            pack();
        }

        public function GetBuyButton():CustomButton
        {
            return (this._buyButton);
        }

        public function GetItemID():int
        {
            return (this._item.Item.NameId);
        }

        public function get StoreItem():InventoryStoreItem
        {
            return (this._item);
        }

        public function get SelectedAmount():int
        {
            return ((this._amountAdjuster) ? this._amountAdjuster.getValue() : 1);
        }

        public function get SellEnabled():Boolean
        {
            return ((!(this._cBox == null)) && (this._cBox.isSelected()));
        }

        private function OnActionButtonPressed(_arg_1:AWEvent):void
        {
            this._item.Action(this._item);
        }

        private function OnStartDrag(_arg_1:DragAndDropEvent):void
        {
            DragManager.startDrag(_arg_1.getDragInitiator(), null, null, new StoreDnd());
        }


    }
}//package hbm.Game.GUI.Store

