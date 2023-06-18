


//hbm.Game.GUI.Cart.CartTabPanel

package hbm.Game.GUI.Cart
{
    import hbm.Game.GUI.Inventory.InventoryGridPanel;
    import hbm.Game.GUI.DndTargets;
    import hbm.Game.GUI.Inventory.InventoryItem;

    public class CartTabPanel extends InventoryGridPanel 
    {


        override protected function get WidthGrid():int
        {
            return (10);
        }

        override protected function get HeightGrid():int
        {
            return (10);
        }

        override protected function SetInventoryItemProperty(_arg_1:InventoryItem):void
        {
            _arg_1.putClientProperty(DndTargets.DND_TYPE, DndTargets.CART_ITEM);
        }

        override protected function SetPanelProperties():void
        {
            putClientProperty(DndTargets.DND_TYPE, DndTargets.CART_PANEL);
        }


    }
}//package hbm.Game.GUI.Cart

