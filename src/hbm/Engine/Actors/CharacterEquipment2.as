


//hbm.Engine.Actors.CharacterEquipment2

package hbm.Engine.Actors
{
    public class CharacterEquipment2 extends CharacterEquipment 
    {

        private var _amount:int;
        private var _name:String;
        private var _clothesColor:int;
        private var _jobId:int;
        private var _gender:int;
        private var _hairColor:int;

        public function CharacterEquipment2()
        {
            Clear();
        }

        public function get Name():String
        {
            return (this._name);
        }

        public function set Name(_arg_1:String):void
        {
            this._name = _arg_1;
        }

        public function get JobId():int
        {
            return (this._jobId);
        }

        public function set JobId(_arg_1:int):void
        {
            this._jobId = _arg_1;
        }

        public function get Gender():int
        {
            return (this._gender);
        }

        public function set Gender(_arg_1:int):void
        {
            this._gender = _arg_1;
        }

        public function get Amount():int
        {
            return (this._amount);
        }

        public function set Amount(_arg_1:int):void
        {
            this._amount = _arg_1;
        }

        public function get HairColor():int
        {
            return (this._hairColor);
        }

        public function set HairColor(_arg_1:int):void
        {
            this._hairColor = _arg_1;
        }

        public function get ClothesColor():int
        {
            return (this._clothesColor);
        }

        public function set ClothesColor(_arg_1:int):void
        {
            this._clothesColor = _arg_1;
        }


    }
}//package hbm.Engine.Actors

