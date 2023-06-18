


//hbm.Game.GUI.CashShopNew.Auction.AuctionRegistrationWindow

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
    import hbm.Game.GUI.Inventory.InventoryItem;
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
    import flash.events.Event;
    import org.aswing.JButton;
    import org.aswing.Icon;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.Cart.InventoryVendingItem;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;

    public class AuctionRegistrationWindow extends WindowPrototype 
    {

        private var _windowTitle:String = ClientApplication.Localization.AUCTION_REGISTRATION_MSG1;
        private var _timeString:String = ClientApplication.Localization.AUCTION_REGISTRATION_MSG2;
        private var _nameString:String = ClientApplication.Localization.AUCTION_REGISTRATION_MSG3;
        private var _buyoutPriceString:String = ClientApplication.Localization.AUCTION_REGISTRATION_MSG4;
        private var _startPriceString:String = ClientApplication.Localization.AUCTION_REGISTRATION_MSG7;
        private var _taxText:String = ClientApplication.Localization.AUCTION_REGISTRATION_MSG6;
        private var _timeVal:String = ClientApplication.Localization.AUCTION_REGISTRATION_MSG5;
        private var _time:JLabel;
        private var _itemSlot:JPanel;
        private var _itemName:JLabel;
        private var _startPrice:JAdjuster;
        private var _buyoutPrice:JAdjuster;
        private var _taxes:JLabel;
        private var _maxPrice:int;
        private var _minPrice:int;
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _localisationLib:LocalizationResourceLibrary;
        private var _itemsLibrary:ItemsResourceLibrary;
        private var _defaultTimeoutHours:int = 24;
        private var _item:InventoryItem;

        public function AuctionRegistrationWindow(_arg_1:int=100, _arg_2:int=100000)
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
            this._taxes.setForeground(ASColor.GRAY);
            this._taxes.setVerticalAlignment(JLabel.CENTER);
            _local_1.append(this.CreateInfoPanel());
            _local_1.append(this._taxes);
            Body.setLayout(new BoxLayout());
            Body.append(_local_1);
            Bottom.removeAll();
            Bottom.append(this.CreateConfirmButton());
            setLocationXY(((ClientApplication.stageWidth - _width) / 2), (((0x0300 - _height) / 2) - 100));
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
            _local_2 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_SetAuctionInfoBack");
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
            _local_3.setSizeWH(233, 24);
            _local_3.setLocationXY(73, 2);
            var _local_4:JLabel = new JLabel(this._startPriceString);
            _local_4.setPreferredWidth(90);
            this.PrepareLabel(_local_4);
            _local_4.setSizeWH(115, 24);
            _local_4.setLocationXY(306, 2);
            var _local_5:JLabel = new JLabel(this._buyoutPriceString);
            _local_5.setPreferredWidth(90);
            this.PrepareLabel(_local_5);
            _local_5.setSizeWH(115, 24);
            _local_5.setLocationXY(425, 2);
            _local_1.append(_local_2);
            _local_1.append(_local_3);
            _local_1.append(_local_4);
            _local_1.append(_local_5);
            return (_local_1);
        }

        private function CreateInfo():Component
        {
            var _local_2:Bitmap;
            var _local_1:JPanel = new JPanel(new EmptyLayout());
            _local_1.setSizeWH(539, 45);
            _local_1.setLocationXY(3, 35);
            this._time = new JLabel(this._timeVal);
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
            this._itemName.setSizeWH(187, 24);
            this._itemName.setLocationXY(116, 11);
            this._startPrice = new JAdjuster();
            this._startPrice.setValues(this._minPrice, 1, this._minPrice, this._maxPrice);
            this._startPrice.setSizeWH(85, 22);
            this._startPrice.setLocationXY(313, 11);
            this._startPrice.addStateListener(this.OnStateChanged1, 0, true);
            var _local_4:JLabel = new JLabel("", new AssetIcon(new WindowSprites.CoinGold()));
            this.PrepareLabel(_local_4);
            _local_4.setSizeWH(13, 13);
            _local_4.setLocationXY(400, 16);
            this._buyoutPrice = new JAdjuster();
            this._buyoutPrice.setValues((this._minPrice + 1), 1, (this._minPrice + 1), (this._maxPrice + 1));
            this._buyoutPrice.setSizeWH(85, 22);
            this._buyoutPrice.setLocationXY(430, 11);
            this._buyoutPrice.addStateListener(this.OnStateChanged2, 0, true);
            var _local_5:JLabel = new JLabel("", new AssetIcon(new WindowSprites.CoinGold()));
            this.PrepareLabel(_local_5);
            _local_5.setSizeWH(13, 13);
            _local_5.setLocationXY(518, 16);
            _local_1.append(this._time);
            _local_1.append(this._itemSlot);
            _local_1.append(this._itemName);
            _local_1.append(this._startPrice);
            _local_1.append(_local_4);
            _local_1.append(this._buyoutPrice);
            _local_1.append(_local_5);
            return (_local_1);
        }

        private function OnStateChanged1(_arg_1:Event):void
        {
            if (this._buyoutPrice.getValue() <= (this._startPrice.getValue() + 50))
            {
                this._buyoutPrice.setValue((this._startPrice.getValue() + 50));
            };
        }

        private function OnStateChanged2(_arg_1:Event):void
        {
            if (this._buyoutPrice.getValue() <= (this._startPrice.getValue() + 50))
            {
                this._startPrice.setValue((this._buyoutPrice.getValue() - 50));
            };
        }

        public function CreateConfirmButton():Component
        {
            var _local_1:JPanel = new JPanel(new CenterLayout());
            _local_1.setPreferredSize(new IntDimension(330, 30));
            var _local_2:JButton = new JButton();
            _local_2.setIcon(this.GetADIcon("SetAuctionConfirmButtonInactive"));
            _local_2.setRollOverIcon(this.GetADIcon("SetAuctionConfirmButtonActive"));
            _local_2.setPressedIcon(this.GetADIcon("SetAuctionConfirmButtonPressed"));
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

        public function SetTime(_arg_1:String):void
        {
            this._time.setText(_arg_1);
        }

        public function SetItem(_arg_1:Component):void
        {
            this._itemSlot.append(_arg_1);
        }

        public function SetName(_arg_1:String):void
        {
            this._itemName.setText(_arg_1);
        }

        public function GetStartPrice():uint
        {
            return (this._startPrice.getValue());
        }

        public function GetBuyoutPrice():uint
        {
            return (this._buyoutPrice.getValue());
        }

        public function RegisterItem(_arg_1:uint):void
        {
            var _local_2:ItemData = this.GetItemData(_arg_1);
            if (_local_2)
            {
                this._item = new InventoryVendingItem(_local_2);
                this._item.setDragEnabled(false);
                this._startPrice.setMinimum(this._minPrice);
                this._buyoutPrice.setMinimum(this.GetMinBuyoutPrice(_local_2.NameId, _local_2.Type));
                this.SetDataToWindow();
                this.show();
            };
        }

        private function GetMinBuyoutPrice(_arg_1:int, _arg_2:int):uint
        {
            var _local_3:int = this._itemsLibrary.GetItemColorType(_arg_1);
            var _local_4:* = 200;
            if (((_arg_2 == ItemData.IT_ARMOR) || (_arg_2 == ItemData.IT_WEAPON)))
            {
                switch (_local_3)
                {
                    case ItemData.ICT_GREEN:
                    case ItemData.ICT_BLUE:
                    case ItemData.ICT_VIOLET:
                    case ItemData.ICT_RED:
                    case ItemData.ICT_ORANGE:
                    case ItemData.ICT_GRAY:
                    case ItemData.ICT_KAFRA:
                        break;
                    case ItemData.ICT_SILVER:
                        _local_4 = 250;
                        break;
                    case ItemData.ICT_GOLD:
                        _local_4 = 500;
                        break;
                    case ItemData.ICT_VIP:
                        _local_4 = 20000;
                        break;
                };
            }
            else
            {
                _local_4 = 200;
            };
            return (_local_4);
        }

        private function GetItemData(_arg_1:uint):ItemData
        {
            return (ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Items[_arg_1]);
        }

        private function SetDataToWindow():void
        {
            if (!this._item)
            {
                return;
            };
            this.SetItem(this._item);
            this.SetName((this._item.Refined + this._item.Name));
            this._taxes.setText(this._taxText);
        }

        private function OnConfirm(event:Event):void
        {
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.AUCTION_REGISTER_ITEM, function OnAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    ClientApplication.Instance.LocalGameClient.SendAuctionRegister(_startPrice.getValue(), _buyoutPrice.getValue(), _defaultTimeoutHours);
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
            ClientApplication.Instance.LocalGameClient.SendAuctionCancelReg();
            ClientApplication.Instance.SetShortcutsEnabled(true);
            super.dispose();
        }


    }
}//package hbm.Game.GUI.CashShopNew.Auction

