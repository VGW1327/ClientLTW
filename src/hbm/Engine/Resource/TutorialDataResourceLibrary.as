


//hbm.Engine.Resource.TutorialDataResourceLibrary

package hbm.Engine.Resource
{
    import hbm.Application.ClientApplication;
    import flash.events.Event;
    import mx.core.BitmapAsset;
    import org.aswing.AttachIcon;

    public class TutorialDataResourceLibrary extends ResourceLibrary 
    {

        private var _tutorial:Object;


        override public function GetLibraryFileName():String
        {
            return (ClientApplication.Instance.Config.GetFileURL("TutorialData"));
        }

        override protected function OnResourceLoaded(_arg_1:Event):void
        {
            super.OnResourceLoaded(_arg_1);
            this.LoadTutorialData();
        }

        public function GetTutorialData(_arg_1:int):Object
        {
            if (this._tutorial == null)
            {
                return (null);
            };
            return (this._tutorial["TutorialInfo"][_arg_1]);
        }

        public function get GetTutorial():Object
        {
            return (this._tutorial);
        }

        private function LoadTutorialData():void
        {
            this._tutorial = GetJSON("TutorialData_Data_Tutorial");
        }

        public function GetItemAttachIcon(_arg_1:String):AttachIcon
        {
            var _local_2:String;
            var _local_3:BitmapAsset;
            if (IsLoaded)
            {
                while (_arg_1.length < 3)
                {
                    _arg_1 = ("0" + _arg_1);
                };
                _local_2 = ("TutorialData_Item_" + _arg_1);
                _local_3 = GetBitmapAsset(_local_2);
                if (_local_3 == null)
                {
                    return (new AttachIcon("TutorialData_Item_000"));
                };
                return (new AttachIcon(_local_2));
            };
            return (null);
        }


    }
}//package hbm.Engine.Resource

