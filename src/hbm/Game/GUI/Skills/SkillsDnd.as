


//hbm.Game.GUI.Skills.SkillsDnd

package hbm.Game.GUI.Skills
{
    import org.aswing.dnd.DragListener;
    import org.aswing.event.DragAndDropEvent;
    import org.aswing.Component;
    import hbm.Game.GUI.DndTargets;
    import org.aswing.dnd.DragManager;
    import org.aswing.dnd.RejectedMotion;
    import hbm.Application.ClientApplication;
    import org.aswing.JPanel;
    import hbm.Engine.Actors.HotKeys;

    public class SkillsDnd implements DragListener 
    {


        public function onDragStart(_arg_1:DragAndDropEvent):void
        {
        }

        public function onDragEnter(_arg_1:DragAndDropEvent):void
        {
        }

        public function onDragOverring(_arg_1:DragAndDropEvent):void
        {
        }

        public function onDragExit(_arg_1:DragAndDropEvent):void
        {
        }

        public function onDragDrop(_arg_1:DragAndDropEvent):void
        {
            var _local_2:Component;
            _local_2 = _arg_1.getTargetComponent();
            var _local_3:Component = _arg_1.getDragInitiator();
            var _local_4:int = ((_local_2) ? _local_2.getClientProperty(DndTargets.DND_TYPE, DndTargets.NOTHING) : DndTargets.NOTHING);
            var _local_5:int = _local_3.getClientProperty(DndTargets.DND_TYPE);
            if (_local_5 == DndTargets.SKILL_ITEM)
            {
                switch (_local_4)
                {
                    case DndTargets.INVENTORY_BAR_SLOT:
                        this.SkillDroppedOnBar(_local_3, _local_2);
                        break;
                    case DndTargets.NOTHING:
                        DragManager.setDropMotion(new RejectedMotion());
                        break;
                };
            }
            else
            {
                if (_local_5 == DndTargets.INVENTORY_SKILL_ITEM)
                {
                    if (!ClientApplication.Instance.BottomHUD.IsLocked)
                    {
                        this.RemoveBarItem(_local_3);
                    }
                    else
                    {
                        DragManager.setDropMotion(new RejectedMotion());
                    };
                }
                else
                {
                    DragManager.setDropMotion(new RejectedMotion());
                };
            };
        }

        private function SkillDroppedOnBar(_arg_1:Component, _arg_2:Component):void
        {
            var _local_3:JPanel;
            _local_3 = JPanel(_arg_2);
            var _local_4:SkillItem = SkillItem(_arg_1);
            var _local_5:int = _local_3.getClientProperty(DndTargets.DND_INDEX);
            ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys.SetHotKey(_local_5, HotKeys.HOTKEY_SKILL, _local_4.Skill.Id, _local_4.Skill.Lv);
            ClientApplication.Instance.LocalGameClient.SendHotkey(_local_5, HotKeys.HOTKEY_SKILL, _local_4.Skill.Id, _local_4.Skill.Lv);
            ClientApplication.Instance.RevalidateInventoryBar();
        }

        private function RemoveBarItem(_arg_1:Component):void
        {
            var _local_2:SkillItem;
            var _local_4:int;
            _local_2 = SkillItem(_arg_1);
            var _local_3:JPanel = _local_2.getClientProperty(DndTargets.DND_SLOT);
            if (_local_3 != null)
            {
                _local_4 = _local_3.getClientProperty(DndTargets.DND_INDEX);
                ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys.RemoveHotKey(_local_4);
                ClientApplication.Instance.LocalGameClient.SendHotkey(_local_4, 0, 0, 0);
                ClientApplication.Instance.RevalidateInventoryBar();
            };
        }


    }
}//package hbm.Game.GUI.Skills

