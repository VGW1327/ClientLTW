


//hbm.Engine.Resource.AbstractResourceLibrary

package hbm.Engine.Resource
{
	import flash.events.ProgressEvent;
    import flash.system.ApplicationDomain;
    import mx.core.BitmapAsset;

    public interface AbstractResourceLibrary 
    {
        function GetLibraryFileName():String;
        function LoadResourceLibrary(_arg_1:Boolean=true):void;
        function GetClass(_arg_1:String):*;
        function GetApplicationDomain():ApplicationDomain;
        function get IsLoaded():Boolean;
        function GetBitmapAsset(_arg_1:String):BitmapAsset;
    }
}//package hbm.Engine.Resource

