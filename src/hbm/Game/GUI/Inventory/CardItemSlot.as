


//hbm.Game.GUI.Inventory.CardItemSlot

package hbm.Game.GUI.Inventory
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.FlowLayout;
    import org.aswing.border.CaveBorder;
    import org.aswing.geom.IntDimension;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.ItemData;

    public class CardItemSlot extends JPanel 
    {

        private var _item:InventoryItem;
        private var _toolTip:CustomToolTip;

        public function CardItemSlot()
        {
            super(new FlowLayout());
            (getLayout() as FlowLayout).setMargin(false);
            setBorder(new CaveBorder(null, 4));
            var _local_1:IntDimension = new IntDimension(38, 38);
            setPreferredSize(_local_1);
            setMaximumSize(_local_1);
            this._toolTip = new CustomToolTip(this, ClientApplication.Instance.GetPopupText(128), 195, 20);
        }

        public function Revalidate():void
        {
            removeAll();
            if (this._item != null)
            {
                this._toolTip.setVisible(false);
                append(this._item);
            }
            else
            {
                this._toolTip.setVisible(true);
                this._item = null;
            };
        }

        public function get Item():InventoryItem
        {
            return (this._item);
        }

        public function SetItem(_arg_1:ItemData):void
        {
            if (_arg_1 != null)
            {
                this._item = new InventoryItem(_arg_1);
                this._item.setDragEnabled(false);
            }
            else
            {
                this._item = null;
            };
            this.Revalidate();
        }


    }
}//package hbm.Game.GUI.Inventory

