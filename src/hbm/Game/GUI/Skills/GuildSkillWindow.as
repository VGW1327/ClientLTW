


//hbm.Game.GUI.Skills.GuildSkillWindow

package hbm.Game.GUI.Skills
{
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Actors.SkillData;
    import hbm.Engine.Resource.SkillsResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.utils.Dictionary;
    import hbm.Game.GUI.DndTargets;
    import org.aswing.geom.IntPoint;
    import hbm.Game.GUI.*;

    public class GuildSkillWindow extends SkillWindow 
    {

        public function GuildSkillWindow()
        {
            super(false);
            SetTitle(ClientApplication.Localization.GUILD_WINDOW_SKILLS_TITLE);
        }

        override protected function RepaintSkills():void
        {
            var _local_1:CharacterInfo;
            var _local_4:Object;
            var _local_5:int;
            var _local_6:SkillData;
            var _local_7:GuildSkillItem;
            var _local_8:int;
            var _local_9:int;
            _panel.removeAll();
            _local_1 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_2:int = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerFraction();
            var _local_3:Dictionary = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills")).GetSkillsByJob(_local_1.clothesColor, 1000);
            for each (_local_4 in _local_3)
            {
                _local_5 = _local_4["Id"];
                _local_6 = _local_1.Skills[_local_5];
                if (_local_6 == null)
                {
                    _local_6 = new SkillData();
                    _local_6.Id = _local_5;
                    _local_6.Disabled = true;
                };
                _local_7 = new GuildSkillItem(_local_6, ((_local_2) ? 1 : 0));
                _local_8 = (int(_local_4["GuiX"]) * 16);
                _local_9 = (int(_local_4["GuiY"]) * 16);
                _local_7.putClientProperty(DndTargets.DND_TYPE, DndTargets.SKILL_ITEM);
                _local_7.setLocation(new IntPoint(_local_8, _local_9));
                _panel.append(_local_7);
            };
            _skillPoints.Value = _local_1.Guild.SkillPoints.toString();
        }


    }
}//package hbm.Game.GUI.Skills

