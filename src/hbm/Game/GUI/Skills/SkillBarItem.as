


//hbm.Game.GUI.Skills.SkillBarItem

package hbm.Game.GUI.Skills
{
    import hbm.Engine.Actors.SkillData;
    import hbm.Game.GUI.DndTargets;
    import org.aswing.JPanel;
    import hbm.Application.ClientApplication;
    import flash.events.Event;

    public class SkillBarItem extends SkillItem 
    {

        public function SkillBarItem(_arg_1:SkillData)
        {
            super(_arg_1);
        }

        override protected function OnSkillButtonPressed(_arg_1:Event):void
        {
            var _local_3:int;
            var _local_2:JPanel = getClientProperty(DndTargets.DND_SLOT);
            if (_local_2 != null)
            {
                _local_3 = _local_2.getClientProperty(DndTargets.DND_INDEX);
                ClientApplication.Instance.BottomHUD.InventoryBarInstance.UseHotkey(_local_3);
            };
        }

        override public function Revalidate():void
        {
            setToolTipText(Name);
        }


    }
}//package hbm.Game.GUI.Skills

