


//hbm.Game.GUI.PartyList.PartyController

package hbm.Game.GUI.PartyList
{
    import hbm.Engine.Network.Client.Client;
    import hbm.Engine.Actors.PartyInfo;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Network.Events.PartyEvent;
    import flash.utils.Dictionary;
    import hbm.Engine.Actors.PartyMember;
    import hbm.Engine.Network.Events.ActorStatsEvent;
    import flash.display.DisplayObject;

    public class PartyController 
    {

        private var _client:Client;
        private var _partyListPanel:PartyListPanel;
        private var _partyInfo:PartyInfo;
        private var _player:CharacterInfo;

        public function PartyController()
        {
            this._client = ClientApplication.Instance.LocalGameClient;
            this._player = this._client.ActorList.GetPlayer();
            this._partyListPanel = new PartyListPanel();
            this.SetListeners();
        }

        private function SetListeners():void
        {
            this._client.addEventListener(PartyEvent.ON_PARTY_CREATION_RESULT, this.OnPartyCreationResult);
            this._client.addEventListener(PartyEvent.ON_PARTY_MEMBER_JOINED, this.OnMemberJoined);
            this._client.addEventListener(PartyEvent.ON_PARTY_LEAVE, this.OnMemberLeft);
            this._client.addEventListener(PartyEvent.ON_PARTY_UPDATED, this.OnUpdated);
            this._client.addEventListener(PartyEvent.ON_PARTY_HP_UPDATED, this.OnHpUpdated);
        }

        private function OnPartyCreationResult(_arg_1:PartyEvent):void
        {
            this.UpdatePartyList();
        }

        private function OnMemberJoined(_arg_1:PartyEvent):void
        {
            this.UpdatePartyList();
        }

        private function OnMemberLeft(_arg_1:PartyEvent):void
        {
            this.UpdatePartyList();
        }

        private function OnUpdated(_arg_1:PartyEvent):void
        {
            this.UpdatePartyList();
        }

        public function UpdatePartyList():void
        {
            this._player = this._client.ActorList.GetPlayer();
            if (!this._player)
            {
                return;
            };
            this._partyInfo = this._player.Party;
            this._partyListPanel.SetData(this.GetDataArray());
        }

        private function GetDataArray():Array
        {
            var _local_2:Dictionary;
            var _local_3:PartyMember;
            var _local_1:Array = [];
            if (this._partyInfo)
            {
                _local_2 = this._partyInfo.PartyMembers;
                for each (_local_3 in _local_2)
                {
                    if (_local_3.CharacterId == this._player.characterId)
                    {
                        _local_1.push(_local_3);
                        break;
                    };
                };
                for each (_local_3 in _local_2)
                {
                    if (((!(_local_3.CharacterId == this._player.characterId)) && (_local_3.Online)))
                    {
                        _local_1.push(_local_3);
                    };
                };
                for each (_local_3 in _local_2)
                {
                    if (((!(_local_3.CharacterId == this._player.characterId)) && (!(_local_3.Online))))
                    {
                        _local_1.push(_local_3);
                    };
                };
            };
            return (_local_1);
        }

        private function OnHpUpdated(_arg_1:PartyEvent):void
        {
            if (!this._partyInfo)
            {
                return;
            };
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetActor(_arg_1.CharacterId);
            var _local_3:PartyMember = this._partyInfo.PartyMembers[_arg_1.CharacterId];
            if (((_local_2) && (_local_3)))
            {
                _local_3.Hp = _local_2.hp;
                _local_3.MaxHp = _local_2.maxHp;
                this._partyListPanel.UpdateHpForCharacter(_arg_1.CharacterId);
            };
        }

        private function OnLevelUpReceived(_arg_1:ActorStatsEvent):void
        {
            var _local_2:int = _arg_1.Actor.characterId;
            if (((this._partyInfo.PartyMembers[_local_2]) && (!(this._player.characterId == _local_2))))
            {
                this._partyListPanel.UpdateLevelFor(_local_2);
            };
        }

        public function GetUIComponent():DisplayObject
        {
            return (this._partyListPanel);
        }


    }
}//package hbm.Game.GUI.PartyList

