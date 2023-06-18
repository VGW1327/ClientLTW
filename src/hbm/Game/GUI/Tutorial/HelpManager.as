


//hbm.Game.GUI.Tutorial.HelpManager

package hbm.Game.GUI.Tutorial
{
    import hbm.Game.Utility.HelpArrow;
    import org.aswing.JPopupMenu;
    import hbm.Engine.PathFinding.RoadAtlas;
    import hbm.Application.ClientApplication;
    import flash.utils.clearTimeout;
    import hbm.Game.Statistic.StatisticManager;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.GUI.CharacterStats.CharacterStatsButton;
    import hbm.Game.GUI.CharacterInventory.CharacterInventoryWindow;
    import org.aswing.JPanel;
    import hbm.Game.GUI.Inventory.InventoryItem;
    import flash.display.DisplayObject;
    import hbm.Game.GUI.Skills.SkillItem;
    import hbm.Game.GUI.Skills.SkillWindow;
    import hbm.Game.GUI.NPCDialog.DialogAnswerListCell;
    import hbm.Game.GUI.NPCDialog.NPCDialog;
    import hbm.Game.GUI.QuestBook.QuestsWindow;
    import hbm.Game.GUI.PremiumShop.NewShopArea;
    import hbm.Game.GUI.CashShopNew.NewShopItem;
    import hbm.Game.GUI.PremiumShop.PremiumShopWindow;
    import flash.utils.setTimeout;
    import org.aswing.JMenuItem;
    import flash.events.Event;

    public class HelpManager 
    {

        public static const NPC_NAME:String = "KeyArrowNext";
        public static const NPC_NAME2:String = "KeyArrowNext2";
        public static const WRONG_SKILL_NPC_NAME:String = "ClickWrongSkill";
        public static var _equipItemId:uint;
        public static var _useItemId:uint;
        public static var _buyItemId:uint;
        public static var _questId:uint;
        public static var _statId:uint;
        public static var _learnSkillId:uint;
        public static const SELECT_MOB_NAME:Array = ["ProdavshiysjaOhrannik", "KrylatajaTvar", "PrizrachnyyPereyarok"];
        public static const NO_HELPER:uint = 0;
        public static const FULL_SCREEN_BUTTON_HELPER:uint = 1;
        public static const EQUIP_ITEM_HELPER:uint = 2;
        public static const USE_ITEM_HELPER:uint = 3;
        public static const LEARN_SKILL_HELPER:uint = 4;
        public static const MOVE_TO_MAP_POINT_HELPER:uint = 6;
        public static const NPC_DIALOG_QUEST_HELPER:uint = 7;
        public static const NPC_DIALOG_ACCEPT_QUEST_HELPER:uint = 8;
        public static const NPC_DIALOG_CLOSE_HELPER:uint = 9;
        public static const QUEST_WINDOW_HELPER:uint = 10;
        public static const PREMIUM_SHOP_WINDOW_HELPER:uint = 11;
        public static const NPC_DIALOG_FINISH_QUEST_HELPER:uint = 12;
        public static const ADD_STAT_HELPER:uint = 13;
        public static const USE_SKILL_HELPER:uint = 14;
        public static const APPLY_TUTORIAL_BUTTON_HELPER:uint = 15;
        private static const NPC_TALK_ICONS:Object = {
            "7":"b_qutake",
            "8":"b_yes",
            "9":"b_close",
            "12":"b_qudone"
        };
        private static const _instance:HelpManager = new (HelpManager)();
        private static var _singletone:Boolean = false;

        private const _helpArrow:HelpArrow = new HelpArrow();

        private var _menu:JPopupMenu;
        private var _currentHelper:uint = 0;
        private var _timerId:uint;
        private var _roadAtlas:RoadAtlas;

        public function HelpManager()
        {
            if (_singletone)
            {
                throw ("Can't create class HelpManager!");
            };
            _singletone = true;
        }

        public static function get Instance():HelpManager
        {
            return (_instance);
        }


        public function GetRoadAtlas():RoadAtlas
        {
            this._roadAtlas = ((this._roadAtlas) || (new RoadAtlas()));
            return (this._roadAtlas);
        }

        public function ShowHelper(_arg_1:uint, _arg_2:Object=null):void
        {
            var _local_3:TutorialWindow;
            this._currentHelper = _arg_1;
            switch (this._currentHelper)
            {
                case FULL_SCREEN_BUTTON_HELPER:
                    this._helpArrow.Attach(ClientApplication.Instance.TopHUD.GetTopHUD._mapPanel._fullscreenButton, HelpArrow.NE_ROTATE, 2);
                    break;
                case EQUIP_ITEM_HELPER:
                    _equipItemId = _arg_2[1];
                    this.UpdateInventoryHelper();
                    break;
                case USE_ITEM_HELPER:
                    _useItemId = _arg_2[1];
                    this.UpdateInventoryHelper();
                    break;
                case LEARN_SKILL_HELPER:
                    _learnSkillId = _arg_2[1];
                    this.UpdateSkillHelper();
                    break;
                case MOVE_TO_MAP_POINT_HELPER:
                    if (_arg_2)
                    {
                        this._helpArrow.AttachToCameraPoint(_arg_2.x, _arg_2.y);
                    };
                    break;
                case NPC_DIALOG_QUEST_HELPER:
                case NPC_DIALOG_ACCEPT_QUEST_HELPER:
                case NPC_DIALOG_CLOSE_HELPER:
                case NPC_DIALOG_FINISH_QUEST_HELPER:
                    this.UpdateNPCTalkHelper();
                    break;
                case QUEST_WINDOW_HELPER:
                    _questId = _arg_2[1];
                    this.UpdateQuestsHelper();
                    break;
                case PREMIUM_SHOP_WINDOW_HELPER:
                    _buyItemId = _arg_2[1];
                    this.UpdatePremiumShopHelper();
                    break;
                case ADD_STAT_HELPER:
                    _statId = _arg_2[1];
                    this.UpdateStatsHelper();
                    break;
                case USE_SKILL_HELPER:
                    this.ShowUseSkillHelper(_arg_2[1]);
                    return;
                case APPLY_TUTORIAL_BUTTON_HELPER:
                    _local_3 = ClientApplication.Instance.TopHUD.GetTutorialPanel().GetTutorialWindow();
                    if (_local_3)
                    {
                        this._helpArrow.Attach(_local_3.DoButton, HelpArrow.SW_ROTATE, 2);
                    };
                    break;
                default:
                    this.ResetHelper();
            };
            if (this._timerId > 0)
            {
                clearTimeout(this._timerId);
                this._timerId = 0;
            };
        }

        public function ResetHelper():void
        {
            this._helpArrow.Detach();
            this._currentHelper = NO_HELPER;
        }

        public function FullScreenPressed():void
        {
            if (this._currentHelper == FULL_SCREEN_BUTTON_HELPER)
            {
                this.SendCompleteHelp();
                this.ResetHelper();
            };
        }

        public function ApplyTutorialPressed():void
        {
            if (this._currentHelper == APPLY_TUTORIAL_BUTTON_HELPER)
            {
                this.ResetHelper();
            };
        }

        public function CharacterInventoryPressed():void
        {
            var _local_1:uint;
            switch (this._currentHelper)
            {
                case ADD_STAT_HELPER:
                    if (ClientApplication.Instance.IsFirstCharacter())
                    {
                        StatisticManager.Instance.SendEvent("tut09_Task3Do1_stats");
                        _local_1 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerRace();
                        switch (_local_1)
                        {
                            case CharacterInfo.RACE_HUMAN:
                                StatisticManager.Instance.SendEvent("tutH09_Task3Do1_stats");
                                break;
                            case CharacterInfo.RACE_ORC:
                                StatisticManager.Instance.SendEvent("tutO09_Task3Do1_stats");
                                break;
                        };
                    };
                    return;
                case EQUIP_ITEM_HELPER:
                    if (ClientApplication.Instance.IsFirstCharacter())
                    {
                        StatisticManager.Instance.SendEvent("tut12_Task4Do1_equip");
                        _local_1 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerRace();
                        switch (_local_1)
                        {
                            case CharacterInfo.RACE_HUMAN:
                                StatisticManager.Instance.SendEvent("tutH12_Task4Do1_equip");
                                break;
                            case CharacterInfo.RACE_ORC:
                                StatisticManager.Instance.SendEvent("tutO12_Task4Do1_equip");
                                break;
                        };
                    };
                    return;
                case USE_ITEM_HELPER:
                    if (ClientApplication.Instance.IsFirstCharacter())
                    {
                        StatisticManager.Instance.SendEvent("tut23_Task7Do1_heal");
                        _local_1 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerRace();
                        switch (_local_1)
                        {
                            case CharacterInfo.RACE_HUMAN:
                                StatisticManager.Instance.SendEvent("tutH23_Task7Do1_heal");
                                break;
                            case CharacterInfo.RACE_ORC:
                                StatisticManager.Instance.SendEvent("tutO23_Task7Do1_heal");
                                break;
                        };
                    };
                    return;
            };
        }

        public function SelectInventoryTab():void
        {
            var _local_1:uint;
            if (this._currentHelper != USE_ITEM_HELPER)
            {
                return;
            };
            if (ClientApplication.Instance.IsFirstCharacter())
            {
                StatisticManager.Instance.SendEvent("tut24_Task7Do2_heal");
                _local_1 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerRace();
                switch (_local_1)
                {
                    case CharacterInfo.RACE_HUMAN:
                        StatisticManager.Instance.SendEvent("tutH24_Task7Do2_heal");
                        return;
                    case CharacterInfo.RACE_ORC:
                        StatisticManager.Instance.SendEvent("tutO24_Task7Do2_heal");
                        return;
                };
            };
        }

        public function SkillsPressed():void
        {
            var _local_1:int;
            var _local_2:uint;
            switch (this._currentHelper)
            {
                case LEARN_SKILL_HELPER:
                    if (ClientApplication.Instance.IsFirstCharacter())
                    {
                        StatisticManager.Instance.SendEvent("tut18_Task6Do1_skill");
                        _local_1 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().jobId;
                        StatisticManager.Instance.SendEvent(("tut18_Task6Do1_skill" + _local_1));
                        _local_2 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerRace();
                        switch (_local_2)
                        {
                            case CharacterInfo.RACE_HUMAN:
                                StatisticManager.Instance.SendEvent("tutH18_Task6Do1_skill");
                                StatisticManager.Instance.SendEvent(("tutH18_Task6Do1_skill" + _local_1));
                                break;
                            case CharacterInfo.RACE_ORC:
                                StatisticManager.Instance.SendEvent("tutO18_Task6Do1_skill");
                                StatisticManager.Instance.SendEvent(("tutO18_Task6Do1_skill" + _local_1));
                                break;
                        };
                    };
                    return;
            };
        }

        public function QuestsPressed():Boolean
        {
            var _local_1:uint;
            if (this._currentHelper == QUEST_WINDOW_HELPER)
            {
                if (ClientApplication.Instance.IsFirstCharacter())
                {
                    StatisticManager.Instance.SendEvent("tut34_Task11Do1_qlogop");
                    _local_1 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerRace();
                    switch (_local_1)
                    {
                        case CharacterInfo.RACE_HUMAN:
                            StatisticManager.Instance.SendEvent("tutH34_Task11Do1_qlogop");
                            break;
                        case CharacterInfo.RACE_ORC:
                            StatisticManager.Instance.SendEvent("tutO34_Task11Do1_qlogop");
                            break;
                    };
                };
                return (true);
            };
            return (false);
        }

        public function get QuestID():uint
        {
            return (_questId);
        }

        public function BuyItem(_arg_1:uint):void
        {
            if (((this._currentHelper == PREMIUM_SHOP_WINDOW_HELPER) && (_buyItemId == _arg_1)))
            {
                this.SendCompleteHelp();
                this.ResetHelper();
            };
        }

        public function AddStatPressed():void
        {
            if (this._currentHelper != ADD_STAT_HELPER)
            {
                return;
            };
            this.SendCompleteHelp();
            this.ResetHelper();
        }

        public function SelectMob(_arg_1:String):void
        {
            if (SELECT_MOB_NAME.indexOf(_arg_1) >= 0)
            {
                this.SendCompleteHelp();
            };
        }

        public function UpdateStatsHelper():void
        {
            var _local_2:CharacterStatsButton;
            if (this._currentHelper != ADD_STAT_HELPER)
            {
                return;
            };
            var _local_1:CharacterInventoryWindow = ClientApplication.Instance.GetCharacterInventoryWindow();
            if (((_local_1) && (_local_1.isShowing())))
            {
                _local_2 = _local_1.GetButtonAddStat(_statId);
                if (_local_2)
                {
                    this._helpArrow.Attach(_local_2, HelpArrow.W_ROTATE);
                }
                else
                {
                    this.ResetHelper();
                };
            }
            else
            {
                this._helpArrow.Attach(ClientApplication.Instance.BottomHUD.GetBottomHUD._characterButton, 0, 2, true);
            };
        }

        public function UpdateInventoryHelper():void
        {
            var _local_3:JPanel;
            var _local_4:InventoryItem;
            var _local_5:DisplayObject;
            var _local_1:uint;
            switch (this._currentHelper)
            {
                case EQUIP_ITEM_HELPER:
                    _local_1 = _equipItemId;
                    break;
                case USE_ITEM_HELPER:
                    _local_1 = _useItemId;
                    break;
                default:
                    return;
            };
            if (this._currentHelper == USE_ITEM_HELPER)
            {
                _local_3 = ClientApplication.Instance.BottomHUD.InventoryBarInstance.GetSlotForItem(_local_1);
                if (_local_3)
                {
                    this._helpArrow.Attach(_local_3, HelpArrow.S_ROTATE);
                    return;
                };
            };
            var _local_2:CharacterInventoryWindow = ClientApplication.Instance.GetCharacterInventoryWindow();
            if (((_local_2) && (_local_2.isShowing())))
            {
                _local_4 = _local_2.GetInventoryItem(_local_1);
                if (_local_4)
                {
                    _local_5 = _local_2.GetIconTab(_local_4.Item.Type);
                    this._helpArrow.Attach(((_local_5) || (_local_4)), HelpArrow.SE_ROTATE);
                }
                else
                {
                    this._helpArrow.Detach();
                };
            }
            else
            {
                this._helpArrow.Attach(ClientApplication.Instance.BottomHUD.GetBottomHUD._characterButton, 0, 2, true);
            };
        }

        public function UpdateSkillHelper():void
        {
            var _local_2:SkillItem;
            var _local_3:int;
            var _local_4:uint;
            if (this._currentHelper != LEARN_SKILL_HELPER)
            {
                return;
            };
            var _local_1:SkillWindow = ClientApplication.Instance.GetSkillsWindow();
            if (((_local_1) && (_local_1.isShowing())))
            {
                _local_2 = _local_1.GetSkillItem(_learnSkillId);
                if (_local_2)
                {
                    if (_local_2.Skill.Lv > 0)
                    {
                        if (ClientApplication.Instance.IsFirstCharacter())
                        {
                            StatisticManager.Instance.SendEvent("tut19_Task6Do2_skill");
                            _local_3 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().jobId;
                            StatisticManager.Instance.SendEvent(("tut19_Task6Do2_skill" + _local_3));
                            _local_4 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerRace();
                            switch (_local_4)
                            {
                                case CharacterInfo.RACE_HUMAN:
                                    StatisticManager.Instance.SendEvent("tutH19_Task6Do2_skill");
                                    StatisticManager.Instance.SendEvent(("tutH19_Task6Do2_skill" + _local_3));
                                    break;
                                case CharacterInfo.RACE_ORC:
                                    StatisticManager.Instance.SendEvent("tutO19_Task6Do2_skill");
                                    StatisticManager.Instance.SendEvent(("tutO19_Task6Do2_skill" + _local_3));
                                    break;
                            };
                        };
                        this._helpArrow.Attach(_local_2.CheckBox, HelpArrow.NW_ROTATE);
                    }
                    else
                    {
                        this._helpArrow.Attach(_local_2, HelpArrow.NE_ROTATE);
                    };
                }
                else
                {
                    this.ResetHelper();
                };
            }
            else
            {
                this._helpArrow.Attach(ClientApplication.Instance.BottomHUD.GetBottomHUD._skillsButton, 0, 2, true);
            };
        }

        public function UpdateNPCTalkHelper():void
        {
            var _local_3:Array;
            var _local_4:DialogAnswerListCell;
            switch (this._currentHelper)
            {
                case NPC_DIALOG_QUEST_HELPER:
                case NPC_DIALOG_ACCEPT_QUEST_HELPER:
                case NPC_DIALOG_CLOSE_HELPER:
                case NPC_DIALOG_FINISH_QUEST_HELPER:
                    break;
                default:
                    return;
            };
            var _local_1:String = NPC_TALK_ICONS[this._currentHelper];
            var _local_2:NPCDialog = ClientApplication.Instance.GetNPCTalkWindow();
            if (((_local_1) && (_local_2)))
            {
                _local_3 = _local_2.GetAnswerItems();
                for each (_local_4 in _local_3)
                {
                    if (_local_4.GetIconName() == _local_1)
                    {
                        this._helpArrow.Attach(_local_4.GetIcon(), HelpArrow.E_ROTATE);
                        return;
                    };
                };
            };
            this._helpArrow.Detach();
        }

        public function UpdateQuestsHelper():void
        {
            var _local_2:DisplayObject;
            if (this._currentHelper != QUEST_WINDOW_HELPER)
            {
                return;
            };
            var _local_1:QuestsWindow = ClientApplication.Instance.GetQuestWindow();
            if (((_local_1) && (_local_1.isShowing())))
            {
                this._helpArrow.Attach(_local_1.FindButton, HelpArrow.SW_ROTATE, 2);
            }
            else
            {
                _local_2 = ClientApplication.Instance.TopHUD.QuestsPanel.GetQuestIcon(_questId);
                if (_local_2)
                {
                    this._helpArrow.Attach(_local_2, HelpArrow.W_ROTATE, 2);
                }
                else
                {
                    this._helpArrow.Attach(ClientApplication.Instance.TopHUD.GetTopHUD._questsButton, HelpArrow.W_ROTATE, 2);
                };
            };
        }

        public function UpdatePremiumShopHelper():void
        {
            var _local_2:NewShopArea;
            var _local_3:NewShopItem;
            var _local_4:DisplayObject;
            if (this._currentHelper != PREMIUM_SHOP_WINDOW_HELPER)
            {
                return;
            };
            var _local_1:PremiumShopWindow = ClientApplication.Instance.PremiumShop;
            if (((_local_1) && (_local_1.isShowing())))
            {
                _local_2 = _local_1.GetShopAreaForItem(_buyItemId);
                if (_local_2)
                {
                    if (_local_2 == _local_1.GetCurShop())
                    {
                        _local_3 = _local_2.GetItem(_buyItemId);
                        if (_local_3)
                        {
                            this._helpArrow.Attach(_local_3.BuyButton, HelpArrow.N_ROTATE, 2);
                        }
                        else
                        {
                            this._helpArrow.Detach();
                        };
                    }
                    else
                    {
                        _local_4 = _local_1.GetIconTab(_local_2);
                        this._helpArrow.Attach(_local_4, HelpArrow.S_ROTATE, 2);
                    };
                }
                else
                {
                    this._helpArrow.Detach();
                };
            }
            else
            {
                this._helpArrow.Attach(ClientApplication.Instance.BottomHUD.GetBottomHUD._premiumShopButton, 0, 2, true);
            };
        }

        private function ShowUseSkillHelper(skillId:uint):void
        {
            var slot:JPanel = ClientApplication.Instance.BottomHUD.InventoryBarInstance.GetSlotForSkill(skillId);
            if (slot)
            {
                this._helpArrow.Attach(slot);
                if (this._timerId == 0)
                {
                    var ClearTimer:Function = function ():void
                    {
                        clearTimeout(_timerId);
                        _timerId = 0;
                        if (_currentHelper == USE_SKILL_HELPER)
                        {
                            _helpArrow.Attach(ClientApplication.Instance.BottomHUD.InventoryBarInstance.GetBaseSlot());
                            RedirectArrow(null, 0, 3);
                        };
                    };
                    this._timerId = setTimeout(ClearTimer, 3000);
                };
            }
            else
            {
                this.ResetHelper();
            };
        }

        private function RedirectArrow(target:DisplayObject, rotate:Number, delay:Number):void
        {
            var result:Function;
            result = function ():void
            {
                clearTimeout(_timerId);
                _timerId = 0;
                if (_currentHelper != NO_HELPER)
                {
                    if (target)
                    {
                        _helpArrow.Attach(target, rotate);
                    }
                    else
                    {
                        ResetHelper();
                    };
                };
            };
            this._timerId = setTimeout(result, (delay * 1000));
        }

        private function SendCompleteHelp():void
        {
            ClientApplication.Instance.LocalGameClient.SendRemoteNPCClick(NPC_NAME);
        }

        private function SendCompleteHelp2():void
        {
            ClientApplication.Instance.LocalGameClient.SendRemoteNPCClick(NPC_NAME2);
        }

        public function EquipItem(_arg_1:uint):void
        {
            if (((this._currentHelper == EQUIP_ITEM_HELPER) && (_arg_1 == _equipItemId)))
            {
                this.SendCompleteHelp();
                this.ResetHelper();
            };
        }

        public function UseItem(_arg_1:uint):void
        {
            if (((this._currentHelper == USE_ITEM_HELPER) && (_arg_1 == _useItemId)))
            {
                this.SendCompleteHelp();
                this.ResetHelper();
            };
        }

        public function LearnSkill(_arg_1:uint):void
        {
            if (this._currentHelper != LEARN_SKILL_HELPER)
            {
                return;
            };
            if (_learnSkillId == _arg_1)
            {
                this.UpdateSkillHelper();
            }
            else
            {
                ClientApplication.Instance.LocalGameClient.SendRemoteNPCClick(WRONG_SKILL_NPC_NAME);
            };
        }

        public function SetSkillHotKey(_arg_1:uint):void
        {
            if (this._currentHelper != LEARN_SKILL_HELPER)
            {
                return;
            };
            if (_learnSkillId == _arg_1)
            {
                this.SendCompleteHelp2();
                this.ResetHelper();
            };
        }

        public function ShowMenuItem(_arg_1:int, _arg_2:JPopupMenu):void
        {
            var _local_3:JMenuItem;
            if ((((this._currentHelper == EQUIP_ITEM_HELPER) && (_arg_1 == _equipItemId)) || ((this._currentHelper == USE_ITEM_HELPER) && (_arg_1 == _useItemId))))
            {
                this._menu = _arg_2;
                this._menu.addEventListener(Event.REMOVED_FROM_STAGE, this.OnHideItemMenu, false, 0, true);
                for each (_local_3 in this._menu.getSubElements())
                {
                    if ((((this._currentHelper == EQUIP_ITEM_HELPER) && (_local_3.getDisplayText() == ClientApplication.Localization.INVENTORY_POPUP_EQUIP)) || ((this._currentHelper == USE_ITEM_HELPER) && (_local_3.getDisplayText() == ClientApplication.Localization.INVENTORY_POPUP_USE))))
                    {
                        this._helpArrow.Attach(_local_3, HelpArrow.E_ROTATE);
                        return;
                    };
                };
            };
        }

        private function OnHideItemMenu(_arg_1:Event):void
        {
            this._menu.removeEventListener(Event.REMOVED_FROM_STAGE, this.OnHideItemMenu);
            this._menu = null;
            this.UpdateInventoryHelper();
        }


    }
}//package hbm.Game.GUI.Tutorial

