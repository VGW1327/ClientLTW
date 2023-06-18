


//hbm.Engine.Resource.LocalizationPreloaderResourceLibrary

package hbm.Engine.Resource
{
    import flash.events.Event;

    public class LocalizationPreloaderResourceLibrary extends ResourceLibrary 
    {

        private var _filePath:String;
        private var _popup:Object;
        private var _languageId:int;

        public function LocalizationPreloaderResourceLibrary(_arg_1:String, _arg_2:int)
        {
            this._filePath = _arg_1;
            this._languageId = _arg_2;
        }

        override public function GetLibraryFileName():String
        {
            var _local_1:String;
            switch (this._languageId){
				case 1:
					_local_1 = "lk_preloader_rus";
					break;
                case 2:
                    _local_1 = "lk_preloader_eng";
                    break;
				default:
					_local_1 = "lk_preloader_rus";
					break;
            }
            return (this._filePath + ResourceManager.Instance.GetResourceFile(_local_1 + ".swf"));
        }

        override protected function OnResourceLoaded(_arg_1:Event):void
        {
            super.OnResourceLoaded(_arg_1);
            this.LoadPopupsData();
        }

        private function LoadPopupsData():void
        {
            this._popup = GetJSON("Localization_Data_Popup");
        }

        public function GetPopups():Object
        {
            if (this._popup)
            {
                return (this._popup["PopupList"]);
            };
            return (null);
        }


    }
}//package hbm.Engine.Resource

