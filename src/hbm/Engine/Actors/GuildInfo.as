


//hbm.Engine.Actors.GuildInfo

package hbm.Engine.Actors
{
    import flash.utils.Dictionary;
    import hbm.Application.ClientApplication;

    public class GuildInfo 
    {

        private var _id:int;
        private var _name:String;
        private var _masterName:String;
        private var _emblem:int;
        private var _mode:int;
        private var _lv:int;
        private var _membersConnected:int;
        private var _maxMembers:int;
        private var _averageLv:int;
        private var _exp:int;
        private var _nextExp:int;
        private var _guildCash:int;
        private var _members:Array;
        private var _titles:Dictionary;
        private var _iAmGuildMaster:Boolean;
        private var _skillPoints:int;
        private var _news:String;
        private var _allies:Dictionary;

        public function GuildInfo()
        {
            this.ClearMembers();
            this._iAmGuildMaster = false;
            this._titles = new Dictionary(true);
            this._allies = new Dictionary(true);
        }

        public function get IsGuildMaster():Boolean
        {
            if (this._masterName != null)
            {
                return (this._masterName == ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().name);
            };
            return (this._iAmGuildMaster);
        }

        public function get CanInvite():Boolean
        {
            return ((this._mode & 0x01) == 1);
        }

        public function get CanKick():Boolean
        {
            return ((this._mode & 0x10) == 16);
        }

        public function set IsGuildMaster(_arg_1:Boolean):void
        {
            this._iAmGuildMaster = _arg_1;
        }

        public function ClearAllies():void
        {
            this._allies = new Dictionary(true);
        }

        public function get Id():int
        {
            return (this._id);
        }

        public function set Id(_arg_1:int):void
        {
            this._id = _arg_1;
        }

        public function get Allies():Dictionary
        {
            return (this._allies);
        }

        public function get Name():String
        {
            return (this._name);
        }

        public function set Name(_arg_1:String):void
        {
            this._name = _arg_1;
        }

        public function get Emblem():int
        {
            return (this._emblem);
        }

        public function set Emblem(_arg_1:int):void
        {
            this._emblem = _arg_1;
        }

        public function get Mode():int
        {
            return (this._mode);
        }

        public function set Mode(_arg_1:int):void
        {
            this._mode = _arg_1;
        }

        public function get NextExp():int
        {
            return (this._nextExp);
        }

        public function set NextExp(_arg_1:int):void
        {
            this._nextExp = _arg_1;
        }

        public function get GuildCash():int
        {
            return (this._guildCash);
        }

        public function set GuildCash(_arg_1:int):void
        {
            this._guildCash = _arg_1;
        }

        public function get Lv():int
        {
            return (this._lv);
        }

        public function set Lv(_arg_1:int):void
        {
            this._lv = _arg_1;
        }

        public function get Exp():int
        {
            return (this._exp);
        }

        public function set Exp(_arg_1:int):void
        {
            this._exp = _arg_1;
        }

        public function get MembersConnected():int
        {
            return (this._membersConnected);
        }

        public function set MembersConnected(_arg_1:int):void
        {
            this._membersConnected = _arg_1;
        }

        public function get Members():int
        {
            return (this._members.length);
        }

        public function get AverageLv():int
        {
            return (this._averageLv);
        }

        public function set AverageLv(_arg_1:int):void
        {
            this._averageLv = _arg_1;
        }

        public function get MaxMembers():int
        {
            return (this._maxMembers);
        }

        public function set MaxMembers(_arg_1:int):void
        {
            this._maxMembers = _arg_1;
        }

        public function get MasterName():String
        {
            return (this._masterName);
        }

        public function set MasterName(_arg_1:String):void
        {
            this._masterName = _arg_1;
        }

        public function get members():Array
        {
            return (this._members);
        }

        public function get SkillPoints():int
        {
            return (this._skillPoints);
        }

        public function set SkillPoints(_arg_1:int):void
        {
            this._skillPoints = _arg_1;
        }

        public function GetMember(_arg_1:int):GuildMember
        {
            var _local_2:GuildMember = (this._members[_arg_1] as GuildMember);
            if (_local_2 == null)
            {
                _local_2 = (this._members[_arg_1] = new GuildMember(_arg_1));
            };
            return (_local_2);
        }

        public function FindMemberByName(_arg_1:String):GuildMember
        {
            var _local_2:GuildMember;
            for each (_local_2 in this._members)
            {
                if (_local_2 != null)
                {
                    if (_local_2.name == _arg_1)
                    {
                        return (_local_2);
                    };
                };
            };
            return (null);
        }

        public function FindMemberByAccountAndId(_arg_1:int, _arg_2:int):GuildMember
        {
            var _local_3:GuildMember;
            for each (_local_3 in this._members)
            {
                if (_local_3 != null)
                {
                    if (((_local_3.accountId == _arg_1) && (_local_3.characterId == _arg_2)))
                    {
                        return (_local_3);
                    };
                };
            };
            return (null);
        }

        public function AddTitle(_arg_1:int, _arg_2:String):void
        {
            this._titles[_arg_1] = _arg_2;
        }

        public function GetTitleByPosition(_arg_1:int):String
        {
            if (this._titles == null)
            {
                return (null);
            };
            return (this._titles[_arg_1]);
        }

        public function ClearMembers():void
        {
            this._members = new Array();
        }

        public function get News():String
        {
            return (this._news);
        }

        public function set News(_arg_1:String):void
        {
            this._news = _arg_1;
        }

        public function DebugPrint():void
        {
            var _local_1:GuildMember;
            if (this._members.length > 0)
            {
                for each (_local_1 in this._members)
                {
                };
            };
        }


    }
}//package hbm.Engine.Actors

