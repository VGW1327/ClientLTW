


//hbm.Game.GUI.Book.SkillDescription

package hbm.Game.GUI.Book
{
    import hbm.Game.GUI.Skills.SkillItem;
    import hbm.Engine.Actors.SkillData;
    import hbm.Engine.Resource.SkillsResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.CharacterInfo;
    import org.aswing.AttachIcon;

    public class SkillDescription extends SkillItem 
    {

        private var _clothes:int;
        private var _jobId:int;

        public function SkillDescription(_arg_1:int, _arg_2:int, _arg_3:int)
        {
            var _local_4:SkillData = new SkillData();
            _local_4.Id = _arg_1;
            _local_4.Lv = -1;
            _local_4.Disabled = true;
            this._clothes = _arg_2;
            this._jobId = _arg_3;
            super(_local_4);
        }

        override public function get ClientSkillDescription():Object
        {
            var _local_1:SkillsResourceLibrary = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_3:Object = _local_1.GetSkillsData(this._clothes, this._jobId, _skill.Id);
            if (_local_3 == null)
            {
                _local_3 = _local_1.GetSkillsData(_local_2.clothesColor, 1000, _skill.Id);
            };
            return (_local_3);
        }

        override public function get Icon():AttachIcon
        {
            var _local_1:SkillsResourceLibrary;
            _local_1 = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
            return (new AttachIcon(_local_1.GetSkillIconRef(this._clothes, _skill.Id)));
        }


    }
}//package hbm.Game.GUI.Book

