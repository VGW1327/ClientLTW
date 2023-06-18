


//hbm.Game.GUI.CharacterCreation.CharacterListWindow

package hbm.Game.GUI.CharacterCreation
{
    import flash.display.Sprite;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import flash.display.DisplayObjectContainer;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.JPanel;
    import flash.display.MovieClip;
    import org.aswing.JLabel;
    import org.aswing.JScrollPane;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import hbm.Application.ClientApplication;
    import hbm.Application.ClientConfig;
    import flash.system.SecurityDomain;
    import flash.system.ApplicationDomain;
    import flash.utils.Dictionary;
    import flash.display.Bitmap;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.AssetBackground;
    import org.aswing.AssetIcon;
    import org.aswing.ASFont;
    import hbm.Game.Utility.HtmlText;
    import org.aswing.ASColor;
    import org.aswing.JScrollBar;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.GUI.Tools.ClientVersionWindow;
    import hbm.Application.ClientVersion;
    import hbm.Game.Character.Character;
    import org.aswing.Component;
    import flash.events.KeyboardEvent;
    import flash.net.URLRequest;
    import flash.display.BitmapData;

    public class CharacterListWindow extends Sprite 
    {

        private static const LIST_ELEMENT_HEIGHT:int = 55;
        private static const LIST_VIEWABLE_ELEMENTS:int = 9;

        private const MAX_SLOTS:int = 15;
        private const WIDTH:int = 803;
        private const HEIGHT:int = 769;

        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _localizationLibrary:LocalizationResourceLibrary;
        private var _parent:DisplayObjectContainer;
        private var _playButton:CustomButton;
        private var _leftPanel:JPanel;
        private var _serverLogoPanel:JPanel;
        private var _bigIconPanel:JPanel;
        private var _backPanel:Sprite;
        private var _cloudBack:MovieClip;
        private var _characters:Array;
        private var _currentSlotId:int;
        private var _characterName:JLabel;
        private var _characterList:JPanel;
        private var _characterListScrollPane:JScrollPane;
        private var _lastSelected:int = -1;
        private var _imageLoader:Loader;
        protected var _resourceContext:LoaderContext;

        public function CharacterListWindow(_arg_1:DisplayObjectContainer, _arg_2:Dictionary)
        {
            this._parent = _arg_1;
            x = 0;
            y = 0;
            this._imageLoader = new Loader();
            this._imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.ImageCompleteHandler);
            this._imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.ImageIoErrorHandler);
            var _local_3:ClientConfig = ClientApplication.Instance.Config;
            var _local_4:* = ((_local_3.CurrentPlatformId == ClientConfig.STANDALONE) ? SecurityDomain.currentDomain : null);
            this._resourceContext = new LoaderContext(true, ApplicationDomain.currentDomain, _local_4);
            this.Init(_arg_2);
        }

        private function Init(_arg_1:Dictionary):void
        {
            var _local_3:Bitmap;
            var _local_8:CharacterInfo;
            var _local_9:CharacterInfo;
            var _local_10:int;
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._localizationLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            var _local_2:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharListLeftPlate");
            this._leftPanel = new JPanel();
            if (_local_2)
            {
                this._leftPanel.setBackgroundDecorator(new AssetBackground(_local_2));
                this._leftPanel.setSizeWH(_local_2.width, _local_2.height);
            };
            switch (ClientApplication.gameServerId)
            {
                case 1:
                    _local_3 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharListPvELogo");
                    break;
                case 0:
                default:
                    _local_3 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharListPvPLogo");
            };
            this._serverLogoPanel = new JPanel();
            if (_local_3)
            {
                this._serverLogoPanel.setBackgroundDecorator(new AssetBackground(_local_3));
                this._serverLogoPanel.setSizeWH(_local_3.width, _local_3.height);
            };
            this._bigIconPanel = new JPanel();
            var _local_4:Bitmap = this._localizationLibrary.GetBitmapAsset("Localization_Item_CharListPlayButton");
            var _local_5:Bitmap = this._localizationLibrary.GetBitmapAsset("Localization_Item_CharListPlayButtonSelected");
            var _local_6:Bitmap = this._localizationLibrary.GetBitmapAsset("Localization_Item_CharListPlayButton");
            this._playButton = new CustomButton();
            this._playButton.setIcon(new AssetIcon(_local_4));
            this._playButton.setRollOverIcon(new AssetIcon(_local_5));
            this._playButton.setPressedIcon(new AssetIcon(_local_6));
            this._playButton.setSizeWH(_local_4.width, _local_4.height);
            this._playButton.setBackgroundDecorator(null);
            this._playButton.addActionListener(this.OnPlayPressed);
            var _local_7:uint = ClientApplication.Instance.LocalGameClient.NumCharactersSlots;
			trace("CharacterListWindow_local_7: " + _local_7);
            if (_local_7 > this.MAX_SLOTS)
            {
                _local_7 = this.MAX_SLOTS;
            };
            for each (_local_9 in _arg_1)
            {
                if (_local_9)
                {
                    _local_8 = _local_9;
                    break;
                };
            };
            this.RepaintForFractionJob(_local_8.clothesColor, _local_8.jobId, _local_8.sex);
            this._characterName = new JLabel(_local_8.name);
            this._characterName.setFont(new ASFont(HtmlText.fontName, 20, true));
            this._characterName.setTextFilters([HtmlText.glow]);
            this._characterName.setSizeWH(200, 20);
            this._characterName.setForeground(new ASColor(15190419));
            addChild(this._backPanel);
            addChild(this._leftPanel);
            addChild(this._serverLogoPanel);
            addChild(this._bigIconPanel);
            addChild(this._playButton);
            addChild(this._characterName);
            this.CreateList();
            this._characters = new Array();
            _local_10 = 0;
            while (_local_10 < _local_7)
            {
                this.AddSlot(_local_10, _arg_1[_local_10]);
                _local_10++;
            };
            if (_local_7 < this.MAX_SLOTS)
            {
                this.AddSlot(_local_7, null, false);
            };
        }

        private function CreateList():void
        {
            var _local_1:int = (LIST_ELEMENT_HEIGHT * LIST_VIEWABLE_ELEMENTS);
            this._characterListScrollPane = new JScrollPane();
            this._characterListScrollPane.setSizeWH(180, _local_1);
            this._characterListScrollPane.setHorizontalScrollBarPolicy(JScrollPane.SCROLLBAR_NEVER);
            var _local_2:JScrollBar = new JScrollBar();
            _local_2.setBackground(new ASColor(988700));
            _local_2.setMideground(new ASColor(1522507));
            this._characterListScrollPane.setVerticalScrollBar(_local_2);
            this._characterList = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            this._characterList.setPreferredHeight(_local_1);
            this._characterListScrollPane.append(this._characterList);
            addChild(this._characterListScrollPane);
        }

        private function CheckClientVersion():void
        {
            var _local_2:ClientVersionWindow;
            var _local_1:uint = uint(ClientVersion.CurrentVersion.split(".")[1]);
			trace("CheckClientVersion_local_1:" + _local_1);
            if (ClientApplication.Instance.LocalGameClient.ServerVersion > _local_1)
            {
                _local_2 = new ClientVersionWindow(stage);
                _local_2.show();
            };
        }

        private function OnPlayPressed(_arg_1:Event):void
        {
            this.ChooseCharacter();
        }

        private function RepaintForFractionJob(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:int = Character.GetFraction(_arg_2, _arg_1);
            if (this._backPanel == null)
            {
                this._backPanel = new Sprite();
            };
            if (this._cloudBack == null)
            {
                this._cloudBack = new CloudBack();
            };
            if (this._cloudBack)
            {
                if (!this._backPanel.contains(this._cloudBack))
                {
                    this._cloudBack.x = ((this.WIDTH - this._cloudBack.width) / 2);
                    this._cloudBack.y = 0;
                    this._backPanel.addChild(this._cloudBack);
                };
            };
            this.RepaintBigIcon(_arg_1, _arg_2, _arg_3);
        }

        private function AddSlot(_arg_1:int, _arg_2:CharacterInfo, _arg_3:Boolean=true):void
        {
            var _local_4:CharacterListItem = new CharacterListItem(_arg_1, _arg_2, _arg_3);
            _local_4.addEventListener(CharacterListEvent.ON_ACTION, this.OnAction, false, 0, true);
            _local_4.addEventListener(CharacterListEvent.ON_RENAME, this.OnRename, false, 0, true);
            this._characterList.append(_local_4);
            if ((_arg_1 + 1) >= LIST_VIEWABLE_ELEMENTS)
            {
                this._characterList.setPreferredHeight((LIST_ELEMENT_HEIGHT * (_arg_1 + 1)));
                this._characterListScrollPane.updateUI();
            };
            this._characters.push(_local_4);
            if (_arg_1 == 0)
            {
                _local_4.Pressed = true;
            };
        }

        private function OnAction(_arg_1:CharacterListEvent):void
        {
            var _local_2:CharacterListItem;
            this._currentSlotId = _arg_1.SlotId;
            if (_arg_1.JobId == -1)
            {
                this.ChooseCharacter();
                return;
            };
            for each (_local_2 in this._characters)
            {
                if (_local_2.SlotId != _arg_1.SlotId)
                {
                    _local_2.Pressed = false;
                }
                else
                {
                    if (this._lastSelected == _local_2.SlotId)
                    {
                        this.ChooseCharacter();
                    };
                    this._lastSelected = _local_2.SlotId;
                    this._characterName.setText(_local_2.CharacterName);
                    this.RepaintForFractionJob(_local_2.ClothesColor, _local_2.JobId, _local_2.Sex);
                };
            };
        }

        private function Repack():void
        {
            this.LocationFromCenter(this._leftPanel, -280, 0);
            this.LocationFromCenter(this._serverLogoPanel, -280, -275);
            this.LocationFromCenter(this._characterListScrollPane, -280, 20);
            this.LocationFromCenter(this._characterName, 0, 290);
            this.LocationFromCenter(this._playButton, 0, 325);
            this.CheckClientVersion();
            this._characterListScrollPane.doLayout();
        }

        private function LocationFromCenter(_arg_1:Component, _arg_2:int, _arg_3:int):void
        {
            _arg_1.setLocationXY((((this.WIDTH - _arg_1.width) / 2) + _arg_2), (((this.HEIGHT - _arg_1.height) / 2) + _arg_3));
        }

        public function Dispose():void
        {
            if (this._parent.contains(this))
            {
                this._parent.removeChild(this);
            };
        }

        public function Show():void
        {
            this._parent.addChild(this);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.OnEnterKeyPressed);
            this.Repack();
        }

        private function OnEnterKeyPressed(_arg_1:KeyboardEvent):void
        {
            var _local_2:int = 13;
            if (_arg_1.keyCode == _local_2)
            {
                this.ChooseCharacter();
            };
        }

        private function ChooseCharacter():void
        {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.OnEnterKeyPressed);
            dispatchEvent(new CharacterListEvent(CharacterListEvent.ON_ACTION, this._currentSlotId));
        }

        private function RepaintBigIcon(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
            var _local_4:String = ClientApplication.Instance.Config.GetFileURLExt((((((("BigIcons/CharIconBig_" + _arg_2) + "_") + _arg_1) + "_") + _arg_3) + ".jxr"));
            this._imageLoader.load(new URLRequest(_local_4), this._resourceContext);
        }

        private function ImageCompleteHandler(_arg_1:Event):void
        {
            var _local_2:BitmapData;
            _local_2 = _arg_1.target.content.bitmapData;
            var _local_3:Bitmap = new Bitmap(_local_2);
            if (_local_3)
            {
                this._bigIconPanel.setBackgroundDecorator(new AssetBackground(_local_3));
                this._bigIconPanel.setSizeWH(_local_3.width, _local_3.height);
                this.LocationFromCenter(this._bigIconPanel, 10, 50);
            };
        }

        private function ImageIoErrorHandler(_arg_1:Event):void
        {
            this._bigIconPanel.setBackgroundDecorator(null);
            this._bigIconPanel.setSizeWH(0, 0);
        }

        private function OnRename(_arg_1:CharacterListEvent):void
        {
            dispatchEvent(_arg_1);
        }


    }
}//package hbm.Game.GUI.CharacterCreation

