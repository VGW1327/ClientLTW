


//hbm.Game.GUI.Refine.RefineItemSlot

package hbm.Game.GUI.Refine
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.FlowLayout;
    import org.aswing.border.CaveBorder;
    import org.aswing.geom.IntDimension;
    import hbm.Game.GUI.DndTargets;
    import hbm.Application.ClientApplication;
    import org.aswing.JLabel;
    import org.aswing.AttachIcon;
    import hbm.Engine.Actors.ItemData;

    public class RefineItemSlot extends JPanel 
    {

        private var _item:InventoryRefineItem;
        private var _tip:CustomToolTip;

        public function RefineItemSlot()
        {
            super(new FlowLayout());
            (getLayout() as FlowLayout).setMargin(false);
            setBorder(new CaveBorder(null, 4));
            var _local_1:IntDimension = new IntDimension(38, 38);
            setPreferredSize(_local_1);
            setMaximumSize(_local_1);
            setDropTrigger(true);
            putClientProperty(DndTargets.DND_TYPE, DndTargets.REFINE_ITEM_SLOT);
            this._tip = new CustomToolTip(this, ClientApplication.Instance.GetPopupText(142), 250, 20);
        }

        public function Revalidate():void
        {
            removeAll();
            if (this._item != null)
            {
                append(this._item);
                this._tip.visible = false;
            }
            else
            {
                this._item = null;
                this._tip.visible = true;
                append(new JLabel("", new AttachIcon("Items_Item_05")));
            };
        }

        public function get Item():InventoryRefineItem
        {
            return (this._item);
        }

        public function SetItem(_arg_1:ItemData):void
        {
            if (_arg_1 != null)
            {
                this._item = new InventoryRefineItem(_arg_1);
            }
            else
            {
                this._item = null;
            };
        }


    }
}//package hbm.Game.GUI.Refine

