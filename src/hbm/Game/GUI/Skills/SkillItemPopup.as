


//hbm.Game.GUI.Skills.SkillItemPopup

package hbm.Game.GUI.Skills
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.AsWingManager;
    import org.aswing.JTextArea;
    import org.aswing.JScrollPane;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import org.aswing.JLabel;
    import org.aswing.geom.IntDimension;
    import hbm.Application.ClientApplication;
    import org.aswing.FlowLayout;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import flash.events.Event;
    import hbm.Engine.Resource.SkillsResourceLibrary;
    import hbm.Engine.Actors.SkillData;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Game.Character.Character;
    import hbm.Engine.Resource.ResourceManager;

    public class SkillItemPopup extends CustomWindow 
    {

        private const _width:int = 430;
        private const _height:int = 200;

        private var _skillItem:SkillItem;

        public function SkillItemPopup(_arg_1:String, _arg_2:SkillItem)
        {
            super(AsWingManager.getRoot(), _arg_1, true, this._width, this._height, true);
            this._skillItem = _arg_2;
            this.InitUI();
            pack();
        }

        private function InitUI():void
        {
            var _local_15:String;
            var _local_16:String;
            var _local_17:JTextArea;
            var _local_18:JScrollPane;
            var _local_19:CustomButton;
            var _local_20:CustomToolTip;
            var _local_21:CustomButton;
            var _local_22:CustomToolTip;
            var _local_23:CustomButton;
            var _local_24:CustomToolTip;
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4));
            var _local_3:JLabel = new JLabel("", this._skillItem.Icon);
            _local_3.setBorder(_local_1);
            _local_3.setPreferredSize(new IntDimension(64, 64));
            _local_2.append(_local_3);
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            _local_4.setBorder(_local_1);
            _local_4.setPreferredWidth(365);
            var _local_5:String = this._skillItem.Name;
            if (this._skillItem.Skill.Lv == 0)
            {
                _local_5 = (_local_5 + ("\n" + ClientApplication.Localization.SKILL_CAN_BE_LEARNED));
            };
            var _local_6:* = "";
            var _local_7:* = "";
            var _local_8:Array;
            if (((_local_5.length > 40) && (!(_local_5.indexOf("\n") > 0))))
            {
                _local_8 = _local_5.split(/ /);
                for each (_local_15 in _local_8)
                {
                    if ((_local_7.length + _local_15.length) > 40)
                    {
                        _local_6 = (_local_6 + (_local_7 + "\n"));
                        _local_7 = _local_15;
                    }
                    else
                    {
                        _local_7 = (_local_7 + (" " + _local_15));
                    };
                };
                _local_5 = (_local_6 + _local_7);
            };
            _local_4.append(new JLabel(_local_5, null, JLabel.LEFT));
            var _local_9:Object = this._skillItem.ClientSkillDescription;
            if (_local_9 != null)
            {
                _local_16 = _local_9["Description"];
                _local_17 = new JTextArea();
                _local_17.setHtmlText(_local_16);
                _local_17.setEditable(false);
                _local_17.setWordWrap(true);
                _local_17.setBackgroundDecorator(null);
                _local_17.getTextField().selectable = false;
                _local_18 = new JScrollPane(_local_17);
                _local_18.setPreferredHeight(124);
                _local_4.append(_local_18);
            };
            _local_2.append(_local_4);
            var _local_10:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 4));
            if (!this._skillItem.Skill.Disabled)
            {
                if (this._skillItem.Skill.Lv == 0)
                {
                    _local_19 = new CustomButton(ClientApplication.Localization.SKILL_POPUP_LEARN);
                    _local_20 = new CustomToolTip(_local_19, ClientApplication.Instance.GetPopupText(122), 140, 10);
                    _local_19.addActionListener(this.OnImproveSkill, 0, true);
                    _local_10.append(_local_19);
                }
                else
                {
                    _local_21 = new CustomButton(ClientApplication.Localization.SKILL_POPUP_IMPROVE);
                    _local_22 = new CustomToolTip(_local_21, ClientApplication.Instance.GetPopupText(123), 150, 10);
                    _local_21.addActionListener(this.OnImproveSkill, 0, true);
                    _local_21.setEnabled((this._skillItem.Skill.Lv < this._skillItem.ClientSkillDescription["MaxLevel"]));
                    _local_10.append(_local_21);
                    if (this._skillItem.Skill.Sp > 0)
                    {
                        _local_23 = new CustomButton(ClientApplication.Localization.SKILL_POPUP_USE);
                        _local_24 = new CustomToolTip(_local_23, ClientApplication.Instance.GetPopupText(124), 140, 10);
                        _local_23.addActionListener(this.OnUseSkill, 0, true);
                        _local_10.append(_local_23);
                    };
                };
            };
            var _local_11:CustomButton = new CustomButton(ClientApplication.Localization.BUTTON_CLOSE);
            _local_11.setToolTipText(ClientApplication.Instance.GetPopupText(2));
            _local_11.addActionListener(this.OnClose, 0, true);
            var _local_12:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
            _local_12.append(_local_11);
            setDefaultButton(_local_11);
            var _local_13:JPanel = new JPanel(new BorderLayout());
            _local_13.setBorder(new EmptyBorder(null, new Insets(4, 0, 0, 0)));
            _local_13.append(_local_10, BorderLayout.WEST);
            _local_13.append(_local_12, BorderLayout.EAST);
            var _local_14:JPanel = new JPanel(new BorderLayout());
            _local_14.setBorder(new EmptyBorder(null, new Insets(6, 4, 2, 4)));
            _local_14.append(_local_2, BorderLayout.CENTER);
            _local_14.append(_local_13, BorderLayout.PAGE_END);
            MainPanel.append(_local_14, BorderLayout.CENTER);
        }

        private function OnClose(_arg_1:Event):void
        {
            dispose();
        }

        private function OnUseSkill(_arg_1:Event):void
        {
            var _local_5:SkillsResourceLibrary;
            var _local_7:SkillData;
            var _local_8:Object;
            dispose();
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_3:int = _local_2.characterId;
            var _local_4:Character = CharacterStorage.Instance.SelectedCharacter;
            if (((!(_local_4 == null)) && (!(ClientApplication.Instance.IsShiftPressed))))
            {
                _local_3 = _local_4.CharacterId;
            };
            _local_5 = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
            var _local_6:int = _local_5.GetSkillTargetType(_local_2.clothesColor, _local_2.jobId, this._skillItem.Skill.Id);
            if (_local_6 == SkillsResourceLibrary.TARGET_COORDINATES)
            {
                CharacterStorage.Instance.SkillPanelSlot = -1;
                CharacterStorage.Instance.SkillMode = this._skillItem.Skill.Id;
                CharacterStorage.Instance.SkillLevel = this._skillItem.Skill.Lv;
                _local_7 = (_local_2.Skills[this._skillItem.Skill.Id] as SkillData);
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
                ClientApplication.Instance.LocalGameClient.SendSkillUse(this._skillItem.Skill.Id, this._skillItem.Skill.Lv, _local_3);
                _local_8 = _local_5.GetSkillsData(_local_2.clothesColor, _local_2.jobId, this._skillItem.Skill.Id);
                if (((ClientApplication.Instance.GameSettings.IsPlaySoundsEnabled) && (!(_local_8 == null))))
                {
                };
            };
        }

        private function OnImproveSkill(_arg_1:Event):void
        {
            dispose();
            ClientApplication.Instance.LocalGameClient.SendAddSkillPoint(this._skillItem.Skill);
        }


    }
}//package hbm.Game.GUI.Skills

