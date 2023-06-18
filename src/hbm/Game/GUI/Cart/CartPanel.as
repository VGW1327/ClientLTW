


//hbm.Game.GUI.Cart.CartPanel

package hbm.Game.GUI.Cart
{
    import hbm.Game.GUI.Inventory.InventoryPanel;
    import hbm.Game.GUI.PaddedValue;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Application.ClientApplication;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.FlowLayout;
    import org.aswing.BorderLayout;
    import hbm.Engine.Actors.CartData;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.Inventory.InventoryItem;
    import flash.utils.Dictionary;
    import flash.events.Event;

    public class CartPanel extends InventoryPanel 
    {

        public static const CART_PANEL_CLOSED:String = "CART_PANEL_CLOSED";
        public static const CART_PANEL_TRADE:String = "CART_PANEL_TRADE";

        protected var _statusWeight:PaddedValue;
        public var _buttonTrade:CustomButton;

        public function CartPanel()
        {
            this.RevalidateItems();
            this.RevalidateStatusBar();
        }

        override protected function CreateStatusBar():JPanel
        {
            _statusBar2 = new PaddedValue(ClientApplication.Localization.CART_STATUS_BAR, "0", ((196 - 56) + 10), (90 + 56));
            var _local_1:CustomToolTip = new CustomToolTip(_statusBar2, ClientApplication.Instance.GetPopupText(107), 250, 20);
            this._statusWeight = new PaddedValue(ClientApplication.Localization.CART_STATUS_WEIGHT, "0", ((196 - 56) + 10), (90 + 56));
            var _local_2:CustomToolTip = new CustomToolTip(this._statusWeight, ClientApplication.Instance.GetPopupText(108), 250, 20);
            var _local_3:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.LEFT));
            var _local_4:EmptyBorder = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            _local_3.setBorder(_local_4);
            _local_3.append(_statusBar2);
            _local_3.append(this._statusWeight);
            var _local_5:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
            var _local_6:CustomButton = new CustomButton(ClientApplication.Localization.BUTTON_CLOSE);
            _local_6.setToolTipText(ClientApplication.Instance.GetPopupText(2));
            this._buttonTrade = new CustomButton(ClientApplication.Localization.CART_BUTTON_TRADE);
            var _local_7:CustomToolTip = new CustomToolTip(this._buttonTrade, ClientApplication.Instance.GetPopupText(121), 130, 20);
            _local_6.addActionListener(this.OnCloseButton, 0, true);
            this._buttonTrade.addActionListener(this.OnTradeButton, 0, true);
            _local_5.append(this._buttonTrade);
            _local_5.append(_local_6);
            _local_3.append(_local_5);
            return (_local_3);
        }

        override protected function InitUI():void
        {
            this.CreatePanels();
            setLayout(new BorderLayout());
            setBorder(new EmptyBorder(null, new Insets(4, 4, 4, 0)));
            append(_etcPanel, BorderLayout.CENTER);
            append(this.CreateStatusBar(), BorderLayout.PAGE_END);
            pack();
        }

        override protected function CreatePanels():void
        {
            _etcPanel = new CartTabPanel();
        }

        override public function RevalidateItems(_arg_1:Boolean=false, _arg_2:ItemData=null):void
        {
            var _local_3:CartData = ClientApplication.Instance.LocalGameClient.Cart;
            if (_local_3)
            {
                this.Revalidate(_local_3.Cart);
            };
        }

        override public function Revalidate(_arg_1:Dictionary):void
        {
            var _local_2:ItemData;
            var _local_3:InventoryItem;
            _etcPanel.Clear();
            for each (_local_2 in _arg_1)
            {
                _local_3 = new InventoryItem(_local_2);
                _etcPanel.AddInventoryItem(_local_3);
            };
        }

        private function OnCloseButton(_arg_1:Event):void
        {
            dispatchEvent(new Event(CART_PANEL_CLOSED));
        }

        private function OnTradeButton(_arg_1:Event):void
        {
            dispatchEvent(new Event(CART_PANEL_TRADE));
        }

        public function RevalidateStatusBar():void
        {
            var _local_1:CartData = ClientApplication.Instance.LocalGameClient.Cart;
            if (!_local_1)
            {
                return;
            };
            _statusBar2.Value = ((((_local_1.Amount.toString() + " ") + ClientApplication.Localization.CART_STATUS_BAR_PART1) + " ") + _local_1.MaxAmount.toString());
            var _local_2:Number = (_local_1.Weight / 1000);
            var _local_3:Number = (_local_1.MaxWeight / 1000);
            this._statusWeight.Value = ((_local_2 + " / ") + _local_3);
        }


    }
}//package hbm.Game.GUI.Cart

