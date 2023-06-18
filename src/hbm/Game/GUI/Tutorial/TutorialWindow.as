


//hbm.Game.GUI.Tutorial.TutorialWindow

package hbm.Game.GUI.Tutorial
{
    import hbm.Game.GUI.Tools.ShadowWindow;
    import org.aswing.JPanel;
    import org.aswing.JLabel;
    import hbm.Game.GUI.Tools.BubbleDialog;
    import org.aswing.JTextArea;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.EmptyLayout;
    import org.aswing.ASFont;
    import hbm.Game.Utility.HtmlText;
    import hbm.Application.ClientApplication;
    import org.aswing.ASColor;
    import org.aswing.SoftBoxLayout;
    import org.aswing.BorderLayout;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Game.GUI.Inventory.InventoryStoreItem;
    import org.aswing.event.AWEvent;

    public class TutorialWindow extends ShadowWindow 
    {

        private var _frame:JPanel;
        private var _imagePanel:JPanel;
        private var _iconPanel:JPanel;
        private var _titlePanel:JLabel;
        private var _bubbleDialog:BubbleDialog;
        private var _descriptionText:JTextArea;
        private var _congratulationPanel:JPanel;
        private var _questLabel:JLabel;
        private var _rewardLabel:JLabel;
        private var _rewardPanel:JPanel;
        private var _doButton:CustomButton;
        private var _tutorialData:Object;
        private var _flag:uint;


        override protected function InitUI():void
        {
            super.InitUI();
            AsWingUtil.SetSize(_window, 899, 889);
            this._imagePanel = new JPanel(new EmptyLayout());
            _window.append(this._imagePanel);
            this._frame = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAssetLocalization(this._frame, "TW_Background");
            this._frame.setLocationXY(140, 390);
            this._iconPanel = new JPanel(new EmptyLayout());
            this._iconPanel.setLocationXY(52, 65);
            this._frame.append(this._iconPanel);
            this._titlePanel = AsWingUtil.CreateLabel("", 15253613, new ASFont(HtmlText.fontName, 22, false));
            this._titlePanel.setHorizontalAlignment(JLabel.LEFT);
            AsWingUtil.SetSize(this._titlePanel, 330, 45);
            this._titlePanel.setLocationXY(270, 45);
            this._frame.append(this._titlePanel);
            this._bubbleDialog = new BubbleDialog(380, 200, "", BubbleDialog.TAIL_ARROW_MIDDLE);
            this._bubbleDialog.SetPositionBubble(390, 320);
            _window.append(this._bubbleDialog);
            this._questLabel = AsWingUtil.CreateLabel(ClientApplication.Localization.TUTORIAL_QUEST_LABEL, 1050118, new ASFont(HtmlText.fontName, 15, false));
            AsWingUtil.SetSize(this._questLabel, 80, 15);
            this._questLabel.setLocationXY(140, 100);
            this._frame.append(this._questLabel);
            this._descriptionText = AsWingUtil.CreateTextArea("");
            this._descriptionText.setForeground(new ASColor(1050118));
            this._descriptionText.setFont(new ASFont(HtmlText.fontName, 14, false));
            AsWingUtil.SetSize(this._descriptionText, 570, 84);
            this._descriptionText.setLocationXY(134, 134);
            this._frame.append(this._descriptionText);
            this._congratulationPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAssetLocalization(this._congratulationPanel, "TW_Congratulations");
            this._congratulationPanel.setLocationXY(119, 97);
            this._frame.append(this._congratulationPanel);
            this._rewardLabel = AsWingUtil.CreateLabel(ClientApplication.Localization.QUEST_WINDOW_REWARD_LABEL, 0, new ASFont(HtmlText.fontName, 16, false));
            AsWingUtil.SetSize(this._rewardLabel, 540, 25);
            this._rewardLabel.setLocationXY(110, 240);
            this._frame.append(this._rewardLabel);
            this._rewardPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 10, SoftBoxLayout.CENTER));
            var _local_1:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetSize(_local_1, 540, 110);
            _local_1.setLocationXY(110, 270);
            _local_1.append(AsWingUtil.AlignCenter(this._rewardPanel));
            this._frame.append(_local_1);
            this._doButton = AsWingUtil.CreateCustomButtonFromAssetLocalization("TW_AcceptButton", "TW_AcceptButtonOver");
            this._doButton.setLocationXY(320, 420);
            this._frame.append(this._doButton);
            this._doButton.addActionListener(this.OnGoButton);
            _window.append(this._frame);
        }

        public function get DoButton():CustomButton
        {
            return (this._doButton);
        }

        public function ShowTutorial(_arg_1:uint, _arg_2:uint=1):void
        {
            var _local_4:Object;
            var _local_5:ItemData;
            var _local_6:Object;
            this._flag = _arg_2;
            this._tutorialData = AsWingUtil.AdditionalData.GetTutorialData(_arg_1);
            if (!this._tutorialData)
            {
                return;
            };
            AsWingUtil.SetBackgroundFromAsset(this._imagePanel, this._tutorialData.Image);
            AsWingUtil.SetBackgroundFromAsset(this._iconPanel, this._tutorialData.Icon);
            this._titlePanel.setText(this._tutorialData.Title);
            this._bubbleDialog.Text = this._tutorialData.Bubble;
            switch (this._tutorialData.Type)
            {
                case 2:
                    AsWingUtil.SetBackgroundFromAssetLocalization(this._frame, "TW_Background");
                    this._rewardLabel.setText(ClientApplication.Localization.TUTORIAL_REWARD_LABEL);
                    this._congratulationPanel.visible = true;
                    this._questLabel.visible = false;
                    this._descriptionText.setLocationXY(134, 134);
                    AsWingUtil.UpdateCustomButton(this._doButton, AsWingUtil.GetAssetLocalization("TW_AcceptButton"), AsWingUtil.GetAssetLocalization("TW_AcceptButtonOver"));
                    this._doButton.setLocationXY(320, 420);
                    break;
                case 3:
                    AsWingUtil.SetBackgroundFromAssetLocalization(this._frame, "TW_Background2");
                    this._congratulationPanel.visible = false;
                    this._rewardLabel.setText("");
                    this._questLabel.visible = false;
                    this._descriptionText.setHtmlText(this._tutorialData.Description);
                    this._descriptionText.setLocationXY(134, 100);
                    AsWingUtil.UpdateCustomButton(this._doButton, AsWingUtil.GetAssetLocalization("TW_NextButton"), AsWingUtil.GetAssetLocalization("TW_NextButtonOver"));
                    this._doButton.setLocationXY(330, 230);
                    break;
                default:
                    AsWingUtil.SetBackgroundFromAssetLocalization(this._frame, "TW_Background");
                    this._congratulationPanel.visible = false;
                    this._questLabel.visible = true;
                    this._descriptionText.setLocationXY(134, 134);
                    this._rewardLabel.setText(ClientApplication.Localization.TUTORIAL_REWARD_LABEL2);
                    this._descriptionText.setHtmlText(this._tutorialData.Description);
                    AsWingUtil.UpdateCustomButton(this._doButton, AsWingUtil.GetAssetLocalization("TW_AcceptButton"), AsWingUtil.GetAssetLocalization("TW_AcceptButtonOver"));
                    this._doButton.setLocationXY(320, 420);
            };
            var _local_3:ItemsResourceLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            this._rewardPanel.removeAll();
            this._rewardLabel.visible = ((this._tutorialData.RewardItemList) && (this._tutorialData.RewardItemList.length));
            if (this._rewardLabel.visible)
            {
                for each (_local_4 in this._tutorialData.RewardItemList)
                {
                    _local_5 = new ItemData();
                    _local_5.Amount = ((_local_4["Count"]) || (0));
                    _local_5.NameId = ((_local_4["Item"]) || (0));
                    _local_5.Identified = 1;
                    _local_5.Origin = ItemData.QUEST;
                    _local_6 = _local_3.GetServerDescriptionObject(_local_5.NameId);
                    if (_local_6)
                    {
                        _local_5.Type = _local_6["type"];
                    };
                    this._rewardPanel.append(this.CreateRewardItem(_local_5));
                };
            };
            ShowWithAnimation();
        }

        private function CreateRewardItem(_arg_1:ItemData):JPanel
        {
            var _local_4:InventoryStoreItem;
            var _local_2:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBorder(_local_2, 0, 3);
            AsWingUtil.SetWidth(_local_2, 110);
            var _local_3:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, SoftBoxLayout.LEFT));
            _local_4 = new InventoryStoreItem(_arg_1);
            AsWingUtil.SetSize(_local_4, 32, 32);
            var _local_5:String = ((_local_4.Item.Identified == 1) ? _local_4.Name : (_local_4.Name + "?"));
            var _local_6:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBackgroundFromAssetLocalization(_local_6, "TW_Item");
            _local_6.append(AsWingUtil.AlignCenter(_local_4));
            var _local_7:String = _local_5;
            if (_local_4.Item.Amount > 1)
            {
                _local_7 = (_local_7 + (" +" + _local_4.Item.Amount));
            };
            var _local_8:JPanel = AsWingUtil.CreateCenterTextFromWidth(_local_7, 1050118, new ASFont(HtmlText.fontName, 14), 120);
            _local_3.appendAll(AsWingUtil.AlignCenter(_local_6), _local_8);
            _local_2.append(_local_3);
            return (_local_2);
        }

        private function OnGoButton(_arg_1:AWEvent):void
        {
            if (this._flag == TutorialPanel.LOAD_TUTORIAL)
            {
                ClientApplication.Instance.LocalGameClient.SendRemoteNPCClick(this._tutorialData.ScriptNPC);
            };
            CloseWithAnimation();
            HelpManager.Instance.ApplyTutorialPressed();
        }

        override public function dispose():void
        {
            super.dispose();
            if (ClientApplication.openLevelupAfterTutorial >= 0)
            {
                ClientApplication.Instance.ShowLevelUpWindow(ClientApplication.openLevelupAfterTutorial);
                ClientApplication.openLevelupAfterTutorial = -1;
            };
        }


    }
}//package hbm.Game.GUI.Tutorial

