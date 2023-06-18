


//hbm.Engine.Actors.FriendMember

package hbm.Engine.Actors
{
    import hbm.Application.ClientApplication;

    public class FriendMember 
    {

        private var _accountId:int;
        private var _characterId:int;
        private var _name:String;
        private var _online:Boolean;


        public function toString():String
        {
            var _local_1:String = ((this._online) ? (", " + ClientApplication.Localization.PARTY_MEMBER_NAME_PART2) : "");
            return (this._name + _local_1);
        }

        public function get Online():Boolean
        {
            return (this._online);
        }

        public function set Online(_arg_1:Boolean):void
        {
            this._online = _arg_1;
        }

        public function get CharacterId():int
        {
            return (this._characterId);
        }

        public function set CharacterId(_arg_1:int):void
        {
            this._characterId = _arg_1;
        }

        public function get AccountId():int
        {
            return (this._accountId);
        }

        public function set AccountId(_arg_1:int):void
        {
            this._accountId = _arg_1;
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

