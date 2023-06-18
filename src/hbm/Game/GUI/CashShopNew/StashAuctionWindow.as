


//hbm.Game.GUI.CashShopNew.StashAuctionWindow

package hbm.Game.GUI.CashShopNew
{
    import hbm.Game.GUI.CashShop.StashPanel;
    import hbm.Game.GUI.CashShopNew.Auction.AuctionPanel;
    import org.aswing.JLabel;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Network.Events.CashShopEvent;
    import mx.core.BitmapAsset;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.JPanel;
    import hbm.Game.Utility.AsWingUtil;
    import flash.display.Bitmap;
    import org.aswing.ASFont;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.GUI.Tools.WindowSprites;
    import org.aswing.Insets;
    import org.aswing.geom.IntDimension;
    import org.aswing.AssetBackground;
    import org.aswing.AssetIcon;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import hbm.Application.ClientConfig;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.GUI.CashShop.Stash.InventoryVioletSellItem;
    import hbm.Engine.Actors.ItemData;
    import org.aswing.*;
    import org.aswing.border.*;

    public class StashAuctionWindow extends WindowPrototype 
    {

        private static const TAB_STASH:uint = 1;
        private static const TAB_AUCTION:uint = 2;

        private const STASH_WINDOW_WIDTH:int = 671;
        private const STASH_WINDOW_HEIGHT:int = 644;
        private const AUCTION_WINDOW_WIDTH:int = 671;
        private const AUCTION_WINDOW_HEIGHT:int = 644;

        private var _stash:StashPanel = null;
        private var _auction:AuctionPanel;
        private var _payButton:ButtonPrototype;
        private var _updateButton:ButtonPrototype;
        private var _balance:JLabel;
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _localizationLibrary:LocalizationResourceLibrary;

        public function StashAuctionWindow(_arg_1:Boolean=false)
        {
            super(null, ClientApplication.Localization.CASH_SHOP_TITLE, _arg_1, this.STASH_WINDOW_WIDTH, this.STASH_WINDOW_HEIGHT);
            addEventListener(CashShopEvent.ON_CASH_SHOP_CHANGE_PANEL, this.ChangePanel);
            setLocationXY(((ClientApplication.stageWidth - _width) / 2), ((0x0300 - _height) / 2));
            validate();
            pack();
        }

        private function GetAsset(_arg_1:String):BitmapAsset
        {
            return (this._dataLibrary.GetBitmapAsset(("AdditionalData_Item_" + _arg_1)));
        }

        private function GetAssetLocalization(_arg_1:String):BitmapAsset
        {
            return (this._dataLibrary.GetBitmapAsset(("Localization_Item_" + _arg_1)));
        }

        override protected function InitUI():void
        {
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._localizationLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            super.InitUI();
            this.BuildTabs(TAB_STASH);
            this.BuildTop();
            this.ChangePanelToStash();
            this.BuildBottom();
        }

        private function BuildTop():void
        {
            _header.setLayout(new BorderLayout());
            _header.setBorder(new EmptyBorder());
            var _local_1:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackground(_local_1, this.GetAsset("NCS_TopBG"));
            AsWingUtil.SetBorder(_local_1, -41, 0, 41);
            _header.append(AsWingUtil.AlignCenter(_local_1), BorderLayout.PAGE_END);
        }

        private function BuildBottom():void
        {
            var _local_2:Bitmap;
            var _local_6:ASFont;
            _bottom.removeAll();
            _bottom.setLayout(new BorderLayout());
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            _local_2 = new WindowSprites.CoinGoldBig();
            var _local_3:Bitmap = Assets.TopMenuButton();
            var _local_4:Bitmap = Assets.UpdateButton();
            var _local_5:JLabel = new JLabel(ClientApplication.Localization.CASH_SHOP_GOLD_BALANSE);
            _local_5.setPreferredWidth(100);
            _local_5.setPreferredHeight(17);
            _local_6 = getFont();
            var _local_7:ASFont = new ASFont(_local_6.getName(), 16, false);
            _local_5.setFont(_local_7);
            _local_5.setBorder(new EmptyBorder(null, new Insets(5, 0, 5, 0)));
            _local_1.append(_local_5);
            this._balance = new JLabel("");
            this._balance.setPreferredWidth(65);
            this._balance.setPreferredHeight(17);
            var _local_8:ASFont = new ASFont(_local_6.getName(), 16, true);
            this._balance.setFont(_local_8);
            this._balance.setBorder(new EmptyBorder(null, new Insets(5, 0, 5, 0)));
            _local_1.append(this._balance);
            var _local_9:JPanel = new JPanel();
            var _local_10:IntDimension = new IntDimension(_local_2.width, ((_local_2.height + 5) + 5));
            _local_9.setPreferredSize(_local_10);
            _local_9.setMinimumSize(_local_10);
            _local_9.setMaximumSize(_local_10);
            _local_9.setBackgroundDecorator(new AssetBackground(_local_2));
            _local_9.setBorder(new EmptyBorder(null, new Insets(5, 0, 5, 0)));
            _local_1.append(_local_9);
            this._updateButton = new ButtonPrototype();
            this._updateButton.setIcon(new AssetIcon(Assets.UpdateButton()));
            this._updateButton.setRollOverIcon(new AssetIcon(Assets.UpdateButtonActive()));
            this._updateButton.setPreferredSize(new IntDimension(_local_4.width, _local_4.height));
            this._updateButton.setBackgroundDecorator(null);
            this._updateButton.addActionListener(this.OnUpdateMoneyButton, 0, true);
            this._updateButton.setBorder(new EmptyBorder(null, new Insets(7, 0, 5, 0)));
            var _local_11:CustomToolTip = new CustomToolTip(this._updateButton, ClientApplication.Instance.GetPopupText(250), 210, 13);
            _local_1.append(this._updateButton);
            this._payButton = new ButtonPrototype();
            this._payButton.setIcon(new AssetIcon(Assets.TopMenuButton()));
            this._payButton.setRollOverIcon(new AssetIcon(Assets.TopMenuButtonActive()));
            this._payButton.setIconTextGap(-90);
            this._payButton.setPreferredSize(new IntDimension(_local_3.width, _local_3.height));
            this._payButton.setBackgroundDecorator(null);
            this._payButton.addActionListener(this.OnPayButton, 0, true);
            this._payButton.setBorder(new EmptyBorder(null, new Insets(7, 0, 5, 0)));
            _local_1.append(this._payButton);
            _bottom.append(AsWingUtil.AlignCenter(_local_1));
        }

        private function BuildTabs(_arg_1:int):void
        {
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4, SoftBoxLayout.TOP));
            var _local_3:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackground(_local_3, this.GetAssetLocalization(((_arg_1 == TAB_STASH) ? "NCS_StashTab" : "NCS_StashTabOut")));
            if (_arg_1 != TAB_STASH)
            {
                _local_3.addEventListener(MouseEvent.CLICK, this.ChangePanelToStash, false, 0, true);
            };
            _local_3.buttonMode = true;
            _local_2.append(_local_3);
            var _local_4:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackground(_local_4, this.GetAssetLocalization(((_arg_1 == TAB_AUCTION) ? "NCS_AuctionTab" : "NCS_AuctionTabOut")));
            if (_arg_1 != TAB_AUCTION)
            {
                _local_4.addEventListener(MouseEvent.CLICK, this.ChangePanelToAuction, false, 0, true);
            };
            _local_4.buttonMode = true;
            _bodyArea.append(_local_2);
            setSizeWH((_width + 83), _height);
        }

        private function OnPayButton(_arg_1:Event):void
        {
            if (!ClientApplication.Instance.Config.IsPaymentsEnabled)
            {
                ClientApplication.Instance.ThisMethodIsDisabled();
            }
            else
            {
                ClientApplication.Instance.OpenPayDialog();
            };
        }

        private function OnWinCupButton(_arg_1:Event):void
        {
            var _local_2:ClientConfig = ClientApplication.Instance.Config;
            switch (_local_2.CurrentPlatformId)
            {
                case ClientConfig.VKONTAKTE:
                case ClientConfig.VKONTAKTE_TEST:
                    navigateToURL(new URLRequest("http://vk.com/page-18990411_28703673"));
                    return;
                case ClientConfig.MAILRU:
                case ClientConfig.MAILRU_TEST:
                    navigateToURL(new URLRequest((_local_2.GetAppGroupURL + "/C822B9F43AAA705.html")));
                    return;
                case ClientConfig.ODNOKLASSNIKI:
                case ClientConfig.ODNOKLASSNIKI_TEST:
                    navigateToURL(new URLRequest((_local_2.GetAppGroupURL + "/topic/205846869629")));
                    return;
                case ClientConfig.WEB:
                case ClientConfig.WEB_TEST:
                case ClientConfig.STANDALONE:
                case ClientConfig.DEBUG:
                case ClientConfig.TEST:
                    navigateToURL(new URLRequest((_local_2.GetAppGroupURL + "/news/section23#content")));
                    return;
            };
        }

        private function ChangePanel(_arg_1:CashShopEvent):void
        {
            removeEventListener(CashShopEvent.ON_CASH_SHOP_CHANGE_PANEL, this.ChangePanel);
            if (_arg_1.Type == 0)
            {
                this.ChangePanelToStash();
            }
            else
            {
                this.ChangePanelToAuction();
            };
        }

        public function ChangePanelToStash(_arg_1:Event=null):void
        {
            _container.removeAll();
            _width = this.STASH_WINDOW_WIDTH;
            _height = this.STASH_WINDOW_HEIGHT;
            SetWindowTitle(ClientApplication.Localization.STASH_TITLE);
            super.InitUI();
            this.BuildTabs(TAB_STASH);
            this.BuildBottom();
            setLocationXY(((ClientApplication.stageWidth - _width) / 2), ((0x0300 - _height) / 2));
            this._stash = new StashPanel();
            _body.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            _body.append(this._stash);
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            this.UpdateColsAmount(_local_2.cashPoints);
        }

        public function ChangePanelToAuction(_arg_1:Event=null):void
        {
            _container.removeAll();
            _width = this.AUCTION_WINDOW_WIDTH;
            _height = this.AUCTION_WINDOW_HEIGHT;
            SetWindowTitle(ClientApplication.Localization.AUCTION_WINDOW_TITLE);
            super.InitUI();
            this.BuildTabs(TAB_AUCTION);
            this.BuildBottom();
            setLocationXY(((ClientApplication.stageWidth - _width) / 2), ((0x0300 - _height) / 2));
            this._auction = new AuctionPanel();
            _body.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            _body.append(this._auction);
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            this.UpdateColsAmount(_local_2.cashPoints);
            ClientApplication.Instance.AuctionInstance.Open(this._auction);
            validate();
        }

        override protected function OnClosePressed(_arg_1:Event):void
        {
            dispose();
        }

        public function UpdateColsAmount(_arg_1:int):void
        {
            this._updateButton.setEnabled(true);
            this._balance.setText(_arg_1.toString());
        }

        public function ClearVioletSellSlot(_arg_1:InventoryVioletSellItem):void
        {
            if (this._stash == null)
            {
                return;
            };
            this._stash.VioletSellPanelInstance.ClearSlot(_arg_1);
        }

        public function RevalidateVioletSellPanel():void
        {
            if (this._stash == null)
            {
                return;
            };
            this._stash.VioletSellPanelInstance.Revalidate();
        }

        public function RevalidateCraftRunePanel(_arg_1:Boolean=false, _arg_2:Boolean=false, _arg_3:ItemData=null):void
        {
            if (this._stash == null)
            {
                return;
            };
            if (_arg_1)
            {
                this._stash.CraftRunePanelInstance.ClearCraftItemSlot();
            };
            if (_arg_2)
            {
                this._stash.CraftRunePanelInstance.ClearRuneCraftSlots();
            };
            if (_arg_3)
            {
                this._stash.CraftRunePanelInstance.SetCraftRuneSlot(_arg_3);
            };
            this._stash.CraftRunePanelInstance.Revalidate();
        }

        private function OnUpdateMoneyButton(_arg_1:Event):void
        {
            this._updateButton.setEnabled(false);
            ClientApplication.Instance.LocalGameClient.SendUpdatePayments();
        }


    }
}//package hbm.Game.GUI.CashShopNew

