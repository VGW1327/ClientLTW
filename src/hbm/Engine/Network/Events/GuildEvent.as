


//hbm.Engine.Network.Events.GuildEvent

package hbm.Engine.Network.Events
{
    import flash.events.Event;
    import hbm.Engine.Actors.CharacterInfo;

    public class GuildEvent extends Event 
    {

        public static const ON_GUILD_CREATION_MESSAGE:String = "ON_GUILD_CREATION_MESSAGE";
        public static const ON_GUILD_UPDATED:String = "ON_GUILD_UPDATED";
        public static const ON_GUILD_JOIN_REQUEST:String = "ON_GUILD_JOIN_REQUEST";
        public static const ON_GUILD_LEAVE_MESSAGE:String = "ON_GUILD_LEAVE_MESSAGE";
        public static const ON_GUILD_ALLY_REQUEST:String = "ON_GUILD_ALLY_REQUEST";
        public static const ON_GUILD_ALLY_BROKEN:String = "ON_GUILD_ALLY_BROKEN";
        public static const ON_GUILD_LIST:String = "ON_GUILD_LIST";
        public static var CurrentGuildId:int;

        private var _player:CharacterInfo;
        private var _guildId:int;
        private var _name:String;
        private var _info:String;
        private var _guildList:Array;
        private var _pages:int;
        public var Result:int;

        public function GuildEvent(_arg_1:String, _arg_2:CharacterInfo=null, _arg_3:int=0, _arg_4:String=null, _arg_5:String=null)
        {
            super(_arg_1);
            this._player = _arg_2;
            this._guildId = _arg_3;
            CurrentGuildId = _arg_3;
            this._name = _arg_4;
            this._info = _arg_5;
        }

        public function get Player():CharacterInfo
        {
            return (this._player);
        }

        public function get GuildId():int
        {
            return (this._guildId);
        }

        public function get Name():String
        {
            return (this._name);
        }

        public function get Info():String
        {
            return (this._info);
        }

        public function get GuildList():Array
        {
            return (this._guildList);
        }

        public function set GuildList(_arg_1:Array):void
        {
            this._guildList = _arg_1;
        }

        public function get Pages():int
        {
            return (this._pages);
        }

        public function set Pages(_arg_1:int):void
        {
            this._pages = _arg_1;
        }


    }
}//package hbm.Engine.Network.Events

