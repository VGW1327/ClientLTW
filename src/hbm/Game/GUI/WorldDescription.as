


//hbm.Game.GUI.WorldDescription

package hbm.Game.GUI
{
    import hbm.Game.Utility.HtmlText;

    public class WorldDescription 
    {

        private var _address:String;
        private var _port:int;
        private var _name:String;
        private var _desc:String;
        private var _game:String;
        private var _gameId:int;

        public function WorldDescription(_arg_1:String, _arg_2:int, _arg_3:String, _arg_4:String, _arg_5:String, _arg_6:int)
        {
            this._address = _arg_1;
            this._port = _arg_2;
            this._name = _arg_3;
            this._desc = HtmlText.update(_arg_4, false, 12, HtmlText.fontName, "#E0BA3B");
            this._game = _arg_5;
            this._gameId = _arg_6;
        }

        public function get Name():String
        {
            return (this._name);
        }

        public function get Description():String
        {
            return (this._desc);
        }

        public function get Address():String
        {
            return (this._address);
        }

        public function get Port():int
        {
            return (this._port);
        }

        public function get Game():String
        {
            return (this._game);
        }

        public function get GameId():int
        {
            return (this._gameId);
        }

        public function toString():String
        {
            return (this._name);
        }


    }
}//package hbm.Game.GUI

