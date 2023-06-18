


//hbm.Engine.Network.Events.FriendEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class FriendEvent extends Event 
    {

        public static const ON_FRIENDS_UPDATED:String = "ON_FRIENDS_UPDATED";
        public static const ON_FRIENDS_RESULT:String = "ON_FRIENDS_RESULT";
        public static const ON_FRIEND_MEMBER_ADD_REQUEST:String = "ON_FRIEND_MEMBER_ADD_REQUEST";
        public static const ON_FRIEND_MEMBER_REMOVED:String = "ON_FRIEND_MEMBER_REMOVED";
        public static var CurrentCharacterId:int;
        public static var CurrentAccountId:int;

        public var Result:int;
        public var AccountId:int;
        public var CharacterId:int;
        public var CharacterName:String;

        public function FriendEvent(_arg_1:String)
        {
            super(_arg_1);
        }

    }
}//package hbm.Engine.Network.Events

