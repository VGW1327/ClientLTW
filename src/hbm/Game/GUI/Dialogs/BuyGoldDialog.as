


//hbm.Game.GUI.Dialogs.BuyGoldDialog

package hbm.Game.GUI.Dialogs
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import hbm.Application.ClientApplication;
    import org.aswing.JAdjuster;
    import org.aswing.JLabel;
    import org.aswing.ASFont;
    import org.aswing.JPanel;
    import hbm.Application.ClientConfig;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import flash.text.StyleSheet;
    import hbm.Game.Utility.HtmlText;
    import org.aswing.JTextArea;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.SoftBoxLayout;
    import org.aswing.AssetIcon;
    import hbm.Game.GUI.Tools.WindowSprites;
    import org.aswing.FlowLayout;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.AttachIcon;
    import org.aswing.BorderLayout;
    import org.aswing.event.AWEvent;

    public class BuyGoldDialog extends CustomWindow 
    {

        private const _width:int = 610;
        private const _height:int = 200;
        private const _platform:int = ClientApplication.Instance.Config.CurrentPlatformId;

        private var _amountAdjuster:JAdjuster;
        private var _result:JLabel;
        private var _base:JLabel;
        private var _bonus:JLabel;
        private var _platformKoef:Number = 1;

        public function BuyGoldDialog()
        {
            var _local_2:JLabel;
            var _local_3:ASFont;
            var _local_11:String;
            var _local_26:String;
            var _local_27:JPanel;
            super(null, ClientApplication.Localization.BUY_DIALOG_TITLE, true, (this._width - 12), this._height, true);
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
                case ClientConfig.MAILRU:
                case ClientConfig.MAILRU_TEST:
                case ClientConfig.FACEBOOK:
                case ClientConfig.FACEBOOK_TEST:
                    this._platformKoef = 6;
                    break;
                case ClientConfig.FOTOSTRANA:
                case ClientConfig.FOTOSTRANA_TEST:
                    this._platformKoef = 0.6;
                    break;
            };
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            _local_2 = new JLabel(ClientApplication.Localization.BUY_DIALOG_BONUS_INFO);
            _local_3 = _local_2.getFont();
            var _local_4:ASFont = new ASFont(_local_3.getName(), 12, true);
            _local_2.setFont(_local_4);
            var _local_5:StyleSheet = new StyleSheet();
            _local_5.setStyle("p", {
                "color":"#f0f3f5",
                "fontFamily":HtmlText.fontName,
                "fontSize":12
            });
            var _local_6:* = "";
            _local_6 = (_local_6 + this.GetHtmlTextForBonus(9, 40, 12));
            _local_6 = (_local_6 + this.GetHtmlTextForBonus(40, 75, 25, true));
            _local_6 = (_local_6 + this.GetHtmlTextForBonus(75, 350, 34, true));
            _local_6 = (_local_6 + this.GetHtmlTextForBonus(350, 650, 43, true));
            _local_6 = (_local_6 + this.GetHtmlTextForBonus(650, 1000, 54, true));
            _local_6 = (_local_6 + this.GetHtmlTextForBonus(1000, -1, 100, true));
            var _local_7:JTextArea = new JTextArea();
            _local_7.setBorder(new EmptyBorder(_local_1, new Insets(0, 0, 0, 0)));
            _local_7.setPreferredWidth((this._width / 2));
            _local_7.setPreferredHeight(105);
            _local_7.setEditable(false);
            _local_7.setWordWrap(true);
            _local_7.setBackgroundDecorator(null);
            _local_7.setHtmlText(_local_6);
            _local_7.getTextField().selectable = false;
            var _local_8:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            _local_8.append(_local_2);
            _local_8.append(_local_7);
            var _local_9:JLabel = new JLabel(ClientApplication.Localization.BUY_DIALOG_BUY_INFO);
            _local_9.setFont(_local_4);
            var _local_10:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4));
            switch (this._platform)
            {
                case ClientConfig.VKONTAKTE:
                case ClientConfig.VKONTAKTE_TEST:
                    _local_11 = ClientApplication.Localization.BUY_DIALOG_VOICE_AMOUNT_VK;
                    break;
                case ClientConfig.MAILRU:
                case ClientConfig.MAILRU_TEST:
                case ClientConfig.DEBUG:
                case ClientConfig.TEST:
                case ClientConfig.FACEBOOK:
                case ClientConfig.FACEBOOK_TEST:
                    _local_11 = ClientApplication.Localization.BUY_DIALOG_VOICE_AMOUNT_MM;
                    break;
                case ClientConfig.ODNOKLASSNIKI:
                case ClientConfig.ODNOKLASSNIKI_TEST:
                    _local_11 = ClientApplication.Localization.BUY_DIALOG_VOICE_AMOUNT_OK;
                    break;
                case ClientConfig.FOTOSTRANA:
                case ClientConfig.FOTOSTRANA_TEST:
                    _local_11 = ClientApplication.Localization.BUY_DIALOG_VOICE_AMOUNT_FS;
                    break;
                default:
                    _local_11 = "";
            };
            var _local_12:JLabel = new JLabel(_local_11, null, JLabel.RIGHT);
            _local_12.setPreferredWidth(210);
            this._amountAdjuster = new JAdjuster(3);
            this._amountAdjuster.setMinimum(((this._platformKoef < 1) ? 1 : this._platformKoef));
            this._amountAdjuster.setMaximum((2000 * this._platformKoef));
            this._amountAdjuster.setValue(((this._platformKoef < 1) ? 1 : this._platformKoef));
            this._amountAdjuster.setPreferredWidth(65);
            this._amountAdjuster.setEditable(true);
            this._amountAdjuster.addStateListener(this.OnChangeValue);
            _local_10.append(_local_12);
            _local_10.append(this._amountAdjuster);
            var _local_13:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4));
            this._base = new JLabel(this.GetAmount(((this._platformKoef < 1) ? 1 : this._platformKoef)).toString(), null, JLabel.RIGHT);
            this._base.setPreferredWidth(50);
            this._base.setFont(_local_4);
            this._base.setForeground(new ASColor(0xFFFFFF));
            var _local_14:JLabel = new JLabel((ClientApplication.Localization.BUY_DIALOG_BASE_AMOUNT_GOLD + ":"), null, JLabel.RIGHT);
            _local_14.setPreferredWidth(150);
            _local_14.setFont(_local_4);
            _local_13.append(_local_14);
            _local_13.append(this._base);
            _local_13.append(new JLabel("", new AssetIcon(new WindowSprites.CoinGold())));
            var _local_15:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4));
            this._bonus = new JLabel(this.GetBonus(((this._platformKoef < 1) ? 1 : this._platformKoef)).toString(), null, JLabel.RIGHT);
            this._bonus.setPreferredWidth(50);
            this._bonus.setFont(_local_4);
            this._bonus.setForeground(new ASColor(0xFFFFFF));
            var _local_16:JLabel = new JLabel(ClientApplication.Localization.BUY_DIALOG_BONUS_AMOUNT, null, JLabel.RIGHT);
            _local_16.setPreferredWidth(150);
            _local_16.setFont(_local_4);
            _local_15.append(_local_16);
            _local_15.append(this._bonus);
            _local_15.append(new JLabel("", new AssetIcon(new WindowSprites.CoinGold())));
            var _local_17:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4));
            this._result = new JLabel(this.GetResult(((this._platformKoef < 1) ? 1 : this._platformKoef)).toString(), null, JLabel.RIGHT);
            this._result.setPreferredWidth(50);
            this._result.setFont(_local_4);
            this._result.setForeground(new ASColor(16240402));
            var _local_18:JLabel = new JLabel(ClientApplication.Localization.BUY_DIALOG_RESULT_AMOUNT, null, JLabel.RIGHT);
            _local_18.setPreferredWidth(150);
            _local_18.setFont(_local_4);
            _local_17.append(_local_18);
            _local_17.append(this._result);
            _local_17.append(new JLabel("", new AssetIcon(new WindowSprites.CoinGold())));
            var _local_19:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, SoftBoxLayout.LEFT));
            _local_19.setBorder(new EmptyBorder(_local_1, new Insets(0, 0, 0, 0)));
            _local_19.setPreferredWidth(((this._width / 2) - 13));
            _local_19.setPreferredHeight(105);
            _local_19.append(_local_10);
            _local_19.append(_local_13);
            _local_19.append(_local_15);
            _local_19.append(_local_17);
            var _local_20:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.CENTER));
            _local_20.append(_local_9);
            _local_20.append(_local_19);
            var _local_21:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4));
            _local_21.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            _local_21.append(_local_8);
            _local_21.append(_local_20);
            var _local_22:JPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
            var _local_23:CustomButton = new CustomButton(ClientApplication.Localization.OK);
            var _local_24:CustomButton = new CustomButton(ClientApplication.Localization.CANCEL);
            _local_23.setPreferredWidth(64);
            _local_24.setPreferredWidth(64);
            _local_23.addActionListener(this.OnActionPressed, 0, true);
            _local_24.addActionListener(this.OnCancel, 0, true);
            _local_22.append(_local_23);
            _local_22.append(_local_24);
            var _local_25:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4, SoftBoxLayout.LEFT));
            _local_25.setBorder(new EmptyBorder(null, new Insets(2, 4, 4, 4)));
            _local_25.append(_local_21);
            switch (this._platform)
            {
                case ClientConfig.ODNOKLASSNIKI:
                case ClientConfig.ODNOKLASSNIKI_TEST:
                    _local_26 = ClientApplication.Localization.BUY_DIALOG_WARNING_MESSAGE_OK;
                    setPreferredHeight((this._height + 90));
                    _local_27 = new JPanel(new FlowLayout(FlowLayout.CENTER));
                    _local_27.setBorder(new EmptyBorder(_local_1, new Insets(0, (this._width / 4), 0, (this._width / 4))));
                    _local_27.setWidth((this._width / 2));
                    _local_27.append(new JLabel(_local_26, new AttachIcon("AchtungIcon")));
                    _local_25.append(_local_27);
                    break;
                case ClientConfig.VKONTAKTE:
                case ClientConfig.VKONTAKTE_TEST:
                case ClientConfig.MAILRU:
                case ClientConfig.MAILRU_TEST:
                case ClientConfig.DEBUG:
                case ClientConfig.TEST:
                case ClientConfig.FOTOSTRANA:
                case ClientConfig.FOTOSTRANA_TEST:
                case ClientConfig.FACEBOOK:
                case ClientConfig.FACEBOOK_TEST:
                    setPreferredHeight((this._height + 40));
                    break;
            };
            _local_25.append(_local_22);
            MainPanel.append(_local_25, BorderLayout.CENTER);
            pack();
            setLocationXY(80, 180);
        }

        override public function show():void
        {
            super.show();
            ClientApplication.Instance.BottomHUD.BlinkGold(false);
            ClientApplication.Instance.SetShortcutsEnabled(false);
        }

        private function OnCancel(_arg_1:AWEvent):void
        {
            ClientApplication.Instance.SetShortcutsEnabled(true);
            dispose();
        }

        private function OnActionPressed(_arg_1:AWEvent):void
        {
            ClientApplication.Instance.SetShortcutsEnabled(true);
            var _local_2:Number = this._amountAdjuster.getValue();
            dispose();
            ClientApplication.Instance.BuyMoneyRequest(_local_2);
        }

        private function OnChangeValue(_arg_1:AWEvent):void
        {
            this._base.setText(this.GetAmount(this._amountAdjuster.getValue()).toString());
            this._bonus.setText(this.GetBonus(this._amountAdjuster.getValue()).toString());
            this._result.setText(this.GetResult(this._amountAdjuster.getValue()).toString());
        }

        private function GetAmountWithBonus(_arg_1:int):Number
        {
            var _local_2:Number = 0;
            if (((((((((((((this._platform == ClientConfig.VKONTAKTE) || (this._platform == ClientConfig.VKONTAKTE)) || (this._platform == ClientConfig.MAILRU)) || (this._platform == ClientConfig.MAILRU_TEST)) || (this._platform == ClientConfig.ODNOKLASSNIKI)) || (this._platform == ClientConfig.ODNOKLASSNIKI_TEST)) || (this._platform == ClientConfig.DEBUG)) || (this._platform == ClientConfig.TEST)) || (this._platform == ClientConfig.FOTOSTRANA)) || (this._platform == ClientConfig.FOTOSTRANA_TEST)) || (this._platform == ClientConfig.FACEBOOK)) || (this._platform == ClientConfig.FACEBOOK_TEST)))
            {
                if (((_arg_1 >= this._platformKoef) && (_arg_1 < int((9 * this._platformKoef)))))
                {
                    _local_2 = ((10 * _arg_1) / this._platformKoef);
                }
                else
                {
                    if (((_arg_1 >= int((9 * this._platformKoef))) && (_arg_1 < int((40 * this._platformKoef)))))
                    {
                        _local_2 = ((100 * _arg_1) / (9 * this._platformKoef));
                    }
                    else
                    {
                        if (((_arg_1 >= int((40 * this._platformKoef))) && (_arg_1 < int((75 * this._platformKoef)))))
                        {
                            _local_2 = ((500 * _arg_1) / (40 * this._platformKoef));
                        }
                        else
                        {
                            if (((_arg_1 >= int((75 * this._platformKoef))) && (_arg_1 < int((350 * this._platformKoef)))))
                            {
                                _local_2 = ((1000 * _arg_1) / (75 * this._platformKoef));
                            }
                            else
                            {
                                if (((_arg_1 >= int((350 * this._platformKoef))) && (_arg_1 < int((650 * this._platformKoef)))))
                                {
                                    _local_2 = ((5000 * _arg_1) / (350 * this._platformKoef));
                                }
                                else
                                {
                                    if (((_arg_1 >= int((650 * this._platformKoef))) && (_arg_1 < int((1000 * this._platformKoef)))))
                                    {
                                        _local_2 = ((10000 * _arg_1) / (650 * this._platformKoef));
                                    }
                                    else
                                    {
                                        if (_arg_1 >= int((1000 * this._platformKoef)))
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
            return (int(((10 * _arg_1) / this._platformKoef)));
        }

        private function GetBonus(_arg_1:Number):int
        {
            var _local_2:int = int(int((this.GetAmountWithBonus(_arg_1) - ((10 * _arg_1) / this._platformKoef))));
            return ((_local_2 > 0) ? _local_2 : 0);
        }

        private function GetResult(_arg_1:Number):int
        {
            return (int(this.GetAmountWithBonus(_arg_1)));
        }

        private function GetHtmlTextForBonus(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:Boolean=false):String
        {
            var _local_6:String;
            var _local_5:* = "";
            _arg_1 = (_arg_1 * this._platformKoef);
            _arg_2 = (_arg_2 * this._platformKoef);
            _arg_2--;
            if (_arg_4)
            {
                _local_5 = (_local_5 + "<br>");
            };
            _local_5 = (_local_5 + (((((ClientApplication.Localization.BUY_DIALOG_BONUS_INFO_PART1 + " ") + '<font color="#f7cf12">') + _arg_1) + "</font>") + " "));
            if (_arg_2 >= 0)
            {
                _local_5 = (_local_5 + (((((ClientApplication.Localization.BUY_DIALOG_BONUS_INFO_PART2 + " ") + '<font color="#f7cf12">') + _arg_2) + "</font>") + " "));
            };
            switch (this._platform)
            {
                case ClientConfig.VKONTAKTE:
                case ClientConfig.VKONTAKTE_TEST:
                case ClientConfig.DEBUG:
                case ClientConfig.TEST:
                    _local_6 = ClientApplication.Localization.BUY_DIALOG_BONUS_INFO_PART3_VK;
                    break;
                case ClientConfig.MAILRU:
                case ClientConfig.MAILRU_TEST:
                case ClientConfig.FACEBOOK:
                case ClientConfig.FACEBOOK_TEST:
                    _local_6 = ClientApplication.Localization.BUY_DIALOG_BONUS_INFO_PART3_MM;
                    break;
                case ClientConfig.ODNOKLASSNIKI:
                case ClientConfig.ODNOKLASSNIKI_TEST:
                    _local_6 = ClientApplication.Localization.BUY_DIALOG_BONUS_INFO_PART3_OK;
                    break;
                case ClientConfig.FOTOSTRANA:
                case ClientConfig.FOTOSTRANA_TEST:
                    _local_6 = ClientApplication.Localization.BUY_DIALOG_BONUS_INFO_PART3_FS;
                    break;
                default:
                    _local_6 = "";
            };
            _local_5 = (_local_5 + (((((((_local_6 + " ") + '<font color="#23FF3D">') + ClientApplication.Localization.BUY_DIALOG_BONUS_INFO_PART2) + " ") + _arg_3) + "%") + "</font>"));
            return (_local_5);
        }


    }
}//package hbm.Game.GUI.Dialogs

