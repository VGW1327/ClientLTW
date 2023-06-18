


//hbm.Engine.Actors.PartyMember

package hbm.Engine.Actors
{
    import hbm.Application.ClientApplication;

    public class PartyMember 
    {

        private var _characterId:int;
        private var _name:String;
        private var _mapName:String;
        private var _leader:Boolean;
        private var _online:Boolean;
        private var _hp:int;
        private var _maxHp:int;
        private var _x:int;
        private var _y:int;


        public function toString():String
        {
            var _local_1:String = ((this._leader) ? (" " + ClientApplication.Localization.PARTY_MEMBER_NAME_PART1) : "");
            var _local_2:String = ((this._online) ? (", " + ClientApplication.Localization.PARTY_MEMBER_NAME_PART2) : "");
            return ((this._name + _local_1) + _local_2);
        }

        public function get MaxHp():int
        {
            return (this._maxHp);
        }

        public function set MaxHp(_arg_1:int):void
        {
            this._maxHp = _arg_1;
        }

        public function get Hp():int
        {
            return (this._hp);
        }

        public function set Hp(_arg_1:int):void
        {
            this._hp = _arg_1;
        }

        public function get X():int
        {
            return (this._x);
        }

        public function set X(_arg_1:int):void
        {
            this._x = _arg_1;
        }

        public function get Y():int
        {
            return (this._y);
        }

        public function set Y(_arg_1:int):void
        {
            this._y = _arg_1;
        }

        public function get Leader():Boolean
        {
            return (this._leader);
        }

        public function set Leader(_arg_1:Boolean):void
        {
            this._leader = _arg_1;
        }

        public function get Online():Boolean
        {
            return (this._online);
        }

        public function set Online(_arg_1:Boolean):void
        {
            this._online = _arg_1;
        }

        public function get MapName():String
        {
            return (this._mapName);
        }

        public function set MapName(_arg_1:String):void
        {
            this._mapName = _arg_1;
        }

        public function get CharacterId():int
        {
            return (this._characterId);
        }

        public function set CharacterId(_arg_1:int):void
        {
            this._characterId = _arg_1;
        }

        public function get Name():String
        {
            return (this._name);
        }

        public function set Name(_arg_1:String):void
        {
            this._name = _arg_1;
        }


    }
}//package hbm.Engine.Actors

