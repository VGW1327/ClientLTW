


//hbm.Game.GUI.CharacterCreation.CharacterCreateEvent

package hbm.Game.GUI.CharacterCreation
{
    import flash.events.Event;

    public class CharacterCreateEvent extends Event 
    {

        public static const ON_CHARACTER_CONFIRMED:String = "ON_CHARACTER_CONFIRMED";
        public static const ON_CHARACTER_RENAME_CONFIRMED:String = "ON_CHARACTER_RENAME_CONFIRMED";
        public static const ON_CHARACTER_CHECK_NAME:String = "ON_CHARACTER_CHECK_NAME";

        private var _name:String;
        private var _isMale:Boolean;
        private var _jobId:int;
        private var _clothesColor:int;

        public function CharacterCreateEvent(_arg_1:String, _arg_2:String, _arg_3:Boolean, _arg_4:int=-1, _arg_5:int=0)
        {
            super(_arg_1);
            this._name = _arg_2;
            this._isMale = _arg_3;
            this._jobId = _arg_4;
            this._clothesColor = _arg_5;
        }

        public function get Name():String
        {
            return (this._name);
        }

        public function get IsMale():Boolean
        {
            return (this._isMale);
        }

        public function get JobId():int
        {
            return (this._jobId);
        }

        public function get ClothesColor():int
        {
            return (this._clothesColor);
        }

        public function get GenderSuffix():String
        {
            if (this._isMale)
            {
                return ("|");
            };
            return ("_");
        }


    }
}//package hbm.Game.GUI.CharacterCreation

