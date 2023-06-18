


//hbm.Game.GUI.CashShop.Stash.VioletSellItemSlot

package hbm.Game.GUI.CashShop.Stash
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import flash.utils.Dictionary;
    import org.aswing.FlowLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.geom.IntDimension;
    import hbm.Game.GUI.DndTargets;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Game.GUI.*;

    public class VioletSellItemSlot extends JPanel 
    {

        private var _item:InventoryVioletSellItem;
        private var _tip:CustomToolTip;
        private var _checkDict:Dictionary;

        public function VioletSellItemSlot(_arg_1:Dictionary)
        {
            super(new FlowLayout());
            (getLayout() as FlowLayout).setMargin(false);
            setBorder(new EmptyBorder(null, new Insets(3, 26, 0, 0)));
            var _local_2:IntDimension = new IntDimension(61, 38);
            setPreferredSize(_local_2);
            setMaximumSize(_local_2);
            setSize(_local_2);
            setDropTrigger(true);
            putClientProperty(DndTargets.DND_TYPE, DndTargets.VIOLET_SELL_ITEM_SLOT);
            this._tip = new CustomToolTip(this, ClientApplication.Instance.GetPopupText(189), 250, 40);
            this._checkDict = _arg_1;
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
            };
        }

        public function get Item():InventoryVioletSellItem
        {
            return (this._item);
        }

        public function SetItem(_arg_1:ItemData):void
        {
            if (((this._item) && (this._checkDict[this._item.Item.NameId] == 1)))
            {
                this._checkDict[this._item.Item.NameId] = 0;
            };
            if (_arg_1 != null)
            {
                this._item = new InventoryVioletSellItem(_arg_1);
            }
            else
            {
                this._item = null;
            };
        }

        public function CheckItem(_arg_1:ItemData):Boolean
        {
            var _local_2:ItemsResourceLibrary;
            var _local_3:int;
            var _local_4:String;
            if (_arg_1)
            {
                _local_2 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
                _local_3 = _arg_1.Type;
                _local_4 = _local_2.GetServerDescriptionObject(_arg_1.NameId)["title_color"];
                if ((((!(_local_3 == ItemData.IT_WEAPON)) && (!(_local_3 == ItemData.IT_ARMOR))) || (!(_local_4 == "#8000FF"))))
                {
                    return (false);
                };
                if (this._checkDict[_arg_1.NameId] == 1)
                {
                    return (false);
                };
                this._checkDict[_arg_1.NameId] = 1;
            }
            else
            {
                this.SetItem(null);
                this.Revalidate();
                return (false);
            };
            return (true);
        }


    }
}//package hbm.Game.GUI.CashShop.Stash

