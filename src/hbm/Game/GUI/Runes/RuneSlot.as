


//hbm.Game.GUI.Runes.RuneSlot

package hbm.Game.GUI.Runes
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
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;

    public class RuneSlot extends JPanel 
    {

        private var _item:InventoryUpgradeRuneItem;
        private var _slotType:int;
        private var _slotIndex:int;
        private var _tip:CustomToolTip;

        public function RuneSlot(_arg_1:int)
        {
            super(new FlowLayout());
            (getLayout() as FlowLayout).setMargin(false);
            var _local_2:IntDimension = new IntDimension(38, 38);
            setPreferredSize(_local_2);
            setMaximumSize(_local_2);
            setDropTrigger(true);
            putClientProperty(DndTargets.DND_TYPE, DndTargets.UPGRADE_RUNE_SLOT);
            this._tip = new CustomToolTip(this, ClientApplication.Instance.GetPopupText(191), 220, 10, false);
            this.SlotType = -1;
            this._slotIndex = _arg_1;
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
                this._tip.visible = true;
                append(new JLabel("", new AttachIcon("Items_Item_101")));
            };
        }

        public function get Item():InventoryUpgradeRuneItem
        {
            return (this._item);
        }

        public function SetItem(_arg_1:ItemData):void
        {
            if (_arg_1 != null)
            {
                this._item = new InventoryUpgradeRuneItem(_arg_1);
            }
            else
            {
                this._item = null;
                this.SlotType = -1;
            };
        }

        public function get SlotIndex():int
        {
            return (this._slotIndex);
        }

        public function get SlotType():int
        {
            return (this._slotType);
        }

        public function set SlotType(_arg_1:int):void
        {
            var _local_2:uint;
            switch (_arg_1)
            {
                case 0:
                    _local_2 = 16767612;
                    setDropTrigger(true);
                    this._tip.updateToolTip(ClientApplication.Instance.GetPopupText(191), 25);
                    if (this._item)
                    {
                        this._item.setDragEnabled(true);
                    };
                    break;
                case 1:
                    _local_2 = 4576069;
                    setDropTrigger(false);
                    if (this._item)
                    {
                        this._item.setDragEnabled(false);
                    };
                    break;
                default:
                    _local_2 = 0xA0A0A0;
                    setDropTrigger(false);
                    this._tip.updateToolTip(ClientApplication.Instance.GetPopupText(192), 25);
            };
            var _local_3:LineBorder = new LineBorder(null, new ASColor(_local_2), 1, 4);
            setBorder(_local_3);
            this._slotType = _arg_1;
        }


    }
}//package hbm.Game.GUI.Runes

