


//hbm.Engine.Network.Events.DisplayNpcImage

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class DisplayNpcImage extends Event 
    {

        public static const ON_DISPLAY_NPC_IMAGE:String = "ON_DISPLAY_NPC_IMAGE";
        public static const ON_HIDE_NPC_IMAGE:String = "ON_HIDE_NPC_IMAGE";
        public static const ON_HIDE_AND_CLEAN_NPC_IMAGE:String = "ON_HIDE_AND_CLEAN_NPC_IMAGE";
        public static const SHOW_NPC_IMAGE:int = 2;
        public static const HIDE_NPC_IMAGE:int = 254;
        public static const HIDE_AND_CLEAN_NPC_IMAGE:int = 0xFF;

        private var _image:String;

        public function DisplayNpcImage(_arg_1:String, _arg_2:String)
        {
            super(_arg_1);
            this._image = _arg_2;
        }

        public function get Image():String
        {
            return (this._image);
        }


    }
}//package hbm.Engine.Network.Events

