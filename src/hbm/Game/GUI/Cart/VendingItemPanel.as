


//hbm.Game.GUI.Cart.VendingItemPanel

package hbm.Game.GUI.Cart
{
    import org.aswing.JPanel;
    import org.aswing.JCheckBox;
    import org.aswing.JAdjuster;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.SoftBoxLayout;
    import org.aswing.JLabel;
    import hbm.Application.ClientApplication;
    import org.aswing.BorderLayout;
    import hbm.Engine.Actors.ItemData;
    import flash.events.Event;
    import org.aswing.event.AWEvent;

    public class VendingItemPanel extends JPanel 
    {

        public static const ON_SELECTION_CHANGED:String = "ON_SELECTION_CHANGED";

        private var _item:InventoryVendingItem;
        private var _checkBox:JCheckBox;
        private var _amountAdjuster:JAdjuster;
        private var _priceAdjuster:JAdjuster;

        public function VendingItemPanel(_arg_1:ItemData)
        {
            this._item = new InventoryVendingItem(_arg_1);
            var _local_2:LineBorder = new LineBorder(null, new ASColor(5333109), 1, 4);
            setBorder(_local_2);
            var _local_3:int = int(this._item.ServerItemDescription["price_buy"]);
            var _local_4:int = int(this._item.ServerItemDescription["price_sell"]);
            if (_local_4 == 0)
            {
                _local_4 = int((_local_3 / 2));
            };
            var _local_5:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            this._checkBox = new JCheckBox(this._item.Name);
            this._checkBox.setSelected(false);
            this._checkBox.setPreferredWidth(198);
            this._checkBox.setMaximumWidth(198);
            this._checkBox.setHorizontalAlignment(JLabel.LEFT);
            this._checkBox.addActionListener(this.OnSelected, 0, true);
            _local_5.append(this._checkBox);
            _local_5.append(new JLabel(ClientApplication.Localization.CART_AMOUNT));
            this._amountAdjuster = new JAdjuster(3);
            this._amountAdjuster.setEditable(false);
            this._amountAdjuster.setPreferredWidth(50);
            this._amountAdjuster.setValues(1, 1, 1, (this._item.Item.Amount + 1));
            _local_5.append(this._amountAdjuster);
            _local_5.append(new JLabel(ClientApplication.Localization.CART_PRICE));
            this._priceAdjuster = new JAdjuster(3);
            this._priceAdjuster.setEditable(true);
            this._priceAdjuster.setPreferredWidth(75);
            this._priceAdjuster.setValues(_local_4, 1, 1, 10000001);
            _local_5.append(this._priceAdjuster);
            append(this._item, BorderLayout.EAST);
            append(_local_5, BorderLayout.CENTER);
            this.ChangeEditableState();
        }

        public function SetVendingData(_arg_1:Boolean, _arg_2:uint, _arg_3:uint):void
        {
            this._checkBox.setSelected(_arg_1);
            this._amountAdjuster.setValue(_arg_2);
            this._priceAdjuster.setValue(_arg_3);
            this.ChangeEditableState();
        }

        private function OnSelected(_arg_1:AWEvent):void
        {
            dispatchEvent(new Event(ON_SELECTION_CHANGED));
            this.ChangeEditableState();
        }

        private function ChangeEditableState():void
        {
            var _local_1:Boolean = this._checkBox.isSelected();
            this._amountAdjuster.setEnabled(_local_1);
            this._priceAdjuster.setEnabled(_local_1);
        }

        public function get Item():InventoryVendingItem
        {
            return (this._item);
        }

        public function get IsChecked():Boolean
        {
            return (this._checkBox.isSelected());
        }

        public function Clear():void
        {
            this._checkBox.setSelected(false);
        }

        public function get Amount():int
        {
            return (this._amountAdjuster.getValue());
        }

        public function get Price():int
        {
            return (this._priceAdjuster.getValue());
        }


    }
}//package hbm.Game.GUI.Cart

