


//hbm.Engine.Actors.AuctionLot

package hbm.Engine.Actors
{
    public class AuctionLot 
    {

        private var _auctionId:uint;
        private var _sellerName:String;
        private var _auctionType:uint;
        private var _bidPrice:uint;
        private var _buyoutPrice:uint;
        private var _buyerName:String;
        private var _timeStamp:uint;
        private var _selfLot:Boolean;
        private var _item:ItemData;

        public function AuctionLot(_arg_1:int, _arg_2:uint, _arg_3:uint, _arg_4:uint, _arg_5:ItemData)
        {
            this._auctionId = _arg_1;
            this._bidPrice = _arg_2;
            this._buyoutPrice = _arg_3;
            this._timeStamp = _arg_4;
            this._item = _arg_5;
        }

        public function get AuctionId():uint
        {
            return (this._auctionId);
        }

        public function get SellerName():String
        {
            return (this._sellerName);
        }

        public function set SellerName(_arg_1:String):void
        {
            this._sellerName = _arg_1;
        }

        public function get AuctionType():uint
        {
            return (this._auctionType);
        }

        public function set AuctionType(_arg_1:uint):void
        {
            this._auctionType = _arg_1;
        }

        public function get BidPrice():uint
        {
            return (this._bidPrice);
        }

        public function set BidPrice(_arg_1:uint):void
        {
            this._bidPrice = _arg_1;
        }

        public function get BuyoutPrice():uint
        {
            return (this._buyoutPrice);
        }

        public function set BuyoutPrice(_arg_1:uint):void
        {
            this._buyoutPrice = _arg_1;
        }

        public function get BuyerName():String
        {
            return (this._buyerName);
        }

        public function set BuyerName(_arg_1:String):void
        {
            this._buyerName = _arg_1;
        }

        public function get TimeStamp():uint
        {
            return (this._timeStamp);
        }

        public function set TimeStamp(_arg_1:uint):void
        {
            this._timeStamp = _arg_1;
        }

        public function get Item():ItemData
        {
            return (this._item);
        }

        public function set Item(_arg_1:ItemData):void
        {
            this._item = _arg_1;
        }

        public function get SelfLot():Boolean
        {
            return (this._selfLot);
        }

        public function set SelfLot(_arg_1:Boolean):void
        {
            this._selfLot = _arg_1;
        }

        public function toString():String
        {
            return ((((((((((("Auction Lot " + this.AuctionId) + "\nAucType ") + this.AuctionType) + "\nItem ") + this.Item.Id) + "\nSeller ") + this.SellerName) + "\nTime ") + this.TimeStamp) + "\nBuyout ") + this.BuyoutPrice);
        }


    }
}//package hbm.Engine.Actors

