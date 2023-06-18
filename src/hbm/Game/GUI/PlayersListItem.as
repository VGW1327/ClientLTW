


//hbm.Game.GUI.PlayersListItem

package hbm.Game.GUI
{
    public class PlayersListItem 
    {

        private var _name:String;
        private var _baseLevel:int;
        private var _characterId:int;

        public function PlayersListItem(_arg_1:String, _arg_2:int, _arg_3:int)
        {
            this._name = _arg_1;
            this._baseLevel = _arg_2;
            this._characterId = _arg_3;
        }

        public function get CharacterId():int
        {
            return (this._characterId);
        }

        public function get BaseLevel():int
        {
            return (this._baseLevel);
        }

        public function get Name():String
        {
            return (this._name);
        }

        public function toString():String
        {
            if (this._baseLevel > 1)
            {
                return (((this._name + "[") + this._baseLevel) + "]");
            };
            return (this._name);
        }


    }
}//package hbm.Game.GUI

