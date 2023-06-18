


//hbm.Game.GUI.CashShopNew.NewBuyCashWindow

package hbm.Game.GUI.CashShopNew
{
    import hbm.Application.ClientApplication;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Game.GUI.Tools.CustomTabbedPane;
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.EditableSpinBoxEx;
    import org.aswing.JLabel;
    import hbm.Application.ClientConfig;
    import hbm.Engine.Network.Events.BuyCahsEvent;
    import mx.core.BitmapAsset;
    import org.aswing.Icon;
    import org.aswing.BorderLayout;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.AssetIcon;
    import org.aswing.SoftBoxLayout;
    import org.aswing.ASFont;
    import hbm.Game.Utility.HtmlText;
    import org.aswing.EmptyLayout;
    import org.aswing.JButton;
    import flash.events.MouseEvent;
    import org.aswing.Component;
    import hbm.Game.Statistic.StatisticManager;
    import flash.events.Event;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import hbm.Engine.Renderer.RenderSystem;

    public class NewBuyCashWindow extends WindowPrototype 
    {

        public static const GOLD_PANEL:int = 1;
        public static const SILVER_PANEL:int = 2;

        private const WIDTH:int = 748;
        private const HEIGHT:int = 600;
        private const _platform:int = ClientApplication.Instance.Config.CurrentPlatformId;

        private var _dataLibrary:AdditionalDataResourceLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
        private var _platformKoef:Number = 1;
        private var _tabs:CustomTabbedPane;
        private var _goldPanel:JPanel;
        private var _silverPanel:JPanel;
        private var _spinBox:EditableSpinBoxEx;
        private var _bonusPercent:JLabel;
        private var _bonusPanel:JPanel;
        private var _amountText:JLabel;
        private var _bonusText:JLabel;
        private var _silverPacks:JPanel;
        private var _textCurrency:JLabel;

        public function NewBuyCashWindow(_arg_1:*=null)
        {
            if (ClientApplication.fromPortal == 2)
            {
                this._platformKoef = 1;
            }
            else
            {
                switch (this._platform)
                {
                    case ClientConfig.VKONTAKTE:
                    case ClientConfig.VKONTAKTE_TEST:
                    case ClientConfig.DEBUG:
                    case ClientConfig.TEST:
                        this._platformKoef = 1;
                        break;
                    case ClientConfig.ODNOKLASSNIKI:
                    case ClientConfig.ODNOKLASSNIKI_TEST:
                        this._platformKoef = 6;
                        break;
                    case ClientConfig.MAILRU:
                    case ClientConfig.MAILRU_TEST:
                        this._platformKoef = 6;
                        break;
                    case ClientConfig.FOTOSTRANA:
                    case ClientConfig.FOTOSTRANA_TEST:
                        this._platformKoef = 0.6;
                        break;
                };
            };
            super(_arg_1, ClientApplication.Localization.BUY_DIALOG_TITLE, true, this.WIDTH, this.HEIGHT, true, true);
            hide();
            _closeWindowButton2.removeFromContainer();
            ClientApplication.Instance.LocalGameClient.addEventListener(BuyCahsEvent.ON_ZENY_PACKS, this.OnLoadSilverPacks);
            ClientApplication.Instance.LocalGameClient.SendGetBuyZenyList();
        }

        private function OnLoadSilverPacks(_arg_1:BuyCahsEvent):void
        {
            var _local_3:Array;
            if (!this._silverPacks)
            {
                return;
            };
            this._silverPacks.removeAll();
            var _local_2:uint;
            while (_local_2 < _arg_1.Packs.length)
            {
                _local_3 = _arg_1.Packs[_local_2];
                this._silverPacks.append(this.CreateSilverPackItem(_local_2, _local_3[0], _local_3[1]));
                _local_2++;
            };
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
            var _local_1:Icon;
            var _local_2:Icon;
            super.InitUI();
            Body.setLayout(new BorderLayout());
            AsWingUtil.SetBackground(Body, this.GetAsset("NBCW_Background"));
            this._tabs = new CustomTabbedPane();
            this._tabs.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            var _local_3:int = ClientApplication.Instance.Config.CurrentPlatformId;
            if (((!(_local_3 == ClientConfig.STANDALONE)) && (!(ClientApplication.fromPortal == 1))))
            {
                this._goldPanel = this.CreateBuyPanel(GOLD_PANEL);
                _local_1 = new AssetIcon(this.GetAsset("NBCW_TabIconGoldOut"));
                _local_2 = new AssetIcon(this.GetAsset("NBCW_TabIconGold"));
                this._tabs.AppendCustomTab(this._goldPanel, _local_1, _local_2, ClientApplication.Instance.GetPopupText(261));
            };
            this._silverPanel = this.CreateBuyPanel(SILVER_PANEL);
            _local_1 = new AssetIcon(this.GetAsset("NBCW_TabIconSilverOut"));
            _local_2 = new AssetIcon(this.GetAsset("NBCW_TabIconSilver"));
            this._tabs.AppendCustomTab(this._silverPanel, _local_1, _local_2, ClientApplication.Instance.GetPopupText(262));
            Body.append(this._tabs);
        }

        private function CreateBuyPanel(_arg_1:int):JPanel
        {
            var _local_6:Array;
            var _local_7:uint;
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            var _local_3:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.TOP));
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.TOP));
            AsWingUtil.SetWidth(_local_4, 485);
            AsWingUtil.SetBorder(_local_4, 0, -8);
            if (_arg_1 == GOLD_PANEL)
            {
                _local_6 = this.GetCurrencyPacks();
                _local_7 = 0;
                while (_local_7 < _local_6.length)
                {
                    _local_4.append(this.CreateGoldPackItem(_local_7, _local_6[_local_7]));
                    _local_7++;
                };
            }
            else
            {
                this._silverPacks = _local_4;
            };
            _local_3.append(_local_4);
            var _local_5:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackground(_local_5, this.GetAsset("NBCW_ImageGold"));
            _local_3.append(_local_5, BorderLayout.NORTH);
            _local_2.append(_local_3);
            if (_arg_1 == GOLD_PANEL)
            {
                _local_2.append(this.CreateBottomPanel());
            };
            return (_local_2);
        }

        private function CreateGoldPackItem(_arg_1:int, _arg_2:int):JPanel
        {
            return (this.CreatePackItem(_arg_1, GOLD_PANEL, this.GetPercentBonus(_arg_2), this.GetAmount(_arg_2), this.GetBonus(_arg_2), _arg_2));
        }

        private function CreateSilverPackItem(_arg_1:int, _arg_2:int, _arg_3:int):JPanel
        {
            return (this.CreatePackItem(_arg_1, SILVER_PANEL, 0, _arg_3, 0, _arg_2));
        }

        private function CreatePackItem(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int, _arg_6:int):JPanel
        {
            var _local_14:JPanel;
            var _local_15:JLabel;
            var _local_16:JPanel;
            var _local_17:JLabel;
            var _local_7:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.TOP));
            AsWingUtil.SetBackground(_local_7, this.GetAsset("NBCW_PackItem"));
            if (_arg_3 > 0)
            {
                _local_14 = new JPanel(new BorderLayout());
                AsWingUtil.SetBackground(_local_14, this.GetAsset("NBCW_PrizeFlag"));
                _local_15 = AsWingUtil.CreateLabel((("+" + _arg_3) + "%"), 0xFFFFFF, new ASFont(getFont().getName(), 12));
                AsWingUtil.SetBorder(_local_15, 0, -10);
                _local_15.setTextFilters([HtmlText.shadow]);
                _local_14.append(_local_15);
                _local_7.append(AsWingUtil.OffsetBorder(_local_14, 20, 0));
            }
            else
            {
                _local_16 = new JPanel(new EmptyLayout());
                AsWingUtil.SetSize(_local_16, 27, 52);
                _local_7.append(_local_16);
            };
            var _local_8:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackground(_local_8, this.GetAsset(((_arg_2 == GOLD_PANEL) ? "NBCW_CoinGoldSmall" : "NBCW_CoinSilverSmall")));
            _local_7.append(AsWingUtil.OffsetBorder(_local_8, 6, 6, 2));
            var _local_9:JPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetSize(_local_9, ((_arg_3 > 0) ? 102 : 130), 50);
            var _local_10:JLabel = AsWingUtil.CreateLabel(_arg_4.toString(), 16770453, new ASFont(getFont().getName(), 18, true));
            AsWingUtil.SetSize(_local_10, 102, 20);
            _local_10.setLocationXY(0, ((_arg_5 > 0) ? 5 : 13));
            _local_10.setHorizontalAlignment(JLabel.LEFT);
            _local_10.setTextFilters([HtmlText.glow]);
            _local_9.append(_local_10);
            if (_arg_5 > 0)
            {
                _local_17 = AsWingUtil.CreateLabel(("+" + _arg_5), 0xFFFFFF, new ASFont(getFont().getName(), 14, true));
                AsWingUtil.SetBackground(_local_17, this.GetAsset("NBCW_BackBonusBlue"));
                _local_17.setLocationXY(0, 25);
                _local_17.setHorizontalAlignment(JLabel.LEFT);
                _local_17.setTextFilters([HtmlText.glow]);
                _local_9.append(_local_17);
            };
            _local_7.append(_local_9);
            var _local_11:String = ((_arg_6 + " ") + ((_arg_2 == GOLD_PANEL) ? this.GetTextAmountCurrency(_arg_6) : this.GetTextAmountGold(_arg_6)));
            var _local_12:JLabel = AsWingUtil.CreateLabel(_local_11, 6255239, new ASFont(getFont().getName(), 14, true));
            AsWingUtil.SetWidth(_local_12, 110);
            _local_12.setHorizontalAlignment(JLabel.LEFT);
            _local_7.append(_local_12);
            var _local_13:JButton = AsWingUtil.CreateButton(((_arg_2 == GOLD_PANEL) ? Assets.BuyButton() : Assets.ChangeButton()), ((_arg_2 == GOLD_PANEL) ? Assets.BuyButtonOver() : Assets.ChangeButtonOver()), ((_arg_2 == GOLD_PANEL) ? Assets.BuyButtonActive() : Assets.ChangeButtonActive()));
            _local_7.putClientProperty("id", _arg_1);
            if (_arg_2 == GOLD_PANEL)
            {
                _local_7.putClientProperty("currency", _arg_6);
                _local_7.addEventListener(MouseEvent.CLICK, this.OnBuyGoldButton);
            }
            else
            {
                _local_7.putClientProperty("gold", _arg_6);
                _local_7.putClientProperty("silver", _arg_4);
                _local_7.addEventListener(MouseEvent.CLICK, this.OnBuySilverButton);
            };
            _local_7.append(_local_13);
            _local_7.useHandCursor = true;
            _local_7.buttonMode = true;
            return (AsWingUtil.OffsetBorder(_local_7, 13, 9, 22));
        }

        private function CreateBottomPanel():JPanel
        {
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0, SoftBoxLayout.TOP));
            AsWingUtil.SetBorder(_local_1, 0, 8);
            this._bonusPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackground(this._bonusPanel, this.GetAsset("NBCW_PrizeFlagBig"));
            this._bonusPercent = AsWingUtil.CreateLabel("", 16777133, new ASFont(getFont().getName(), 16));
            AsWingUtil.SetBorder(this._bonusPercent, 0, -10);
            this._bonusPercent.setTextFilters([HtmlText.shadow]);
            this._bonusPanel.append(this._bonusPercent);
            this._bonusPanel.alpha = 0;
            _local_1.append(AsWingUtil.OffsetBorder(this._bonusPanel, 20, 0));
            var _local_2:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackground(_local_2, this.GetAsset("NBCW_CoinGoldSmall"));
            _local_1.append(AsWingUtil.OffsetBorder(_local_2, 6, 18, 2));
            var _local_3:JPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetSize(_local_3, 100, 80);
            this._amountText = AsWingUtil.CreateLabel(this.GetAmount(1).toString(), 16770453, new ASFont(getFont().getName(), 18, true));
            AsWingUtil.SetSize(this._amountText, 100, 30);
            this._amountText.setLocationXY(0, 20);
            this._amountText.setHorizontalAlignment(JLabel.LEFT);
            this._amountText.setTextFilters([HtmlText.glow]);
            _local_3.append(this._amountText);
            this._bonusText = AsWingUtil.CreateLabel("+0", 0xFFFFFF, new ASFont(getFont().getName(), 14, true));
            AsWingUtil.SetBackground(this._bonusText, this.GetAsset("NBCW_BackBonusRed"));
            this._bonusText.setHorizontalAlignment(JLabel.LEFT);
            this._bonusText.setVerticalAlignment(JLabel.CENTER);
            this._bonusText.setTextFilters([HtmlText.glow]);
            this._bonusText.setLocationXY(0, 46);
            this._bonusText.visible = false;
            _local_3.append(this._bonusText);
            _local_1.append(_local_3);
            var _local_4:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetWidth(_local_4, 150);
            AsWingUtil.SetBorder(_local_4, 0, 28);
            if (ClientApplication.fromPortal == 2)
            {
                this._spinBox = new EditableSpinBoxEx(1, 20000, 1);
            }
            else
            {
                this._spinBox = new EditableSpinBoxEx(this._platformKoef, (2000 * this._platformKoef), ((this._platformKoef > 0) ? Math.ceil(this._platformKoef) : 1));
            };
            this._spinBox.SetStateListener(this.OnChangeValue);
            _local_4.append(this._spinBox);
            _local_1.append(_local_4);
            this._textCurrency = AsWingUtil.CreateLabel(this.GetTextAmountCurrency(1), 6255239, new ASFont(getFont().getName(), 14, true));
            AsWingUtil.SetWidth(this._textCurrency, 170);
            this._textCurrency.setHorizontalAlignment(JLabel.LEFT);
            _local_1.append(this._textCurrency);
            var _local_5:JButton = AsWingUtil.CreateButton(this.GetAssetLocalization("CS_BuyButtonBig"), this.GetAssetLocalization("CS_BuyButtonBigOver"), this.GetAssetLocalization("CS_BuyButtonBigPress"));
            _local_5.putClientProperty("currency", "calc");
            AsWingUtil.SetBorder(_local_5, 0, 0);
            _local_5.addActionListener(this.OnBuyGoldButton);
            _local_1.append(_local_5);
            return (_local_1);
        }

        private function GetTextAmountCurrency(_arg_1:int):String
        {
            var _local_2:Array;
            if (ClientApplication.fromPortal == 2)
            {
                _local_2 = ClientApplication.Localization.BUY_DIALOG_MM_DECLINATION;
            }
            else
            {
                switch (this._platform)
                {
                    case ClientConfig.VKONTAKTE:
                    case ClientConfig.DEBUG:
                    case ClientConfig.VKONTAKTE_TEST:
                    case ClientConfig.TEST:
                        _local_2 = ClientApplication.Localization.BUY_DIALOG_VK_DECLINATION;
                        break;
                    case ClientConfig.MAILRU:
                    case ClientConfig.MAILRU_TEST:
                    case ClientConfig.WEB:
                    case ClientConfig.WEB_TEST:
                        _local_2 = ClientApplication.Localization.BUY_DIALOG_MM_DECLINATION;
                        break;
                    case ClientConfig.ODNOKLASSNIKI:
                    case ClientConfig.ODNOKLASSNIKI_TEST:
                        return (ClientApplication.Localization.BUY_DIALOG_OK_DECLINATION);
                    case ClientConfig.FOTOSTRANA:
                    case ClientConfig.FOTOSTRANA_TEST:
                        return (ClientApplication.Localization.BUY_DIALOG_FS_DECLINATION);
                    default:
                        return ("");
                };
            };
            return (HtmlText.declination(_arg_1, _local_2));
        }

        private function GetTextAmountGold(_arg_1:int):String
        {
            var _local_2:Array = ClientApplication.Localization.BUY_DIALOG_GOLDS_DECLINATION;
            return (HtmlText.declination(_arg_1, _local_2));
        }

        private function OnChangeValue():void
        {
            var _local_1:int;
            _local_1 = this._spinBox.GetValue();
            var _local_2:int = this.GetPercentBonus(_local_1);
            if (_local_2 > 0)
            {
                this._bonusPercent.setText((("+" + _local_2) + "%"));
                this._bonusPanel.alpha = 1;
            }
            else
            {
                this._bonusPercent.setText("");
                this._bonusPanel.alpha = 0;
            };
            this._amountText.setText(this.GetAmount(_local_1).toString());
            var _local_3:int = this.GetBonus(_local_1);
            if (_local_3 > 0)
            {
                this._bonusText.setText(("+" + _local_3));
                this._bonusText.visible = true;
            }
            else
            {
                this._bonusText.visible = false;
            };
            this._textCurrency.setText(this.GetTextAmountCurrency(_local_1));
        }

        private function GetPercentBonus(_arg_1:int):int
        {
            if (ClientApplication.fromPortal == 2)
            {
                if (((_arg_1 >= 1) && (_arg_1 < 6)))
                {
                    return (0);
                };
                if (((_arg_1 >= 6) && (_arg_1 < 13)))
                {
                    return (50);
                };
                if (((_arg_1 >= 13) && (_arg_1 < 20)))
                {
                    return (60);
                };
                if (((_arg_1 >= 20) && (_arg_1 < 200)))
                {
                    return (65);
                };
                if (((_arg_1 >= 200) && (_arg_1 < 400)))
                {
                    return (70);
                };
                if (((_arg_1 >= 400) && (_arg_1 < 700)))
                {
                    return (75);
                };
                if (((_arg_1 >= 700) && (_arg_1 < 1000)))
                {
                    return (80);
                };
                if (((_arg_1 >= 1000) && (_arg_1 < 1500)))
                {
                    return (95);
                };
                if (((_arg_1 >= 1500) && (_arg_1 < 2000)))
                {
                    return (110);
                };
                if (((_arg_1 >= 2000) && (_arg_1 < 3000)))
                {
                    return (120);
                };
                if (((_arg_1 >= 3000) && (_arg_1 < 5000)))
                {
                    return (135);
                };
                if (((_arg_1 >= 5000) && (_arg_1 < 7000)))
                {
                    return (140);
                };
                if (((_arg_1 >= 7000) && (_arg_1 < 10000)))
                {
                    return (145);
                };
                if (_arg_1 >= 10000)
                {
                    return (150);
                };
            }
            else
            {
                if (((_arg_1 >= this._platformKoef) && (_arg_1 < (9 * this._platformKoef))))
                {
                    return (0);
                };
                if (((_arg_1 >= (9 * this._platformKoef)) && (_arg_1 < (40 * this._platformKoef))))
                {
                    return (12);
                };
                if (((_arg_1 >= (40 * this._platformKoef)) && (_arg_1 < (75 * this._platformKoef))))
                {
                    return (25);
                };
                if (((_arg_1 >= (75 * this._platformKoef)) && (_arg_1 < (350 * this._platformKoef))))
                {
                    return (34);
                };
                if (((_arg_1 >= (350 * this._platformKoef)) && (_arg_1 < (650 * this._platformKoef))))
                {
                    return (43);
                };
                if (((_arg_1 >= (650 * this._platformKoef)) && (_arg_1 < (1000 * this._platformKoef))))
                {
                    return (54);
                };
                if (_arg_1 >= (1000 * this._platformKoef))
                {
                    return (100);
                };
            };
            return (0);
        }

        private function GetCurrencyPacks():Array
        {
            if (ClientApplication.fromPortal == 2)
            {
                return ([150, 300, 1300, 2200, 3600, 10000]);
            };
            switch (this._platform)
            {
                case ClientConfig.DEBUG:
                case ClientConfig.TEST:
                case ClientConfig.VKONTAKTE_TEST:
                case ClientConfig.VKONTAKTE:
                    return ([30, 60, 250, 500, 700, 1000]);
                case ClientConfig.WEB:
                case ClientConfig.WEB_TEST:
                case ClientConfig.FACEBOOK:
                case ClientConfig.FACEBOOK_TEST:
                    return ([150, 300, 1300, 2200, 3600, 10000]);
                case ClientConfig.MAILRU:
                case ClientConfig.MAILRU_TEST:
                case ClientConfig.ODNOKLASSNIKI:
                case ClientConfig.ODNOKLASSNIKI_TEST:
                    return ([180, 360, 1500, 3000, 4200, 6000]);
                case ClientConfig.FOTOSTRANA:
                case ClientConfig.FOTOSTRANA_TEST:
                    return ([20, 40, 160, 315, 440, 625]);
                default:
                    return ([]);
            };
        }

        private function GetAmountWithBonus(_arg_1:int):Number
        {
            var _local_2:Number = 0;
            if (ClientApplication.fromPortal == 2)
            {
                if (((_arg_1 >= 1) && (_arg_1 < 6)))
                {
                    _local_2 = (2 * _arg_1);
                }
                else
                {
                    if (((_arg_1 >= 6) && (_arg_1 < 13)))
                    {
                        _local_2 = ((18 * _arg_1) / 6);
                    }
                    else
                    {
                        if (((_arg_1 >= 13) && (_arg_1 < 20)))
                        {
                            _local_2 = ((42 * _arg_1) / 13);
                        }
                        else
                        {
                            if (((_arg_1 >= 20) && (_arg_1 < 200)))
                            {
                                _local_2 = ((66 * _arg_1) / 20);
                            }
                            else
                            {
                                if (((_arg_1 >= 200) && (_arg_1 < 400)))
                                {
                                    _local_2 = ((680 * _arg_1) / 200);
                                }
                                else
                                {
                                    if (((_arg_1 >= 400) && (_arg_1 < 700)))
                                    {
                                        _local_2 = ((1400 * _arg_1) / 400);
                                    }
                                    else
                                    {
                                        if (((_arg_1 >= 700) && (_arg_1 < 1000)))
                                        {
                                            _local_2 = ((2520 * _arg_1) / 700);
                                        }
                                        else
                                        {
                                            if (((_arg_1 >= 1000) && (_arg_1 < 1500)))
                                            {
                                                _local_2 = ((3900 * _arg_1) / 1000);
                                            }
                                            else
                                            {
                                                if (((_arg_1 >= 1500) && (_arg_1 < 2000)))
                                                {
                                                    _local_2 = ((6300 * _arg_1) / 1500);
                                                }
                                                else
                                                {
                                                    if (((_arg_1 >= 2000) && (_arg_1 < 3000)))
                                                    {
                                                        _local_2 = ((8800 * _arg_1) / 2000);
                                                    }
                                                    else
                                                    {
                                                        if (((_arg_1 >= 3000) && (_arg_1 < 5000)))
                                                        {
                                                            _local_2 = ((14100 * _arg_1) / 3000);
                                                        }
                                                        else
                                                        {
                                                            if (((_arg_1 >= 5000) && (_arg_1 < 7000)))
                                                            {
                                                                _local_2 = ((24000 * _arg_1) / 5000);
                                                            }
                                                            else
                                                            {
                                                                if (((_arg_1 >= 7000) && (_arg_1 < 10000)))
                                                                {
                                                                    _local_2 = ((34300 * _arg_1) / 7000);
                                                                }
                                                                else
                                                                {
                                                                    if (_arg_1 >= 10000)
                                                                    {
                                                                        _local_2 = ((50000 * _arg_1) / 10000);
                                                                    };
                                                                };
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            }
            else
            {
                if (((_arg_1 >= this._platformKoef) && (_arg_1 < (9 * this._platformKoef))))
                {
                    _local_2 = ((10 * _arg_1) / this._platformKoef);
                }
                else
                {
                    if (((_arg_1 >= (9 * this._platformKoef)) && (_arg_1 < (40 * this._platformKoef))))
                    {
                        _local_2 = ((100 * _arg_1) / (9 * this._platformKoef));
                    }
                    else
                    {
                        if (((_arg_1 >= (40 * this._platformKoef)) && (_arg_1 < (75 * this._platformKoef))))
                        {
                            _local_2 = ((500 * _arg_1) / (40 * this._platformKoef));
                        }
                        else
                        {
                            if (((_arg_1 >= (75 * this._platformKoef)) && (_arg_1 < (350 * this._platformKoef))))
                            {
                                _local_2 = ((1000 * _arg_1) / (75 * this._platformKoef));
                            }
                            else
                            {
                                if (((_arg_1 >= (350 * this._platformKoef)) && (_arg_1 < (650 * this._platformKoef))))
                                {
                                    _local_2 = ((5000 * _arg_1) / (350 * this._platformKoef));
                                }
                                else
                                {
                                    if (((_arg_1 >= (650 * this._platformKoef)) && (_arg_1 < (1000 * this._platformKoef))))
                                    {
                                        _local_2 = ((10000 * _arg_1) / (650 * this._platformKoef));
                                    }
                                    else
                                    {
                                        if (_arg_1 >= (1000 * this._platformKoef))
                                        {
                                            _local_2 = ((20000 * _arg_1) / (1000 * this._platformKoef));
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            return (_local_2);
        }

        private function GetAmount(_arg_1:Number):int
        {
            if (ClientApplication.fromPortal == 2)
            {
                return (int((2 * _arg_1)));
            };
            return (int(((10 * _arg_1) / this._platformKoef)));
        }

        private function GetBonus(_arg_1:Number):int
        {
            var _local_2:int;
            if (ClientApplication.fromPortal == 2)
            {
                _local_2 = int((this.GetAmountWithBonus(_arg_1) - (2 * _arg_1)));
            }
            else
            {
                _local_2 = int(int((this.GetAmountWithBonus(_arg_1) - ((10 * _arg_1) / this._platformKoef))));
            };
            return ((_local_2 > 0) ? _local_2 : 0);
        }

        private function GetResult(_arg_1:Number):int
        {
            return (int(this.GetAmountWithBonus(_arg_1)));
        }

        private function OnBuyGoldButton(_arg_1:Event):void
        {
            var _local_3:int;
            var _local_4:Object;
            var _local_5:Number;
            var _local_2:Component = (_arg_1.currentTarget as Component);
            if (_local_2)
            {
                _local_3 = _local_2.getClientProperty("id");
                _local_4 = _local_2.getClientProperty("currency");
                if (_local_4 == "calc")
                {
                    _local_5 = this._spinBox.GetValue();
                    StatisticManager.Instance.SendEventNum("BuyGoldFreeClick", this.GetAmount(_local_5));
                }
                else
                {
                    _local_5 = Number(_local_4);
                    StatisticManager.Instance.SendEvent((("BuyGoldRack" + (_local_3 + 1)) + "Click"));
                };
                this.dispose();
                ClientApplication.Instance.BuyMoneyRequest(_local_5);
            };
        }

        private function OnBuySilverButton(e:Event):void
        {
            var id:int;
            var amountGold:Number;
            var amountSilver:Number;
            var player:CharacterInfo;
            var inf:String;
            var component:Component = (e.currentTarget as Component);
            if (component)
            {
                id = component.getClientProperty("id");
                amountGold = Number(component.getClientProperty("gold"));
                amountSilver = Number(component.getClientProperty("silver"));
                player = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                if (((player) && (player.cashPoints < amountGold)))
                {
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.BUY_DIALOG_BUY_INFO, ClientApplication.Localization.BUY_DIALOG_NOT_ENOUGH_MONEY, this.SelectBuyGold, null, false, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
                }
                else
                {
                    var resultDlgBuy:Function = function (_arg_1:int):void
                    {
                        if (_arg_1 == JOptionPane.YES)
                        {
                            StatisticManager.Instance.SendEvent((("BuySilverPack" + (id + 1)) + "Click"));
                            ClientApplication.Instance.LocalGameClient.SenBuyZeny(id);
                        };
                    };
                    inf = ClientApplication.Localization.BUY_DIALOG_BUY_SILVER.concat();
                    inf = inf.replace("%1", amountSilver.toFixed());
                    inf = inf.replace("%2", amountGold.toFixed());
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.BUY_DIALOG_BUY_INFO, inf, resultDlgBuy, null, false, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
                };
            };
        }

        private function SelectBuyGold(_arg_1:int):void
        {
            if (_arg_1 == JOptionPane.YES)
            {
                this._tabs.setSelectedComponent(this._goldPanel);
            };
        }

        public function ShowBuyCash(_arg_1:int=1):void
        {
            this.show();
            this.AlignCenterScreen();
            var _local_2:Component = (((_arg_1 == GOLD_PANEL) && (this._goldPanel)) ? this._goldPanel : this._silverPanel);
            this._tabs.setSelectedComponent(_local_2);
        }

        private function AlignCenterScreen():void
        {
            if (!isShowing())
            {
                return;
            };
            setLocationXY(((RenderSystem.Instance.ScreenWidth - width) / 2), ((RenderSystem.Instance.ScreenHeight - height) / 2));
        }

        override public function show():void
        {
            super.show();
            ClientApplication.Instance.BottomHUD.BlinkGold(false);
            ClientApplication.Instance.SetShortcutsEnabled(false);
        }

        override public function dispose():void
        {
            super.dispose();
            ClientApplication.Instance.SetShortcutsEnabled(true);
        }


    }
}//package hbm.Game.GUI.CashShopNew

