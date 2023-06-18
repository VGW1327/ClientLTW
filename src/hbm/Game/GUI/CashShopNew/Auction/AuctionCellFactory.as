


//hbm.Game.GUI.CashShopNew.Auction.AuctionCellFactory

package hbm.Game.GUI.CashShopNew.Auction
{
    import org.aswing.ListCellFactory;
    import org.aswing.ListCell;

    public class AuctionCellFactory implements ListCellFactory 
    {


        public function isShareCells():Boolean
        {
            return (false);
        }

        public function isAllCellHasSameHeight():Boolean
        {
            return (false);
        }

        public function createNewCell():ListCell
        {
            return (new AuctionItemListCell());
        }

        public function getCellHeight():int
        {
            return (50);
        }


    }
}//package hbm.Game.GUI.CashShopNew.Auction

