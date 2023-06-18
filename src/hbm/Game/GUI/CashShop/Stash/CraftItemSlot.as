


//hbm.Game.GUI.CashShop.Stash.CraftItemSlot

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

    public class CraftItemSlot extends JPanel 
    {

        private var _item:InventoryCraftItem;
        private var _tip:CustomToolTip;

        public function CraftItemSlot()
        {
            super(new FlowLayout());
            (getLayout() as FlowLayout).setMargin(false);
            var _local_1:IntDimension = new IntDimension(38, 38);
            setPreferredSize(_local_1);
            setMaximumSize(_local_1);
            setSize(_local_1);
            setDropTrigger(true);
            putClientProperty(DndTargets.DND_TYPE, DndTargets.CRAFT_ITEM_SLOT);
            this._tip = new CustomToolTip(this, ClientApplication.Instance.GetPopupText(197), 250, 20);
        }

        public function Revalidate():void
        {
            removeAll();
            if (this._item != null)
            {
                append(this._item);
                this._tip.visible = false;
                dispatchEvent(new SlotEvent(true, SlotEvent.CRAFT_ITEM));
            }
            else
            {
                this._item = null;
                this._tip.visible = true;
                append(new JLabel("", new AttachIcon("Items_Item_102")));
                dispatchEvent(new SlotEvent(false, SlotEvent.CRAFT_ITEM));
            };
        }

        public function get Item():InventoryCraftItem
        {
            return (this._item);
        }

        public function SetItem(_arg_1:ItemData):void
        {
            if (_arg_1 != null)
            {
                this._item = new InventoryCraftItem(_arg_1);
            }
            else
            {
                this._item = null;
            };
        }


    }
}//package hbm.Game.GUI.CashShop.Stash

