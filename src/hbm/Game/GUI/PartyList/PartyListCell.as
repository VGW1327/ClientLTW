


//hbm.Game.GUI.PartyList.PartyListCell

package hbm.Game.GUI.PartyList
{
    import org.aswing.ListCell;
    import hbm.Engine.Actors.PartyMember;
    import org.aswing.Component;
    import hbm.Application.ClientApplication;
    import org.aswing.JList;

    public class PartyListCell implements ListCell 
    {

        private var _partyMemberInfo:PartyMember;
        private var _cellPanel:PartyMemberPanel;

        public function PartyListCell()
        {
            this._cellPanel = new PartyMemberPanel();
        }

        public function getCellValue():*
        {
            return (this._partyMemberInfo);
        }

        public function getCellComponent():Component
        {
            return (this._cellPanel);
        }

        public function setCellValue(_arg_1:*):void
        {
            if ((_arg_1 is PartyMember))
            {
                this._partyMemberInfo = _arg_1;
                this.SetData(_arg_1);
            }
            else
            {
                throw (new ArgumentError("Data value for partyList should be of the 'Party Member' type!"));
            };
        }

        public function SetData(_arg_1:PartyMember):void
        {
            this._cellPanel.SetIfLeader(this._partyMemberInfo.Leader);
            this._cellPanel.SetOnline(this._partyMemberInfo.Online);
            this.UpdateHP();
            this.UpdateTextFields();
        }

        public function UpdateHP():void
        {
            var _local_1:int;
            if (this._partyMemberInfo.MaxHp != 0)
            {
                _local_1 = int(((100 * this._partyMemberInfo.Hp) / this._partyMemberInfo.MaxHp));
                this._cellPanel.SetMaxHP(100);
                this._cellPanel.SetCurrentHP(_local_1);
            }
            else
            {
                this._cellPanel.ClearHP();
            };
        }

        public function UpdateTextFields():void
        {
            this._cellPanel.SetName(this._partyMemberInfo.Name);
            var _local_1:int = ClientApplication.Instance.LocalGameClient.ActorList.GetActor(this._partyMemberInfo.CharacterId).baseLevel;
            this._cellPanel.SetLevel(_local_1);
            if (_local_1 > 0)
            {
                this.SetDefaultHp();
            };
        }

        private function SetDefaultHp():void
        {
            if (this._partyMemberInfo.MaxHp == 0)
            {
                this._cellPanel.SetMaxHP(100);
                this._cellPanel.SetCurrentHP(100);
            };
        }

        public function setListCellStatus(_arg_1:JList, _arg_2:Boolean, _arg_3:int):void
        {
        }


    }
}//package hbm.Game.GUI.PartyList

