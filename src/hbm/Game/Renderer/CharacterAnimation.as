


//hbm.Game.Renderer.CharacterAnimation

package hbm.Game.Renderer
{
    import hbm.Engine.Renderer.RenderObject;
    import flash.geom.Point;
    import flash.filters.GlowFilter;
    import flash.filters.BitmapFilterQuality;
    import br.com.stimuli.loading.BulkLoader;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.utils.Dictionary;
    import flash.utils.Timer;
    import flash.display.BitmapData;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import flash.geom.Rectangle;
    import hbm.Application.ClientApplication;
    import hbm.Application.ClientConfig;
    import flash.system.SecurityDomain;
    import flash.system.ApplicationDomain;
    import flash.system.ImageDecodingPolicy;
    import hbm.Engine.Network.Events.ActorChangeStatusEvent;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.Bitmap;
    import hbm.Game.Character.Character;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.utils.ByteArray;
    import flash.display.BitmapDataChannel;
    import hbm.Engine.Renderer.RenderSystem;
    import flash.geom.ColorTransform;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Engine.Renderer.Camera;
    import hbm.Engine.Renderer.ColorMatrix;
    import flash.filters.ColorMatrixFilter;
    import hbm.Game.Character.Monsters.RabbitAnimation;
    import hbm.Engine.Renderer.Rabbitgedon;
    import flash.events.TimerEvent;

    public class CharacterAnimation extends RenderObject 
    {

        private static var _releaseTimerTimeout:int = 60000;
        private static const _shadowResourceName:String = "AdditionalData_Item_Shadow";
        private static const _auraResourceName:String = "AdditionalData_Item_Aura";
        private static const _mobPointerResourceName:String = "AdditionalData_Item_MobPointer";
        private static const _friendPointerResourceName:String = "AdditionalData_Item_FriendPointer";
        private static const _zeroPoint:Point = new Point(0, 0);
        private static const _correctionPoint:Point = new Point(5, 5);
        private static var _enemyGlowFilter:GlowFilter = new GlowFilter(0xFF0000, 0.9, 8, 8, 2, BitmapFilterQuality.LOW);
        private static var _friendGlowFilter:GlowFilter = new GlowFilter(0xFF00, 0.9, 8, 8, 2, BitmapFilterQuality.LOW);
        private static var _refineGlowFilter:GlowFilter = new GlowFilter(0xCC0000, 0.3, 8, 8, 5, BitmapFilterQuality.LOW);

        private const _maxHideTimer:Number = 0.3;
        private const _maxUnhideTimer:Number = 0.2;

        private var _loader:BulkLoader = null;
        private var _leftHandDrawOrder:Boolean = false;
        private var _internalLoader:Loader;
        private var _refObjectCounter:int = 0;
        private var _newImageFormatCounter:uint = 0;
        private var _isNewGraphicsType:Boolean = false;
        private var _loaderContext:LoaderContext = null;
        private var _newImageFormatLoaderContext:LoaderContext;
        private var _bitmapLoaderData:Array = new Array();
        private var _baseAnimation:CharacterAnimation = null;
        private var _textureNameList:Array = null;
        private var _textureAlphaNameList:Array = null;
        private var _textureBitmapDataList:Array = null;
        private var _animationStateList:Dictionary = null;
        private var _currentAnimationState:CharacterAnimationState = null;
        private var _currentAnimationStateLH:CharacterAnimationState = null;
        private var _currentAnimationStateRH:CharacterAnimationState = null;
        private var _releaseTimer:Timer = null;
        private var _isSwfLoaded:Boolean = false;
        private var _shadowBitmapData:BitmapData = null;
        private var _option:Dictionary = null;
        private var _option2:Dictionary = null;
        private var _optionBitmaps:Dictionary = null;
        private var _option2Bitmaps:Dictionary = null;
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _mobPointerBitmapData:BitmapData = null;
        private var _friendPointerBitmapData:BitmapData = null;
        private var _lastDrawRect:Rectangle = null;
        private var _isLocalOrGuildPlayer:Boolean = false;
        private var _leftHandRefineLevel:int;
        private var _rightHandRefineLevel:int;
        private var _characterName:String = null;
        private var _isDataLoaded:Boolean = false;
        private var _isDataLoadingStarted:Boolean = false;
        private var _drawUnknownCharacter:*;
        private var _clonedDataStorage:Array = null;
        private var _topLeftDrawPosition:Point;
        private var _topLeftShadowPosition:Point;
        private var _isHided:Boolean = false;
        private var _isInvisible:Boolean = false;
        private var _hideTimer:Number = 0;
        private var _unhideTimer:Number = 0.2;
        private var _shining:Number = 0;
        private var _shiningSideUp:Boolean = true;
        private var _alpha:Number = 1;
        private var _drawShadow:Boolean = true;
        private var _characterLevel:int = 0;
        private var _needDraw:Boolean = true;
        private var _isSelected:Boolean = false;
        private var _characterType:int;
        private var _characterHairColor:int;
        private var _characterGender:int;
        private var _brightness:Number;
        private var _contrast:Number;
        private var _saturation:Number;
        private var _hue:Number;

        public function CharacterAnimation()
        {
            this._characterName = "Unknown";
            this._lastDrawRect = new Rectangle();
            this._textureNameList = new Array();
            this._textureAlphaNameList = new Array();
            this._textureBitmapDataList = new Array();
            this._animationStateList = new Dictionary(true);
            this._clonedDataStorage = new Array();
            this._topLeftDrawPosition = new Point(0, 0);
            this._topLeftShadowPosition = new Point(0, 0);
            this._drawUnknownCharacter = null;
            this._internalLoader = new Loader();
            var _local_1:ClientConfig = ClientApplication.Instance.Config;
            var _local_2:* = ((_local_1.CurrentPlatformId == ClientConfig.STANDALONE) ? SecurityDomain.currentDomain : null);
            this._newImageFormatLoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, _local_2);
            this._newImageFormatLoaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
            this._optionBitmaps = new Dictionary(true);
            this._option = new Dictionary(true);
            this._option[ActorChangeStatusEvent.OPTION1_STONE] = false;
            this._option[ActorChangeStatusEvent.OPTION1_FREEZE] = false;
            this._option[ActorChangeStatusEvent.OPTION1_SLEEP] = false;
            this._option2Bitmaps = new Dictionary(true);
            this._option2 = new Dictionary(true);
            this._option2[ActorChangeStatusEvent.OPT2_SILENCE] = false;
            this._option2[ActorChangeStatusEvent.OPT2_POISON] = false;
            this._option2[ActorChangeStatusEvent.OPT2_CURSE] = false;
            this._option2[ActorChangeStatusEvent.OPT2_DEATHFEAR] = false;
            this._option2[ActorChangeStatusEvent.OPT2_ROCKSKIN] = false;
            this._option2[ActorChangeStatusEvent.OPT2_RAGETUDRAH] = false;
            this._option2[ActorChangeStatusEvent.OPT2_FLAG] = false;
            this._option2[ActorChangeStatusEvent.OPT2_FLAG2] = false;
            this._option2[ActorChangeStatusEvent.OPT2_FLAG3] = false;
            this._option2[ActorChangeStatusEvent.OPT2_FLAG4] = false;
            this._option2[ActorChangeStatusEvent.OPT2_FLAG5] = false;
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
        }

        public static function get ReleaseTimerTimeout():int
        {
            return (_releaseTimerTimeout);
        }

        public static function set ReleaseTimerTimeout(_arg_1:int):void
        {
            _releaseTimerTimeout = _arg_1;
        }


        public function SetOption(_arg_1:int, _arg_2:Boolean):void
        {
            this._option[_arg_1] = _arg_2;
        }

        public function GetOption(_arg_1:int):Boolean
        {
            return ((this._option[_arg_1]) || (false));
        }

        public function SetOption2(_arg_1:int, _arg_2:Boolean):void
        {
            this._option2[_arg_1] = _arg_2;
        }

        public function GetOption2(_arg_1:int):Boolean
        {
            return ((this._option2[_arg_1]) || (false));
        }

        public function set CharacterType(_arg_1:int):void
        {
            this._characterType = _arg_1;
        }

        public function set CharacterGender(_arg_1:int):void
        {
            this._characterGender = _arg_1;
        }

        public function set CharacterHairColor(_arg_1:int):void
        {
            this._characterHairColor = _arg_1;
        }

        public function get Selected():Boolean
        {
            return (this._isSelected);
        }

        public function set Selected(_arg_1:Boolean):void
        {
            this._isSelected = _arg_1;
        }

        public function StartHide(_arg_1:Boolean=false):void
        {
            this._isHided = true;
            this._hideTimer = ((_arg_1) ? 0 : this._maxHideTimer);
            this._unhideTimer = 0;
        }

        public function RemoveAllStatus():void
        {
            this._hideTimer = 0;
            this._isHided = false;
            this._unhideTimer = this._maxUnhideTimer;
        }

        public function set DrawShadow(_arg_1:Boolean):void
        {
            this._drawShadow = _arg_1;
        }

        public function set CharacterLevel(_arg_1:int):void
        {
            var _local_2:Bitmap;
            this._characterLevel = _arg_1;
            if (((this._characterLevel == 99) && (this._characterType == Character.CHARACTER_PLAYER)))
            {
                _local_2 = this._dataLibrary.GetBitmapAsset(_auraResourceName);
                if (_local_2 != null)
                {
                    this._shadowBitmapData = _local_2.bitmapData.clone();
                };
            };
        }

        public function set NeedDraw(_arg_1:Boolean):void
        {
            this._needDraw = _arg_1;
        }

        public function SetDrawUnknownCharacter(_arg_1:*):void
        {
            this._drawUnknownCharacter = _arg_1;
        }

        public function get CharacterName():String
        {
            return (this._characterName);
        }

        public function SetCharacterName(_arg_1:String):void
        {
            this._characterName = _arg_1;
        }

        protected function AddTexture(_arg_1:String, _arg_2:String):void
        {
            this._textureNameList.push(_arg_1);
            this._textureAlphaNameList.push(_arg_2);
        }

        protected function AddAnimationState(_arg_1:String, _arg_2:CharacterAnimationState):void
        {
            if (this._currentAnimationState == null)
            {
                this._currentAnimationState = _arg_2;
            };
            this._animationStateList[_arg_1] = _arg_2;
        }

        public function GetNumTextures():uint
        {
            return (this._textureNameList.length);
        }

        public function GetTexture(_arg_1:uint):BitmapData
        {
            if (((_arg_1 < 0) || (_arg_1 >= this._textureBitmapDataList.length)))
            {
                return (null);
            };
            return (this._textureBitmapDataList[_arg_1]);
        }

        public function GetTextureName(_arg_1:uint):String
        {
            if (((_arg_1 < 0) || (_arg_1 >= this._textureNameList.length)))
            {
                return (null);
            };
            return (this._textureNameList[_arg_1]);
        }

        public function GetTextureAlphaName(_arg_1:uint):String
        {
            if (((_arg_1 < 0) || (_arg_1 >= this._textureAlphaNameList.length)))
            {
                return (null);
            };
            return (this._textureAlphaNameList[_arg_1]);
        }

        public function get CurrentAnimationState():CharacterAnimationState
        {
            return (this._currentAnimationState);
        }

        public function set CurrentAnimationState(_arg_1:CharacterAnimationState):void
        {
            if (_arg_1 != null)
            {
                this._currentAnimationStateLH = null;
                this._currentAnimationStateRH = null;
                this._currentAnimationState = _arg_1;
            };
        }

        public function set CurrentAnimationStateLH(_arg_1:CharacterAnimationState):void
        {
            if (_arg_1 != null)
            {
                this._currentAnimationStateLH = _arg_1;
            };
        }

        public function set CurrentAnimationStateRH(_arg_1:CharacterAnimationState):void
        {
            if (_arg_1 != null)
            {
                this._currentAnimationStateRH = _arg_1;
            };
        }

        public function SetLeftHandDrawOrder(_arg_1:Boolean):void
        {
            this._leftHandDrawOrder = _arg_1;
        }

        public function SetCurrentAnimationState(_arg_1:String):void
        {
            this.CurrentAnimationState = this.GetAnimationFrameData(_arg_1);
        }

        public function SetCurrentAnimationStateLH(_arg_1:String):void
        {
            this._currentAnimationStateLH = this.GetAnimationFrameData(_arg_1);
        }

        public function SetCurrentAnimationStateRH(_arg_1:String):void
        {
            this._currentAnimationStateRH = this.GetAnimationFrameData(_arg_1);
        }

        public function GetAnimationFrameData(_arg_1:String):CharacterAnimationState
        {
            return (this._animationStateList[_arg_1]);
        }

        protected function StartLoadingInternal():void
        {
            if (this._isDataLoadingStarted)
            {
                return;
            };
            if (this._isSwfLoaded)
            {
                this._isDataLoadingStarted = true;
                this.OnLoaded(null);
                return;
            };
            var _local_1:String = ClientApplication.Instance.Config.GetFileURL(this._characterName);
            var _local_2:ClientConfig = ClientApplication.Instance.Config;
            if (_local_2.CurrentPlatformId == ClientConfig.STANDALONE)
            {
                this._loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
            }
            else
            {
                this._loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
            };
            this._loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
            var _local_3:URLRequest = new URLRequest(_local_1);
            this._internalLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.OnLoaded, false, 0, true);
            this._internalLoader.load(_local_3, this._loaderContext);
            this._isDataLoadingStarted = true;
        }

        public function StartLoading():void
        {
            if (this._isDataLoadingStarted)
            {
                return;
            };
            this._loader = BulkLoader.getLoader("main-site");
            this._loader.logLevel = BulkLoader.LOG_SILENT;
            var _local_1:ClientConfig = ClientApplication.Instance.Config;
            if (_local_1.CurrentPlatformId == ClientConfig.STANDALONE)
            {
                this._loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
            }
            else
            {
                this._loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
            };
            this._loaderContext.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
            this._loader.addEventListener(BulkLoader.COMPLETE, this.OnLoaded, false, 0, true);
            var _local_2:String = ClientApplication.Instance.Config.GetFileURL(this._characterName);
            this._loader.add(_local_2, {
                "context":this._loaderContext,
                "type":BulkLoader.TYPE_MOVIECLIP
            });
            this._loader.start();
            this._isDataLoadingStarted = true;
        }

        public function EnableNewImageFormat():void
        {
            this._isNewGraphicsType = true;
        }

        private function get IsNewImageFormat():Boolean
        {
            return (this._isNewGraphicsType);
        }

        protected function NewImageFormatLoaded(_arg_1:Event):void
        {
            var _local_2:uint = this._textureNameList.length;
            _arg_1.currentTarget.removeEventListener(Event.COMPLETE, this.NewImageFormatLoaded);
            if (++this._newImageFormatCounter == _local_2)
            {
                this.OnNewImageFormatFilesLoaded();
            };
        }

        private function OnNewImageFormatFilesLoaded():void
        {
            var _local_3:CharacterAnimation;
            var _local_4:Bitmap;
            var _local_1:uint = this._textureNameList.length;
            var _local_2:uint;
            while (_local_2 < _local_1)
            {
                _local_4 = Bitmap(this._bitmapLoaderData[_local_2].content);
                this._textureBitmapDataList[_local_2] = _local_4.bitmapData;
                this._bitmapLoaderData[_local_2].unload();
                _local_2++;
            };
            this._isSwfLoaded = true;
            this._isDataLoaded = true;
            for each (_local_3 in this._clonedDataStorage)
            {
                _local_3._textureBitmapDataList = this._textureBitmapDataList;
            };
            this._bitmapLoaderData = new Array();
            this._clonedDataStorage = new Array();
            ClientApplication.Instance.RevalidateGUI();
        }

        private function LoadAnimationDataFromLoader(_arg_1:Loader):void
        {
            var _local_2:Class;
            var _local_3:Object;
            var _local_4:Array;
            var _local_5:String;
            if ((((_arg_1) && (_arg_1.contentLoaderInfo.content)) && (_arg_1.contentLoaderInfo.content.hasOwnProperty("_animationDataClass"))))
            {
                _local_2 = (_arg_1.contentLoaderInfo.content as Object)._animationDataClass;
                if (_local_2)
                {
                    _local_3 = new (_local_2)();
                    for each (_local_4 in _local_3._textures)
                    {
                        this.AddTexture(_local_4[0], _local_4[1]);
                    };
                    for (_local_5 in _local_3._states)
                    {
                        this.AddAnimationState(_local_5, _local_3._states[_local_5]);
                    };
                };
            };
        }

        private function OnLoaded(_arg_1:Event):void
        {
            var _local_3:CharacterAnimation;
            var _local_4:Loader;
            var _local_5:String;
            var _local_6:Class;
            var _local_7:ByteArray;
            var _local_8:Bitmap;
            var _local_9:String;
            var _local_10:Class;
            var _local_11:Bitmap;
            var _local_12:BitmapData;
            var _local_13:BitmapData;
            var _local_14:String;
            this._newImageFormatCounter = 0;
            this._bitmapLoaderData = new Array();
            if ((((_arg_1) && (_arg_1.currentTarget)) && (_arg_1.currentTarget.hasOwnProperty("loader"))))
            {
                _local_4 = (_arg_1.currentTarget.loader as Loader);
                this.LoadAnimationDataFromLoader(_local_4);
            };
            var _local_2:uint;
            while (_local_2 < this._textureNameList.length)
            {
                _local_5 = this._textureNameList[_local_2];
                _local_6 = (this._loaderContext.applicationDomain.getDefinition(_local_5) as Class);
                if (this.IsNewImageFormat)
                {
                    _local_7 = (new (_local_6)() as ByteArray);
                    if (_local_7 != null)
                    {
                        this._bitmapLoaderData[_local_2] = new Loader();
                        this._bitmapLoaderData[_local_2].contentLoaderInfo.addEventListener(Event.COMPLETE, this.NewImageFormatLoaded);
                        this._bitmapLoaderData[_local_2].loadBytes(_local_7, this._newImageFormatLoaderContext);
                    };
                }
                else
                {
                    _local_8 = new (_local_6)();
                    if (_local_8 != null)
                    {
                        this._textureBitmapDataList[_local_2] = _local_8.bitmapData;
                    };
                };
                _local_2++;
            };
            if (!this.IsNewImageFormat)
            {
                _local_2 = 0;
                while (_local_2 < this._textureAlphaNameList.length)
                {
                    _local_9 = this._textureAlphaNameList[_local_2];
                    _local_10 = (this._loaderContext.applicationDomain.getDefinition(_local_9) as Class);
                    _local_11 = new (_local_10)();
                    if (_local_11 != null)
                    {
                        _local_12 = this._textureBitmapDataList[_local_2];
                        _local_13 = new BitmapData(_local_12.width, _local_12.height, true);
                        _local_13.copyPixels(_local_12, _local_12.rect, new Point(0, 0));
                        _local_13.copyChannel(_local_11.bitmapData, _local_11.bitmapData.rect, new Point(0, 0), BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
                        this._textureBitmapDataList[_local_2] = _local_13;
                    };
                    _local_2++;
                };
            };
            this._isSwfLoaded = true;
            this._isDataLoaded = true;
            for each (_local_3 in this._clonedDataStorage)
            {
                _local_3._textureBitmapDataList = this._textureBitmapDataList;
                for (_local_14 in this._animationStateList)
                {
                    _local_3._animationStateList[_local_14] = this._animationStateList[_local_14].Clone();
                };
            };
            this._clonedDataStorage = new Array();
            ClientApplication.Instance.RevalidateGUI();
        }

        public function Update(_arg_1:Number):void
        {
            var _local_2:int;
            if (this._currentAnimationState == null)
            {
                this._currentAnimationStateLH = null;
                this._currentAnimationStateRH = null;
                this._currentAnimationState = this._animationStateList[0];
                if (this._currentAnimationState == null)
                {
                    return;
                };
            };
            if (this._hideTimer > 0)
            {
                this._hideTimer = (this._hideTimer - _arg_1);
            };
            if (this._unhideTimer > 0)
            {
                this._unhideTimer = (this._unhideTimer - _arg_1);
            };
            if (this._hideTimer < 0)
            {
                this._hideTimer = 0;
            };
            if (this._unhideTimer < 0)
            {
                this._unhideTimer = 0;
            };
            this._currentAnimationState.Update(_arg_1);
            if (((!(this._currentAnimationStateLH == null)) || (!(this._currentAnimationStateRH == null))))
            {
                _local_2 = this._currentAnimationState.CurrentAnimationIndex;
                if (this._currentAnimationStateLH != null)
                {
                    this._currentAnimationStateLH.CurrentAnimationIndex = _local_2;
                };
                if (this._currentAnimationStateRH != null)
                {
                    this._currentAnimationStateRH.CurrentAnimationIndex = _local_2;
                };
                if (this._shiningSideUp)
                {
                    this._shining = (this._shining + _arg_1);
                    if (this._shining > 1)
                    {
                        this._shining = 1;
                        this._shiningSideUp = false;
                    };
                }
                else
                {
                    this._shining = (this._shining - _arg_1);
                    if (this._shining < 0)
                    {
                        this._shining = 0;
                        this._shiningSideUp = true;
                    };
                };
            };
        }

        public function Play(_arg_1:Boolean=true):void
        {
            if (this._currentAnimationState == null)
            {
                this._currentAnimationStateLH = null;
                this._currentAnimationStateRH = null;
                this._currentAnimationState = this._animationStateList[0];
                if (this._currentAnimationState == null)
                {
                    return;
                };
            };
            this.CurrentAnimationState.Play(_arg_1);
            if (this._currentAnimationStateLH != null)
            {
                this._currentAnimationStateLH.Play(_arg_1);
            };
            if (this._currentAnimationStateRH != null)
            {
                this._currentAnimationStateRH.Play(_arg_1);
            };
        }

        public function Stop():void
        {
            if (this._currentAnimationState == null)
            {
                this._currentAnimationStateLH = null;
                this._currentAnimationStateRH = null;
                this._currentAnimationState = this._animationStateList[0];
                if (this._currentAnimationState == null)
                {
                    return;
                };
            };
            this.CurrentAnimationState.Stop();
            if (this._currentAnimationStateLH != null)
            {
                this._currentAnimationStateLH.Stop();
            };
            if (this._currentAnimationStateRH != null)
            {
                this._currentAnimationStateRH.Stop();
            };
        }

        override public function get Priority():uint
        {
            return (RenderSystem.Instance.MainCamera.MaxHeight - Position.y);
        }

        public function SetAlpha(_arg_1:Number):void
        {
            this._alpha = _arg_1;
        }

        public function DrawFrame(_arg_1:BitmapData, _arg_2:String, _arg_3:int):void
        {
            var _local_6:uint;
            this._currentAnimationState = this._animationStateList[_arg_2];
            if (this._currentAnimationState == null)
            {
                return;
            };
            var _local_4:CharacterAnimationFrame = this._currentAnimationState.GetAnimationFrame(_arg_3);
            if (_local_4 == null)
            {
                return;
            };
            this._topLeftDrawPosition.x = (((_arg_1.width / 2) + _local_4.CenterOffset.x) - _local_4.HotSpot.x);
            this._topLeftDrawPosition.y = (((_arg_1.height / 2) + _local_4.CenterOffset.y) - _local_4.HotSpot.y);
            var _local_5:Rectangle = _local_4.TextureFrame.clone();
            _local_6 = _local_4.TextureIndex;
            var _local_7:BitmapData = this.GetTexture(_local_6);
            if (_local_7 == null)
            {
                return;
            };
            _arg_1.copyPixels(_local_7, _local_5, this._topLeftDrawPosition, _local_7, _local_5.topLeft, true);
        }

        private function UpdateRefineGlow(_arg_1:int):void
        {
            switch (_arg_1)
            {
                case 1:
                    _refineGlowFilter.alpha = 0.3;
                    _refineGlowFilter.color = 26316;
                    break;
                case 2:
                    _refineGlowFilter.alpha = 0.4;
                    _refineGlowFilter.color = 26316;
                    break;
                case 3:
                    _refineGlowFilter.alpha = 0.5;
                    _refineGlowFilter.color = 26316;
                    break;
                case 4:
                    _refineGlowFilter.alpha = 0.6;
                    _refineGlowFilter.color = 26316;
                    break;
                case 5:
                    _refineGlowFilter.alpha = 0.7;
                    _refineGlowFilter.color = 26316;
                    break;
                case 6:
                    _refineGlowFilter.alpha = 0.4;
                    _refineGlowFilter.color = 0xCC0000;
                    break;
                case 7:
                    _refineGlowFilter.alpha = 0.5;
                    _refineGlowFilter.color = 0xCC0000;
                    break;
                case 8:
                    _refineGlowFilter.alpha = 0.6;
                    _refineGlowFilter.color = 0xCC0000;
                    break;
                case 9:
                    _refineGlowFilter.alpha = 0.7;
                    _refineGlowFilter.color = 0xCC0000;
                    break;
                case 10:
                    _refineGlowFilter.alpha = 0.8;
                    _refineGlowFilter.color = 0xCC0000;
                    break;
                case 11:
                    _refineGlowFilter.alpha = 0.3;
                    _refineGlowFilter.color = 0xFF00F0;
                    break;
                case 12:
                    _refineGlowFilter.alpha = 0.4;
                    _refineGlowFilter.color = 0xFF00F0;
                    break;
                case 13:
                    _refineGlowFilter.alpha = 0.5;
                    _refineGlowFilter.color = 0xFF00F0;
                    break;
                case 14:
                    _refineGlowFilter.alpha = 0.6;
                    _refineGlowFilter.color = 0xFF00F0;
                    break;
                case 15:
                    _refineGlowFilter.alpha = 0.7;
                    _refineGlowFilter.color = 0xFF00F0;
                    break;
                case 16:
                    _refineGlowFilter.alpha = 0.4;
                    _refineGlowFilter.color = 0xFF9C00;
                    break;
                case 17:
                    _refineGlowFilter.alpha = 0.5;
                    _refineGlowFilter.color = 0xFF9C00;
                    break;
                case 18:
                    _refineGlowFilter.alpha = 0.6;
                    _refineGlowFilter.color = 0xFF9C00;
                    break;
                case 19:
                    _refineGlowFilter.alpha = 0.7;
                    _refineGlowFilter.color = 0xFF9C00;
                    break;
                case 20:
                    _refineGlowFilter.alpha = 0.8;
                    _refineGlowFilter.color = 0xFF9C00;
                    break;
                default:
                    _refineGlowFilter.alpha = 0.8;
                    _refineGlowFilter.color = 0xFFFFFF;
            };
            var _local_2:Number = (_refineGlowFilter.alpha / 2);
            _refineGlowFilter.alpha = (_local_2 + (this._shining * _local_2));
        }

        public function DrawWeaponAnimation(_arg_1:Camera, _arg_2:BitmapData, _arg_3:CharacterAnimationState, _arg_4:int):void
        {
            var _local_8:uint;
            var _local_11:Number;
            var _local_12:Number;
            var _local_13:Boolean;
            var _local_14:Boolean;
            var _local_15:Rectangle;
            var _local_16:BitmapData;
            var _local_17:BitmapData;
            var _local_18:Point;
            var _local_19:Rectangle;
            var _local_20:BitmapData;
            var _local_21:BitmapData;
            var _local_22:Point;
            var _local_23:ColorTransform;
            var _local_24:Rectangle;
            var _local_25:BitmapData;
            if (_arg_3 == null)
            {
                return;
            };
            var _local_5:CharacterAnimationFrame = _arg_3.CurrentAnimationFrame;
            if (_local_5 == null)
            {
                return;
            };
            var _local_6:Point = _arg_1.TopLeftPoint;
            this._topLeftDrawPosition.x = (Position.x - _local_6.x);
            this._topLeftDrawPosition.y = ((_arg_1.MaxHeight - Position.y) - _local_6.y);
            this._topLeftDrawPosition.x = (this._topLeftDrawPosition.x + (_local_5.CenterOffset.x - _local_5.HotSpot.x));
            this._topLeftDrawPosition.y = (this._topLeftDrawPosition.y - (_local_5.HotSpot.y - _local_5.CenterOffset.y));
            var _local_7:Rectangle = _local_5.TextureFrame.clone();
            _local_8 = _local_5.TextureIndex;
            var _local_9:BitmapData = this.GetTexture(_local_8);
            var _local_10:Boolean = this._needDraw;
            if (((this._topLeftDrawPosition.x > _arg_2.width) || ((this._topLeftDrawPosition.x + _local_7.width) <= 0)))
            {
                _local_10 = false;
            };
            if (((this._topLeftDrawPosition.y > _arg_2.height) || ((this._topLeftDrawPosition.y + _local_7.height) <= 0)))
            {
                _local_10 = false;
            };
            _local_10 = ((_local_10) && (!(this._isInvisible)));
            if (this._isHided)
            {
                _local_11 = (this._hideTimer / this._maxHideTimer);
                if (!this.IsLocalOrGuildPlayer)
                {
                    this._alpha = (1 * _local_11);
                }
                else
                {
                    this._alpha = (0.75 + (0.25 * _local_11));
                };
            }
            else
            {
                this._alpha = 1;
            };
            if (this._unhideTimer > 0)
            {
                _local_12 = (1 - (this._hideTimer / this._maxHideTimer));
                if (!this.IsLocalOrGuildPlayer)
                {
                    this._alpha = (1 * _local_12);
                }
                else
                {
                    this._alpha = (0.75 + (0.25 * _local_12));
                };
            };
            _local_10 = ((_local_10) && (this._alpha > 0.2));
            if (_local_9 != null)
            {
                if (_local_10)
                {
                    if (this._alpha == 1)
                    {
                        _local_13 = CharacterStorage.Instance.IsEnableObjectsGlow;
                        _local_14 = this.IsCollided(CharacterStorage.Instance.LastPointerPosition);
                        if (((_local_13) && (_local_14)))
                        {
                            _local_15 = new Rectangle(0, 0, (_local_7.width + 10), (_local_7.height + 10));
                            _local_16 = new BitmapData(_local_15.width, _local_15.height, true, 0);
                            _local_17 = new BitmapData(_local_15.width, _local_15.height, true, 0);
                            _local_17.copyPixels(_local_9, _local_7, _correctionPoint, _local_9, _local_7.topLeft, true);
                            if (((this._characterType == Character.CHARACTER_NPC) || (this.IsLocalOrGuildPlayer)))
                            {
                                _local_16.applyFilter(_local_17, _local_15, _zeroPoint, _friendGlowFilter);
                            }
                            else
                            {
                                _local_16.applyFilter(_local_17, _local_15, _zeroPoint, _enemyGlowFilter);
                            };
                            _local_18 = this._topLeftDrawPosition.clone();
                            _local_18.offset(-5, -5);
                            _arg_2.copyPixels(_local_16, _local_15, _local_18, _local_16, _zeroPoint, true);
                        }
                        else
                        {
                            if (_arg_4 > 0)
                            {
                                this.UpdateRefineGlow(_arg_4);
                                _local_19 = new Rectangle(0, 0, (_local_7.width + 10), (_local_7.height + 10));
                                _local_20 = new BitmapData(_local_19.width, _local_19.height, true, 0);
                                _local_21 = new BitmapData(_local_19.width, _local_19.height, true, 0);
                                _local_21.copyPixels(_local_9, _local_7, _correctionPoint, _local_9, _local_7.topLeft, true);
                                _local_20.applyFilter(_local_21, _local_19, _zeroPoint, _refineGlowFilter);
                                _local_22 = this._topLeftDrawPosition.clone();
                                _local_22.offset(-5, -5);
                                _arg_2.copyPixels(_local_20, _local_19, _local_22, _local_20, _zeroPoint, true);
                            }
                            else
                            {
                                _arg_2.copyPixels(_local_9, _local_7, this._topLeftDrawPosition, _local_9, _local_7.topLeft, true);
                            };
                        };
                    }
                    else
                    {
                        _local_23 = new ColorTransform(1, 1, 1, this._alpha);
                        _local_24 = new Rectangle(0, 0, _local_7.width, _local_7.height);
                        _local_25 = new BitmapData(_local_7.width, _local_7.height, true);
                        _local_25.copyPixels(_local_9, _local_7, new Point(0, 0));
                        _local_25.colorTransform(_local_24, _local_23);
                        _arg_2.copyPixels(_local_25, _local_24, this._topLeftDrawPosition, _local_25, _local_24.topLeft, true);
                    };
                };
            };
        }

        override public function Draw(_arg_1:Camera, _arg_2:BitmapData):void
        {
            var _local_6:uint;
            var _local_9:Bitmap;
            var _local_10:Bitmap;
            var _local_11:Bitmap;
            var _local_12:Number;
            var _local_13:Number;
            var _local_14:Boolean;
            var _local_15:Rectangle;
            var _local_16:BitmapData;
            var _local_17:Boolean;
            var _local_18:Boolean;
            var _local_19:ColorMatrix;
            var _local_20:ColorMatrixFilter;
            var _local_21:Rectangle;
            var _local_22:BitmapData;
            var _local_23:BitmapData;
            var _local_24:Point;
            var _local_25:ColorTransform;
            var _local_26:Rectangle;
            var _local_27:BitmapData;
            if (this._currentAnimationState == null)
            {
                return;
            };
            var _local_3:CharacterAnimationFrame = this._currentAnimationState.CurrentAnimationFrame;
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:Point = _arg_1.TopLeftPoint;
            this._topLeftDrawPosition.x = (Position.x - _local_4.x);
            this._topLeftDrawPosition.y = ((_arg_1.MaxHeight - Position.y) - _local_4.y);
            this._topLeftDrawPosition.x = (this._topLeftDrawPosition.x + (_local_3.CenterOffset.x - _local_3.HotSpot.x));
            this._topLeftDrawPosition.y = (this._topLeftDrawPosition.y - (_local_3.HotSpot.y - _local_3.CenterOffset.y));
            if ((this._baseAnimation is RabbitAnimation))
            {
                this._drawShadow = true;
                Rabbitgedon.UpdateCrazyRabbit(this, this._topLeftDrawPosition);
            };
            var _local_5:Rectangle = _local_3.TextureFrame.clone();
            _local_6 = _local_3.TextureIndex;
            var _local_7:BitmapData = this.GetTexture(_local_6);
            if (this._shadowBitmapData == null)
            {
                if (((this._characterLevel == 99) && (this._characterType == Character.CHARACTER_PLAYER)))
                {
                    _local_9 = this._dataLibrary.GetBitmapAsset(_auraResourceName);
                }
                else
                {
                    _local_9 = this._dataLibrary.GetBitmapAsset(_shadowResourceName);
                };
                if (_local_9 != null)
                {
                    this._shadowBitmapData = _local_9.bitmapData.clone();
                };
            };
            if (this._mobPointerBitmapData == null)
            {
                _local_10 = this._dataLibrary.GetBitmapAsset(_mobPointerResourceName);
                if (_local_10 != null)
                {
                    this._mobPointerBitmapData = _local_10.bitmapData.clone();
                };
            };
            if (this._friendPointerBitmapData == null)
            {
                _local_11 = this._dataLibrary.GetBitmapAsset(_friendPointerResourceName);
                if (_local_11 != null)
                {
                    this._friendPointerBitmapData = _local_11.bitmapData.clone();
                };
            };
            var _local_8:Boolean = this._needDraw;
            if (((this._topLeftDrawPosition.x > _arg_2.width) || ((this._topLeftDrawPosition.x + _local_5.width) <= 0)))
            {
                _local_8 = false;
            };
            if (((this._topLeftDrawPosition.y > _arg_2.height) || ((this._topLeftDrawPosition.y + _local_5.height) <= 0)))
            {
                _local_8 = false;
            };
            _local_8 = ((_local_8) && (!(this._isInvisible)));
            try
            {
                if (((((!(_local_7 == null)) && (!(this._shadowBitmapData == null))) && (_local_8)) && (this._drawShadow)))
                {
                    this._topLeftShadowPosition.x = ((Position.x - _local_4.x) - (this._shadowBitmapData.width / 2));
                    this._topLeftShadowPosition.y = ((((_arg_1.MaxHeight - Position.y) - _local_4.y) - (this._shadowBitmapData.height / 2)) + 4);
                    if (!this.IsHided)
                    {
                        _arg_2.copyPixels(this._shadowBitmapData, this._shadowBitmapData.rect, this._topLeftShadowPosition, this._shadowBitmapData, this._shadowBitmapData.rect.topLeft, true);
                    };
                };
            }
            catch(e:Error)
            {
            };
            if ((((((!(_local_7 == null)) && (!(this._mobPointerBitmapData == null))) && (!(this._friendPointerBitmapData == null))) && (_local_8)) && (this._isSelected)))
            {
                if (this._characterType != Character.CHARACTER_NPC)
                {
                    this._topLeftShadowPosition.x = ((Position.x - _local_4.x) - (this._mobPointerBitmapData.width / 2));
                    this._topLeftShadowPosition.y = ((((_arg_1.MaxHeight - Position.y) - _local_4.y) - (this._mobPointerBitmapData.height / 2)) - 3);
                    _arg_2.copyPixels(this._mobPointerBitmapData, this._mobPointerBitmapData.rect, this._topLeftShadowPosition, this._mobPointerBitmapData, this._mobPointerBitmapData.rect.topLeft, true);
                }
                else
                {
                    this._topLeftShadowPosition.x = ((Position.x - _local_4.x) - (this._friendPointerBitmapData.width / 2));
                    this._topLeftShadowPosition.y = ((((_arg_1.MaxHeight - Position.y) - _local_4.y) - (this._friendPointerBitmapData.height / 2)) - 3);
                    _arg_2.copyPixels(this._friendPointerBitmapData, this._friendPointerBitmapData.rect, this._topLeftShadowPosition, this._friendPointerBitmapData, this._friendPointerBitmapData.rect.topLeft, true);
                };
            };
            if (this._isHided)
            {
                _local_12 = (this._hideTimer / this._maxHideTimer);
                if (!this.IsLocalOrGuildPlayer)
                {
                    this._alpha = (1 * _local_12);
                }
                else
                {
                    this._alpha = (0.75 + (0.25 * _local_12));
                };
            }
            else
            {
                this._alpha = 1;
            };
            if (this._unhideTimer > 0)
            {
                _local_13 = (1 - (this._hideTimer / this._maxHideTimer));
                if (!this.IsLocalOrGuildPlayer)
                {
                    this._alpha = (1 * _local_13);
                }
                else
                {
                    this._alpha = (0.75 + (0.25 * _local_13));
                };
            };
            _local_8 = ((_local_8) && (this._alpha > 0.2));
            if (((_local_7 == null) && (_local_8)))
            {
                if (this._drawUnknownCharacter)
                {
                    this._drawUnknownCharacter(_arg_1, _arg_2, Position);
                };
            }
            else
            {
                if (_local_8)
                {
                    if (this._alpha == 1)
                    {
                        _local_14 = false;
                        if (((this._characterType == Character.CHARACTER_PLAYER) && (this._characterHairColor > 0)))
                        {
                            _local_14 = true;
                            _local_19 = new ColorMatrix();
                            if (this._characterGender == 1)
                            {
                                switch (this._characterHairColor)
                                {
                                    case 1:
                                        _local_19.adjustColor(-86, -50, -78, 36);
                                        break;
                                    case 2:
                                        _local_19.adjustColor(0, 0, 14, 43);
                                        break;
                                    case 3:
                                        _local_19.adjustColor(0, 0, 72, 3);
                                        break;
                                    case 4:
                                        _local_19.adjustColor(24, 24, -70, 100);
                                        break;
                                    case 5:
                                        _local_19.adjustColor(0, 21, 28, 100);
                                        break;
                                    case 6:
                                        _local_19.adjustColor(-48, -17, 52, 13);
                                        break;
                                    default:
                                        _local_14 = false;
                                };
                            }
                            else
                            {
                                switch (this._characterHairColor)
                                {
                                    case 1:
                                        _local_19.adjustColor(-60, -33, -74, 107);
                                        break;
                                    case 2:
                                        _local_19.adjustColor(0, 0, 14, 43);
                                        break;
                                    case 3:
                                        _local_19.adjustColor(0, 0, 50, 3);
                                        break;
                                    case 4:
                                        _local_19.adjustColor(38, 21, -70, 100);
                                        break;
                                    case 5:
                                        _local_19.adjustColor(9, 22, 28, 100);
                                        break;
                                    case 6:
                                        _local_19.adjustColor(-46, -46, 52, 32);
                                        break;
                                    default:
                                        _local_14 = false;
                                };
                            };
                        };
                        if (_local_14)
                        {
                            _local_20 = new ColorMatrixFilter(_local_19);
                            _local_15 = new Rectangle(0, 0, _local_5.width, _local_5.height);
                            _local_16 = new BitmapData(_local_5.width, _local_5.height, true, 0);
                            _local_16.applyFilter(_local_7, _local_5, _zeroPoint, _local_20);
                        };
                        _local_17 = CharacterStorage.Instance.IsEnableObjectsGlow;
                        _local_18 = this.IsCollided(CharacterStorage.Instance.LastPointerPosition);
                        if (((_local_17) && (_local_18)))
                        {
                            _local_21 = new Rectangle(0, 0, (_local_5.width + 10), (_local_5.height + 10));
                            _local_22 = new BitmapData(_local_21.width, _local_21.height, true, 0);
                            _local_23 = new BitmapData(_local_21.width, _local_21.height, true, 0);
                            if (!_local_14)
                            {
                                _local_23.copyPixels(_local_7, _local_5, _correctionPoint, _local_7, _local_5.topLeft, true);
                            }
                            else
                            {
                                _local_23.copyPixels(_local_16, _local_15, _correctionPoint, _local_16, _zeroPoint, true);
                            };
                            if (((this._characterType == Character.CHARACTER_NPC) || (this.IsLocalOrGuildPlayer)))
                            {
                                _local_22.applyFilter(_local_23, _local_21, _zeroPoint, _friendGlowFilter);
                            }
                            else
                            {
                                _local_22.applyFilter(_local_23, _local_21, _zeroPoint, _enemyGlowFilter);
                            };
                            _local_24 = this._topLeftDrawPosition.clone();
                            _local_24.offset(-5, -5);
                            _arg_2.copyPixels(_local_22, _local_21, _local_24, _local_22, _zeroPoint, true);
                        }
                        else
                        {
                            if (!_local_14)
                            {
                                _arg_2.copyPixels(_local_7, _local_5, this._topLeftDrawPosition, _local_7, _local_5.topLeft, true);
                            }
                            else
                            {
                                _arg_2.copyPixels(_local_16, _local_15, this._topLeftDrawPosition, _local_16, _zeroPoint, true);
                            };
                        };
                    }
                    else
                    {
                        _local_25 = new ColorTransform(1, 1, 1, this._alpha);
                        _local_26 = new Rectangle(0, 0, _local_5.width, _local_5.height);
                        _local_27 = new BitmapData(_local_5.width, _local_5.height, true);
                        _local_27.copyPixels(_local_7, _local_5, new Point(0, 0));
                        _local_27.colorTransform(_local_26, _local_25);
                        _arg_2.copyPixels(_local_27, _local_26, this._topLeftDrawPosition, _local_27, _local_26.topLeft, true);
                    };
                };
            };
            this._lastDrawRect.x = this._topLeftDrawPosition.x;
            this._lastDrawRect.y = this._topLeftDrawPosition.y;
            this._lastDrawRect.width = _local_5.width;
            this._lastDrawRect.height = _local_5.height;
            if (!this._leftHandDrawOrder)
            {
                if (this._currentAnimationStateLH != null)
                {
                    this.DrawWeaponAnimation(_arg_1, _arg_2, this._currentAnimationStateLH, this.LeftHandRefineLevel);
                };
                if (this._currentAnimationStateRH != null)
                {
                    this.DrawWeaponAnimation(_arg_1, _arg_2, this._currentAnimationStateRH, this.RightHandRefineLevel);
                };
            }
            else
            {
                if (this._currentAnimationStateRH != null)
                {
                    this.DrawWeaponAnimation(_arg_1, _arg_2, this._currentAnimationStateRH, this.RightHandRefineLevel);
                };
                if (this._currentAnimationStateLH != null)
                {
                    this.DrawWeaponAnimation(_arg_1, _arg_2, this._currentAnimationStateLH, this.LeftHandRefineLevel);
                };
            };
            if (((this.GetOption(ActorChangeStatusEvent.OPTION1_FREEZE)) && (!(this._isInvisible))))
            {
                this.DrawOption(_arg_2, _arg_1, ActorChangeStatusEvent.OPTION1_FREEZE);
            };
            if ((((this.GetOption(ActorChangeStatusEvent.OPTION1_STONE)) && (!(this._isHided))) && (!(this._isInvisible))))
            {
                this.DrawOption(_arg_2, _arg_1, ActorChangeStatusEvent.OPTION1_STONE);
            };
            if ((((this.GetOption(ActorChangeStatusEvent.OPTION1_SLEEP)) && (!(this._isHided))) && (!(this._isInvisible))))
            {
                this.DrawOption(_arg_2, _arg_1, ActorChangeStatusEvent.OPTION1_SLEEP);
            };
            if ((((this.GetOption2(ActorChangeStatusEvent.OPT2_POISON)) && (!(this._isHided))) && (!(this._isInvisible))))
            {
                this.DrawOption2(_arg_2, _arg_1, ActorChangeStatusEvent.OPT2_POISON);
            };
            if ((((this.GetOption2(ActorChangeStatusEvent.OPT2_SILENCE)) && (!(this._isHided))) && (!(this._isInvisible))))
            {
                this.DrawOption2(_arg_2, _arg_1, ActorChangeStatusEvent.OPT2_SILENCE);
            };
            if ((((this.GetOption2(ActorChangeStatusEvent.OPT2_CURSE)) && (!(this._isHided))) && (!(this._isInvisible))))
            {
                this.DrawOption2(_arg_2, _arg_1, ActorChangeStatusEvent.OPT2_CURSE);
            };
            if ((((this.GetOption2(3)) && (!(this._isHided))) && (!(this._isInvisible))))
            {
                this.DrawOption2(_arg_2, _arg_1, 3);
            };
            if ((((this.GetOption2(ActorChangeStatusEvent.OPT2_ROCKSKIN)) && (!(this._isHided))) && (!(this._isInvisible))))
            {
                this.DrawOption2(_arg_2, _arg_1, ActorChangeStatusEvent.OPT2_ROCKSKIN);
            };
            if ((((this.GetOption2(ActorChangeStatusEvent.OPT2_RAGETUDRAH)) && (!(this._isHided))) && (!(this._isInvisible))))
            {
                this.DrawOption2(_arg_2, _arg_1, ActorChangeStatusEvent.OPT2_RAGETUDRAH);
            };
            if ((((this.GetOption2(ActorChangeStatusEvent.OPT2_DEATHFEAR)) && (!(this._isHided))) && (!(this._isInvisible))))
            {
                this.DrawOption2(_arg_2, _arg_1, ActorChangeStatusEvent.OPT2_DEATHFEAR);
            };
            if (this.GetOption2(ActorChangeStatusEvent.OPT2_FLAG))
            {
                this.DrawOption2(_arg_2, _arg_1, ActorChangeStatusEvent.OPT2_FLAG);
            };
            if (this.GetOption2(ActorChangeStatusEvent.OPT2_FLAG2))
            {
                this.DrawOption2(_arg_2, _arg_1, ActorChangeStatusEvent.OPT2_FLAG2);
            };
            if (this.GetOption2(ActorChangeStatusEvent.OPT2_FLAG3))
            {
                this.DrawOption2(_arg_2, _arg_1, ActorChangeStatusEvent.OPT2_FLAG3);
            };
            if (this.GetOption2(ActorChangeStatusEvent.OPT2_FLAG4))
            {
                this.DrawOption2(_arg_2, _arg_1, ActorChangeStatusEvent.OPT2_FLAG4);
            };
            if (this.GetOption2(ActorChangeStatusEvent.OPT2_FLAG5))
            {
                this.DrawOption2(_arg_2, _arg_1, ActorChangeStatusEvent.OPT2_FLAG5);
            };
        }

        private function DrawOption(_arg_1:BitmapData, _arg_2:Camera, _arg_3:int):void
        {
            var _local_5:String;
            var _local_7:Bitmap;
            var _local_4:BitmapData = this._optionBitmaps[_arg_3];
            var _local_6:int;
            switch (_arg_3)
            {
                case ActorChangeStatusEvent.OPTION1_STONE:
                    _local_5 = "AdditionalData_Item_Rock";
                    _local_6 = 10;
                    break;
                case ActorChangeStatusEvent.OPTION1_FREEZE:
                    _local_5 = "AdditionalData_Item_Freeze";
                    _local_6 = 10;
                    break;
                case ActorChangeStatusEvent.OPTION1_SLEEP:
                    _local_5 = "AdditionalData_Item_Sleep";
                    _local_6 = -90;
                    break;
                default:
                    return;
            };
            if (_local_4 == null)
            {
                _local_7 = this._dataLibrary.GetBitmapAsset(_local_5);
                if (_local_7 != null)
                {
                    _local_4 = _local_7.bitmapData;
                };
            };
            if (_local_4 != null)
            {
                this._topLeftDrawPosition.x = ((Position.x - _arg_2.TopLeftPoint.x) - (_local_4.width / 2));
                this._topLeftDrawPosition.y = ((((_arg_2.MaxHeight - Position.y) - _arg_2.TopLeftPoint.y) - _local_4.height) + _local_6);
                _arg_1.copyPixels(_local_4, _local_4.rect, this._topLeftDrawPosition, _local_4, _local_4.rect.topLeft, true);
            };
        }

        private function DrawOption2(_arg_1:BitmapData, _arg_2:Camera, _arg_3:int):void
        {
            var _local_5:String;
            var _local_6:Bitmap;
            var _local_4:BitmapData = this._option2Bitmaps[_arg_3];
            switch (_arg_3)
            {
                case 3:
                    _local_5 = "AdditionalData_Item_Manner";
                    break;
                case ActorChangeStatusEvent.OPT2_POISON:
                    _local_5 = "AdditionalData_Item_Poison";
                    break;
                case ActorChangeStatusEvent.OPT2_CURSE:
                    _local_5 = "AdditionalData_Item_Curse";
                    break;
                case ActorChangeStatusEvent.OPT2_SILENCE:
                    _local_5 = "AdditionalData_Item_Silence";
                    break;
                case ActorChangeStatusEvent.OPT2_DEATHFEAR:
                    _local_5 = "AdditionalData_Item_DeathFear";
                    break;
                case ActorChangeStatusEvent.OPT2_ROCKSKIN:
                    _local_5 = "AdditionalData_Item_RockSkin";
                    break;
                case ActorChangeStatusEvent.OPT2_RAGETUDRAH:
                    _local_5 = "AdditionalData_Item_RageTudrah";
                    break;
                case ActorChangeStatusEvent.OPT2_FLAG:
                    _local_5 = "AdditionalData_Item_Flag";
                    break;
                case ActorChangeStatusEvent.OPT2_FLAG2:
                    _local_5 = "AdditionalData_Item_Flag2";
                    break;
                case ActorChangeStatusEvent.OPT2_FLAG3:
                    _local_5 = "AdditionalData_Item_Flag3";
                    break;
                case ActorChangeStatusEvent.OPT2_FLAG4:
                    _local_5 = "AdditionalData_Item_Flag4";
                    break;
                case ActorChangeStatusEvent.OPT2_FLAG5:
                    _local_5 = "AdditionalData_Item_Flag5";
                    break;
                default:
                    return;
            };
            if (_local_4 == null)
            {
                _local_6 = this._dataLibrary.GetBitmapAsset(_local_5);
                if (_local_6 != null)
                {
                    _local_4 = _local_6.bitmapData;
                };
            };
            if (_local_4 != null)
            {
                this._topLeftDrawPosition.x = ((Position.x - _arg_2.TopLeftPoint.x) - (_local_4.width / 2));
                this._topLeftDrawPosition.y = ((((_arg_2.MaxHeight - Position.y) - _arg_2.TopLeftPoint.y) - _local_4.height) - 90);
                _arg_1.copyPixels(_local_4, _local_4.rect, this._topLeftDrawPosition, _local_4, _local_4.rect.topLeft, true);
            };
        }

        public function InternalRelease(_arg_1:TimerEvent):void
        {
            var _local_2:BitmapData;
            var _local_3:BitmapData;
            if (this._refObjectCounter > 0)
            {
                return;
            };
            for each (_local_2 in this._textureBitmapDataList)
            {
                _local_2.dispose();
            };
            this._isDataLoaded = false;
            this._isDataLoadingStarted = false;
            this._textureBitmapDataList = new Array();
            for each (_local_3 in this._optionBitmaps)
            {
                _local_3.dispose();
            };
            this._optionBitmaps = new Dictionary(true);
            for each (_local_3 in this._option2Bitmaps)
            {
                _local_3.dispose();
            };
            this._option2Bitmaps = new Dictionary(true);
            if (this._shadowBitmapData != null)
            {
                this._shadowBitmapData.dispose();
                this._shadowBitmapData = null;
            };
            if (this._mobPointerBitmapData != null)
            {
                this._mobPointerBitmapData.dispose();
            };
            if (this._friendPointerBitmapData != null)
            {
                this._friendPointerBitmapData.dispose();
            };
        }

        public function Release():void
        {
            this._baseAnimation._refObjectCounter--;
            if (this._baseAnimation._refObjectCounter > 0)
            {
                return;
            };
            if (this.CharacterName == "Cat")
            {
                return;
            };
            this._baseAnimation._releaseTimer.reset();
            this._baseAnimation._releaseTimer.delay = _releaseTimerTimeout;
            this._baseAnimation._releaseTimer.start();
            this._baseAnimation = null;
            this._textureBitmapDataList = new Array();
        }

        public function Clone():CharacterAnimation
        {
            var _local_2:String;
            var _local_1:CharacterAnimation = new CharacterAnimation();
            if (this._releaseTimer == null)
            {
                this._releaseTimer = new Timer(_releaseTimerTimeout, 1);
                this._releaseTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.InternalRelease);
            };
            if (!this._isDataLoadingStarted)
            {
                this.StartLoadingInternal();
            };
            if (!this._isDataLoaded)
            {
                this._clonedDataStorage.push(_local_1);
            };
            this._refObjectCounter = (this._refObjectCounter + 1);
            _local_1._baseAnimation = this;
            _local_1._characterName = this._characterName;
            _local_1._textureNameList = this._textureNameList;
            _local_1._textureAlphaNameList = this._textureAlphaNameList;
            _local_1._drawUnknownCharacter = this._drawUnknownCharacter;
            _local_1._shadowBitmapData = this._shadowBitmapData;
            _local_1.CharacterLevel = this._characterLevel;
            for (_local_2 in this._animationStateList)
            {
                _local_1._animationStateList[_local_2] = this._animationStateList[_local_2].Clone();
            };
            _local_1._currentAnimationState = null;
            _local_1._textureBitmapDataList = this._textureBitmapDataList;
            _local_1.Hided = this._isHided;
            return (_local_1);
        }

        public function set Invisible(_arg_1:Boolean):void
        {
            this._isInvisible = _arg_1;
        }

        public function set Hided(_arg_1:Boolean):void
        {
            this._isHided = _arg_1;
        }

        public function IsCollided(_arg_1:Point):Boolean
        {
            var _local_2:Boolean;
            if (this._lastDrawRect != null)
            {
                _local_2 = this._lastDrawRect.containsPoint(_arg_1);
            };
            return (_local_2);
        }

        public function IsIntersected(_arg_1:Rectangle):Boolean
        {
            var _local_2:Boolean;
            if (this._lastDrawRect != null)
            {
                _local_2 = this._lastDrawRect.intersects(_arg_1);
            };
            return (_local_2);
        }

        public function get IsLocalOrGuildPlayer():Boolean
        {
            return (this._isLocalOrGuildPlayer);
        }

        public function set IsLocalOrGuildPlayer(_arg_1:Boolean):void
        {
            this._isLocalOrGuildPlayer = _arg_1;
        }

        public function get IsHided():Boolean
        {
            return (this._isHided);
        }

        public function get LeftHandRefineLevel():int
        {
            return (this._leftHandRefineLevel);
        }

        public function set LeftHandRefineLevel(_arg_1:int):void
        {
            this._leftHandRefineLevel = _arg_1;
        }

        public function get RightHandRefineLevel():int
        {
            return (this._rightHandRefineLevel);
        }

        public function set RightHandRefineLevel(_arg_1:int):void
        {
            this._rightHandRefineLevel = _arg_1;
        }

        public function SetAdjustColor(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):void
        {
            this._brightness = _arg_1;
            this._contrast = _arg_2;
            this._saturation = _arg_3;
            this._hue = _arg_4;
        }


    }
}//package hbm.Game.Renderer

