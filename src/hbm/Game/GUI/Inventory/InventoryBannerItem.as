


//hbm.Game.GUI.Inventory.InventoryBannerItem

package hbm.Game.GUI.Inventory
{
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import org.aswing.AttachIcon;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.DisplayObject;
    import hbm.Application.ClientApplication;
    import flash.events.Event;

    public class InventoryBannerItem extends InventoryItem 
    {

        public function InventoryBannerItem(_arg_1:ItemData)
        {
            super(_arg_1);
            setBorder(null);
        }

        override public function get Icon():AttachIcon
        {
            var _local_1:ItemsResourceLibrary;
            var _local_2:AttachIcon;
            _local_1 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            _local_2 = _local_1.GetItemAttachIcon(_item.NameId);
            var _local_3:DisplayObject = _local_2.getAsset();
            _local_3.scaleX = 1;
            _local_3.scaleY = 1;
            return (_local_2);
        }

        override protected function OnInventoryButtonPressed(_arg_1:Event):void
        {
            ClientApplication.Instance.OpenCashShop(_item);
        }


    }
}//package hbm.Game.GUI.Inventory

