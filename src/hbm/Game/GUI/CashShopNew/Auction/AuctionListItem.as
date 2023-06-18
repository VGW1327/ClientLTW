


//hbm.Game.GUI.CashShopNew.Auction.AuctionListItem

package hbm.Game.GUI.CashShopNew.Auction
{
    import org.aswing.JPanel;
    import org.aswing.JLabel;
    import hbm.Game.GUI.Inventory.InventoryItem;
    import hbm.Game.GUI.CashShopNew.CustomLabel;
    import hbm.Game.GUI.CashShopNew.ButtonPrototype;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.Bitmap;
    import org.aswing.EmptyLayout;
    import org.aswing.geom.IntDimension;
    import org.aswing.AssetBackground;
    import org.aswing.CenterLayout;
    import org.aswing.ASFont;
    import org.aswing.AssetIcon;
    import hbm.Game.GUI.Tools.WindowSprites;
    import org.aswing.Icon;
    import org.aswing.Component;
    import flash.filters.ColorMatrixFilter;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import hbm.Application.ClientApplication;
    import org.aswing.AttachIcon;
    import flash.events.Event;

    public class AuctionListItem extends JPanel 
    {

        private var _auctionId:int;
        private var _bid:int;
        private var _buyout:int;
        private var _timeRemaining:JLabel;
        private var _itemSlot:JPanel;
        private var _item:InventoryItem;
        private var _itemName:CustomLabel;
        private var _bidPrice:JLabel;
        private var _buyer:JLabel;
        private var _buyoutPrice:JLabel;
        private var _seller:String;
        private var _selfLot:Boolean;
        private var _bidButton:ButtonPrototype;
        private var _cancelButton:ButtonPrototype;
        private var _buyButton:ButtonPrototype;
        private var _graphicsLib:AdditionalDataResourceLibrary;
        private var _localisationLib:LocalizationResourceLibrary;

        public function AuctionListItem()
        {
            this._graphicsLib = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._localisationLib = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            this.InitUI();
        }

        public function DisableActionButtons():void
        {
            this._bidButton.setEnabled(false);
            this._cancelButton.setEnabled(false);
            this._buyButton.setEnabled(false);
        }

        private function InitUI():void
        {
            var _local_1:Bitmap;
            setLayout(new EmptyLayout());
            _local_1 = this._graphicsLib.GetBitmapAsset("AdditionalData_Item_AuctionPanelRow");
            var _local_2:IntDimension = new IntDimension(_local_1.width, _local_1.height);
            setPreferredSize(_local_2);
            setMinimumSize(_local_2);
            setMaximumSize(_local_2);
            setBackgroundDecorator(new AssetBackground(_local_1));
            this._timeRemaining = new JLabel("");
            this.PrepareLabel(this._timeRemaining);
            this._timeRemaining.setSizeWH(73, 35);
            this._timeRemaining.setLocationXY(1, 10);
            this._itemSlot = new JPanel(new CenterLayout());
            this._itemSlot.setSizeWH(40, 40);
            this._itemSlot.setLocationXY(81, 7);
            var _local_3:ASFont = new ASFont(getFont().getName(), 12);
            this._itemName = new CustomLabel("", _local_3);
            this._itemName.setSizeWH(215, 40);
            this._itemName.setLocationXY(120, 10);
            this._bidPrice = new JLabel("");
            this._bidPrice.setSizeWH(90, 35);
            this._bidPrice.setLocationXY(331, 10);
            this._bidPrice.setIcon(new AssetIcon(new WindowSprites.CoinGold()));
            this.PrepareLabel(this._bidPrice);
            this._bidPrice.setHorizontalTextPosition(JLabel.LEFT);
            this._buyer = new JLabel("");
            this._buyer.setSizeWH(90, 24);
            this._buyer.setLocationXY(331, 28);
            this.PrepareLabel(this._buyer);
            this._buyoutPrice = new JLabel("");
            this._buyoutPrice.setSizeWH(62, 35);
            this._buyoutPrice.setLocationXY(481, 10);
            this._buyoutPrice.setIcon(new AssetIcon(new WindowSprites.CoinGold()));
            this.PrepareLabel(this._buyoutPrice);
            this._buyoutPrice.setHorizontalTextPosition(JLabel.LEFT);
            append(this._timeRemaining);
            append(this._itemSlot);
            append(this._itemName);
            append(this._bidPrice);
            append(this._buyer);
            append(this._buyoutPrice);
            append(this.CreateBidButton());
            append(this.CreateBuyoutButton());
            append(this.CreateCancelButton());
        }

        private function CreateBidButton():Component
        {
            this._bidButton = new ButtonPrototype();
            this._bidButton.setSizeWH(61, 49);
            this._bidButton.setLocationXY(420, 1);
            this._bidButton.setIcon(this.GetAD2Icon("AuctionBidButtonInactive"));
            this._bidButton.setRollOverIcon(this.GetAD2Icon("AuctionBidButtonActive"));
            this._bidButton.setPressedIcon(this.GetAD2Icon("AuctionBidButtonPressed"));
            var _local_1:Icon = this.GetDisableAD2Icon("AuctionBidButtonInactive");
            this._bidButton.setDisabledIcon(_local_1);
            this._bidButton.addActionListener(this.OnBidButton);
            return (this._bidButton);
        }

        private function CreateBuyoutButton():Component
        {
            this._buyButton = new ButtonPrototype();
            this._buyButton.setSizeWH(100, 49);
            this._buyButton.setLocationXY(542, 1);
            this._buyButton.setIcon(this.GetADIcon("AuctionBuyoutButtonInactive"));
            this._buyButton.setRollOverIcon(this.GetADIcon("AuctionBuyoutButtonActive"));
            this._buyButton.setPressedIcon(this.GetADIcon("AuctionBuyoutButtonPressed"));
            var _local_1:Icon = this.GetDisableADIcon("AuctionBuyoutButtonInactive");
            this._buyButton.setDisabledIcon(_local_1);
            this._buyButton.addActionListener(this.OnBuyButton);
            return (this._buyButton);
        }

        private function CreateCancelButton():Component
        {
            this._cancelButton = new ButtonPrototype();
            this._cancelButton.setSizeWH(100, 49);
            this._cancelButton.setLocationXY(542, 1);
            this._cancelButton.setIcon(this.GetADIcon("AuctionCancelButtonInactive"));
            this._cancelButton.setRollOverIcon(this.GetADIcon("AuctionCancelButtonActive"));
            this._cancelButton.setPressedIcon(this.GetADIcon("AuctionCancelButtonPressed"));
            var _local_1:Icon = this.GetDisableADIcon("AuctionCancelButtonInactive");
            this._cancelButton.setDisabledIcon(_local_1);
            this._cancelButton.addActionListener(this.OnCancelButton);
            return (this._cancelButton);
        }

        private function GetADIcon(_arg_1:String):Icon
        {
            var _local_2:Bitmap = this._localisationLib.GetBitmapAsset(("Localization_Item_" + _arg_1));
            return (new AssetIcon(_local_2));
        }

        private function GetDisableADIcon(_arg_1:String):Icon
        {
            var _local_3:Array;
            var _local_2:Bitmap = this._localisationLib.GetBitmapAsset(("Localization_Item_" + _arg_1));
            _local_3 = [0.33, 0.59, 0.11, 0, 0, 0.33, 0.59, 0.11, 0, 0, 0.33, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
            var _local_4:ColorMatrixFilter = new ColorMatrixFilter(_local_3);
            _local_2.filters = [_local_4];
            return (new AssetIcon(_local_2));
        }

        private function GetAD2Icon(_arg_1:String):Icon
        {
            var _local_2:Bitmap = this._graphicsLib.GetBitmapAsset(("AdditionalData_Item_" + _arg_1));
            return (new AssetIcon(_local_2));
        }

        private function GetDisableAD2Icon(_arg_1:String):Icon
        {
            var _local_3:Array;
            var _local_2:Bitmap = this._graphicsLib.GetBitmapAsset(("AdditionalData_Item_" + _arg_1));
            _local_3 = [0.33, 0.59, 0.11, 0, 0, 0.33, 0.59, 0.11, 0, 0, 0.33, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
            var _local_4:ColorMatrixFilter = new ColorMatrixFilter(_local_3);
            _local_2.filters = [_local_4];
            return (new AssetIcon(_local_2));
        }

        private function OnBidButton(_arg_1:Event):void
        {
            if (this._selfLot)
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.AUCTION_ERROR_BID, null, null, true, new AttachIcon("AchtungIcon")));
                return;
            };
            ClientApplication.Instance.AuctionInstance.OpenAuctionBid(this._auctionId, this._timeRemaining.getText(), this._bid, this._item);
        }

        private function OnBuyButton(event:Event):void
        {
            if (this._selfLot)
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.AUCTION_ERROR_BUY, null, null, true, new AttachIcon("AchtungIcon")));
                return;
            };
            var msg:String = ((ClientApplication.Localization.AUCTION_BUY_ITEM + "") + this._buyout);
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, msg, function OnAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    ClientApplication.Instance.LocalGameClient.SendAuctionBid(_auctionId, _buyout);
                };
            }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
        }

        private function OnCancelButton(event:Event):void
        {
            if (this._selfLot)
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.AUCTION_CANCEL_ITEM, function OnAccepted (_arg_1:int):void
                {
                    if (_arg_1 == JOptionPane.YES)
                    {
                        ClientApplication.Instance.LocalGameClient.SendAuctionCancel(_auctionId);
                    };
                }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            };
        }

        public function SetAuctionId(_arg_1:int):void
        {
            this._auctionId = _arg_1;
        }

        public function SetName(_arg_1:String):void
        {
            this._itemName.setText(_arg_1);
        }

        public function SetBidPrice(_arg_1:int):void
        {
            this._bid = _arg_1;
            this._bidPrice.setText(_arg_1.toString());
        }

        public function SetBuyoutPrice(_arg_1:int):void
        {
            this._buyout = _arg_1;
            this._buyoutPrice.setText(_arg_1.toString());
        }

        public function SetTime(_arg_1:String):void
        {
            this._timeRemaining.setText(_arg_1);
        }

        public function SetItemIcon(_arg_1:InventoryItem):void
        {
            this._item = _arg_1;
            this._itemSlot.removeAll();
            this._itemSlot.append(_arg_1);
        }

        public function set Seller(_arg_1:String):void
        {
            this._seller = _arg_1;
        }

        public function set Buyer(_arg_1:String):void
        {
            this._buyer.setText(_arg_1);
            if (((_arg_1) && (_arg_1.length > 0)))
            {
                this._bidPrice.setLocationXY(331, 3);
            };
        }

        public function set SelfLot(_arg_1:Boolean):void
        {
            this._selfLot = _arg_1;
            this._buyButton.visible = (!(_arg_1));
            this._cancelButton.visible = _arg_1;
        }

        private function PrepareLabel(_arg_1:JLabel):void
        {
            _arg_1.setHorizontalAlignment(JLabel.CENTER);
            _arg_1.setVerticalAlignment(JLabel.CENTER);
        }


    }
}//package hbm.Game.GUI.CashShopNew.Auction

