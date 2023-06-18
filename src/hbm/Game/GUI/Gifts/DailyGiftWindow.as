


//hbm.Game.GUI.Gifts.DailyGiftWindow

package hbm.Game.GUI.Gifts
{
    import hbm.Game.GUI.Tools.ShadowWindow;
    import hbm.Game.Utility.AsWingUtil;
    import hbm.Application.ClientApplication;
    import org.aswing.ASFont;
    import org.aswing.JLabel;
    import hbm.Game.Utility.HtmlText;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import flash.geom.ColorTransform;
    import org.aswing.EmptyLayout;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import flash.events.Event;
    import hbm.Engine.Renderer.RenderSystem;

    public class DailyGiftWindow extends ShadowWindow 
    {

        private var _premium:int;
        private var _day:int;

        public function DailyGiftWindow(_arg_1:int, _arg_2:int)
        {
            this._premium = _arg_1;
            this._day = _arg_2;
            super();
        }

        override protected function InitUI():void
        {
            super.InitUI();
            AsWingUtil.SetBackgroundFromAsset(_window, "DGW_Background");
            var _local_1:JLabel = AsWingUtil.CreateLabel(ClientApplication.Localization.DAILY_GIFT_WINDOW_TITLE, 16772788, new ASFont(getFont().getName(), 14, true));
            AsWingUtil.SetSize(_local_1, 182, 32);
            _local_1.setLocationXY(250, 122);
            _local_1.setTextFilters([HtmlText.shadow]);
            _window.append(_local_1);
            var _local_2:JLabel = AsWingUtil.CreateLabel(ClientApplication.Localization.DAILY_GIFT_WINDOW_LABEL, 0xFFFFFF, new ASFont(getFont().getName(), 18));
            AsWingUtil.SetSize(_local_2, 244, 20);
            _local_2.setLocationXY(218, 216);
            _local_2.setTextFilters([HtmlText.shadow]);
            _window.append(_local_2);
            var _local_3:JLabel = AsWingUtil.CreateLabel(ClientApplication.Localization.DAILY_GIFT_WINDOW_LABEL2, 0xFFFFFF, new ASFont(getFont().getName(), 13));
            AsWingUtil.SetSize(_local_3, 352, 20);
            _local_3.setLocationXY(174, 274);
            _window.append(_local_3);
            _window.append(this.CreateRewardCarts());
            var _local_4:CustomButton = AsWingUtil.CreateCustomButtonFromAssetLocalization("DGW_ButtonTake", "DGW_ButtonTakeOver");
            _local_4.setLocationXY(292, 0x0202);
            _local_4.addActionListener(this.OnClose, 0, true);
            _window.append(_local_4);
        }

        private function CreateRewardCarts():JPanel
        {
            var _local_5:Object;
            var _local_6:Object;
            var _local_7:uint;
            var _local_8:JPanel;
            var _local_9:JPanel;
            var _local_10:JLabel;
            var _local_11:String;
            var _local_12:JLabel;
            var _local_13:Array;
            var _local_14:String;
            var _local_15:JPanel;
            var _local_16:JPanel;
            var _local_17:JPanel;
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4, SoftBoxLayout.LEFT));
            AsWingUtil.SetSize(_local_1, 646, 185);
            _local_1.setLocationXY(42, 308);
            var _local_2:ColorTransform = new ColorTransform(1.2, 1.2, 1.2, 1, 30, 30, 30);
            var _local_3:ASFont = new ASFont(HtmlText.fontName, 16, true);
            var _local_4:Object = AsWingUtil.AdditionalData.GetGiftDbData(this._premium);
            if (_local_4)
            {
                _local_5 = {};
                for each (_local_6 in _local_4["GiftList"])
                {
                    _local_5[_local_6.Day] = _local_6;
                };
                _local_7 = 1;
                while (_local_7 <= 5)
                {
                    _local_6 = _local_5[_local_7];
                    _local_8 = new JPanel(new EmptyLayout());
                    AsWingUtil.SetSize(_local_8, 123, (166 + 19));
                    _local_1.append(_local_8);
                    _local_9 = new JPanel(new EmptyLayout());
                    AsWingUtil.SetBackgroundFromAsset(_local_9, this.GetBGCart(_local_7));
                    _local_8.append(_local_9);
                    _local_10 = AsWingUtil.CreateLabel(((ClientApplication.Localization.DAILY_GIFT_WINDOW_DAY + " ") + _local_7), 0xFFFFFF, _local_3);
                    AsWingUtil.SetSize(_local_10, 123, 20);
                    _local_10.setLocationXY(0, 5);
                    _local_8.append(_local_10);
                    _local_11 = ((_local_6.Amount + " ") + HtmlText.declination(_local_6.Amount, ClientApplication.Localization.MONETS_DECLINATION));
                    _local_12 = AsWingUtil.CreateLabel(_local_11, 0xFFFF00, _local_3);
                    AsWingUtil.SetSize(_local_12, 123, 20);
                    _local_12.setLocationXY(0, 145);
                    _local_8.append(_local_12);
                    if (_local_6.NameId == 2)
                    {
                        _local_13 = ClientApplication.Localization.BUY_DIALOG_GOLDS_DECLINATION;
                    }
                    else
                    {
                        _local_13 = ClientApplication.Localization.BUY_DIALOG_SILVERS_DECLINATION;
                    };
                    _local_14 = ((_local_6.Amount + " ") + HtmlText.declination(_local_6.Amount, _local_13));
                    if (_local_7 < this._day)
                    {
                        _local_9.transform.colorTransform = _local_2;
                        _local_15 = new JPanel(new EmptyLayout());
                        AsWingUtil.SetBackgroundFromAsset(_local_15, "DGW_Check");
                        _local_15.setLocationXY(80, 116);
                        _local_8.append(_local_15);
                        new CustomToolTip(_local_8, ClientApplication.Instance.GetPopupText(282), 300);
                    }
                    else
                    {
                        if (_local_7 > this._day)
                        {
                            _local_9.filters = [HtmlText.gray];
                            new CustomToolTip(_local_8, HtmlText.GetText(ClientApplication.Instance.GetPopupText(284), _local_14), 300);
                        };
                    };
                    if (_local_7 == this._day)
                    {
                        _local_16 = new JPanel(new EmptyLayout());
                        AsWingUtil.SetBackgroundFromAssetLocalization(_local_16, "DGW_CheckToday");
                        _local_16.setLocationXY(20, 166);
                        _local_8.append(_local_16);
                        new CustomToolTip(_local_8, HtmlText.GetText(ClientApplication.Instance.GetPopupText(283), _local_14), 300);
                    }
                    else
                    {
                        if (_local_7 == (this._day + 1))
                        {
                            _local_17 = new JPanel(new EmptyLayout());
                            AsWingUtil.SetBackgroundFromAssetLocalization(_local_17, "DGW_CheckTomorrow");
                            _local_17.setLocationXY(20, 166);
                            _local_8.append(_local_17);
                        };
                    };
                    _local_7++;
                };
            };
            return (_local_1);
        }

        private function GetBGCart(_arg_1:uint):String
        {
            if (_arg_1 < 4)
            {
                return ("DGW_CartSilver" + _arg_1);
            };
            switch (this._premium)
            {
                case 0:
                case 1:
                default:
                    if (_arg_1 == 4)
                    {
                        return ("DGW_CartSilver4");
                    };
                    return ("DGW_CartGoldSmall");
                case 2:
                    if (_arg_1 == 4)
                    {
                        return ("DGW_CartGoldSmall");
                    };
                    return ("DGW_CartGoldBig");
            };
            return (""); //dead code
        }

        private function OnClose(_arg_1:Event):void
        {
            CloseWithAnimation();
        }

        override protected function OnStageResize(_arg_1:Event=null):void
        {
            AsWingUtil.SetSize(this, ClientApplication.Instance.stage.stageWidth, ClientApplication.Instance.stage.stageHeight);
            _window.setLocationXY(((RenderSystem.Instance.ScreenWidth - _window.width) / 2), ((RenderSystem.Instance.ScreenHeight - _window.height) / 2));
        }

        override public function dispose():void
        {
            super.dispose();
            if (ClientApplication.gift2Counter == 0)
            {
                ClientApplication.Instance.OpenWitchWindow();
            };
        }


    }
}//package hbm.Game.GUI.Gifts

