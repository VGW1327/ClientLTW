


//hbm.Game.GUI.Inventory.InventoryBarItem

package hbm.Game.GUI.Inventory
{
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.DndTargets;
    import org.aswing.JPanel;
    import hbm.Application.ClientApplication;
    import flash.events.Event;

    public class InventoryBarItem extends InventoryItem 
    {

        public function InventoryBarItem(_arg_1:ItemData)
        {
            super(_arg_1);
        }

        override public function Revalidate():void
        {
            var _local_1:String = ((Item.Amount > 1) ? (" x" + Item.Amount.toString()) : "");
            setToolTipText(((Name + " ") + _local_1));
        }

        override protected function OnInventoryButtonPressed(_arg_1:Event):void
        {
            var _local_3:int;
            var _local_2:JPanel = getClientProperty(DndTargets.DND_SLOT);
            if (_local_2 != null)
            {
                _local_3 = _local_2.getClientProperty(DndTargets.DND_INDEX);
                ClientApplication.Instance.BottomHUD.InventoryBarInstance.UseHotkey(_local_3);
            };
        }


    }
}//package hbm.Game.GUI.Inventory

