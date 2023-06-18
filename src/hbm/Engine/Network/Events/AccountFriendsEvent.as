


//hbm.Engine.Network.Events.AccountFriendsEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class AccountFriendsEvent extends Event 
    {

        public static const ON_ACCOUNT_FRIENDS_UPDATE:String = "ON_ACCOUNT_FRIENDS_UPDATE";

        private var _friends:Array;

        public function AccountFriendsEvent(_arg_1:Array)
        {
            super(ON_ACCOUNT_FRIENDS_UPDATE);
            this._friends = _arg_1;
        }

        public function get FriendsIds():Array
        {
            return (this._friends);
        }


    }
}//package hbm.Engine.Network.Events

