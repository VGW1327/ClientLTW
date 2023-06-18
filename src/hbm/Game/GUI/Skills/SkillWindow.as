


//hbm.Game.GUI.Skills.SkillWindow

package hbm.Game.GUI.Skills
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import flash.display.DisplayObject;
    import org.aswing.JPanel;
    import hbm.Game.GUI.PaddedValue;
    import hbm.Application.ClientApplication;
    import org.aswing.geom.IntDimension;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.EmptyLayout;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.JButton;
    import org.aswing.FlowLayout;
    import org.aswing.BorderLayout;
    import org.aswing.JOptionPane;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import mx.utils.StringUtil;
    import org.aswing.AttachIcon;
    import flash.events.Event;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import hbm.Engine.Resource.SkillsResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.utils.getDefinitionByName;
    import org.aswing.AssetBackground;
    import hbm.Engine.Actors.SkillData;
    import flash.utils.Dictionary;
    import hbm.Game.GUI.DndTargets;
    import org.aswing.geom.IntPoint;
    import hbm.Game.GUI.*;

    public class SkillWindow extends CustomWindow 
    {

        private var _currentBackgroundRef:String;
        private var _currentBackground:DisplayObject;
        protected var _panel:JPanel;
        private var _skillItems:Object = {};
        protected var _skillPoints:PaddedValue;
        private var _resetCost:int = 50000;
        private var _resetable:Boolean = true;
        private var _jobBar:JobExpBar;

        public function SkillWindow(_arg_1:Boolean=true)
        {
            super(owner, ClientApplication.Localization.WINDOW_CHARACTER_SKILLS_TITLE, false, this.WidthWindow, this.HeightWindow, true);
            this._resetable = _arg_1;
            this.InitUI();
        }

        protected function get SizeBG():IntDimension
        {
            return (new IntDimension(288, 384));
        }

        protected function get WidthWindow():int
        {
            return (275);
        }

        protected function get HeightWindow():int
        {
            return (405);
        }

        private function InitUI():void
        {
            var _local_2:JPanel;
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            _local_2 = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            _local_2.setBorder(new EmptyBorder(null, new Insets(10, 0, 0, 0)));
            this._panel = new JPanel(new EmptyLayout());
            this._panel.setPreferredSize(this.SizeBG);
            _local_2.append(this._panel);
            var _local_3:int = ((this._resetable) ? (this.WidthWindow - 125) : (this.WidthWindow - 45));
            this._skillPoints = new PaddedValue(ClientApplication.Localization.WINDOW_CHARACTER_SKILL_POINTS, "0", _local_3, 50);
            var _local_4:CustomToolTip = new CustomToolTip(this._skillPoints, ClientApplication.Instance.GetPopupText(59), 280, 20);
            var _local_5:JButton = new JButton(ClientApplication.Localization.WINDOW_CHARACTER_RESET_POINTS);
            _local_5.setPreferredWidth(74);
            _local_5.addActionListener(this.OnResetStatsPressed);
            new CustomToolTip(_local_5, ClientApplication.Instance.GetPopupText(248), 170, 70);
            var _local_6:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0, false));
            _local_6.setBorder(_local_1);
            _local_6.append(this._skillPoints);
            var _local_7:JPanel = new JPanel(new SoftBoxLayout(0, 5));
            _local_7.append(_local_6);
            if (this._resetable)
            {
                _local_7.append(_local_5);
            };
            _local_2.append(_local_7);
            if (this._resetable)
            {
                this._jobBar = new JobExpBar();
                this._jobBar.x = (this.WidthWindow / 2);
                this._jobBar.y = 15;
                _local_2.addChild(this._jobBar);
            };
            MainPanel.append(_local_2, BorderLayout.CENTER);
            pack();
            setLocationXY(((ClientApplication.stageWidth - this.WidthWindow) / 2), ((0x0300 - this.HeightWindow) / 2));
        }

        private function OnResetStatsPressed(event:Event):void
        {
            var handler:Function = function (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    PerformStatReset();
                };
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.RESET_STATS_DIALOG_TITLE, StringUtil.substitute(ClientApplication.Localization.RESET_STATS_DIALOG_INFO, this._resetCost), handler, null, false, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
        }

        private function PerformStatReset():void
        {
            var _local_1:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            if (_local_1.money > this._resetCost)
            {
                ClientApplication.Instance.LocalGameClient.SendRemoteNPCClick("GeneralNPC_ReloadSkills");
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.RESET_STATS_DIALOG_TITLE, ClientApplication.Localization.RESET_FAILED_DIALOG_INFO, null, null, false, new AttachIcon("AchtungIcon")));
            };
        }

        override public function show():void
        {
            ClientApplication.Instance.BottomHUD.BlinkCharacterSkills(false);
            if (this._currentBackgroundRef == null)
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.JOB_NOT_IMPLEMENTED_TITLE, ClientApplication.Localization.JOB_NOT_IMPLEMENTED_MESSAGE, null, null, true, new AttachIcon("AchtungIcon")));
            }
            else
            {
                super.show();
                HelpManager.Instance.SkillsPressed();
            };
            HelpManager.Instance.UpdateSkillHelper();
        }

        override public function dispose():void
        {
            super.dispose();
            HelpManager.Instance.UpdateSkillHelper();
        }

        public function RevalidateSkills(clothesColor:int, jobId:int):void
        {
            var classIcon:Class;
            if (jobId == 0)
            {
                return;
            };
            this.RepaintSkills();
            var classBackgroundRef:String = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills")).GetSkillBackgroundRef(clothesColor, jobId);
            if (classBackgroundRef != null)
            {
                if (classBackgroundRef === this._currentBackgroundRef)
                {
                    return;
                };
                this._currentBackgroundRef = classBackgroundRef;
                try
                {
                    classIcon = (getDefinitionByName(classBackgroundRef) as Class);
                    this._currentBackground = new (classIcon)();
                    this._panel.setBackgroundDecorator(new AssetBackground(this._currentBackground));
                }
                catch(e:ReferenceError)
                {
                    _currentBackgroundRef = null;
                };
            };
        }

        public function GetSkillItem(_arg_1:uint):SkillItem
        {
            return (this._skillItems[_arg_1]);
        }

        protected function RepaintSkills():void
        {
            var _local_1:CharacterInfo;
            var _local_3:Object;
            var _local_4:int;
            var _local_5:SkillData;
            var _local_6:SkillItem;
            var _local_7:int;
            var _local_8:int;
            this._panel.removeAll();
            this._skillItems = {};
            _local_1 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_2:Dictionary = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills")).GetSkillsByJob(_local_1.clothesColor, _local_1.jobId);
            for each (_local_3 in _local_2)
            {
                _local_4 = int(_local_3["Id"]);
                _local_5 = _local_1.Skills[_local_4];
                if (_local_5 == null)
                {
                    _local_5 = new SkillData();
                    _local_5.Id = int(_local_4);
                    _local_5.Disabled = true;
                }
                else
                {
                    _local_5.Disabled = (_local_3["TemporaryDisabled"] == 1);
                };
                _local_6 = new SkillItem(_local_5, true);
                _local_7 = (int(_local_3["GuiX"]) * 16);
                _local_8 = (int(_local_3["GuiY"]) * 16);
                _local_6.putClientProperty(DndTargets.DND_TYPE, DndTargets.SKILL_ITEM);
                _local_6.setLocation(new IntPoint(_local_7, _local_8));
                this._panel.append(_local_6);
                this._skillItems[_local_4] = _local_6;
            };
            this._skillPoints.Value = _local_1.skillPoint.toString();
            HelpManager.Instance.UpdateSkillHelper();
        }

        public function UpdateSkillPoints(_arg_1:int):void
        {
            this._skillPoints.Value = _arg_1.toString();
        }

        public function RevalidateStats(_arg_1:CharacterInfo):void
        {
            this._jobBar._text.text = _arg_1.jobLevel.toString();
            this._jobBar._progress.scaleX = ClientApplication.Instance.BottomHUD.GetBottomHUD._jobLevelBar._progressMask.scaleX;
        }


    }
}//package hbm.Game.GUI.Skills

