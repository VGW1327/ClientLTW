


//hbm.Engine.Network.Events.NpcTalkEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class NpcTalkEvent extends Event 
    {

        public static const ON_NPC_TALK:String = "ON_NPC_TALK";
        public static const ON_NPC_RESPONSES:String = "ON_NPC_RESPONSES";
        public static const ON_NPC_TALK_CONTINUE:String = "ON_NPC_TALK_CONTINUE";
        public static const ON_NPC_TALK_CLOSE:String = "ON_NPC_TALK_CLOSE";
        public static const ON_NPC_INPUT_STRING:String = "ON_NPC_INPUT_STRING";
        public static const ON_NPC_INPUT_NUMBER:String = "ON_NPC_INPUT_NUMBER";

        private var _message:String;
        private var _character:int;
        private var _answers:Array;

        public function NpcTalkEvent(_arg_1:String, _arg_2:int, _arg_3:String=null, _arg_4:Array=null)
        {
            super(_arg_1);
            this._character = _arg_2;
            this._message = _arg_3;
            this._answers = _arg_4;
        }

        public function get CharacterId():int
        {
            return (this._character);
        }

        public function get Message():String
        {
            return (this._message);
        }

        public function get Answers():Array
        {
            return (this._answers);
        }


    }
}//package hbm.Engine.Network.Events

