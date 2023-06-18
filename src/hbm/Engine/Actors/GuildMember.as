


//hbm.Engine.Actors.GuildMember

package hbm.Engine.Actors
{
    import hbm.Engine.Network.Packet.Coordinates;

    public class GuildMember 
    {

        private var _id:int;
        private var _accountId:int;
        private var _characterId:int;
        private var _hair:int;
        private var _hairColor:int;
        private var _gender:int;
        private var _jobId:int;
        private var _lv:int;
        private var _baseExp:uint;
        private var _online:int;
        private var _position:int;
        private var _lastLogin:int;
        private var _name:String;
        private var _coordinates:Coordinates;

        public function GuildMember(_arg_1:int)
        {
            this._id = _arg_1;
            this._coordinates = null;
        }

        public function get coordinates():Coordinates
        {
            return (this._coordinates);
        }

        public function set coordinates(_arg_1:Coordinates):void
        {
            this._coordinates = _arg_1;
        }

        public function get accountId():int
        {
            return (this._accountId);
        }

        public function set accountId(_arg_1:int):void
        {
            this._accountId = _arg_1;
        }

        public function get jobId():int
        {
            return (this._jobId);
        }

        public function set jobId(_arg_1:int):void
        {
            this._jobId = _arg_1;
        }

        public function get hair():int
        {
            return (this._hair);
        }

        public function set hair(_arg_1:int):void
        {
            this._hair = _arg_1;
        }

        public function get name():String
        {
            return (this._name);
        }

        public function set name(_arg_1:String):void
        {
            this._name = _arg_1;
        }

        public function get position():int
        {
            return (this._position);
        }

        public function set position(_arg_1:int):void
        {
            this._position = _arg_1;
        }

        public function get lastLogin():int
        {
            return (this._lastLogin);
        }

        public function set lastLogin(_arg_1:int):void
        {
            this._lastLogin = _arg_1;
        }

        public function get hairColor():int
        {
            return (this._hairColor);
        }

        public function set hairColor(_arg_1:int):void
        {
            this._hairColor = _arg_1;
        }

        public function get gender():int
        {
            return (this._gender);
        }

        public function set gender(_arg_1:int):void
        {
            this._gender = _arg_1;
        }

        public function get baseExp():uint
        {
            return (this._baseExp);
        }

        public function set baseExp(_arg_1:uint):void
        {
            this._baseExp = _arg_1;
        }

        public function get online():int
        {
            return (this._online);
        }

        public function set online(_arg_1:int):void
        {
            this._online = _arg_1;
        }

        public function get lv():int
        {
            return (this._lv);
        }

        public function set lv(_arg_1:int):void
        {
            this._lv = _arg_1;
        }

        public function get characterId():int
        {
            return (this._characterId);
        }

        public function set characterId(_arg_1:int):void
        {
            this._characterId = _arg_1;
        }


    }
}//package hbm.Engine.Actors

