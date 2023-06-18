


//hbm.Game.GUI.Inventory.InventoryGridPanel

package hbm.Game.GUI.Inventory
{
    import org.aswing.JPanel;
    import org.aswing.GridLayout;
    import org.aswing.FlowLayout;
    import org.aswing.geom.IntDimension;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import hbm.Game.GUI.DndTargets;
    import hbm.Game.GUI.*;

    public class InventoryGridPanel extends JPanel 
    {

        protected var _itemsCount:int;
        protected var _slots:Array = [];

        public function InventoryGridPanel()
        {
            super(new GridLayout(0, this.WidthGrid));
            this.Clear();
            this.SetPanelProperties();
            setDropTrigger(true);
            this.Refill();
        }

        protected function get WidthGrid():int
        {
            return (10);
        }

        protected function get HeightGrid():int
        {
            return (12);
        }

        public function Clear():void
        {
            var _local_1:JPanel;
            for each (_local_1 in this._slots)
            {
                _local_1.removeAll();
            };
            this._itemsCount = 0;
        }

        protected function Refill():void
        {
            var _local_2:int;
            removeAll();
            this._slots = [];
            var _local_1:int = (this.HeightGrid * this.WidthGrid);
            if (_local_1 > 0)
            {
                _local_2 = 0;
                while (_local_2 < _local_1)
                {
                    this._slots.push(this.CreateSlot());
                    _local_2++;
                };
            };
        }

        protected function CreateSlot():JPanel
        {
            var _local_3:FlowLayout;
            var _local_1:IntDimension = new IntDimension(34, 34);
            var _local_2:LineBorder = new LineBorder(null, new ASColor(5333109), 1, 0);
            _local_3 = new FlowLayout();
            _local_3.setMargin(false);
            var _local_4:JPanel = new JPanel(_local_3);
            _local_4.setBorder(_local_2);
            _local_4.setPreferredSize(_local_1);
            _local_4.setMaximumSize(_local_1);
            append(_local_4);
            return (_local_4);
        }

        public function AddInventoryItem(_arg_1:InventoryItem):void
        {
            this.SetInventoryItemProperty(_arg_1);
            if (this._itemsCount >= this._slots.length)
            {
                this._slots.push(this.CreateSlot());
            };
            var _local_2:JPanel = this._slots[this._itemsCount];
            _local_2.append(_arg_1);
            this._itemsCount++;
        }

        protected function SetInventoryItemProperty(_arg_1:InventoryItem):void
        {
            _arg_1.putClientProperty(DndTargets.DND_TYPE, DndTargets.INVENTORY_ITEM);
        }

        protected function SetPanelProperties():void
        {
            putClientProperty(DndTargets.DND_TYPE, DndTargets.INVENTORY_PANEL);
        }


    }
}//package hbm.Game.GUI.Inventory

