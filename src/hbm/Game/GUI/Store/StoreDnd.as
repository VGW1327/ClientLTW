


//hbm.Game.GUI.Store.StoreDnd

package hbm.Game.GUI.Store
{
    import org.aswing.dnd.DragListener;
    import org.aswing.event.DragAndDropEvent;
    import org.aswing.Component;
    import org.aswing.dnd.DragManager;
    import org.aswing.dnd.RejectedMotion;
    import hbm.Application.ClientApplication;

    public class StoreDnd implements DragListener 
    {

        public static const NOTHING:int = 0;
        public static const BUY_ITEM:int = 1;
        public static const SELL_ITEM:int = 2;
        public static const BUY_PANEL:int = 3;
        public static const SELL_PANEL:int = 4;
        public static const DND_ITEM:String = "item";
        public static const DND_SLOT:String = "slot";
        public static const DND_TYPE:String = "type";
        public static const DND_INDEX:String = "index";


        public function onDragStart(_arg_1:DragAndDropEvent):void
        {
        }

        public function onDragEnter(_arg_1:DragAndDropEvent):void
        {
        }

        public function onDragOverring(_arg_1:DragAndDropEvent):void
        {
        }

        public function onDragExit(_arg_1:DragAndDropEvent):void
        {
        }

        public function onDragDrop(_arg_1:DragAndDropEvent):void
        {
            var _local_3:Component;
            var _local_2:Component = _arg_1.getTargetComponent();
            _local_3 = _arg_1.getDragInitiator();
            var _local_4:int = ((_local_3) ? _local_3.getClientProperty(DND_TYPE, NOTHING) : NOTHING);
            var _local_5:int = ((_local_2) ? _local_2.getClientProperty(DND_TYPE, NOTHING) : NOTHING);
            if (((_local_4 == BUY_ITEM) && (_local_5 == SELL_PANEL)))
            {
                this.BuyItem(_local_3);
            }
            else
            {
                if (((_local_4 == SELL_ITEM) && (_local_5 == BUY_PANEL)))
                {
                    this.SellItem(_local_3);
                }
                else
                {
                    DragManager.setDropMotion(new RejectedMotion());
                };
            };
        }

        private function BuyItem(_arg_1:Component):void
        {
            var _local_2:StoreItemPanel = StoreItemPanel(_arg_1);
            ClientApplication.Instance.LocalGameClient.SendBuyItem(_local_2.StoreItem.Item.NameId, 1);
        }

        private function SellItem(_arg_1:Component):void
        {
            var _local_2:StoreItemPanel = StoreItemPanel(_arg_1);
            _local_2.StoreItem.SellItem(1);
        }


    }
}//package hbm.Game.GUI.Store

