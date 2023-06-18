


//hbm.Game.GUI.Cart.InventoryVendingItem

package hbm.Game.GUI.Cart
{
    import hbm.Game.GUI.Inventory.InventoryItem;
    import hbm.Engine.Actors.ItemData;
    import flash.events.Event;

    public class InventoryVendingItem extends InventoryItem 
    {

        private var _clickable:Boolean = true;

        public function InventoryVendingItem(_arg_1:ItemData, _arg_2:Boolean=true)
        {
            var _local_3:ItemData = new ItemData();
            _local_3.Id = _arg_1.Id;
            _local_3.NameId = _arg_1.NameId;
            _local_3.Amount = _arg_1.Amount;
            _local_3.Equip = _arg_1.Equip;
            _local_3.Identified = _arg_1.Identified;
            _local_3.Cards = _arg_1.Cards;
            _local_3.Type = _arg_1.Type;
            _local_3.TypeEquip = _arg_1.TypeEquip;
            _local_3.Attr = _arg_1.Attr;
            _local_3.Upgrade = _arg_1.Upgrade;
            _local_3.Price = _arg_1.Price;
            _local_3.Origin = ItemData.QUEST;
            this._clickable = _arg_2;
            super(_local_3);
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
}//package hbm.Game.GUI.Cart

