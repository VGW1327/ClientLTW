


//hbm.Game.GUI.Inventory.InventoryStoreItem

package hbm.Game.GUI.Inventory
{
    import hbm.Engine.Actors.ItemData;
    import flash.events.Event;

    public class InventoryStoreItem extends InventoryItem 
    {

        private var _clickable:Boolean = true;

        public function InventoryStoreItem(_arg_1:ItemData, _arg_2:Boolean=true)
        {
            this._clickable = _arg_2;
            super(_arg_1);
            setDragEnabled(false);
        }

        override protected function OnInventoryButtonPressed(_arg_1:Event):void
        {
            var _local_2:InventoryItem;
            if (this._clickable)
            {
                _local_2 = (_arg_1.target as InventoryItem);
                Action(_local_2);
            };
        }


    }
}//package hbm.Game.GUI.Inventory

