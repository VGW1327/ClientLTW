


//hbm.Engine.Resource.LocalizationResourceLibrary

package hbm.Engine.Resource
{
    import hbm.Application.ClientApplication;
    import flash.events.Event;

    public class LocalizationResourceLibrary extends ResourceLibrary 
    {


        override public function GetLibraryFileName():String
        {
            var _local_1:String;
            switch (ClientApplication.languageId)
            {
                case 1:
					_local_1 = "lk_rus";
					break;
                case 2:
                    _local_1 = "lk_eng";
                    break;
				default:
					_local_1 = "lk_rus";
					break;
            };
            return (ClientApplication.Instance.Config.GetFileURL(_local_1));
        }

        override protected function OnResourceLoaded(_arg_1:Event):void
        {
            super.OnResourceLoaded(_arg_1);
        }


    }
}//package hbm.Engine.Resource

