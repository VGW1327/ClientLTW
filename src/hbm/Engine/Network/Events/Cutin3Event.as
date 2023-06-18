package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class Cutin3Event extends Event 
    {

        public static const ON_CUTIN3_COMMAND:String = "ON_CUTIN3_COMMAND";
        public static const COMMAND_UPDATE_QUESTS:int = 0;
        public static const COMMAND_PREMIUMSHOP_BUY:int = 3;
        public static const COMMAND_GIFT2_COUNTER:int = 4;
        public static const COMMAND_LOAD_ICON_TUTORIAL:int = 5;
        public static const COMMAND_ACCEPT_ICON_TUTORIAL:int = 6;
        public static const COMMAND_DELETE_ICON_TUTORIAL:int = 7;
        public static const COMMAND_SHOW_TUTORIAL_WINDOW:int = 8;
        public static const COMMAND_SHOW_ARROW_TUTORIAL:int = 9;
        public static const COMMAND_SHOW_MOVE_TO_POINT:int = 10;
        public static const COMMAND_ENABLE_SKILLS_BUTTON:int = 11;
        public static const COMMAND_CLOSE_ALL_WINDOW:int = 12;
        public static const COMMAND_SEND_STATISTIC:int = 13;
        public static const COMMAND_SHOW_ARROW_PARAM_TUTORIAL:int = 14;
        public static const COMMAND_SEND_STATISTIC_NUM:int = 18;
        public static const COMMAND_SHOW_LEVELUP_WINDOW:int = 19;
        public static const COMMAND_SHOW_QUEST_ACCEPT:int = 20;
        public static const COMMAND_SHOW_QUEST_REWARD:int = 21;

        private var _command:int;
        private var _value:String;

        public function Cutin3Event(_arg_1:String, _arg_2:int, _arg_3:String=null)
        {
            super(_arg_1);
            this._command = _arg_2;
            this._value = _arg_3;
        }

        public function get Command():int
        {
            return (this._command);
        }

        public function get Value():String
        {
            return (this._value);
        }


    }
}