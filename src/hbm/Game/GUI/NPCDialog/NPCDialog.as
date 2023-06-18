


//hbm.Game.GUI.NPCDialog.NPCDialog

package hbm.Game.GUI.NPCDialog
{
    import hbm.Game.GUI.Tools.ShadowWindow;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import org.aswing.JPanel;
    import org.aswing.JLabel;
    import hbm.Game.GUI.Tools.BubbleDialog;
    import org.aswing.JList;
    import org.aswing.JTextField;
    import org.aswing.JAdjuster;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Game.Utility.AsWingUtil;
    import org.aswing.EmptyLayout;
    import org.aswing.BorderLayout;
    import org.aswing.ASFont;
    import hbm.Game.Utility.HtmlText;
    import flash.events.Event;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.JTextArea;
    import org.aswing.JScrollPane;
    import hbm.Engine.Actors.ItemData;
    import org.aswing.ASColor;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.GUI.Inventory.InventoryStoreItem;
    import org.aswing.AttachIcon;
    import org.aswing.event.ListItemEvent;
    import org.aswing.JScrollBar;
    import org.aswing.border.EmptyBorder;
    import hbm.Game.GUI.Tools.StandardButtonsFactory;
    import org.aswing.JButton;
    import org.aswing.geom.IntDimension;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import org.aswing.Insets;
    import org.aswing.FlowLayout;

    public class NPCDialog extends ShadowWindow 
    {

        public static const ON_NEXT_PRESSED:String = "ON_NEXT_PRESSED";
        public static const ON_NPC_DIALOG_CANCELED:String = "ON_NPC_DIALOG_CANCELED";
        public static const ON_NPC_TALK_OK_PRESSED:String = "ON_NPC_TALK_OK_PRESSED";
        public static const ON_NPC_DIALOG_ALL_CANCELED:String = "ON_NPC_DIALOG_ALL_CANCELED";
        public static const ON_NPC_TALK_INPUT_PRESSED:String = "ON_NPC_TALK_INPUT_PRESSED";
        public static const ON_NPC_TALK_INPUT_CANCELED:String = "ON_NPC_TALK_INPUT_CANCELED";
        public static const STATE_NPC_TALK:uint = 0;
        public static const STATE_NPC_QUEST_ACCEPT:uint = 1;
        public static const STATE_NPC_QUEST_REWARD:uint = 2;

        private var _characterInfo:CharacterInfo;
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _width:int = 899;
        private var _height:int = 890;
        private var _npcIconBig:JPanel;
        private var _frameIcon:JPanel;
        private var _npcIcon:JLabel;
        private var _longWindowHeight:int = 520;
        private var _forseClose:Boolean = false;
        private var _npcId:int;
        private var _npcDialogPanel:JPanel;
        private var _answerPanel:JPanel;
        private var _bubbleDialog:BubbleDialog;
        private var _answerListBox:JList;
        private var _answerLabel:JLabel;
        private var _questPanel:JPanel;
        private var _isNumberInput:Boolean;
        private var _inputTextField:JTextField;
        private var _inputNumberAdjuster:JAdjuster;
        private var _string:String;
        private var _number:int;
        private var _stateDialog:uint;
        private var _paramState:Object;

        public function NPCDialog(_arg_1:int)
        {
            this._npcId = _arg_1;
            this._characterInfo = ClientApplication.Instance.LocalGameClient.ActorList.actors[_arg_1];
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            super();
        }

        override protected function InitUI():void
        {
            super.InitUI();
            AsWingUtil.SetSize(_window, this._width, this._height);
            this.CreateNPCTalkPanel();
            this._npcDialogPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetBackgroundFromAsset(this._npcDialogPanel, "NewNpcDialogBackground");
            this._npcDialogPanel.setLocationXY(140, 390);
            this._answerLabel = new JLabel(ClientApplication.Localization.DLG_NPC_ANSWER_TITLE, null, JLabel.LEFT);
            this._npcDialogPanel.append(this._answerLabel);
            this._answerPanel = new JPanel(new BorderLayout());
            AsWingUtil.SetSize(this._answerPanel, 564, 362);
            this._answerPanel.setLocationXY(135, 110);
            this._npcDialogPanel.append(this._answerPanel);
            this._questPanel = new JPanel(new EmptyLayout());
            AsWingUtil.SetSize(this._questPanel, 760, 376);
            this._npcDialogPanel.append(this._questPanel);
            var _local_1:JLabel = AsWingUtil.CreateLabel(ClientApplication.Localization.DLG_NPC_TITLE, 15253613, new ASFont(HtmlText.fontName, 22, false));
            AsWingUtil.SetSize(_local_1, 330, 45);
            _local_1.setLocationXY(270, 50);
            this._npcDialogPanel.append(_local_1);
            var _local_2:String = (((!(this._characterInfo == null)) && (!(this._characterInfo.internalName == "Unknown"))) ? this._characterInfo.internalName : "");
            var _local_3:JLabel = AsWingUtil.CreateLabel(_local_2, 16767612, new ASFont(getFont().getName(), 12, false));
            _local_3.setTextFilters([HtmlText.glow]);
            AsWingUtil.SetSize(_local_3, 238, 24);
            _local_3.setLocationXY(72, 10);
            this._npcDialogPanel.append(_local_3);
            _window.append(this._npcDialogPanel);
            this.SelectStateDialog(STATE_NPC_TALK);
        }

        public function SelectStateDialog(_arg_1:uint, _arg_2:Object=null):void
        {
            this._stateDialog = _arg_1;
            this._paramState = _arg_2;
        }

        private function UpdateState():void
        {
            switch (this._stateDialog)
            {
                case STATE_NPC_TALK:
                    this._answerPanel.visible = true;
                    this._questPanel.visible = false;
                    AsWingUtil.SetSize(this._answerPanel, 580, 360);
                    this._answerPanel.setLocationXY(135, 110);
                    return;
                case STATE_NPC_QUEST_ACCEPT:
                    this._questPanel.visible = true;
                    this._answerPanel.visible = true;
                    AsWingUtil.SetSize(this._answerPanel, 580, 90);
                    this._answerPanel.setLocationXY(135, 385);
                    AsWingUtil.SetSize(this._questPanel, 760, 376);
                    this.ShowQuestDialog(int(this._paramState), false);
                    this._stateDialog = STATE_NPC_TALK;
                    return;
                case STATE_NPC_QUEST_REWARD:
                    this._questPanel.visible = true;
                    this._answerPanel.visible = false;
                    AsWingUtil.SetSize(this._questPanel, 760, 500);
                    this.ShowQuestDialog(int(this._paramState), true);
                    this._stateDialog = STATE_NPC_TALK;
                    return;
            };
        }

        private function OnApplyReward(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendTalkResponse(this._npcId, 1);
        }

        private function ShowQuestDialog(_arg_1:int, _arg_2:Boolean):void
        {
            var _local_4:ItemsResourceLibrary;
            var _local_5:JPanel;
            var _local_6:Object;
            var _local_7:JPanel;
            var _local_8:JPanel;
            var _local_9:CustomButton;
            var _local_10:String;
            var _local_11:JTextArea;
            var _local_12:JScrollPane;
            var _local_13:JLabel;
            var _local_14:Object;
            var _local_15:ItemData;
            var _local_16:Object;
            this._questPanel.removeAll();
            var _local_3:Object = this._dataLibrary.GetQuestsData(_arg_1);
            if (_local_3)
            {
                _local_4 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
                if (_arg_2)
                {
                    _local_8 = new JPanel();
                    AsWingUtil.SetBackgroundFromAssetLocalization(_local_8, "QW_Congratulation");
                    _local_8.setLocationXY(119, 97);
                    this._questPanel.append(_local_8);
                    _local_9 = AsWingUtil.CreateCustomButtonFromAssetLocalization("QW_ApplyButton", "QW_ApplyButtonOver", "QW_ApplyButtonPress");
                    _local_9.setLocationXY(292, 428);
                    _local_9.addActionListener(this.OnApplyReward, 0, true);
                    this._questPanel.append(_local_9);
                }
                else
                {
                    _local_10 = (("<p>" + ((_local_3["Description"]) || (ClientApplication.Localization.QUEST_WINDOW_EMPTY_DESCRIPTION))) + "</p>");
                    _local_11 = AsWingUtil.CreateTextArea(_local_10);
                    _local_11.setForeground(new ASColor(0));
                    _local_11.setFont(new ASFont(HtmlText.fontName, 14, false));
                    AsWingUtil.SetBorder(_local_11, 10, 25);
                    AsWingUtil.SetWidth(_local_11, 560);
                    _local_12 = new JScrollPane(_local_11, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_NEVER);
                    AsWingUtil.SetBackgroundFromAssetLocalization(_local_12, "QW_TaskPanel");
                    _local_12.setLocationXY(119, 97);
                    this._questPanel.append(_local_12);
                };
                _local_5 = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 10, SoftBoxLayout.CENTER));
                _local_6 = _local_3["RewardItemList"];
                if (((_local_6) && (_local_6.length)))
                {
                    _local_13 = AsWingUtil.CreateLabel(ClientApplication.Localization.QUEST_WINDOW_REWARD_LABEL, 0, new ASFont(HtmlText.fontName, 14, false));
                    AsWingUtil.SetSize(_local_13, 600, 25);
                    _local_13.setLocationXY(110, 240);
                    this._questPanel.append(_local_13);
                    for each (_local_14 in _local_6)
                    {
                        _local_15 = new ItemData();
                        _local_15.Amount = ((_local_14["Count"]) || (0));
                        _local_15.NameId = ((_local_14["Item"]) || (0));
                        _local_15.Identified = 1;
                        _local_15.Origin = ItemData.QUEST;
                        _local_16 = _local_4.GetServerDescriptionObject(_local_15.NameId);
                        if (_local_16)
                        {
                            _local_15.Type = _local_16["type"];
                        };
                        _local_5.append(this.CreateRewardItem(_local_15));
                    };
                };
                _local_7 = new JPanel(new BorderLayout());
                _local_7.setLocationXY(110, 270);
                AsWingUtil.SetSize(_local_7, 600, 110);
                _local_7.append(AsWingUtil.AlignCenter(_local_5));
                this._questPanel.append(_local_7);
            };
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
            var _local_8:JPanel = AsWingUtil.CreateCenterTextFromWidth(_local_7, 1050118, new ASFont(HtmlText.fontName, 13), 120);
            _local_3.appendAll(AsWingUtil.AlignCenter(_local_6), _local_8);
            _local_2.append(_local_3);
            return (_local_2);
        }

        protected function CreateNPCTalkPanel():void
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
            this._frameIcon.setLocationXY(184, 258);
            _window.append(this._frameIcon);
            this.RevalidateNPC();
        }

        private function RevalidateNPC():void
        {
            var _local_1:Object;
            var _local_3:AttachIcon;
            var _local_5:String;
            _local_1 = this._dataLibrary.GetNpcDataFromName(this._characterInfo.name);
            var _local_2:Boolean;
            var _local_4:int = (((!(_local_1 == null)) && (_local_1["Icon"] > 0)) ? _local_1["Icon"] : 402);
            if (_local_4 >= 400)
            {
                AsWingUtil.SetBackgroundFromAsset(this._npcIconBig, ("Npc" + _local_4));
                _local_2 = true;
            }
            else
            {
                _local_5 = ("AdditionalData_Item_Npc" + _local_4);
                _local_3 = new AttachIcon(_local_5);
            };
            if (_local_2)
            {
                this._npcIconBig.visible = true;
                this._frameIcon.visible = false;
            }
            else
            {
                this._npcIconBig.visible = false;
                this._frameIcon.visible = true;
                if (((!(_local_3)) || (!(_local_3.getAsset()))))
                {
                    _local_3 = new AttachIcon("AdditionalData_Item_NpcDialogTestNpc");
                };
                this._npcIcon.setIcon(_local_3);
            };
        }

        public function AddTextMessage(_arg_1:String):void
        {
            var _local_2:String = this._bubbleDialog.Text;
            if (0 != _local_2.length)
            {
                _local_2 = (_local_2 + "\n");
            };
            _local_2 = (_local_2 + _arg_1);
            this._bubbleDialog.Text = _local_2;
        }

        public function ClearTextMessage():void
        {
            this._bubbleDialog.Text = "";
        }

        private function OnNextPressed(_arg_1:Event):void
        {
            dispatchEvent(new Event(ON_NEXT_PRESSED));
        }

        public function EnableTalkPanel(_arg_1:Boolean=true):void
        {
        }

        public function EnableAnswerPanel(_arg_1:Boolean=true):void
        {
            if (!_arg_1)
            {
                this.UpdateNPCTalkAnswersPanel([ClientApplication.Localization.DLG_NPC_NEXT_BUTTON]);
                this._answerListBox.removeEventListener(ListItemEvent.ITEM_CLICK, this.OnAnswerListItemClicked);
                this._answerListBox.addEventListener(ListItemEvent.ITEM_CLICK, this.OnNextPressed);
            };
        }

        protected function UpdateNPCTalkAnswersPanel(_arg_1:Array=null, _arg_2:Boolean=false):void
        {
            var _local_3:JScrollPane;
            var _local_4:JScrollBar;
            var _local_5:JPanel;
            var _local_6:EmptyBorder;
            var _local_7:StandardButtonsFactory;
            var _local_8:JButton;
            var _local_9:JButton;
            var _local_10:JPanel;
            this.UpdateState();
            this._answerPanel.removeAll();
            if (_arg_1)
            {
                this._answerListBox = new JList(_arg_1);
                this._answerListBox.setSelectedIndex(-1);
                this._answerListBox.addEventListener(ListItemEvent.ITEM_CLICK, this.OnAnswerListItemClicked);
                this._answerListBox.setCellFactory(new DialogAnswerListCellFactory());
                this._answerListBox.setVerticalUnitIncrement(3);
                _local_3 = new JScrollPane(this._answerListBox);
                _local_3.setPreferredSize(new IntDimension(564, 360));
                _local_4 = new JScrollBar();
                _local_4.setBackground(new ASColor(988700));
                _local_4.setMideground(new ASColor(1522507));
                _local_3.setVerticalScrollBar(_local_4);
                this._answerPanel.append(_local_3, BorderLayout.CENTER);
                HelpManager.Instance.UpdateNPCTalkHelper();
            }
            else
            {
                if (_arg_2)
                {
                    _local_5 = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS));
                    _local_6 = new EmptyBorder(null, new Insets(10, 5, 5, 5));
                    _local_5.setBorder(_local_6);
                    if (this._isNumberInput)
                    {
                        this._inputNumberAdjuster = new JAdjuster(3);
                        this._inputNumberAdjuster.setMinimum(1);
                        this._inputNumberAdjuster.setMaximum(100);
                        this._inputNumberAdjuster.setValue(1);
                        this._inputNumberAdjuster.setEditable(true);
                        _local_5.append(this._inputNumberAdjuster);
                        _local_5.setPreferredWidth(50);
                    }
                    else
                    {
                        this._inputTextField = new JTextField("", 70);
                        this._inputTextField.setMaxChars(70);
                        _local_5.append(this._inputTextField);
                    };
                    this._answerPanel.append(_local_5, BorderLayout.NORTH);
                    _local_7 = new StandardButtonsFactory();
                    _local_8 = _local_7.CreateButton(StandardButtonsFactory.OK);
                    _local_8.addActionListener(this.OnInputPressed, 0, true);
                    _local_9 = _local_7.CreateButton(StandardButtonsFactory.CANCEL);
                    _local_9.addActionListener(this.OnInputCanceled, 0, true);
                    _local_10 = new JPanel(new FlowLayout());
                    _local_10.setBorder(new EmptyBorder(null, new Insets(0, 0, 10, 0)));
                    _local_10.append(_local_8);
                    _local_10.append(_local_9);
                    this._answerPanel.append(_local_10, BorderLayout.SOUTH);
                };
            };
            this._answerPanel.revalidate();
        }

        public function SetAnswers(_arg_1:Array):void
        {
            if (this._npcDialogPanel)
            {
                this.UpdateNPCTalkAnswersPanel(_arg_1);
            };
        }

        public function InputValue(_arg_1:Boolean=false):void
        {
            this._isNumberInput = _arg_1;
            if (this._npcDialogPanel)
            {
                this.UpdateNPCTalkAnswersPanel(null, true);
            };
        }

        public function GetInputString():String
        {
            return (this._string);
        }

        public function GetInputNumber():int
        {
            return (this._number);
        }

        public function GetAnswerItems():Array
        {
            var _local_2:DialogAnswerListCell;
            var _local_3:uint;
            var _local_1:Array = [];
            if (this._answerListBox)
            {
                _local_3 = 0;
                while ((_local_2 = (this._answerListBox.getCellByIndex(_local_3++) as DialogAnswerListCell)))
                {
                    _local_1.push(_local_2);
                };
            };
            return (_local_1);
        }

        public function GetSelectedIndex():int
        {
            return (this._answerListBox.getSelectedIndex() + 1);
        }

        private function OnAnswerListItemClicked(_arg_1:ListItemEvent):void
        {
            dispatchEvent(new Event(ON_NPC_TALK_OK_PRESSED));
        }

        public function OnInputPressed(_arg_1:Event):void
        {
            if (this._isNumberInput)
            {
                this._number = this._inputNumberAdjuster.getValue();
                this._string = null;
            }
            else
            {
                this._string = this._inputTextField.getText();
                this._number = 0;
            };
            dispatchEvent(new Event(ON_NPC_TALK_INPUT_PRESSED));
        }

        public function OnInputCanceled(_arg_1:Event):void
        {
            dispatchEvent(new Event(ON_NPC_TALK_INPUT_CANCELED));
        }

        public function get IsNumberInput():Boolean
        {
            return (this._isNumberInput);
        }

        public function get NPCId():int
        {
            return (this._npcId);
        }

        public function get HaveToClose():Boolean
        {
            return (this._forseClose);
        }

        public function set HaveToClose(_arg_1:Boolean):void
        {
            this._forseClose = _arg_1;
        }


    }
}//package hbm.Game.GUI.NPCDialog

