


//hbm.Game.GUI.CharacterStats.CharacterStatsItemSlot

package hbm.Game.GUI.CharacterStats
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.FlowLayout;
    import org.aswing.border.CaveBorder;
    import org.aswing.geom.IntDimension;
    import hbm.Game.GUI.DndTargets;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Actors.CharacterEquipment;
    import org.aswing.JLabel;
    import org.aswing.AttachIcon;

    public class CharacterStatsItemSlot extends JPanel 
    {

        private var _slotId:int;
        private var _hint:String;
        private var _toolTip:CustomToolTip;
        private var _width:int = -1;
        private var _height:int = -1;

        public function CharacterStatsItemSlot(_arg_1:int, _arg_2:String=null, _arg_3:int=-1, _arg_4:int=-1)
        {
            super(new FlowLayout());
            (getLayout() as FlowLayout).setMargin(false);
            setBorder(new CaveBorder(null, 4));
            var _local_5:IntDimension = new IntDimension(38, 38);
            setPreferredSize(_local_5);
            setMaximumSize(_local_5);
            setDropTrigger(true);
            putClientProperty(DndTargets.DND_TYPE, DndTargets.INVENTORY_STATS_SLOT);
            this._hint = _arg_2;
            this._width = _arg_3;
            this._height = _arg_4;
            if (_arg_2)
            {
                this._toolTip = new CustomToolTip(this, _arg_2, this._width, this._height);
            };
            this._slotId = _arg_1;
        }

        public function SetSlotItem(_arg_1:int):void
        {
            this._slotId = _arg_1;
        }

        public function Revalidate():void
        {
            var _local_1:CharacterInfo;
            var _local_3:String;
            _local_1 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_2:ItemData = _local_1.Equipment.GetItemBySlotName(this._slotId);
            removeAll();
            if (_local_2 != null)
            {
                if (this._toolTip)
                {
                    this._toolTip.setVisible(false);
                };
                append(new InventoryStatsItem(_local_2));
            }
            else
            {
                if (this._toolTip)
                {
                    this._toolTip.setVisible(true);
                };
                if (this._slotId == CharacterEquipment.SLOT_ARROWS)
                {
                    _local_3 = CharacterEquipment.SLOT_LEFT_HAND.toString();
                }
                else
                {
                    _local_3 = this._slotId.toString();
                };
                while (_local_3.length < 2)
                {
                    _local_3 = ("0" + _local_3);
                };
                _local_3 = ("Items_Item_" + _local_3);
                append(new JLabel("", new AttachIcon(_local_3)));
            };
        }

        public function get SlotId():int
        {
            return (this._slotId);
        }


    }
}//package hbm.Game.GUI.CharacterStats

