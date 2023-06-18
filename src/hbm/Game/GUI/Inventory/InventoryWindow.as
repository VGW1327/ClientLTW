


//hbm.Game.GUI.Inventory.InventoryWindow

package hbm.Game.GUI.Inventory
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import hbm.Application.ClientApplication;
    import org.aswing.BorderLayout;
    import hbm.Engine.Actors.CartData;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import flash.utils.Dictionary;
    import flash.display.DisplayObject;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.Tutorial.HelpManager;

    public class InventoryWindow extends CustomWindow 
    {

        private var _inventoryPanel:InventoryPanel;

        public function InventoryWindow(_arg_1:*=null, _arg_2:String=null, _arg_3:Boolean=false, _arg_4:int=305, _arg_5:int=230, _arg_6:Boolean=true)
        {
            super(_arg_1, ((_arg_2) ? _arg_2 : ClientApplication.Localization.INVENTORY_TITLE), _arg_3, _arg_4, _arg_5, _arg_6);
            this.InitUI();
            setLocationXY(((ClientApplication.stageWidth - _arg_4) / 2), ((0x0300 - _arg_5) / 2));
        }

        protected function InitUI():void
        {
            this._inventoryPanel = new InventoryPanel();
            MainPanel.append(this._inventoryPanel, BorderLayout.CENTER);
            pack();
        }

        public function OpenVenderShop():void
        {
            var _local_1:CartData = ClientApplication.Instance.LocalGameClient.Cart;
            if (_local_1 == null)
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.INVENTORY_CART_DIALOG_TITLE1, ClientApplication.Localization.INVENTORY_CART_DIALOG_MESSAGE1, null, null, true, new AttachIcon("StopIcon")));
            }
            else
            {
                if (ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerIsTrader())
                {
                    ClientApplication.Instance.ShowCart();
                }
                else
                {
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.INVENTORY_CART_DIALOG_TITLE1, ClientApplication.Localization.INVENTORY_CART_DIALOG_MESSAGE3, null, null, true, new AttachIcon("StopIcon")));
                };
            };
        }

        public function Revalidate(_arg_1:Dictionary):void
        {
            this._inventoryPanel.Revalidate(_arg_1);
        }

        public function GetInventoryItem(_arg_1:uint):InventoryItem
        {
            return (this._inventoryPanel.GetInventoryItem(_arg_1));
        }

        public function GetIconTab(_arg_1:uint):DisplayObject
        {
            return (this._inventoryPanel.GetIconTab(_arg_1));
        }

        public function RevalidateAmount(_arg_1:Dictionary, _arg_2:ItemData):void
        {
            this._inventoryPanel.RevalidateAmount(_arg_1, _arg_2);
        }

        public function RevalidateItems(_arg_1:Boolean=false, _arg_2:ItemData=null):void
        {
            this._inventoryPanel.RevalidateItems(_arg_1, _arg_2);
        }

        override public function show():void
        {
            ClientApplication.Instance.BottomHUD.BlinkCharacterStats(false);
            super.show();
            HelpManager.Instance.UpdateInventoryHelper();
            HelpManager.Instance.CharacterInventoryPressed();
        }

        override public function dispose():void
        {
            super.dispose();
            HelpManager.Instance.UpdateInventoryHelper();
        }


    }
}//package hbm.Game.GUI.Inventory

