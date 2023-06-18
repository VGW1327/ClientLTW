package hbm.Engine.Resource
{
    import flash.events.EventDispatcher;
    import flash.display.Loader;
    import flash.system.LoaderContext;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.SecurityDomain;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
    import flash.errors.IllegalOperationError;
    import mx.core.BitmapAsset;
    import hbm.Engine.Utility.JSONParser;

    public class ResourceLibrary extends EventDispatcher implements AbstractResourceLibrary 
    {

        public static const ON_LOADED:String = "ON_LOADED";
		public static const ON_PROGRESS:String = "ON_PROGRESS";

        protected var _isLoaded:Boolean = false;
        protected var _resourceLoader:Loader;
        protected var _resourceContext:LoaderContext;
        private var _isResourceLoadedDispatch:Boolean;
		protected var _progress:Number = 0;
		protected var _bytesTotal:int = 0;
		

        public function GetLibraryFileName():String
        {
            return (null);
        }

        public function LoadResourceLibrary(_arg_1:Boolean=true):void
        {
            this._resourceLoader = new Loader();
			var _local_2:URLRequest = new URLRequest(this.GetLibraryFileName());
            this._isResourceLoadedDispatch = _arg_1;
            this._resourceContext = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
            this._resourceLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.OnResourceLoaded, false, 0, true);
			this._resourceLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.OnResourceProgress, false, 0, true);
            this._resourceLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.OnIoError, false, 0, true);
            this._resourceLoader.load(_local_2, this._resourceContext);
        }

        public function get IsLoaded():Boolean
        {
            return (this._isLoaded);
        }

        public function GetClass(name:String):*
        {
            if (!this._isLoaded)
            {
                return (null);
            };
            try
            {
                return (this._resourceContext.applicationDomain.getDefinition(name) as Class);
            }
            catch(e:Error)
            {
                throw (new IllegalOperationError(((name + " definition not found in ") + GetLibraryFileName())));
            };
            return (null);
        }

        public function GetBitmapAsset(assetName:String):BitmapAsset
        {
            var currentClass:Class;
            if (!this._isLoaded)
            {
                return (null);
            };
            try
            {
                currentClass = (this._resourceContext.applicationDomain.getDefinition(assetName) as Class);
                if (currentClass == null)
                {
                    return (null);
                };
            }
            catch(error:Error)
            {
                return (null);
            };
            return (new (currentClass)());
        }

        protected function GetJSON(_arg_1:String):Object
        {
            var _local_2:Class = this.GetClass(_arg_1);
            return (JSONParser.GetJSON(_local_2));
        }

        public function GetApplicationDomain():ApplicationDomain
        {
            return (this._resourceContext.applicationDomain);
        }
		
		private function OnResourceProgress(_arg_1:ProgressEvent):void
        {
            this._progress = (_arg_1.bytesLoaded / _arg_1.bytesTotal);
            dispatchEvent(new Event(ResourceLibrary.ON_PROGRESS));
        }
		
        protected function OnResourceLoaded(_arg_1:Event):void
        {
			this._progress = 1;
            this._isLoaded = true;
            if (this._isResourceLoadedDispatch)
            {
                dispatchEvent(new Event(ResourceLibrary.ON_LOADED));
            };
        }

        protected function OnIoError(_arg_1:IOErrorEvent):void
        {
        }
		
		public function get progress():Number
        {
            return (this._progress);
        }
    }
}

