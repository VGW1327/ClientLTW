


//hbm.Game.GUI.CharacterCreation.CharacterListEvent

package hbm.Game.GUI.CharacterCreation
{
    import flash.events.Event;

    public class CharacterListEvent extends Event 
    {

        public static const ON_ACTION:String = "CLI_ON_ACTION";
        public static const ON_RENAME:String = "CLI_ON_RENAME";

        private var _slotId:int;
        private var _typeName:String;
        private var _jobId:int;

        public function CharacterListEvent(_arg_1:String, _arg_2:int, _arg_3:int=-1)
        {
            super(_arg_1);
            this._typeName = _arg_1;
            this._slotId = _arg_2;
            this._jobId = _arg_3;
        }

        override public function clone():Event
        {
            return (new CharacterListEvent(this._typeName, this._slotId, this._jobId));
        }

        public function get SlotId():int
        {
            return (this._slotId);
        }

        public function get JobId():int
        {
            return (this._jobId);
        }


    }
}//package hbm.Game.GUI.CharacterCreation

