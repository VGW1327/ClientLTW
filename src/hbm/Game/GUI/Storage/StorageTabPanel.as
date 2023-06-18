


//hbm.Game.GUI.Storage.StorageTabPanel

package hbm.Game.GUI.Storage
{
    import hbm.Game.GUI.Inventory.InventoryGridPanel;
    import hbm.Game.GUI.DndTargets;
    import hbm.Game.GUI.Inventory.InventoryItem;

    public class StorageTabPanel extends InventoryGridPanel 
    {


        override protected function get WidthGrid():int
        {
            return (10);
        }

        override protected function get HeightGrid():int
        {
            return (20);
        }

        override protected function SetInventoryItemProperty(_arg_1:InventoryItem):void
        {
            _arg_1.putClientProperty(DndTargets.DND_TYPE, DndTargets.STORAGE_ITEM);
        }

        override protected function SetPanelProperties():void
        {
            putClientProperty(DndTargets.DND_TYPE, DndTargets.STORAGE_PANEL);
        }


    }
}//package hbm.Game.GUI.Storage

