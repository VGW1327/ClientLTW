


//hbm.Game.GUI.CashShop.Stash.VioletSellPanel

package hbm.Game.GUI.CashShop.Stash
{
    import org.aswing.JPanel;
    import flash.utils.Dictionary;
    import org.aswing.JLabel;
    import hbm.Game.GUI.Tools.CustomButton;
    import flash.display.Bitmap;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import org.aswing.ASFont;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Application.ClientApplication;
    import hbm.Game.Utility.AsWingUtil;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.BorderLayout;
    import org.aswing.AssetIcon;
    import org.aswing.geom.IntDimension;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import flash.events.Event;

    public class VioletSellPanel extends JPanel 
    {

        private var _itemSlots:Array;
        private var _checkDict:Dictionary;
        private var _descriptionText:JLabel;
        private var _buttonSell:CustomButton;
        private var _buttonSellIcon:Bitmap = null;
        private var _buttonSellIconActive:Bitmap = null;
        private var _descriptionTextStr:String;

        public function VioletSellPanel()
        {
            this.InitUI();
            this.Revalidate();
        }

        protected function InitUI():void
        {
            var _local_2:JPanel;
            var _local_4:LocalizationResourceLibrary;
            var _local_8:ASFont;
            var _local_12:VioletSellItemSlot;
            setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, SoftBoxLayout.CENTER));
            setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            var _local_1:JLabel = new JLabel(ClientApplication.Localization.VIOLET_SELL_WINDOW_TITLE, null, JLabel.LEFT);
            AsWingUtil.SetBorder(_local_1, 0, 5, 24);
            _local_2 = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 15));
            var _local_3:AdditionalDataResourceLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            _local_4 = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            this._itemSlots = new Array();
            this._checkDict = new Dictionary(true);
            AsWingUtil.SetBorder(_local_2, 104, 17);
            var _local_5:int;
            while (_local_5 < 5)
            {
                _local_12 = new VioletSellItemSlot(this._checkDict);
                _local_12.Revalidate();
                this._itemSlots.push(_local_12);
                _local_2.append(_local_12);
                _local_5++;
            };
            var _local_6:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, SoftBoxLayout.TOP));
            AsWingUtil.SetBackground(this, _local_3.GetBitmapAsset("AdditionalData_Item_Stash_Lombard"));
            _local_6.append(AsWingUtil.AlignCenter(_local_1));
            var _local_7:int = 2;
            this._descriptionTextStr = (((((((ClientApplication.Localization.VIOLET_SELL_WINDOW_ITEM_SLOT_HINT + " (") + ClientApplication.Localization.VIOLET_SELL_WINDOW_RESULT_MESSAGE) + " ") + _local_7.toString()) + " ") + ClientApplication.Localization.VIOLET_SELL_WINDOW_RESULT_GOLD) + ")");
            this._descriptionText = new JLabel(this._descriptionTextStr, null, JLabel.LEFT);
            this._descriptionText.setBorder(new EmptyBorder(null, new Insets(15, 105, 0, 0)));
            _local_8 = this._descriptionText.getFont();
            var _local_9:ASFont = new ASFont(_local_8.getName(), 12, true);
            this._descriptionText.setFont(_local_9);
            var _local_10:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBorder(_local_10, 0, 10, 20);
            this._buttonSell = new CustomButton("");
            this._buttonSell.buttonMode = true;
            this._buttonSellIcon = _local_4.GetBitmapAsset("Localization_Item_Stash_SellButton");
            this._buttonSellIconActive = _local_4.GetBitmapAsset("Localization_Item_Stash_SellButtonActive");
            this._buttonSell.setIcon(new AssetIcon(this._buttonSellIcon));
            this._buttonSell.setRollOverIcon(new AssetIcon(_local_4.GetBitmapAsset("Localization_Item_Stash_SellButtonOver")));
            this._buttonSell.setPressedIcon(new AssetIcon(_local_4.GetBitmapAsset("Localization_Item_Stash_SellButtonPressed")));
            this._buttonSell.setBackgroundDecorator(null);
            this._buttonSell.setSize(new IntDimension(this._buttonSellIcon.width, this._buttonSellIcon.height));
            this._buttonSell.addActionListener(this.OnSell, 0, true);
            var _local_11:CustomToolTip = new CustomToolTip(this._buttonSell, ClientApplication.Instance.GetPopupText(187), 220, 40);
            _local_10.append(this._buttonSell);
            _local_6.append(_local_2);
            _local_6.append(this._descriptionText);
            _local_6.append(AsWingUtil.AlignCenter(_local_10));
            append(_local_6);
        }

        private function OnSell(_arg_1:Event):void
        {
            if ((((((this._itemSlots[0].Item) && (this._itemSlots[1].Item)) && (this._itemSlots[2].Item)) && (this._itemSlots[3].Item)) && (this._itemSlots[4].Item)))
            {
                ClientApplication.Instance.LocalGameClient.SendVioletSell(this._itemSlots[0].Item.Item.Id, this._itemSlots[1].Item.Item.Id, this._itemSlots[2].Item.Item.Id, this._itemSlots[3].Item.Item.Id, this._itemSlots[4].Item.Item.Id);
                this.ClearSellSlots();
            };
        }

        private function ClearSellSlots():void
        {
            var _local_1:VioletSellItemSlot;
            for each (_local_1 in this._itemSlots)
            {
                _local_1.SetItem(null);
                _local_1.Revalidate();
            };
        }

        public function ClearSlot(_arg_1:InventoryVioletSellItem):void
        {
            var _local_2:VioletSellItemSlot;
            for each (_local_2 in this._itemSlots)
            {
                if (((_local_2.Item) && (_local_2.Item.Item.NameId == _arg_1.Item.NameId)))
                {
                    _local_2.SetItem(null);
                    _local_2.Revalidate();
                };
            };
        }

        public function Revalidate():void
        {
            var _local_3:VioletSellItemSlot;
            var _local_4:*;
            var _local_1:Boolean = true;
            var _local_2:int;
            for each (_local_3 in this._itemSlots)
            {
                if (!_local_3)
                {
                    _local_1 = false;
                    break;
                };
            };
            for each (_local_4 in this._checkDict)
            {
                if (_local_4 == 1)
                {
                    _local_2++;
                };
            };
            _local_1 = ((_local_1) && (_local_2 == this._itemSlots.length));
            if (!_local_1)
            {
                this._descriptionText.setText(this._descriptionTextStr);
            };
            if (this._buttonSell != null)
            {
                this._buttonSell.setEnabled(_local_1);
                if (_local_1)
                {
                    this._buttonSell.setIcon(new AssetIcon(this._buttonSellIconActive));
                }
                else
                {
                    this._buttonSell.setIcon(new AssetIcon(this._buttonSellIcon));
                };
            };
        }


    }
}//package hbm.Game.GUI.CashShop.Stash

