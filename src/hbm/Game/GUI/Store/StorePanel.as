


//hbm.Game.GUI.Store.StorePanel

package hbm.Game.GUI.Store
{
    import org.aswing.JPanel;
    import org.aswing.GridLayout;
    import org.aswing.JScrollPane;
    import org.aswing.geom.IntDimension;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Actors.ItemList;

    public class StorePanel extends JPanel 
    {

        public static const BUY_PANEL:int = 0;
        public static const SELL_PANEL:int = 1;

        private var _itemPanel:JPanel;
        private var _itemList:Array;
        private var _storeMode:int;

        public function StorePanel(_arg_1:int)
        {
            this._storeMode = _arg_1;
            this._itemPanel = new JPanel(new GridLayout(0, 2, 4, 4));
            if (this._storeMode == StorePanel.SELL_PANEL)
            {
                this._itemList = new Array();
            };
            var _local_2:JScrollPane = new JScrollPane(this._itemPanel, JScrollPane.SCROLLBAR_ALWAYS);
            _local_2.setPreferredSize(new IntDimension(((0x0200 + 60) + 60), (128 + 45)));
            setDropTrigger(true);
            append(_local_2);
        }

        public function LoadItems(_arg_1:Array):void
        {
            var _local_2:ItemData;
            var _local_3:StoreItemPanel;
            this._itemPanel.removeAll();
            if (this._storeMode == StorePanel.SELL_PANEL)
            {
                this._itemList = new Array();
            };
            for each (_local_2 in _arg_1)
            {
                _local_3 = new StoreItemPanel(_local_2, this._storeMode);
                this._itemPanel.append(_local_3);
                if (this._storeMode == StorePanel.SELL_PANEL)
                {
                    this._itemList.push(_local_3);
                };
            };
            pack();
        }

        public function GetItemGrid(_arg_1:int):StoreItemPanel
        {
            var _local_2:StoreItemPanel;
            var _local_3:uint;
            if (this._itemPanel)
            {
                _local_3 = 0;
                while (_local_3 < this._itemPanel.getComponentCount())
                {
                    _local_2 = (this._itemPanel.getComponent(_local_3) as StoreItemPanel);
                    if (((_local_2) && (_local_2.GetItemID() == _arg_1)))
                    {
                        return (_local_2);
                    };
                    _local_3++;
                };
            };
            return (null);
        }

        public function GetSelectedItems():Array
        {
            var _local_1:Array;
            var _local_2:StoreItemPanel;
            if (this._storeMode == StorePanel.SELL_PANEL)
            {
                _local_1 = new Array();
                for each (_local_2 in this._itemList)
                {
                    if (_local_2.SellEnabled)
                    {
                        _local_1.push(new ItemList(_local_2.StoreItem.Item.Id, _local_2.SelectedAmount, _local_2.StoreItem.Item.NameId));
                    };
                };
                if (_local_1.length > 0)
                {
                    return (_local_1);
                };
            };
            return (null);
        }


    }
}//package hbm.Game.GUI.Store

