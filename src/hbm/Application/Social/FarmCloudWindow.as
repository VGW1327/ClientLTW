


//hbm.Application.Social.FarmCloudWindow

package hbm.Application.Social
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.JPanel;
    import flash.display.Loader;
    import org.aswing.JLabel;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Network.Events.FarmEvent;
    import org.aswing.BorderLayout;
    import org.aswing.EmptyLayout;
    import hbm.Game.Utility.AsWingUtil;
    import flash.geom.Rectangle;
    import org.aswing.ASFont;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.Utility.Payments;
    import hbm.Engine.Actors.ItemData;
    import org.aswing.JOptionPane;
    import hbm.Game.Statistic.StatisticManager;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.AttachIcon;
    import flash.events.Event;
    import hbm.Game.Utility.HtmlText;
    import hbm.Engine.Renderer.RenderSystem;
    import flash.net.URLRequest;

    public class FarmCloudWindow extends WindowPrototype 
    {

        private const WIDTH:int = 674;
        private const HEIGHT:int = 680;

        private var _customFarmList:Array = [];
        private var _curCustomIndex:uint;
        private var _curCustomBG:uint = 1;
        private var _leftArrow:CustomButton;
        private var _rightArrow:CustomButton;
        private var _fakeAvatar:JPanel;
        private var _avatar:Loader;
        private var _labelName:JLabel;
        private var _bgPanel:JPanel;
        private var _btnFarm:CustomButton;
        private var _costLabel:JLabel;
        private var _costIcon:JPanel;

        public function FarmCloudWindow(_arg_1:Object=null)
        {
            super(owner, ClientApplication.Localization.CUSTOM_FARM_WINDOW_HEADER, true, this.WIDTH, this.HEIGHT, true, true);
            if (_arg_1)
            {
                this.UpdateUser(_arg_1);
            };
            ClientApplication.Instance.LocalGameClient.addEventListener(FarmEvent.ON_UPDATE_CUSTOM_FARM, this.OnUpdateCustomFarm, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(FarmEvent.ON_UPDATE_CUSTOM_FARM_LIST, this.OnUpdateCustomFarmList, false, 0, true);
            ClientApplication.Instance.LocalGameClient.SendGetCustomFarmList();
        }

        private function OnUpdateCustomFarm(_arg_1:FarmEvent):void
        {
            this._curCustomBG = (_arg_1.Data as uint);
            var _local_2:uint = this._customFarmList.length;
            var _local_3:uint;
            while (_local_3 < _local_2)
            {
                if (this._customFarmList[_local_3][0] == this._curCustomBG)
                {
                    this._curCustomIndex = _local_3;
                    break;
                };
                _local_3++;
            };
            this.UpdateCustomFarm();
        }

        private function OnUpdateCustomFarmList(_arg_1:FarmEvent):void
        {
            ClientApplication.Instance.LocalGameClient.removeEventListener(FarmEvent.ON_UPDATE_CUSTOM_FARM_LIST, this.OnUpdateCustomFarmList);
            this._customFarmList = (_arg_1.Data as Array);
        }

        override protected function InitUI():void
        {
            super.InitUI();
            Body.setLayout(new BorderLayout());
            var _local_1:JPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetSize(_local_1, 650, 552);
            this._bgPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAsset(this._bgPanel, "FF_Background1");
            this._bgPanel.setLocationXY(23, 0);
            _local_1.append(this._bgPanel);
            this._fakeAvatar = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAsset(this._fakeAvatar, "FF_NoAvatarUser");
            this._fakeAvatar.setLocationXY(60, 66);
            _local_1.append(this._fakeAvatar);
            this._avatar = new Loader();
            this._avatar.x = 60;
            this._avatar.y = 66;
            this._avatar.scrollRect = new Rectangle(0, 0, 50, 50);
            _local_1.addChild(this._avatar);
            var _local_2:JPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAsset(_local_2, "FF_CharacterFrame");
            _local_2.setLocationXY(53, 60);
            _local_1.append(_local_2);
            this._labelName = AsWingUtil.CreateLabel("", 16500537, new ASFont(getFont().getName(), 10, false));
            this._labelName.setHorizontalAlignment(JLabel.CENTER);
            AsWingUtil.SetBackgroundFromAsset(this._labelName, "FF_BGName");
            this._labelName.setLocationXY(48, 128);
            _local_1.append(this._labelName);
            this._leftArrow = AsWingUtil.CreateCustomButtonFromAsset("NCS_Left", "NCS_LeftOver", "NCS_LeftPress");
            this._leftArrow.addActionListener(this.OnScrollLeft, 0, true);
            this._leftArrow.setLocationXY(0, 200);
            _local_1.append(this._leftArrow);
            this._rightArrow = AsWingUtil.CreateCustomButtonFromAsset("NCS_Right", "NCS_RightOver", "NCS_RightPress");
            this._rightArrow.addActionListener(this.OnScrollRight, 0, true);
            this._rightArrow.setLocationXY(612, 200);
            _local_1.append(this._rightArrow);
            this._btnFarm = AsWingUtil.CreateCustomButtonFromAssetLocalization("FF_StandViewButton", "FF_StandViewButtonOver", "FF_StandViewButtonPress");
            this._btnFarm.addActionListener(this.OnSetCustomFarm, 0, true);
            this._btnFarm.setLocationXY(240, 495);
            new CustomToolTip(this._btnFarm, ClientApplication.Instance.GetPopupText(268));
            _local_1.append(this._btnFarm);
            var _local_3:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            this._costLabel = AsWingUtil.CreateLabel("", 16500537, new ASFont(getFont().getName(), 14, false));
            _local_3.append(this._costLabel);
            this._costIcon = new JPanel(new BorderLayout());
            AsWingUtil.SetBackgroundFromAsset(this._costIcon, "FF_FarmIcon");
            _local_3.append(AsWingUtil.AlignCenter(this._costIcon));
            _local_3.setLocationXY(450, 492);
            AsWingUtil.SetSize(_local_3, 200, 40);
            _local_1.append(_local_3);
            Body.append(_local_1);
        }

        private function OnSetCustomFarm(e:Event):void
        {
            var curCustom:Array;
            var arr:Array;
            curCustom = this._customFarmList[this._curCustomIndex];
            if (curCustom[1] > 0)
            {
                if (Payments.TestAmountPay(ItemData.CASH, curCustom[1]))
                {
                    var resultDlgBuy:Function = function (_arg_1:int):void
                    {
                        if (_arg_1 == JOptionPane.YES)
                        {
                            StatisticManager.Instance.SendEvent(("UseGoldCloud_" + curCustom[0]));
                            ClientApplication.Instance.LocalGameClient.SendBuyCustomFarm(_curCustomIndex);
                        };
                    };
                    arr = ClientApplication.Localization.BUY_DIALOG_GOLDS_DECLINATION;
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.CUSTOM_FARM_WINDOW_BUY_TITLE, ((ClientApplication.Localization.CUSTOM_FARM_WINDOW_BUY_TEXT + Payments.GetTextAmountCoins(ItemData.CASH, curCustom[1])) + "?"), resultDlgBuy, null, false, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
                };
            }
            else
            {
                StatisticManager.Instance.SendEvent(("UseGoldCloud_" + curCustom[0]));
                ClientApplication.Instance.LocalGameClient.SendBuyCustomFarm(this._curCustomIndex);
            };
        }

        private function OnScrollLeft(_arg_1:Event):void
        {
            if (this._curCustomIndex == 0)
            {
                this._curCustomIndex = (this._customFarmList.length - 1);
            }
            else
            {
                this._curCustomIndex--;
            };
            this.UpdateCustomFarm();
        }

        private function OnScrollRight(_arg_1:Event):void
        {
            this._curCustomIndex++;
            if (this._curCustomIndex >= this._customFarmList.length)
            {
                this._curCustomIndex = 0;
            };
            this.UpdateCustomFarm();
        }

        private function UpdateCustomFarm():void
        {
            this._bgPanel.setBackgroundDecorator(null);
            var _local_1:Array = this._customFarmList[this._curCustomIndex];
            AsWingUtil.SetBackgroundFromAsset(this._bgPanel, ("FF_Background" + _local_1[0]));
            if (_local_1[0] == this._curCustomBG)
            {
                this._btnFarm.visible = (this._costLabel.visible = (this._costIcon.visible = false));
            }
            else
            {
                this._btnFarm.visible = (this._costLabel.visible = true);
                if (_local_1[1] > 0)
                {
                    this._costLabel.setText(_local_1[1]);
                    this._costIcon.visible = true;
                }
                else
                {
                    this._costLabel.setText(ClientApplication.Localization.CUSTOM_FARM_WINDOW_SHARA);
                    this._costIcon.visible = false;
                };
            };
        }

        private function EnableScroll(_arg_1:Boolean):void
        {
            if (_arg_1)
            {
                this._leftArrow.mouseEnabled = (this._rightArrow.mouseEnabled = true);
                this._leftArrow.filters = null;
                this._rightArrow.filters = null;
            }
            else
            {
                this._leftArrow.mouseEnabled = (this._rightArrow.mouseEnabled = false);
                this._leftArrow.filters = [HtmlText.gray];
                this._rightArrow.filters = [HtmlText.gray];
            };
        }

        override public function show():void
        {
            super.show();
            setLocationXY(((RenderSystem.Instance.ScreenWidth - width) / 2), ((RenderSystem.Instance.ScreenHeight - height) / 2));
        }

        public function UpdateUser(_arg_1:Object):void
        {
            if (_arg_1.avatar)
            {
                this._avatar.load(new URLRequest(unescape(_arg_1.avatar)));
            }
            else
            {
                this._avatar.unload();
            };
            var _local_2:String = ((_arg_1.displayName) ? _arg_1.displayName.replace(" ", "\n") : "???");
            this._labelName.setText(_local_2);
            pack();
        }


    }
}//package hbm.Application.Social

