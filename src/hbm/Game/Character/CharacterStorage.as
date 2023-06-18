


//hbm.Game.Character.CharacterStorage

package hbm.Game.Character
{
    import hbm.Engine.Renderer.RenderObject;
    import flash.utils.Dictionary;
    import flash.geom.Point;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Utility.Vector2D;
    import hbm.Engine.Actors.CharacterEquipment2;
    import hbm.Engine.Actors.CharacterInfo;
    import flash.display.BitmapData;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Actors.CharacterEquipment;
    import flash.display.Bitmap;
    import hbm.Engine.Renderer.Camera;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Game.Renderer.CharacterAnimation;
    import hbm.Game.Character.Monsters.Monster_UnknownAnimation;
    import hbm.Game.Character.Monsters.RabbitAnimation;
    import hbm.Engine.Renderer.Rabbitgedon;
    import hbm.Game.Character.Monsters.DeadSkeletonAnimation;
    import hbm.Game.Character.NPC.NPC_UnknownAnimation;
    import hbm.Game.Character.NPC.StorageAnimation;
    import hbm.Game.Character.Customizations.ManAnimation;
    import hbm.Game.Character.Customizations.WomanAnimation;
    import hbm.Game.Character.Customizations.ManOrcAnimation;
    import hbm.Game.Character.Customizations.WomanOrcAnimation;
    import hbm.Game.Character.Customizations.ManUndeadAnimation;
    import hbm.Game.Character.Customizations.WomanUndeadAnimation;
    import hbm.Game.Character.Players.Man_UnknownAnimation;
    import hbm.Game.Character.Players.Woman_UnknownAnimation;
    import hbm.Engine.Network.Events.ActorDisplayEvent;
    import hbm.Engine.Network.Events.ClientEvent;
    import hbm.Engine.Network.Events.FloorItemEvent;
    import hbm.Engine.Network.Events.GuildEvent;
    import hbm.Engine.Network.Events.SkillUseEvent;
    import hbm.Engine.Network.Events.PvPModeEvent;
    import hbm.Engine.Network.Events.SkillHealEvent;
    import hbm.Engine.Network.Events.SkillCastNoDamage;
    import hbm.Engine.Network.Events.ActorChangeStatusEvent;
    import hbm.Engine.Network.Events.ActorActiveStatusEvent;
    import hbm.Engine.Network.Events.SkillCastEvent;
    import hbm.Engine.Network.Events.SkillUnitEvent;
    import hbm.Engine.Network.Events.SkillPosEffectEvent;
    import hbm.Engine.Network.Events.SkillUnitClearEvent;
    import hbm.Engine.Network.Events.ActorHpUpdateEvent;
    import hbm.Game.Renderer.SkillUnitManager;
    import flash.utils.getTimer;
    import hbm.Game.Renderer.BattleLogManager;
    import hbm.Engine.Network.Events.ChatMessage;
    import mx.core.BitmapAsset;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import hbm.Game.Renderer.StatusManager;
    import hbm.Game.Statistic.StatisticManager;
    import hbm.Game.Music.Music;
    import hbm.Engine.Network.Events.ActorActionEvent;
    import hbm.Engine.Network.Events.ActorStatsEvent;
    import hbm.Engine.Network.Events.CharacterEvent;
    import hbm.Game.Renderer.MapItemManager;
    import flash.events.Event;
    import hbm.Game.Utility.HtmlText;
    import flash.events.MouseEvent;
    import hbm.Engine.Renderer.RenderSystem;
    import hbm.Engine.Collision.MapCollisionManager;
    import hbm.Engine.Collision.MapCollisionData;
    import flash.geom.Rectangle;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import hbm.Engine.Actors.SkillData;
    import hbm.Game.Renderer.MapItemObject;
    import hbm.Engine.Resource.SkillsResourceLibrary;
    import hbm.Game.Renderer.ArrowManager;
    import flash.events.KeyboardEvent;
    import hbm.Game.Character.Monsters.*;
    import hbm.Game.Character.Players.*;
    import hbm.Game.Character.NPC.*;

    public class CharacterStorage extends RenderObject 
    {

        public static const RECEIVE_MESSAGE_COOLDOWN:int = 1000;
        private static var _isSingletonLock:Boolean = false;
        private static var _singleton:CharacterStorage = null;
        public static const MAN_CUSTOMIZATION:int = 0;
        public static const WOMAN_CUSTOMIZATION:int = 1;
        public static const ORC_MAN_CUSTOMIZATION:int = 2;
        public static const ORC_WOMAN_CUSTOMIZATION:int = 3;
        public static const UNDEAD_MAN_CUSTOMIZATION:int = 4;
        public static const UNDEAD_WOMAN_CUSTOMIZATION:int = 5;
        public static const TURON_MAN_CUSTOMIZATION:int = 6;
        public static const TURON_WOMAN_CUSTOMIZATION:int = 7;
        public static const CELL_SIZE:int = 32;

        private var _receiveMessageCooldown:int = 0;
        private var _characterData:Array = null;
        private var _customizationData:Array = null;
        private var _characterActorData:Dictionary = null;
        private var _localPlayerCharacter:Character = null;
        private var _lastSelectedCharacter:Character = null;
        private var _pvpMode:int = 0;
        private var _movePointerCollision:int;
        private var _movePointerPosition:Point;
        private var _lastPointerPosition:Point;
        private var _skillMode:uint;
        private var _skillRangeSqr:uint;
        private var _skillLevel:uint;
        private var _skillPanelSlot:int;
        private var _skillCharacterId:int;
        private var _awayMapItemId:int;
        private var _isEnableAutoAttack:Boolean = true;
        private var _isEnableObjectsGlow:Boolean = true;
        private var _isEnableBlinking:Boolean = true;
        private var _isEnableChatHiding:Boolean = true;
        private var _isShowGWDamage:Boolean = false;
        private var _isShowGuildNotice:Boolean = false;
        private var _isEnableSkillAnimation:Boolean = true;
        private var _startArrowPosition:Point = null;
        private var _endArrowPosition:Point = null;

        public function CharacterStorage()
        {
            if (!_isSingletonLock)
            {
                throw (new Error("Invalid Singleton access. Use CharacterStorage.Instance."));
            };
            this._characterData = new Array();
            this._customizationData = new Array();
            this._characterActorData = new Dictionary(true);
            this._skillMode = 0;
            this._skillLevel = 0;
            this._skillRangeSqr = 0;
            this._awayMapItemId = -1;
            this._skillPanelSlot = -1;
            this._skillCharacterId = -1;
            this._movePointerCollision = 0;
            this._movePointerPosition = new Point(0, 0);
            this._lastPointerPosition = new Point(0, 0);
            this._startArrowPosition = new Point(0, 0);
            this._endArrowPosition = new Point(0, 0);
            Priority = 100001;
        }

        public static function get Instance():CharacterStorage
        {
            if (_singleton == null)
            {
                _isSingletonLock = true;
                _singleton = new (CharacterStorage)();
                _isSingletonLock = false;
            };
            return (_singleton);
        }


        public function get SkillCharacterId():int
        {
            return (this._skillCharacterId);
        }

        public function set SkillCharacterId(_arg_1:int):void
        {
            this._skillCharacterId = _arg_1;
        }

        public function get SkillMode():uint
        {
            return (this._skillMode);
        }

        public function set SkillMode(_arg_1:uint):void
        {
            this._skillMode = _arg_1;
        }

        public function get SkillRangeSqr():uint
        {
            return (this._skillRangeSqr);
        }

        public function set SkillRangeSqr(_arg_1:uint):void
        {
            this._skillRangeSqr = _arg_1;
        }

        public function get SkillPanelSlot():int
        {
            return (this._skillPanelSlot);
        }

        public function set SkillPanelSlot(_arg_1:int):void
        {
            this._skillPanelSlot = _arg_1;
        }

        public function get SkillLevel():uint
        {
            return (this._skillLevel);
        }

        public function set SkillLevel(_arg_1:uint):void
        {
            this._skillLevel = _arg_1;
        }

        public function get PvPMode():int
        {
            return (this._pvpMode);
        }

        public function GetJobName(_arg_1:int, _arg_2:int, _arg_3:Boolean=false):String
        {
            var _local_4:Array;
            var _local_5:Array;
            var _local_6:Array;
            if (_arg_3)
            {
                _local_4 = ((_arg_1) ? ClientApplication.Localization.JOB_NAMES1 : ClientApplication.Localization.JOB_NAMES0);
                _local_5 = ((_arg_1) ? ClientApplication.Localization.JOB_NAMES_ADV1 : ClientApplication.Localization.JOB_NAMES_ADV0);
                _local_6 = ((_arg_1) ? ClientApplication.Localization.JOB_NAMES_BABY0 : ClientApplication.Localization.JOB_NAMES_BABY1);
            }
            else
            {
                _local_4 = ((_arg_1) ? ClientApplication.Localization.JOB_NAMES1 : ClientApplication.Localization.JOB_NAMES0);
                _local_5 = ((_arg_1) ? ClientApplication.Localization.JOB_NAMES_ADV1 : ClientApplication.Localization.JOB_NAMES_ADV0);
                _local_6 = ((_arg_1) ? ClientApplication.Localization.JOB_NAMES_BABY1 : ClientApplication.Localization.JOB_NAMES_BABY0);
            };
            var _local_7:String = ((_arg_2 >= 4023) ? _local_6[(_arg_2 - 4023)] : ((_arg_2 >= 4001) ? _local_5[(_arg_2 - 4001)] : _local_4[_arg_2]));
            if (_local_7 == null)
            {
                return ("Unknown");
            };
            return (_local_7);
        }

        public function GetJobEquipID(_arg_1:int):uint
        {
            if (_arg_1 >= 4023)
            {
                return (_arg_1 - 4023);
            };
            if (_arg_1 >= 4001)
            {
                return (_arg_1 - 4001);
            };
            return (_arg_1);
        }

        public function GetCharacterDistanceSqr(_arg_1:Character, _arg_2:Character):Number
        {
            if (((_arg_1 == null) || (_arg_2 == null)))
            {
                return (0);
            };
            var _local_3:Vector2D = Vector2D.fromPoint(_arg_1.Position).divide(CELL_SIZE);
            var _local_4:Vector2D = Vector2D.fromPoint(_arg_2.Position).divide(CELL_SIZE);
            return (Vector2D.distanceSquared(_local_4, _local_3));
        }

        public function UpdateNextTarget(_arg_1:Boolean=false):void
        {
            var _local_3:Character;
            if (((this._lastSelectedCharacter == null) || (_arg_1)))
            {
                this.SelectCharacter(this.GetNearestTarget());
                return;
            };
            var _local_2:Boolean;
            for each (_local_3 in this._characterActorData)
            {
                if (_local_3 != null)
                {
                    if (_local_3 != this._localPlayerCharacter)
                    {
                        if (_local_3.IsValid)
                        {
                            if (!_local_2)
                            {
                                if (_local_3 != this._lastSelectedCharacter) continue;
                                _local_2 = true;
                            }
                            else
                            {
                                if (_local_3.CharacterType != Character.CHARACTER_NPC)
                                {
                                    if (_local_3.CharacterType == Character.CHARACTER_PLAYER)
                                    {
                                        if (this._localPlayerCharacter.LocalCharacterInfo.guildName == _local_3.LocalCharacterInfo.guildName) continue;
                                        if (_local_3.IsHided)
                                        {
                                            if (this.CheckIntravision(this._localPlayerCharacter, _local_3)) continue;
                                        };
                                    };
                                    if (!((_local_3.CharacterType == Character.CHARACTER_MONSTER) && (_local_3.IsDead)))
                                    {
                                        this.SelectCharacter(_local_3);
                                        return;
                                    };
                                };
                            };
                        };
                    };
                };
            };
            this.UpdateNextTarget(true);
        }

        public function GetNearestTarget():Character
        {
            var _local_3:Character;
            var _local_4:Number;
            var _local_1:Character;
            var _local_2:Number = 100000;
            for each (_local_3 in this._characterActorData)
            {
                if (_local_3 != null)
                {
                    if (_local_3 != this._localPlayerCharacter)
                    {
                        if (_local_3.IsValid)
                        {
                            if (!((_local_3.CharacterType == Character.CHARACTER_MONSTER) && (_local_3.IsDead)))
                            {
                                if (_local_3.CharacterType != Character.CHARACTER_NPC)
                                {
                                    if (_local_3.CharacterType == Character.CHARACTER_PLAYER)
                                    {
                                        if (((!(this._localPlayerCharacter.LocalCharacterInfo.guildName == null)) && (this._localPlayerCharacter.LocalCharacterInfo.guildName == _local_3.LocalCharacterInfo.guildName))) continue;
                                        if (_local_3.IsHided)
                                        {
                                            if (this.CheckIntravision(this._localPlayerCharacter, _local_3)) continue;
                                        };
                                    };
                                    _local_4 = this.GetCharacterDistanceSqr(this._localPlayerCharacter, _local_3);
                                    if (!((_local_4 == 0) || (_local_4 >= _local_2)))
                                    {
                                        _local_1 = _local_3;
                                        _local_2 = _local_4;
                                        break;
                                    };
                                };
                            };
                        };
                    };
                };
            };
            return (_local_1);
        }

        public function OnStartBaseAttack():void
        {
            var _local_2:Vector2D;
            var _local_3:Vector2D;
            var _local_1:Character = this._lastSelectedCharacter;
            if (_local_1 == null)
            {
                _local_1 = this.GetNearestTarget();
                if (_local_1 != null)
                {
                    this.SelectCharacter(_local_1);
                };
            };
            if (_local_1 == null)
            {
                return;
            };
            if (!_local_1.IsValid)
            {
                return;
            };
            if (((_local_1.CharacterType == Character.CHARACTER_MONSTER) && (_local_1.IsDead)))
            {
                return;
            };
            _local_2 = Vector2D.fromPoint(_local_1.Position).divide(CELL_SIZE);
            _local_3 = Vector2D.fromPoint(this._localPlayerCharacter.Position).divide(CELL_SIZE);
            var _local_4:Number = Vector2D.distanceSquared(_local_3, _local_2);
            if (_local_4 > ((this._localPlayerCharacter.LocalCharacterInfo.range * this._localPlayerCharacter.LocalCharacterInfo.range) + 4))
            {
                ClientApplication.Instance.LocalGameClient.MoveTo(_local_2.x, _local_2.y);
                return;
            };
            _local_1.IsAutoAttacked = false;
            ClientApplication.Instance.LocalGameClient.SendAttack(_local_1.CharacterId, 7);
        }

        public function get SelectedCharacter():Character
        {
            return (this._lastSelectedCharacter);
        }

        public function get MovePointerCollision():int
        {
            return (this._movePointerCollision);
        }

        public function get MovePointerPosition():Point
        {
            return (this._movePointerPosition);
        }

        public function get LastPointerPosition():Point
        {
            return (this._lastPointerPosition);
        }

        public function get LocalPlayerCharacter():Character
        {
            return (this._localPlayerCharacter);
        }

        public function get LocalPlayerIconSmall():String
        {
            if (this._localPlayerCharacter == null)
            {
                return (null);
            };
            return (this._localPlayerCharacter.AnimationName + "Graphics_IconSmall");
        }

        public function GetCustomizedCharacterIcon(_arg_1:int, _arg_2:int, _arg_3:CharacterEquipment):Bitmap
        {
            var _local_4:Boolean;
            var _local_5:Boolean;
            var _local_6:Boolean;
            var _local_15:Object;
            var _local_16:CharacterEquipment2;
            var _local_17:CharacterInfo;
            var _local_7:int = -1;
            if ((_arg_3 is CharacterEquipment2))
            {
                _local_16 = (_arg_3 as CharacterEquipment2);
                _local_4 = (_local_16.Gender == 1);
                _local_5 = Character.IsBabyClass(_local_16.JobId);
                _local_6 = ((_local_16.JobId == 17) || (_local_16.JobId == 4018));
                _local_7 = _local_16.ClothesColor;
            }
            else
            {
                _local_17 = this._localPlayerCharacter.LocalCharacterInfo;
                _local_4 = (_local_17.sex == 1);
                _local_5 = Character.IsBabyClass(_local_17.jobId);
                _local_6 = ((_local_17.jobId == 17) || (_local_17.jobId == 4018));
                _local_7 = _local_17.clothesColor;
            };
            if (((_local_7 > 0) && (_local_5)))
            {
                return (null);
            };
            var _local_8:uint = ((_local_7 > 0) ? ((_local_4) ? ((_local_5) ? TURON_MAN_CUSTOMIZATION : UNDEAD_MAN_CUSTOMIZATION) : ((_local_5) ? TURON_WOMAN_CUSTOMIZATION : UNDEAD_WOMAN_CUSTOMIZATION)) : ((_local_4) ? ((_local_5) ? ORC_MAN_CUSTOMIZATION : MAN_CUSTOMIZATION) : ((_local_5) ? ORC_WOMAN_CUSTOMIZATION : WOMAN_CUSTOMIZATION)));
            var _local_9:Character = this._characterActorData[_local_8];
            if (_local_9 == null)
            {
                return (null);
            };
            var _local_10:BitmapData = new BitmapData(_arg_1, _arg_2, true, 0);
            var _local_11:ItemsResourceLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            var _local_12:ItemData;
            var _local_13:ItemData;
            var _local_14:* = "Background";
            _local_9.DrawFrame(_local_10, _local_14, 0);
            _local_12 = _arg_3.GetItemBySlotName(CharacterEquipment.SLOT_ROBE);
            if (_local_12 != null)
            {
                _local_15 = _local_11.GetServerDescriptionObject(_local_12.NameId);
                _local_14 = (((_local_15) && (!(_local_15["view_name"] == ""))) ? _local_15["view_name"] : "Cloak");
                _local_9.DrawFrame(_local_10, _local_14, ((_local_15) ? _local_15["view_index"] : 0));
            };
            _local_12 = _arg_3.GetItemBySlotName(CharacterEquipment.SLOT_SHOES);
            if (_local_12 != null)
            {
                _local_15 = _local_11.GetServerDescriptionObject(_local_12.NameId);
                _local_14 = (((_local_15) && (!(_local_15["view_name"] == ""))) ? _local_15["view_name"] : "Leg");
                _local_9.DrawFrame(_local_10, _local_14, ((_local_15) ? _local_15["view_index"] : 0));
            };
            _local_12 = _arg_3.GetItemBySlotName(CharacterEquipment.SLOT_BODY);
            if (_local_12 != null)
            {
                _local_15 = _local_11.GetServerDescriptionObject(_local_12.NameId);
                _local_14 = (((_local_15) && (!(_local_15["view_name"] == ""))) ? _local_15["view_name"] : "Body");
                _local_9.DrawFrame(_local_10, _local_14, ((_local_15) ? _local_15["view_index"] : 0));
            };
            _local_12 = _arg_3.GetItemBySlotName(CharacterEquipment.SLOT_HEAD_TOP);
            if (_local_12 != null)
            {
                _local_15 = _local_11.GetServerDescriptionObject(_local_12.NameId);
                _local_14 = (((_local_15) && (!(_local_15["view_name"] == ""))) ? _local_15["view_name"] : "Head");
                _local_9.DrawFrame(_local_10, _local_14, ((_local_15) ? _local_15["view_index"] : 0));
            };
            _local_12 = _arg_3.GetItemBySlotName(CharacterEquipment.SLOT_RIGHT_HAND);
            _local_13 = _arg_3.GetItemBySlotName(CharacterEquipment.SLOT_LEFT_HAND);
            if (((((!(_local_12 == null)) && (!(_local_13 == null))) && (_local_12.NameId == _local_13.NameId)) && (_local_12.Id == _local_13.Id)))
            {
                _local_15 = _local_11.GetServerDescriptionObject(_local_12.NameId);
                _local_14 = (((_local_15) && (!(_local_15["view_name"] == ""))) ? _local_15["view_name"] : "Weapon/Cross");
                _local_9.DrawFrame(_local_10, _local_14, ((_local_15) ? _local_15["view_index"] : 0));
            }
            else
            {
                if (_local_12 != null)
                {
                    _local_15 = _local_11.GetServerDescriptionObject(_local_12.NameId);
                    _local_14 = (((_local_15) && (!(_local_15["view_name"] == ""))) ? _local_15["view_name"] : "Weapon/Hummer");
                    _local_9.DrawFrame(_local_10, _local_14, ((_local_15) ? _local_15["view_index"] : 0));
                };
                if (_local_13 != null)
                {
                    _local_15 = _local_11.GetServerDescriptionObject(_local_13.NameId);
                    if (_local_6)
                    {
                        if (((_local_15) && (!(_local_15["view_name"] == ""))))
                        {
                            if (_local_15["view_name"] != "Weapon/Shield")
                            {
                                _local_14 = "Weapon/KnifeLH";
                            }
                            else
                            {
                                _local_14 = _local_15["view_name"];
                            };
                        }
                        else
                        {
                            _local_14 = "Weapon/KnifeLH";
                        };
                    }
                    else
                    {
                        _local_14 = (((_local_15) && (!(_local_15["view_name"] == ""))) ? _local_15["view_name"] : "Weapon/Shield");
                    };
                    _local_9.DrawFrame(_local_10, _local_14, ((_local_15) ? _local_15["view_index"] : 0));
                };
            };
            return (new Bitmap(_local_10));
        }

        public function get LocalPlayerIconBig():String
        {
            if (this._localPlayerCharacter == null)
            {
                return (null);
            };
            return (this._localPlayerCharacter.AnimationName + "Graphics_IconBig");
        }

        public function CharacterIconBig(_arg_1:int, _arg_2:int, _arg_3:int=-1):String
        {
            var _local_4:Character;
            for each (_local_4 in this._characterActorData)
            {
                if (_local_4 != null)
                {
                    if (_local_4.IsValid)
                    {
                        if (((_local_4.LocalCharacterInfo.jobId == _arg_2) && (_local_4.LocalCharacterInfo.clothesColor == _arg_1)))
                        {
                            if (!((_arg_3 >= 0) && (!(_local_4.LocalCharacterInfo.sex == _arg_3))))
                            {
                                return (_local_4.AnimationName + "Graphics_IconBig");
                            };
                        };
                    };
                };
            };
            if (this._localPlayerCharacter == null)
            {
                return (null);
            };
            return (this._localPlayerCharacter.AnimationName + "Graphics_IconBig");
        }

        override public function Draw(_arg_1:Camera, _arg_2:BitmapData):void
        {
            var _local_3:Character;
            for each (_local_3 in this._characterActorData)
            {
                if (_local_3 != null)
                {
                    if (_local_3.IsValid)
                    {
                        _local_3.DrawInfo(_arg_1, _arg_2);
                    };
                };
            };
        }

        public function GetCharacterAnimation(_arg_1:uint):CharacterAnimation
        {
            var _local_3:AdditionalDataResourceLibrary;
            var _local_4:Object;
            var _local_5:CharacterAnimation;
            var _local_2:CharacterAnimation = this._characterData[_arg_1];
            if (_local_2 == null)
            {
                _local_3 = (ResourceManager.Instance.Library("AdditionalData") as AdditionalDataResourceLibrary);
                if (_local_3)
                {
                    _local_4 = _local_3.GetAnimationDataFromId(_arg_1);
                    if ((((_local_4) && (this.hasOwnProperty(_local_4.draw))) && (_local_4.name)))
                    {
                        _local_5 = new CharacterAnimation();
                        _local_5.EnableNewImageFormat();
                        _local_5.SetCharacterName(_local_4.name);
                        _local_5.SetDrawUnknownCharacter(this[_local_4.draw]);
                        this._characterData[_arg_1] = _local_5;
                        return (_local_5);
                    };
                };
                return (this._characterData[0]);
            };
            return (this._characterData[_arg_1]);
        }

        public function GetCustomizationAnimation(_arg_1:uint):CharacterAnimation
        {
            var _local_2:CharacterAnimation = this._customizationData[_arg_1];
            if (_local_2 == null)
            {
                return (this._customizationData[0]);
            };
            return (this._customizationData[_arg_1]);
        }

        public function DrawUnknownManCharacter(_arg_1:Camera, _arg_2:BitmapData, _arg_3:Point):void
        {
            var _local_4:CharacterAnimation = this.GetCharacterAnimation(1);
            _local_4.Position = _arg_3;
            _local_4.Draw(_arg_1, _arg_2);
        }

        public function DrawUnknownWomanCharacter(_arg_1:Camera, _arg_2:BitmapData, _arg_3:Point):void
        {
            var _local_4:CharacterAnimation = this.GetCharacterAnimation(2);
            _local_4.Position = _arg_3;
            _local_4.Draw(_arg_1, _arg_2);
        }

        public function DrawUnknownMonsterCharacter(_arg_1:Camera, _arg_2:BitmapData, _arg_3:Point):void
        {
            var _local_4:CharacterAnimation = this.GetCharacterAnimation(1000);
            _local_4.Position = _arg_3;
            _local_4.Draw(_arg_1, _arg_2);
        }

        public function DrawUnknownNPC(_arg_1:Camera, _arg_2:BitmapData, _arg_3:Point):void
        {
            var _local_4:CharacterAnimation = this.GetCharacterAnimation(0);
            _local_4.Position = _arg_3;
            _local_4.DrawShadow = false;
            _local_4.Draw(_arg_1, _arg_2);
        }

        public function GetCharacterType(_arg_1:int):int
        {
            if ((((((_arg_1 >= 10) && (_arg_1 < 200)) || ((_arg_1 >= 2010) && (_arg_1 < 2200))) || ((_arg_1 >= 3010) && (_arg_1 < 3099))) || ((_arg_1 >= 5010) && (_arg_1 < 5099))))
            {
                return (Character.CHARACTER_PLAYER);
            };
            if (((_arg_1 >= 200) && (_arg_1 <= 999)))
            {
                return (Character.CHARACTER_NPC);
            };
            if ((((_arg_1 >= 1000) && (_arg_1 <= 1899)) || ((_arg_1 >= 1900) && (_arg_1 <= 2000))))
            {
                return (Character.CHARACTER_MONSTER);
            };
            return (Character.CHARACTER_UNKNOWN);
        }

        private function LoadMonsters():void
        {
            var _local_1:CharacterAnimation;
            _local_1 = new Monster_UnknownAnimation();
            _local_1.StartLoading();
            this._characterData[1000] = _local_1;
            _local_1 = new RabbitAnimation();
            _local_1.SetDrawUnknownCharacter(this.DrawUnknownMonsterCharacter);
            this._characterData[Rabbitgedon.ID_CRAZY_RABBIT] = _local_1;
            _local_1 = new DeadSkeletonAnimation();
            _local_1.SetDrawUnknownCharacter(this.DrawUnknownMonsterCharacter);
            this._characterData[1163] = _local_1;
        }

        private function LoadNpc():void
        {
            var _local_1:CharacterAnimation;
            _local_1 = new NPC_UnknownAnimation();
            _local_1.StartLoading();
            this._characterData[0] = _local_1;
            _local_1 = new StorageAnimation();
            _local_1.StartLoading();
            this._characterData[206] = _local_1;
        }

        private function LoadCustomizations():void
        {
            var _local_1:CharacterAnimation;
            _local_1 = new ManAnimation();
            _local_1.StartLoading();
            this._customizationData[MAN_CUSTOMIZATION] = _local_1;
            _local_1 = new WomanAnimation();
            _local_1.StartLoading();
            this._customizationData[WOMAN_CUSTOMIZATION] = _local_1;
            _local_1 = new ManOrcAnimation();
            _local_1.StartLoading();
            this._customizationData[ORC_MAN_CUSTOMIZATION] = _local_1;
            _local_1 = new WomanOrcAnimation();
            _local_1.StartLoading();
            this._customizationData[ORC_WOMAN_CUSTOMIZATION] = _local_1;
            _local_1 = new ManUndeadAnimation();
            _local_1.StartLoading();
            this._customizationData[UNDEAD_MAN_CUSTOMIZATION] = _local_1;
            _local_1 = new WomanUndeadAnimation();
            _local_1.StartLoading();
            this._customizationData[UNDEAD_WOMAN_CUSTOMIZATION] = _local_1;
        }

        private function LoadManPlayers():void
        {
            var _local_1:CharacterAnimation;
            _local_1 = new Man_UnknownAnimation();
            _local_1.StartLoading();
            this._characterData[1] = _local_1;
        }

        private function LoadWomanPlayers():void
        {
            var _local_1:CharacterAnimation;
            _local_1 = new Woman_UnknownAnimation();
            _local_1.StartLoading();
            this._characterData[2] = _local_1;
        }

        private function LoadOrcManPlayers():void
        {
            var _local_1:CharacterAnimation;
        }

        private function LoadOrcWomanPlayers():void
        {
            var _local_1:CharacterAnimation;
        }

        private function LoadUndeadManPlayers():void
        {
            var _local_1:CharacterAnimation;
        }

        private function LoadUndeadWomanPlayers():void
        {
            var _local_1:CharacterAnimation;
        }

        private function LoadTuronManPlayers():void
        {
            var _local_1:CharacterAnimation;
        }

        private function LoadTuronWomanPlayers():void
        {
            var _local_1:CharacterAnimation;
        }

        public function LoadGraphics():void
        {
            if (this._characterData.length > 0)
            {
                return;
            };
            this.LoadCustomizations();
            this.LoadManPlayers();
            this.LoadWomanPlayers();
            this.LoadOrcManPlayers();
            this.LoadOrcWomanPlayers();
            this.LoadUndeadManPlayers();
            this.LoadUndeadWomanPlayers();
            this.LoadTuronManPlayers();
            this.LoadTuronWomanPlayers();
            this.LoadNpc();
            this.LoadMonsters();
            ClientApplication.Instance.LocalGameClient.addEventListener(ActorDisplayEvent.ON_ACTOR_UPDATE_DIR, this.OnActorUpdateDir, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(ActorDisplayEvent.ON_ACTOR_MOVES, this.OnActorDisplay, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(ActorDisplayEvent.ON_ACTOR_INFO_UPDATED, this.OnActorDisplay, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(ActorDisplayEvent.ON_ACTOR_NAME_UPDATED, this.OnActorDisplay, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(ActorDisplayEvent.ON_ACTOR_HAIR_COLOR_CHANGED, this.OnChangeHairColor, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(ActorDisplayEvent.ON_ACTOR_DISAPPEAR, this.OnActorDisappear, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(ActorDisplayEvent.ON_ACTOR_CAST_CANCELED, this.OnActorCastCanceled, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(ActorDisplayEvent.ON_ACTOR_INTERRUPTED, this.OnActorMovementInterrupted, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(ActorDisplayEvent.ON_ACTOR_RESURRECTED, this.OnPlayerResurrected, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(ClientEvent.ON_PLAYER_RESPAWNED, this.OnPlayerRespawned, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(FloorItemEvent.ON_GET_AREA_CHAR_ITEM, this.OnGetAreaCharItem, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(FloorItemEvent.ON_FLOOR_ITEM_APPEARED, this.OnFloorItemAppeared, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(FloorItemEvent.ON_FLOOR_ITEM_DISAPPEARED, this.OnFloorItemDisappeared, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(GuildEvent.ON_GUILD_UPDATED, this.OnGuildUpdated, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(SkillUseEvent.ON_SKILL_USE, this.OnSkillUse, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(PvPModeEvent.ON_PVP_MODE_ACTION, this.OnPvPModeChanged, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(SkillHealEvent.ON_SKILL_HEAL, this.OnSkillHeal, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(SkillCastNoDamage.ON_SKILL_CAST_NODAMAGE, this.OnSkillNoDamage, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(ActorChangeStatusEvent.ON_ACTOR_CHANGE_STATUS, this.OnActorChangeStatus, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(ActorActiveStatusEvent.ON_ACTOR_ACTIVE_STATUS, this.OnActorActiveStatus, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(SkillCastEvent.ON_SKILL_CAST, this.OnSkillCast, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(SkillUnitEvent.ON_SKILL_UNIT, this.OnSkillUnit, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(SkillPosEffectEvent.ON_SKILL_POS_EFFECT, this.OnSkillPosEffect, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(SkillUnitClearEvent.ON_SKILL_UNIT_CLEAR, this.OnSkillUnitClear, false, 0, true);
            ClientApplication.Instance.LocalGameClient.addEventListener(ActorHpUpdateEvent.ON_ACTOR_HP_UPDATE, this.OnActorHpUpdate, false, 0, true);
        }

        public function OnActorHpUpdate(_arg_1:ActorHpUpdateEvent):void
        {
            var _local_5:int;
            var _local_6:SelectedActorInfoNew;
            var _local_2:Character = this._characterActorData[_arg_1.CharacterId];
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:Object = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetMonstersData(_local_2.Name);
            if (_local_3 != null)
            {
                _local_5 = _local_3["Sprite"];
                if ((((_local_5 == 1014) || (_local_5 == 1012)) || (_local_5 == 1027)))
                {
                    return;
                };
            };
            var _local_4:CharacterInfo = _local_2.LocalCharacterInfo;
            _local_4.hp = _arg_1.CurrentHP;
            _local_4.maxHp = _arg_1.MaximumHP;
            if (((_local_2.Selected) && (_local_4.maxHp > 0)))
            {
                _local_6 = ClientApplication.Instance.TopHUD.GetSelectedActorInfo();
                _local_6._progress._progressMask.scaleX = (Number(_local_4.hp) / Number(_local_4.maxHp));
            };
        }

        public function OnSkillUnitClear(_arg_1:SkillUnitClearEvent):void
        {
            SkillUnitManager.Instance.RemoveSkillUnit(_arg_1.UnitId);
        }

        public function OnSkillUnit(_arg_1:SkillUnitEvent):void
        {
            SkillUnitManager.Instance.AddSkillUnit(_arg_1.UnitId, _arg_1.Flag, _arg_1.Flag2, _arg_1.X, _arg_1.Y);
        }

        public function OnSkillPosEffect(_arg_1:SkillPosEffectEvent):void
        {
            var _local_2:int = -1;
            switch (_arg_1.SkillId)
            {
                case 110:
                    _local_2 = 13;
                    break;
            };
            if (_local_2 > 0)
            {
                SkillUnitManager.Instance.AddSkillUnit(-1, 134, _local_2, _arg_1.X, _arg_1.Y);
            };
        }

        public function OnSkillCast(_arg_1:SkillCastEvent):void
        {
            var _local_2:Character = this._characterActorData[_arg_1.SourceId];
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:Number = (Number(_arg_1.CastTime) / 1000);
            if (_arg_1.CastTime > 0)
            {
                _local_2.StartCast(_local_3);
            };
            if (_local_2 == this._localPlayerCharacter)
            {
                ClientApplication.Instance.BottomHUD.InventoryBarInstance.DoCooldownSkillSlots(_arg_1.SkillId, _local_3);
            };
        }

        public function OnActorCastCanceled(_arg_1:ActorDisplayEvent):void
        {
            var _local_3:uint;
            var _local_2:Character;
            if (_arg_1 == null)
            {
                _local_3 = this._localPlayerCharacter.LocalCharacterInfo.characterId;
                _local_2 = this._characterActorData[_local_3];
            }
            else
            {
                _local_2 = this._characterActorData[_arg_1.Character.characterId];
            };
            if (_local_2 == null)
            {
                return;
            };
            _local_2.StopCast();
            if (_local_2 == this._localPlayerCharacter)
            {
                ClientApplication.Instance.BottomHUD.InventoryBarInstance.StopCooldownSkillSlots();
            };
        }

        public function OnActorMovementInterrupted(_arg_1:ActorDisplayEvent):void
        {
            var _local_2:Character = this._characterActorData[_arg_1.Character.characterId];
            if (_local_2 == null)
            {
                return;
            };
            _local_2.OnMovementInterrupted();
        }

        public function OnReceivedPublicMessage(_arg_1:ChatMessage):void
        {
            var _local_2:int;
            var _local_5:int;
            _local_2 = getTimer();
            var _local_3:uint = (_local_2 - this._receiveMessageCooldown);
            if (_local_3 < RECEIVE_MESSAGE_COOLDOWN)
            {
                return;
            };
            this._receiveMessageCooldown = _local_2;
            var _local_4:Character = this._characterActorData[_arg_1.CharacterId];
            if (_local_4 == null)
            {
                return;
            };
            _local_5 = int(Math.floor((Math.random() * 100)));
            var _local_6:uint = 0x7700;
            var _local_7:Point = new Point((_local_4.Position.x - 50), ((_local_4.Position.y + 150) + _local_5));
            var _local_8:int = int((3 + (_arg_1.Message.length / 5)));
            BattleLogManager.Instance.AddBattleMessage(_arg_1.Message, _local_8, new Point((_local_4.Position.x - 50), (_local_4.Position.y + 120)), _local_7, _local_6, 1);
        }

        public function OnReceivedEmotion(_arg_1:ChatMessage):void
        {
            var _local_4:String;
            var _local_5:AdditionalDataResourceLibrary;
            var _local_7:BitmapAsset;
            var _local_2:Character = this._characterActorData[_arg_1.CharacterId];
            if (_local_2 == null)
            {
                return;
            };
            var _local_3:Point = new Point(_local_2.Position.x, (_local_2.Position.y + 130));
            _local_4 = _arg_1.Message;
            _local_5 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_6:Object = _local_5.GetEmotionData(int(_local_4));
            if (_local_6)
            {
                _local_7 = _local_5.GetBitmap("emo", _local_6.IconId);
                if (_local_7)
                {
                    BattleLogManager.Instance.AddBattleMessage(null, 3, new Point(_local_2.Position.x, (_local_2.Position.y + 110)), _local_3, 0, 1, _local_7);
                };
            };
        }

        public function OnReceivedGuildMessage(_arg_1:ChatMessage):void
        {
        }

        public function OnReceivedPartyMessage(_arg_1:ChatMessage):void
        {
        }

        public function OnReceivedPrivateMessage(_arg_1:ChatMessage):void
        {
        }

        public function OnActorChangeManner(_arg_1:CharacterInfo, _arg_2:int):void
        {
            var _local_3:uint;
            if (_arg_1 == null)
            {
                return;
            };
            _local_3 = _arg_1.characterId;
            var _local_4:Character = this._characterActorData[_local_3];
            if (_local_4 == null)
            {
                return;
            };
            var _local_5:* = (_local_4 == this._localPlayerCharacter);
            if (_arg_2 == CharacterInfo.SP_MANNER)
            {
                if (_local_5)
                {
                    if ((((_arg_1.lastManner == 0) && (_arg_1.manner > 0)) && (!(_local_4.GetOption2(3)))))
                    {
                        ClientApplication.Instance.SetChatEnabled(false);
                        new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.MUTE_SETTED, null, null, true, new AttachIcon("AchtungIcon")));
                    }
                    else
                    {
                        if ((((_arg_1.lastManner > 0) && (_arg_1.manner == 0)) && (_local_4.GetOption2(3))))
                        {
                            ClientApplication.Instance.SetChatEnabled(true);
                            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.UNMUTE_SETTED, null, null, true, new AttachIcon("AchtungIcon")));
                        };
                    };
                };
                _local_4.SetOption2(3, (_arg_1.manner > 0));
            };
            if (_local_5)
            {
                switch (_arg_2)
                {
                    case CharacterInfo.SP_MANNER:
                        StatusManager.Instance.ChangeStatusItem(_arg_1.clothesColor, ActorActiveStatusEvent.SI_MANNER, _arg_1.manner);
                        return;
                    case CharacterInfo.SP_DEATHFEAR:
                        StatusManager.Instance.ChangeStatusItem(_arg_1.clothesColor, ActorActiveStatusEvent.SI_DEATHFEAR, _arg_1.deathfear);
                        return;
                    case CharacterInfo.SP_BREAKRIB:
                        StatusManager.Instance.ChangeStatusItem(_arg_1.clothesColor, ActorActiveStatusEvent.SI_BREAKRIB, _arg_1.breakrib);
                        return;
                    case CharacterInfo.SP_BREAKHEAD:
                        StatusManager.Instance.ChangeStatusItem(_arg_1.clothesColor, ActorActiveStatusEvent.SI_BREAKHEAD, _arg_1.breakhead);
                        return;
                    case CharacterInfo.SP_ARENAPUNISH:
                        StatusManager.Instance.ChangeStatusItem(_arg_1.clothesColor, ActorActiveStatusEvent.SI_LADDER, _arg_1.arenapunish);
                        return;
                };
            };
        }

        public function OnActorChangeStatus(_arg_1:ActorChangeStatusEvent):void
        {
            var _local_5:int;
            var _local_2:uint = _arg_1.characterId;
            var _local_3:Character = this._characterActorData[_local_2];
            if (_local_3 == null)
            {
                return;
            };
            if (_local_3.Invisible)
            {
                _local_5 = int(_local_2);
                if (((_local_5 > 0) && (this._characterActorData[uint(-(_local_5))] == null)))
                {
                    _local_3.Invisible = false;
                    _local_3.LocalCharacterInfo.showName = true;
                };
            };
            var _local_4:* = (_local_3 == this._localPlayerCharacter);
            if ((_arg_1.option & ActorChangeStatusEvent.OPTION_INVISIBLE))
            {
                _local_3.Invisible = true;
                _local_3.LocalCharacterInfo.showName = false;
            };
            if ((_arg_1.option & ActorChangeStatusEvent.OPTION_HIDE))
            {
                if (_local_4)
                {
                    _local_3.StartHide();
                }
                else
                {
                    if (this.CheckIntravision(this._localPlayerCharacter, _local_3))
                    {
                        _local_3.StartHide();
                    };
                };
            }
            else
            {
                if (((_arg_1.option == 0) || (_arg_1.option & ActorChangeStatusEvent.OPTION_CART1)))
                {
                    _local_3.RemoveAllStatus();
                };
            };
            if (_arg_1.option1 == ActorChangeStatusEvent.OPTION1_STUN)
            {
                _local_3.StartStun();
            }
            else
            {
                if (_arg_1.option1 == 0)
                {
                    _local_3.EndStun();
                };
            };
            _local_3.SetOption(ActorChangeStatusEvent.OPTION1_STONE, (_arg_1.option1 == ActorChangeStatusEvent.OPTION1_STONE));
            _local_3.SetOption(ActorChangeStatusEvent.OPTION1_FREEZE, (_arg_1.option1 == ActorChangeStatusEvent.OPTION1_FREEZE));
            _local_3.SetOption(ActorChangeStatusEvent.OPTION1_SLEEP, (_arg_1.option1 == ActorChangeStatusEvent.OPTION1_SLEEP));
            _local_3.SetOption2(ActorChangeStatusEvent.OPT2_SILENCE, ((_arg_1.option2 & ActorChangeStatusEvent.OPT2_SILENCE) > 0));
            _local_3.SetOption2(ActorChangeStatusEvent.OPT2_POISON, ((_arg_1.option2 & ActorChangeStatusEvent.OPT2_POISON) > 0));
            _local_3.SetOption2(ActorChangeStatusEvent.OPT2_CURSE, ((_arg_1.option2 & ActorChangeStatusEvent.OPT2_CURSE) > 0));
            _local_3.SetOption2(ActorChangeStatusEvent.OPT2_DEATHFEAR, ((_arg_1.option2 & ActorChangeStatusEvent.OPT2_DEATHFEAR) > 0));
            _local_3.SetOption2(ActorChangeStatusEvent.OPT2_ROCKSKIN, ((_arg_1.option2 & ActorChangeStatusEvent.OPT2_ROCKSKIN) > 0));
            _local_3.SetOption2(ActorChangeStatusEvent.OPT2_RAGETUDRAH, ((_arg_1.option2 & ActorChangeStatusEvent.OPT2_RAGETUDRAH) > 0));
            _local_3.SetOption2(ActorChangeStatusEvent.OPT2_FLAG, ((_arg_1.option2 & ActorChangeStatusEvent.OPT2_FLAG) > 0));
            _local_3.SetOption2(ActorChangeStatusEvent.OPT2_FLAG2, ((_arg_1.option2 & ActorChangeStatusEvent.OPT2_FLAG2) > 0));
            _local_3.SetOption2(ActorChangeStatusEvent.OPT2_FLAG3, ((_arg_1.option2 & ActorChangeStatusEvent.OPT2_FLAG3) > 0));
            _local_3.SetOption2(ActorChangeStatusEvent.OPT2_FLAG4, ((_arg_1.option2 & ActorChangeStatusEvent.OPT2_FLAG4) > 0));
            _local_3.SetOption2(ActorChangeStatusEvent.OPT2_FLAG5, ((_arg_1.option2 & ActorChangeStatusEvent.OPT2_FLAG5) > 0));
        }

        public function OnActorActiveStatus(_arg_1:ActorActiveStatusEvent):void
        {
            var _local_4:CharacterInfo;
            var _local_5:uint;
            var _local_6:CharacterAnimation;
            var _local_2:uint = _arg_1.characterId;
            var _local_3:Character = this._characterActorData[_local_2];
            if (_local_3 == null)
            {
                _local_4 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                if (_local_4.characterId == _local_2)
                {
                    _local_5 = this.GetCharacterAnimationIndex(_local_4);
                    _local_6 = this.GetCharacterAnimation(_local_5).Clone();
                    this._localPlayerCharacter = new Character(_local_6, _local_4, _local_5, true);
                    this._characterActorData[_local_4.characterId] = this._localPlayerCharacter;
                    _local_3 = this._characterActorData[_local_2];
                };
            };
            if (_local_3 == null)
            {
                return;
            };
            if (_arg_1.flag == 1)
            {
                if (_arg_1.statusType == ActorActiveStatusEvent.SI_HIDING)
                {
                    if (_local_3 == this._localPlayerCharacter)
                    {
                        _local_3.StartHide();
                    }
                    else
                    {
                        if (this.CheckIntravision(this._localPlayerCharacter, _local_3))
                        {
                            _local_3.StartHide();
                        };
                    };
                };
                if (_local_3 == this._localPlayerCharacter)
                {
                    if (_arg_1.statusType == ActorActiveStatusEvent.SI_INTRAVISION)
                    {
                        _local_3.LocalCharacterInfo.intravision = true;
                    };
                    StatusManager.Instance.OnStatusItem(_local_3.LocalCharacterInfo.clothesColor, _arg_1.statusType, _arg_1.duration);
                };
            }
            else
            {
                if (_arg_1.statusType == ActorActiveStatusEvent.SI_HIDING)
                {
                    if (_local_3 == this._localPlayerCharacter)
                    {
                        _local_3.RemoveAllStatus();
                    }
                    else
                    {
                        if (this.CheckIntravision(this._localPlayerCharacter, _local_3))
                        {
                            _local_3.RemoveAllStatus();
                        };
                    };
                };
                if (_local_3 == this._localPlayerCharacter)
                {
                    if (_arg_1.statusType == ActorActiveStatusEvent.SI_INTRAVISION)
                    {
                        _local_3.LocalCharacterInfo.intravision = false;
                    };
                    StatusManager.Instance.OffStatusItem(_arg_1.statusType);
                };
            };
        }

        public function OnSkillNoDamage(_arg_1:SkillCastNoDamage):void
        {
            var _local_4:int;
            var _local_5:int;
            var _local_2:Character = this._characterActorData[_arg_1.TargetId];
            var _local_3:int = -1;
            if (((((_arg_1.Fail == 0) || (_local_2 == null)) || (_local_2.CharacterType == Character.CHARACTER_NPC)) || (_local_2.CharacterType == Character.CHARACTER_UNKNOWN)))
            {
                return;
            };
            switch (_arg_1.SkillId)
            {
                case 28:
                    _local_3 = 9;
                    break;
                case 54:
                    _local_3 = 10;
                    break;
                case 45:
                    _local_3 = 11;
                    break;
                case 653:
                    _local_3 = 12;
                    break;
                case 489:
                    _local_3 = 14;
                    break;
            };
            if (_local_3 > 0)
            {
                _local_4 = int((((_local_2.Position.x - 20) / CharacterStorage.CELL_SIZE) + 1));
                _local_5 = int((((_local_2.Position.y + 60) / CharacterStorage.CELL_SIZE) - 1));
                SkillUnitManager.Instance.AddSkillUnit(-1, 134, _local_3, _local_4, _local_5);
            };
        }

        public function OnExpChanged():void
        {
            var _local_1:int;
            if (this._localPlayerCharacter == null)
            {
                return;
            };
            if (this._localPlayerCharacter.LocalCharacterInfo == null)
            {
                return;
            };
            if (this._localPlayerCharacter.LocalCharacterInfo.lastBaseExp <= 0)
            {
                return;
            };
            _local_1 = int(Math.floor((Math.random() * 20)));
            var _local_2:uint = 39372;
            var _local_3:Point = new Point(this._localPlayerCharacter.Position.x, ((this._localPlayerCharacter.Position.y + 100) + _local_1));
            var _local_4:String = ((("+" + this._localPlayerCharacter.LocalCharacterInfo.lastBaseExp) + " ") + ClientApplication.Localization.BATTLE_EXP_UP);
            var _local_5:Boolean = ((!(this.PvPMode == 3)) || (this._isShowGWDamage));
            if (_local_5)
            {
                BattleLogManager.Instance.AddBattleMessage(_local_4, 1.5, new Point(this._localPlayerCharacter.Position.x, (this._localPlayerCharacter.Position.y + 50)), _local_3, _local_2);
            };
            this._localPlayerCharacter.LocalCharacterInfo.lastBaseExp = 0;
        }

        public function OnMoneyChanged():void
        {
            var _local_2:int;
            if (((this._localPlayerCharacter == null) || (this._localPlayerCharacter.LocalCharacterInfo == null)))
            {
                return;
            };
            var _local_1:int = this._localPlayerCharacter.LocalCharacterInfo.lastMoney;
            if (_local_1 < 0)
            {
                StatisticManager.Instance.SendEventNum("spentSilver", _local_1);
                this._localPlayerCharacter.LocalCharacterInfo.lastMoney = 0;
                return;
            };
            if (_local_1 == 0)
            {
                return;
            };
            _local_2 = int(Math.floor((Math.random() * 10)));
            var _local_3:uint = 0xDDDDDD;
            var _local_4:Point = new Point(this._localPlayerCharacter.Position.x, ((this._localPlayerCharacter.Position.y + 80) + _local_2));
            var _local_5:String = ((("+" + _local_1) + " ") + ClientApplication.Localization.BATTLE_ZENY_UP);
            BattleLogManager.Instance.AddBattleMessage(_local_5, 1, new Point(this._localPlayerCharacter.Position.x, (this._localPlayerCharacter.Position.y + 25)), _local_4, _local_3);
            StatisticManager.Instance.SendEventNum("getSilver", _local_1);
            this._localPlayerCharacter.LocalCharacterInfo.lastMoney = 0;
        }

        public function OnGoldChanged():void
        {
            var _local_2:int;
            if (((this._localPlayerCharacter == null) || (this._localPlayerCharacter.LocalCharacterInfo == null)))
            {
                return;
            };
            var _local_1:int = this._localPlayerCharacter.LocalCharacterInfo.lastGold;
            if (_local_1 < 0)
            {
                this._localPlayerCharacter.LocalCharacterInfo.lastGold = 0;
                return;
            };
            if (_local_1 == 0)
            {
                return;
            };
            _local_2 = int(Math.floor((Math.random() * 10)));
            var _local_3:uint = 0xFFD700;
            var _local_4:Point = new Point(this._localPlayerCharacter.Position.x, ((this._localPlayerCharacter.Position.y + 80) + _local_2));
            var _local_5:String = ((("+" + _local_1) + " ") + ClientApplication.Localization.BATTLE_GOLD_UP);
            BattleLogManager.Instance.AddBattleMessage(_local_5, 1, new Point(this._localPlayerCharacter.Position.x, (this._localPlayerCharacter.Position.y + 25)), _local_4, _local_3);
            this._localPlayerCharacter.LocalCharacterInfo.lastGold = 0;
        }

        public function OnSkillHeal(_arg_1:SkillHealEvent):void
        {
            var _local_3:int;
            var _local_5:uint;
            var _local_6:String;
            if (this._localPlayerCharacter == null)
            {
                return;
            };
            var _local_2:int = _arg_1.Type;
            if (((!(_local_2 == 5)) && (!(_local_2 == 7))))
            {
                return;
            };
            _local_3 = int(Math.floor((Math.random() * 20)));
            var _local_4:Point = new Point(this._localPlayerCharacter.Position.x, ((this._localPlayerCharacter.Position.y + 100) + _local_3));
            if (_local_2 == 5)
            {
                _local_5 = 43588;
                _local_6 = ((ClientApplication.Localization.BATTLE_SKILL_HEAL + " +") + _arg_1.Value);
            }
            else
            {
                if (_local_2 == 7)
                {
                    _local_5 = 17578;
                    _local_6 = ((ClientApplication.Localization.BATTLE_SKILL_MANA + " +") + _arg_1.Value);
                };
            };
            BattleLogManager.Instance.AddBattleMessage(_local_6, 1, new Point(this._localPlayerCharacter.Position.x, (this._localPlayerCharacter.Position.y + 50)), _local_4, _local_5);
        }

        public function OnPvPModeChanged(_arg_1:PvPModeEvent):void
        {
            this._pvpMode = _arg_1.PvpMode;
            if (Music.Instance.MusicEnabled)
            {
                if (this._pvpMode == 3)
                {
                    Music.Instance.PlayBattle();
                }
                else
                {
                    Music.Instance.PlayIdle();
                };
            };
        }

        public function OnSkillUse(_arg_1:SkillUseEvent):void
        {
            var _local_2:ActorActionEvent = new ActorActionEvent();
            if (_arg_1.damage == -30000)
            {
                return;
            };
            _local_2.sourceID = _arg_1.srcId;
            _local_2.targetID = _arg_1.dstId;
            _local_2.tick = _arg_1.tick;
            _local_2.sourceDelay = _arg_1.sdelay;
            _local_2.targetDelay = _arg_1.ddelay;
            _local_2.damage = _arg_1.damage;
            _local_2.div = _arg_1.div;
            _local_2.actionType = 0;
            _local_2.damage2 = 0;
            _local_2.skillId = _arg_1.skillId;
            this.OnReceivedActorAction(_local_2);
        }

        public function OnGuildUpdated(_arg_1:GuildEvent):void
        {
            if (this._localPlayerCharacter != null)
            {
                this._localPlayerCharacter.UpdateCharacterName();
            };
        }

        public function OnActorLevelUp(_arg_1:ActorStatsEvent):void
        {
            var _local_2:uint = _arg_1.Actor.characterId;
            var _local_3:Character = this._characterActorData[_local_2];
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:Point = new Point(_local_3.Position.x, (_local_3.Position.y + 180));
            var _local_5:Point = new Point(_local_3.Position.x, (_local_3.Position.y + 20));
            BattleLogManager.Instance.AddBattleMessage(("+" + ClientApplication.Localization.BATTLE_LEVEL_UP), 5, _local_5, _local_4, 4435517);
            _local_3.StartLevelUpFx();
        }

        public function OnActorJobLevelUp(_arg_1:ActorStatsEvent):void
        {
            var _local_2:uint = _arg_1.Actor.characterId;
            var _local_3:Character = this._characterActorData[_local_2];
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:Point = new Point(_local_3.Position.x, (_local_3.Position.y + 150));
            var _local_5:Point = new Point(_local_3.Position.x, (_local_3.Position.y + 20));
            BattleLogManager.Instance.AddBattleMessage(("+" + ClientApplication.Localization.BATTLE_JOB_LEVEL_UP), 5, _local_5, _local_4, 10606366);
            _local_3.StartLevelUpFx();
        }

        public function OnPlayerSkillFailed(_arg_1:CharacterEvent):void
        {
            var _local_2:uint = _arg_1.Player.characterId;
            var _local_3:Character = this._characterActorData[_local_2];
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:Point = new Point(_local_3.Position.x, (_local_3.Position.y + 150));
            var _local_5:Point = new Point(_local_3.Position.x, (_local_3.Position.y + 20));
            BattleLogManager.Instance.AddBattleMessage(_arg_1.Info, 5, _local_5, _local_4, 10606366);
        }

        public function OnActorRefineResult(_arg_1:ActorStatsEvent):void
        {
            var _local_2:uint = _arg_1.Actor.characterId;
            var _local_3:Character = this._characterActorData[_local_2];
            if (_local_3 == null)
            {
                return;
            };
            var _local_4:Point = new Point(_local_3.Position.x, (_local_3.Position.y + 150));
            var _local_5:Point = new Point(_local_3.Position.x, (_local_3.Position.y + 20));
            if (_arg_1.EventId == ActorStatsEvent.ID_REFINE_FAILED)
            {
                BattleLogManager.Instance.AddBattleMessage(ClientApplication.Localization.BATTLE_REFINE_FAIL, 5, _local_5, _local_4, 10606366);
            }
            else
            {
                if (_arg_1.EventId == ActorStatsEvent.ID_REFINE_SUCCESS)
                {
                    BattleLogManager.Instance.AddBattleMessage(ClientApplication.Localization.BATTLE_REFINE_SUCCESS, 5, _local_5, _local_4, 10606366);
                };
            };
        }

        public function OnGetAreaCharItem(_arg_1:FloorItemEvent):void
        {
            MapItemManager.Instance.AddMapItem(_arg_1.ItemId, _arg_1.NameId, _arg_1.IdentifyFlag, _arg_1.PosX, _arg_1.PosY, _arg_1.SubX, _arg_1.SubY, _arg_1.Amount);
        }

        public function OnFloorItemAppeared(_arg_1:FloorItemEvent):void
        {
            MapItemManager.Instance.AddMapItem(_arg_1.ItemId, _arg_1.NameId, _arg_1.IdentifyFlag, _arg_1.PosX, _arg_1.PosY, _arg_1.SubX, _arg_1.SubY, _arg_1.Amount);
        }

        public function OnFloorItemDisappeared(_arg_1:FloorItemEvent):void
        {
            MapItemManager.Instance.RemoveMapItem(_arg_1.ItemId);
        }

        public function OnPlayerRespawned(_arg_1:ClientEvent):void
        {
            if (this._localPlayerCharacter != null)
            {
                this._localPlayerCharacter.CharacterLevel = this._localPlayerCharacter.LocalCharacterInfo.baseLevel;
                this._localPlayerCharacter.Respawn();
            };
        }

        public function OnPlayerResurrected(_arg_1:ActorDisplayEvent):void
        {
            var _local_2:CharacterInfo;
            _local_2 = _arg_1.Character;
            var _local_3:uint = _local_2.characterId;
            var _local_4:Character = this._characterActorData[_local_3];
            if (_local_4 != null)
            {
                _local_4.TurnIdle();
            };
        }

        public function OnChangeMap():void
        {
            var _local_1:Character;
            var _local_2:CharacterInfo;
            var _local_3:uint;
            var _local_4:CharacterAnimation;
            this._pvpMode = 0;
            this._localPlayerCharacter = null;
            this._lastSelectedCharacter = null;
            for each (_local_1 in this._characterActorData)
            {
                if (_local_1 != null)
                {
                    _local_1.Release();
                };
            };
            this._characterActorData = new Dictionary(true);
            MapItemManager.Instance.Clear();
            SkillUnitManager.Instance.Clear();
            _local_2 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            _local_3 = this.GetCharacterAnimationIndex(_local_2);
            _local_4 = this.GetCharacterAnimation(_local_3).Clone();
            this._localPlayerCharacter = new Character(_local_4, _local_2, _local_3, true);
            this._characterActorData[_local_2.characterId] = this._localPlayerCharacter;
            this.LoadCustomization(MAN_CUSTOMIZATION);
            this.LoadCustomization(WOMAN_CUSTOMIZATION);
            this.LoadCustomization(ORC_MAN_CUSTOMIZATION);
            this.LoadCustomization(ORC_WOMAN_CUSTOMIZATION);
            this.LoadCustomization(UNDEAD_MAN_CUSTOMIZATION);
            this.LoadCustomization(UNDEAD_WOMAN_CUSTOMIZATION);
            ClientApplication.Instance.LocalGameClient.addEventListener(ActorActionEvent.ON_ACTOR_ACTION, this.OnReceivedActorAction, false, 0, true);
            this._localPlayerCharacter.CharacterLevel = _local_2.baseLevel;
        }

        private function LoadCustomization(_arg_1:int):void
        {
            var _local_2:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetCustomization(_arg_1);
            var _local_3:CharacterAnimation = this.GetCustomizationAnimation(_arg_1).Clone();
            this._characterActorData[_local_2.characterId] = new Character(_local_3, _local_2, _arg_1, true);
        }

        private function OnPlayerMove(_arg_1:Event):void
        {
        }

        private function OnActorUpdateDir(_arg_1:ActorDisplayEvent):void
        {
            var _local_2:uint = _arg_1.Character.characterId;
            var _local_3:Character = this._characterActorData[_local_2];
            if (_local_3 == null)
            {
                return;
            };
            _local_3.SetIdleOrientation();
        }

        private function OnActorDisappear(_arg_1:ActorDisplayEvent):void
        {
            var _local_2:CharacterInfo;
            _local_2 = _arg_1.Character;
            var _local_3:uint = _local_2.characterId;
            var _local_4:Character = this._characterActorData[_local_3];
            if (_local_4 != null)
            {
                if (_local_4.Selected)
                {
                    this.SelectCharacter(null, true);
                };
                if (_arg_1.Action == ActorDisplayEvent.DIED)
                {
                    _local_4.OnDeadStart();
                    if (_local_4 == this._localPlayerCharacter)
                    {
                    };
                }
                else
                {
                    if ((((_arg_1.Action == ActorDisplayEvent.MOVED_OUT_OF_SIGHT) || (_arg_1.Action == ActorDisplayEvent.RESPAWNED)) || (_arg_1.Action == ActorDisplayEvent.TELEPORTED)))
                    {
                        _local_4.Release();
                        this._characterActorData[_local_3] = null;
                    };
                };
            };
        }

        private function GetCharacterAnimationIndex(_arg_1:CharacterInfo):uint
        {
			trace("GetCharacterAnimationIndex");
            var _local_3:uint;
            var _local_5:Object;
            var _local_6:Object;
            var _local_7:Object;
            var _local_8:String;
            var _local_9:AdditionalDataResourceLibrary;
            var _local_10:Object;
            var _local_11:Object;
            var _local_12:Object;
            var _local_13:Object;
            var _local_14:int;
            var _local_15:int;
            var _local_16:int;
            var _local_17:int;
            var _local_18:Boolean;
            var _local_19:Boolean;
            var _local_20:Boolean;
            var _local_2:uint;
            _local_3 = _arg_1.characterId;
            var _local_4:Boolean = ((int(_local_3) < 0) || ((_arg_1.DisguiseId > 1000) && (_arg_1.DisguiseId < 4000)));
            if (((_local_3 >= 100000000) || (_local_4)))
            {
                _local_9 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
                if (_local_2 == 0)
                {
                    if (_arg_1.DisguiseId == Rabbitgedon.ID_CRAZY_RABBIT)
                    {
                        _local_2 = Rabbitgedon.ID_CRAZY_RABBIT;
                        _arg_1.internalName = "Crazy Rabbit";
                        _arg_1.showName = true;
                        _arg_1.drawShadow = false;
                        _arg_1.nameColor = -1;
                    };
                    _local_10 = ((_local_4) ? _local_9.GetMonstersDataById(_arg_1.DisguiseId) : _local_9.GetMonstersData(_arg_1.name));
                    trace("GetCharacterAnimationIndex_arg_1.name1: " + _arg_1.name);
					trace("GetCharacterAnimationIndex_arg_1.DisguiseId1: " + _arg_1.DisguiseId);
					if (_local_10 != null)
                    {
                        _local_2 = _local_10["Sprite"];
                        _arg_1.internalName = _local_10["iName"];
                        _local_6 = _local_10["ShowName"];
                        _arg_1.showName = ((_local_6 != null) ? (_local_6 as Boolean) : true);
                        _local_5 = _local_10["DrawShadow"];
                        _arg_1.drawShadow = ((_local_5 != null) ? (_local_5 as Boolean) : true);
                        _local_8 = _local_10["NameColor"];
                        _arg_1.nameColor = ((_local_8 != null) ? HtmlText.combineRGBFromHex(_local_8) : -1);
                    };
                };
				trace("GetCharacterAnimationIndex: == _local_2: " + _local_2);
                if (_local_2 == 0)
                {
                    _local_11 = _local_9.GetNpcDataFromName(_arg_1.name);
					trace("GetCharacterAnimationIndex_local_11: " + _local_11);
					trace("GetCharacterAnimationIndex_arg_1.name: " + _arg_1.name);
					trace("GetCharacterAnimationIndex_arg_1.DisguiseId: " + _arg_1.DisguiseId);
                    if (_local_11 != null)
                    {
                        _local_2 = _local_11["CharacterIndex"];
                        _arg_1.internalName = _local_11["Name"];
                        _local_12 = _local_11["Visible"];
                        _arg_1.needDraw = ((_local_12 != null) ? (_local_12 as Boolean) : true);
                        _local_5 = _local_11["DrawShadow"];
                        _arg_1.drawShadow = ((_local_5 != null) ? (_local_5 as Boolean) : true);
                        _local_6 = _local_11["ShowName"];
                        _arg_1.showName = ((_local_6 != null) ? (_local_6 as Boolean) : true);
                        _local_13 = _local_11["AllowSelection"];
                        _arg_1.allowSelection = ((_local_13 != null) ? (_local_13 as Boolean) : true);
                        _local_7 = _local_11["AutoHideName"];
                        _arg_1.autoHideName = ((_local_7 != null) ? _local_7 : false);
                        _local_8 = _local_11["NameColor"];
                        _arg_1.nameColor = ((_local_8 != null) ? HtmlText.combineRGBFromHex(_local_8) : -1);
                    }
                    else
                    {
                        if (((_arg_1.jobId == 45) || (!(_arg_1.name.indexOf("Warp") == -1))))
                        {
                            _local_2 = 300;
                        };
                    };
                };
                if (((_local_2 == 0) && (_arg_1.jobId <= 25)))
                {
                    _local_14 = _arg_1.sex;
                    _local_15 = _arg_1.jobId;
                    if (_local_14 == 1)
                    {
                        _local_2 = (_local_15 + 10);
                    }
                    else
                    {
                        _local_2 = (_local_15 + 40);
                    };
                };
            }
            else
            {
                if (_local_3 >= 2000000)
                {
                    _local_16 = _arg_1.sex;
                    _local_17 = _arg_1.jobId;
                    _local_18 = Character.IsBabyClass(_local_17);
                    _local_19 = ((_local_18) ? false : Character.IsAdvancedClass(_local_17));
                    _local_20 = (_arg_1.clothesColor > 0);
                    _local_2 = ((((_local_17 + ((_local_16 == 1) ? 10 : 40)) + ((_local_18) ? (100 - 4023) : 0)) + ((_local_19) ? (3000 - 4001) : 0)) + ((_local_20) ? 2000 : 0));
                };
            };
            if ((((_local_2 == 40) || (_local_2 == 0)) && ((_arg_1.characterId - 110000000) >= 1000)))
            {
                _local_2 = 1900;
            };
			trace("_local_2: " + _local_2);
            return (_local_2);
        }

        private function OnChangeHairColor(_arg_1:ActorDisplayEvent):void
        {
            var _local_2:CharacterInfo;
            var _local_5:uint;
            var _local_6:CharacterAnimation;
            _local_2 = _arg_1.Character;
            var _local_3:uint = _local_2.characterId;
            var _local_4:Character = this._characterActorData[_local_3];
            if (_local_4 != null)
            {
                _local_5 = this.GetCharacterAnimationIndex(_local_2);
                _local_6 = this.GetCharacterAnimation(_local_5).Clone();
                _local_4.ChangeCharacterInfo(_local_6, _local_2, _local_5);
            };
        }

        private function OnActorDisplay(_arg_1:ActorDisplayEvent):void
        {
            var _local_2:CharacterInfo;
            var _local_3:uint;
            var _local_7:Character;
            var _local_8:uint;
            var _local_9:CharacterAnimation;
            var _local_10:uint;
            var _local_11:uint;
            var _local_12:CharacterAnimation;
            var _local_13:CharacterAnimation;
            _local_2 = _arg_1.Character;
            _local_3 = _local_2.characterId;
            var _local_4:Character = this._characterActorData[_local_3];
            var _local_5:Boolean = ((_arg_1.disguiseId > 1000) && (_arg_1.disguiseId < 4000));
            var _local_6:int = int(_local_3);
            if (((_local_6 < 0) && (!(this._characterActorData[-(_local_6)] == null))))
            {
                _local_7 = this._characterActorData[-(_local_6)];
                _local_7.Invisible = true;
                _local_7.LocalCharacterInfo.showName = false;
            };
            this.OnActorChangeManner(_local_2, CharacterInfo.SP_MANNER);
            if (_local_4 == null)
            {
                if (_local_5)
                {
                    _local_2.DisguiseId = _arg_1.disguiseId;
                };
                _local_8 = this.GetCharacterAnimationIndex(_local_2);
                _local_9 = this.GetCharacterAnimation(_local_8).Clone();
                _local_4 = new Character(_local_9, _local_2, _local_8);
                this._characterActorData[_local_3] = _local_4;
            }
            else
            {
                _local_10 = _local_4.CharacterAnimationIndex;
                _local_11 = this.GetCharacterAnimationIndex(_local_2);
                if (_local_10 != _local_11)
                {
                    _local_12 = this.GetCharacterAnimation(_local_11).Clone();
                    _local_4.ChangeCharacterInfo(_local_12, _local_2, _local_11);
                }
                else
                {
                    if (((!(_local_4.Name == _local_2.name)) && (!(_local_2.name == null))))
                    {
                        _local_13 = this.GetCharacterAnimation(_local_10).Clone();
                        _local_4.ChangeCharacterInfo(_local_13, _local_2, _local_10);
                    }
                    else
                    {
                        if (((_local_4.CharacterType == Character.CHARACTER_PLAYER) || (_local_10 == 1900)))
                        {
                            _local_4.UpdateCharacterName();
                        }
                        else
                        {
                            if (((_local_4.CharacterType == Character.CHARACTER_NPC) && (_local_2.jobId == 45)))
                            {
                                _local_4.UpdateCharacterName(false, true);
                            };
                        };
                    };
                };
            };
            if (_arg_1.withOptions)
            {
                _local_4.Invisible = ((_arg_1.option & ActorChangeStatusEvent.OPTION_INVISIBLE) > 0);
                if ((_arg_1.option & ActorChangeStatusEvent.OPTION_HIDE))
                {
                    if (_local_4 == this._localPlayerCharacter)
                    {
                        _local_4.StartHide();
                    }
                    else
                    {
                        if (this.CheckIntravision(this._localPlayerCharacter, _local_4))
                        {
                            _local_4.StartHide(true);
                        };
                    };
                };
            };
            if (_local_4.CharacterType == Character.CHARACTER_PLAYER)
            {
                if (((_local_4.LocalCharacterInfo.isDead) && (!(_local_4 == this._localPlayerCharacter))))
                {
                    _local_4.TurnDead();
                };
            };
            _local_4.NeedDraw = _local_2.needDraw;
            _local_4.DrawShadow = _local_2.drawShadow;
            _local_4.CharacterLevel = _local_2.baseLevel;
            _local_4.Invisible = _local_2.invisible;
        }

        public function OnMouseMove(_arg_1:MouseEvent):void
        {
            this._lastPointerPosition.x = _arg_1.stageX;
            this._lastPointerPosition.y = _arg_1.stageY;
            this.UpdateCursor();
        }

        private function UpdateCursor():void
        {
            var _local_1:int = int(int(((RenderSystem.Instance.MainCamera.TopLeftPoint.x + this._lastPointerPosition.x) / CELL_SIZE)));
            var _local_2:int = int(int((((RenderSystem.Instance.MainCamera.MaxHeight - this._lastPointerPosition.y) - RenderSystem.Instance.MainCamera.TopLeftPoint.y) / CELL_SIZE)));
            this._movePointerPosition.x = _local_1;
            this._movePointerPosition.y = _local_2;
            var _local_3:MapCollisionData = MapCollisionManager.Instance.CurrentMap;
            if (_local_3 != null)
            {
                this._movePointerCollision = _local_3.GetValue(_local_1, _local_2);
            };
        }

        public function IsCharacterIntersected(_arg_1:Rectangle):Boolean
        {
            var _local_2:Character;
            var _local_3:Boolean;
            for each (_local_2 in this._characterActorData)
            {
                if (_local_2 != null)
                {
                    if (_local_2.IsValid)
                    {
                        if (!((_local_2.CharacterType == Character.CHARACTER_MONSTER) && (_local_2.IsDead)))
                        {
                            _local_3 = _local_2.IsIntersected(_arg_1);
                            if (_local_3)
                            {
                                return (true);
                            };
                        };
                    };
                };
            };
            return (false);
        }

        public function RemoveCharacter(_arg_1:Character):void
        {
            this._characterActorData[_arg_1.CharacterId] = null;
        }

        public function SelectCharacter(_arg_1:Character, _arg_2:Boolean=false):void
        {
            var _local_4:Object;
            var _local_5:int;
            var _local_6:CharacterInfo;
            if (((!(_arg_1 == null)) && (!(this._lastSelectedCharacter == null))))
            {
                this._lastSelectedCharacter.Selected = false;
            };
            if (_arg_1 != null)
            {
                this._lastSelectedCharacter = _arg_1;
            };
            if (this._lastSelectedCharacter != null)
            {
                this._lastSelectedCharacter.Selected = true;
            };
            if (((_arg_1 == null) && (_arg_2)))
            {
                if (this._lastSelectedCharacter != null)
                {
                    this._lastSelectedCharacter.Selected = false;
                };
                this._lastSelectedCharacter = null;
            };
            var _local_3:SelectedActorInfoNew = ClientApplication.Instance.TopHUD.GetSelectedActorInfo();
            _local_3._characterId.visible = false;
            if ((((this._lastSelectedCharacter == null) || (this._lastSelectedCharacter.LocalCharacterInfo == null)) || ((!(this._lastSelectedCharacter.CharacterType == Character.CHARACTER_PLAYER)) && (!(this._lastSelectedCharacter.CharacterType == Character.CHARACTER_MONSTER)))))
            {
                _local_3.visible = false;
            }
            else
            {
                _local_3.visible = true;
                _local_3._progress._progressMask.scaleX = 1;
                if (this._lastSelectedCharacter.CharacterType == Character.CHARACTER_MONSTER)
                {
                    _local_4 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetMonstersData(this._lastSelectedCharacter.Name);
                    if (_local_4 != null)
                    {
                        _local_5 = _local_4["LV"];
                        _local_3._name.text = this._lastSelectedCharacter.InternalName;
                        _local_3._level.text = _local_5.toString();
                    }
                    else
                    {
                        _local_3._name.text = this._lastSelectedCharacter.InternalName;
                        _local_3._level.text = "1";
                    };
                    _local_3._characterId.text = "";
                    HelpManager.Instance.SelectMob(this._lastSelectedCharacter.Name);
                    _local_3._equipButton.visible = false;
                }
                else
                {
                    _local_6 = this._lastSelectedCharacter.LocalCharacterInfo;
                    _local_3._name.text = ((_local_6 != null) ? ((_local_6.guildName != null) ? (((_local_6.name + "[") + _local_6.guildName) + "]") : _local_6.internalName) : "");
                    _local_3._level.text = ((_local_6 != null) ? _local_6.baseLevel.toString() : "1");
                    _local_3._characterId.text = _local_6.characterId.toString();
                    _local_3._equipButton.visible = false;
                };
                if (this._lastSelectedCharacter.LocalCharacterInfo.maxHp > 0)
                {
                    _local_3._progress._progressMask.scaleX = (Number(this._lastSelectedCharacter.LocalCharacterInfo.hp) / Number(this._lastSelectedCharacter.LocalCharacterInfo.maxHp));
                };
                if (_local_3._progress._progressMask.scaleX == 0)
                {
                    _local_3.visible = false;
                };
            };
        }

        public function GetTargetCharacter(_arg_1:Point):Character
        {
            var _local_2:Character;
            var _local_3:Boolean;
            for each (_local_2 in this._characterActorData)
            {
                if (_local_2 != null)
                {
                    if (_local_2.IsValid)
                    {
                        if (!_local_2.IsDead)
                        {
                            _local_3 = _local_2.IsCollided(_arg_1);
                            if (((_local_3) && (!(this._localPlayerCharacter == _local_2))))
                            {
                                return (_local_2);
                            };
                        };
                    };
                };
            };
            return (null);
        }

        public function OnMouseClick(_arg_1:MouseEvent):void
        {
            var _local_6:Character;
            var _local_12:Boolean;
            var _local_13:int;
            var _local_14:Number;
            var _local_15:Character;
            var _local_16:Number;
            var _local_17:Vector2D;
            var _local_18:Number;
            var _local_19:Vector2D;
            var _local_20:SkillData;
            if (this._localPlayerCharacter == null)
            {
                return;
            };
            this.AwayMapItemId = -1;
            this.SkillCharacterId = -1;
            if (this._localPlayerCharacter.CurrentState == CharacterState.Dead)
            {
                return;
            };
            if (ClientApplication.Instance.IsBusyMode)
            {
                return;
            };
            var _local_2:Character;
            var _local_3:Point = new Point(_arg_1.stageX, _arg_1.stageY);
            if (this.SkillMode > 0)
            {
                if (this.SkillPanelSlot >= 0)
                {
                    ClientApplication.Instance.BottomHUD.InventoryBarInstance.DoCooldownSlot(this.SkillPanelSlot);
                };
                ClientApplication.Instance.LocalGameClient.SendSkillUseOnLocation(this.SkillMode, this.SkillLevel, CharacterStorage.Instance.MovePointerPosition.x, CharacterStorage.Instance.MovePointerPosition.y);
                ClientApplication.Instance.BottomHUD.InventoryBarInstance.DoCooldownSkillSlots(this.SkillMode, 0, this.SkillPanelSlot);
                this.SkillMode = 0;
                this.SkillLevel = 0;
                this.SkillRangeSqr = 0;
                this.SkillPanelSlot = -1;
                return;
            };
            var _local_4:Boolean;
            var _local_5:Boolean = ClientApplication.Instance.isDieOnLadder;
            for each (_local_6 in this._characterActorData)
            {
                if (_local_6 != null)
                {
                    if (_local_6.IsValid)
                    {
                        if (_local_6.IsDead)
                        {
                            if ((((this._localPlayerCharacter.LocalCharacterInfo.jobId == 8) || (this._localPlayerCharacter.LocalCharacterInfo.jobId == 4032)) && (!(_local_5))))
                            {
                                if (_local_6.CharacterType != Character.CHARACTER_PLAYER) continue;
                            }
                            else
                            {
                                continue;
                            };
                        };
                        _local_12 = _local_6.IsCollided(_local_3);
                        if ((((_local_12) && (!(this._localPlayerCharacter == _local_6))) && (!(this._localPlayerCharacter.Position == null))))
                        {
                            _local_13 = int(_local_6.CharacterId);
                            if (!((_local_13 < 0) && (this._localPlayerCharacter.CharacterId == -(_local_13))))
                            {
                                _local_2 = _local_6;
                                _local_14 = Vector2D.distanceSquared(Vector2D.fromPoint(this._localPlayerCharacter.Position).divide(CELL_SIZE), Vector2D.fromPoint(_local_2.Position).divide(CELL_SIZE));
                                if ((((_local_2.CharacterType == Character.CHARACTER_NPC) || (_local_14 <= ((this._localPlayerCharacter.LocalCharacterInfo.range * this._localPlayerCharacter.LocalCharacterInfo.range) + 2))) || (_local_2.IsShopMode)))
                                {
                                    if (!_local_2.IsSelecting) break;
                                    _local_15 = this._lastSelectedCharacter;
                                    this.SelectCharacter(_local_6);
                                    if (_local_15 != this._lastSelectedCharacter)
                                    {
                                        return;
                                    };
                                    if (((_local_2.IsShopMode) && (_local_2.LocalCharacterFraction == this._localPlayerCharacter.LocalCharacterFraction)))
                                    {
                                        ClientApplication.Instance.LocalGameClient.SendVenderConnect(_local_2.CharacterId);
                                    }
                                    else
                                    {
                                        ClientApplication.Instance.LocalGameClient.SendAttack(_local_6.CharacterId, 7);
                                    };
                                    return;
                                };
                                break;
                            };
                        };
                    };
                };
            };
            if (((((_local_2) && (!(_local_2 == this._lastSelectedCharacter))) && (_local_2.IsSelecting)) && (!(_local_2.CharacterType == Character.CHARACTER_NPC))))
            {
                _local_4 = true;
            };
            if (((_local_2 == null) || ((!(_local_2 == null)) && (_local_2.IsSelecting))))
            {
                this.SelectCharacter(_local_2);
            };
            var _local_7:Boolean = true;
            var _local_8:MapItemObject = MapItemManager.Instance.GetCollidedItem(_local_3);
            var _local_9:Vector2D = Vector2D.fromPoint(this._localPlayerCharacter.Position).divide(CELL_SIZE);
            if (_local_8 != null)
            {
                if (this._localPlayerCharacter.LocalCharacterInfo.ItemsCount >= ItemData.MAX_INVENTORY)
                {
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.INVENTORY_FULL_TITLE, ClientApplication.Localization.STORE_RESULTS[3], null, null, true, new AttachIcon("AchtungIcon")));
                }
                else
                {
                    if (_local_2 == null)
                    {
                        _local_16 = Vector2D.distanceSquared(_local_9, Vector2D.fromPoint(_local_8.InternalPosition));
                        if (_local_16 > 4)
                        {
                            this.AwayMapItemId = _local_8.ItemId;
                        }
                        else
                        {
                            this.AwayMapItemId = -1;
                            ClientApplication.Instance.LocalGameClient.SendTake(_local_8.ItemId);
                        };
                    }
                    else
                    {
                        this.AwayMapItemId = _local_8.ItemId;
                    };
                };
            };
            var _local_10:int = int(int(((RenderSystem.Instance.MainCamera.TopLeftPoint.x + _arg_1.stageX) / CELL_SIZE)));
            var _local_11:int = int(int((((RenderSystem.Instance.MainCamera.MaxHeight - _arg_1.stageY) - RenderSystem.Instance.MainCamera.TopLeftPoint.y) / CELL_SIZE)));
            if (((!(_local_2 == null)) || (!(_local_8 == null))))
            {
                _local_17 = ((_local_2 == null) ? Vector2D.fromPoint(_local_8.Position).divide(CELL_SIZE) : Vector2D.fromPoint(_local_2.Position).divide(CELL_SIZE));
                _local_18 = Vector2D.distanceSquared(_local_9, _local_17);
                if (_local_18 < 4)
                {
                    _local_7 = false;
                    _local_19 = _local_9.subtract(_local_17);
                    if (_local_19.x > 0)
                    {
                        if (_local_19.y > 0)
                        {
                            this._localPlayerCharacter.LocalCharacterInfo.coordinates.dir = 7;
                        }
                        else
                        {
                            if (_local_19.y < 0)
                            {
                                this._localPlayerCharacter.LocalCharacterInfo.coordinates.dir = 5;
                            }
                            else
                            {
                                this._localPlayerCharacter.LocalCharacterInfo.coordinates.dir = 6;
                            };
                        };
                    }
                    else
                    {
                        if (_local_19.x < 0)
                        {
                            if (_local_19.y > 0)
                            {
                                this._localPlayerCharacter.LocalCharacterInfo.coordinates.dir = 1;
                            }
                            else
                            {
                                if (_local_19.y < 0)
                                {
                                    this._localPlayerCharacter.LocalCharacterInfo.coordinates.dir = 3;
                                }
                                else
                                {
                                    this._localPlayerCharacter.LocalCharacterInfo.coordinates.dir = 2;
                                };
                            };
                        }
                        else
                        {
                            if (_local_19.y < 0)
                            {
                                this._localPlayerCharacter.LocalCharacterInfo.coordinates.dir = 4;
                            }
                            else
                            {
                                if (_local_19.y > 0)
                                {
                                    this._localPlayerCharacter.LocalCharacterInfo.coordinates.dir = 0;
                                };
                            };
                        };
                    };
                }
                else
                {
                    if (((_local_17.x == _local_10) && (_local_17.y == _local_11)))
                    {
                        _local_10 = (_local_10 + 1);
                    };
                };
            };
            if (((_local_7) && (!(ClientApplication.Instance.IsCtrlPressed))))
            {
                if (!_local_4)
                {
                    if (_local_2)
                    {
                        _local_2.IsAutoAttacked = true;
                    }
                    else
                    {
                        if (this._lastSelectedCharacter)
                        {
                            this._lastSelectedCharacter.IsAutoAttacked = false;
                        };
                    };
                    if (this.MovePointerCollision == 0)
                    {
                        this._localPlayerCharacter.OnMovementInterrupted(false, false);
                        ClientApplication.Instance.LocalGameClient.MoveTo(_local_10, _local_11);
                        SkillUnitManager.Instance.AddSkillUnit(-1, 134, 20, _local_10, _local_11);
                    }
                    else
                    {
                        SkillUnitManager.Instance.AddSkillUnit(-1, 134, 21, _local_10, _local_11);
                    };
                };
                if (this.LocalPlayerCharacter.isCasting)
                {
                    if (this.LocalPlayerCharacter.LocalCharacterInfo.jobId != 4032)
                    {
                        ClientApplication.Instance.LocalGameClient.SendSkillCastCancel();
                    }
                    else
                    {
                        _local_20 = this.LocalPlayerCharacter.LocalCharacterInfo.Skills[278];
                        if (((_local_20 == null) || (_local_20.Lv == 0)))
                        {
                            ClientApplication.Instance.LocalGameClient.SendSkillCastCancel();
                        };
                    };
                };
            };
        }

        private function OnReceivedActorAction(_arg_1:ActorActionEvent):void
        {
            var _local_2:Character;
            var _local_3:Character;
            var _local_4:int;
            var _local_5:int;
            var _local_6:uint;
            var _local_7:Boolean;
            var _local_8:String;
            var _local_9:Point;
            var _local_10:Number;
            var _local_11:Number;
            var _local_12:uint;
            var _local_13:int;
            var _local_14:int;
            var _local_15:Point;
            var _local_16:int;
            var _local_17:SkillsResourceLibrary;
            var _local_18:Boolean;
            switch (_arg_1.actionType)
            {
                case 0:
                case 10:
                case 8:
                    _local_2 = this._characterActorData[_arg_1.targetID];
                    _local_3 = this._characterActorData[_arg_1.sourceID];
                    if (((_local_3 == null) && (_local_2 == null)))
                    {
                        return;
                    };
                    _local_4 = int(_arg_1.targetID);
                    _local_5 = int(_arg_1.sourceID);
                    if (_local_4 < 0)
                    {
                        _local_4 = (_local_4 * -1);
                    };
                    if (_local_5 < 0)
                    {
                        _local_5 = (_local_5 * -1);
                    };
                    _local_6 = this._localPlayerCharacter.CharacterId;
                    _local_7 = (((!(this.PvPMode == 3)) || (this._isShowGWDamage)) && ((_local_6 == _local_4) || (_local_6 == _local_5)));
                    _local_8 = "";
                    _local_9 = null;
                    _local_10 = 0;
                    _local_11 = 0;
                    if (_local_2 != null)
                    {
                        _local_11 = 100;
                        _local_10 = 50;
                        if (_local_3 != null)
                        {
                            if (_local_2.Position.x < _local_3.Position.x)
                            {
                                _local_10 = -50;
                            };
                        };
                        _local_9 = new Point(_local_2.Position.x, (_local_2.Position.y + 50));
                        if (((_arg_1.targetDelay > 0) && (_arg_1.damage > 0)))
                        {
                        };
                    }
                    else
                    {
                        _local_10 = 0;
                        _local_11 = 100;
                        _local_9 = new Point(_local_3.Position.x, (_local_3.Position.y + 50));
                    };
                    _local_12 = 0;
                    _local_13 = int(Math.floor((Math.random() * 20)));
                    _local_14 = int(Math.floor((Math.random() * 20)));
                    _local_15 = new Point(((_local_9.x - 50) + _local_13), ((_local_9.y + _local_11) + _local_14));
                    if (_arg_1.damage == 0)
                    {
                        _local_8 = ClientApplication.Localization.BATTLE_MISS;
                        _local_12 = 0x909090;
                        if (_local_3 == this._localPlayerCharacter)
                        {
                            _local_12 = 15679291;
                        };
                    }
                    else
                    {
                        _local_18 = (_arg_1.actionType == 10);
                        _local_8 = _arg_1.damage.toString();
                        if (_arg_1.damage2 > 0)
                        {
                            _local_8 = (_arg_1.damage + _arg_1.damage2).toString();
                        };
                        if (_arg_1.div == 2)
                        {
                            _local_8 = (_local_8 + "!");
                        };
                        if (_local_18)
                        {
                            _local_8 = (_local_8 + "!!");
                        };
                        if (((_local_2 == this._localPlayerCharacter) || (this._localPlayerCharacter.CharacterId == _local_4)))
                        {
                            _local_12 = 15679291;
                        };
                    };
                    this.CreateArrowEffect(_local_3, _local_2, _arg_1.skillId);
                    if (((!(_arg_1.damage == -1)) && (_local_7)))
                    {
                        BattleLogManager.Instance.AddBattleMessage(_local_8, 1, _local_9, _local_15, _local_12);
                    };
                    _local_16 = SkillsResourceLibrary.TARGET_CHARACTER;
                    _local_17 = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
                    if (((_local_17) && (_local_3)))
                    {
                        _local_16 = _local_17.GetSkillTargetType(_local_3.LocalCharacterFraction, _local_3.LocalCharacterInfo.jobId, _arg_1.skillId);
                    };
                    if (_local_16 != SkillsResourceLibrary.TARGET_COORDINATES)
                    {
                        this.StartDirectionAttack(_local_3, _local_2);
                        if (this.IsEnableAutoAttack)
                        {
                            if ((((_local_2 == this._localPlayerCharacter) && (this._lastSelectedCharacter == null)) && (!(_local_3 == null))))
                            {
                                if (((this._localPlayerCharacter.CurrentState == CharacterState.Idle) && (!(_local_3 == null))))
                                {
                                    ClientApplication.Instance.LocalGameClient.SendAttack(_local_3.CharacterId, 7);
                                };
                                this.SelectCharacter(_local_3);
                            };
                        };
                    };
                    return;
            };
        }

        private function CreateArrowEffect(_arg_1:Character, _arg_2:Character, _arg_3:int):void
        {
            var _local_4:Number;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            if (((!(_arg_1 == null)) && (!(_arg_2 == null))))
            {
                if (((_arg_1.LocalCharacterInfo.viewWeaponId == 11) || (_arg_3 > 0)))
                {
                    this._startArrowPosition.x = _arg_1.Position.x;
                    this._startArrowPosition.y = (_arg_1.Position.y + 60);
                    this._endArrowPosition.x = (_arg_2.Position.x - 20);
                    this._endArrowPosition.y = (_arg_2.Position.y + 60);
                    if (_arg_3 <= 0)
                    {
                        ArrowManager.Instance.AddArrowObject(this._startArrowPosition, this._endArrowPosition);
                    }
                    else
                    {
                        _local_4 = -1;
                        _local_5 = -1;
                        switch (_arg_3)
                        {
                            case 14:
                            case 19:
                            case 20:
                            case 46:
                            case 86:
                            case 382:
                                _local_4 = 0.2;
                                break;
                            case 59:
                            case 251:
                            case 490:
                            case 555:
                            case 1004:
                                _local_4 = 0.25;
                                break;
                            case 1009:
                                _local_5 = 5;
                                break;
                            case 90:
                                _local_5 = 6;
                                break;
                        };
                        if (_local_5 > 0)
                        {
                            _local_6 = int(((this._endArrowPosition.x / CharacterStorage.CELL_SIZE) + 1));
                            _local_7 = int(((this._endArrowPosition.y / CharacterStorage.CELL_SIZE) - 1));
                            SkillUnitManager.Instance.AddSkillUnit(-1, 134, _local_5, _local_6, _local_7);
                        };
                        if (_local_4 > 0)
                        {
                            ArrowManager.Instance.AddArrowObject(this._startArrowPosition, this._endArrowPosition, _local_4, _arg_3);
                        };
                    };
                };
            };
        }

        private function StartDirectionAttack(_arg_1:Character, _arg_2:Character):void
        {
            var _local_3:Vector2D;
            var _local_4:Vector2D;
            var _local_5:Vector2D;
            if (((!(_arg_1 == null)) && (!(_arg_2 == null))))
            {
                _local_3 = Vector2D.fromPoint(_arg_2.Position).divide(CELL_SIZE);
                _local_4 = Vector2D.fromPoint(_arg_1.Position).divide(CELL_SIZE);
                _local_5 = _local_4.subtract(_local_3);
                if (_local_5.x > 0)
                {
                    if (_local_5.y < 0)
                    {
                        _arg_1.LocalCharacterInfo.coordinates.dir = 7;
                    }
                    else
                    {
                        if (_local_5.y > 0)
                        {
                            _arg_1.LocalCharacterInfo.coordinates.dir = 5;
                        }
                        else
                        {
                            _arg_1.LocalCharacterInfo.coordinates.dir = 6;
                        };
                    };
                }
                else
                {
                    if (_local_5.x < 0)
                    {
                        if (_local_5.y < 0)
                        {
                            _arg_1.LocalCharacterInfo.coordinates.dir = 1;
                        }
                        else
                        {
                            if (_local_5.y > 0)
                            {
                                _arg_1.LocalCharacterInfo.coordinates.dir = 3;
                            }
                            else
                            {
                                _arg_1.LocalCharacterInfo.coordinates.dir = 2;
                            };
                        };
                    }
                    else
                    {
                        if (_local_5.y > 0)
                        {
                            _arg_1.LocalCharacterInfo.coordinates.dir = 4;
                        }
                        else
                        {
                            if (_local_5.y < 0)
                            {
                                _arg_1.LocalCharacterInfo.coordinates.dir = 0;
                            };
                        };
                    };
                };
                _arg_1.OnAttackStart();
            };
        }

        public function OnKeyDown(_arg_1:KeyboardEvent):void
        {
            if (this._localPlayerCharacter != null)
            {
                this._localPlayerCharacter.OnAttackStart();
            };
        }

        public function Update(_arg_1:Number):void
        {
            var _local_2:Character;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:CharacterAnimation;
            var _local_6:SelectedActorInfoNew;
            var _local_7:Number;
            for each (_local_2 in this._characterActorData)
            {
                if (_local_2 != null)
                {
                    if (_local_2.IsValid)
                    {
                        if (((((_local_2.LocalCharacterInfo) && (_local_2.LocalCharacterInfo.jobId > 1000)) && (_local_2.LocalCharacterInfo.jobId < 4000)) && (!(_local_2.LocalCharacterInfo.jobId == _local_2.LocalCharacterInfo.DisguiseId))))
                        {
                            _local_2.LocalCharacterInfo.DisguiseId = _local_2.LocalCharacterInfo.jobId;
                            _local_3 = _local_2.CharacterAnimationIndex;
                            _local_4 = this.GetCharacterAnimationIndex(_local_2.LocalCharacterInfo);
                            if (_local_3 != _local_4)
                            {
                                _local_5 = this.GetCharacterAnimation(_local_4).Clone();
                                _local_2.ChangeCharacterInfo(_local_5, _local_2.LocalCharacterInfo, _local_4);
                            };
                        };
                        _local_2.Update(_arg_1);
                        if (((_local_2.Selected) && (_local_2.LocalCharacterInfo.maxHp > 0)))
                        {
                            _local_6 = ClientApplication.Instance.TopHUD.GetSelectedActorInfo();
                            _local_7 = (Number(_local_2.LocalCharacterInfo.hp) / Number(_local_2.LocalCharacterInfo.maxHp));
                            _local_6._progress._progressMask.scaleX = _local_7;
                            if (_local_7 == 0)
                            {
                                _local_6.visible = false;
                            };
                        };
                    };
                };
            };
            if (((!(this._localPlayerCharacter == null)) && (!(this._localPlayerCharacter.Position == null))))
            {
                RenderSystem.Instance.MainCamera.Position = new Point(this._localPlayerCharacter.Position.x, this._localPlayerCharacter.Position.y);
                this.UpdateCursor();
            };
        }

        public function get IsEnableAutoAttack():Boolean
        {
            return (this._isEnableAutoAttack);
        }

        public function set IsEnableAutoAttack(_arg_1:Boolean):void
        {
            this._isEnableAutoAttack = _arg_1;
        }

        public function get IsEnableObjectsGlow():Boolean
        {
            return (this._isEnableObjectsGlow);
        }

        public function set IsEnableObjectsGlow(_arg_1:Boolean):void
        {
            this._isEnableObjectsGlow = _arg_1;
        }

        public function get IsEnableBlinking():Boolean
        {
            return (this._isEnableBlinking);
        }

        public function set IsEnableBlinking(_arg_1:Boolean):void
        {
            this._isEnableBlinking = _arg_1;
        }

        public function get IsShowGWDamage():Boolean
        {
            return (this._isShowGWDamage);
        }

        public function set IsShowGWDamage(_arg_1:Boolean):void
        {
            this._isShowGWDamage = _arg_1;
        }

        public function get IsShowGuildNotice():Boolean
        {
            return (this._isShowGuildNotice);
        }

        public function set IsShowGuildNotice(_arg_1:Boolean):void
        {
            this._isShowGuildNotice = _arg_1;
        }

        public function get IsEnableSkillAnimation():Boolean
        {
            return (this._isEnableSkillAnimation);
        }

        public function set IsEnableSkillAnimation(_arg_1:Boolean):void
        {
            this._isEnableSkillAnimation = _arg_1;
        }

        public function GetCharacterData(_arg_1:int):Character
        {
            return (this._characterActorData[_arg_1]);
        }

        public function get AwayMapItemId():int
        {
            return (this._awayMapItemId);
        }

        public function set AwayMapItemId(_arg_1:int):void
        {
            this._awayMapItemId = _arg_1;
        }

        private function CheckIntravision(_arg_1:Character, _arg_2:Character):Boolean
        {
            var _local_3:Boolean;
            if (((_arg_1) && (_arg_1.LocalCharacterInfo.intravision)))
            {
                switch (_arg_2.LocalCharacterInfo.viewHead)
                {
                    case 23416:
                    case 21613:
                    case 23279:
                    case 14818:
                    case 14819:
                    case 14822:
                    case 14823:
                    case 21617:
                    case 14824:
                    case 14827:
                    case 14829:
                    case 14830:
                    case 21689:
                        _local_3 = true;
                        break;
                };
            }
            else
            {
                _local_3 = true;
            };
            return (_local_3);
        }

        public function UpdateNpcQuestInfo():void
        {
            var _local_1:Character;
            for each (_local_1 in this._characterActorData)
            {
                if (_local_1)
                {
                    _local_1.UpdateNpcQuestInfo();
                };
            };
        }

        public function get IsEnableChatHiding():Boolean
        {
            return (this._isEnableChatHiding);
        }

        public function set IsEnableChatHiding(_arg_1:Boolean):void
        {
            if (_arg_1 != this._isEnableChatHiding)
            {
                this._isEnableChatHiding = _arg_1;
                if (_arg_1)
                {
                    ClientApplication.Instance.LeftChatBarInstance.StartAutoHideChat();
                }
                else
                {
                    ClientApplication.Instance.LeftChatBarInstance.StopAutoHideChat();
                };
            };
        }


    }
}//package hbm.Game.Character

