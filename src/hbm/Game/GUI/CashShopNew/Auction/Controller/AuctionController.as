


//hbm.Game.GUI.CashShopNew.Auction.Controller.AuctionController

package hbm.Game.GUI.CashShopNew.Auction.Controller
{
    import hbm.Engine.Network.Client.Client;
    import hbm.Game.GUI.CashShopNew.Auction.AuctionPanel;
    import hbm.Game.GUI.CashShopNew.Auction.AuctionRegistrationWindow;
    import hbm.Game.GUI.CashShopNew.Auction.AuctionBidWindow;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Network.Events.AuctionEvent;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import hbm.Game.GUI.Inventory.InventoryItem;
    import hbm.Game.GUI.CashShopNew.StashAuctionWindow;

    public class AuctionController 
    {

        private var _gameClient:Client;
        private var _panel:AuctionPanel;
        private var _registrationWindow:AuctionRegistrationWindow;
        private var _bidWindow:AuctionBidWindow;

        public function AuctionController()
        {
            this._gameClient = ClientApplication.Instance.LocalGameClient;
            this._gameClient.addEventListener(AuctionEvent.ON_AUCTION_ITEM_SET, this.OnItemSetToAuction);
            this._gameClient.addEventListener(AuctionEvent.ON_AUCTION_LIST_RECEIVED, this.OnAuctionListReceived);
            this._gameClient.addEventListener(AuctionEvent.ON_AUCTION_MESSAGE, this.OnAuctionMessage);
        }

        public function RefreshAuctionsList(_arg_1:int):void
        {
            var _local_2:int = AuctionSearchType.PRICE;
            this._gameClient.SendAuctionSearch(_local_2, 100000, "", _arg_1);
        }

        private function OnAuctionListReceived(_arg_1:AuctionEvent):void
        {
            if (this._panel)
            {
                this._panel.SetData(_arg_1.AuctionList, _arg_1.Pages);
            };
        }

        public function OnItemSetToAuction(_arg_1:AuctionEvent):void
        {
            if (_arg_1.Flag)
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_ERROR_TITLE, ClientApplication.Localization.AUCTION_SET_ITEM_ERROR, null, null, true, new AttachIcon("AchtungIcon")));
            }
            else
            {
                this.OpenAuctionRegistration(_arg_1.ItemID);
            };
        }

        public function Open(_arg_1:AuctionPanel):void
        {
            this._panel = _arg_1;
            var _local_2:int = AuctionSearchType.PRICE;
            ClientApplication.Instance.LocalGameClient.SendAuctionSearch(_local_2, 100000, "", 1);
        }

        public function OpenAuctionRegistration(_arg_1:uint):void
        {
            if (((this._registrationWindow) && (this._registrationWindow.isShowing())))
            {
                this._registrationWindow.dispose();
            };
            this._registrationWindow = new AuctionRegistrationWindow();
            this._registrationWindow.RegisterItem(_arg_1);
        }

        public function OpenAuctionBid(_arg_1:int, _arg_2:String, _arg_3:uint, _arg_4:InventoryItem):void
        {
            if (((this._bidWindow) && (this._bidWindow.isShowing())))
            {
                this._bidWindow.dispose();
            };
            this._bidWindow = new AuctionBidWindow();
            this._bidWindow.BidItem(_arg_1, _arg_2, _arg_3, _arg_4.Item);
        }

        public function OnAuctionMessage(_arg_1:AuctionEvent):void
        {
            var _local_2:String;
            var _local_3:StashAuctionWindow = ClientApplication.Instance.StashAuction;
            if (((!(_local_3 == null)) && (_local_3.isShowing())))
            {
                this._panel.TurnToPage(1);
            };
            switch (_arg_1.Flag)
            {
                case 0:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE0;
                    break;
                case 1:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE1;
                    return;
                case 2:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE2;
                    break;
                case 3:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE3;
                    break;
                case 4:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE4;
                    break;
                case 5:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE5;
                    break;
                case 6:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE6;
                    break;
                case 7:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE7;
                    break;
                case 8:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE8;
                    break;
                case 9:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE9;
                    break;
                case 10:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE10;
                    break;
                case 11:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE11;
                    break;
                case 12:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE12;
                    break;
                case 13:
                    _local_2 = ClientApplication.Localization.AUCTION_MESSAGE13;
                    break;
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, _local_2, null, null, true, new AttachIcon("AchtungIcon"), JOptionPane.OK));
        }


    }
}//package hbm.Game.GUI.CashShopNew.Auction.Controller

