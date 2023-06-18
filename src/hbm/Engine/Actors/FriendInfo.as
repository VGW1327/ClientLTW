


//hbm.Engine.Actors.FriendInfo

package hbm.Engine.Actors
{
    import flash.utils.Dictionary;

    public class FriendInfo 
    {

        private var _friends:Dictionary;

        public function FriendInfo()
        {
            this.ClearFriends();
        }

        public function get Friends():int
        {
            return (this._friends.length);
        }

        public function get friends():Dictionary
        {
            return (this._friends);
        }

        public function GetFriend(_arg_1:int):FriendMember
        {
            var _local_2:FriendMember = (this._friends[_arg_1] as FriendMember);
            if (_local_2 == null)
            {
                _local_2 = (this._friends[_arg_1] = new FriendMember());
            };
            return (_local_2);
        }

        public function RemoveFriend(_arg_1:int):void
        {
            var _local_2:FriendMember = (this._friends[_arg_1] as FriendMember);
            if (_local_2 != null)
            {
                delete this._friends[_arg_1];
            };
        }

        public function FindMemberByName(_arg_1:String):FriendMember
        {
            var _local_2:FriendMember;
            for each (_local_2 in this._friends)
            {
                if (_local_2 != null)
                {
                    if (_local_2.Name == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        public function FindMemberByAccountAndId(_arg_1:int, _arg_2:int):FriendMember
        {
            var _local_3:FriendMember;
            for each (_local_3 in this._friends)
            {
                if (_local_3 != null)
                {
                    if (((_local_3.AccountId == _arg_1) && (_local_3.CharacterId == _arg_2)))
                    {
                        return (_local_3);
                    };
                };
            };
            return (null);
        }

        public function ClearFriends():void
        {
            this._friends = new Dictionary(true);
        }


    }
}//package hbm.Engine.Actors

