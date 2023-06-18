


//hbm.Engine.Network.Events.ClientEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class ClientEvent extends Event 
    {

        public static const ON_ACCOUNT_DOESNT_EXIST:String = "ON_ACCOUNT_DOESNT_EXIST";
        public static const ON_CHARACTER_NAME_DUPLICATE:String = "ON_CHARACTER_NAME_DUPLICATE";
        public static const ON_PASSWORD_ERROR:String = "ON_PASSWORD_ERROR";
        public static const ON_CONNECTED_TO_ACCOUNT:String = "ON_CONNECTED_TO_ACCOUNT";
        public static const ON_CHARSERVER_INVITATION:String = "ON_CHARSERVER_INVITATION";
        public static const ON_CHARACTER_CREATION_SUCCESSFUL:String = "ON_CHARACTER_CREATION_SUCCESSFUL";
        public static const ON_CHARACTERS_RECEIVED:String = "ON_CHARACTERS_RECEIVED";
        public static const ON_CHARACTERS_DOSENT_EXIST:String = "ON_CHARACTERS_DOSENT_EXIST";
        public static const ON_CHARACTER_NAME_DENIED:String = "ON_CHARACTER_NAME_DENIED";
        public static const ON_MAPSERVER_INVITATION:String = "ON_MAPSERVER_INVITATION";
        public static const ON_ENTERED_MAP:String = "ON_ENTERED_MAP";
        public static const ON_PLAYER_RESPAWNED:String = "ON_PLAYER_RESPAWNED";
        public static const ON_PLAYER_RESPAWNED_INSTANCE:String = "ON_PLAYER_RESPAWNED_INSTANCE";
        public static const ON_PLAYER_DETACHED:String = "ON_PLAYER_DETACHED";
        public static const ON_CHARACTER_RENAME_REQUEST_ACCEPTED:String = "ON_CHARACTER_RENAME_REQUEST_ACCEPTED";
        public static const ON_CHARACTER_RENAME_REQUEST_REJECTED:String = "ON_CHARACTER_RENAME_REQUEST_REJECTED";
        public static const ON_CHARACTER_RENAME_SUCCESSFUL:String = "ON_CHARACTER_RENAME_SUCCESSFUL";
        public static const ON_CHARACTER_RENAME_ALREADY_CHANGED:String = "ON_CHARACTER_RENAME_ALREADY_CHANGED";
        public static const ON_CHARACTER_RENAME_FAILED:String = "ON_CHARACTER_RENAME_FAILED";
        public static const ON_CHARACTER_CHECK_NAME_SUCCESSFUL:String = "ON_CHARACTER_CHECK_NAME_SUCCESSFUL";
        public static const ON_CHARACTER_CHECK_NAME_FAILED:String = "ON_CHARACTER_CHECK_NAME_FAILED";

        public var slot:int = -1;
        public var flag:int = -1;

        public function ClientEvent(_arg_1:String)
        {
            super(_arg_1);
        }

    }
}//package hbm.Engine.Network.Events

