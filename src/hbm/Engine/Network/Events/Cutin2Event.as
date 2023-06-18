


//hbm.Engine.Network.Events.Cutin2Event

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class Cutin2Event extends Event 
    {

        public static const ON_CUTIN2_COMMAND:String = "ON_CUTIN2_COMMAND";
        public static const COMMAND_DISPLAY_WELCOME_IMAGE:int = 0;
        public static const COMMAND_SHOW_GUIDE_BUTTON:int = 1;
        public static const COMMAND_SHOW_ARENA_BUTTON:int = 2;
        public static const COMMAND_HIDE_ARENA_BUTTON:int = 3;
        public static const COMMAND_SHOW_CLOUD_BUTTON:int = 4;
        public static const COMMAND_HIDE_CLOUD_BUTTON:int = 5;
        public static const COMMAND_OPEN_CART:int = 6;
        public static const COMMAND_OPEN_NEWS:int = 7;

        private var _command:int;

        public function Cutin2Event(_arg_1:String, _arg_2:int)
        {
            super(_arg_1);
            this._command = _arg_2;
        }

        public function get Command():int
        {
            return (this._command);
        }


    }
}//package hbm.Engine.Network.Events

