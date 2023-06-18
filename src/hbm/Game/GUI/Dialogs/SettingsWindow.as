


//hbm.Game.GUI.Dialogs.SettingsWindow

package hbm.Game.GUI.Dialogs
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JCheckBox;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Application.ClientApplication;
    import org.aswing.JPanel;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.BorderLayout;
    import org.aswing.JLabel;
    import hbm.Application.ClientVersion;
    import flash.events.Event;
    import org.aswing.event.AWEvent;

    public class SettingsWindow extends CustomWindow 
    {

        public static const ON_SETTINGS_APPLIED:String = "ON_SETTINGS_APPLIED";
        public static const AUTO_ATTACK:int = 1;
        public static const GRAPHICS_QUALITY:int = 2;
        public static const FPS_COUNTER:int = 4;
        public static const PLAY_MUSIC:int = 8;
        public static const RELEASE_TIMER:int = 16;
        public static const PLAY_SOUNDS:int = 32;
        public static const DISABLE_OBJECTS_GLOW:int = 64;
        public static const DISABLE_VIEW_QUIP:int = 128;
        public static const DISABLE_BLINKING:int = 0x0100;
        public static const SHOW_GW_DAMAGE:int = 0x0200;
        public static const HIDE_GUILD_NOTICE:int = 0x0400;
        public static const DISABLE_SKILL_ANIMATION:int = 0x0800;
        public static const DISABLE_CHAT_HIDING:int = 0x1000;

        private const _width:int = 325;
        private const _height:int = 310;

        private var _autoAttack:JCheckBox;
        private var _graphicsQuality:JCheckBox;
        private var _playMusic:JCheckBox;
        private var _playSounds:JCheckBox;
        private var _fpsCounter:JCheckBox;
        private var _releaseTimerTimeout:JCheckBox;
        private var _enableObjectsGlow:JCheckBox;
        private var _enableBlinking:JCheckBox;
        private var _showGWDamage:JCheckBox;
        private var _showGuildNotice:JCheckBox;
        private var _enableSkillAnimation:JCheckBox;
        private var _enableHidingChat:JCheckBox;
        private var _button:CustomButton;

        public function SettingsWindow()
        {
            super(null, ClientApplication.Localization.DLG_SETTINGS_TITLE, false, this._width, this._height, true);
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, SoftBoxLayout.LEFT));
            var _local_2:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            var _local_3:EmptyBorder = new EmptyBorder(null, new Insets(0, 6, 0, 0));
            this._autoAttack = new JCheckBox(ClientApplication.Localization.DLG_SETTINGS_AUTO_ATTACK);
            this._autoAttack.setHorizontalAlignment(SoftBoxLayout.LEFT);
            this._autoAttack.setPreferredWidth(270);
            this._autoAttack.setSelected(true);
            this._autoAttack.setBorder(_local_3);
            var _local_4:CustomToolTip = new CustomToolTip(this._autoAttack, ClientApplication.Instance.GetPopupText(149), 225, 55);
            _local_1.append(this._autoAttack);
            this._graphicsQuality = new JCheckBox(ClientApplication.Localization.DLG_SETTINGS_GRAPHICS);
            this._graphicsQuality.setHorizontalAlignment(SoftBoxLayout.LEFT);
            this._graphicsQuality.setSelected(true);
            this._graphicsQuality.setBorder(_local_3);
            var _local_5:CustomToolTip = new CustomToolTip(this._graphicsQuality, ClientApplication.Instance.GetPopupText(150), 250, 70);
            _local_1.append(this._graphicsQuality);
            this._enableSkillAnimation = new JCheckBox(ClientApplication.Localization.DLG_SETTINGS_SKILL_ANIMATION);
            this._enableSkillAnimation.setHorizontalAlignment(SoftBoxLayout.LEFT);
            this._enableSkillAnimation.setSelected(true);
            this._enableSkillAnimation.setBorder(_local_3);
            var _local_6:CustomToolTip = new CustomToolTip(this._enableSkillAnimation, ClientApplication.Instance.GetPopupText(246), 250, 70);
            _local_1.append(this._enableSkillAnimation);
            this._playMusic = new JCheckBox(ClientApplication.Localization.DLG_SETTINGS_PLAY_MUSIC);
            this._playMusic.setHorizontalAlignment(SoftBoxLayout.LEFT);
            this._playMusic.setSelected(true);
            this._playMusic.setBorder(_local_3);
            var _local_7:CustomToolTip = new CustomToolTip(this._playMusic, ClientApplication.Instance.GetPopupText(153), 235, 40);
            _local_1.append(this._playMusic);
            this._playSounds = new JCheckBox(ClientApplication.Localization.DLG_SETTINGS_PLAY_SOUNDS);
            this._playSounds.setHorizontalAlignment(SoftBoxLayout.LEFT);
            this._playSounds.setSelected(true);
            this._playSounds.setBorder(_local_3);
            var _local_8:CustomToolTip = new CustomToolTip(this._playSounds, ClientApplication.Instance.GetPopupText(157), 235, 40);
            _local_1.append(this._playSounds);
            this._fpsCounter = new JCheckBox(ClientApplication.Localization.DLG_SETTINGS_FPS);
            this._fpsCounter.setHorizontalAlignment(SoftBoxLayout.LEFT);
            this._fpsCounter.setSelected(false);
            this._fpsCounter.setBorder(_local_3);
            var _local_9:CustomToolTip = new CustomToolTip(this._fpsCounter, ClientApplication.Instance.GetPopupText(151), 280, 40);
            _local_1.append(this._fpsCounter);
            this._releaseTimerTimeout = new JCheckBox(ClientApplication.Localization.DLG_SETTINGS_RELEASE_TIMER);
            this._releaseTimerTimeout.setHorizontalAlignment(SoftBoxLayout.LEFT);
            this._releaseTimerTimeout.setSelected(false);
            this._releaseTimerTimeout.setBorder(_local_3);
            var _local_10:CustomToolTip = new CustomToolTip(this._releaseTimerTimeout, ClientApplication.Instance.GetPopupText(154), 240, 60);
            _local_1.append(this._releaseTimerTimeout);
            this._enableObjectsGlow = new JCheckBox(ClientApplication.Localization.DLG_SETTINGS_OBJECT_GLOW);
            this._enableObjectsGlow.setHorizontalAlignment(SoftBoxLayout.LEFT);
            this._enableObjectsGlow.setSelected(true);
            this._enableObjectsGlow.setBorder(_local_3);
            var _local_11:CustomToolTip = new CustomToolTip(this._enableObjectsGlow, ClientApplication.Instance.GetPopupText(166), 240, 60);
            _local_1.append(this._enableObjectsGlow);
            this._enableBlinking = new JCheckBox(ClientApplication.Localization.DLG_SETTINGS_BLINKING);
            this._enableBlinking.setHorizontalAlignment(SoftBoxLayout.LEFT);
            this._enableBlinking.setSelected(true);
            this._enableBlinking.setBorder(_local_3);
            var _local_12:CustomToolTip = new CustomToolTip(this._enableBlinking, ClientApplication.Instance.GetPopupText(180), 240, 60);
            _local_1.append(this._enableBlinking);
            this._showGWDamage = new JCheckBox(ClientApplication.Localization.DLG_SETTINGS_SHOW_GW_DAMAGE);
            this._showGWDamage.setHorizontalAlignment(SoftBoxLayout.LEFT);
            this._showGWDamage.setSelected(false);
            this._showGWDamage.setBorder(_local_3);
            var _local_13:CustomToolTip = new CustomToolTip(this._showGWDamage, ClientApplication.Instance.GetPopupText(205), 250, 40);
            _local_1.append(this._showGWDamage);
            this._showGuildNotice = new JCheckBox(ClientApplication.Localization.DLG_SETTINGS_SHOW_GUILD_NOTICE);
            this._showGuildNotice.setHorizontalAlignment(SoftBoxLayout.LEFT);
            this._showGuildNotice.setSelected(false);
            this._showGuildNotice.setBorder(_local_3);
            var _local_14:CustomToolTip = new CustomToolTip(this._showGuildNotice, ClientApplication.Instance.GetPopupText(244), 0xFF, 60);
            _local_1.append(this._showGuildNotice);
            this._enableHidingChat = new JCheckBox(ClientApplication.Localization.DLG_SETTINGS_CHAT_HIDING);
            this._enableHidingChat.setHorizontalAlignment(SoftBoxLayout.LEFT);
            this._enableHidingChat.setSelected(true);
            this._enableHidingChat.setBorder(_local_3);
            var _local_15:CustomToolTip = new CustomToolTip(this._enableHidingChat, ClientApplication.Instance.GetPopupText(285), 250, 70);
            _local_1.append(this._enableHidingChat);
            _local_1.setBorder(_local_2);
            var _local_16:JPanel = new JPanel();
            _local_16.setLayout(new BorderLayout());
            _local_16.setBorder(new EmptyBorder(null, new Insets(6, 6, 4, 4)));
            var _local_17:JLabel = new JLabel(((ClientApplication.Localization.DLG_SETTINGS_VERSION + " ") + ClientVersion.CurrentVersion));
            _local_16.append(_local_17, BorderLayout.WEST);
            this._button = new CustomButton(ClientApplication.Localization.DLG_SETTINGS_APPLY_BUTTON);
            var _local_18:CustomToolTip = new CustomToolTip(this._button, ClientApplication.Instance.GetPopupText(144), 220, 20);
            this._button.addActionListener(this.OnApplyPressed, 0, true);
            _local_16.append(this._button, BorderLayout.EAST);
            var _local_19:JPanel = new JPanel(new BorderLayout());
            _local_19.setBorder(new EmptyBorder(null, new Insets(10, 6, 0, 0)));
            _local_19.append(_local_1, BorderLayout.CENTER);
            _local_19.append(_local_16, BorderLayout.PAGE_END);
            MainPanel.append(_local_19, BorderLayout.CENTER);
            pack();
            setDefaultButton(this._button);
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
        }

        public function get CurrentSettings():uint
        {
            return (((((((((((((this.IsAutoAttackEnabled) ? AUTO_ATTACK : 0) | ((this.IsHighQualityEnabled) ? GRAPHICS_QUALITY : 0)) | ((this.IsFPSEnabled) ? FPS_COUNTER : 0)) | ((this.IsPlayMusicEnabled) ? PLAY_MUSIC : 0)) | ((this.IsReleaseTimerEnabled) ? RELEASE_TIMER : 0)) | ((this.IsPlaySoundsEnabled) ? PLAY_SOUNDS : 0)) | ((this.IsObjectsGlowDisabled) ? DISABLE_OBJECTS_GLOW : 0)) | ((this.IsBlinkingDisabled) ? DISABLE_BLINKING : 0)) | ((this.IsShowGWDAmageEnabled) ? SHOW_GW_DAMAGE : 0)) | ((this.IsGuildNoticeDisabled) ? HIDE_GUILD_NOTICE : 0)) | ((this.IsSkillAnimationDisabled) ? DISABLE_SKILL_ANIMATION : 0)) | ((this.IsChatHidingDisabled) ? DISABLE_CHAT_HIDING : 0));
        }

        public function set CurrentSettings(_arg_1:uint):void
        {
            this._autoAttack.setSelected(((_arg_1 & AUTO_ATTACK) > 0));
            this._graphicsQuality.setSelected(((_arg_1 & GRAPHICS_QUALITY) > 0));
            this._fpsCounter.setSelected(((_arg_1 & FPS_COUNTER) > 0));
            this._playMusic.setSelected(((_arg_1 & PLAY_MUSIC) > 0));
            this._releaseTimerTimeout.setSelected(((_arg_1 & RELEASE_TIMER) > 0));
            this._playSounds.setSelected(((_arg_1 & PLAY_SOUNDS) > 0));
            this._enableObjectsGlow.setSelected((!((_arg_1 & DISABLE_OBJECTS_GLOW) > 0)));
            this._enableBlinking.setSelected((!((_arg_1 & DISABLE_BLINKING) > 0)));
            this._showGWDamage.setSelected(((_arg_1 & SHOW_GW_DAMAGE) > 0));
            this._showGuildNotice.setSelected((!((_arg_1 & HIDE_GUILD_NOTICE) > 0)));
            this._enableSkillAnimation.setSelected((!((_arg_1 & DISABLE_SKILL_ANIMATION) > 0)));
            this._enableHidingChat.setSelected((!((_arg_1 & DISABLE_CHAT_HIDING) > 0)));
            dispatchEvent(new Event(ON_SETTINGS_APPLIED));
        }

        public function get IsAutoAttackEnabled():Boolean
        {
            return (this._autoAttack.isSelected());
        }

        public function get IsHighQualityEnabled():Boolean
        {
            return (this._graphicsQuality.isSelected());
        }

        public function get IsPlayMusicEnabled():Boolean
        {
            return (this._playMusic.isSelected());
        }

        public function get IsPlaySoundsEnabled():Boolean
        {
            return (this._playSounds.isSelected());
        }

        public function get IsObjectsGlowDisabled():Boolean
        {
            return (!(this._enableObjectsGlow.isSelected()));
        }

        public function get IsBlinkingDisabled():Boolean
        {
            return (!(this._enableBlinking.isSelected()));
        }

        public function get IsChatHidingDisabled():Boolean
        {
            return (!(this._enableHidingChat.isSelected()));
        }

        public function get IsReleaseTimerEnabled():Boolean
        {
            return (this._releaseTimerTimeout.isSelected());
        }

        public function get IsFPSEnabled():Boolean
        {
            return (this._fpsCounter.isSelected());
        }

        public function get IsShowGWDAmageEnabled():Boolean
        {
            return (this._showGWDamage.isSelected());
        }

        public function get IsGuildNoticeDisabled():Boolean
        {
            return (!(this._showGuildNotice.isSelected()));
        }

        public function get IsSkillAnimationDisabled():Boolean
        {
            return (!(this._enableSkillAnimation.isSelected()));
        }

        private function OnApplyPressed(_arg_1:AWEvent):void
        {
            dispose();
            dispatchEvent(new Event(ON_SETTINGS_APPLIED));
        }


    }
}//package hbm.Game.GUI.Dialogs

