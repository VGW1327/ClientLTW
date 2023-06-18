


//hbm.Game.GUI.Skills.SkillItem

package hbm.Game.GUI.Skills
{
    import org.aswing.JPanel;
    import hbm.Engine.Actors.SkillData;
    import org.aswing.JLabelButton;
    import org.aswing.JCheckBox;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.JPopupMenu;
    import hbm.Game.GUI.Inventory.InventoryBar;
    import org.aswing.geom.IntDimension;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import flash.events.MouseEvent;
    import org.aswing.SoftBoxLayout;
    import org.aswing.event.DragAndDropEvent;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.HotKeys;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import flash.events.Event;
    import hbm.Engine.Resource.SkillsResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Actors.CharacterInfo;
    import org.aswing.AttachIcon;
    import flash.filters.ColorMatrixFilter;
    import flash.display.DisplayObject;
    import hbm.Engine.Renderer.RenderSystem;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Game.Character.Character;
    import org.aswing.dnd.DragManager;
    import hbm.Game.GUI.*;

    public class SkillItem extends JPanel 
    {

        protected var _skill:SkillData;
        private var _skillButton:JLabelButton;
        private var _cBox:JCheckBox;
        private var _toolTip:CustomToolTip;
        private var _menu:JPopupMenu;

        public function SkillItem(_arg_1:SkillData, _arg_2:Boolean=false)
        {
            var _local_5:InventoryBar;
            var _local_6:int;
            var _local_7:JPanel;
            super();
            this._skill = _arg_1;
            var _local_3:IntDimension = new IntDimension(32, 32);
            var _local_4:EmptyBorder = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            this._skillButton = new JLabelButton();
            this._skillButton.setIcon(this.Icon);
            this._skillButton.setSize(_local_3);
            this._skillButton.setPreferredSize(_local_3);
            this._skillButton.addEventListener(MouseEvent.CLICK, this.OnSkillButtonPressed, false, 0, true);
            setLayout(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0));
            setBorder(_local_4);
            setSize(_local_3);
            setDragEnabled(((!(this._skill.Disabled)) && (this._skill.Sp > 0)));
            addEventListener(DragAndDropEvent.DRAG_RECOGNIZED, this.OnStartDrag, false, 0, true);
            append(this._skillButton);
            if ((((_arg_2) && (!(this._skill.Disabled))) && (this._skill.Sp > 0)))
            {
                _local_5 = ClientApplication.Instance.BottomHUD.InventoryBarInstance;
                _local_6 = _local_5.GetSlotIndexForSkill(this._skill.Id);
                setSize(new IntDimension(50, 32));
                this._cBox = new JCheckBox();
                if (_local_6 >= 0)
                {
                    this._cBox.setSelected(true);
                };
                this._cBox.addSelectionListener(this.OnChangeState);
                _local_7 = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0));
                _local_7.setBorder(new EmptyBorder(null, new Insets(20, 2, 0, 0)));
                _local_7.append(this._cBox, SoftBoxLayout.LEFT);
                append(_local_7);
            };
            this.Revalidate();
        }

        public function get CheckBox():JCheckBox
        {
            return (this._cBox);
        }

        private function OnChangeState(_arg_1:Event):void
        {
            var _local_3:int;
            var _local_2:InventoryBar = ClientApplication.Instance.BottomHUD.InventoryBarInstance;
            if (this._cBox.isSelected())
            {
                _local_3 = _local_2.GetFirstEmptySlotIndex();
                if (_local_3 >= 0)
                {
                    ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys.SetHotKey(_local_3, HotKeys.HOTKEY_SKILL, this._skill.Id, this._skill.Lv);
                    ClientApplication.Instance.LocalGameClient.SendHotkey(_local_3, HotKeys.HOTKEY_SKILL, this._skill.Id, this._skill.Lv);
                    ClientApplication.Instance.RevalidateInventoryBar();
                    HelpManager.Instance.SetSkillHotKey(this._skill.Id);
                }
                else
                {
                    this._cBox.setSelected(false);
                };
            }
            else
            {
                _local_3 = _local_2.GetSlotIndexForSkill(this._skill.Id);
                if (_local_3 >= 0)
                {
                    ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys.RemoveHotKey(_local_3);
                    ClientApplication.Instance.LocalGameClient.SendHotkey(_local_3, 0, 0, 0);
                    ClientApplication.Instance.RevalidateInventoryBar();
                };
            };
        }

        public function Revalidate():void
        {
            if (this._toolTip)
            {
                this._toolTip.Dispose();
                this._toolTip = null;
            };
            this._toolTip = new CustomToolTip(this, this.SkillToolTip, 350);
        }

        public function get Name():String
        {
            var _local_1:Object = this.ClientSkillDescription;
            var _local_2:* = "?";
            if (_local_1 != null)
            {
                _local_2 = _local_1["Name"];
                if (!this._skill.Disabled)
                {
                    if (this._skill.Lv > 0)
                    {
                        _local_2 = (_local_2 + (((", " + this._skill.Lv.toString()) + "/") + _local_1["MaxLevel"]));
                    };
                };
            };
            return (_local_2);
        }

        public function get SoundEffect():String
        {
            var _local_1:Object = this.ClientSkillDescription;
            var _local_2:* = "?";
            if (_local_1 != null)
            {
                _local_2 = _local_1["SoundEffect"];
            };
            return (_local_2);
        }

        public function get ClientSkillDescription():Object
        {
            var _local_1:SkillsResourceLibrary = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_3:Object = _local_1.GetSkillsData(_local_2.clothesColor, _local_2.jobId, this._skill.Id);
            if (_local_3 == null)
            {
                _local_3 = _local_1.GetSkillsData(_local_2.clothesColor, 1000, this._skill.Id);
            };
            return (_local_3);
        }

        public function get Icon():AttachIcon
        {
            var _local_1:SkillsResourceLibrary;
            var _local_2:CharacterInfo;
            var _local_3:AttachIcon;
            var _local_5:Array;
            var _local_6:ColorMatrixFilter;
            _local_1 = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
            _local_2 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            _local_3 = new AttachIcon(_local_1.GetSkillIconRef(_local_2.clothesColor, this._skill.Id));
            var _local_4:DisplayObject = _local_3.getAsset();
            if (_local_4 != null)
            {
                if (this._skill.Disabled)
                {
                    _local_5 = [0.2, 0.2, 0.2, 0, 0, 0.2, 0.2, 0.2, 0, 0, 0.22, 0.22, 0.28, 0, 0, 0, 0, 0, 1, 0];
                    _local_6 = new ColorMatrixFilter(_local_5);
                    _local_4.filters = [_local_6];
                }
                else
                {
                    if (this._skill.Lv == 0)
                    {
                        _local_4.alpha = 0.36;
                    };
                };
            };
            return (_local_3);
        }

        public function get Skill():SkillData
        {
            return (this._skill);
        }

        protected function OnSkillButtonPressed(_arg_1:Event):void
        {
            if (!ClientApplication.Instance.limitClick)
            {
                return;
            };
            this._menu = new JPopupMenu();
            if (!this.Skill.Disabled)
            {
                if (this.Skill.Lv == 0)
                {
                    this._menu.addMenuItem(ClientApplication.Localization.SKILL_POPUP_LEARN).addActionListener(this.OnImproveSkill, 0, true);
                }
                else
                {
                    if (this.Skill.Lv < this.ClientSkillDescription["MaxLevel"])
                    {
                        this._menu.addMenuItem(ClientApplication.Localization.SKILL_POPUP_IMPROVE).addActionListener(this.OnImproveSkill, 0, true);
                    };
                    if (this.Skill.Sp > 0)
                    {
                        this._menu.addMenuItem(ClientApplication.Localization.SKILL_POPUP_USE).addActionListener(this.OnUseSkill, 0, true);
                    };
                };
            };
            this._menu.addMenuItem(ClientApplication.Localization.SKILL_POPUP_INFO).addActionListener(this.OnViewInfo, 0, true);
            this._menu.show(null, (stage.mouseX - 10), (stage.mouseY - 10));
            ClientApplication.Instance.limitClick = false;
        }

        public function Action(_arg_1:SkillItem):void
        {
            var _local_2:SkillItemPopup;
            _local_2 = new SkillItemPopup(_arg_1.Name, _arg_1);
            var _local_3:int = Math.min(stage.mouseX, (RenderSystem.Instance.ScreenWidth - _local_2.getWidth()));
            var _local_4:int = Math.min(stage.mouseY, (RenderSystem.Instance.ScreenHeight - _local_2.getHeight()));
            _local_2.setLocationXY(_local_3, _local_4);
            _local_2.show();
        }

        protected function OnViewInfo(_arg_1:Event):void
        {
            this.Action(this);
        }

        private function OnUseSkill(_arg_1:Event):void
        {
            var _local_5:SkillsResourceLibrary;
            var _local_7:SkillData;
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_3:int = _local_2.characterId;
            var _local_4:Character = CharacterStorage.Instance.SelectedCharacter;
            if (((!(_local_4 == null)) && (!(ClientApplication.Instance.IsShiftPressed))))
            {
                _local_3 = _local_4.CharacterId;
            };
            _local_5 = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
            var _local_6:int = _local_5.GetSkillTargetType(_local_2.clothesColor, _local_2.jobId, this.Skill.Id);
            if (_local_6 == SkillsResourceLibrary.TARGET_COORDINATES)
            {
                CharacterStorage.Instance.SkillPanelSlot = -1;
                CharacterStorage.Instance.SkillMode = this.Skill.Id;
                CharacterStorage.Instance.SkillLevel = this.Skill.Lv;
                _local_7 = (_local_2.Skills[this.Skill.Id] as SkillData);
                if (_local_7 != null)
                {
                    CharacterStorage.Instance.SkillRangeSqr = (_local_7.Range * _local_7.Range);
                }
                else
                {
                    CharacterStorage.Instance.SkillRangeSqr = 0;
                };
                if (CharacterStorage.Instance.SkillRangeSqr == 1)
                {
                    CharacterStorage.Instance.SkillRangeSqr = 17;
                };
            }
            else
            {
                ClientApplication.Instance.LocalGameClient.SendSkillUse(this.Skill.Id, this.Skill.Lv, _local_3);
                if (ClientApplication.Instance.GameSettings.IsPlaySoundsEnabled)
                {
                };
            };
        }

        private function OnImproveSkill(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendAddSkillPoint(this.Skill);
            HelpManager.Instance.LearnSkill(this.Skill.Id);
        }

        protected function OnStartDrag(_arg_1:DragAndDropEvent):void
        {
            DragManager.startDrag(_arg_1.getDragInitiator(), null, null, new SkillsDnd());
        }

        private function get SkillToolTip():String
        {
            var _local_3:String;
            var _local_1:* = (("<font color='#ffcc32'><b>" + this.Name) + "</b></font>");
            if (this.Skill.Lv == 0)
            {
                _local_1 = (_local_1 + ("<br>" + ClientApplication.Localization.SKILL_CAN_BE_LEARNED));
            };
            var _local_2:Object = this.ClientSkillDescription;
            if (_local_2)
            {
                _local_3 = _local_2["Description"];
                if (_local_3 != null)
                {
                    _local_1 = (_local_1 + ("<br><br>" + _local_3));
                };
            };
            return (_local_1);
        }


    }
}//package hbm.Game.GUI.Skills

