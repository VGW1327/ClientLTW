


//hbm.Game.GUI.Update.UpdateWindow

package hbm.Game.GUI.Update
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import org.aswing.JLabel;
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Application.ClientConfig;
    import hbm.Application.ClientApplication;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.BorderLayout;
    import org.aswing.ASFont;
    import org.aswing.EmptyLayout;
    import org.aswing.JScrollPane;
    import org.aswing.SoftBoxLayout;
    import org.aswing.JTextArea;
    import org.aswing.ASColor;
    import flash.events.MouseEvent;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import flash.events.Event;
    import hbm.Engine.Renderer.RenderSystem;

    public class UpdateWindow extends WindowPrototype 
    {

        private static const MAX_HEIGHT_LIST:int = 260;

        private const WIDTH:int = 674;
        private const HEIGHT:int = 660;

        private var _curUpdate:int;
        private var _updatesData:Array;
        private var _dateLabel:JLabel;
        private var _banner:JPanel;
        private var _listDescription:JPanel;
        private var _leftArrow:CustomButton;
        private var _rightArrow:CustomButton;
        private var _enablePost:Boolean = (ClientConfig.DisableWallPost.indexOf(ClientApplication.Instance.Config.CurrentPlatformId) < 0);
        private var _wallPanel:JPanel;
        private var _textWallPost:String;

        public function UpdateWindow()
        {
            super(owner, ClientApplication.Localization.UPDATE_WINDOW_TITLE, true, this.WIDTH, this.HEIGHT, true, true);
            this._updatesData = AsWingUtil.AdditionalData.GetUpdatesData();
            this._curUpdate = 0;
            this.Update();
        }

        override protected function InitUI():void
        {
            var _local_4:JPanel;
            var _local_5:String;
            var _local_6:CustomButton;
            super.InitUI();
            Body.setLayout(new BorderLayout());
            this._dateLabel = new JLabel();
            this._dateLabel.setFont(new ASFont(getFont().getName(), 16, true));
            AsWingUtil.SetWidth(this._dateLabel, 480);
            Top.append(this._dateLabel);
            var _local_1:JPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetSize(_local_1, (602 + 46), 528);
            var _local_2:JPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAsset(_local_2, "UW_Background");
            _local_2.setLocationXY(23, 0);
            _local_1.append(_local_2);
            this._banner = new JPanel(new EmptyLayout());
            this._banner.setLocationXY(62, 10);
            _local_1.append(this._banner);
            this._leftArrow = AsWingUtil.CreateCustomButtonFromAsset("NCS_Left", "NCS_LeftOver", "NCS_LeftPress");
            this._leftArrow.addActionListener(this.OnScrollLeft, 0, true);
            this._leftArrow.setLocationXY(0, 200);
            _local_1.append(this._leftArrow);
            this._rightArrow = AsWingUtil.CreateCustomButtonFromAsset("NCS_Right", "NCS_RightOver", "NCS_RightPress");
            this._rightArrow.addActionListener(this.OnScrollRight, 0, true);
            this._rightArrow.setLocationXY(612, 200);
            _local_1.append(this._rightArrow);
            this._listDescription = new JPanel(new BorderLayout());
            var _local_3:JScrollPane = new JScrollPane(this._listDescription);
            AsWingUtil.SetSize(_local_3, 560, MAX_HEIGHT_LIST);
            _local_3.setLocationXY(50, 200);
            _local_1.append(_local_3);
            if (this._enablePost)
            {
                this._wallPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 10, SoftBoxLayout.TOP));
                AsWingUtil.SetSize(this._wallPanel, 310, 50);
                this._wallPanel.setLocationXY(175, 465);
                _local_4 = new JPanel(new BorderLayout());
                switch (ClientApplication.Instance.Config.CurrentPlatformId)
                {
                    case ClientConfig.VKONTAKTE:
                    case ClientConfig.VKONTAKTE_TEST:
                        _local_5 = "LevelWindowVk";
                        break;
                    case ClientConfig.FOTOSTRANA:
                    case ClientConfig.FOTOSTRANA_TEST:
                        _local_5 = "LevelWindowFs";
                        break;
                    case ClientConfig.MAILRU:
                    case ClientConfig.MAILRU_TEST:
                        _local_5 = "LevelWindowMm";
                        break;
                    case ClientConfig.ODNOKLASSNIKI:
                    case ClientConfig.ODNOKLASSNIKI_TEST:
                        _local_5 = "LevelWindowOk";
                        break;
                };
                if (_local_5)
                {
                    AsWingUtil.SetBackgroundFromAsset(_local_4, _local_5);
                    this._wallPanel.append(AsWingUtil.OffsetBorder(_local_4, 0, 5));
                };
                _local_6 = AsWingUtil.CreateCustomButtonFromAssetLocalization("WallPostUpdateActive", "WallPostUpdateOver");
                this._wallPanel.append(_local_6);
                _local_6.addActionListener(this.OnSendToWall, 0, true);
                _local_1.append(this._wallPanel);
            };
            Body.append(_local_1);
            if (_closeWindowButton2)
            {
                _closeWindowButton2.removeFromContainer();
            };
        }

        private function CreateUpdateDescriptionList(_arg_1:Object):JPanel
        {
            var _local_5:String;
            var _local_6:JPanel;
            var _local_7:JLabel;
            var _local_8:JTextArea;
            var _local_9:JPanel;
            var _local_2:Array = ((_arg_1.list) || ([]));
            this._textWallPost = ((_arg_1.walltext) || (""));
            var _local_3:Object = _arg_1.action;
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, SoftBoxLayout.TOP));
            for each (_local_5 in _local_2)
            {
                _local_6 = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
                _local_4.append(_local_6);
                _local_7 = new JLabel();
                AsWingUtil.SetBackgroundFromAsset(_local_7, "UW_Marker");
                _local_6.append(AsWingUtil.OffsetBorder(_local_7, 0, 3));
                _local_8 = AsWingUtil.CreateTextArea("");
                _local_8.setForeground(new ASColor(16772788));
                _local_8.setHtmlText(_local_5);
                AsWingUtil.SetWidth(_local_8, 520);
                _local_6.append(_local_8);
                this._textWallPost = (this._textWallPost + ("\n" + _local_8.getText()));
            };
            if (((_local_3) && (_local_3.image)))
            {
                _local_9 = new JPanel(new BorderLayout());
                AsWingUtil.SetBackgroundFromAssetLocalization(_local_9, _local_3.image);
                _local_9.buttonMode = true;
                _local_9.addEventListener(MouseEvent.CLICK, this.OnActionOpen, false, 0, true);
                new CustomToolTip(_local_9, _local_3.description, 400);
                _local_4.append(AsWingUtil.AlignCenter(_local_9));
            };
            _local_4.pack();
            if (_local_4.getHeight() < MAX_HEIGHT_LIST)
            {
                AsWingUtil.SetSize(_local_4, 545, (MAX_HEIGHT_LIST - 1));
            }
            else
            {
                AsWingUtil.SetWidth(_local_4, 531);
            };
            return (_local_4);
        }

        private function OnActionOpen(_arg_1:Event):void
        {
            ClientApplication.Instance.SetAnaloguesId("23213");
            ClientApplication.Instance.OpenCashShop();
            dispose();
        }

        private function OnScrollLeft(_arg_1:Event):void
        {
            this._curUpdate = Math.max(0, (this._curUpdate - 1));
            this.Update();
        }

        private function OnScrollRight(_arg_1:Event):void
        {
            this._curUpdate = Math.min((this._updatesData.length - 1), (this._curUpdate + 1));
            this.Update();
        }

        private function UpdateArrows():void
        {
            if (this._curUpdate == 0)
            {
                this._leftArrow.alpha = 0;
                this._leftArrow.mouseEnabled = (this._leftArrow.buttonMode = false);
            }
            else
            {
                this._leftArrow.alpha = 1;
                this._leftArrow.mouseEnabled = (this._leftArrow.buttonMode = true);
            };
            if (this._curUpdate >= (this._updatesData.length - 1))
            {
                this._rightArrow.alpha = 0;
                this._rightArrow.mouseEnabled = (this._rightArrow.buttonMode = false);
            }
            else
            {
                this._rightArrow.alpha = 1;
                this._rightArrow.mouseEnabled = (this._rightArrow.buttonMode = true);
            };
        }

        private function Update():void
        {
            this.UpdateArrows();
            var _local_1:Object = this._updatesData[this._curUpdate];
            if (!_local_1)
            {
                return;
            };
            this._dateLabel.setText(_local_1.title);
            AsWingUtil.SetBackgroundFromAssetLocalization(this._banner, _local_1.banner);
            this._listDescription.removeAll();
            this._listDescription.append(this.CreateUpdateDescriptionList(_local_1));
            if (this._enablePost)
            {
                this._wallPanel.visible = (this._curUpdate == 0);
            };
        }

        private function OnSendToWall(_arg_1:Event):void
        {
            var _local_2:String;
            var _local_4:String;
            var _local_3:Object = AsWingUtil.AdditionalData.GetWallUpdatesData();
            if (_local_3 != null)
            {
                switch (ClientApplication.Instance.Config.CurrentPlatformId)
                {
                    case ClientConfig.VKONTAKTE:
                    case ClientConfig.VKONTAKTE_TEST:
                        _local_2 = _local_3[ClientConfig.VKONTAKTE]["image"];
                        if (ClientApplication.fromPortal > 0)
                        {
                            _local_2 = ClientApplication.Instance.Config.GetFileURLExt((("Wall/" + _local_2) + ".jpg"));
                        };
                        break;
                    case ClientConfig.FOTOSTRANA:
                    case ClientConfig.FOTOSTRANA_TEST:
                        _local_2 = _local_3[ClientConfig.FOTOSTRANA]["image"];
                        _local_2 = ClientApplication.Instance.Config.GetFileURLExt(_local_2);
                        break;
                    case ClientConfig.MAILRU:
                    case ClientConfig.MAILRU_TEST:
                        _local_2 = _local_3[ClientConfig.MAILRU]["image"];
                        _local_2 = ClientApplication.Instance.Config.GetFileURLExt(_local_2);
                        break;
                    case ClientConfig.ODNOKLASSNIKI:
                    case ClientConfig.ODNOKLASSNIKI_TEST:
                        _local_2 = _local_3[ClientConfig.ODNOKLASSNIKI]["image"];
                        _local_2 = ClientApplication.Instance.Config.GetFileURLExt(_local_2);
                        break;
                };
                _local_4 = "";
                if (ClientApplication.fromPortal == 0)
                {
                    _local_4 = ClientApplication.Instance.Config.GetAppGroupURL;
                };
                ClientApplication.Instance.WallPost(this._textWallPost, _local_2, _local_4);
            };
            dispose();
        }

        override public function show():void
        {
            super.show();
            setLocationXY(((RenderSystem.Instance.ScreenWidth - width) / 2), ((RenderSystem.Instance.ScreenHeight - height) / 2));
        }


    }
}//package hbm.Game.GUI.Update

