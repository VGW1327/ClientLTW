


//hbm.Game.GUI.Guild.GuildWindow

package hbm.Game.GUI.Guild
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Game.GUI.PaddedValue;
    import hbm.Application.ClientApplication;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.JPanel;
    import org.aswing.FlowLayout;
    import org.aswing.BorderLayout;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.JLabel;
    import org.aswing.JTabbedPane;
    import hbm.Engine.Actors.GuildInfo;
    import org.aswing.event.AWEvent;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import hbm.Game.GUI.*;

    public class GuildWindow extends CustomWindow 
    {

        private const _width:int = 525;
        private const _height:int = 475;

        private var _infoPanel:GuildInfoPanel;
        private var _membersPanel:GuildMembersPanel;
        private var _alliesPanel:GuildAlliesPanel;
        private var _guildSkillsButton:CustomButton;
        private var _guildNews:PaddedValue;
        private var _changeGuildInfo:CustomButton;
        private var _isGuildMaster:Boolean = false;

        public function GuildWindow(_arg_1:*=null)
        {
            super(_arg_1, ClientApplication.Localization.GUILD_WINDOW_TITLE, false, this._width, this._height, true);
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
            this.InitUI();
        }

        private function InitUI():void
        {
            var _local_4:CustomButton;
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            this._infoPanel = new GuildInfoPanel();
            this._membersPanel = new GuildMembersPanel(((_local_2) ? _local_2.clothesColor : 0));
            this._alliesPanel = new GuildAlliesPanel();
            this._guildSkillsButton = new CustomButton(ClientApplication.Localization.GUILD_WINDOW_SKILLS_TITLE);
            var _local_3:CustomToolTip = new CustomToolTip(this._guildSkillsButton, ClientApplication.Instance.GetPopupText(76), 145, 20);
            this._guildSkillsButton.addActionListener(this.OnGuildSkillsShow, 0, true);
            _local_4 = new CustomButton(ClientApplication.Localization.GUILD_WINDOW_BUTTON_LEAVE);
            var _local_5:CustomToolTip = new CustomToolTip(_local_4, ClientApplication.Instance.GetPopupText(77), 250, 40);
            _local_4.addActionListener(this.OnLeaveButtonPressed, 0, true);
            var _local_6:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 4));
            _local_6.append(this._guildSkillsButton);
            _local_6.append(_local_4);
            var _local_7:CustomButton = new CustomButton(ClientApplication.Localization.BUTTON_CLOSE);
            _local_7.setToolTipText(ClientApplication.Instance.GetPopupText(2));
            _local_7.addActionListener(this.OnCloseButtonPressed, 0, true);
            var _local_8:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
            _local_8.append(_local_7);
            var _local_9:JPanel = new JPanel(new BorderLayout());
            _local_9.append(_local_6, BorderLayout.WEST);
            _local_9.append(_local_8, BorderLayout.EAST);
            var _local_10:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2));
            _local_10.setBorder(new EmptyBorder(null, new Insets(8, 0, 5, 0)));
            this._changeGuildInfo = new CustomButton(ClientApplication.Localization.GUILD_WINDOW_BUTTON_EDIT);
            var _local_11:CustomToolTip = new CustomToolTip(this._changeGuildInfo, ClientApplication.Instance.GetPopupText(67), 240, 40);
            this._changeGuildInfo.addActionListener(this.OnGuildNewsEdit, 0, true);
            this._guildNews = new PaddedValue(ClientApplication.Localization.GUILD_WINDOW_NEWS_TITLE, "", 60, ((214 + 50) + 100));
            var _local_12:CustomToolTip = new CustomToolTip(this._guildNews, ClientApplication.Instance.GetPopupText(66), 250, 40);
            this._guildNews.SetPadding(JLabel.LEFT);
            _local_10.append(this._guildNews);
            _local_10.append(this._changeGuildInfo);
            var _local_13:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            _local_13.append(this._infoPanel);
            _local_13.append(_local_10);
            var _local_14:JTabbedPane = new JTabbedPane();
            _local_14.setBorder(_local_1);
            _local_14.appendTab(this._membersPanel, ClientApplication.Localization.GUILD_WINDOW_TAB_MEMBERS, null, ClientApplication.Instance.GetPopupText(68));
            _local_14.appendTab(this._alliesPanel, ClientApplication.Localization.GUILD_WINDOW_TAB_ALLIES, null, ClientApplication.Instance.GetPopupText(69));
            _local_13.append(_local_14);
            var _local_15:JPanel = new JPanel(new BorderLayout());
            _local_15.setBorder(new EmptyBorder(null, new Insets(6, 4, 0, 4)));
            _local_15.append(_local_13, BorderLayout.CENTER);
            _local_15.append(_local_9, BorderLayout.PAGE_END);
            MainPanel.append(_local_15, BorderLayout.CENTER);
            pack();
        }

        override public function show():void
        {
            var _local_1:GuildInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Guild;
            if (_local_1 != null)
            {
                this._isGuildMaster = _local_1.IsGuildMaster;
                this._membersPanel.DefaultSort();
            };
            super.show();
        }

        private function OnCloseButtonPressed(_arg_1:AWEvent):void
        {
            dispose();
        }

        private function OnGuildNewsEdit(_arg_1:AWEvent):void
        {
            if (this._isGuildMaster)
            {
                ClientApplication.Instance.SetShortcutsEnabled(false);
                new CustomOptionPane(JOptionPane.showInputDialog(ClientApplication.Localization.GUILD_WINDOW_EDIT_NEWS_TITLE1, ClientApplication.Localization.GUILD_WINDOW_EDIT_NEWS_MESSAGE1, this.OnGuildNewsEntered, "", null, true));
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.GUILD_WINDOW_EDIT_NEWS_TITLE2, ClientApplication.Localization.GUILD_WINDOW_EDIT_NEWS_MESSAGE2, null, null, true, new AttachIcon("AchtungIcon")));
            };
        }

        private function OnGuildNewsEntered(_arg_1:String):void
        {
            var _local_2:GuildInfo;
            ClientApplication.Instance.SetShortcutsEnabled(true);
            if (_arg_1 != null)
            {
                _local_2 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Guild;
                ClientApplication.Instance.LocalGameClient.SendGuildNotice(_local_2.Id, _local_2.MasterName, _arg_1);
            };
        }

        private function OnLeaveButtonPressed(_arg_1:AWEvent):void
        {
            var _local_2:GuildInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Guild;
            if (((_local_2.IsGuildMaster) && (_local_2.Members > 1)))
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.ERR_CRITICAL_ERROR_TITLE, ClientApplication.Localization.GUILD_WINDOW_LEAVE_MESSAGE1, null, null, true, new AttachIcon("AchtungIcon")));
            }
            else
            {
                ClientApplication.Instance.SetShortcutsEnabled(false);
                new CustomOptionPane(JOptionPane.showInputDialog(ClientApplication.Localization.GUILD_WINDOW_LEAVE_TITLE2, ClientApplication.Localization.GUILD_WINDOW_LEAVE_MESSAGE2, this.OnLeaveGuildReasonEntered, "", null, true));
            };
        }

        private function OnLeaveGuildReasonEntered(_arg_1:String):void
        {
            ClientApplication.Instance.SetShortcutsEnabled(true);
            if (_arg_1 != null)
            {
                ClientApplication.Instance.LocalGameClient.SendGuildLeave(_arg_1.substr(0, 38));
            };
        }

        private function OnGuildSkillsShow(_arg_1:AWEvent):void
        {
            var _local_2:GuildInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Guild;
            if (_local_2.IsGuildMaster)
            {
                ClientApplication.Instance.ShowGuildSkillsWindow();
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.GUILD_WINDOW_EDIT_SKILLS_TITLE, (((ClientApplication.Localization.GUILD_WINDOW_EDIT_SKILLS_MESSAGE + " '") + _local_2.MasterName) + "'"), null, null, true, new AttachIcon("StopIcon")));
            };
        }

        public function Revalidate():void
        {
            var _local_1:GuildInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Guild;
            if (_local_1 != null)
            {
                this._isGuildMaster = _local_1.IsGuildMaster;
                this._infoPanel.Revalidate();
                this._membersPanel.Revalidate();
                this._alliesPanel.Revalidate();
                this._guildNews.Value = _local_1.News;
                SetTitle(((ClientApplication.Localization.GUILD_WINDOW_TITLE + ": ") + _local_1.Name));
                this._guildSkillsButton.visible = _local_1.IsGuildMaster;
                this._changeGuildInfo.visible = _local_1.IsGuildMaster;
            }
            else
            {
                dispose();
            };
        }


    }
}//package hbm.Game.GUI.Guild

