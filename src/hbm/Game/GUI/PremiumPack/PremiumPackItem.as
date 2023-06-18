


//hbm.Game.GUI.PremiumPack.PremiumPackItem

package hbm.Game.GUI.PremiumPack
{
    import hbm.Game.GUI.Inventory.InventoryItem;
    import hbm.Engine.Actors.ItemData;
    import flash.events.Event;
    import org.aswing.AttachIcon;

    public class PremiumPackItem extends InventoryItem 
    {

        private var _clickable:Boolean = true;
        private var _visible:Boolean = true;

        public function PremiumPackItem(_arg_1:ItemData, _arg_2:Boolean=true, _arg_3:Boolean=false)
        {
            this._clickable = _arg_2;
            this._visible = _arg_3;
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

        override public function get Icon():AttachIcon
        {
            var _local_1:AttachIcon = super.Icon;
            if (!this._visible)
            {
                _local_1.getAsset().alpha = 0;
            };
            return (_local_1);
        }


    }
}//package hbm.Game.GUI.PremiumPack

