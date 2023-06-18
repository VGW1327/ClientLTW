


//hbm.Game.GUI.Guild.GuildInfoPanel

package hbm.Game.GUI.Guild
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Game.GUI.PaddedValue;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Application.ClientApplication;
    import org.aswing.geom.IntDimension;
    import org.aswing.BorderLayout;
    import hbm.Engine.Actors.GuildMember;
    import flash.display.Bitmap;
    import hbm.Engine.Actors.GuildInfo;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.AssetIcon;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import flash.events.Event;
    import hbm.Game.GUI.*;

    public class GuildInfoPanel extends JPanel 
    {

        private var _lvlUpButton:CustomButton;
        private var _emblemPanel:JPanel;
        private var _emblemId:int = 0;
        private var _emblem:PaddedValue;
        private var _emblemButton:CustomButton;
        private var _guildLv:PaddedValue;
        private var _guildMaster:PaddedValue;
        private var _guildOnlineCount:PaddedValue;
        private var _guildMaxCount:PaddedValue;
        private var _guildExp:PaddedValue;
        private var _guildNextExp:PaddedValue;
        private var _guildCash:PaddedValue;
        private var _levelPanel:JPanel;
        private var _emblemTip:CustomToolTip;
        private var _dataLibrary:AdditionalDataResourceLibrary;

        public function GuildInfoPanel()
        {
            super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            this.InitUI();
        }

        private function InitUI():void
        {
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            var _local_2:EmptyBorder = new EmptyBorder(null, new Insets(0, 5, 0, 0));
            setBorder(_local_1);
            var _local_3:* = 418;
            var _local_4:int = 100;
            this._emblem = new PaddedValue(ClientApplication.Localization.GUILD_WINDOW_LABEL_EMBLEM, "", (_local_3 - 20), _local_4);
            this._emblemButton = new CustomButton(null);
            this._emblemButton.setPreferredSize(new IntDimension(24, 24));
            this._emblemButton.setMaximumSize(new IntDimension(24, 24));
            this._emblemPanel = new JPanel(new BorderLayout());
            this._emblemPanel.setBorder(new EmptyBorder(null, new Insets(5, 5, 0, 0)));
            this._emblemPanel.append(this._emblem, BorderLayout.WEST);
            this._emblemPanel.append(this._emblemButton, BorderLayout.EAST);
            this._guildLv = new PaddedValue(ClientApplication.Localization.GUILD_WINDOW_LABEL_LV, "", (_local_3 - 20), _local_4);
            var _local_5:CustomToolTip = new CustomToolTip(this._guildLv, ClientApplication.Instance.GetPopupText(60), 220, 40);
            this._levelPanel = new JPanel(new BorderLayout());
            this._levelPanel.append(this._guildLv, BorderLayout.WEST);
            this._levelPanel.setBorder(_local_2);
            this._guildMaster = new PaddedValue(ClientApplication.Localization.GUILD_WINDOW_LABEL_MASTER, "", _local_3, _local_4);
            var _local_6:CustomToolTip = new CustomToolTip(this._guildMaster, ClientApplication.Instance.GetPopupText(61), 125, 20);
            this._guildOnlineCount = new PaddedValue(ClientApplication.Localization.GUILD_WINDOW_LABEL_ONLINE_PART1, "", _local_3, _local_4);
            var _local_7:CustomToolTip = new CustomToolTip(this._guildOnlineCount, ClientApplication.Instance.GetPopupText(62), 220, 10);
            this._guildMaxCount = new PaddedValue(ClientApplication.Localization.GUILD_WINDOW_LABEL_MAXMEMBERS, "", _local_3, _local_4);
            var _local_8:CustomToolTip = new CustomToolTip(this._guildMaxCount, ClientApplication.Instance.GetPopupText(63), 250, 10);
            this._guildCash = new PaddedValue(ClientApplication.Localization.GUILD_WINDOW_LABEL_CASH, "", (_local_3 - 13), _local_4, 1);
            var _local_9:CustomToolTip = new CustomToolTip(this._guildCash, ClientApplication.Instance.GetPopupText(245), 250, 20);
            this._guildExp = new PaddedValue(ClientApplication.Localization.GUILD_WINDOW_LABEL_EXP, "", _local_3, _local_4);
            var _local_10:CustomToolTip = new CustomToolTip(this._guildExp, ClientApplication.Instance.GetPopupText(64), 220, 40);
            this._guildNextExp = new PaddedValue(ClientApplication.Localization.GUILD_WINDOW_LABEL_NEXT_EXP, "", _local_3, _local_4);
            var _local_11:CustomToolTip = new CustomToolTip(this._guildNextExp, ClientApplication.Instance.GetPopupText(65), 220, 55);
            append(this._emblemPanel);
            append(this._levelPanel);
            append(this._guildMaster);
            append(this._guildOnlineCount);
            append(this._guildMaxCount);
            append(this._guildExp);
            append(this._guildNextExp);
            append(this._guildCash);
        }

        public function Revalidate():void
        {
            var _local_3:GuildMember;
            var _local_4:Bitmap;
            var _local_5:Bitmap;
            var _local_6:Bitmap;
            var _local_7:CustomToolTip;
            var _local_1:GuildInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Guild;
            if (_local_1 == null)
            {
                return;
            };
            if (this._dataLibrary == null)
            {
                this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            };
            this.RevalidateEmblem(_local_1.Emblem);
            if (((!(this._dataLibrary == null)) && (this._lvlUpButton == null)))
            {
                _local_4 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_HealButton");
                _local_5 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_HealButtonSelected");
                _local_6 = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_HealButtonPressed");
                this._lvlUpButton = new CustomButton(null);
                this._lvlUpButton.setIcon(new AssetIcon(_local_4));
                this._lvlUpButton.setRollOverIcon(new AssetIcon(_local_5));
                this._lvlUpButton.setPressedIcon(new AssetIcon(_local_6));
                this._lvlUpButton.setSize(new IntDimension(16, 16));
                this._lvlUpButton.setBackgroundDecorator(null);
                this._lvlUpButton.addActionListener(this.OnGuildLvlUpClick, 0, true);
                _local_7 = new CustomToolTip(this._lvlUpButton, ClientApplication.Instance.GetPopupText(167), 240, 20);
                this._levelPanel.append(this._lvlUpButton, BorderLayout.EAST);
            };
            if (_local_1.IsGuildMaster)
            {
                this._emblemButton.addActionListener(this.OnChangeEmblemClick, 0, true);
                this._emblemTip = new CustomToolTip(this._emblemButton, ClientApplication.Instance.GetPopupText(206), 210, 30);
            };
            var _local_2:int;
            for each (_local_3 in _local_1.members)
            {
                if (_local_3.online != 0)
                {
                    _local_2++;
                };
            };
            this._guildLv.Value = _local_1.Lv.toString();
            this._guildMaster.Value = _local_1.MasterName;
            this._guildOnlineCount.Value = ((_local_2.toString() + ClientApplication.Localization.GUILD_WINDOW_LABEL_ONLINE_PART2) + _local_1.Members.toString());
            this._guildMaxCount.Value = _local_1.MaxMembers.toString();
            this._guildExp.Value = _local_1.Exp.toString();
            this._guildNextExp.Value = _local_1.NextExp.toString();
            this._guildCash.Value = _local_1.GuildCash.toString();
        }

        private function RevalidateEmblem(_arg_1:int):void
        {
            var _local_2:Bitmap;
            if (this._emblemId == _arg_1)
            {
                return;
            };
            if (this._dataLibrary == null)
            {
                return;
            };
            this._emblemId = _arg_1;
            if (_arg_1 > 0)
            {
                _local_2 = this._dataLibrary.GetBitmap("guild", _arg_1.toString());
                if (_local_2 != null)
                {
                    this._emblemButton.setIcon(new AssetIcon(_local_2));
                    this._emblemButton.setRollOverIcon(new AssetIcon(_local_2));
                    this._emblemButton.setPressedIcon(new AssetIcon(_local_2));
                    this._emblemButton.setPreferredSize(new IntDimension(_local_2.width, _local_2.height));
                    this._emblemButton.setMaximumSize(new IntDimension(_local_2.width, _local_2.height));
                    this._emblemButton.setBackgroundDecorator(null);
                };
            }
            else
            {
                this._emblemPanel.remove(this._emblemButton);
                if (this._emblemTip)
                {
                    this._emblemTip.disposeToolTip();
                };
                this._emblemButton = new CustomButton(null);
                this._emblemButton.setPreferredSize(new IntDimension(24, 24));
                this._emblemButton.setMaximumSize(new IntDimension(24, 24));
                this._emblemPanel.append(this._emblemButton, BorderLayout.EAST);
            };
        }

        private function OnGuildLvlUpClick(evt:Event):void
        {
            var priceArray:Array;
            var priceInCols:String;
            var guild:GuildInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Guild;
            if (guild.Lv < 50)
            {
                priceArray = [10, 20, 30, 60, 90, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1200, 1400, 1600, 1800, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7000, 7500, 8000, 8500, 9000, 9500, 10000, 11000, 12000, 13000, 14000, 15000, 30000, 45000, 60000, 75000, 90000, 120000, 150000, 180000, 300000];
                priceInCols = int(priceArray[guild.Lv]).toString();
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ((ClientApplication.Localization.CASH_GUILD_LEVEL_UP_MESSAGE + " ") + priceInCols), function OnOperationAccepted (_arg_1:int):void
                {
                    if (_arg_1 == JOptionPane.YES)
                    {
                        ClientApplication.Instance.LocalGameClient.SendChatMessage("@cashguildlvlup");
                        Revalidate();
                    };
                }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.CASH_GUILD_LEVEL_UP_LIMIT, null, null, true, new AttachIcon("AchtungIcon")));
            };
        }

        private function OnChangeEmblemClick(_arg_1:Event):void
        {
            ClientApplication.Instance.ShowEmblemWindow();
        }


    }
}//package hbm.Game.GUI.Guild

