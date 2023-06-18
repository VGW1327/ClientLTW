


//hbm.Game.GUI.Vender.ShopPanel

package hbm.Game.GUI.Vender
{
    import org.aswing.JPanel;
    import org.aswing.GridLayout;
    import org.aswing.JScrollPane;
    import org.aswing.geom.IntDimension;
    import hbm.Engine.Actors.ItemData;
    import org.aswing.JLabel;
    import hbm.Application.ClientApplication;
    import org.aswing.AttachIcon;
    import hbm.Game.GUI.Store.*;

    public class ShopPanel extends JPanel 
    {

        public static const BUY_PANEL:int = 0;
        public static const SELL_PANEL:int = 1;

        private var _itemList:JPanel;
        private var _shopMode:int;

        public function ShopPanel(_arg_1:int)
        {
            this._shopMode = _arg_1;
            this._itemList = new JPanel(new GridLayout(0, 2, 4, 4));
            var _local_2:JScrollPane = new JScrollPane(this._itemList, JScrollPane.SCROLLBAR_ALWAYS);
            _local_2.setPreferredSize(new IntDimension(((0x0200 + 60) + 60), (128 + 45)));
            setDropTrigger(true);
            append(_local_2);
        }

        public function LoadItems(_arg_1:Array):void
        {
            var _local_2:ItemData;
            this._itemList.removeAll();
            if (_arg_1.length == 0)
            {
                this._itemList.append(new JLabel(ClientApplication.Localization.CASH_SHOP_GOODS_SOLD, new AttachIcon("AchtungIcon"), JLabel.CENTER));
            }
            else
            {
                for each (_local_2 in _arg_1)
                {
                    this._itemList.append(new ShopItemPanel(_local_2, this._shopMode));
                };
            };
            pack();
        }


    }
}//package hbm.Game.GUI.Vender

