


//hbm.Game.GUI.LevelUp.LevelUpWindow

package hbm.Game.GUI.LevelUp
{
    import hbm.Game.GUI.CashShopNew.WindowPrototype;
    import flash.display.Sprite;
    import hbm.Engine.Actors.ItemData;
    import org.aswing.JCheckBox;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import hbm.Application.ClientApplication;
    import hbm.Application.ClientConfig;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.GUI.PremiumPack.PremiumPackItem;
    import org.aswing.JLabel;
    import org.aswing.JPanel;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.EmptyLayout;
    import hbm.Game.Utility.AsWingUtil;
    import hbm.Game.Utility.HtmlText;
    import org.aswing.ASFont;
    import org.aswing.JButton;
    import org.aswing.SoftBoxLayout;
    import org.aswing.BorderLayout;
    import hbm.Game.GUI.CashShopNew.Assets;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class LevelUpWindow extends WindowPrototype 
    {

        private static const WIDTH:int = 606;
        private static const HEIGHT:int = 510;
        private static var _shapeLockScreen:Sprite;

        private var _item:ItemData;
        private var _count:int;
        private var _cBox:JCheckBox;
        private var _wallPost:Boolean = false;
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _localisationLib:LocalizationResourceLibrary;

        public function LevelUpWindow(_arg_1:int)
        {
            this._count = _arg_1;
            switch (ClientApplication.Instance.Config.CurrentPlatformId)
            {
                case ClientConfig.VKONTAKTE:
                case ClientConfig.VKONTAKTE_TEST:
                case ClientConfig.FOTOSTRANA:
                case ClientConfig.FOTOSTRANA_TEST:
                case ClientConfig.MAILRU:
                case ClientConfig.MAILRU_TEST:
                case ClientConfig.ODNOKLASSNIKI:
                case ClientConfig.ODNOKLASSNIKI_TEST:
                    this._wallPost = true;
                    break;
            };
            super(null, "Награда за новый уровень", false, WIDTH, HEIGHT, true);
            pack();
            setLocationXY(((ClientApplication.stageWidth / 2) - (_width / 2)), 140);
        }

        override protected function InitUI():void
        {
            var _local_2:CharacterInfo;
            var _local_8:ItemData;
            var _local_9:PremiumPackItem;
            var _local_10:JLabel;
            var _local_11:JPanel;
            var _local_12:String;
            super.InitUI();
            this.BuildTopMenu();
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._localisationLib = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            var _local_1:JPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetBorder(_local_1, 2);
            AsWingUtil.SetBackground(_local_1, this._localisationLib.GetBitmapAsset("Localization_Item_LevelUpWindowBackground"));
            _local_2 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_3:JLabel = AsWingUtil.CreateLabel(HtmlText.GetText("Поздравляем с получением %val1% уровня!", _local_2.baseLevel), 15253613, new ASFont(HtmlText.fontName, 18, true));
            AsWingUtil.SetSize(_local_3, 380, 25);
            _local_3.setLocationXY(95, 160);
            _local_3.setTextFilters([HtmlText.shadow]);
            _local_1.append(_local_3);
            var _local_4:JLabel = AsWingUtil.CreateLabel("Кто молодец?", 15253613, new ASFont(HtmlText.fontName, 18, true));
            AsWingUtil.SetSize(_local_4, 200, 25);
            _local_4.setLocationXY(193, 283);
            _local_4.setTextFilters([HtmlText.shadow]);
            _local_1.append(_local_4);
            this._item = new ItemData();
            this._item.NameId = 2;
            this._item.Amount = this._count;
            this._item.Identified = 1;
            this._item.Origin = ItemData.QUEST;
            var _local_5:PremiumPackItem = new PremiumPackItem(this._item, false, false);
            AsWingUtil.SetSize(_local_5, 64, 64);
            _local_5.setLocationXY(250, 205);
            _local_1.append(_local_5);
            var _local_6:JLabel = AsWingUtil.CreateLabel(HtmlText.GetText("x%val1%", this._count), 15253613, new ASFont(HtmlText.fontName, 18, true));
            AsWingUtil.SetSize(_local_6, 50, 25);
            _local_6.setLocationXY(264, 250);
            _local_6.setTextFilters([HtmlText.shadow]);
            _local_1.append(_local_6);
            var _local_7:JButton = AsWingUtil.CreateButton(this._localisationLib.GetBitmapAsset("Localization_Item_LevelUpButton"), this._localisationLib.GetBitmapAsset("Localization_Item_LevelUpButtonOver"), this._localisationLib.GetBitmapAsset("Localization_Item_LevelUpButtonPress"));
            _local_7.addActionListener(this.OnClose, 0, true);
            setDefaultButton(_local_7);
            _local_7.setLocationXY(190, 313);
            _local_1.append(_local_7);
            if (this._wallPost)
            {
                _local_8 = new ItemData();
                _local_8.NameId = 4;
                _local_8.Amount = 1;
                _local_8.Identified = 1;
                _local_8.Origin = ItemData.QUEST;
                _local_9 = new PremiumPackItem(_local_8, false, true);
                AsWingUtil.SetSize(_local_9, 32, 32);
                _local_9.setLocationXY(400, 355);
                _local_10 = AsWingUtil.CreateLabel("Рассказать друзьям   +1%", 0xDDDDDD, new ASFont(HtmlText.fontName, 14, true));
                AsWingUtil.SetSize(_local_10, 300, 20);
                _local_10.setLocationXY(135, 363);
                _local_10.setTextFilters([HtmlText.shadow]);
                this._cBox = new JCheckBox();
                AsWingUtil.SetSize(this._cBox, 32, 32);
                this._cBox.setLocationXY(155, 358);
                _local_11 = new JPanel(new SoftBoxLayout());
                switch (ClientApplication.Instance.Config.CurrentPlatformId)
                {
                    case ClientConfig.VKONTAKTE:
                    case ClientConfig.VKONTAKTE_TEST:
                        _local_12 = "LevelWindowVk";
                        break;
                    case ClientConfig.FOTOSTRANA:
                    case ClientConfig.FOTOSTRANA_TEST:
                        _local_12 = "LevelWindowFs";
                        break;
                    case ClientConfig.MAILRU:
                    case ClientConfig.MAILRU_TEST:
                        _local_12 = "LevelWindowMm";
                        break;
                    case ClientConfig.ODNOKLASSNIKI:
                    case ClientConfig.ODNOKLASSNIKI_TEST:
                        _local_12 = "LevelWindowOk";
                        break;
                };
                AsWingUtil.SetBackground(_local_11, this._dataLibrary.GetBitmapAsset(("AdditionalData_Item_" + _local_12)));
                _local_11.setLocationXY(120, 355);
                _local_1.append(_local_11);
                _local_1.append(_local_10);
                _local_1.append(_local_9);
                _local_1.append(this._cBox);
            };
            Bottom.removeAll();
            Body.setLayout(new BorderLayout());
            Body.append(_local_1, BorderLayout.CENTER);
        }

        private function BuildTopMenu():void
        {
            Top.setLayout(new BorderLayout());
            var _local_1:JPanel = new JPanel();
            AsWingUtil.SetBackground(_local_1, Assets.Ornament3());
            Top.append(_local_1, BorderLayout.PAGE_END);
        }

        private function OnClose(_arg_1:Event):void
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:String;
            var _local_5:CharacterInfo;
            var _local_6:Object;
            if (((this._wallPost) && (this._cBox.isSelected())))
            {
                ClientApplication.Instance.LocalGameClient.SendRemoteNPCClick("LvUpBonusReward");
                _local_3 = "";
                _local_5 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                if (ClientApplication.fromPortal == 0)
                {
                    _local_3 = ClientApplication.Instance.Config.GetAppGroupURL;
                };
                _local_6 = this._dataLibrary.GetWallLevelupData();
                if (_local_6 == null)
                {
                    this.dispose();
                    return;
                };
                switch (ClientApplication.Instance.Config.CurrentPlatformId)
                {
                    case ClientConfig.VKONTAKTE:
                    case ClientConfig.VKONTAKTE_TEST:
                        _local_4 = this.GetTextForLevel(_local_6[ClientConfig.VKONTAKTE]["image"], _local_5.baseLevel);
                        if (ClientApplication.fromPortal > 0)
                        {
                            _local_4 = ClientApplication.Instance.Config.GetFileURLExt((("Wall/" + _local_4) + ".jpg"));
                        };
                        break;
                    case ClientConfig.FOTOSTRANA:
                    case ClientConfig.FOTOSTRANA_TEST:
                        _local_4 = this.GetTextForLevel(_local_6[ClientConfig.FOTOSTRANA]["image"], _local_5.baseLevel);
                        _local_4 = ClientApplication.Instance.Config.GetFileURLExt(_local_4);
                        break;
                    case ClientConfig.MAILRU:
                    case ClientConfig.MAILRU_TEST:
                        _local_4 = this.GetTextForLevel(_local_6[ClientConfig.MAILRU]["image"], _local_5.baseLevel);
                        _local_4 = ClientApplication.Instance.Config.GetFileURLExt(_local_4);
                        break;
                    case ClientConfig.ODNOKLASSNIKI:
                    case ClientConfig.ODNOKLASSNIKI_TEST:
                        _local_4 = this.GetTextForLevel(_local_6[ClientConfig.ODNOKLASSNIKI]["image"], _local_5.baseLevel);
                        _local_4 = ClientApplication.Instance.Config.GetFileURLExt(_local_4);
                        break;
                };
                _local_2 = this.GetTextForLevel(_local_6["text"], _local_5.baseLevel);
                _local_2 = HtmlText.GetText(_local_2, _local_5.baseLevel);
                ClientApplication.Instance.WallPost(_local_2, _local_4, _local_3);
            };
            if (ClientApplication.openTutorialAfterLevelup >= 0)
            {
                ClientApplication.Instance.TopHUD.GetTutorialPanel().ShowTutorialWindow(ClientApplication.openTutorialAfterLevelup);
                ClientApplication.openTutorialAfterLevelup = -1;
            };
            this.dispose();
        }

        private function GetTextForLevel(_arg_1:Array, _arg_2:int):String
        {
            var _local_4:Object;
            var _local_3:* = "";
            if (((_arg_1) && (_arg_1.length > 0)))
            {
                for each (_local_4 in _arg_1)
                {
                    if (_local_4.minLevel < _arg_2)
                    {
                        _local_3 = _local_4.src;
                    };
                };
            };
            return (_local_3);
        }

        override public function show():void
        {
            if (!_shapeLockScreen)
            {
                _shapeLockScreen = new Sprite();
                _shapeLockScreen.graphics.beginFill(0, 0.75);
                _shapeLockScreen.graphics.drawRect(0, 0, 1, 1);
                _shapeLockScreen.graphics.endFill();
                _shapeLockScreen.addEventListener(MouseEvent.CLICK, this.OnClose, false, 0, true);
            };
            ClientApplication.Instance.stage.addEventListener(Event.RESIZE, this.OnStageResize, false, 0, true);
            this.OnStageResize();
            ClientApplication.Instance.addChild(_shapeLockScreen);
            super.show();
        }

        private function OnStageResize(_arg_1:Event=null):void
        {
            _shapeLockScreen.width = ClientApplication.Instance.stage.stageWidth;
            _shapeLockScreen.height = ClientApplication.Instance.stage.stageHeight;
        }

        override public function dispose():void
        {
            if (_shapeLockScreen.parent)
            {
                _shapeLockScreen.parent.removeChild(_shapeLockScreen);
            };
            ClientApplication.Instance.stage.removeEventListener(Event.RESIZE, this.OnStageResize);
            super.dispose();
        }


    }
}//package hbm.Game.GUI.LevelUp

