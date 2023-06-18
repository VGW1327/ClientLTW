package hbm.Game.GUI
{
    import flash.display.Sprite;
    import flash.display.DisplayObjectContainer;
    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import hbm.Application.ClientApplication;
    import hbm.Application.ClientConfig;
    import flash.system.SecurityDomain;
    import flash.system.ApplicationDomain;
    import flash.net.URLRequest;
    import flash.display.BitmapData;

    public class LoadingScreen extends Sprite 
    {

        private var _parent:DisplayObjectContainer;
        private var _loadingScreen:LoadingWindow;
        private var _advt:Bitmap;
        private var _advtLoader:Loader;
        protected var _resourceContext:LoaderContext;

        public function LoadingScreen(_arg_1:DisplayObjectContainer, _arg_2:int, _arg_3:int)
        {
            this._parent = _arg_1;
            this._loadingScreen = new LoadingWindow();
			this._loadingScreen._progressBar.progress.x = - (this._loadingScreen._progressBar.progress.width);
            this._advtLoader = new Loader();
            this._advtLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.ImageCompleteHandler);
            this._advtLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.ImageErrorHandler);
            var _local_4:ClientConfig = ClientApplication.Instance.Config;
            var _local_5:* = ((_local_4.CurrentPlatformId == ClientConfig.STANDALONE) ? SecurityDomain.currentDomain : null);
            this._resourceContext = new LoaderContext(true, ApplicationDomain.currentDomain, _local_5);
            this.ShowAdvt();
            addChild(this._loadingScreen);
        }

        private function ShowAdvt():void
        {
            var _local_1:int;
            if (((!(this._advt == null)) && (this._loadingScreen.contains(this._advt))))
            {
                this._loadingScreen.removeChild(this._advt);
            };
            _local_1 = int((Math.random() * 28));
            var _local_2:String = ((_local_1 < 10) ? ("0" + _local_1) : _local_1.toString());
            var _local_3:String = ClientApplication.Instance.Config.GetFileURLExt((("Advt/img" + _local_2) + ".jxr"));
            this._advtLoader.load(new URLRequest(_local_3), this._resourceContext);
        }

        public function UpdateProgress(_arg_1:Number, _arg_2:Number):void
        {
			var _local_2:Number = ((_arg_2 > 0) ? (_arg_1 / _arg_2) : 0);
			this._loadingScreen._progressBar.progress.x = - (this._loadingScreen._progressBar.progress.width) + (_local_2 * this._loadingScreen._progressBar.progress.width);
        }

        private function ImageCompleteHandler(_arg_1:Event):void
        {
            var _local_2:BitmapData;
            _local_2 = _arg_1.target.content.bitmapData;
            var _local_3:Bitmap = new Bitmap(_local_2);
            if (_local_3)
            {
                this._advt = _local_3;
                this._advt.x = ((width - this._advt.width) / 2);
                this._advt.y = ((height / 2) + 150);
                this._loadingScreen.addChild(this._advt);
            };
        }

        private function ImageErrorHandler(_arg_1:Event):void
        {
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
        }


    }
}

