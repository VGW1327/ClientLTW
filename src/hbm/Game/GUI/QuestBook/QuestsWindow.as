


//hbm.Game.GUI.QuestBook.QuestsWindow

package hbm.Game.GUI.QuestBook
{
    import hbm.Game.GUI.Tools.ShadowWindow;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.utils.Dictionary;
    import org.aswing.JPanel;
    import org.aswing.JLabel;
    import hbm.Game.GUI.Tools.BubbleDialog;
    import org.aswing.JTextArea;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Game.GUI.Tools.CustomTabbedPane;
    import org.aswing.JPopupMenu;
    import org.aswing.JCheckBox;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.EmptyLayout;
    import hbm.Application.ClientApplication;
    import org.aswing.ASFont;
    import hbm.Game.Utility.HtmlText;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import flash.events.MouseEvent;
    import org.aswing.ASColor;
    import org.aswing.JScrollPane;
    import org.aswing.AssetIcon;
    import org.aswing.Icon;
    import org.aswing.GridLayout;
    import org.aswing.BorderLayout;
    import hbm.Game.GUI.Tools.WindowSprites;
    import hbm.Game.Utility.Payments;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import org.aswing.AttachIcon;
    import flash.events.Event;
    import hbm.Engine.PathFinding.RoadAtlas;
    import org.aswing.JMenuItem;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Game.GUI.Inventory.InventoryStoreItem;

    public class QuestsWindow extends ShadowWindow 
    {

        private static const _tutorialQuests:Array = [289, 290, 291, 315];

        private var _dataLibrary:AdditionalDataResourceLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
        private var _quests:Array;
        private var _questsIdHash:Dictionary;
        private var _curQuestIndex:uint;
        private var _width:int = 899;
        private var _height:int = 890;
        private var _npcIconBig:JPanel;
        private var _frameIcon:JPanel;
        private var _npcIcon:JLabel;
        private var _bubbleDialog:BubbleDialog;
        private var _titlePanel:JLabel;
        private var _npcNameLabel:JLabel;
        private var _descriptionText:JTextArea;
        private var _rewardLabel:JLabel;
        private var _rewardPanel:JPanel;
        private var _requirePanel:JPanel;
        private var _locationLabel:JLabel;
        private var _counterLabel:JLabel;
        private var _completeIcon:JPanel;
        private var _leftArrow:CustomButton;
        private var _rightArrow:CustomButton;
        private var _tabsTask:CustomTabbedPane;
        private var _mercenaryPanel:JPanel;
        private var _mercenaryPrice:JLabel;
        private var _questsMenu:JPopupMenu;
        private var _findCheckBox:JCheckBox;
        private var _abandonButton:CustomButton;
        private var _showQuestId:uint;


        override protected function InitUI():void
        {
            var _local_1:JPanel;
            super.InitUI();
            AsWingUtil.SetSize(_window, this._width, this._height);
            this.CreateNPCPanel();
            _local_1 = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAsset(_local_1, "QuestsWindowBackground");
            _local_1.setLocationXY(140, 390);
            _window.append(_local_1);
            this._titlePanel = AsWingUtil.CreateLabel(ClientApplication.Localization.DLG_NPC_TITLE, 15253613, new ASFont(HtmlText.fontName, 22, false));
            AsWingUtil.SetSize(this._titlePanel, 330, 45);
            this._titlePanel.setLocationXY(270, 50);
            _local_1.append(this._titlePanel);
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 10, SoftBoxLayout.CENTER));
            AsWingUtil.SetSize(_local_2, 90, 35);
            _local_2.setLocationXY(580, 52);
            _local_1.append(_local_2);
            this._leftArrow = AsWingUtil.CreateCustomButtonFromAsset("QW_ActiveLeft", "QW_OverLeft");
            this._leftArrow.addActionListener(this.OnScrollLeft, 0, true);
            new CustomToolTip(this._leftArrow, ClientApplication.Instance.GetPopupText(273), 200);
            this._rightArrow = AsWingUtil.CreateCustomButtonFromAsset("QW_ActiveRight", "QW_OverRight");
            this._rightArrow.addActionListener(this.OnScrollRight, 0, true);
            new CustomToolTip(this._rightArrow, ClientApplication.Instance.GetPopupText(274), 200);
            this._counterLabel = AsWingUtil.CreateLabel("", 15253613, getFont());
            this._counterLabel.setTextFilters([HtmlText.shadow]);
            this._counterLabel.buttonMode = true;
            this._counterLabel.addEventListener(MouseEvent.CLICK, this.OnShowMenu, false, 0, true);
            new CustomToolTip(this._counterLabel, ClientApplication.Instance.GetPopupText(275), 300);
            AsWingUtil.SetBackgroundFromAsset(this._counterLabel, "QW_IconCounter");
            _local_2.appendAll(AsWingUtil.AlignCenter(this._leftArrow), this._counterLabel, AsWingUtil.AlignCenter(this._rightArrow));
            this._npcNameLabel = AsWingUtil.CreateLabel("", 16767612, new ASFont(getFont().getName(), 12, false));
            this._npcNameLabel.setTextFilters([HtmlText.glow]);
            AsWingUtil.SetSize(this._npcNameLabel, 238, 24);
            this._npcNameLabel.setLocationXY(72, 10);
            _local_1.append(this._npcNameLabel);
            this._tabsTask = new CustomTabbedPane();
            this._tabsTask.setLocationXY(120, 97);
            AsWingUtil.SetBorder(this._tabsTask);
            AsWingUtil.SetSize(this._tabsTask, 600, 128);
            this._descriptionText = AsWingUtil.CreateTextArea("");
            this._descriptionText.setForeground(new ASColor(0));
            this._descriptionText.setFont(new ASFont(HtmlText.fontName, 14, false));
            AsWingUtil.SetBorder(this._descriptionText, 10);
            AsWingUtil.SetWidth(this._descriptionText, 560);
            var _local_3:JScrollPane = new JScrollPane(this._descriptionText, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_NEVER);
            AsWingUtil.SetSize(_local_3, 580, 128);
            var _local_4:Icon = new AssetIcon(AsWingUtil.GetAssetLocalization("QW_TabTask"));
            var _local_5:Icon = new AssetIcon(AsWingUtil.GetAssetLocalization("QW_TabTaskActive"));
            this._tabsTask.AppendCustomTab(_local_3, _local_4, _local_5, ClientApplication.Instance.GetPopupText(269));
            this._requirePanel = new JPanel(new GridLayout(2, 3));
            AsWingUtil.SetBorder(this._requirePanel, 10, -5, 0, 10);
            _local_1.append(this._tabsTask);
            this._rewardLabel = AsWingUtil.CreateLabel(ClientApplication.Localization.QUEST_WINDOW_REWARD_LABEL, 0, new ASFont(HtmlText.fontName, 16, false));
            AsWingUtil.SetSize(this._rewardLabel, 600, 25);
            this._rewardLabel.setLocationXY(110, 240);
            _local_1.append(this._rewardLabel);
            this._rewardPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 10, SoftBoxLayout.CENTER));
            var _local_6:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetSize(_local_6, 600, 110);
            _local_6.setLocationXY(110, 270);
            _local_6.append(AsWingUtil.AlignCenter(this._rewardPanel));
            _local_1.append(_local_6);
            this._completeIcon = new JPanel(new BorderLayout());
            AsWingUtil.SetBackgroundFromAsset(this._completeIcon, "QW_Stamp");
            this._completeIcon.setLocationXY(120, 210);
            _local_1.append(this._completeIcon);
            new CustomToolTip(this._completeIcon, ClientApplication.Instance.GetPopupText(276), 200);
            this._abandonButton = AsWingUtil.CreateCustomButtonFromAssetLocalization("QW_AbandonButton", "QW_AbandonButtonOver", "QW_AbandonButtonPress");
            this._abandonButton.setLocationXY(570, 223);
            this._abandonButton.addActionListener(this.OnAbandonQuest, 0, true);
            _local_1.append(this._abandonButton);
            new CustomToolTip(this._abandonButton, ClientApplication.Instance.GetPopupText(277), 200);
            this._mercenaryPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 10, SoftBoxLayout.RIGHT));
            this._mercenaryPanel.setLocationXY(370, 375);
            AsWingUtil.SetSize(this._mercenaryPanel, 340, 100);
            var _local_7:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.RIGHT));
            AsWingUtil.SetSize(_local_7, 340, 20);
            var _local_8:JLabel = AsWingUtil.CreateLabel(ClientApplication.Localization.QUEST_WINDOW_MERCENARY_LABEL, 1050118, new ASFont(HtmlText.fontName, 14, true));
            this._mercenaryPrice = AsWingUtil.CreateLabel("", 0xFFFFFF, new ASFont(HtmlText.fontName, 14, true));
            this._mercenaryPrice.setTextFilters([HtmlText.shadow]);
            var _local_9:JLabel = AsWingUtil.CreateIcon(new WindowSprites.CoinGold());
            AsWingUtil.SetBorder(_local_9, 0, 5);
            _local_7.appendAll(_local_8, this._mercenaryPrice, AsWingUtil.AlignCenter(_local_9));
            this._mercenaryPanel.append(_local_7);
            var _local_10:CustomButton = AsWingUtil.CreateCustomButtonFromAssetLocalization("QW_ExecuteButton", "QW_ExecuteButtonOver", "QW_ExecuteButtonPress");
            _local_10.addActionListener(this.OnReleaseQuest, 0, true);
            this._mercenaryPanel.append(AsWingUtil.AlignCenter(_local_10));
            new CustomToolTip(_local_10, ClientApplication.Instance.GetPopupText(278), 200);
            _local_1.append(this._mercenaryPanel);
            var _local_11:JLabel = AsWingUtil.CreateLabel(ClientApplication.Localization.QUEST_WINDOW_LOCATION_LABEL, 1050118, new ASFont(HtmlText.fontName, 16, false));
            AsWingUtil.SetSize(_local_11, 155, 22);
            _local_11.setLocationXY(50, 425);
            _local_1.append(_local_11);
            this._locationLabel = AsWingUtil.CreateLabel("", 1050118, new ASFont(HtmlText.fontName, 14));
            AsWingUtil.SetSize(this._locationLabel, 155, 22);
            this._locationLabel.setLocationXY(50, (425 + 22));
            _local_1.append(this._locationLabel);
            this._findCheckBox = AsWingUtil.CreateCheckBoxFromAsset("QW_NavigateEnable", "QW_NavigateDisable");
            this._findCheckBox.setLocationXY(230, 428);
            this._findCheckBox.addActionListener(this.OnFindLocation, 0, true);
            _local_1.append(this._findCheckBox);
            new CustomToolTip(this._findCheckBox, ClientApplication.Instance.GetPopupText(280), 200);
            var _local_12:CustomButton = AsWingUtil.CreateCustomButtonFromAsset("EC_ButtonClose", "EC_ButtonCloseOver", "EC_ButtonClosePress");
            _local_12.setLocationXY(810, 440);
            _local_12.addActionListener(this.OnClose, 0, true);
            _window.append(_local_12);
        }

        public function get FindButton():JCheckBox
        {
            return (this._findCheckBox);
        }

        private function OnReleaseQuest(evt:Event):void
        {
            var quest:Object;
            var npc:Object;
            var arr:Array;
            quest = this._quests[this._curQuestIndex];
            if (((quest) && (quest.Price)))
            {
                npc = this._dataLibrary.GetNpcDataFromId(quest.NpcId[0]);
                if (((!(npc)) || (!(npc.ScriptName))))
                {
                    return;
                };
                if (Payments.TestAmountPay(ItemData.CASH, quest.Price))
                {
                    arr = ClientApplication.Localization.BUY_DIALOG_GOLDS_DECLINATION;
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.QUEST_WINDOW_MERCENARY_DIALOG, HtmlText.GetText(ClientApplication.Localization.QUEST_WINDOW_MERCENARY_DIALOG_DESCRIPTION, quest.Price, HtmlText.declination(quest.Price, arr)), function OnFinishQuest (_arg_1:int):void
                    {
                        if (_arg_1 == JOptionPane.YES)
                        {
                            CloseWithAnimation();
                            ClientApplication.Instance.LocalGameClient.SendRemoteNPCEvent(((npc.ScriptName + "::OnAutoQuest") + _questsIdHash[quest]));
                            if (_findCheckBox.isSelected())
                            {
                                HelpManager.Instance.GetRoadAtlas().Reset();
                            };
                            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.QUEST_WINDOW_MERCENARY_DIALOG2, ClientApplication.Localization.QUEST_WINDOW_MERCENARY_DIALOG_DESCRIPTION2, null, null, true, new AttachIcon("AchtungIcon"), JOptionPane.OK));
                        };
                    }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
                };
            };
        }

        private function OnFindLocation(_arg_1:Event):void
        {
            var _local_2:Object;
            var _local_3:uint;
            var _local_4:int;
            var _local_5:uint;
            if (this._findCheckBox.isSelected())
            {
                _local_2 = this._quests[this._curQuestIndex];
                if (_local_2)
                {
                    if (("TutorialNPC" in _local_2))
                    {
                        HelpManager.Instance.GetRoadAtlas().Reset();
                        ClientApplication.Instance.LocalGameClient.SendRemoteNPCClick(_local_2["TutorialNPC"]);
                    }
                    else
                    {
                        if (_local_2.Locations)
                        {
                            _local_3 = RoadAtlas.FAIL_FIND;
                            _local_4 = this.GetQuestState(_local_2);
                            _local_5 = this._questsIdHash[_local_2];
                            if (_local_4 == _local_2.Complete)
                            {
                                HelpManager.Instance.GetRoadAtlas().HelpMoveToMap(_local_2.Locations[(_local_2.Locations.length - 1)], _local_2.NpcId[(_local_2.NpcId.length - 1)], _local_5);
                            }
                            else
                            {
                                switch (_local_2.NpcId.length)
                                {
                                    case 2:
                                        _local_3 = HelpManager.Instance.GetRoadAtlas().HelpMoveToMap(_local_2.Locations[0], "", _local_5);
                                        break;
                                    case 3:
                                        HelpManager.Instance.GetRoadAtlas().HelpMoveToMap(_local_2.Locations[0], _local_2.NpcId[1], _local_5);
                                        break;
                                    default:
                                        HelpManager.Instance.GetRoadAtlas().HelpMoveToMap(_local_2.Locations[(_local_4 - 1)], _local_2.NpcId[_local_4], _local_5);
                                };
                            };
                            if (((_local_3 == RoadAtlas.COMPLETE_FIND) && (_tutorialQuests.indexOf(_local_5) < 0)))
                            {
                                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.QUEST_WINDOW_DIALOG_TITLE, ClientApplication.Localization.QUEST_WINDOW_DIALOG_DESCRIPTION, null, null, true, new AttachIcon("AchtungIcon")));
                            };
                        };
                    };
                };
                CloseWithAnimation();
            }
            else
            {
                HelpManager.Instance.GetRoadAtlas().Reset();
            };
        }

        private function OnShowMenu(_arg_1:MouseEvent):void
        {
            if (this._quests.length < 1)
            {
                return;
            };
            var _local_2:uint = this._questsMenu.getPreferredHeight();
            this._questsMenu.show(this._counterLabel, (this._counterLabel.x - 30), (this._counterLabel.y - _local_2));
        }

        private function OnScrollRight(_arg_1:Event):void
        {
            this._curQuestIndex = Math.min((this._quests.length - 1), (this._curQuestIndex + 1));
            this.ShowQuest(this._curQuestIndex);
            this.UpdateCounter();
        }

        private function OnScrollLeft(_arg_1:Event):void
        {
            this._curQuestIndex = Math.max(0, (this._curQuestIndex - 1));
            this.ShowQuest(this._curQuestIndex);
            this.UpdateCounter();
        }

        protected function CreateNPCPanel():void
        {
            this._npcIconBig = new JPanel(new EmptyLayout());
            _window.append(this._npcIconBig);
            this._frameIcon = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAsset(this._frameIcon, "NewNpcIconFrame");
            AsWingUtil.SetBorder(this._frameIcon);
            this._bubbleDialog = new BubbleDialog(380, 200, "", BubbleDialog.TAIL_ARROW_MIDDLE);
            this._bubbleDialog.SetPositionBubble(390, 320);
            _window.append(this._bubbleDialog);
            this._npcIcon = new JLabel();
            this._npcIcon.setAlignmentX(JLabel.CENTER);
            this._npcIcon.setAlignmentY(JLabel.CENTER);
            AsWingUtil.SetBackgroundFromAsset(this._npcIcon, "NpcDialogNpcFaceFrame");
            this._npcIcon.setLocationXY(70, -4);
            this._frameIcon.append(this._npcIcon);
            this._frameIcon.setLocationXY(184, 251);
            _window.append(this._frameIcon);
        }

        public function Revalidate():void
        {
            var _local_2:*;
            var _local_3:int;
            var _local_4:Object;
            var _local_5:JMenuItem;
            var _local_1:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            this._quests = [];
            this._questsIdHash = new Dictionary();
            this._questsMenu = new JPopupMenu();
            this._curQuestIndex = 0;
            for (_local_2 in _local_1.QuestStates)
            {
                if (_local_2 != 254)
                {
                    _local_3 = _local_1.QuestStates[_local_2];
                    if (((_local_3 > 0) && (_local_3 < 100)))
                    {
                        _local_4 = this._dataLibrary.GetQuestsData(_local_2);
                        if (_local_4)
                        {
                            _local_5 = this._questsMenu.addMenuItem(((_local_4.Name) || (ClientApplication.Localization.QUEST_WINDOW_UNKNOWN_NAME)));
                            _local_5.putClientProperty("index", this._quests.length);
                            _local_5.addActionListener(this.OnSelectQuest, 0, true);
                            this._questsIdHash[_local_4] = _local_2;
                            this._quests.push(_local_4);
                            if (this._showQuestId == _local_2)
                            {
                                this._curQuestIndex = (this._quests.length - 1);
                            };
                        };
                    };
                };
            };
            if (this._quests.length)
            {
                this.ShowQuest(this._curQuestIndex);
            }
            else
            {
                this.ShowFake();
            };
        }

        private function OnAbandonQuest(evt:Event):void
        {
            var quest:Object;
            quest = this._quests[this._curQuestIndex];
            if (!quest)
            {
                return;
            };
            if (quest["type"] == 1)
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.QUEST_BOOK_CANT_ABANDON_QUEST, ClientApplication.Localization.QUEST_BOOK_CANT_ABANDON_QUEST_MESSAGE));
                return;
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.QUEST_BOOK_BUTTON_CANCEL, ClientApplication.Localization.QUEST_BOOK_CANCEL_MESSAGE, function OnQusetCancelAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    ClientApplication.Instance.LocalGameClient.SendCancelQuest(_questsIdHash[quest]);
                    ClientApplication.Instance.TopHUD.QuestsPanel.Update();
                };
            }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
        }

        private function OnSelectQuest(_arg_1:Event):void
        {
            var _local_2:JMenuItem = (_arg_1.target as JMenuItem);
            if (!_local_2)
            {
                return;
            };
            this._curQuestIndex = _local_2.getClientProperty("index", 0);
            this.ShowQuest(this._curQuestIndex);
        }

        private function UpdateCounter():void
        {
            this._counterLabel.setText((((this._curQuestIndex + 1) + "/") + this._quests.length));
            if (this._curQuestIndex == 0)
            {
                this._leftArrow.alpha = 0;
                this._leftArrow.mouseEnabled = (this._leftArrow.buttonMode = false);
            }
            else
            {
                this._leftArrow.alpha = 1;
                this._leftArrow.mouseEnabled = (this._leftArrow.buttonMode = true);
            };
            if (this._curQuestIndex >= (this._quests.length - 1))
            {
                this._rightArrow.alpha = 0;
                this._rightArrow.mouseEnabled = (this._rightArrow.buttonMode = false);
            }
            else
            {
                this._rightArrow.alpha = 1;
                this._rightArrow.mouseEnabled = (this._rightArrow.buttonMode = true);
            };
        }

        private function ShowQuest(_arg_1:uint):void
        {
            var _local_6:Object;
            var _local_9:int;
            var _local_12:Object;
            var _local_13:AssetIcon;
            var _local_14:AssetIcon;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:ItemData;
            var _local_19:String;
            var _local_20:ItemData;
            var _local_21:Object;
            var _local_22:ItemData;
            var _local_23:String;
            var _local_24:Object;
            var _local_2:Object = this._quests[_arg_1];
            if (!_local_2)
            {
                return;
            };
            this.UpdateCounter();
            this.RevalidateNPC(_local_2.NpcId[0], ((_local_2.Bubble) ? _local_2.Bubble[0] : ""));
            this._titlePanel.setText(((_local_2.Name) || (ClientApplication.Localization.QUEST_WINDOW_UNKNOWN_NAME)));
            var _local_3:* = (("<p>" + ((_local_2["Description"]) || (ClientApplication.Localization.QUEST_WINDOW_EMPTY_DESCRIPTION))) + "</p>");
            this._descriptionText.setHtmlText(_local_3);
            var _local_4:ItemsResourceLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            var _local_5:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            this._tabsTask.setSelectedIndex(0);
            if (this._tabsTask.getTabCount() > 1)
            {
                this._tabsTask.removeTabAt(this._tabsTask.getIndex(this._requirePanel));
            };
            this._abandonButton.visible = (!(_local_2["Type"] == 1));
            this._requirePanel.removeAll();
            var _local_7:Object = _local_2["RequiredItemList"];
            if (((_local_7) && (_local_7.length > 0)))
            {
                for each (_local_12 in _local_7)
                {
                    _local_15 = ((_local_12["Item"]) || (0));
                    _local_16 = ((_local_12["Count"]) || (0));
                    if (_local_15 > 0)
                    {
                        _local_17 = 0;
                        _local_18 = new ItemData();
                        _local_18.NameId = _local_15;
                        _local_18.Identified = 1;
                        _local_18.Origin = ItemData.QUEST;
                        if (_local_15 == 3)
                        {
                            _local_17 = _local_5.money;
                        }
                        else
                        {
                            _local_20 = _local_5.GetItemByName(_local_15);
                            if (_local_20)
                            {
                                if (_local_20.Amount == 1)
                                {
                                    _local_17 = _local_5.GetAmountOfItemByName(_local_15);
                                }
                                else
                                {
                                    _local_17 = _local_20.Amount;
                                };
                            };
                        };
                        _local_18.Amount = _local_17;
                        _local_6 = _local_4.GetServerDescriptionObject(_local_18.NameId);
                        if (_local_6)
                        {
                            _local_18.Type = _local_6["type"];
                        };
                        _local_19 = ("[" + _local_17.toString());
                        if (_local_16 > 0)
                        {
                            _local_19 = (_local_19 + ("/" + _local_16.toString()));
                        };
                        _local_19 = (_local_19 + "]\n");
                        this._requirePanel.append(this.CreateRequireItem(_local_18, _local_19));
                    };
                };
                _local_13 = new AssetIcon(AsWingUtil.GetAssetLocalization("QW_TabProgress"));
                _local_14 = new AssetIcon(AsWingUtil.GetAssetLocalization("QW_TabProgressActive"));
                this._tabsTask.AppendCustomTab(this._requirePanel, _local_13, _local_14, ClientApplication.Instance.GetPopupText(270));
            };
            this._rewardPanel.removeAll();
            var _local_8:Object = _local_2["RewardItemList"];
            this._rewardLabel.visible = ((_local_8) && (_local_8.length));
            if (this._rewardLabel.visible)
            {
                for each (_local_21 in _local_8)
                {
                    _local_22 = new ItemData();
                    _local_22.Amount = ((_local_21["Count"]) || (0));
                    _local_22.NameId = ((_local_21["Item"]) || (0));
                    _local_22.Identified = 1;
                    _local_22.Origin = ItemData.QUEST;
                    _local_6 = _local_4.GetServerDescriptionObject(_local_22.NameId);
                    if (_local_6)
                    {
                        _local_22.Type = _local_6["type"];
                    };
                    this._rewardPanel.append(this.CreateRewardItem(_local_22));
                };
            };
            _local_9 = this.GetQuestState(_local_2);
            var _local_10:* = (_local_9 == _local_2.Complete);
            this._completeIcon.visible = _local_10;
            this._mercenaryPanel.visible = ((_local_2.Price > 0) && (!(_local_10)));
            if (this._mercenaryPanel.visible)
            {
                this._mercenaryPrice.setText(_local_2.Price);
            };
            this._findCheckBox.visible = false;
            var _local_11:String = ClientApplication.Localization.QUEST_WINDOW_UNKNOWN_LOCATION;
            if (_local_2.Locations)
            {
                if (_local_10)
                {
                    _local_23 = _local_2.Locations[(_local_2.Locations.length - 1)];
                    this._findCheckBox.visible = true;
                }
                else
                {
                    if (_local_2.Locations.length > 1)
                    {
                        switch (_local_2.NpcId.length)
                        {
                            case 2:
                            case 3:
                                _local_23 = _local_2.Locations[0];
                                break;
                            default:
                                _local_23 = _local_2.Locations[(_local_9 - 1)];
                        };
                        this._findCheckBox.visible = true;
                    };
                };
                if (this._findCheckBox.visible)
                {
                    this._findCheckBox.setSelected((HelpManager.Instance.GetRoadAtlas().QuestId == this._questsIdHash[_local_2]));
                };
                _local_24 = this._dataLibrary.GetMapsData(((_local_23) || ("")));
                if (_local_24)
                {
                    _local_11 = _local_24.Name;
                };
            };
            this._locationLabel.setText(_local_11);
            HelpManager.Instance.UpdateQuestsHelper();
        }

        private function ShowFake():void
        {
            this._counterLabel.setText("0/0");
            this._leftArrow.alpha = 0;
            this._leftArrow.mouseEnabled = (this._leftArrow.buttonMode = false);
            this._rightArrow.alpha = 0;
            this._rightArrow.mouseEnabled = (this._rightArrow.buttonMode = false);
            this.RevalidateNPC(0, "");
            this._titlePanel.setText("");
            this._descriptionText.setHtmlText((("<p>" + ClientApplication.Localization.QUEST_WINDOW_NOT_QUESTS_DESCRIPTION) + "</p>"));
            this._tabsTask.setSelectedIndex(0);
            if (this._tabsTask.getTabCount() > 1)
            {
                this._tabsTask.removeTabAt(this._tabsTask.getIndex(this._requirePanel));
            };
            this._abandonButton.visible = false;
            this._completeIcon.visible = false;
            this._requirePanel.removeAll();
            this._rewardPanel.removeAll();
            this._rewardLabel.visible = false;
            this._mercenaryPanel.visible = false;
            this._findCheckBox.visible = false;
            this._locationLabel.setText("");
        }

        private function GetQuestState(_arg_1:Object):int
        {
            var _local_2:int = this._questsIdHash[_arg_1];
            var _local_3:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            return (_local_3.QuestStates[_local_2]);
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
            AsWingUtil.SetBackgroundFromAsset(_local_6, "QW_IconFrame");
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

        private function CreateRequireItem(_arg_1:ItemData, _arg_2:String=""):JPanel
        {
            var _local_5:InventoryStoreItem;
            var _local_3:JPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetBorder(_local_3, 0, 3);
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 2, SoftBoxLayout.LEFT));
            _local_5 = new InventoryStoreItem(_arg_1);
            AsWingUtil.SetSize(_local_5, 32, 32);
            var _local_6:String = ((_local_5.Item.Identified == 1) ? _local_5.Name : (_local_5.Name + "?"));
            var _local_7:JLabel = AsWingUtil.CreateLabel((_arg_2 + _local_6), 1050118, new ASFont(HtmlText.fontName, 14));
            AsWingUtil.SetWidth(_local_7, 170);
            _local_7.setHorizontalAlignment(JLabel.LEFT);
            _local_4.appendAll(AsWingUtil.AlignCenter(_local_5), _local_7);
            _local_3.append(_local_4);
            return (_local_3);
        }

        private function RevalidateNPC(_arg_1:uint, _arg_2:String):void
        {
            var _local_3:Object;
            var _local_5:AttachIcon;
            var _local_7:String;
            _local_3 = this._dataLibrary.GetNpcDataFromId(_arg_1.toString());
            var _local_4:Boolean;
            var _local_6:int = (((!(_local_3 == null)) && (_local_3["Icon"] > 0)) ? _local_3["Icon"] : 402);
            if (_local_6 >= 400)
            {
                AsWingUtil.SetBackgroundFromAsset(this._npcIconBig, ("Npc" + _local_6));
                _local_4 = true;
            }
            else
            {
                _local_7 = ("AdditionalData_Item_Npc" + _local_6);
                _local_5 = new AttachIcon(_local_7);
            };
            if (_local_3 != null)
            {
                this._npcNameLabel.setText(_local_3.Name);
            }
            else
            {
                this._npcNameLabel.setText("");
            };
            if (_local_4)
            {
                this._npcIconBig.visible = true;
                this._frameIcon.visible = false;
            }
            else
            {
                this._npcIconBig.visible = false;
                this._frameIcon.visible = true;
                if (((!(_local_5)) || (!(_local_5.getAsset()))))
                {
                    _local_5 = new AttachIcon("AdditionalData_Item_NpcDialogTestNpc");
                };
                this._npcIcon.setIcon(_local_5);
            };
            this._bubbleDialog.Text = _arg_2;
        }

        private function OnClose(_arg_1:Event):void
        {
            CloseWithAnimation();
        }

        override public function dispose():void
        {
            super.dispose();
            HelpManager.Instance.UpdateQuestsHelper();
        }

        public function ShowQuestWindow(_arg_1:uint=0):void
        {
            ShowWithAnimation();
            this._showQuestId = _arg_1;
            if (HelpManager.Instance.QuestsPressed())
            {
                this._showQuestId = HelpManager.Instance.QuestID;
            };
        }


    }
}//package hbm.Game.GUI.QuestBook

