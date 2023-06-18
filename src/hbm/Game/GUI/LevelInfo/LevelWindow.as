


//hbm.Game.GUI.LevelInfo.LevelWindow

package hbm.Game.GUI.LevelInfo
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JPanel;
    import flash.display.DisplayObject;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.JLabel;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.Bitmap;
    import org.aswing.EmptyLayout;
    import org.aswing.AssetBackground;
    import org.aswing.SoftBoxLayout;
    import org.aswing.geom.IntDimension;
    import org.aswing.geom.IntPoint;
    import org.aswing.AssetIcon;
    import org.aswing.ASFont;
    import hbm.Engine.Actors.Actors;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Game.Character.Character;
    import hbm.Game.Utility.HtmlText;
    import flash.utils.getDefinitionByName;
    import flash.events.Event;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;

    public class LevelWindow extends CustomWindow 
    {

        private const _width:int = 247;
        private const _height:int = 180;

        private var _panel:JPanel;
        private var _avatarIconRef:String;
        private var _avatarIcon:DisplayObject;
        private var _avatarPanel:JPanel;
        private var _lvlUpButton:CustomButton;
        private var _jobUpButton:CustomButton;
        private var _nameEditButton:CustomButton;
        private var _jobEditButton:CustomButton;
        private var _lvlBaseExpPanel:JPanel;
        private var _lvlJobExpPanel:JPanel;
        private var _nameText:JLabel;
        private var _jobText:JLabel;
        private var _baseLvlText:JLabel;
        private var _jobLvlText:JLabel;
        private var _baseLvlProgressText:JLabel;
        private var _jobLvlProgressText:JLabel;
        private var _premiumText:JLabel;
        private var _premiumUntilText:JLabel;
        private var _lvlUpTip1:CustomToolTip;
        private var _lvlUpTip2:CustomToolTip;
        private var _jobUpTip1:CustomToolTip;
        private var _jobUpTip2:CustomToolTip;

        public function LevelWindow()
        {
            super(null, ClientApplication.Localization.LEVEL_WINDOW_TITLE, false, this._width, this._height, true);
            this.InitUI();
            pack();
            setLocationXY(200, 200);
        }

        private function InitUI():void
        {
            var _local_4:AdditionalDataResourceLibrary;
            var _local_1:JPanel = new JPanel(new BorderLayout());
            _local_1.setBorder(new EmptyBorder(null, new Insets(6, 6, 4, 4)));
            var _local_2:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            var _local_3:EmptyBorder = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            _local_4 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_5:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlupBackg");
            var _local_6:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlupButton");
            var _local_7:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlupButtonSelected");
            var _local_8:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlupButtonPressed");
            var _local_9:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlupButton");
            var _local_10:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlupButtonSelected");
            var _local_11:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlupButtonPressed");
            var _local_12:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlEditButton");
            var _local_13:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlEditButtonSelected");
            var _local_14:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlEditButtonPressed");
            var _local_15:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlEditButton");
            var _local_16:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlEditButtonSelected");
            var _local_17:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlEditButtonPressed");
            var _local_18:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlExpLine");
            var _local_19:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlBaseExp");
            var _local_20:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlExpLine");
            var _local_21:Bitmap = _local_4.GetBitmapAsset("AdditionalData_Item_LvlJobExp");
            this._panel = new JPanel(new EmptyLayout());
            this._panel.setBorder(_local_2);
            this._panel.setBackgroundDecorator(new AssetBackground(_local_5));
            this._panel.setPreferredHeight((_local_5.height + 8));
            this._panel.setPreferredWidth((_local_5.width + 4));
            this._panel.setMaximumHeight((_local_5.height + 8));
            this._panel.setMaximumWidth((_local_5.width + 4));
            this.RevalidateAvatar();
            if (this._avatarIcon)
            {
                this._avatarPanel = new JPanel(new SoftBoxLayout());
                this._avatarPanel.setBorder(_local_3);
                this._avatarPanel.setBackgroundDecorator(new AssetBackground(this._avatarIcon));
                this._avatarPanel.setSize(new IntDimension(this._avatarIcon.width, this._avatarIcon.height));
                this._avatarPanel.setLocation(new IntPoint(10, 5));
                this._panel.append(this._avatarPanel);
            };
            this._nameEditButton = new CustomButton(null);
            this._nameEditButton.setIcon(new AssetIcon(_local_12));
            this._nameEditButton.setRollOverIcon(new AssetIcon(_local_13));
            this._nameEditButton.setPressedIcon(new AssetIcon(_local_14));
            this._nameEditButton.setSize(new IntDimension(20, 20));
            this._nameEditButton.setBackgroundDecorator(null);
            this._nameEditButton.setLocation(new IntPoint(218, 24));
            this._nameEditButton.addActionListener(this.OnNameEditClick, 0, true);
            var _local_22:CustomToolTip = new CustomToolTip(this._nameEditButton, ClientApplication.Instance.GetPopupText(160), 220, 20);
            this._panel.append(this._nameEditButton);
            this._jobEditButton = new CustomButton(null);
            this._jobEditButton.setIcon(new AssetIcon(_local_15));
            this._jobEditButton.setRollOverIcon(new AssetIcon(_local_16));
            this._jobEditButton.setPressedIcon(new AssetIcon(_local_17));
            this._jobEditButton.setSize(new IntDimension(20, 20));
            this._jobEditButton.setBackgroundDecorator(null);
            this._jobEditButton.setLocation(new IntPoint(218, 54));
            this._jobEditButton.addActionListener(this.OnClick, 0, true);
            var _local_23:CustomToolTip = new CustomToolTip(this._jobEditButton, ClientApplication.Instance.GetPopupText(161), 220, 20);
            this._panel.append(this._jobEditButton);
            this._lvlUpButton = new CustomButton(null);
            this._lvlUpButton.setIcon(new AssetIcon(_local_6));
            this._lvlUpButton.setRollOverIcon(new AssetIcon(_local_7));
            this._lvlUpButton.setPressedIcon(new AssetIcon(_local_8));
            this._lvlUpButton.setSize(new IntDimension(20, 20));
            this._lvlUpButton.setBackgroundDecorator(null);
            this._lvlUpButton.setLocation(new IntPoint(218, 84));
            this._lvlUpButton.addActionListener(this.OnBaseLvlUpClick, 0, true);
            this._lvlUpTip1 = new CustomToolTip(this._lvlUpButton, ClientApplication.Instance.GetPopupText(158), 240, 50);
            this._lvlUpTip2 = new CustomToolTip(this._lvlUpButton, ClientApplication.Instance.GetPopupText(162), 240, 20);
            this._panel.append(this._lvlUpButton);
            this._jobUpButton = new CustomButton(null);
            this._jobUpButton.setIcon(new AssetIcon(_local_9));
            this._jobUpButton.setRollOverIcon(new AssetIcon(_local_10));
            this._jobUpButton.setPressedIcon(new AssetIcon(_local_11));
            this._jobUpButton.setSize(new IntDimension(20, 20));
            this._jobUpButton.setBackgroundDecorator(null);
            this._jobUpButton.setLocation(new IntPoint(218, 110));
            this._jobUpButton.addActionListener(this.OnJobLvlUpClick, 0, true);
            this._jobUpTip1 = new CustomToolTip(this._jobUpButton, ClientApplication.Instance.GetPopupText(159), 190, 20);
            this._jobUpTip2 = new CustomToolTip(this._jobUpButton, ClientApplication.Instance.GetPopupText(163), 240, 20);
            this._panel.append(this._jobUpButton);
            this._lvlBaseExpPanel = new JPanel(new SoftBoxLayout());
            this._lvlBaseExpPanel.setBorder(_local_3);
            this._lvlBaseExpPanel.setBackgroundDecorator(new AssetBackground(_local_19));
            this._lvlBaseExpPanel.setSize(new IntDimension(1, _local_19.height));
            this._lvlBaseExpPanel.setLocation(new IntPoint(45, 85));
            this._panel.append(this._lvlBaseExpPanel);
            var _local_24:JPanel = new JPanel(new SoftBoxLayout());
            _local_24.setBorder(_local_3);
            _local_24.setBackgroundDecorator(new AssetBackground(_local_18));
            _local_24.setSize(new IntDimension(_local_18.width, _local_18.height));
            _local_24.setLocation(new IntPoint(43, 82));
            this._panel.append(_local_24);
            this._lvlJobExpPanel = new JPanel(new SoftBoxLayout());
            this._lvlJobExpPanel.setBorder(_local_3);
            this._lvlJobExpPanel.setBackgroundDecorator(new AssetBackground(_local_21));
            this._lvlJobExpPanel.setSize(new IntDimension(1, _local_21.height));
            this._lvlJobExpPanel.setLocation(new IntPoint(45, 112));
            this._panel.append(this._lvlJobExpPanel);
            var _local_25:JPanel = new JPanel(new SoftBoxLayout());
            _local_25.setBorder(_local_3);
            _local_25.setBackgroundDecorator(new AssetBackground(_local_20));
            _local_25.setSize(new IntDimension(_local_20.width, _local_20.height));
            _local_25.setLocation(new IntPoint(43, 109));
            this._panel.append(_local_25);
            this._nameText = new JLabel("", null, JLabel.CENTER);
            this._nameText.setBorder(_local_3);
            this._nameText.setSize(new IntDimension(115, 20));
            var _local_26:ASFont = this._nameText.getFont();
            this._nameText.setFont(new ASFont(_local_26.getName(), 12, true));
            this._nameText.setForeground(new ASColor(0xFFFFFF));
            this._nameText.setLocation(new IntPoint(90, 25));
            var _local_27:CustomToolTip = new CustomToolTip(this._nameText, ClientApplication.Instance.GetPopupText(3), 100, 10);
            this._panel.append(this._nameText);
            this._jobText = new JLabel("", null, JLabel.CENTER);
            this._jobText.setBorder(_local_3);
            this._jobText.setSize(new IntDimension(115, 20));
            this._jobText.setFont(new ASFont(_local_26.getName(), 12, true));
            this._jobText.setForeground(new ASColor(0xFFFFFF));
            this._jobText.setLocation(new IntPoint(90, 53));
            var _local_28:CustomToolTip = new CustomToolTip(this._jobText, ClientApplication.Instance.GetPopupText(5), 140, 10);
            this._panel.append(this._jobText);
            this._baseLvlText = new JLabel("", null, JLabel.CENTER);
            this._baseLvlText.setBorder(_local_3);
            this._baseLvlText.setSize(new IntDimension(20, 20));
            this._baseLvlText.setFont(new ASFont(_local_26.getName(), 13, true));
            this._baseLvlText.setForeground(new ASColor(0xFFFFFF));
            this._baseLvlText.setLocation(new IntPoint(14, 81));
            var _local_29:CustomToolTip = new CustomToolTip(this._baseLvlText, ClientApplication.Instance.GetPopupText(4), 170, 10);
            this._panel.append(this._baseLvlText);
            this._jobLvlText = new JLabel("", null, JLabel.CENTER);
            this._jobLvlText.setBorder(_local_3);
            this._jobLvlText.setSize(new IntDimension(20, 20));
            this._jobLvlText.setFont(new ASFont(_local_26.getName(), 13, true));
            this._jobLvlText.setForeground(new ASColor(0xFFFFFF));
            this._jobLvlText.setLocation(new IntPoint(15, 110));
            var _local_30:CustomToolTip = new CustomToolTip(this._jobLvlText, ClientApplication.Instance.GetPopupText(9), 185, 10);
            this._panel.append(this._jobLvlText);
            this._baseLvlProgressText = new JLabel("", null, JLabel.CENTER);
            this._baseLvlProgressText.setBorder(_local_3);
            this._baseLvlProgressText.setSize(new IntDimension(145, 20));
            this._baseLvlProgressText.setFont(new ASFont(_local_26.getName(), 11, true));
            this._baseLvlProgressText.setForeground(new ASColor(0xFFFFFF));
            this._baseLvlProgressText.setLocation(new IntPoint(55, 83));
            var _local_31:CustomToolTip = new CustomToolTip(this._baseLvlProgressText, ClientApplication.Instance.GetPopupText(164), 165, 10);
            this._panel.append(this._baseLvlProgressText);
            this._jobLvlProgressText = new JLabel("", null, JLabel.CENTER);
            this._jobLvlProgressText.setBorder(_local_3);
            this._jobLvlProgressText.setSize(new IntDimension(145, 20));
            this._jobLvlProgressText.setFont(new ASFont(_local_26.getName(), 11, true));
            this._jobLvlProgressText.setForeground(new ASColor(0xFFFFFF));
            this._jobLvlProgressText.setLocation(new IntPoint(55, 110));
            var _local_32:CustomToolTip = new CustomToolTip(this._jobLvlProgressText, ClientApplication.Instance.GetPopupText(165), 170, 10);
            this._panel.append(this._jobLvlProgressText);
            this._premiumText = new JLabel("", null, JLabel.CENTER);
            this._premiumText.setBorder(new EmptyBorder(null, new Insets(4, 0, 0, 0)));
            this._premiumText.setSize(new IntDimension(115, 20));
            this._premiumText.setFont(new ASFont(_local_26.getName(), 12, true));
            this._premiumText.setForeground(new ASColor(16767612));
            this._premiumUntilText = new JLabel("", null, JLabel.CENTER);
            this._premiumUntilText.setBorder(_local_3);
            this._premiumUntilText.setSize(new IntDimension(115, 20));
            this._premiumUntilText.setFont(new ASFont(_local_26.getName(), 12, true));
            this._premiumUntilText.setForeground(new ASColor(16767612));
            var _local_33:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            _local_33.append(this._premiumText, BorderLayout.SOUTH);
            _local_33.append(this._premiumUntilText, BorderLayout.SOUTH);
            _local_1.append(this._panel, BorderLayout.CENTER);
            _local_1.append(_local_33, BorderLayout.SOUTH);
            MainPanel.append(_local_1, BorderLayout.CENTER);
        }

        public function RevalidateInfo():void
        {
            var _local_1:Actors;
            var _local_5:uint;
            this.RevalidateAvatar();
            _local_1 = ClientApplication.Instance.LocalGameClient.ActorList;
            var _local_2:CharacterInfo = _local_1.GetPlayer();
            this._nameText.setText(_local_2.internalName);
            this._jobText.setText(CharacterStorage.Instance.GetJobName(((_local_2) ? _local_2.clothesColor : 0), _local_2.jobId));
            this._baseLvlText.setText(_local_2.baseLevel.toString());
            this._jobLvlText.setText(_local_2.jobLevel.toString());
            var _local_3:Boolean = Character.IsBabyClass(_local_2.jobId);
            var _local_4:* = "";
            if (_local_2.nextBaseExp != 0)
            {
                _local_4 = ((HtmlText.ConvertExp(_local_2.baseExp) + " / ") + HtmlText.ConvertExp(_local_2.nextBaseExp));
            }
            else
            {
                _local_4 = ((_local_3) ? "2.000.000.000/2.000.000.000" : "999.999.999 / 999.999.999");
            };
            this._baseLvlProgressText.setText(_local_4);
            this._lvlBaseExpPanel.scaleX = int((((_local_2.nextBaseExp != 0) ? (_local_2.baseExp / _local_2.nextBaseExp) : 1) * 166));
            _local_4 = ((_local_2.nextJobExp != 0) ? ((HtmlText.ConvertExp(_local_2.jobExp) + " / ") + HtmlText.ConvertExp(_local_2.nextJobExp)) : "2.083.386 / 2.083.386");
            this._jobLvlProgressText.setText(_local_4);
            this._lvlJobExpPanel.scaleX = int((((_local_2.nextJobExp != 0) ? (_local_2.jobExp / _local_2.nextJobExp) : 1) * 166));
            this._jobEditButton.setEnabled((!(_local_2.jobId == 0)));
            this._lvlUpButton.setEnabled((!(_local_2.jobId == 0)));
            this._jobUpButton.setEnabled((!(_local_2.jobId == 0)));
            this._lvlUpTip1.setVisible((_local_2.baseLevel < 80));
            this._lvlUpTip2.setVisible((_local_2.baseLevel >= 80));
            this._jobUpTip1.setVisible((_local_2.jobLevel < 50));
            this._jobUpTip2.setVisible((_local_2.jobLevel >= 50));
            _local_5 = ClientApplication.Instance.LocalGameClient.PremiumType;
            var _local_6:String = ((_local_5 > 0) ? ((_local_5 == 1) ? ClientApplication.Localization.PREMIUM_TYPE_VALUE_BASE : ClientApplication.Localization.PREMIUM_TYPE_VALUE_SUPER) : ClientApplication.Localization.PREMIUM_TYPE_VALUE_NOTHING);
            var _local_7:String = ((_local_5 > 0) ? ClientApplication.Instance.LocalGameClient.PremiumUntilStr : ClientApplication.Localization.PREMIUM_UNTIL_VALUE_NOTHING);
            this._premiumText.setText(((ClientApplication.Localization.PREMIUM_TYPE_MESSAGE + " ") + _local_6));
            this._premiumUntilText.setText(((ClientApplication.Localization.PREMIUM_UNTIL_MESSAGE + " ") + _local_7));
        }

        public function RevalidateAvatar():void
        {
            var classIcon:Class;
            var classIconRef:String = CharacterStorage.Instance.LocalPlayerIconSmall;
            if (classIconRef != null)
            {
                if (classIconRef === this._avatarIconRef)
                {
                    return;
                };
                this._avatarIconRef = classIconRef;
                if (this._avatarIcon != null)
                {
                    this._avatarIcon = null;
                };
                try
                {
                    classIcon = (getDefinitionByName(classIconRef) as Class);
                    this._avatarIcon = new (classIcon)();
                }
                catch(e:ReferenceError)
                {
                    _avatarIconRef = null;
                };
            };
        }

        private function OnClick(_arg_1:Event):void
        {
            ClientApplication.Instance.ThisMethodIsDisabled();
        }

        private function OnNameEditClick(evt:Event):void
        {
            var/*const*/ priceInCols:Number = 500;
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ((ClientApplication.Localization.CASH_RENAME_CHARACTER_MESSAGE + " ") + priceInCols), function OnOperationAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    ClientApplication.Instance.LocalGameClient.SendChatMessage("@cashrenamecharacter");
                    RevalidateInfo();
                };
            }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
        }

        private function OnBaseLvlUpClick(evt:Event):void
        {
            var priceArray:Array;
            var priceInCols:String;
            var player:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            if (player.baseLevel < 80)
            {
                priceArray = [10, 25, 50, 100, 200, 300, 500, 1000];
                priceInCols = int(priceArray[int((player.baseLevel / 10))]).toString();
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ((ClientApplication.Localization.CASH_BASE_LEVEL_UP_MESSAGE + " ") + priceInCols), function OnOperationAccepted (_arg_1:int):void
                {
                    if (_arg_1 == JOptionPane.YES)
                    {
                        ClientApplication.Instance.LocalGameClient.SendChatMessage("@cashlvlup");
                        RevalidateInfo();
                    };
                }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.CASH_BASE_LEVEL_UP_LIMIT, null, null, true, new AttachIcon("AchtungIcon")));
            };
        }

        private function OnJobLvlUpClick(evt:Event):void
        {
            var priceArray:Array;
            var priceInCols:String;
            var player:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            if (player.jobLevel < 50)
            {
                priceArray = [10, 50, 200, 500, 1000];
                priceInCols = int(priceArray[int((player.jobLevel / 10))]).toString();
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ((ClientApplication.Localization.CASH_JOB_LEVEL_UP_MESSAGE + " ") + priceInCols), function OnOperationAccepted (_arg_1:int):void
                {
                    if (_arg_1 == JOptionPane.YES)
                    {
                        ClientApplication.Instance.LocalGameClient.SendChatMessage("@cashjoblvlup");
                        RevalidateInfo();
                    };
                }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.CASH_JOB_LEVEL_UP_LIMIT, null, null, true, new AttachIcon("AchtungIcon")));
            };
        }


    }
}//package hbm.Game.GUI.LevelInfo

