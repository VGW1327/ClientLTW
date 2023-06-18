


//hbm.Game.GUI.Cart.CartWindow

package hbm.Game.GUI.Cart
{
    import hbm.Game.GUI.Inventory.InventoryWindow;
    import hbm.Application.ClientApplication;
    import org.aswing.BorderLayout;
    import flash.events.Event;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Actors.SkillData;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import hbm.Engine.Actors.ItemData;

    public class CartWindow extends InventoryWindow 
    {

        private const _width:int = 335;
        private const _height:int = 405;

        private var _cartPanel:CartPanel;
        private var _vending:VendingWindow;

        public function CartWindow()
        {
            super(null, ClientApplication.Localization.CART_TITLE, false, this._width, this._height, true);
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
        }

        override protected function InitUI():void
        {
            this._cartPanel = new CartPanel();
            this._cartPanel.addEventListener(CartPanel.CART_PANEL_CLOSED, this.OnClose);
            this._cartPanel.addEventListener(CartPanel.CART_PANEL_TRADE, this.OnTrade);
            MainPanel.append(this._cartPanel, BorderLayout.CENTER);
            pack();
        }

        private function OnClose(_arg_1:Event):void
        {
            this.dispose();
        }

        private function OnTrade(_arg_1:Event):void
        {
            var _local_2:CharacterInfo;
            this.dispose();
            _local_2 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_3:SkillData = _local_2.Skills[41];
            if (((!(_local_3 == null)) && (ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerIsTrader())))
            {
                if (_local_3.Lv == 0)
                {
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.INVENTORY_CART_DIALOG_TITLE2, ClientApplication.Localization.INVENTORY_CART_DIALOG_MESSAGE2, null, null, true, new AttachIcon("StopIcon")));
                }
                else
                {
                    this._vending = new VendingWindow(_local_2, (_local_3.Lv + 2));
                    this._vending.RevalidateItems();
                    this._vending.show();
                };
            };
        }

        public function VenderCreate():void
        {
            if (this._vending)
            {
                this._vending.VenderCreate();
            };
        }

        public function VenderClose():void
        {
            if (this._vending)
            {
                this._vending.VenderClose();
                if (this._vending.isShowing())
                {
                    this._vending.dispose();
                };
            };
        }

        public function RevalidateStatusBar():void
        {
            this._cartPanel.RevalidateStatusBar();
        }

        override public function RevalidateItems(_arg_1:Boolean=false, _arg_2:ItemData=null):void
        {
            this._cartPanel.RevalidateItems(_arg_1, _arg_2);
        }

        override public function show():void
        {
            super.show();
            this._cartPanel._buttonTrade.visible = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerIsTrader();
        }

        override public function dispose():void
        {
            super.dispose();
        }


    }
}//package hbm.Game.GUI.Cart

