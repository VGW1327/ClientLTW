


//hbm.Engine.Network.Events.PartyEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;

    public class PartyEvent extends Event 
    {

        public static const ON_PARTY_CREATION_RESULT:String = "ON_PARTY_CREATION_RESULT";
        public static const ON_PARTY_JOIN_REQUEST:String = "ON_PARTY_JOIN_REQUEST";
        public static const ON_PARTY_MEMBER_JOINED:String = "ON_PARTY_MEMBER_JOINED";
        public static const ON_PARTY_UPDATED:String = "ON_PARTY_UPDATED";
        public static const ON_PARTY_HP_UPDATED:String = "ON_PARTY_HP_UPDATED";
        public static const ON_PARTY_LEAVE:String = "ON_PARTY_LEAVE";

        public var Result:int;
        public var PartyName:String;
        public var CharacterId:int;
        public var CharacterName:String;
        public var CurrentPartyId:int;

        public function PartyEvent(_arg_1:String)
        {
            super(_arg_1);
        }

    }
}//package hbm.Engine.Network.Events

