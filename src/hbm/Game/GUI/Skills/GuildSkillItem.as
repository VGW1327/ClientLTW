


//hbm.Game.GUI.Skills.GuildSkillItem

package hbm.Game.GUI.Skills
{
    import hbm.Engine.Actors.SkillData;
    import hbm.Engine.Resource.SkillsResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;

    public class GuildSkillItem extends SkillItem 
    {

        private var _clothesColor:int = 0;

        public function GuildSkillItem(_arg_1:SkillData, _arg_2:int)
        {
            this._clothesColor = _arg_2;
            super(_arg_1, true);
        }

        override public function get ClientSkillDescription():Object
        {
            var _local_1:SkillsResourceLibrary = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
            return (_local_1.GetSkillsData(this._clothesColor, 1000, _skill.Id));
        }


    }
}//package hbm.Game.GUI.Skills

