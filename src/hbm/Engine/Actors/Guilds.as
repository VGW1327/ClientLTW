


//hbm.Engine.Actors.Guilds

package hbm.Engine.Actors
{
    import flash.utils.Dictionary;

    public class Guilds 
    {

        private var _guilds:Dictionary;
        private var _playerGuildID:uint;

        public function Guilds()
        {
            this._guilds = new Dictionary(true);
        }

        public function AddGuild(_arg_1:GuildInfo):void
        {
            this._guilds[_arg_1.Id] = _arg_1;
        }

        public function GetGuild(_arg_1:uint):GuildInfo
        {
            var _local_2:GuildInfo = (this._guilds[_arg_1] as GuildInfo);
            if (_local_2 == null)
            {
                _local_2 = new GuildInfo();
                _local_2.Id = _arg_1;
                this.AddGuild(_local_2);
            };
            return (_local_2);
        }

        public function RemoveGuild(_arg_1:uint):void
        {
            if (_arg_1 != this._playerGuildID)
            {
                delete this._guilds[_arg_1];
            };
        }

        public function get guilds():Dictionary
        {
            return (this._guilds);
        }

        public function DebugPrint():void
        {
            var _local_1:GuildInfo;
            for each (_local_1 in this._guilds)
            {
                if (_local_1 != null)
                {
                    _local_1.DebugPrint();
                };
            };
        }


    }
}//package hbm.Engine.Actors

