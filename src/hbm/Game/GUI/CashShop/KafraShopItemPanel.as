


//hbm.Game.GUI.CashShop.KafraShopItemPanel

package hbm.Game.GUI.CashShop
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Inventory.InventoryStoreItem;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import hbm.Application.ClientApplication;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.JLabel;
    import org.aswing.AssetIcon;
    import hbm.Game.GUI.Tools.WindowSprites;
    import org.aswing.SoftBoxLayout;
    import org.aswing.BorderLayout;
    import hbm.Engine.Actors.ItemData;
    import org.aswing.event.AWEvent;

    public class KafraShopItemPanel extends JPanel 
    {

        private var _item:InventoryStoreItem;

        public function KafraShopItemPanel(_arg_1:ItemData)
        {
            var _local_3:int;
            var _local_4:String;
            var _local_5:CustomButton;
            super();
            this._item = new InventoryStoreItem(_arg_1);
            var _local_2:LineBorder = new LineBorder(null, new ASColor(5333109), 1, 4);
            setBorder(_local_2);
            setPreferredWidth((240 + 60));
            _local_3 = this._item.Item.Price;
            _local_4 = _local_3.toString();
            _local_5 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_BUY);
            var _local_6:CustomToolTip = new CustomToolTip(_local_5, ClientApplication.Instance.GetPopupText(126, _local_4), 150, 10);
            _local_5.setPreferredWidth(60);
            _local_5.addActionListener(this.OnActionButtonPressed, 0, true);
            var _local_7:String = ((this._item.Item.Identified == 1) ? this._item.Name : (this._item.Name + "?"));
            var _local_8:JLabel = new JLabel(_local_7, null, JLabel.LEFT);
            _local_8.setPreferredWidth(184);
            _local_8.setMaximumWidth(184);
            var _local_9:JLabel = new JLabel((((ClientApplication.Localization.STORE_ITEM_PRICE_PART1 + ": ") + _local_4) + " "), null, JLabel.LEFT);
            var _local_10:JLabel = new JLabel(ClientApplication.Localization.STORE_ITEM_PRICE_PART2, new AssetIcon(new WindowSprites.CoinKafra()), JLabel.LEFT);
            var _local_11:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0));
            _local_11.append(_local_9);
            _local_11.append(_local_10);
            var _local_12:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0));
            _local_12.append(_local_8);
            _local_12.append(_local_11);
            append(this._item, BorderLayout.EAST);
            append(_local_12, BorderLayout.CENTER);
            append(_local_5, BorderLayout.WEST);
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


    }
}//package hbm.Game.GUI.CashShop

