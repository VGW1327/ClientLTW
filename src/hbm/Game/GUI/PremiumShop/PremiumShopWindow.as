


//hbm.Game.GUI.PremiumShop.PremiumShopWindow

package hbm.Game.GUI.PremiumShop
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import org.aswing.JLabel;
    import hbm.Game.GUI.Tools.CustomTabbedPane;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Application.ClientApplication;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.JPanel;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.Icon;
    import org.aswing.SoftBoxLayout;
    import org.aswing.ASFont;
    import hbm.Game.Utility.HtmlText;
    import hbm.Game.GUI.Tools.WindowSprites;
    import flash.display.Bitmap;
    import hbm.Game.GUI.CashShopNew.Assets;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Actors.Actors;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Actors.CharacterInfo;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import hbm.Game.GUI.CashShopNew.NewBuyCashWindow;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import hbm.Engine.Renderer.RenderSystem;

    public class PremiumShopWindow extends WindowPrototype 
    {

        private static var _buyPanelItems:Object;

        private const WIDTH:int = 812;
        private const HEIGHT:int = 654;

        private var _titleShop:JLabel;
        private var _tabs:CustomTabbedPane;
        private var _pageCountLabel:JLabel;
        private var _leftArrow:CustomButton;
        private var _rightArrow:CustomButton;
        private var _balanceGold:JLabel;
        private var _balanceSilver:JLabel;
        private var _updateButton:CustomButton;
        private var _tabsData:Array;
        private var _shopId:uint;

        public function PremiumShopWindow()
        {
            super(null, ClientApplication.Localization.CASH_SHOP_TITLE, modal, this.WIDTH, this.HEIGHT);
            pack();
        }

        public function get ShopID():uint
        {
            return (this._shopId);
        }

        override protected function InitUI():void
        {
            super.InitUI();
            this.BuildTop();
            this.BuildBodyShop();
            this.BuildBottom();
        }

        private function BuildTop():void
        {
            _header.setLayout(new BorderLayout());
            _header.setBorder(new EmptyBorder());
            var _local_1:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackgroundFromAsset(_local_1, "NCS_TopBG");
            _header.append(AsWingUtil.AlignCenter(_local_1), BorderLayout.PAGE_END);
        }

        private function BuildBodyShop():void
        {
            var _local_2:Icon;
            var _local_3:Icon;
            AsWingUtil.SetBackgroundFromAsset(_body, "NCS_MiddleGB");
            _body.setBorder(new EmptyBorder());
            _body.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            this._titleShop = AsWingUtil.CreateLabel("", 16767611, new ASFont(getFont().getName(), 16, false));
            this._titleShop.setTextFilters([HtmlText.shadow]);
            AsWingUtil.SetBorder(this._titleShop, 0, 0, 0, 21);
            _body.append(this._titleShop);
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.TOP));
            AsWingUtil.SetHeight(_local_1, 470);
            this._leftArrow = AsWingUtil.CreateCustomButtonFromAsset("NCS_Left", "NCS_LeftOver", "NCS_LeftPress");
            this._leftArrow.addActionListener(this.OnScrollLeft, 0, true);
            _local_1.append(AsWingUtil.OffsetBorder(this._leftArrow, 0, 220));
            this._tabs = new CustomTabbedPane();
            this._tabs.addStateListener(this.OnSelectTab, 0, true);
            _local_2 = AsWingUtil.CreateIconFromAsset("NCS_TabExclusiveOut");
            _local_3 = AsWingUtil.CreateIconFromAsset("NCS_TabExclusive");
            this._tabs.AppendCustomTab(new NewShopArea(), _local_2, _local_3);
            _local_2 = AsWingUtil.CreateIconFromAsset("NCS_TabWeaponOut");
            _local_3 = AsWingUtil.CreateIconFromAsset("NCS_TabWeapon");
            this._tabs.AppendCustomTab(new NewShopArea(), _local_2, _local_3);
            _local_2 = AsWingUtil.CreateIconFromAsset("NCS_TabArmorOut");
            _local_3 = AsWingUtil.CreateIconFromAsset("NCS_TabArmor");
            this._tabs.AppendCustomTab(new NewShopArea(), _local_2, _local_3);
            _local_2 = AsWingUtil.CreateIconFromAsset("NCS_TabRinglOut");
            _local_3 = AsWingUtil.CreateIconFromAsset("NCS_TabRing");
            this._tabs.AppendCustomTab(new NewShopArea(), _local_2, _local_3);
            _local_2 = AsWingUtil.CreateIconFromAsset("NCS_TabBottleOut");
            _local_3 = AsWingUtil.CreateIconFromAsset("NCS_TabBottle");
            this._tabs.AppendCustomTab(new NewShopArea(), _local_2, _local_3);
            _local_2 = AsWingUtil.CreateIconFromAsset("NCS_TabScrollOut");
            _local_3 = AsWingUtil.CreateIconFromAsset("NCS_TabScroll");
            this._tabs.AppendCustomTab(new NewShopArea(), _local_2, _local_3);
            _local_2 = AsWingUtil.CreateIconFromAsset("NCS_TabChestOut");
            _local_3 = AsWingUtil.CreateIconFromAsset("NCS_TabChest");
            this._tabs.AppendCustomTab(new NewShopArea(), _local_2, _local_3);
            _local_1.append(this._tabs);
            AsWingUtil.SetWidth(this._tabs, (570 + 147));
            this._rightArrow = AsWingUtil.CreateCustomButtonFromAsset("NCS_Right", "NCS_RightOver", "NCS_RightPress");
            this._rightArrow.addActionListener(this.OnScrollRight, 0, true);
            _local_1.append(AsWingUtil.OffsetBorder(this._rightArrow, 0, 220));
            _body.append(_local_1);
            this._pageCountLabel = AsWingUtil.CreateLabel("0/0", 16770453, new ASFont(getFont().getName(), 16, true));
            AsWingUtil.SetBorder(this._pageCountLabel, 0, 5);
            this._pageCountLabel.setTextFilters([HtmlText.glow]);
            _body.append(this._pageCountLabel);
        }

        private function BuildBottom():void
        {
            _bottom.removeAll();
            _bottom.setLayout(new BorderLayout());
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            var _local_2:Bitmap = new WindowSprites.CoinGoldBig();
            var _local_3:Bitmap = new WindowSprites.CoinSilverBig();
            var _local_4:JLabel = AsWingUtil.CreateLabel(ClientApplication.Localization.CASH_SHOP_GOLD_BALANSE, getForeground().getRGB(), new ASFont(getFont().getName(), 16, false));
            _local_4.setHorizontalAlignment(JLabel.LEFT);
            AsWingUtil.SetSize(_local_4, 160, (17 + 8));
            AsWingUtil.SetBorder(_local_4, 10, 8);
            _local_1.append(_local_4);
            this._balanceSilver = AsWingUtil.CreateLabel("", getForeground().getRGB(), new ASFont(getFont().getName(), 16));
            AsWingUtil.SetSize(this._balanceSilver, 140, (17 + 10));
            AsWingUtil.SetBorder(this._balanceSilver, 40, 10);
            this._balanceSilver.setHorizontalAlignment(JLabel.RIGHT);
            _local_1.append(this._balanceSilver);
            var _local_5:JPanel = new JPanel();
            AsWingUtil.SetBackground(_local_5, _local_3);
            AsWingUtil.SetSize(_local_5, _local_3.width, ((_local_3.height + 6) + 5));
            AsWingUtil.SetBorder(_local_5, 0, 6, 0, 5);
            _local_1.append(_local_5);
            var _local_6:CustomButton = AsWingUtil.CreateCustomButton(Assets.TopMenuButton(), Assets.TopMenuButtonActive());
            _local_6.addActionListener(this.OnPaySilverButton, 0, true);
            _local_1.append(AsWingUtil.OffsetBorder(_local_6, 0, 5));
            this._balanceGold = AsWingUtil.CreateLabel("", getForeground().getRGB(), new ASFont(getFont().getName(), 16));
            AsWingUtil.SetSize(this._balanceGold, 120, (17 + 10));
            AsWingUtil.SetBorder(this._balanceGold, 0, 10);
            this._balanceGold.setHorizontalAlignment(JLabel.RIGHT);
            _local_1.append(this._balanceGold);
            var _local_7:JPanel = new JPanel();
            AsWingUtil.SetBackground(_local_7, _local_2);
            AsWingUtil.SetSize(_local_7, _local_2.width, ((_local_2.height + 6) + 5));
            AsWingUtil.SetBorder(_local_7, 0, 6, 0, 5);
            _local_1.append(_local_7);
            this._updateButton = AsWingUtil.CreateCustomButton(Assets.UpdateButton(), Assets.UpdateButtonActive());
            this._updateButton.addActionListener(this.OnUpdateMoneyButton, 0, true);
            new CustomToolTip(this._updateButton, ClientApplication.Instance.GetPopupText(250), 210, 13);
            _local_1.append(AsWingUtil.OffsetBorder(this._updateButton, 0, 5));
            var _local_8:CustomButton = AsWingUtil.CreateCustomButton(Assets.TopMenuButton(), Assets.TopMenuButtonActive());
            _local_8.addActionListener(this.OnPayGoldButton, 0, true);
            _local_1.append(AsWingUtil.OffsetBorder(_local_8, 0, 5));
            _bottom.append(_local_1, BorderLayout.CENTER);
        }

        private function LoadData():void
        {
            var _local_1:AdditionalDataResourceLibrary;
            var _local_4:Object;
            var _local_5:Object;
            var _local_6:NewShopArea;
            _local_1 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_2:Object = _local_1.JobArmorShop;
            this._tabsData = _local_1.GetCashShop;
            if (((!(this._tabsData)) || (!(_buyPanelItems[this._shopId]))))
            {
                return;
            };
            var _local_3:Array = [];
            for each (_local_4 in this._tabsData)
            {
                for each (_local_5 in _local_4.filter)
                {
                    if (_local_5.Exception == 1)
                    {
                        _local_3 = _local_3.concat(_local_5.items);
                    };
                };
            };
            for each (_local_4 in this._tabsData)
            {
                this._tabs.setTipAt(_local_4.id, _local_4.name);
                _local_6 = (this._tabs.getComponent(_local_4.id) as NewShopArea);
                if (_local_6)
                {
                    _local_6.LoadFilters(_local_4.filter, _buyPanelItems[this._shopId], _local_3, ((_local_4.id == 2) ? _local_2 : null));
                    _local_6.ChangeFilterCallback = this.UpdatePageCounter;
                };
            };
            this.OnSelectTab(null);
        }

        public function loadAnalogues(_arg_1:String):void
        {
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:NewShopArea;
            if (_arg_1)
            {
                _local_2 = this._tabs.getComponentCount();
                _local_3 = 0;
                while (_local_3 < _local_2)
                {
                    _local_4 = (this._tabs.getComponent(_local_3) as NewShopArea);
                    if (_local_4.ShowItem(int(_arg_1)))
                    {
                        this._tabs.setSelectedComponent(_local_4);
                        _local_4.UpdateFilter();
                        return;
                    };
                    _local_3++;
                };
            };
        }

        private function LoadBuyItems():void
        {
            var _local_1:ItemsResourceLibrary;
            var _local_2:AdditionalDataResourceLibrary;
            var _local_3:Object;
            var _local_4:String;
            var _local_5:Actors;
            var _local_6:int;
            var _local_7:int;
            var _local_8:Array;
            var _local_9:Object;
            var _local_10:Object;
            var _local_11:ItemData;
            if (!_buyPanelItems)
            {
                _buyPanelItems = {};
                _local_1 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
                _local_2 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
                _local_3 = _local_2.GetPremiumShop;
                for (_local_4 in _local_3)
                {
                    _local_5 = ClientApplication.Instance.LocalGameClient.ActorList;
                    _local_6 = ((_local_5) ? _local_5.GetPlayerFraction() : CharacterInfo.FRACTION_LIGHT);
                    _local_7 = ((_local_6 == CharacterInfo.FRACTION_DARK) ? ItemData.ITEM_ATTRIBUTE_FRACTION : 0);
                    _local_8 = [];
                    for each (_local_9 in _local_3[_local_4].ItemList)
                    {
                        _local_10 = _local_1.GetServerDescriptionObject(_local_9.Item);
                        if (_local_10)
                        {
                            _local_11 = new ItemData();
                            _local_11.Price = _local_9.Price;
                            _local_11.Type = _local_10.type;
                            _local_11.Id = 0;
                            _local_11.NameId = _local_9.Item;
                            _local_11.Identified = 1;
                            switch (_local_9.Currency)
                            {
                                case 1:
                                    _local_11.Origin = ItemData.CASH;
                                    break;
                                case 2:
                                    _local_11.Origin = ItemData.KAFRA;
                                    break;
                                case 0:
                                default:
                                    _local_11.Origin = ItemData.ZENY;
                            };
                            _local_11.Attr = _local_7;
                            if ((((_local_11.Type == ItemData.IT_HEALING) || (_local_11.Type == ItemData.IT_USABLE)) || (_local_11.Type == ItemData.IT_ETC)))
                            {
                                _local_11.Amount = 20;
                            }
                            else
                            {
                                _local_11.Amount = 1;
                            };
                            _local_11.Cards = new <int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                            _local_8.push(_local_11);
                        };
                    };
                    _buyPanelItems[_local_4] = _local_8;
                };
            };
            this.LoadData();
        }

        public function UpdateGoldAmount(_arg_1:int):void
        {
            this._updateButton.setEnabled(true);
            this._balanceGold.setText(_arg_1.toString());
        }

        public function UpdateSilverAmount(_arg_1:int):void
        {
            this._balanceSilver.setText(_arg_1.toString());
        }

        private function OnSelectTab(_arg_1:Event):void
        {
            var _local_2:int;
            _local_2 = this._tabs.getSelectedIndex();
            var _local_3:String = this._tabs.getTipAt(_local_2);
            this._titleShop.setText(_local_3);
            var _local_4:NewShopArea = this.GetCurShop();
            _local_4.ResetFilters();
            _local_4.UpdateFilter();
            this.UpdatePageCounter();
        }

        private function UpdatePageCounter():void
        {
            if (!this._pageCountLabel)
            {
                return;
            };
            var _local_1:NewShopArea = this.GetCurShop();
            this._pageCountLabel.setText(((_local_1.CurPage + "/") + _local_1.MaxPage));
            this._leftArrow.alpha = ((_local_1.CurPage > 1) ? 1 : 0);
            this._rightArrow.alpha = ((_local_1.CurPage < _local_1.MaxPage) ? 1 : 0);
            this._leftArrow.mouseEnabled = (this._leftArrow.buttonMode = (this._leftArrow.alpha > 0));
            this._rightArrow.mouseEnabled = (this._rightArrow.buttonMode = (this._rightArrow.alpha > 0));
        }

        public function GetIconTab(_arg_1:NewShopArea):DisplayObject
        {
            var _local_2:int = this._tabs.getIndex(_arg_1);
            if (_local_2 < 0)
            {
                return (null);
            };
            return (this._tabs.getIconAt(_local_2).getDisplay(this._tabs));
        }

        public function GetCurShop():NewShopArea
        {
            return (this._tabs.getComponent(this._tabs.getSelectedIndex()) as NewShopArea);
        }

        public function GetShopAreaForItem(_arg_1:uint):NewShopArea
        {
            var _local_3:NewShopArea;
            var _local_2:uint;
            while (_local_2 < this._tabs.getTabCount())
            {
                _local_3 = (this._tabs.getComponent(_local_2) as NewShopArea);
                if (_local_3.HasItem(_arg_1))
                {
                    return (_local_3);
                };
                _local_2++;
            };
            return (null);
        }

        private function OnScrollLeft(_arg_1:Event):void
        {
            this.GetCurShop().ScrollLeft();
            this.UpdatePageCounter();
        }

        private function OnScrollRight(_arg_1:Event):void
        {
            this.GetCurShop().ScrollRight();
            this.UpdatePageCounter();
        }

        private function OnUpdateMoneyButton(_arg_1:Event):void
        {
            this._updateButton.setEnabled(false);
            ClientApplication.Instance.LocalGameClient.SendUpdatePayments();
        }

        private function OnPayGoldButton(_arg_1:Event):void
        {
            ClientApplication.Instance.OpenPayDialog();
        }

        private function OnPaySilverButton(_arg_1:Event):void
        {
            ClientApplication.Instance.OpenPayDialog(NewBuyCashWindow.SILVER_PANEL);
        }

        public function ShowPremiumShop(_arg_1:uint=0):void
        {
            this._shopId = _arg_1;
            this.LoadBuyItems();
            this.show();
            HelpManager.Instance.UpdatePremiumShopHelper();
        }

        override public function dispose():void
        {
            super.dispose();
            HelpManager.Instance.UpdatePremiumShopHelper();
        }

        override public function show():void
        {
            super.show();
            this.AlignCenterScreen();
            var _local_1:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            if (_local_1)
            {
                this.UpdateGoldAmount(_local_1.cashPoints);
                this.UpdateSilverAmount(_local_1.money);
            };
        }

        private function AlignCenterScreen():void
        {
            if (!isShowing())
            {
                return;
            };
            setLocationXY(((RenderSystem.Instance.ScreenWidth - width) / 2), ((RenderSystem.Instance.ScreenHeight - height) / 2));
        }


    }
}//package hbm.Game.GUI.PremiumShop

