


//vk.events.CustomEvent

package vk.events
{
    import flash.events.Event;

    public class CustomEvent extends Event 
    {

        public static const CONN_INIT:String = "onConnectionInit";
        public static const WINDOW_BLUR:String = "onWindowBlur";
        public static const WINDOW_FOCUS:String = "onWindowFocus";
        public static const APP_ADDED:String = "onApplicationAdded";
        public static const WALL_SAVE:String = "onWallPostSave";
        public static const WALL_CANCEL:String = "onWallPostCancel";
        public static const PHOTO_SAVE:String = "onProfilePhotoSave";
        public static const PHOTO_CANCEL:String = "onProfilePhotoCancel";

        private var _data:Object = new Object();
        private var _params:Array = new Array();

        public function CustomEvent(_arg_1:String, _arg_2:Boolean=false, _arg_3:Boolean=false)
        {
            super(_arg_1, _arg_2, _arg_3);
        }

        public function get data():Object
        {
            return (_data);
        }

        public function set data(_arg_1:Object):void
        {
            _data = _arg_1;
        }

        public function get params():Array
        {
            return (_params);
        }

        public function set params(_arg_1:Array):void
        {
            _params = _arg_1;
        }


    }
}//package vk.events

