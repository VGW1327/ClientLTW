


//hbm.Game.GUI.CashShopNew.Auction.AuctionPanel

package hbm.Game.GUI.CashShopNew.Auction
{
    import org.aswing.JPanel;
    import hbm.Application.ClientApplication;
    import org.aswing.JList;
    import hbm.Game.GUI.Tools.Flipper;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.geom.IntDimension;
    import org.aswing.BoxLayout;
    import flash.display.Bitmap;
    import org.aswing.AssetBackground;
    import org.aswing.EmptyLayout;
    import org.aswing.JLabel;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.Component;
    import org.aswing.JScrollPane;
    import flash.events.Event;
    import hbm.Game.Utility.HtmlText;

    public class AuctionPanel extends JPanel 
    {

        private var _timeTitle:String = ClientApplication.Localization.AUCTION_WINDOW_MSG1;
        private var _nameTitle:String = ClientApplication.Localization.AUCTION_WINDOW_MSG2;
        private var _bidPriceTitle:String = ClientApplication.Localization.AUCTION_WINDOW_MSG4;
        private var _priceTitle:String = ClientApplication.Localization.AUCTION_WINDOW_MSG3;
        private var _bidTitle:String = ClientApplication.Localization.AUCTION_WINDOW_MSG5;
        private var _itemList:JList;
        private var _flipper:Flipper;
        private var _graphicLib:AdditionalDataResourceLibrary;
        private var _list:Array;

        public function AuctionPanel()
        {
            this._graphicLib = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this.InitUI();
        }

        private function InitUI():void
        {
            var _local_3:IntDimension;
            setLayout(new BoxLayout());
            var _local_1:Bitmap = this._graphicLib.GetBitmapAsset("AdditionalData_Item_AuctionPanelBack");
            if (_local_1)
            {
                _local_3 = new IntDimension(_local_1.width, _local_1.height);
                setPreferredSize(_local_3);
                setMinimumSize(_local_3);
                setMaximumSize(_local_3);
                setBackgroundDecorator(new AssetBackground(_local_1));
            };
            var _local_2:JPanel = new JPanel(new EmptyLayout());
            _local_2.append(this.CreateHeader());
            _local_2.append(this.CreateList());
            append(_local_2);
        }

        private function CreateHeader():Component
        {
            var _local_1:JPanel = new JPanel(new EmptyLayout());
            _local_1.setSizeWH(648, 40);
            _local_1.setLocationXY(3, 3);
            var _local_2:JLabel = new JLabel(this._timeTitle);
            this.PrepareLabel(_local_2);
            _local_2.setSizeWH(75, 35);
            _local_2.setLocationXY(1, 2);
            var _local_3:JLabel = new JLabel(this._nameTitle);
            this.PrepareLabel(_local_3);
            _local_3.setSizeWH(0xFF, 35);
            _local_3.setLocationXY(76, 2);
            var _local_4:JLabel = new JLabel(this._bidPriceTitle);
            this.PrepareLabel(_local_4);
            _local_4.setSizeWH(90, 35);
            _local_4.setLocationXY(331, 2);
            var _local_5:JLabel = new JLabel(this._bidTitle);
            this.PrepareLabel(_local_5);
            _local_5.setSizeWH(60, 35);
            _local_5.setLocationXY(421, 2);
            var _local_6:JLabel = new JLabel(this._priceTitle);
            this.PrepareLabel(_local_6);
            _local_6.setSizeWH(62, 35);
            _local_6.setLocationXY(481, 2);
            this._flipper = new Flipper();
            this._flipper.SetText("");
            this._flipper.setBorder(new EmptyBorder(null, new Insets(3)));
            this._flipper.setSizeWH(102, 35);
            this._flipper.setLocationXY(542, 2);
            this._flipper.addEventListener(Flipper.ON_BACKWARD, this.OnFlipperBack);
            this._flipper.addEventListener(Flipper.ON_FORWARD, this.OnFlipperForward);
            _local_1.append(_local_2);
            _local_1.append(_local_3);
            _local_1.append(_local_4);
            _local_1.append(_local_6);
            _local_1.append(_local_5);
            _local_1.append(this._flipper);
            return (_local_1);
        }

        private function CreateList():Component
        {
            this._itemList = new JList();
            this._itemList.setCellFactory(new AuctionCellFactory());
            var _local_1:JScrollPane = new JScrollPane(this._itemList, JScrollPane.SCROLLBAR_NEVER, JScrollPane.SCROLLBAR_NEVER);
            _local_1.setSizeWH(648, 534);
            _local_1.setLocationXY(3, 45);
            return (_local_1);
        }

        public function OnFlipperBack(_arg_1:Event):void
        {
            this.TurnToPage(this._flipper.CurrentPage);
        }

        public function OnFlipperForward(_arg_1:Event):void
        {
            this.TurnToPage(this._flipper.CurrentPage);
        }

        public function SetData(_arg_1:Array, _arg_2:int):void
        {
            this._flipper.Pages = _arg_2;
            this._list = _arg_1;
            this._itemList.setListData(this._list);
            this._flipper.SetText(HtmlText.GetText(ClientApplication.Localization.LOADING_ADDITIONAL_WINDOW_INFO_PART1, this._flipper.CurrentPage, this._flipper.Pages));
        }

        private function PrepareLabel(_arg_1:JLabel):void
        {
            _arg_1.setHorizontalAlignment(JLabel.CENTER);
            _arg_1.setVerticalAlignment(JLabel.CENTER);
        }

        public function get Page():int
        {
            return (this._flipper.CurrentPage);
        }

        public function TurnToPage(_arg_1:uint):void
        {
            ClientApplication.Instance.AuctionInstance.RefreshAuctionsList(_arg_1);
            this._flipper.CurrentPage = _arg_1;
            this._flipper.SetText(HtmlText.GetText(ClientApplication.Localization.LOADING_ADDITIONAL_WINDOW_INFO_PART1, _arg_1, this._flipper.Pages));
        }


    }
}//package hbm.Game.GUI.CashShopNew.Auction

