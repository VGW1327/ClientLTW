


//hbm.Game.GUI.CharacterCreation.NewCharacterCreateWindow

package hbm.Game.GUI.CharacterCreation
{
    import flash.display.Sprite;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import hbm.Engine.Resource.SkillsResourceLibrary;
    import flash.display.DisplayObjectContainer;
    import org.aswing.JTextField;
    import flash.text.TextField;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.JPanel;
    import flash.display.MovieClip;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import hbm.Game.Utility.NameGenerator;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import hbm.Application.ClientApplication;
    import hbm.Application.ClientConfig;
    import flash.system.SecurityDomain;
    import flash.system.ApplicationDomain;
    import hbm.Engine.Resource.ResourceManager;
    import flash.text.TextFormat;
    import flash.events.TimerEvent;
    import hbm.Game.Utility.AsWingUtil;
    import flash.display.Bitmap;
    import org.aswing.AssetBackground;
    import flash.filters.ColorMatrixFilter;
    import org.aswing.AssetIcon;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.ButtonGroup;
    import hbm.Game.Utility.HtmlText;
    import flash.filters.GlowFilter;
    import flash.filters.BitmapFilterQuality;
    import hbm.Game.Character.CharacterStorage;
    import flash.net.URLRequest;
    import org.aswing.Component;
    import flash.display.BitmapData;
    import flash.text.TextFieldAutoSize;
    import flash.text.AntiAliasType;
    import flash.text.GridFitType;

    public class NewCharacterCreateWindow extends Sprite 
    {

        private static const AUTO_START_DELAY:uint = 1000;

        private const WIDTH:int = 803;
        private const HEIGHT:int = 769;

        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _localizationLibrary:LocalizationResourceLibrary;
        private var _skillsLibrary:SkillsResourceLibrary;
        private var _parent:DisplayObjectContainer;
        private var _nameTextField:JTextField;
        private var _msgTextLabel:TextField;
        private var _confirmButton:CustomButton;
        private var _generateButton:CustomButton;
        private var _leftJobPanel:JPanel;
        private var _bottomPanel:JPanel;
        private var _bigIconPanel:JPanel;
        private var _nameInputPanel:JPanel;
        private var _nameInputOkPanel:JPanel;
        private var _maleButton:JobRadioButton;
        private var _femaleButton:JobRadioButton;
        private var _humanButton:JobRadioButton;
        private var _orcButton:JobRadioButton;
        private var _undeadButton:JobRadioButton;
        private var _turonButton:JobRadioButton;
        private var _currentJobId:int = 0;
        private var _serverJobId:int = 0;
        private var _clothesColor:int = -1;
        private var _isMale:Boolean;
        private var _newCharacter:Boolean;
        private var _backPanel:Sprite;
        private var _cloudBack:MovieClip;
        private var _imageLoader:Loader;
        protected var _resourceContext:LoaderContext;
        private var _jobLinePopups:Array;
        private var _buttonPopups:Array;
        private var _jobButtonPopups:Array;
        private var _jobButtons:Dictionary;
        private var _activeCheckingName:Boolean = false;
        private var _timer:Timer;
        private var _lastCharacterName:String = "";
        private var _generator:NameGenerator;
        private var _activeGenerateName:Boolean = false;

        public function NewCharacterCreateWindow(_arg_1:DisplayObjectContainer, _arg_2:Boolean)
        {
            this._parent = _arg_1;
            this._newCharacter = _arg_2;
            x = 0;
            y = 0;
            this._imageLoader = new Loader();
            this._imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.ImageCompleteHandler);
            this._imageLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.HideBigIcon);
            var _local_3:ClientConfig = ClientApplication.Instance.Config;
            var _local_4:* = ((_local_3.CurrentPlatformId == ClientConfig.STANDALONE) ? SecurityDomain.currentDomain : null);
            this._resourceContext = new LoaderContext(true, ApplicationDomain.currentDomain, _local_4);
            this._generator = new NameGenerator();
            this.Init();
            addEventListener(Event.ADDED_TO_STAGE, this.OnAddedToStage);
        }

        private function Init():void
        {
            var _local_8:Array;
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._localizationLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            this._skillsLibrary = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
            var _local_1:TextFormat = new TextFormat();
            _local_1.size = 16;
            _local_1.color = 0xCCCCCC;
            this._nameTextField = new JTextField("", 24);
            this._nameTextField.setMaxChars(22);
            this._nameTextField.setSizeWH(180, 27);
            this._nameTextField.setBackgroundDecorator(null);
            this._nameTextField.getTextField().defaultTextFormat = _local_1;
            this._nameTextField.addEventListener(Event.CHANGE, this.OnStartTimer);
            this._timer = new Timer(AUTO_START_DELAY);
            this._timer.addEventListener(TimerEvent.TIMER, this.OnChangeText, false, 0, true);
            this._leftJobPanel = new JPanel();
            AsWingUtil.SetBackgroundFromAsset(this._leftJobPanel, "CharCreateLeftBar");
            this._bottomPanel = new JPanel();
            AsWingUtil.SetBackgroundFromAsset(this._bottomPanel, "CharCreateBottomBar");
            this._bigIconPanel = new JPanel();
            var _local_2:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharCreateNameField2");
            this._nameInputPanel = new JPanel();
            if (_local_2)
            {
                this._nameInputPanel.setBackgroundDecorator(new AssetBackground(_local_2));
                this._nameInputPanel.setSizeWH(_local_2.width, _local_2.height);
            };
            var _local_3:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharCreateNameFieldOk2");
            this._nameInputOkPanel = new JPanel();
            if (_local_3)
            {
                this._nameInputOkPanel.setBackgroundDecorator(new AssetBackground(_local_3));
                this._nameInputOkPanel.setSizeWH(_local_3.width, _local_3.height);
            };
            this._nameInputOkPanel.visible = false;
            var _local_4:Bitmap = this._localizationLibrary.GetBitmapAsset("Localization_Item_CharCreateButton2");
            var _local_5:Bitmap = this._localizationLibrary.GetBitmapAsset("Localization_Item_CharCreateButtonSelected2");
            var _local_6:Bitmap = this._localizationLibrary.GetBitmapAsset("Localization_Item_CharCreateButtonPressed2");
            var _local_7:Bitmap = this._dataLibrary.GetBitmapAsset("Localization_Item_CharCreateButton2");
            _local_8 = [0.33, 0.59, 0.11, 0, 0, 0.33, 0.59, 0.11, 0, 0, 0.33, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
            var _local_9:ColorMatrixFilter = new ColorMatrixFilter(_local_8);
            _local_7.filters = [_local_9];
            this._confirmButton = new CustomButton();
            this._confirmButton.setIcon(new AssetIcon(_local_4));
            this._confirmButton.setRollOverIcon(new AssetIcon(_local_5));
            this._confirmButton.setPressedIcon(new AssetIcon(_local_6));
            this._confirmButton.setDisabledIcon(new AssetIcon(_local_7));
            this._confirmButton.setSizeWH(_local_4.width, _local_4.height);
            this._confirmButton.setBackgroundDecorator(null);
            this._confirmButton.addActionListener(this.OnConfirmPressed);
            this._confirmButton.setEnabled(false);
            var _local_10:Bitmap = this._dataLibrary.GetBitmapAsset("Localization_Item_CharRandomButton2");
            var _local_11:Bitmap = this._dataLibrary.GetBitmapAsset("Localization_Item_CharRandomButtonSelected2");
            var _local_12:Bitmap = this._dataLibrary.GetBitmapAsset("Localization_Item_CharRandomButtonPressed2");
            this._generateButton = new CustomButton();
            this._generateButton.setIcon(new AssetIcon(_local_10));
            this._generateButton.setRollOverIcon(new AssetIcon(_local_11));
            this._generateButton.setPressedIcon(new AssetIcon(_local_12));
            this._generateButton.setSizeWH(_local_10.width, _local_10.height);
            this._generateButton.setBackgroundDecorator(null);
            this._generateButton.addActionListener(this.OnGeneratePressed);
            this._generateButton.setEnabled(false);
            this._buttonPopups = new Array();
            this._buttonPopups.push(new CustomToolTip(this._confirmButton, ClientApplication.Instance.GetPopupText(105), 200, 40));
            this._humanButton = new JobRadioButton();
            this._humanButton.addActionListener(this.OnHumanPressed);
            this._buttonPopups.push(new CustomToolTip(this._humanButton, ClientApplication.Instance.GetPopupText(223), 250, 68));
            this._orcButton = new JobRadioButton();
            this._orcButton.addActionListener(this.OnOrcPressed);
            this._buttonPopups.push(new CustomToolTip(this._orcButton, ClientApplication.Instance.GetPopupText(226), 250, 68));
            this._undeadButton = new JobRadioButton();
            this._undeadButton.addActionListener(this.OnUndeadPressed);
            this._buttonPopups.push(new CustomToolTip(this._undeadButton, ClientApplication.Instance.GetPopupText(224), 250, 68));
            this._turonButton = new JobRadioButton();
            this._turonButton.addActionListener(this.OnTuronPressed);
            this._buttonPopups.push(new CustomToolTip(this._turonButton, ClientApplication.Instance.GetPopupText(225), 250, 70));
            var _local_13:ButtonGroup = new ButtonGroup();
            _local_13.append(this._humanButton);
            _local_13.append(this._orcButton);
            _local_13.append(this._undeadButton);
            _local_13.append(this._turonButton);
            this._humanButton.setSelected(true);
            this._maleButton = new JobRadioButton();
            this._femaleButton = new JobRadioButton();
            var _local_14:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharCreateMaleButton2");
            var _local_15:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharCreateMaleButtonSelected2");
            var _local_16:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharCreateMaleButtonPressed2");
            this._maleButton.setIcon(new AssetIcon(_local_14));
            this._maleButton.setRollOverIcon(new AssetIcon(_local_15));
            this._maleButton.setSelectedIcon(new AssetIcon(_local_16));
            this._maleButton.setSizeWH(_local_14.width, _local_14.height);
            this._maleButton.addActionListener(this.OnMalePressed);
            var _local_17:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharCreateFermaleButton2");
            var _local_18:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharCreateFermaleButtonSelected2");
            var _local_19:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharCreateFermaleButtonPressed2");
            this._femaleButton.setIcon(new AssetIcon(_local_17));
            this._femaleButton.setRollOverIcon(new AssetIcon(_local_18));
            this._femaleButton.setSelectedIcon(new AssetIcon(_local_19));
            this._femaleButton.setSizeWH(_local_17.width, _local_17.height);
            this._femaleButton.addActionListener(this.OnFemalePressed);
            var _local_20:ButtonGroup = new ButtonGroup();
            _local_20.append(this._maleButton);
            _local_20.append(this._femaleButton);
            this._buttonPopups.push(new CustomToolTip(this._maleButton, ClientApplication.Instance.GetPopupText(229), 200, 40));
            this._buttonPopups.push(new CustomToolTip(this._femaleButton, ClientApplication.Instance.GetPopupText(230), 200, 40));
            var _local_21:TextFormat = new TextFormat();
            _local_21.size = 13;
            _local_21.font = HtmlText.fontName;
            _local_21.bold = true;
            this._msgTextLabel = this.CreateTextField("", 0xFF0000, _local_21, [HtmlText.glow]);
            var _local_22:GlowFilter = new GlowFilter(4526615, 0.6, 2, 2, 3, BitmapFilterQuality.LOW, true, false);
            var _local_23:GlowFilter = new GlowFilter(4526615, 0.8, 2, 2, 3, BitmapFilterQuality.LOW, false, false);
            if (this._backPanel == null)
            {
                this._backPanel = new Sprite();
            };
            this.RandomRaceJob();
            addChild(this._backPanel);
            addChild(this._bigIconPanel);
            addChild(this._bottomPanel);
            addChild(this._leftJobPanel);
            addChild(this._nameInputPanel);
            addChild(this._nameInputOkPanel);
            addChild(this._nameTextField);
            addChild(this._confirmButton);
            addChild(this._generateButton);
            addChild(this._msgTextLabel);
            addChild(this._maleButton);
            addChild(this._femaleButton);
            addChild(this._humanButton);
            addChild(this._orcButton);
            addChild(this._undeadButton);
            addChild(this._turonButton);
        }

        private function RepaintForFractionJob(_arg_1:int, _arg_2:int):void
        {
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
            this.RepaintBigIcon(_arg_1, _arg_2, this._isMale);
        }

        private function RepaintForJobGender(_arg_1:Boolean):void
        {
            var _local_3:Array;
            var _local_2:String = ((_arg_1) ? "Man" : "Woman");
            _local_3 = [0.33, 0.59, 0.11, 0, 0, 0.33, 0.59, 0.11, 0, 0, 0.33, 0.59, 0.11, 0, 0, 0, 0, 0, 1, 0];
            var _local_4:ColorMatrixFilter = new ColorMatrixFilter(_local_3);
            var _local_5:Bitmap = this._dataLibrary.GetBitmapAsset((("AdditionalData_Item_CharCreateHuman" + _local_2) + "Button2"));
            var _local_6:Bitmap = this._dataLibrary.GetBitmapAsset((("AdditionalData_Item_CharCreateHuman" + _local_2) + "ButtonSelected2"));
            var _local_7:Bitmap = this._dataLibrary.GetBitmapAsset((("AdditionalData_Item_CharCreateHuman" + _local_2) + "ButtonPressed2"));
            this._humanButton.setIcon(new AssetIcon(_local_5));
            this._humanButton.setRollOverIcon(new AssetIcon(_local_6));
            this._humanButton.setSelectedIcon(new AssetIcon(_local_7));
            this._humanButton.setSizeWH(_local_5.width, _local_5.height);
            var _local_8:Bitmap = this._dataLibrary.GetBitmapAsset((("AdditionalData_Item_CharCreateOrc" + _local_2) + "Button2"));
            var _local_9:Bitmap = this._dataLibrary.GetBitmapAsset((("AdditionalData_Item_CharCreateOrc" + _local_2) + "ButtonSelected2"));
            var _local_10:Bitmap = this._dataLibrary.GetBitmapAsset((("AdditionalData_Item_CharCreateOrc" + _local_2) + "ButtonPressed2"));
            this._orcButton.setIcon(new AssetIcon(_local_8));
            this._orcButton.setRollOverIcon(new AssetIcon(_local_9));
            this._orcButton.setSelectedIcon(new AssetIcon(_local_10));
            this._orcButton.setSizeWH(_local_8.width, _local_8.height);
            var _local_11:Bitmap = this._dataLibrary.GetBitmapAsset((("AdditionalData_Item_CharCreateUndead" + _local_2) + "Button2"));
            var _local_12:Bitmap = this._dataLibrary.GetBitmapAsset((("AdditionalData_Item_CharCreateUndead" + _local_2) + "ButtonSelected2"));
            var _local_13:Bitmap = this._dataLibrary.GetBitmapAsset((("AdditionalData_Item_CharCreateUndead" + _local_2) + "ButtonPressed2"));
            this._undeadButton.setIcon(new AssetIcon(_local_11));
            this._undeadButton.setRollOverIcon(new AssetIcon(_local_12));
            this._undeadButton.setSelectedIcon(new AssetIcon(_local_13));
            this._undeadButton.setSizeWH(_local_11.width, _local_11.height);
            var _local_14:Bitmap = this._dataLibrary.GetBitmapAsset((("AdditionalData_Item_CharCreateTuron" + _local_2) + "Button2"));
            var _local_15:Bitmap = this._dataLibrary.GetBitmapAsset((("AdditionalData_Item_CharCreateTuron" + _local_2) + "ButtonSelected2"));
            var _local_16:Bitmap = this._dataLibrary.GetBitmapAsset((("AdditionalData_Item_CharCreateTuron" + _local_2) + "ButtonPressed2"));
            this._turonButton.setIcon(new AssetIcon(_local_14));
            this._turonButton.setRollOverIcon(new AssetIcon(_local_15));
            this._turonButton.setSelectedIcon(new AssetIcon(_local_16));
            this._turonButton.setSizeWH(_local_14.width, _local_14.height);
            this.RepaintBigIcon(this._clothesColor, this._currentJobId, _arg_1);
            if (this._clothesColor < 0)
            {
                return;
            };
            this._isMale = _arg_1;
        }

        private function Repack():void
        {
            this.LocationFromCenter(this._leftJobPanel, -460, -105);
            this.LocationFromCenter(this._bottomPanel, 6, 220);
            this.LocationFromCenter(this._nameInputPanel, 300, -62);
            this.LocationFromCenter(this._nameInputOkPanel, 392, -80);
            this.LocationFromCenter(this._nameTextField, 282, -78);
            this.LocationFromCenter(this._generateButton, 300, -45);
            this.LocationFromCenter(this._confirmButton, 300, 30);
            this._msgTextLabel.x = (((this.WIDTH - this._msgTextLabel.width) / 2) - 15);
            this._msgTextLabel.y = (((this.HEIGHT - this._msgTextLabel.height) / 2) + 80);
            this.LocationFromCenter(this._maleButton, -480, -288);
            this.LocationFromCenter(this._femaleButton, -440, -288);
            this.LocationFromCenter(this._humanButton, -145, 238);
            this.LocationFromCenter(this._turonButton, -385, 238);
            this.LocationFromCenter(this._orcButton, 145, 238);
            this.LocationFromCenter(this._undeadButton, 385, 238);
        }

        private function CreateJobButton(_arg_1:int, _arg_2:int, _arg_3:ButtonGroup, _arg_4:int, _arg_5:int, _arg_6:Boolean=true, _arg_7:Boolean=true, _arg_8:Boolean=false):JobRadioButton
        {
            var _local_13:String;
            var _local_14:String;
            var _local_15:Object;
            var _local_16:int;
            if (this._dataLibrary == null)
            {
                return (null);
            };
            var _local_9:Bitmap = this._dataLibrary.GetBitmapAsset((((("AdditionalData_Item_CharIconSmall_" + _arg_5) + "_") + _arg_4) + "p"));
            var _local_10:Bitmap = this._dataLibrary.GetBitmapAsset(((("AdditionalData_Item_CharIconSmall_" + _arg_5) + "_") + _arg_4));
            var _local_11:Bitmap = this._dataLibrary.GetBitmapAsset((((("AdditionalData_Item_CharIconSmall_" + _arg_5) + "_") + _arg_4) + "s"));
            var _local_12:JobRadioButton = new JobRadioButton(_arg_4, _arg_5, _arg_6);
            if (_local_9 == null)
            {
                _local_9 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharIconSmall_0");
            };
            if (_local_10 == null)
            {
                _local_10 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharIconSmall_0s");
            };
            if (_local_11 == null)
            {
                _local_11 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_CharIconSmall_0p");
            };
            _local_12.setIcon(new AssetIcon(_local_9));
            if (_arg_7)
            {
                _local_12.setRollOverIcon(new AssetIcon(_local_10));
                _local_12.setSelectedIcon(new AssetIcon(_local_11));
                _local_12.addActionListener(this.OnJobButtonPressed);
            };
            _local_12.setSizeWH(_local_9.width, _local_9.height);
            _local_12.setLocationXY((_arg_1 + 4), (_arg_2 + 4));
            if (((_arg_3) && (_arg_7)))
            {
                _arg_3.append(_local_12);
            };
            if (_arg_8)
            {
                _local_12.setSelected(true);
            };
            if (this._jobButtonPopups)
            {
                _local_13 = ((_arg_7) ? CharacterStorage.Instance.GetJobName(_arg_4, _arg_5) : ClientApplication.Localization.UNDER_CONSTRUCTION_MESSAGE);
                _local_14 = (("<font color='#FFF36C'>" + _local_13) + "</font>");
                _local_15 = this._dataLibrary.GetJobSkills(_arg_5);
                _local_16 = 13;
                if (_local_15)
                {
                    if (_local_15.JobDescription)
                    {
                        _local_14 = (_local_14 + ("<br>" + _local_15.JobDescription));
                        _local_16 = (_local_16 + 30);
                    };
                };
                this._jobButtonPopups.push(new CustomToolTip(_local_12, _local_14, ((_arg_7) ? 250 : 100), _local_16));
            };
            if (this._jobButtons)
            {
                this._jobButtons[_arg_5] = _local_12;
            };
            return (_local_12);
        }

        private function OnJobButtonPressed(_arg_1:Event):void
        {
            var _local_2:JobRadioButton = (_arg_1.target as JobRadioButton);
            if (_local_2 == null)
            {
                return;
            };
            if (((this._currentJobId == _local_2.JobId) && (this._clothesColor == _local_2.Fraction)))
            {
                return;
            };
            this.RefreshCreatePanel(_local_2.CanCreate);
            if (_local_2.CanCreate)
            {
                this._nameTextField.requestFocus();
            };
            this.RepaintBigIcon(_local_2.Fraction, _local_2.JobId, this._isMale);
            this._currentJobId = _local_2.JobId;
            this._clothesColor = _local_2.Fraction;
        }

        private function RepaintLeftJobPanelForHuman(_arg_1:int):void
        {
            var _local_3:CustomToolTip;
            if (this._leftJobPanel == null)
            {
                return;
            };
            this._leftJobPanel.removeAll();
            if (this._jobButtonPopups)
            {
                for each (_local_3 in this._jobButtonPopups)
                {
                    _local_3.Dispose();
                    _local_3 = null;
                };
            };
            var _local_2:ButtonGroup = new ButtonGroup();
            this._jobButtonPopups = new Array();
            this._jobButtons = new Dictionary(true);
            this._leftJobPanel.append(this.CreateHeaderJobPanel("Mage", 0, 135));
            this._leftJobPanel.append(this.CreateJobButton(20, 150, _local_2, _arg_1, 2, true, true, true));
            this._leftJobPanel.append(this.CreateJobButton(20, 195, _local_2, _arg_1, 4));
            this._leftJobPanel.append(this.CreateHeaderJobPanel("Warrior", 0, 245));
            this._leftJobPanel.append(this.CreateJobButton(20, 260, _local_2, _arg_1, 1));
            this._leftJobPanel.append(this.CreateJobButton(20, 305, _local_2, _arg_1, 6));
            this._leftJobPanel.append(this.CreateJobButton(20, 350, _local_2, _arg_1, 5));
            this._leftJobPanel.append(this.CreateHeaderJobPanel("Ranger", 0, 405));
            this._leftJobPanel.append(this.CreateJobButton(20, 420, _local_2, _arg_1, 3));
        }

        private function RepaintLeftJobPanelForOrc(_arg_1:int):void
        {
            var _local_3:CustomToolTip;
            if (this._leftJobPanel == null)
            {
                return;
            };
            this._leftJobPanel.removeAll();
            if (this._jobButtonPopups)
            {
                for each (_local_3 in this._jobButtonPopups)
                {
                    _local_3.Dispose();
                    _local_3 = null;
                };
            };
            var _local_2:ButtonGroup = new ButtonGroup();
            this._jobButtonPopups = new Array();
            this._jobButtons = new Dictionary(true);
            this._leftJobPanel.append(this.CreateHeaderJobPanel("Orc", 0, 155));
            this._leftJobPanel.append(this.CreateJobButton(20, 193, _local_2, _arg_1, 4024, true, true, true));
        }

        private function RepaintBigIcon(_arg_1:int, _arg_2:int, _arg_3:Boolean):void
        {
            var _local_4:String = ClientApplication.Instance.Config.GetFileURLExt((((((("BigIcons/CharIconBig_" + _arg_2) + "_") + _arg_1) + "_") + ((_arg_3) ? 1 : 0)) + ".jxr"));
            this._imageLoader.load(new URLRequest(_local_4), this._resourceContext);
        }

        private function CreateHeaderJobPanel(_arg_1:String, _arg_2:int, _arg_3:int):JPanel
        {
            var _local_4:Bitmap = this._localizationLibrary.GetBitmapAsset((("Localization_Item_CharCreateHeader" + _arg_1) + "On2"));
            var _local_5:JPanel = new JPanel();
            if (_local_4)
            {
                _local_5.setBackgroundDecorator(new AssetBackground(_local_4));
                _local_5.setSizeWH(_local_4.width, _local_4.height);
                _local_5.setLocationXY(_arg_2, _arg_3);
            };
            return (_local_5);
        }

        private function RandomRaceJob():void
        {
            var _local_1:int = int((Math.random() * 4));
            switch (_local_1)
            {
                case 0:
                    this._clothesColor = 0;
                    this._currentJobId = Math.ceil((Math.random() * 6));
                    break;
                case 1:
                    this._clothesColor = 0;
                    this._currentJobId = 4024;
                    break;
                case 2:
                    this._clothesColor = 1;
                    this._currentJobId = Math.ceil((Math.random() * 6));
                    break;
                case 3:
                    this._clothesColor = 1;
                    this._currentJobId = 4024;
                    break;
            };
            var _local_2:int = int(Math.floor((Math.random() * 2)));
            this._isMale = ((_local_2) ? true : false);
            this.RepaintForJobGender(this._isMale);
            if (this._isMale)
            {
                this._maleButton.setSelected(true);
            }
            else
            {
                this._femaleButton.setSelected(true);
            };
            switch (_local_1)
            {
                case 0:
                    this.RepaintAll(0, this._currentJobId, "Human");
                    this.RepaintLeftJobPanelForHuman(0);
                    this._humanButton.setSelected(true);
                    break;
                case 1:
                    this.RepaintAll(0, this._currentJobId, "Orc");
                    this.RepaintLeftJobPanelForOrc(0);
                    this._orcButton.setSelected(true);
                    break;
                case 2:
                    this.RepaintAll(1, this._currentJobId, "Undead");
                    this.RepaintLeftJobPanelForHuman(1);
                    this._undeadButton.setSelected(true);
                    break;
                case 3:
                    this.RepaintAll(1, this._currentJobId, "Turon");
                    this.RepaintLeftJobPanelForOrc(1);
                    this._turonButton.setSelected(true);
                    break;
            };
            this._jobButtons[this._currentJobId].setSelected(true);
        }

        private function OnHumanPressed(_arg_1:Event):void
        {
            this.RepaintAll(0, 2, "Human");
            this.RepaintLeftJobPanelForHuman(0);
        }

        private function OnOrcPressed(_arg_1:Event):void
        {
            this.RepaintAll(0, 4024, "Orc");
            this.RepaintLeftJobPanelForOrc(0);
        }

        private function OnUndeadPressed(_arg_1:Event):void
        {
            this.RepaintAll(1, 2, "Undead");
            this.RepaintLeftJobPanelForHuman(1);
        }

        private function OnTuronPressed(_arg_1:Event):void
        {
            this.RepaintAll(1, 4024, "Turon");
            this.RepaintLeftJobPanelForOrc(1);
        }

        private function OnLightElfPressed(_arg_1:Event):void
        {
        }

        private function OnDarkElfPressed(_arg_1:Event):void
        {
        }

        private function RepaintAll(_arg_1:int, _arg_2:int, _arg_3:String):void
        {
            this.RepaintForFractionJob(_arg_1, _arg_2);
            this.RefreshCreatePanel(true);
            this._nameTextField.requestFocus();
            this._currentJobId = _arg_2;
            this._clothesColor = _arg_1;
        }

        private function OnMalePressed(_arg_1:Event):void
        {
            this.RepaintForJobGender(true);
        }

        private function OnFemalePressed(_arg_1:Event):void
        {
            this.RepaintForJobGender(false);
        }

        private function LocalCheckCharacterName(_arg_1:String):Boolean
        {
            var _local_2:RegExp;
            var _local_4:String;
            var _local_5:int;
            _local_2 = new RegExp(ClientApplication.Localization.PLAYER_NAME_PATTERN);
            var _local_3:Array = _arg_1.match(_local_2);
            if (_local_3 != null)
            {
                if (_local_3[0] === _arg_1)
                {
                    _local_4 = _arg_1.toLowerCase().replace(ClientApplication.Localization.CENSURE_PATTERN1, "_").replace(ClientApplication.Localization.CENSURE_PATTERN2, "_").replace(ClientApplication.Localization.CREATE_NAME_CENSURE_PATTERN, "_");
                    if (_local_4 != null)
                    {
                        _local_5 = _local_4.indexOf("_");
                        if (_local_5 >= 0)
                        {
                            this._msgTextLabel.text = ClientApplication.Localization.ERR_CHARACTER_NAME_INCORRECT;
                            return (false);
                        };
                    };
                    this._msgTextLabel.text = "";
                    return (true);
                };
            };
            this._msgTextLabel.text = ClientApplication.Localization.ERR_WRONG_CHARACTER_NAME;
            return (false);
        }

        private function OnConfirmPressed(_arg_1:Event):void
        {
            if (this.LocalCheckCharacterName(this._nameTextField.getText()))
            {
                this._lastCharacterName = this._nameTextField.getText();
                this._serverJobId = ((this._currentJobId == 4024) ? 7 : this._currentJobId);
                dispatchEvent(new CharacterCreateEvent(CharacterCreateEvent.ON_CHARACTER_CONFIRMED, this._lastCharacterName, this._isMale, this._serverJobId, this._clothesColor));
            };
        }

        private function OnGeneratePressed(_arg_1:Event):void
        {
            this.GenerateAndCheck();
        }

        private function LocationFromCenter(_arg_1:Component, _arg_2:int, _arg_3:int):void
        {
            _arg_1.setLocationXY((((this.WIDTH - _arg_1.width) / 2) + _arg_2), (((this.HEIGHT - _arg_1.height) / 2) + _arg_3));
        }

        public function Dispose():void
        {
            var _local_1:CustomToolTip;
            var _local_2:CustomToolTip;
            var _local_3:CustomToolTip;
            if (this._parent.contains(this))
            {
                this._parent.removeChild(this);
            };
            if (this._jobLinePopups)
            {
                for each (_local_1 in this._jobLinePopups)
                {
                    _local_1.Dispose();
                    _local_1 = null;
                };
            };
            if (this._buttonPopups)
            {
                for each (_local_2 in this._buttonPopups)
                {
                    _local_2.Dispose();
                    _local_2 = null;
                };
            };
            if (this._jobButtonPopups)
            {
                for each (_local_3 in this._jobButtonPopups)
                {
                    _local_3.Dispose();
                    _local_3 = null;
                };
            };
        }

        public function Show():void
        {
            this._parent.addChild(this);
            this.Repack();
            this._nameTextField.requestFocus();
        }

        public function GetName():String
        {
            return (this._lastCharacterName);
        }

        public function get JobId():int
        {
            return (this._currentJobId);
        }

        public function get IsMale():Boolean
        {
            return (this._isMale);
        }

        public function get IsActiveCheckingName():Boolean
        {
            return (this._activeCheckingName);
        }

        public function ActiveCheckingName(_arg_1:Boolean, _arg_2:Boolean):void
        {
            this._activeCheckingName = _arg_2;
            if (this._activeGenerateName)
            {
                if (_arg_1)
                {
                    this._activeGenerateName = false;
                    this._generateButton.setEnabled(true);
                    this._nameTextField.setText(this._lastCharacterName);
					
                }
                else
                {
                    this.GenerateAndCheck();
                };
                this._msgTextLabel.text = "";
            }
            else
            {
                this._msgTextLabel.text = ((_arg_1) ? "" : ClientApplication.Localization.ERR_CHARACTER_NAME_ALREADY_EXISTS);
            };
            this._nameInputOkPanel.visible = _arg_1;
            this._confirmButton.setEnabled(_arg_1);
        }

        public function get ServerJobId():int
        {
            return (this._serverJobId);
        }

        public function get ClothesColor():int
        {
            return (this._clothesColor);
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
                this.LocationFromCenter(this._bigIconPanel, -25, -130);
            };
        }

        private function HideBigIcon(_arg_1:Event):void
        {
            this._bigIconPanel.setBackgroundDecorator(null);
            this._bigIconPanel.setSizeWH(0, 0);
        }

        private function RefreshCreatePanel(_arg_1:Boolean):void
        {
            this._confirmButton.visible = _arg_1;
            this._nameInputPanel.visible = _arg_1;
            this._nameTextField.visible = _arg_1;
        }

        public function get newCharacter():Boolean
        {
            return (this._newCharacter);
        }

        public function set newCharacter(_arg_1:Boolean):void
        {
        }

        private function OnChangeText(_arg_1:Event):void
        {
            if (this._timer.running)
            {
                this._timer.stop();
            };
            var _local_2:String = this._nameTextField.getText();
            if (this.LocalCheckCharacterName(_local_2))
            {
                this._lastCharacterName = _local_2;
                this._activeCheckingName = true;
                dispatchEvent(new CharacterCreateEvent(CharacterCreateEvent.ON_CHARACTER_CHECK_NAME, this._lastCharacterName, true));
            };
        }

        private function OnStartTimer(_arg_1:Event):void
        {
            this._confirmButton.setEnabled(false);
            this._nameInputOkPanel.visible = false;
            this._msgTextLabel.text = "";
            this._timer.delay = AUTO_START_DELAY;
            this._timer.reset();
            this._timer.start();
        }

        private function CreateTextField(_arg_1:String, _arg_2:uint, _arg_3:TextFormat, _arg_4:Array=null):TextField
        {
            var _local_5:TextField = new TextField();
            _local_5.textColor = _arg_2;
            _local_5.defaultTextFormat = _arg_3;
            _local_5.autoSize = TextFieldAutoSize.CENTER;
            _local_5.antiAliasType = AntiAliasType.ADVANCED;
            _local_5.gridFitType = GridFitType.PIXEL;
            _local_5.sharpness = -400;
            _local_5.selectable = false;
            _local_5.filters = ((_arg_4) ? _arg_4 : [new GlowFilter(4526615, 0.8, 2, 2, 2, BitmapFilterQuality.LOW, false, false)]);
            _local_5.text = _arg_1;
            return (_local_5);
        }

        protected function OnAddedToStage(_arg_1:Event):void
        {
            if (this._generator)
            {
                this.GenerateAndCheck();
            };
        }

        private function GenerateAndCheck():void
        {
            this._lastCharacterName = this._generator.Generate(this._isMale);
            this._activeGenerateName = true;
            this._activeCheckingName = true;
            this._generateButton.setEnabled(false);
            dispatchEvent(new CharacterCreateEvent(CharacterCreateEvent.ON_CHARACTER_CHECK_NAME, this._lastCharacterName, true));
        }


    }
}//package hbm.Game.GUI.CharacterCreation

