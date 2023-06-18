package hbm.Engine.Resource
{
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;

    public class ResourceManager extends EventDispatcher 
    {

        private static var _singleton:ResourceManager = null;
        private static var _isSingletonLock:Boolean = false;

        private var _libraries:Dictionary;
        private var _fileListData:Function;

        public function ResourceManager()
        {
            if (!_isSingletonLock)
            {
                throw (new Error("Invalid Singleton access."));
            };
            this._libraries = new Dictionary(true);
        }

        public static function get Instance():ResourceManager
        {
            if (_singleton == null)
            {
                _isSingletonLock = true;
                _singleton = new (ResourceManager)();
                _isSingletonLock = false;
            };
            return (_singleton);
        }


        public function GetResourceFile(_arg_1:String):String
        {
            if (this._fileListData == null)
            {
                return (_arg_1);
            };
            return (this._fileListData(_arg_1));
        }

        public function SetFileList(_arg_1:Function):void
        {
            this._fileListData = _arg_1;
        }

        public function RegisterLibrary(_arg_1:AbstractResourceLibrary, _arg_2:String):void
        {
            this._libraries[_arg_2] = _arg_1;
        }

        public function Library(_arg_1:String):AbstractResourceLibrary
        {
            return (this._libraries[_arg_1] as AbstractResourceLibrary);
        }

        public function GetLibrariesCount():int
        {
            var _local_2:AbstractResourceLibrary;
            var _local_1:int;
            for each (_local_2 in this._libraries)
            {
                _local_1++;
            };
            return (_local_1);
        }

        public function GetLibrariesLoadedCount():int
        {
            var _local_2:AbstractResourceLibrary;
            var _local_1:int;
            for each (_local_2 in this._libraries)
            {
                if (_local_2.IsLoaded)
                {
                    _local_1++;
                };
            };
            return (_local_1);
        }

        public function get Libraries():Dictionary
        {
            return (this._libraries);
        }


    }
}

