


//hbm.Game.GUI.Inventory.InventoryBar

package hbm.Game.GUI.Inventory
{
    import flash.display.Sprite;
    import org.aswing.JPanel;
    import flash.geom.Point;
    import flash.utils.Dictionary;
    import org.aswing.JWindow;
    import org.aswing.geom.IntDimension;
    import org.aswing.JLabel;
    import org.aswing.EmptyLayout;
    import org.aswing.FlowLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.geom.IntPoint;
    import hbm.Game.GUI.DndTargets;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Application.ClientApplication;
    import org.aswing.ASFont;
    import hbm.Game.Utility.HtmlText;
    import org.aswing.ASColor;
    import flash.events.MouseEvent;
    import hbm.Engine.Actors.HotKeys;
    import hbm.Game.GUI.Skills.SkillBarItem;
    import hbm.Engine.Actors.SkillData;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Actors.ItemData;
    import org.aswing.AssetBackground;
    import flash.utils.getTimer;
    import caurina.transitions.Tweener;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Resource.SkillsResourceLibrary;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.Character.Character;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Engine.Actors.CharacterEquipment;
    import hbm.Game.GUI.*;

    public class InventoryBar extends Sprite 
    {

        public static const SLOTS:int = 11;
        private static const GLOBAL_CD:uint = 500;

        private var _lastFrameTickTime:uint = 0;
        private var _slots:Array;
        private var _cdSlots:Array;
        private var _cdPanels:Array;
        private var _cdPanelLabels:Array;
        private var _tooltips:Array;
        private var _actionSlot:JPanel;
        private var _actionItem:InventoryBarActionItem;
        private var _currentPosition:Point;
        private var _cooldownItems:Dictionary;
        private var _cooldownSkills:Dictionary;
        private var _timeToUseItem:Dictionary;
        private var _timeToUseSkill:Number;
        private var _cdSkillFlag:Boolean;
        private var _width:int;
        private var _height:int;
        private var _globalCoolDown:uint;

        public function InventoryBar(_arg_1:int, _arg_2:int)
        {
            x = 0;
            y = 0;
            this._width = _arg_1;
            this._height = _arg_2;
            this._slots = new Array();
            this._cdSlots = new Array();
            this._cdPanels = new Array();
            this._cdPanelLabels = new Array();
            this._tooltips = new Array();
            this._cooldownItems = new Dictionary(true);
            this._cooldownSkills = new Dictionary(true);
            this._timeToUseItem = new Dictionary(true);
            this._timeToUseSkill = 0;
            this._currentPosition = new Point(0, 0);
            var _local_3:JWindow = new JWindow(this);
            _local_3.getContentPane().append(this.InitUI());
            _local_3.getContentPane().setFocusable(false);
            _local_3.setSize(new IntDimension(_arg_1, _arg_2));
            _local_3.setMaximumSize(new IntDimension(_arg_1, _arg_2));
            _local_3.setFocusable(false);
            _local_3.show();
        }

        public function InitUI():JPanel
        {
            var _local_7:JPanel;
            var _local_8:JPanel;
            var _local_9:JLabel;
            var _local_10:JPanel;
            var _local_11:JPanel;
            var _local_12:int;
            var _local_1:JPanel = new JPanel(new EmptyLayout());
            var _local_2:IntDimension = new IntDimension(this._width, this._height);
            _local_1.setSize(_local_2);
            _local_1.setPreferredSize(_local_2);
            _local_1.setMaximumSize(_local_2);
            var _local_3:FlowLayout = new FlowLayout();
            var _local_4:EmptyBorder = new EmptyBorder(null, new Insets(0, 0, 0, 0));
            var _local_5:IntDimension = new IntDimension(34, 34);
            _local_3.setMargin(false);
            this._actionSlot = new JPanel(_local_3);
            this._actionSlot.setBorder(_local_4);
            this._actionSlot.setSize(_local_5);
            this._actionSlot.setPreferredSize(_local_5);
            this._actionSlot.setMaximumSize(_local_5);
            this._actionSlot.setLocation(new IntPoint(0, 0));
            _local_1.append(this._actionSlot);
            var _local_6:int;
            while (_local_6 < SLOTS)
            {
                _local_7 = new JPanel(_local_3);
                _local_7.setBorder(_local_4);
                _local_7.setPreferredSize(_local_5);
                _local_7.setSize(_local_5);
                _local_7.setDropTrigger(true);
                _local_7.putClientProperty(DndTargets.DND_TYPE, DndTargets.INVENTORY_BAR_SLOT);
                _local_7.putClientProperty(DndTargets.DND_INDEX, _local_6);
                _local_7.setLocation(new IntPoint(0, 0));
                _local_7.useHandCursor = true;
                _local_7.buttonMode = true;
                this._tooltips.push(new CustomToolTip(_local_7, ClientApplication.Localization.INVENTORY_ITEM_EMPTY, 100, 10));
                _local_8 = new JPanel(_local_3);
                _local_8.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
                _local_8.setSize(new IntDimension(36, 36));
                _local_8.setLocation(new IntPoint(0, 34));
                _local_9 = new JLabel("", null, JLabel.CENTER);
                _local_9.setBorder(new EmptyBorder(null, new Insets(8, 2, 0, 0)));
                _local_9.setWidth(36);
                _local_9.setPreferredWidth(36);
                _local_9.setFont(new ASFont(HtmlText.fontName, 12, false));
                _local_9.setForeground(new ASColor(16767612));
                _local_9.setTextFilters([HtmlText.glow]);
                _local_9.setVisible(false);
                _local_8.append(_local_9);
                _local_10 = new JPanel(_local_3);
                _local_10.setBorder(_local_4);
                _local_10.setSize(_local_5);
                _local_10.setLocation(new IntPoint(0, 34));
                _local_11 = new JPanel(new EmptyLayout());
                _local_11.setBorder(_local_4);
                _local_11.setSize(_local_5);
                _local_11.setPreferredSize(_local_5);
                _local_11.setMaximumSize(_local_5);
                _local_12 = (36 + (_local_6 * 36));
                _local_11.setLocation(new IntPoint(_local_12, 0));
                _local_11.append(_local_7);
                _local_11.append(_local_10);
                _local_11.append(_local_8);
                _local_1.append(_local_11);
                this._slots.push(_local_7);
                this._cdSlots.push(_local_10);
                this._cdPanels.push(_local_8);
                this._cdPanelLabels.push(_local_9);
                _local_6++;
            };
            return (_local_1);
        }

        private function OnMouseClick(_arg_1:MouseEvent):void
        {
            ClientApplication.Instance.ShowSkillsWindow();
        }

        public function GetBaseSlot():JPanel
        {
            return (this._actionSlot);
        }

        public function GetSlotForSkill(_arg_1:uint):JPanel
        {
            var _local_4:Object;
            var _local_2:HotKeys = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys;
            var _local_3:int;
            while (_local_3 < HotKeys.HOTKEYS)
            {
                _local_4 = _local_2.GetHotKeyObject(_local_3);
                if (((_local_4) && (_local_4.Id == _arg_1)))
                {
                    return (this._slots[_local_3]);
                };
                _local_3++;
            };
            return (null);
        }

        public function GetSlotForItem(_arg_1:uint):JPanel
        {
            var _local_4:Object;
            var _local_2:HotKeys = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys;
            var _local_3:int;
            while (_local_3 < HotKeys.HOTKEYS)
            {
                _local_4 = _local_2.GetHotKeyObject(_local_3);
                if (((_local_4) && (_local_4.NameId == _arg_1)))
                {
                    return (this._slots[_local_3]);
                };
                _local_3++;
            };
            return (null);
        }

        public function LoadHotKeys():void
        {
            var _local_1:int;
            while (_local_1 < HotKeys.HOTKEYS)
            {
                this.UpdateSlot(_local_1);
                _local_1++;
            };
        }

        private function UpdateSlot(_arg_1:int):void
        {
            var _local_2:HotKeys;
            var _local_10:InventoryBarItem;
            var _local_11:InventoryBarItem;
            var _local_12:SkillBarItem;
            var _local_13:SkillData;
            var _local_14:SkillBarItem;
            _local_2 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys;
            var _local_3:AdditionalDataResourceLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_4:* = "AdditionalData_Item_Cooldown";
            var _local_5:int = _local_2.GetHotKeyType(_arg_1);
            var _local_6:Object = _local_2.GetHotKeyObject(_arg_1);
            var _local_7:JPanel = this._slots[_arg_1];
            var _local_8:JPanel = this._cdSlots[_arg_1];
            var _local_9:CustomToolTip = this._tooltips[_arg_1];
            _local_7.removeEventListener(MouseEvent.CLICK, this.OnMouseClick);
            switch (_local_5)
            {
                case HotKeys.HOTKEY_ITEM:
                    _local_10 = _local_7.getClientProperty(DndTargets.DND_ITEM);
                    if ((((_local_6 == null) && (_local_10 == null)) || (((_local_10) && (_local_6 is ItemData)) && (_local_10.Item.NameId == ItemData(_local_6).NameId))))
                    {
                        return;
                    };
                    _local_9.visible = true;
                    _local_7.removeAll();
                    if (((!(_local_6 == null)) && (_local_6 is ItemData)))
                    {
                        _local_11 = new InventoryBarItem(ItemData(_local_6));
                        _local_11.putClientProperty(DndTargets.DND_TYPE, DndTargets.INVENTORY_SLOT_ITEM);
                        _local_11.putClientProperty(DndTargets.DND_SLOT, _local_7);
                        _local_8.setBackgroundDecorator(new AssetBackground(_local_3.GetBitmapAsset(_local_4)));
                        _local_7.putClientProperty(DndTargets.DND_ITEM, _local_11);
                        _local_7.append(_local_11);
                        _local_9.visible = false;
                    }
                    else
                    {
                        _local_2.RemoveHotKey(_arg_1);
                        ClientApplication.Instance.LocalGameClient.SendHotkey(_arg_1, 0, 0, 0);
                    };
                    break;
                case HotKeys.HOTKEY_SKILL:
                    _local_12 = _local_7.getClientProperty(DndTargets.DND_SKILL);
                    if ((((_local_6 == null) && (_local_12 == null)) || (((_local_12) && (_local_6 is SkillData)) && (_local_12.Skill.Id == SkillData(_local_6).Id))))
                    {
                        return;
                    };
                    _local_9.visible = true;
                    _local_7.removeAll();
                    if (_local_6 != -1)
                    {
                        if (((!(_local_6 == null)) && (_local_6 is SkillData)))
                        {
                            _local_13 = SkillData(_local_6);
                            if (((_local_13.Disabled) || (_local_13.Lv <= 0)))
                            {
                                _local_2.RemoveHotKey(_arg_1);
                                ClientApplication.Instance.LocalGameClient.SendHotkey(_arg_1, 0, 0, 0);
                            }
                            else
                            {
                                _local_14 = new SkillBarItem(_local_13);
                                _local_14.putClientProperty(DndTargets.DND_TYPE, DndTargets.INVENTORY_SKILL_ITEM);
                                _local_14.putClientProperty(DndTargets.DND_SLOT, _local_7);
                                _local_8.setBackgroundDecorator(new AssetBackground(_local_3.GetBitmapAsset(_local_4)));
                                _local_7.putClientProperty(DndTargets.DND_SKILL, _local_14);
                                _local_7.append(_local_14);
                                _local_9.visible = false;
                            };
                        }
                        else
                        {
                            _local_2.RemoveHotKey(_arg_1);
                            ClientApplication.Instance.LocalGameClient.SendHotkey(_arg_1, 0, 0, 0);
                        };
                    };
                    break;
                case HotKeys.HOTKEY_EMPTY:
                    _local_9.visible = true;
                    _local_7.removeAll();
                    _local_7.putClientProperty(DndTargets.DND_ITEM, null);
                    _local_7.putClientProperty(DndTargets.DND_SKILL, null);
                    break;
            };
            if (_local_9.visible)
            {
                _local_7.addEventListener(MouseEvent.CLICK, this.OnMouseClick, false, 0, true);
            };
        }

        public function DoCooldownSlot(_arg_1:int=-1):Boolean
        {
            var _local_2:JPanel = ((_arg_1 >= 0) ? this._slots[_arg_1] : this._actionSlot);
            if (_local_2.alpha < 1)
            {
                return (false);
            };
            var _local_3:uint = getTimer();
            if (this._globalCoolDown > _local_3)
            {
                return (false);
            };
            this._globalCoolDown = (_local_3 + GLOBAL_CD);
            Tweener.addTween(_local_2, {
                "alpha":0.5,
                "time":0.1,
                "transition":"linear"
            });
            Tweener.addTween(_local_2, {
                "alpha":1,
                "time":0.1,
                "transition":"linear",
                "delay":0.15
            });
            return (true);
        }

        public function DoCooldownItemSlot(_arg_1:int):Boolean
        {
            var _local_2:JPanel = this._slots[_arg_1];
            if (_local_2.alpha < 1)
            {
                return (false);
            };
            _local_2.alpha = 0.2;
            Tweener.addTween(_local_2, {
                "alpha":1,
                "time":2,
                "transition":"easeInQuart"
            });
            return (true);
        }

        public function DoCooldownItemSlots(_arg_1:int, _arg_2:int=-1):void
        {
            var _local_6:int;
            var _local_7:JPanel;
            var _local_8:InventoryBarItem;
            var _local_9:JPanel;
            var _local_10:JPanel;
            var _local_11:JLabel;
            var _local_3:int = this.GetCooldownForItem(_arg_1);
            if (_local_3 <= 0)
            {
                if (_arg_2 >= 0)
                {
                    this.DoCooldownSlot(_arg_2);
                };
                return;
            };
            this._timeToUseItem[_arg_1] = _local_3;
            var _local_4:HotKeys = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys;
            var _local_5:int;
            while (_local_5 < HotKeys.HOTKEYS)
            {
                _local_6 = _local_4.GetHotKeyType(_local_5);
                if (_local_6 == HotKeys.HOTKEY_ITEM)
                {
                    _local_7 = this._slots[_local_5];
                    _local_8 = _local_7.getClientProperty(DndTargets.DND_ITEM);
                    if (_local_8.Item.NameId == _arg_1)
                    {
                        if (_local_8.Item.Amount != 1)
                        {
                            _local_9 = this._cdSlots[_local_5];
                            _local_10 = this._cdPanels[_local_5];
                            _local_11 = this._cdPanelLabels[_local_5];
                            _local_11.setVisible(false);
                            Tweener.addTween(_local_9, {
                                "y":1,
                                "time":0,
                                "transition":"linear"
                            });
                            Tweener.addTween(_local_10, {
                                "y":0,
                                "time":0,
                                "transition":"linear"
                            });
                            Tweener.addTween(_local_9, {
                                "y":34,
                                "time":_local_3,
                                "transition":"linear",
                                "delay":0.01
                            });
                            Tweener.addTween(_local_10, {
                                "y":34,
                                "time":0,
                                "transition":"linear",
                                "delay":_local_3
                            });
                            Tweener.addTween(_local_7, {
                                "alpha":0.5,
                                "time":0.1,
                                "transition":"linear",
                                "delay":(_local_3 + 0.01)
                            });
                            Tweener.addTween(_local_7, {
                                "alpha":1,
                                "time":0.1,
                                "transition":"linear",
                                "delay":(_local_3 + 0.15)
                            });
                        };
                    };
                };
                _local_5++;
            };
        }

        public function StopCooldownSkillSlots():void
        {
            this._timeToUseSkill = 0;
        }

        public function DoCooldownSkillSlots(_arg_1:int, _arg_2:Number, _arg_3:int=-1):void
        {
            var _local_7:int;
            var _local_8:JPanel;
            var _local_9:JPanel;
            var _local_4:Number = (this.GetCooldownForSkill(_arg_1) + _arg_2);
            if (_local_4 <= 0)
            {
                if (_arg_3 >= 0)
                {
                    this.DoCooldownSlot(_arg_3);
                };
                return;
            };
            this._timeToUseSkill = _local_4;
            var _local_5:HotKeys = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys;
            var _local_6:int;
            while (_local_6 < HotKeys.HOTKEYS)
            {
                _local_7 = _local_5.GetHotKeyType(_local_6);
                if (_local_7 == HotKeys.HOTKEY_SKILL)
                {
                    _local_8 = this._cdSlots[_local_6];
                    _local_9 = this._cdPanels[_local_6];
                    Tweener.addTween(_local_8, {
                        "y":1,
                        "time":0,
                        "transition":"linear"
                    });
                    Tweener.addTween(_local_9, {
                        "y":0,
                        "time":0,
                        "transition":"linear"
                    });
                    Tweener.addTween(_local_8, {
                        "y":34,
                        "time":_local_4,
                        "transition":"linear",
                        "delay":0.01
                    });
                    this._cdSkillFlag = true;
                };
                _local_6++;
            };
        }

        private function GetCooldownForItem(_arg_1:int):Number
        {
            var _local_2:Number;
            if (!this._cooldownItems.hasOwnProperty(_arg_1.toString()))
            {
                _local_2 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items")).GetItemCooldown(_arg_1);
                this._cooldownItems[_arg_1] = _local_2;
                if (_local_2 >= 0)
                {
                    this._timeToUseItem[_arg_1] = 0;
                };
            };
            return (this._cooldownItems[_arg_1]);
        }

        public function CheckCooldownItem(_arg_1:int):Boolean
        {
            if (this._timeToUseItem.hasOwnProperty(_arg_1.toString()))
            {
                return (this._timeToUseItem[_arg_1] == 0);
            };
            return (true);
        }

        public function UpdateForSkill(_arg_1:String):void
        {
            var _local_2:int = ((_arg_1 != null) ? int(_arg_1) : -1);
            if (_local_2 > 0)
            {
                this.UpdateSlotIndexForSkill(_local_2);
            };
        }

        private function GetCooldownForSkill(_arg_1:int):Number
        {
            var _local_2:Number;
            if (!this._cooldownSkills.hasOwnProperty(_arg_1.toString()))
            {
                _local_2 = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills")).GetSkillCooldown(_arg_1);
                this._cooldownSkills[_arg_1] = _local_2;
                if (_local_2 >= 0)
                {
                    this._timeToUseSkill = 0;
                };
            };
            return (this._cooldownSkills[_arg_1]);
        }

        public function CheckCooldownSkill():Boolean
        {
            return (this._timeToUseSkill == 0);
        }

        public function UseHotkey(_arg_1:int):void
        {
            var _local_2:CharacterInfo;
            var _local_3:HotKeys;
            var _local_6:int;
            var _local_7:int;
            var _local_8:int;
            var _local_9:Character;
            var _local_10:int;
            var _local_11:SkillsResourceLibrary;
            var _local_12:int;
            var _local_13:SkillData;
            _local_2 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            _local_3 = _local_2.Hotkeys;
            var _local_4:int = _local_3.GetHotKeyType(_arg_1);
            var _local_5:Object = _local_3.GetHotKeyObject(_arg_1);
            switch (_local_4)
            {
                case HotKeys.HOTKEY_EMPTY:
                    ClientApplication.Instance.ShowSkillsWindow();
                    return;
                case HotKeys.HOTKEY_ITEM:
                    _local_6 = ItemData(_local_5).NameId;
                    if (this.CheckCooldownItem(_local_6))
                    {
                        this.DoCooldownItemSlots(_local_6, _arg_1);
                        ClientApplication.Instance.LocalGameClient.SendItemUse(ItemData(_local_5).Id, _local_2.characterId);
                        HelpManager.Instance.UseItem(_local_6);
                        if ((((_local_6 >= 24112) && (_local_6 <= 24114)) || (_local_6 == 24120)))
                        {
                            ClientApplication.Instance._currentCraftItemId = _local_6;
                        };
                    };
                    return;
                case HotKeys.HOTKEY_SKILL:
                    if (this.CheckCooldownSkill())
                    {
                        _local_7 = _local_3.GetHotKeyLv(_arg_1);
                        _local_8 = _local_2.characterId;
                        _local_9 = CharacterStorage.Instance.SelectedCharacter;
                        if (((!(_local_9 == null)) && (!(ClientApplication.Instance.IsShiftPressed))))
                        {
                            _local_8 = _local_9.CharacterId;
                        };
                        _local_10 = SkillData(_local_5).Id;
                        _local_11 = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
                        _local_12 = _local_11.GetSkillTargetType(_local_2.clothesColor, _local_2.jobId, _local_10);
                        if (_local_12 == SkillsResourceLibrary.TARGET_COORDINATES)
                        {
                            CharacterStorage.Instance.SkillLevel = _local_7;
                            CharacterStorage.Instance.SkillMode = _local_10;
                            CharacterStorage.Instance.SkillPanelSlot = _arg_1;
                            _local_13 = (_local_2.Skills[_local_10] as SkillData);
                            if (_local_13 != null)
                            {
                                CharacterStorage.Instance.SkillRangeSqr = (_local_13.Range * _local_13.Range);
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
                            this.DoCooldownSkillSlots(SkillData(_local_5).Id, 0, _arg_1);
                            ClientApplication.Instance.LocalGameClient.SendSkillUse(_local_10, _local_7, _local_8);
                        };
                    };
                    return;
            };
        }

        public function LoadActionSlot():void
        {
            var _local_1:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_2:ItemData = _local_1.Equipment.GetItemBySlotName(CharacterEquipment.SLOT_RIGHT_HAND);
            this._actionSlot.removeAll();
            if (_local_2 == null)
            {
                _local_2 = new ItemData();
                _local_2.NameId = 1;
                _local_2.Identified = 1;
            };
            this._actionItem = new InventoryBarActionItem(_local_2);
            this._actionSlot.append(this._actionItem);
        }

        public function RevalidateSlots(_arg_1:ItemData=null):void
        {
            var _local_4:int;
            var _local_5:Object;
            if (!_arg_1)
            {
                return;
            };
            if (((this._actionItem) && (this._actionItem.SubNameId == _arg_1.NameId)))
            {
                return;
            };
            var _local_2:HotKeys = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys;
            var _local_3:int;
            while (_local_3 < HotKeys.HOTKEYS)
            {
                _local_4 = _local_2.GetHotKeyType(_local_3);
                _local_5 = _local_2.GetHotKeyObject(_local_3);
                if ((((_local_5 as ItemData) && (_local_5.NameId == _arg_1.NameId)) || ((_local_4 == HotKeys.HOTKEY_ITEM) && (!(_local_5)))))
                {
                    this.UpdateSlot(_local_3);
                };
                _local_3++;
            };
            HelpManager.Instance.UpdateInventoryHelper();
        }

        public function Update(_arg_1:uint):void
        {
            var _local_5:Object;
            var _local_7:Number;
            var _local_8:int;
            var _local_9:JPanel;
            var _local_10:int;
            var _local_11:String;
            var _local_12:JLabel;
            var _local_13:InventoryBarItem;
            var _local_14:JPanel;
            var _local_15:JPanel;
            var _local_16:ItemData;
            var _local_2:Number = (Number((_arg_1 - this._lastFrameTickTime)) / 1000);
            this._lastFrameTickTime = _arg_1;
            var _local_3:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:HotKeys = _local_3.Hotkeys;
            for (_local_5 in this._timeToUseItem)
            {
                _local_7 = this._timeToUseItem[_local_5];
                if (_local_7 > 0)
                {
                    _local_7 = (_local_7 - _local_2);
                    if (_local_7 < 0)
                    {
                        _local_7 = 0;
                    };
                };
                this._timeToUseItem[_local_5] = _local_7;
            };
            if (this._timeToUseSkill > 0)
            {
                this._timeToUseSkill = (this._timeToUseSkill - _local_2);
                if (this._timeToUseSkill < 0)
                {
                    this._timeToUseSkill = 0;
                };
            };
            var _local_6:int;
            for (;_local_6 < HotKeys.HOTKEYS;_local_6++)
            {
                _local_8 = _local_4.GetHotKeyType(_local_6);
                if (((_local_8 == HotKeys.HOTKEY_ITEM) || (_local_8 == HotKeys.HOTKEY_SKILL)))
                {
                    _local_9 = this._slots[_local_6];
                    if (_local_8 == HotKeys.HOTKEY_ITEM)
                    {
                        _local_13 = _local_9.getClientProperty(DndTargets.DND_ITEM);
                        if (this._timeToUseItem[_local_13.Item.NameId] == 0) continue;
                        _local_10 = (int(this._timeToUseItem[_local_13.Item.NameId]) + 1);
                    }
                    else
                    {
                        if (this._timeToUseSkill == 0) continue;
                        _local_10 = (int(this._timeToUseSkill) + 1);
                    };
                    if (_local_10 > 60)
                    {
                        _local_11 = (Math.round((_local_10 / 60)).toString() + ClientApplication.Localization.TIME_MINUTES);
                    }
                    else
                    {
                        _local_11 = (_local_10 + ClientApplication.Localization.TIME_SECONDS);
                    };
                    _local_12 = this._cdPanelLabels[_local_6];
                    _local_12.setVisible(true);
                    _local_12.setText(_local_11);
                };
            };
            if (((this._cdSkillFlag) && (this._timeToUseSkill == 0)))
            {
                _local_6 = 0;
                while (_local_6 < HotKeys.HOTKEYS)
                {
                    _local_8 = _local_4.GetHotKeyType(_local_6);
                    if (_local_8 == HotKeys.HOTKEY_SKILL)
                    {
                        _local_14 = this._cdPanels[_local_6];
                        _local_15 = this._cdSlots[_local_6];
                        _local_9 = this._slots[_local_6];
                        Tweener.addTween(_local_15, {
                            "y":34,
                            "time":0,
                            "transition":"linear"
                        });
                        Tweener.addTween(_local_14, {
                            "y":34,
                            "time":0,
                            "transition":"linear"
                        });
                        Tweener.addTween(_local_9, {
                            "alpha":0.5,
                            "time":0.1,
                            "transition":"linear",
                            "delay":0.01
                        });
                        Tweener.addTween(_local_9, {
                            "alpha":1,
                            "time":0.1,
                            "transition":"linear",
                            "delay":0.15
                        });
                    };
                    _local_6++;
                };
                this._cdSkillFlag = false;
            };
            if (this._actionItem)
            {
                _local_16 = _local_3.Equipment.GetItemBySlotName(CharacterEquipment.SLOT_SOULSHOTS);
                if (_local_16)
                {
                    this._actionItem.SoulshotData = _local_16;
                };
            };
        }

        public function GetFirstEmptySlotIndex():int
        {
            var _local_3:int;
            var _local_1:HotKeys = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys;
            var _local_2:int;
            while (_local_2 < HotKeys.HOTKEYS)
            {
                _local_3 = _local_1.GetHotKeyType(_local_2);
                if (_local_3 == HotKeys.HOTKEY_EMPTY)
                {
                    return (_local_2);
                };
                _local_2++;
            };
            return (-1);
        }

        public function GetSlotIndexForSkill(_arg_1:int):int
        {
            var _local_4:int;
            var _local_5:Object;
            var _local_6:int;
            var _local_2:HotKeys = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys;
            var _local_3:int = (HotKeys.HOTKEYS - 1);
            while (_local_3 >= 0)
            {
                _local_4 = _local_2.GetHotKeyType(_local_3);
                if (_local_4 == HotKeys.HOTKEY_SKILL)
                {
                    _local_5 = _local_2.GetHotKeyObject(_local_3);
                    if (_local_5 != -1)
                    {
                        _local_6 = SkillData(_local_5).Id;
                        if (_local_6 == _arg_1)
                        {
                            return (_local_3);
                        };
                    };
                };
                _local_3--;
            };
            return (-1);
        }

        public function UpdateSlotIndexForSkill(_arg_1:int):void
        {
            var _local_4:int;
            var _local_5:Object;
            var _local_6:SkillData;
            var _local_2:HotKeys = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys;
            var _local_3:int = (HotKeys.HOTKEYS - 1);
            while (_local_3 >= 0)
            {
                _local_4 = _local_2.GetHotKeyType(_local_3);
                if (_local_4 == HotKeys.HOTKEY_SKILL)
                {
                    _local_5 = _local_2.GetHotKeyObject(_local_3);
                    if ((((_local_5) && (!(_local_5 == -1))) && (_local_5 is SkillData)))
                    {
                        _local_6 = SkillData(_local_5);
                        if (_local_6)
                        {
                            if (_local_6.Id == _arg_1)
                            {
                                ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys.SetHotKey(_local_3, HotKeys.HOTKEY_SKILL, _local_6.Id, _local_6.Lv);
                            };
                        };
                    };
                };
                _local_3--;
            };
        }


    }
}//package hbm.Game.GUI.Inventory

