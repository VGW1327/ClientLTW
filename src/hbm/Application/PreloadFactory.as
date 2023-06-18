package hbm.Application
{
    import flash.display.MovieClip;
    import com.bit101.components.Label;
    import com.bit101.components.ProgressBar;
    import hbm.Engine.Resource.LocalizationPreloaderResourceLibrary;
    import flash.display.StageScaleMode;
    import flash.display.StageAlign;
    import flash.events.Event;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.utils.getDefinitionByName;

    public class PreloadFactory extends MovieClip 
    {

        private var _progressText:Label;
        private var _progressBar:ProgressBar;
        private var _localizationPreloader:LocalizationPreloaderResourceLibrary;
        private var _languageId:int;
        private var _flashVars:Object = null;

        public function PreloadFactory()
        {
            if (stage != null)
            {
                stage.scaleMode = StageScaleMode.NO_SCALE;
                stage.align = StageAlign.TOP_LEFT;
            }
            addEventListener(Event.ADDED_TO_STAGE, OnAddedToStage);
        }

        public function SetFileList(_arg_1:Function):void
        {
            ResourceManager.Instance.SetFileList(_arg_1);
        }

        public function SetFlashVars(_arg_1:Object):void
        {
            this._flashVars = _arg_1;
        }

        protected function OnAddedToStage(_arg_1:Event):void
        {
            var _local_2:int = stage.stageWidth;
			var _local_3:int = stage.stageHeight;
            var _local_4:int = int((_local_2 / 2));
			var _local_5:String = loaderInfo.loaderURL;
            var _local_6:RegExp = /^.+\//;
            var _local_7:Array = _local_5.match(_local_6);
			var _local_8:String = _local_7[0];
            graphics.beginFill(0xF8F8F8);
            graphics.drawRect(0, 0, _local_2, _local_3);
            _progressBar = new ProgressBar(this, 400, 300);
            _progressBar.width = 200;
            _progressBar.height = 13;
            _progressBar.x = (_local_4 - (_progressBar.width / 2));
            _progressBar.maximum = 100;
            _progressText = new Label(this, _local_4, 297);
            _progressText.text = "0%";
            _progressText.x = ((_local_4 - (_progressText.width / 2)) - 3);
            if (_flashVars == null)
            {
                _flashVars = loaderInfo.parameters;
            }
            _languageId = (((!(_flashVars == null)) && (!(_flashVars["lang"] == null))) ? _flashVars["lang"] : 0);
            _localizationPreloader = new LocalizationPreloaderResourceLibrary(_local_8, _languageId);
            ResourceManager.Instance.RegisterLibrary(_localizationPreloader, "LocalizationPreloader");
            _localizationPreloader.LoadResourceLibrary(false);
            addEventListener(Event.ENTER_FRAME, OnEnterFrame);
        }

        protected function OnEnterFrame(_arg_1:Event):void
        {
            if (framesLoaded == totalFrames && _localizationPreloader.IsLoaded)
            {
                graphics.clear();
                removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
                Init();
            }
            else
            {
                //this._progressBar.value = Math.round((root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal) * 100);
				//var _local_2:Number = ((root.loaderInfo.bytesTotal > 0) ? Math.round(((root.loaderInfo.bytesLoaded / root.loaderInfo.bytesTotal) * 100)) : 0);
                //this._progressText.text = "Loading: " + _local_2 + "%";
            }
        }

        protected function Init():void
        {
			var _local_1:Class = Class(getDefinitionByName("hbm.Application.ClientApplication"));
            DisplayObjectContainer(_progressBar.parent).removeChild(_progressBar);
            DisplayObjectContainer(_progressText.parent).removeChild(_progressText);
            if (_local_1)
            {
                var _local_2:DisplayObject = new _local_1() as DisplayObject;
                ClientApplication.languageId = _languageId;
                ClientApplication.flashVars = _flashVars;
                ClientApplication.Localization = _localizationPreloader.GetClass("Localization");
                ClientApplication.Popups = _localizationPreloader.GetPopups();
                addChild(_local_2);
            }
        }
    }
}

