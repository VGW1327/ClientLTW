


//hbm.Game.GUI.CashShopNew.Auction.AuctionItemListCell

package hbm.Game.GUI.CashShopNew.Auction
{
    import org.aswing.ListCell;
    import org.aswing.Component;
    import hbm.Engine.Actors.AuctionLot;
    import hbm.Game.GUI.Inventory.InventoryItem;
    import hbm.Game.GUI.Cart.InventoryVendingItem;
    import hbm.Application.ClientApplication;
    import org.aswing.JList;

    public class AuctionItemListCell implements ListCell 
    {

        private var _rowPanel:AuctionListItem;

        public function AuctionItemListCell()
        {
            this._rowPanel = new AuctionListItem();
        }

        public function getCellValue():*
        {
            return (null);
        }

        public function getCellComponent():Component
        {
            return (this._rowPanel);
        }

        public function setCellValue(_arg_1:*):void
        {
            var _local_2:AuctionLot;
            var _local_3:InventoryItem;
            var _local_4:String;
            var _local_5:uint;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            if (((_arg_1) && (_arg_1 is AuctionLot)))
            {
                _local_2 = (_arg_1 as AuctionLot);
                _local_3 = new InventoryVendingItem(_local_2.Item);
                _local_3.setDragEnabled(false);
                this._rowPanel.SetAuctionId(_local_2.AuctionId);
                this._rowPanel.SetBidPrice(_local_2.BidPrice);
                this._rowPanel.SetBuyoutPrice(_local_2.BuyoutPrice);
                this._rowPanel.SetName((_local_3.Refined + _local_3.Name));
                this._rowPanel.SetItemIcon(_local_3);
                this._rowPanel.Buyer = _local_2.BuyerName;
                this._rowPanel.Seller = _local_2.SellerName;
                this._rowPanel.SelfLot = _local_2.SelfLot;
                _local_4 = "";
                if (_local_2.TimeStamp > ClientApplication.Instance.timeOnServer)
                {
                    _local_5 = (_local_2.TimeStamp - ClientApplication.Instance.timeOnServer);
                    if (_local_5 >= 86400)
                    {
                        _local_6 = int(int((_local_5 / 86400)));
                        _local_4 = (_local_4 + (((_local_6 + " ") + ClientApplication.Localization.TIME_DAYS) + " "));
                        _local_5 = (_local_5 - (_local_6 * 86400));
                    };
                    if (_local_5 >= 3600)
                    {
                        _local_7 = int(int((_local_5 / 3600)));
                        _local_4 = (_local_4 + (((_local_7 + " ") + ClientApplication.Localization.TIME_HOURS) + " "));
                        _local_5 = (_local_5 - (_local_7 * 3600));
                    };
                    if (_local_5 >= 60)
                    {
                        _local_8 = int(int((_local_5 / 60)));
                        _local_4 = (_local_4 + (((_local_8 + " ") + ClientApplication.Localization.TIME_MINUTES) + " "));
                    };
                }
                else
                {
                    this._rowPanel.DisableActionButtons();
                    _local_4 = ClientApplication.Localization.TIME_IS_UP;
                };
                this._rowPanel.SetTime(_local_4);
            };
        }

        public function setListCellStatus(_arg_1:JList, _arg_2:Boolean, _arg_3:int):void
        {
        }


    }
}//package hbm.Game.GUI.CashShopNew.Auction

