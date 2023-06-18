


//hbm.Game.GUI.CashShop.Stash.CraftRuneSlot

package hbm.Game.GUI.CashShop.Stash
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.FlowLayout;
    import org.aswing.geom.IntDimension;
    import hbm.Game.GUI.DndTargets;
    import hbm.Application.ClientApplication;
    import org.aswing.JLabel;
    import org.aswing.AttachIcon;
    import hbm.Engine.Actors.ItemData;

    public class CraftRuneSlot extends JPanel 
    {

        private var _item:InventoryCraftRuneItem;
        private var _slotIndex:int;
        private var _tip:CustomToolTip;

        public function CraftRuneSlot(_arg_1:int)
        {
            super(new FlowLayout());
            (getLayout() as FlowLayout).setMargin(false);
            var _local_2:IntDimension = new IntDimension(38, 38);
            setPreferredSize(_local_2);
            setMaximumSize(_local_2);
            setSize(_local_2);
            setDropTrigger(true);
            putClientProperty(DndTargets.DND_TYPE, DndTargets.CRAFT_RUNE_SLOT);
            if (_arg_1 != 2)
            {
                this._tip = new CustomToolTip(this, ClientApplication.Instance.GetPopupText(198), 220, 40);
            };
            this._slotIndex = _arg_1;
        }

        public function Revalidate():void
        {
            removeAll();
            if (this._item != null)
            {
                append(this._item);
                if (this._slotIndex != 2)
                {
                    this._tip.visible = false;
                };
                dispatchEvent(new SlotEvent(true, SlotEvent.CRAFT_RUNE, this._slotIndex));
            }
            else
            {
                if (this._slotIndex != 2)
                {
                    this._tip.visible = true;
                };
                append(new JLabel("", new AttachIcon("Items_Item_101")));
                dispatchEvent(new SlotEvent(false, SlotEvent.CRAFT_RUNE, this._slotIndex));
            };
        }

        public function get Item():InventoryCraftRuneItem
        {
            return (this._item);
        }

        public function SetItem(_arg_1:ItemData):void
        {
            if (_arg_1 != null)
            {
                this._item = new InventoryCraftRuneItem(_arg_1);
            }
            else
            {
                this._item = null;
            };
        }

        public function get SlotIndex():int
        {
            return (this._slotIndex);
        }


    }
}//package hbm.Game.GUI.CashShop.Stash

