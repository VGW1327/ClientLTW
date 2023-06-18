


//hbm.Game.GUI.CashShop.KafraShopPanel

package hbm.Game.GUI.CashShop
{
    import org.aswing.JPanel;
    import org.aswing.GridLayout;
    import org.aswing.JScrollPane;
    import org.aswing.geom.IntDimension;
    import hbm.Engine.Actors.ItemData;
    import hbm.Application.ClientApplication;
    import org.aswing.JLabel;
    import org.aswing.AttachIcon;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Game.GUI.Store.*;
    import hbm.Game.GUI.Vender.*;

    public class KafraShopPanel extends JPanel 
    {

        private var _itemList:JPanel;
        private var _filter:Array;
        private var _buyPanelItems:Array;

        public function KafraShopPanel(_arg_1:Array, _arg_2:Boolean=false)
        {
            this._filter = _arg_1;
            this.InitUI(_arg_2);
        }

        protected function InitUI(_arg_1:Boolean):void
        {
            var _local_2:uint = ((_arg_1) ? (348 - 4) : (348 + 48));
            this._itemList = new JPanel(new GridLayout(0, 2, 4, 4));
            var _local_3:JScrollPane = new JScrollPane(this._itemList, JScrollPane.SCROLLBAR_ALWAYS);
            _local_3.setPreferredSize(new IntDimension(((0x0200 + 60) + 60), _local_2));
            append(_local_3);
        }

        public function LoadItems(_arg_1:Array):void
        {
            this._buyPanelItems = _arg_1;
            this.RevalidateItemsForJob(0, false);
            pack();
        }

        public function RevalidateItemsForJob(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_7:ItemData;
            var _local_8:Boolean;
            var _local_9:Object;
            var _local_10:Object;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:Object;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:String;
            var _local_19:Number;
            var _local_20:Number;
            var _local_3:Boolean = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerIsBabyClass();
            var _local_4:Number = (ClientApplication.Instance.timeOnServer * 1000);
            if (((_arg_1 < 0) || (_arg_1 >= ClientApplication.Localization.JOB_MAP0.length)))
            {
                return;
            };
            this._itemList.removeAll();
            if (this._filter.length == 0)
            {
                this._itemList.append(new JLabel(ClientApplication.Localization.CASH_SHOP_TEMPORARITY_CLOSED, new AttachIcon("StopIcon"), JLabel.CENTER));
                return;
            };
            var _local_5:int;
            var _local_6:ItemsResourceLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            for each (_local_7 in this._buyPanelItems)
            {
                _local_8 = false;
                if (_arg_2)
                {
                    _local_11 = _local_6.GetServerDescriptionObject(_local_7.NameId)["equip_level"];
                    if (_local_11 != 24) continue;
                };
                for each (_local_10 in this._filter)
                {
                    _local_9 = _local_10;
                    _local_12 = _local_10["begin"];
                    _local_13 = _local_10["end"];
                    if (((_local_7.NameId >= _local_12) && (_local_7.NameId <= _local_13)))
                    {
                        if (_arg_1 == 0)
                        {
                            _local_8 = true;
                            break;
                        };
                        _local_14 = _local_6.GetServerDescriptionObject(_local_7.NameId);
                        _local_15 = _local_14["equip_jobs"];
                        _local_16 = _local_14["equip_upper"];
                        _local_17 = ((_local_15 >> _arg_1) & 0x01);
                        if (_local_17 == 1)
                        {
                            if ((((_local_3) && (_local_16 & 0x04)) || ((!(_local_3)) && (_local_16 & 0x01))))
                            {
                                _local_8 = true;
                                break;
                            };
                        };
                    };
                };
                if (_local_8)
                {
                    _local_18 = _local_9["StartDate"];
                    if (_local_18 != null)
                    {
                        _local_19 = ClientApplication.Instance.ConvertDate(_local_18);
                        _local_20 = ClientApplication.Instance.ConvertDate(_local_9["EndDate"]);
                        if (!((((_local_19 > 0) && (_local_20 > 0)) && (_local_4 >= _local_19)) && (_local_4 < _local_20)))
                        {
                            _local_8 = false;
                        };
                    };
                };
                if (_local_8)
                {
                    this._itemList.append(new KafraShopItemPanel(_local_7));
                    _local_5++;
                };
            };
            if (_local_5 == 0)
            {
                this._itemList.append(new JLabel(ClientApplication.Localization.CASH_SHOP_GOODS_SOLD, new AttachIcon("AchtungIcon"), JLabel.CENTER));
            };
        }


    }
}//package hbm.Game.GUI.CashShop

