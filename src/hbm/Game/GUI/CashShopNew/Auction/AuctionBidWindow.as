


//hbm.Game.GUI.CashShopNew.Auction.AuctionBidWindow

package hbm.Game.GUI.CashShopNew.Auction
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import hbm.Application.ClientApplication;
    import org.aswing.JLabel;
    import org.aswing.JPanel;
    import org.aswing.JAdjuster;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Game.GUI.Cart.InventoryVendingItem;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.SoftBoxLayout;
    import org.aswing.ASColor;
    import org.aswing.BoxLayout;
    import flash.display.Bitmap;
    import org.aswing.EmptyLayout;
    import org.aswing.geom.IntDimension;
    import org.aswing.AssetBackground;
    import org.aswing.Component;
    import org.aswing.CenterLayout;
    import org.aswing.AssetIcon;
    import hbm.Game.GUI.Tools.WindowSprites;
    import org.aswing.JButton;
    import org.aswing.Icon;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import flash.events.Event;

    public class AuctionBidWindow extends WindowPrototype 
    {

        private var _windowTitle:String = ClientApplication.Localization.AUCTION_BID_MSG1;
        private var _timeString:String = ClientApplication.Localization.AUCTION_REGISTRATION_MSG2;
        private var _nameString:String = ClientApplication.Localization.AUCTION_REGISTRATION_MSG3;
        private var _bidString:String = ClientApplication.Localization.AUCTION_BID_MSG2;
        private var _taxText:String = ClientApplication.Localization.AUCTION_BID_MSG3;
        private var _time:JLabel;
        private var _itemSlot:JPanel;
        private var _itemName:JLabel;
        private var _bidPrice:JAdjuster;
        private var _taxes:JLabel;
        private var _maxPrice:int;
        private var _minPrice:int;
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _localisationLib:LocalizationResourceLibrary;
        private var _itemsLibrary:ItemsResourceLibrary;
        private var _item:InventoryVendingItem;
        private var _auctionId:int;

        public function AuctionBidWindow(_arg_1:int=100, _arg_2:int=100000)
        {
            _width = 572;
            _height = 235;
            super(null, this._windowTitle, true, _width, _height, true);
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._localisationLib = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            this._itemsLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            this._maxPrice = _arg_2;
            this._minPrice = _arg_1;
            this.InitGUI();
        }

        private function InitGUI():void
        {
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            this._taxes = new JLabel("");
            this.PrepareLabel(this._taxes);
            this._taxes.setPreferredHeight(40);
            this._taxes.setForeground(ASColor.WHITE);
            this._taxes.setVerticalAlignment(JLabel.CENTER);
            _local_1.append(this.CreateInfoPanel());
            _local_1.append(this._taxes);
            Body.setLayout(new BoxLayout());
            Body.append(_local_1);
            Bottom.removeAll();
            Bottom.append(this.CreateConfirmButton());
            setLocationXY(((ClientApplication.stageWidth - _width) / 2), ((0x0300 - _height) / 2));
        }

        private function PrepareLabel(_arg_1:JLabel):void
        {
            _arg_1.setHorizontalAlignment(JLabel.CENTER);
            _arg_1.setVerticalAlignment(JLabel.CENTER);
        }

        private function CreateInfoPanel():Component
        {
            var _local_2:Bitmap;
            var _local_1:JPanel = new JPanel(new EmptyLayout());
            _local_2 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_BidAuctionBack");
            var _local_3:IntDimension = new IntDimension(_local_2.width, _local_2.height);
            _local_1.setBackgroundDecorator(new AssetBackground(_local_2));
            _local_1.setPreferredSize(_local_3);
            _local_1.setMinimumSize(_local_3);
            _local_1.setMaximumSize(_local_3);
            _local_1.append(this.CreateInfoHeader());
            _local_1.append(this.CreateInfo());
            return (_local_1);
        }

        private function CreateInfoHeader():Component
        {
            var _local_1:JPanel = new JPanel(new EmptyLayout());
            _local_1.setSizeWH(539, 27);
            _local_1.setLocationXY(3, 3);
            var _local_2:JLabel = new JLabel(this._timeString);
            this.PrepareLabel(_local_2);
            _local_2.setSizeWH(69, 24);
            _local_2.setLocationXY(3, 2);
            var _local_3:JLabel = new JLabel(this._nameString);
            this.PrepareLabel(_local_3);
            _local_3.setSizeWH(340, 24);
            _local_3.setLocationXY(73, 2);
            var _local_4:JLabel = new JLabel(this._bidString);
            _local_4.setPreferredWidth(90);
            this.PrepareLabel(_local_4);
            _local_4.setSizeWH(115, 24);
            _local_4.setLocationXY(425, 2);
            _local_1.append(_local_2);
            _local_1.append(_local_3);
            _local_1.append(_local_4);
            return (_local_1);
        }

        private function CreateInfo():Component
        {
            var _local_2:Bitmap;
            var _local_1:JPanel = new JPanel(new EmptyLayout());
            _local_1.setSizeWH(539, 45);
            _local_1.setLocationXY(3, 35);
            this._time = new JLabel();
            this.PrepareLabel(this._time);
            this._time.setSizeWH(69, 24);
            this._time.setLocationXY(1, 11);
            _local_2 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_SetAuctionItemBack");
            var _local_3:IntDimension = new IntDimension(_local_2.width, _local_2.height);
            this._itemSlot = new JPanel(new CenterLayout());
            this._itemSlot.setBackgroundDecorator(new AssetBackground(_local_2));
            this._itemSlot.setSize(_local_3);
            this._itemSlot.setLocationXY(73, 2);
            this._itemName = new JLabel("");
            this.PrepareLabel(this._itemName);
            this._itemName.setSizeWH(300, 24);
            this._itemName.setLocationXY(116, 11);
            this._bidPrice = new JAdjuster();
            this._bidPrice.setValues(1, 1, 1, (this._maxPrice + 1));
            this._bidPrice.setSizeWH(85, 22);
            this._bidPrice.setLocationXY(430, 11);
            var _local_4:JLabel = new JLabel("", new AssetIcon(new WindowSprites.CoinGold()));
            this.PrepareLabel(_local_4);
            _local_4.setSizeWH(13, 13);
            _local_4.setLocationXY(518, 16);
            _local_1.append(this._time);
            _local_1.append(this._itemSlot);
            _local_1.append(this._itemName);
            _local_1.append(this._bidPrice);
            _local_1.append(_local_4);
            return (_local_1);
        }

        public function CreateConfirmButton():Component
        {
            var _local_1:JPanel = new JPanel(new CenterLayout());
            _local_1.setPreferredSize(new IntDimension(330, 30));
            var _local_2:JButton = new JButton();
            _local_2.setIcon(this.GetADIcon("BidAuctionButtonInactive"));
            _local_2.setRollOverIcon(this.GetADIcon("BidAuctionButtonActive"));
            _local_2.setPressedIcon(this.GetADIcon("BidAuctionButtonPressed"));
            _local_2.setPreferredSize(new IntDimension(195, 29));
            _local_2.setOpaque(false);
            _local_2.addActionListener(this.OnConfirm, 0, true);
            _local_1.append(_local_2);
            return (_local_1);
        }

        private function GetADIcon(_arg_1:String):Icon
        {
            var _local_2:Bitmap = this._localisationLib.GetBitmapAsset(("Localization_Item_" + _arg_1));
            return (new AssetIcon(_local_2));
        }

        public function SetItem(_arg_1:Component):void
        {
            this._itemSlot.append(_arg_1);
        }

        public function SetName(_arg_1:String):void
        {
            this._itemName.setText(_arg_1);
        }

        public function BidItem(_arg_1:int, _arg_2:String, _arg_3:uint, _arg_4:ItemData):void
        {
            var _local_5:uint;
            if (_arg_4)
            {
                this._auctionId = _arg_1;
                this._item = new InventoryVendingItem(_arg_4);
                this._item.setDragEnabled(false);
                this._time.setText(_arg_2);
                this._minPrice = _arg_3;
                _local_5 = (this._minPrice + 50);
                if (_local_5 >= this._maxPrice)
                {
                    _local_5 = this._maxPrice;
                };
                this._bidPrice.setMinimum(_local_5);
                this._bidPrice.setValue(_local_5);
                this.SetItem(this._item);
                this.SetName((this._item.Refined + this._item.Name));
                this.SetDataToWindow();
                this.show();
            };
        }

        private function GetItemData(_arg_1:uint):ItemData
        {
            return (ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Items[_arg_1]);
        }

        private function SetDataToWindow():void
        {
            this._taxes.setText(this._taxText);
        }

        private function OnConfirm(event:Event):void
        {
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.AUCTION_BID_ITEM, function OnAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    ClientApplication.Instance.LocalGameClient.SendAuctionBid(_auctionId, _bidPrice.getValue());
                    dispose();
                };
            }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
        }

        override public function show():void
        {
            ClientApplication.Instance.SetShortcutsEnabled(false);
            super.show();
        }

        override public function dispose():void
        {
            ClientApplication.Instance.SetShortcutsEnabled(true);
            super.dispose();
        }


    }
}//package hbm.Game.GUI.CashShopNew.Auction

