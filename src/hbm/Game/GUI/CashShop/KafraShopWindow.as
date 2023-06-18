


//hbm.Game.GUI.CashShop.KafraShopWindow

package hbm.Game.GUI.CashShop
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JLabel;
    import org.aswing.JTabbedPane;
    import hbm.Application.ClientApplication;
    import org.aswing.JPanel;
    import org.aswing.ASFont;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import flash.display.Bitmap;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Game.GUI.JobSelectorPanel;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.GUI.Tools.WindowSprites;
    import org.aswing.AssetIcon;
    import org.aswing.BorderLayout;
    import org.aswing.JComboBox;
    import org.aswing.Component;
    import org.aswing.event.AWEvent;
    import org.aswing.JCheckBox;
    import hbm.Game.GUI.Dialogs.BuyGoldDialog;
    import hbm.Application.ClientConfig;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import org.aswing.AttachIcon;
    import flash.events.Event;
    import hbm.Game.GUI.CashShop.Stash.InventoryVioletSellItem;
    import hbm.Engine.Actors.ItemData;

    public class KafraShopWindow extends CustomWindow 
    {

        private const _width:int = 645;
        private const _height:int = 466;

        private var _colsAmountLabel:JLabel;
        private var _tabbedPanel:JTabbedPane;
        private var _tabsData:Array;

        public function KafraShopWindow()
        {
            super(null, ClientApplication.Localization.KAFRA_SHOP_TITLE, false, this._width, this._height, true);
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
            this.InitUI();
            pack();
        }

        private function InitUI():void
        {
            var _local_4:Object;
            var _local_5:JPanel;
            var _local_6:JLabel;
            var _local_7:ASFont;
            var _local_8:ASFont;
            var _local_9:CustomToolTip;
            var _local_10:Bitmap;
            var _local_11:JLabel;
            var _local_12:CustomButton;
            var _local_13:JPanel;
            var _local_14:JPanel;
            var _local_15:StashPanel;
            var _local_16:KafraShopPanel;
            var _local_17:JobSelectorPanel;
            var _local_18:JPanel;
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            this._tabbedPanel = new JTabbedPane();
            var _local_3:AdditionalDataResourceLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._tabsData = _local_3.GetKafraShop;
            if (!this._tabsData)
            {
                return;
            };
            for each (_local_4 in this._tabsData)
            {
                if (_local_4["items"] != null)
                {
                    if (_local_4["type"] == 1)
                    {
                        _local_15 = new StashPanel();
                        _local_15.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
                        this._tabbedPanel.appendTab(_local_15, _local_4["name"]);
                        _local_4["tab"] = _local_15;
                    };
                }
                else
                {
                    _local_16 = new KafraShopPanel(_local_4["filter"], (!(_local_4["jobSelector"] == null)));
                    _local_16.setBorder(_local_1);
                    if (_local_4["jobSelector"] != null)
                    {
                        _local_17 = new JobSelectorPanel(((_local_2) ? _local_2.clothesColor : 0), false);
                        if (_local_17.JobsList)
                        {
                            _local_17.JobsList.addSelectionListener(this.OnJobChanged, 0, true);
                        };
                        if (_local_17.GoldCheckBox != null)
                        {
                            _local_17.GoldCheckBox.addActionListener(this.OnCheckBoxClicked, 0, true);
                        };
                        _local_18 = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
                        _local_18.append(_local_17);
                        _local_18.append(_local_16);
                        this._tabbedPanel.appendTab(_local_18, _local_4["name"]);
                    }
                    else
                    {
                        this._tabbedPanel.appendTab(_local_16, _local_4["name"]);
                    };
                    _local_4["tab"] = _local_16;
                };
            };
            _local_5 = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            _local_6 = new JLabel((ClientApplication.Localization.CASH_SHOP_GOLD_BALANSE + " "));
            _local_7 = _local_6.getFont();
            _local_8 = new ASFont(_local_7.getName(), 14, true);
            _local_6.setFont(_local_8);
            _local_6.setHorizontalAlignment(JLabel.LEFT);
            this._colsAmountLabel = new JLabel();
            this._colsAmountLabel.setFont(_local_8);
            this._colsAmountLabel.setForeground(new ASColor(16240402));
            this._colsAmountLabel.setPreferredWidth(60);
            this._colsAmountLabel.setHorizontalAlignment(JLabel.RIGHT);
            _local_9 = new CustomToolTip(this._colsAmountLabel, ClientApplication.Instance.GetPopupText(201), 185, 40);
            _local_10 = new WindowSprites.CoinKafra();
            _local_11 = new JLabel(" ", new AssetIcon(_local_10));
            _local_5.append(_local_6);
            _local_5.append(this._colsAmountLabel);
            _local_5.append(_local_11);
            _local_12 = new CustomButton(ClientApplication.Localization.BUTTON_CLOSE);
            _local_12.addActionListener(this.OnCloseButtonPressed, 0, true);
            _local_13 = new JPanel(new BorderLayout());
            _local_13.setBorder(new EmptyBorder(null, new Insets(6, 0, 0, 0)));
            _local_13.append(_local_5, BorderLayout.WEST);
            _local_13.append(_local_12, BorderLayout.EAST);
            _local_14 = new JPanel(new BorderLayout());
            _local_14.setBorder(new EmptyBorder(null, new Insets(6, 4, 4, 4)));
            _local_14.append(this._tabbedPanel, BorderLayout.CENTER);
            _local_14.append(_local_13, BorderLayout.PAGE_END);
            MainPanel.append(_local_14, BorderLayout.CENTER);
            addEventListener(CustomWindow.CUSTOM_WINDOW_CLOSED, this.OnCloseButtonPressed, false, 0, true);
            pack();
        }

        private function OnJobChanged(_arg_1:AWEvent):void
        {
            var _local_3:JComboBox;
            var _local_4:JPanel;
            var _local_5:JobSelectorPanel;
            var _local_6:int;
            var _local_7:Boolean;
            var _local_8:Component;
            var _local_9:JPanel;
            var _local_10:KafraShopPanel;
            var _local_2:Object = _arg_1.currentTarget;
            if (_local_2 == null)
            {
                return;
            };
            if ((_local_2 is JComboBox))
            {
                _local_3 = (_local_2 as JComboBox);
                if ((_local_3.parent is JPanel))
                {
                    _local_4 = (_local_3.parent as JPanel);
                    if ((_local_4.parent is JobSelectorPanel))
                    {
                        _local_5 = (_local_4.parent as JobSelectorPanel);
                        _local_6 = ((_local_5.JobsList != null) ? _local_5.JobsList.getSelectedIndex() : 0);
                        _local_7 = ((_local_5.GoldCheckBox != null) ? _local_5.GoldCheckBox.isSelected() : false);
                        if (_local_6 >= 0)
                        {
                            _local_8 = this._tabbedPanel.getSelectedComponent();
                            if ((_local_8 is JPanel))
                            {
                                _local_9 = (_local_8 as JPanel);
                                _local_10 = (_local_9.getChildAt(2) as KafraShopPanel);
                                if (_local_10 != null)
                                {
                                    _local_10.RevalidateItemsForJob(_local_5.Index2JobId(_local_6), _local_7);
                                };
                            };
                        };
                    };
                };
            };
        }

        private function OnCheckBoxClicked(_arg_1:AWEvent):void
        {
            var _local_3:JCheckBox;
            var _local_4:JPanel;
            var _local_5:JobSelectorPanel;
            var _local_6:int;
            var _local_7:Boolean;
            var _local_8:Component;
            var _local_9:JPanel;
            var _local_10:KafraShopPanel;
            var _local_2:Object = _arg_1.currentTarget;
            if (_local_2 == null)
            {
                return;
            };
            if ((_local_2 is JCheckBox))
            {
                _local_3 = (_local_2 as JCheckBox);
                if ((_local_3.parent is JPanel))
                {
                    _local_4 = (_local_3.parent as JPanel);
                    if ((_local_4.parent is JobSelectorPanel))
                    {
                        _local_5 = (_local_4.parent as JobSelectorPanel);
                        _local_6 = ((_local_5.JobsList != null) ? _local_5.JobsList.getSelectedIndex() : 0);
                        _local_7 = ((_local_5.GoldCheckBox != null) ? _local_5.GoldCheckBox.isSelected() : false);
                        if (_local_6 >= 0)
                        {
                            _local_8 = this._tabbedPanel.getSelectedComponent();
                            if ((_local_8 is JPanel))
                            {
                                _local_9 = (_local_8 as JPanel);
                                _local_10 = (_local_9.getChildAt(2) as KafraShopPanel);
                                if (_local_10 != null)
                                {
                                    _local_10.RevalidateItemsForJob(_local_5.Index2JobId(_local_6), _local_7);
                                };
                            };
                        };
                    };
                };
            };
        }

        private function OnBuyMoney(_arg_1:AWEvent):void
        {
            var _local_2:int;
            var _local_3:BuyGoldDialog;
            if (!ClientApplication.Instance.Config.IsPaymentsEnabled)
            {
                ClientApplication.Instance.ThisMethodIsDisabled();
            }
            else
            {
                _local_2 = ClientApplication.Instance.Config.CurrentPlatformId;
                if ((((!(_local_2 == ClientConfig.WEB)) && (!(_local_2 == ClientConfig.WEB_TEST))) && (!(_local_2 == ClientConfig.STANDALONE))))
                {
                    _local_3 = new BuyGoldDialog();
                    _local_3.show();
                }
                else
                {
                    ClientApplication.Instance.BuyMoneyRequest(0);
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.BUY_DIALOG_WEB_REDIRECT_MESSAGE, null, null, true, new AssetIcon(new WindowSprites.CoinGold())));
                };
            };
        }

        private function OnJobMoney(_arg_1:AWEvent):void
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
                    navigateToURL(new URLRequest((_local_2.GetAppGroupURL + "/7AC0FC3A020D6E10.html")));
                    return;
                case ClientConfig.ODNOKLASSNIKI:
                case ClientConfig.ODNOKLASSNIKI_TEST:
                    navigateToURL(new URLRequest((_local_2.GetAppGroupURL + "/topic/203032710781")));
                    return;
                case ClientConfig.WEB:
                case ClientConfig.WEB_TEST:
                case ClientConfig.STANDALONE:
                case ClientConfig.DEBUG:
                case ClientConfig.TEST:
                    navigateToURL(new URLRequest((_local_2.GetAppGroupURL + "/tenders/#content")));
                    return;
                default:
                    this.ThisMethodIsDisabled();
            };
        }

        public function ThisMethodIsDisabled():void
        {
            new CustomOptionPane(JOptionPane.showMessageDialog("", ClientApplication.Localization.METHOD_IS_DISABLED_TEXT, null, null, true, new AttachIcon("AchtungIcon")));
        }

        public function LoadBuyItems(_arg_1:Array):void
        {
            var _local_3:Object;
            var _local_4:Object;
            var _local_5:KafraShopPanel;
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            this.UpdateColsAmount(_local_2.kafraPoints);
            for each (_local_3 in this._tabsData)
            {
                _local_4 = _local_3["tab"];
                if ((_local_4 is KafraShopPanel))
                {
                    _local_5 = (_local_4 as KafraShopPanel);
                    _local_5.LoadItems(_arg_1);
                };
            };
        }

        public function UpdateColsAmount(_arg_1:int):void
        {
            this._colsAmountLabel.setText(_arg_1.toString());
        }

        private function OnCloseButtonPressed(_arg_1:Event):void
        {
            ClientApplication.Instance.OpenKafraShop();
        }

        public function get TabbedPanel():JTabbedPane
        {
            return (this._tabbedPanel);
        }

        public function ClearVioletSellSlot(_arg_1:InventoryVioletSellItem):void
        {
            var _local_2:Object;
            var _local_3:Object;
            var _local_4:StashPanel;
            if (this._tabsData == null)
            {
                return;
            };
            for each (_local_2 in this._tabsData)
            {
                _local_3 = _local_2["tab"];
                if ((_local_3 is StashPanel))
                {
                    _local_4 = (_local_3 as StashPanel);
                    _local_4.VioletSellPanelInstance.ClearSlot(_arg_1);
                };
            };
        }

        public function RevalidateVioletSellPanel():void
        {
            var _local_1:Object;
            var _local_2:Object;
            var _local_3:StashPanel;
            if (this._tabsData == null)
            {
                return;
            };
            for each (_local_1 in this._tabsData)
            {
                _local_2 = _local_1["tab"];
                if ((_local_2 is StashPanel))
                {
                    _local_3 = (_local_2 as StashPanel);
                    _local_3.VioletSellPanelInstance.Revalidate();
                };
            };
        }

        public function RevalidateCraftRunePanel(_arg_1:Boolean=false, _arg_2:Boolean=false, _arg_3:ItemData=null):void
        {
            var _local_4:Object;
            var _local_5:Object;
            var _local_6:StashPanel;
            if (this._tabsData == null)
            {
                return;
            };
            for each (_local_4 in this._tabsData)
            {
                _local_5 = _local_4["tab"];
                if ((_local_5 is StashPanel))
                {
                    _local_6 = (_local_5 as StashPanel);
                    if (_arg_1)
                    {
                        _local_6.CraftRunePanelInstance.ClearCraftItemSlot();
                    };
                    if (_arg_2)
                    {
                        _local_6.CraftRunePanelInstance.ClearRuneCraftSlots();
                    };
                    if (_arg_3)
                    {
                        _local_6.CraftRunePanelInstance.SetCraftRuneSlot(_arg_3);
                    };
                    _local_6.CraftRunePanelInstance.Revalidate();
                };
            };
        }

        public function TabPanel(_arg_1:int):Object
        {
            if (((_arg_1 < 0) || (this._tabsData == null)))
            {
                return (null);
            };
            return (this._tabsData[_arg_1]);
        }


    }
}//package hbm.Game.GUI.CashShop

