


//hbm.Game.Character.Character

package hbm.Game.Character
{
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.Renderer.CharacterAnimation;
    import flash.utils.Timer;
    import flash.geom.Point;
    import flash.text.TextField;
    import flash.geom.Matrix;
    import flash.display.BitmapData;
    import flash.geom.ColorTransform;
    import hbm.Engine.Renderer.RenderSystem;
    import flash.text.TextFieldAutoSize;
    import flash.text.AntiAliasType;
    import flash.text.GridFitType;
    import hbm.Game.Utility.HtmlText;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.display.Bitmap;
    import flash.utils.Dictionary;
    import hbm.Engine.Renderer.Camera;
    import hbm.Game.Renderer.CharacterAnimationState;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import hbm.Engine.Collision.MapCollisionManager;
    import hbm.Game.Renderer.MapItemObject;
    import hbm.Engine.Utility.Vector2D;
    import hbm.Game.Renderer.MapItemManager;
    import hbm.Application.ClientApplication;

    public class Character 
    {

        public static const CHARACTER_UNKNOWN:int = 0;
        public static const CHARACTER_MONSTER:int = 1;
        public static const CHARACTER_NPC:int = 2;
        public static const CHARACTER_PLAYER:int = 3;

        private var _currentCharacterState:int;
        private var _characterInfo:CharacterInfo;
        private var _animation:CharacterAnimation;
        private var _currentCharacterAnimationIndex:int;
        private var _deadTimer:Number;
        private var _currentNodeIndex:int;
        private var _pathFinderData:Array;
        private var _currentRunSpeed:Number;
        private var _currentPathLength:Number;
        private var _timeOutTimer:Timer;
        private var _isBoss:Boolean = false;
        private var _isAgressive:Boolean = false;
        private var _questStatus:int;
        private var _lastMovementIdle:String = "Idle/Down";
        private var _lastCharacterPosition:Point = new Point(0, 0);
        private var _textName:TextField;
        private var _shopName:TextField;
        private var _isLocalPlayer:Boolean;
        private var _castInfo:CastGauge;
        private var _healthInfo:HealthGauge;
        private var _monsterHealthInfo:MobHealthGauge;
        private var _stunEffect:StunEffect;
        private var _effectFrameTimer:Number;
        private var _levelUpEffect:LevelUpFx;
        private var _matrix:Matrix;
        private var _topLeftDrawPosition:Point;
        private var _whoopBitmapData:BitmapData;
        private var _questionBitmapData:BitmapData;
        private var _maxCastTime:Number;
        private var _existCastTime:Number;
        private var _wasCashBeforeAttack:Boolean = false;
        private var _lastShopNameText:String = "";
        private var _lastActorNameText:String = "";
        private var _lastGuildEmblemId:int = -1;
        private var _currentNamePosition:Point;
        private var _nameBitmapData:BitmapData;
        private var _shopBitmapData:BitmapData;
        private var _guildEmblemBitmapData:BitmapData;
        private var _isShopNameChanged:Boolean = true;
        private var _isActorNameChanged:Boolean = true;
        private var _isGuildEmblemChanged:Boolean = true;
        private var _beforeDeadYPosition:int;
        private var _characterType:int;
        private var _currentColorTransform:ColorTransform;
        private var _isAutoAttacked:Boolean = false;

        public function Character(_arg_1:CharacterAnimation, _arg_2:CharacterInfo, _arg_3:uint, _arg_4:Boolean=false)
        {
            this._deadTimer = 0;
            this._maxCastTime = 0;
            this._existCastTime = 0;
            this._effectFrameTimer = 0;
            this._animation = _arg_1;
            this._characterInfo = _arg_2;
            this._isLocalPlayer = _arg_4;
            this._currentCharacterAnimationIndex = _arg_3;
            this._currentRunSpeed = 5;
            this._animation.IsLocalOrGuildPlayer = _arg_4;
            this._animation.CharacterLevel = _arg_2.baseLevel;
            this._characterType = CharacterStorage.Instance.GetCharacterType(_arg_3);
            this._animation.CharacterType = this._characterType;
            this._animation.CharacterGender = this._characterInfo.sex;
            this._animation.Invisible = this._characterInfo.invisible;
            this._animation.Hided = this._characterInfo.hided;
            this._animation.CharacterHairColor = this._characterInfo.hairColor;
            this._matrix = new Matrix();
            this._castInfo = new CastGauge();
            this._healthInfo = new HealthGauge();
            this._monsterHealthInfo = new MobHealthGauge();
            this._topLeftDrawPosition = new Point();
            this._currentNamePosition = new Point();
            this._currentColorTransform = new ColorTransform();
            this._stunEffect = new StunEffect();
            this._stunEffect.stop();
            this._stunEffect.visible = false;
            this._stunEffect.enabled = false;
            if (_arg_2.characterId >= 10)
            {
                RenderSystem.Instance.AddRenderObject(this._animation);
            };
            this._currentCharacterState = CharacterState.Idle;
            if (((this._characterType == CHARACTER_NPC) || (this._characterType == CHARACTER_MONSTER)))
            {
                this._characterInfo.coordinates.dir = 4;
            };
            this.SetIdleOrientation();
            this._textName = new TextField();
            this._textName.x = 511;
            this._textName.y = 150;
            this._textName.textColor = 0xCCCCCC;
            this.UpdateCharacterName(false, true);
            this._textName.autoSize = TextFieldAutoSize.LEFT;
            this._textName.antiAliasType = AntiAliasType.ADVANCED;
            this._textName.gridFitType = GridFitType.PIXEL;
            this._textName.sharpness = -400;
            this._textName.selectable = false;
            this._textName.filters = [HtmlText.glow];
            this._shopName = new TextField();
            this._shopName.x = 511;
            this._shopName.y = 150;
            this._shopName.visible = false;
            this._shopName.textColor = 6697881;
            this._shopName.autoSize = TextFieldAutoSize.LEFT;
            this._shopName.antiAliasType = AntiAliasType.ADVANCED;
            this._shopName.gridFitType = GridFitType.PIXEL;
            this._shopName.sharpness = -400;
            this._shopName.selectable = false;
            this._shopName.backgroundColor = 0xCCCCCC;
            this._shopName.filters = [HtmlText.glow];
            this.UpdateMonsterInfo();
            this.UpdateNpcQuestInfo();
        }

        public static function GetPlayerRace(_arg_1:int, _arg_2:int):int
        {
            var _local_3:uint = GetFraction(_arg_1, _arg_2);
            var _local_4:Boolean = IsBabyClass(_arg_1);
            if (_local_3 == CharacterInfo.FRACTION_LIGHT)
            {
                return ((_local_4) ? CharacterInfo.RACE_TURON : CharacterInfo.RACE_HUMAN);
            };
            return ((_local_4) ? CharacterInfo.RACE_ORC : CharacterInfo.RACE_UNDEAD);
        }

        public static function GetFraction(_arg_1:int, _arg_2:int):int
        {
            var _local_3:Boolean = IsBabyClass(_arg_1);
            if ((((_arg_2 == 0) && (_local_3)) || ((_arg_2 > 0) && (!(_local_3)))))
            {
                return (CharacterInfo.FRACTION_DARK);
            };
            return (CharacterInfo.FRACTION_LIGHT);
        }

        public static function IsBabyClass(_arg_1:int):Boolean
        {
            switch (_arg_1)
            {
                case 4024:
                case 4032:
                case 4037:
                    return (true);
                default:
                    return (false);
            };
        }

        public static function IsAdvancedClass(_arg_1:int):Boolean
        {
            switch (_arg_1)
            {
                case 4008:
                case 4009:
                case 4010:
                case 4011:
                case 4012:
                case 4015:
                case 4018:
                    return (true);
                default:
                    return (false);
            };
        }


        public function GetNamePos():Point
        {
            return (this._currentNamePosition);
        }

        private function GetIdleName():String
        {
            var _local_1:* = "Idle";
            if (((this._characterInfo.clothesColor == 0) && ((this._characterInfo.jobId == 4037) || (this._characterInfo.jobId == 4024))))
            {
                if (this._characterInfo)
                {
                    if (this._characterInfo.viewWeapon == 0)
                    {
                        _local_1 = (_local_1 + "0");
                    };
                };
            };
            return (_local_1);
        }

        private function GetRunName():String
        {
            var _local_1:* = "Run";
            if (((this._characterInfo.clothesColor == 0) && ((this._characterInfo.jobId == 4037) || (this._characterInfo.jobId == 4024))))
            {
                if (this._characterInfo)
                {
                    if (this._characterInfo.viewWeapon == 0)
                    {
                        _local_1 = (_local_1 + "0");
                    };
                };
            };
            return (_local_1);
        }

        private function UpdateActorNameBitmap():void
        {
            if (((this._lastActorNameText == this._textName.htmlText) && (!(this._nameBitmapData == null))))
            {
                this._isActorNameChanged = false;
                return;
            };
            if (this._nameBitmapData)
            {
                this._nameBitmapData.dispose();
            };
            this._nameBitmapData = new BitmapData(this._textName.width, this._textName.height, true, 0);
            this._nameBitmapData.draw(this._textName);
            this._isActorNameChanged = false;
            this._lastActorNameText = this._textName.htmlText;
        }

        private function UpdateShopNameBitmap():void
        {
            if (((this._lastShopNameText == this._shopName.htmlText) && (!(this._shopBitmapData == null))))
            {
                this._isShopNameChanged = false;
                return;
            };
            if (this._shopBitmapData)
            {
                this._shopBitmapData.dispose();
            };
            this._shopBitmapData = new BitmapData(this._shopName.width, this._shopName.height, true, 0);
            this._shopBitmapData.draw(this._shopName);
            this._isShopNameChanged = false;
            this._lastShopNameText = this._shopName.htmlText;
        }

        private function UpdateGuildEmblemBitmap():void
        {
            if (((this._characterInfo.guildName == null) || ((this._lastGuildEmblemId == this._characterInfo.guildEmblem) && (!(this._guildEmblemBitmapData == null)))))
            {
                this._isGuildEmblemChanged = false;
                if (((this._characterInfo.guildName == null) && (this._guildEmblemBitmapData)))
                {
                    this._guildEmblemBitmapData.dispose();
                    this._guildEmblemBitmapData = null;
                };
                return;
            };
            var _local_1:Bitmap = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetBitmap("guild", this._characterInfo.guildEmblem.toString());
            if (_local_1 != null)
            {
                if (this._guildEmblemBitmapData)
                {
                    this._guildEmblemBitmapData.dispose();
                };
                this._guildEmblemBitmapData = _local_1.bitmapData;
                this._isGuildEmblemChanged = false;
                this._lastGuildEmblemId = this._characterInfo.guildEmblem;
            };
        }

        public function StartLevelUpFx():void
        {
            if (!this._levelUpEffect)
            {
                this._levelUpEffect = new LevelUpFx();
                this._levelUpEffect.visible = true;
                this._levelUpEffect.enabled = true;
            };
            this._levelUpEffect.gotoAndPlay(0);
        }

        public function set NeedDraw(_arg_1:Boolean):void
        {
            if (this._animation)
            {
                this._animation.NeedDraw = _arg_1;
            };
        }

        public function set DrawShadow(_arg_1:Boolean):void
        {
            if (this._animation)
            {
                this._animation.DrawShadow = _arg_1;
            };
        }

        public function set CharacterLevel(_arg_1:int):void
        {
            if (this._animation)
            {
                this._animation.CharacterLevel = _arg_1;
            };
        }

        public function SetOption(_arg_1:int, _arg_2:Boolean):void
        {
            if (this._animation)
            {
                this._animation.SetOption(_arg_1, _arg_2);
            };
        }

        public function GetOption(_arg_1:int):Boolean
        {
            if (!this._animation)
            {
                return (false);
            };
            return (this._animation.GetOption(_arg_1));
        }

        public function SetOption2(_arg_1:int, _arg_2:Boolean):void
        {
            if (this._animation)
            {
                this._animation.SetOption2(_arg_1, _arg_2);
            };
        }

        public function GetOption2(_arg_1:int):Boolean
        {
            if (!this._animation)
            {
                return (false);
            };
            return (this._animation.GetOption2(_arg_1));
        }

        public function StartStun():void
        {
            this._stunEffect.visible = true;
            this._stunEffect.enabled = true;
            this._stunEffect.gotoAndPlay(0);
        }

        public function EndStun():void
        {
            this._stunEffect.stop();
            this._stunEffect.enabled = false;
            this._stunEffect.visible = false;
        }

        public function StartCast(_arg_1:Number):void
        {
            this._maxCastTime = _arg_1;
            this._existCastTime = _arg_1;
            this._wasCashBeforeAttack = true;
        }

        public function StopCast():void
        {
            this._existCastTime = 0;
        }

        public function get isCasting():Boolean
        {
            return (this._existCastTime > 0);
        }

        public function get Selected():Boolean
        {
            if (this._animation != null)
            {
                return (this._animation.Selected);
            };
            return (false);
        }

        public function set Selected(_arg_1:Boolean):void
        {
            if (this._animation != null)
            {
                this._animation.Selected = _arg_1;
            };
        }

        public function UpdateNpcQuestInfo():void
        {
            var _local_1:String;
            this._questStatus = 0;
            if (this._characterType != CHARACTER_NPC)
            {
                return;
            };
            if (!this._isLocalPlayer)
            {
                _local_1 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetNpcId(this._characterInfo.name);
                this._questStatus = this.GetQuestStatus(_local_1);
            };
        }

        public function GetQuestStatus(_arg_1:String):int
        {
            var _local_3:AdditionalDataResourceLibrary;
            var _local_5:Character;
            var _local_9:*;
            var _local_10:int;
            var _local_11:Object;
            var _local_12:Array;
            var _local_13:String;
            var _local_14:Array;
            var _local_15:Array;
            var _local_16:*;
            var _local_17:*;
            var _local_2:int;
            _local_3 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_4:Boolean = _local_3.IsQuestNpc(_arg_1);
            if (!_local_4)
            {
                return (0);
            };
            _local_5 = CharacterStorage.Instance.LocalPlayerCharacter;
            var _local_6:Dictionary = _local_5._characterInfo.QuestStates;
            var _local_7:Boolean;
            var _local_8:Array = new Array();
            if (_local_6 != null)
            {
                for (_local_9 in _local_6)
                {
                    _local_10 = _local_6[_local_9];
                    if (_local_10 >= 100)
                    {
                        _local_8.push(_local_9);
                    }
                    else
                    {
                        _local_11 = _local_3.GetQuestsData(_local_9);
                        if (_local_11 != null)
                        {
                            _local_12 = _local_11.NpcId;
                            _local_13 = _local_12[_local_10];
                            if (_local_13 == _arg_1)
                            {
                                _local_2 = 2;
                                _local_7 = true;
                                break;
                            };
                        };
                    };
                };
            };
            if (!_local_7)
            {
                _local_14 = _local_3.GetQuestsIdArray(_arg_1);
                _local_15 = new Array();
                if (((!(_local_14 == null)) && (_local_14.length > 0)))
                {
                    for each (_local_16 in _local_14)
                    {
                        _local_7 = false;
                        for each (_local_17 in _local_8)
                        {
                            if (_local_16 == _local_17)
                            {
                                _local_7 = true;
                                break;
                            };
                        };
                        if (!_local_7)
                        {
                            _local_15.push(_local_16);
                        };
                    };
                    if (_local_15.length > 0)
                    {
                        _local_2 = 1;
                    };
                };
            };
            return (_local_2);
        }

        private function UpdateMonsterInfo():void
        {
            var _local_2:Boolean;
            var _local_4:int;
            this._isBoss = false;
            this._isAgressive = false;
            if (this._characterType != CHARACTER_MONSTER)
            {
                return;
            };
            var _local_1:AdditionalDataResourceLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            _local_2 = ((int(this._characterInfo.characterId) < 0) || (this._characterInfo.DisguiseId > 1000));
            var _local_3:Object = ((_local_2) ? _local_1.GetMonstersDataById(this._characterInfo.DisguiseId) : _local_1.GetMonstersData(this._characterInfo.name));
            if (_local_3 != null)
            {
                _local_4 = _local_3["Mode"];
                if ((_local_4 & 0x04) > 0)
                {
                    this._isAgressive = true;
                };
                if ((_local_4 & 0x20) > 0)
                {
                    this._isBoss = true;
                };
            };
        }

        public function get IsShopMode():Boolean
        {
            return (this._shopName.visible);
        }

        public function UpdateShopName():void
        {
            var _local_1:String;
            if (this._characterInfo != null)
            {
                if (this._characterInfo.VenderName == null)
                {
                    this._shopName.visible = false;
                }
                else
                {
                    this._shopName.visible = true;
                    _local_1 = this._characterInfo.VenderName;
                    if (_local_1.length > 22)
                    {
                        _local_1 = (_local_1.substr(0, 20) + "...");
                    };
                    this._shopName.htmlText = HtmlText.update((("&lt;" + _local_1) + "&gt;"), true);
                };
            };
        }

        public function UpdateCharacterName(_arg_1:Boolean=true, _arg_2:Boolean=false):void
        {
            var _local_3:AdditionalDataResourceLibrary;
            var _local_4:Boolean;
            var _local_5:Object;
            var _local_6:int;
            var _local_7:int;
            if (this._characterInfo != null)
            {
                if (!_arg_2)
                {
                    this._characterInfo.internalName = this._characterInfo.name;
                };
                if (((this._characterType == Character.CHARACTER_PLAYER) && (!(this._characterInfo.guildName == null))))
                {
                    if ((((!(this._isLocalPlayer)) && (!(CharacterStorage.Instance.LocalPlayerCharacter == null))) && (!(CharacterStorage.Instance.LocalPlayerCharacter.LocalCharacterInfo == null))))
                    {
                        if (((!(this._characterInfo.guildName == null)) && (this._characterInfo.guildName == CharacterStorage.Instance.LocalPlayerCharacter.LocalCharacterInfo.guildName)))
                        {
                            this._animation.IsLocalOrGuildPlayer = true;
                        };
                    };
                    this._textName.htmlText = HtmlText.update((((this._characterInfo.internalName + " [") + this._characterInfo.guildName) + "]"), true);
                }
                else
                {
                    if (this._characterType == Character.CHARACTER_MONSTER)
                    {
                        _local_3 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
                        _local_4 = ((int(this._characterInfo.characterId) < 0) || (this._characterInfo.DisguiseId > 1000));
                        _local_5 = ((_local_4) ? _local_3.GetMonstersDataById(this._characterInfo.DisguiseId) : _local_3.GetMonstersData(this._characterInfo.name));
                        if (_local_5 != null)
                        {
                            _local_6 = _local_5["LV"];
                            _local_7 = _local_5["Sprite"];
                            if (((((_local_7 == 1014) || (_local_7 == 1012)) || (_local_7 == 1027)) || ((_local_7 >= 1900) && (_local_7 < 2000))))
                            {
                                this._textName.htmlText = HtmlText.update(this._characterInfo.internalName, true);
                            }
                            else
                            {
                                this._textName.htmlText = HtmlText.update((((this._characterInfo.internalName + " [") + ((this._characterInfo.guildName != null) ? this._characterInfo.guildName : _local_6)) + "]"), true);
                            };
                        }
                        else
                        {
                            this._textName.htmlText = HtmlText.update(this._characterInfo.internalName, true);
                        };
                    }
                    else
                    {
                        this._textName.htmlText = HtmlText.update(this._characterInfo.internalName, true);
                    };
                };
            };
            if (_arg_1)
            {
                this.UpdateShopName();
            };
            this._isShopNameChanged = true;
            this._isActorNameChanged = true;
            this._isGuildEmblemChanged = true;
        }

        public function get CharacterType():int
        {
            return (this._characterType);
        }

        public function get CharacterAnimationIndex():uint
        {
            return (this._currentCharacterAnimationIndex);
        }

        public function get IsSelecting():Boolean
        {
            return ((this._characterInfo.allowSelection) && ((!(this._animation.IsHided)) || (this._animation.IsLocalOrGuildPlayer)));
        }

        public function ChangeCharacterInfo(_arg_1:CharacterAnimation, _arg_2:CharacterInfo, _arg_3:uint):void
        {
            var _local_4:int = this._currentCharacterState;
            if (_arg_1 != this._animation)
            {
                if (this._animation != null)
                {
                    if (((this._currentCharacterState == CharacterState.Attack) || (this._currentCharacterState == CharacterState.Attack2)))
                    {
                        this.OnAttackEnd(null);
                    };
                    if (((!(this._animation.Position.x == 0)) || (!(this._animation.Position.y == 0))))
                    {
                        _arg_1.Position.x = this._animation.Position.x;
                        _arg_1.Position.y = this._animation.Position.y;
                    };
                    RenderSystem.Instance.RemoveRenderObject(this._animation);
                    this._animation.Release();
                };
                this._animation = _arg_1;
                RenderSystem.Instance.AddRenderObject(this._animation);
            };
            this._characterInfo = _arg_2;
            this._currentCharacterAnimationIndex = _arg_3;
            this._characterType = CharacterStorage.Instance.GetCharacterType(_arg_3);
            this._animation.CharacterType = this._characterType;
            this._animation.CharacterGender = this._characterInfo.sex;
            this._animation.Invisible = this._characterInfo.invisible;
            this._animation.Hided = this._characterInfo.hided;
            this._animation.IsLocalOrGuildPlayer = ((this._animation.IsLocalOrGuildPlayer) || (this._isLocalPlayer));
            this._animation.CharacterLevel = this._characterInfo.baseLevel;
            this._animation.CharacterHairColor = this._characterInfo.hairColor;
            if (this._characterType == CHARACTER_PLAYER)
            {
                this._characterInfo.internalName = this._characterInfo.name;
            };
            this._textName = new TextField();
            this._textName.x = 511;
            this._textName.y = 150;
            this._textName.textColor = 0xCCCCCC;
            this._textName.htmlText = HtmlText.update(this._characterInfo.internalName, true);
            this._textName.autoSize = TextFieldAutoSize.LEFT;
            this._textName.antiAliasType = AntiAliasType.ADVANCED;
            this._textName.gridFitType = GridFitType.PIXEL;
            this._textName.sharpness = -400;
            this._textName.selectable = false;
            this._textName.filters = [HtmlText.glow];
            if (((this._characterType == CHARACTER_NPC) || (this._characterType == CHARACTER_MONSTER)))
            {
                this._characterInfo.coordinates.dir = 4;
            };
            this._lastMovementIdle = ((this.GetIdleName() + "/") + this.GetAnimationDirectionName());
            this._animation.SetCurrentAnimationState(this._lastMovementIdle);
            if (((_local_4 == CharacterState.Attack) || (_local_4 == CharacterState.Attack2)))
            {
                this.OnAttackStart();
            };
            this.UpdateMonsterInfo();
            this.UpdateNpcQuestInfo();
            this.UpdateCharacterName(false, true);
        }

        public function get LocalCharacterInfo():CharacterInfo
        {
            return (this._characterInfo);
        }

        public function get LocalCharacterFraction():int
        {
            return (GetFraction(this._characterInfo.jobId, this._characterInfo.clothesColor));
        }

        public function DrawFrame(_arg_1:BitmapData, _arg_2:String, _arg_3:int):void
        {
            if (this._animation != null)
            {
                this._animation.DrawFrame(_arg_1, _arg_2, _arg_3);
            };
        }

        public function DrawInfo(_arg_1:Camera, _arg_2:BitmapData):void
        {
            var _local_5:int;
            var _local_6:Character;
            var _local_7:Number;
            var _local_8:int;
            var _local_9:int;
            var _local_10:Bitmap;
            var _local_11:Bitmap;
            var _local_3:* = (!(((this._deadTimer >= 3) && (this._currentCharacterState == CharacterState.Dead)) && (this._characterType == CHARACTER_MONSTER)));
            if (this.Position == null)
            {
                return;
            };
            if (!_local_3)
            {
                return;
            };
            if (this._animation != null)
            {
                if ((((this._animation.IsHided) && (!(this._animation.IsLocalOrGuildPlayer))) && (!(this._isLocalPlayer))))
                {
                    _local_5 = int(this._characterInfo.characterId);
                    if (_local_5 > 0)
                    {
                        return;
                    };
                };
            };
            this._matrix.tx = ((this.Position.x - _arg_1.TopLeftPoint.x) - (this._textName.textWidth / 2));
            this._matrix.ty = (((_arg_1.MaxHeight - this.Position.y) - _arg_1.TopLeftPoint.y) + 10);
            this._textName.textColor = 4638965;
            var _local_4:Boolean = true;
            switch (this._characterType)
            {
                case CHARACTER_NPC:
                    this._textName.textColor = ((this._characterInfo.nameColor > 0) ? this._characterInfo.nameColor : 0x9900);
                    _local_4 = this._characterInfo.autoHideName;
                    break;
                case CHARACTER_PLAYER:
                    this._textName.textColor = 4638965;
                    _local_4 = false;
                    _local_6 = CharacterStorage.Instance.LocalPlayerCharacter;
                    if (((_local_6) && (!(_local_6 == this))))
                    {
                        if (((_local_6.LocalCharacterInfo) && (!(_local_6.LocalCharacterFraction == this.LocalCharacterFraction))))
                        {
                            this._textName.textColor = 15679291;
                        }
                        else
                        {
                            if (CharacterStorage.Instance.PvPMode >= 1)
                            {
                                if ((((_local_6.LocalCharacterInfo) && (_local_6.LocalCharacterInfo.guildName == null)) || (this.LocalCharacterInfo.guildName == null)))
                                {
                                    this._textName.textColor = 15679291;
                                }
                                else
                                {
                                    if (!this.LocalCharacterInfo.isAllie)
                                    {
                                        this._textName.textColor = 15679291;
                                    };
                                };
                            };
                        };
                    };
                    if (this._characterInfo.Support)
                    {
                        this._textName.textColor = 3407667;
                    };
                    break;
                case CHARACTER_MONSTER:
                    this._textName.textColor = ((this._characterInfo.nameColor > 0) ? this._characterInfo.nameColor : ((this._isBoss) ? 0xFF6600 : ((this._isAgressive) ? 15679291 : 0xCCCCCC)));
                    break;
            };
            if (this._characterInfo.needDraw)
            {
                if (((!(this._characterInfo.invisible)) && (this._characterInfo.showName)))
                {
                    if (this._isActorNameChanged)
                    {
                        this.UpdateActorNameBitmap();
                    };
                    if (((this._characterInfo.guildEmblem == 0) && (!(this._characterInfo.Guild == null))))
                    {
                        this._characterInfo.guildEmblem = this._characterInfo.Guild.Emblem;
                    };
                    this._currentNamePosition.x = this._matrix.tx;
                    this._currentNamePosition.y = this._matrix.ty;
                    if (this._characterInfo.guildEmblem != 0)
                    {
                        this._currentNamePosition.x = (this._currentNamePosition.x + 12);
                        if (((this._isGuildEmblemChanged) || (this._guildEmblemBitmapData == null)))
                        {
                            this.UpdateGuildEmblemBitmap();
                        };
                        if (this._guildEmblemBitmapData != null)
                        {
                            this._topLeftDrawPosition.x = (this._currentNamePosition.x - 24);
                            this._topLeftDrawPosition.y = (this._currentNamePosition.y - 3);
                            _arg_2.copyPixels(this._guildEmblemBitmapData, this._guildEmblemBitmapData.rect, this._topLeftDrawPosition, this._guildEmblemBitmapData, this._guildEmblemBitmapData.rect.topLeft, true);
                        };
                    };
                    if (((!(_local_4)) || (this.IsCollided(CharacterStorage.Instance.LastPointerPosition))))
                    {
                        _arg_2.copyPixels(this._nameBitmapData, this._nameBitmapData.rect, this._currentNamePosition, this._nameBitmapData, this._nameBitmapData.rect.topLeft, true);
                    };
                };
            };
            if (this._levelUpEffect)
            {
                if (this._levelUpEffect.currentFrame < this._levelUpEffect.totalFrames)
                {
                    this._matrix.tx = (this.Position.x - _arg_1.TopLeftPoint.x);
                    _arg_2.draw(this._levelUpEffect, this._matrix);
                };
            };
            if (((this._isLocalPlayer) || ((this._characterInfo.hp >= 0) && (this._characterInfo.maxHp > 0))))
            {
                this._matrix.ty = (this._matrix.ty + 25);
                this._matrix.tx = (this.Position.x - _arg_1.TopLeftPoint.x);
                if (((!(this._characterInfo == null)) && (this._characterInfo.maxHp > 0)))
                {
                    _local_7 = (Number(this._characterInfo.hp) / Number(this._characterInfo.maxHp));
                    if (this._characterType == CHARACTER_MONSTER)
                    {
                        this._monsterHealthInfo._progress.scaleX = _local_7;
                    }
                    else
                    {
                        this._healthInfo._progress.scaleX = _local_7;
                    };
                };
                if (this._characterInfo.hp > 0)
                {
                    if (this._characterType == CHARACTER_MONSTER)
                    {
                        _arg_2.draw(this._monsterHealthInfo, this._matrix);
                    }
                    else
                    {
                        _arg_2.draw(this._healthInfo, this._matrix);
                    };
                };
            };
            if (((this._existCastTime > 0) && (this._maxCastTime > 0)))
            {
                this._matrix.ty = (this._matrix.ty - 150);
                this._matrix.tx = (this.Position.x - _arg_1.TopLeftPoint.x);
                this._castInfo._progress.scaleX = ((this._maxCastTime - this._existCastTime) / this._maxCastTime);
                _arg_2.draw(this._castInfo, this._matrix);
                this._matrix.ty = (this._matrix.ty + 150);
            };
            if (this._shopName.visible)
            {
                this._matrix.ty = (this._matrix.ty - 135);
                this._matrix.tx = ((this.Position.x - _arg_1.TopLeftPoint.x) - (this._shopName.textWidth / 2));
                this._shopName.textColor = 6697881;
                if (this._isShopNameChanged)
                {
                    this.UpdateShopNameBitmap();
                };
                this._currentNamePosition.x = this._matrix.tx;
                this._currentNamePosition.y = this._matrix.ty;
                _arg_2.copyPixels(this._shopBitmapData, this._shopBitmapData.rect, this._currentNamePosition, this._shopBitmapData, this._shopBitmapData.rect.topLeft, true);
            };
            if (this._stunEffect.visible)
            {
                _local_8 = (int(this._effectFrameTimer) % this._stunEffect.totalFrames);
                if (this._stunEffect.currentFrame != _local_8)
                {
                    _local_9 = (_local_8 - this._stunEffect.currentFrame);
                    if (Math.abs(_local_9) > 1)
                    {
                        _local_8 = (this._stunEffect.currentFrame + 1);
                        if (_local_8 >= this._stunEffect.totalFrames)
                        {
                            _local_8 = 0;
                        };
                    };
                    this._stunEffect.gotoAndStop(_local_8);
                };
                this._matrix.ty = (((_arg_1.MaxHeight - this.Position.y) - _arg_1.TopLeftPoint.y) - 110);
                this._matrix.tx = (this.Position.x - _arg_1.TopLeftPoint.x);
                _arg_2.draw(this._stunEffect, this._matrix);
            };
            if (this._characterType == Character.CHARACTER_NPC)
            {
                if (this._questStatus == 1)
                {
                    if (this._whoopBitmapData == null)
                    {
                        _local_10 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetBitmapAsset("AdditionalData_Item_Whoop");
                        if (_local_10 != null)
                        {
                            this._whoopBitmapData = _local_10.bitmapData;
                        };
                    };
                    if (this._whoopBitmapData != null)
                    {
                        this._topLeftDrawPosition.x = ((this.Position.x - _arg_1.TopLeftPoint.x) - (this._whoopBitmapData.width / 2));
                        this._topLeftDrawPosition.y = ((((_arg_1.MaxHeight - this.Position.y) - _arg_1.TopLeftPoint.y) - (this._whoopBitmapData.height / 2)) - 125);
                        _arg_2.copyPixels(this._whoopBitmapData, this._whoopBitmapData.rect, this._topLeftDrawPosition, this._whoopBitmapData, this._whoopBitmapData.rect.topLeft, true);
                    };
                };
                if (this._questStatus == 2)
                {
                    if (this._questionBitmapData == null)
                    {
                        _local_11 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetBitmapAsset("AdditionalData_Item_Question");
                        if (_local_11 != null)
                        {
                            this._questionBitmapData = _local_11.bitmapData;
                        };
                    };
                    if (this._questionBitmapData != null)
                    {
                        this._topLeftDrawPosition.x = ((this.Position.x - _arg_1.TopLeftPoint.x) - (this._questionBitmapData.width / 2));
                        this._topLeftDrawPosition.y = ((((_arg_1.MaxHeight - this.Position.y) - _arg_1.TopLeftPoint.y) - (this._questionBitmapData.height / 2)) - 125);
                        _arg_2.copyPixels(this._questionBitmapData, this._questionBitmapData.rect, this._topLeftDrawPosition, this._questionBitmapData, this._questionBitmapData.rect.topLeft, true);
                    };
                };
            };
        }

        public function Respawn():void
        {
            this._currentCharacterState = CharacterState.Idle;
        }

        public function get Name():String
        {
            if (this._characterInfo == null)
            {
                return ("Unknown");
            };
            return (this._characterInfo.name);
        }

        public function get InternalName():String
        {
            if (this._characterInfo == null)
            {
                return ("");
            };
            return (this._characterInfo.internalName);
        }

        public function set Name(_arg_1:String):void
        {
            if (this._characterInfo == null)
            {
                return;
            };
            this._characterInfo.internalName = _arg_1;
            this._textName.htmlText = HtmlText.update(this._characterInfo.internalName, true);
        }

        public function get AnimationName():String
        {
            if (this._animation == null)
            {
                return ("Unknown");
            };
            return (this._animation.CharacterName);
        }

        public function Release():void
        {
            if (this._animation != null)
            {
                RenderSystem.Instance.RemoveRenderObject(this._animation);
                this._animation.Release();
                this._animation = null;
            };
            this._characterInfo = null;
        }

        public function get Position():Point
        {
            if (this._animation == null)
            {
                return (null);
            };
            return (this._animation.Position);
        }

        public function set Position(_arg_1:Point):void
        {
            this._animation.Position = _arg_1;
        }

        public function get IsHided():Boolean
        {
            if (this._characterInfo == null)
            {
                return (false);
            };
            return (this._characterInfo.hided);
        }

        public function StartHide(_arg_1:Boolean=false):void
        {
            if (this.IsHided)
            {
                return;
            };
            if (!this._isLocalPlayer)
            {
                if (this.Selected)
                {
                    CharacterStorage.Instance.SelectCharacter(null, true);
                };
            };
            if (this._characterInfo)
            {
                this._characterInfo.hided = true;
            };
            if (this._animation != null)
            {
                this._animation.StartHide(_arg_1);
            };
        }

        public function get Invisible():Boolean
        {
            if (this._characterInfo == null)
            {
                return (false);
            };
            return (this._characterInfo.invisible);
        }

        public function set Invisible(_arg_1:Boolean):void
        {
            if (!this._isLocalPlayer)
            {
                if (((this.Selected) && (_arg_1)))
                {
                    CharacterStorage.Instance.SelectCharacter(null, true);
                };
            };
            if (this._characterInfo)
            {
                this._characterInfo.invisible = _arg_1;
            };
            if (this._animation)
            {
                this._animation.Invisible = _arg_1;
            };
        }

        public function RemoveAllStatus():void
        {
            if (this._animation != null)
            {
                this._animation.RemoveAllStatus();
            };
            if (this._characterInfo)
            {
                this._characterInfo.hided = false;
            };
        }

        public function SetIdleOrientation():void
        {
            var _local_1:String = ((this.GetIdleName() + "/") + this.GetAnimationDirectionName());
            var _local_2:String = this.GetLeftHandAnimation("Idle");
            var _local_3:String = this.GetRightHandAnimation("Idle");
            this._lastMovementIdle = _local_1;
            this._animation.SetCurrentAnimationState(_local_1);
            var _local_4:* = (this._characterInfo.coordinates.dir >= 5);
            this._animation.SetLeftHandDrawOrder(_local_4);
            if (_local_2 != null)
            {
                this._animation.SetCurrentAnimationStateLH(_local_2);
            };
            if (_local_3 != null)
            {
                this._animation.SetCurrentAnimationStateRH(_local_3);
            };
            this._animation.Stop();
            this._animation.Play(false);
        }

        public function GetLeftHandAnimation(_arg_1:String):String
        {
            var _local_2:String;
            if (this._characterInfo.viewShield == 0)
            {
                return (null);
            };
            this._animation.LeftHandRefineLevel = this._characterInfo.leftHandRefineLevel;
            return ((((_arg_1 + "L") + this._characterInfo.viewShieldId) + "/") + this.GetAnimationDirectionName());
        }

        public function GetRightHandAnimation(_arg_1:String):String
        {
            var _local_2:String;
            if (this._characterInfo.viewWeapon == 0)
            {
                return (null);
            };
            this._animation.RightHandRefineLevel = this._characterInfo.rightHandRefineLevel;
            return ((((_arg_1 + "R") + this._characterInfo.viewWeaponId) + "/") + this.GetAnimationDirectionName());
        }

        public function OnAttackStart():void
        {
            if (this._currentCharacterState == CharacterState.Attack)
            {
                return;
            };
            this._characterInfo.coordinates.isNeedFindPath = true;
            this._currentCharacterState = CharacterState.Attack;
            var _local_1:* = "Attack/Left";
            var _local_2:uint;
            if (((!(this._characterInfo.jobId == 3)) && (!(this._characterInfo.jobId == 11))))
            {
                if (((this._characterInfo.clothesColor == 0) && ((this._characterInfo.jobId == 4037) || (this._characterInfo.jobId == 4024))))
                {
                    if (this._characterInfo.viewWeapon == 0)
                    {
                        _local_2 = 2;
                    }
                    else
                    {
                        _local_2 = uint((uint((Math.random() * 2)) % 2));
                    };
                }
                else
                {
                    _local_2 = uint((uint((Math.random() * 2)) % 2));
                };
            }
            else
            {
                _local_2 = 1;
                if (this._characterInfo.viewWeapon != 0)
                {
                    if (this._characterInfo.viewWeaponId == 11)
                    {
                        _local_2 = 0;
                    };
                };
            };
            switch (_local_2)
            {
                case 0:
                    _local_1 = "Attack";
                    break;
                case 1:
                    _local_1 = "Attack2";
                    break;
                case 2:
                    _local_1 = "Attack0";
                    break;
            };
            var _local_3:String = this.GetLeftHandAnimation(_local_1);
            var _local_4:String = this.GetRightHandAnimation(_local_1);
            _local_1 = (_local_1 + ("/" + this.GetAnimationDirectionName()));
            if (((!(this._characterInfo.coordinates.x1 == 0)) || (!(this._characterInfo.coordinates.y1 == 0))))
            {
                this._lastCharacterPosition.x = this._characterInfo.coordinates.x1;
                this._lastCharacterPosition.y = this._characterInfo.coordinates.y1;
                this._characterInfo.coordinates.x = int(this._lastCharacterPosition.x);
                this._characterInfo.coordinates.y = int(this._lastCharacterPosition.y);
                this.Position.x = (this._lastCharacterPosition.x * CharacterStorage.CELL_SIZE);
                this.Position.y = (this._lastCharacterPosition.y * CharacterStorage.CELL_SIZE);
            };
            var _local_5:* = (this.GetIdleName() + "/");
            _local_5 = (_local_5 + this.GetAnimationDirectionName());
            this._lastMovementIdle = _local_5;
            this._animation.SetCurrentAnimationState(_local_1);
            var _local_6:* = (this._characterInfo.coordinates.dir >= 5);
            this._animation.SetLeftHandDrawOrder(_local_6);
            if (_local_3 != null)
            {
                this._animation.SetCurrentAnimationStateLH(_local_3);
            };
            if (_local_4 != null)
            {
                this._animation.SetCurrentAnimationStateRH(_local_4);
            };
            this._animation.Stop();
            this._animation.Play(false);
            if (this._animation.CurrentAnimationState != null)
            {
                this._animation.CurrentAnimationState.addEventListener(CharacterAnimationState.ON_COMPLETED, this.OnAttackEnd);
            };
        }

        private function GetAnimationDirectionName():String
        {
            var _local_1:* = "Down";
            switch (this._characterInfo.coordinates.dir)
            {
                case 0:
                    _local_1 = "Up";
                    break;
                case 1:
                    _local_1 = "RightUp";
                    break;
                case 2:
                    _local_1 = "Right";
                    break;
                case 3:
                    _local_1 = "DownRight";
                    break;
                case 4:
                    _local_1 = "Down";
                    break;
                case 5:
                    _local_1 = "LeftDown";
                    break;
                case 6:
                    _local_1 = "Left";
                    break;
                case 7:
                    _local_1 = "UpLeft";
                    break;
            };
            return (_local_1);
        }

        private function OnAttackEnd(_arg_1:Event):void
        {
            this._currentCharacterState = CharacterState.Idle;
            this._animation.CurrentAnimationState.removeEventListener(CharacterAnimationState.ON_COMPLETED, this.OnAttackEnd);
        }

        public function get IsDead():Boolean
        {
            return (this._currentCharacterState == CharacterState.Dead);
        }

        public function OnDeadStart():void
        {
            var _local_5:uint;
            this._deadTimer = 0;
            this._beforeDeadYPosition = this.Position.y;
            this._currentCharacterState = CharacterState.Dead;
            var _local_1:* = "Death/";
            if (this._animation.GetAnimationFrameData("Death2/DownRight") != null)
            {
                _local_5 = 0;
                _local_5 = uint((uint((Math.random() * 2)) % 2));
                switch (_local_5)
                {
                    case 0:
                        _local_1 = "Death/";
                        break;
                    case 1:
                        _local_1 = "Death2/";
                        break;
                };
            };
            var _local_2:String = this.GetLeftHandAnimation(_local_1);
            var _local_3:String = this.GetRightHandAnimation(_local_1);
            switch (this._characterInfo.coordinates.dir)
            {
                case 0:
                case 1:
                    _local_1 = (_local_1 + "RightUp");
                    break;
                case 2:
                case 3:
                    _local_1 = (_local_1 + "DownRight");
                    break;
                case 4:
                case 5:
                    _local_1 = (_local_1 + "LeftDown");
                    break;
                case 6:
                case 7:
                    _local_1 = (_local_1 + "UpLeft");
                    break;
            };
            if (this._animation.GetAnimationFrameData(_local_1) == null)
            {
                _local_1 = "Death/DownRight";
            };
            this._animation.SetCurrentAnimationState(_local_1);
            var _local_4:* = (this._characterInfo.coordinates.dir >= 5);
            this._animation.SetLeftHandDrawOrder(_local_4);
            if (_local_2 != null)
            {
                this._animation.SetCurrentAnimationStateLH(_local_2);
            };
            if (_local_3 != null)
            {
                this._animation.SetCurrentAnimationStateRH(_local_3);
            };
            this._animation.Stop();
            this._animation.Play(false);
            if (this._animation.CurrentAnimationState != null)
            {
                this._animation.CurrentAnimationState.addEventListener(CharacterAnimationState.ON_COMPLETED, this.OnDeadEnd);
            };
        }

        private function OnDeadEnd(_arg_1:Event):void
        {
            this._animation.CurrentAnimationState.removeEventListener(CharacterAnimationState.ON_COMPLETED, this.OnDeadEnd);
            this._deadTimer = 0;
        }

        public function IsCollided(_arg_1:Point):Boolean
        {
            if (this._animation != null)
            {
                return (this._animation.IsCollided(_arg_1));
            };
            return (false);
        }

        public function IsIntersected(_arg_1:Rectangle):Boolean
        {
            if (this._animation != null)
            {
                return (this._animation.IsIntersected(_arg_1));
            };
            return (false);
        }

        public function get IsAnimationValid():Boolean
        {
            return (!(this._animation == null));
        }

        public function get IsValid():Boolean
        {
            if (this._characterInfo == null)
            {
                return (false);
            };
            if (this._characterInfo.characterId <= 10)
            {
                return (false);
            };
            if (this._animation == null)
            {
                return (false);
            };
            return (this._animation.IsVisible);
        }

        public function get CharacterId():uint
        {
            if (this._characterInfo == null)
            {
                return (0);
            };
            return (this._characterInfo.characterId);
        }

        public function get CurrentState():int
        {
            return (this._currentCharacterState);
        }

        public function set CurrentState(_arg_1:int):void
        {
            this._currentCharacterState = _arg_1;
        }

        public function OnMovementInterrupted(_arg_1:Boolean=false, _arg_2:Boolean=true):void
        {
            this._currentNodeIndex = 0;
            this._pathFinderData = null;
            this._currentPathLength = 0;
            this._characterInfo.coordinates.isNeedFindPath = true;
            this._characterInfo.coordinates.x = this._lastCharacterPosition.x;
            this._characterInfo.coordinates.y = this._lastCharacterPosition.y;
            if (_arg_1)
            {
                this._characterInfo.coordinates.x1 = this._characterInfo.coordinates.x;
                this._characterInfo.coordinates.y1 = this._characterInfo.coordinates.y;
            };
            if ((((!(this._currentCharacterState == CharacterState.Attack)) && (!(this._currentCharacterState == CharacterState.Dead))) && (_arg_2)))
            {
                this._currentCharacterState = CharacterState.Idle;
            };
        }

        public function ResetDelayMovement():void
        {
            if (this._timeOutTimer == null)
            {
                return;
            };
            this._timeOutTimer.stop();
        }

        public function DelayMovement(_arg_1:int):void
        {
            if (_arg_1 < 10)
            {
                return;
            };
            if (this._timeOutTimer == null)
            {
                this._timeOutTimer = new Timer(_arg_1, 1);
            };
            this._timeOutTimer.stop();
            this._timeOutTimer.repeatCount = 1;
            this._timeOutTimer.delay = _arg_1;
            if (this._timeOutTimer.delay < 10)
            {
                this._timeOutTimer.delay = 10;
            };
            this._timeOutTimer.start();
        }

        private function SearchPath():void
        {
            this._currentNodeIndex = 0;
            this._currentPathLength = 0;
            if ((((this._lastCharacterPosition.x == 0) && (!(this._lastCharacterPosition.x == this._characterInfo.coordinates.x))) || ((this._lastCharacterPosition.y == 0) && (!(this._lastCharacterPosition.y == this._characterInfo.coordinates.y)))))
            {
                this._lastCharacterPosition.x = this._characterInfo.coordinates.x;
                this._lastCharacterPosition.y = this._characterInfo.coordinates.y;
            }
            else
            {
                this._characterInfo.coordinates.x = this._lastCharacterPosition.x;
                this._characterInfo.coordinates.y = this._lastCharacterPosition.y;
            };
            this._pathFinderData = MapCollisionManager.Instance.FindPath(this._characterInfo.coordinates);
            this._currentPathLength = MapCollisionManager.Instance.LastPathLength();
            this._characterInfo.coordinates.isNeedFindPath = false;
        }

        public function Update(_arg_1:Number):void
        {
            var _local_8:String;
            var _local_9:String;
            var _local_10:String;
            var _local_11:String;
            var _local_12:String;
            var _local_13:String;
            var _local_14:Boolean;
            var _local_15:int;
            var _local_16:Point;
            var _local_17:Number;
            var _local_18:Boolean;
            var _local_19:MapItemObject;
            var _local_20:Vector2D;
            var _local_21:Vector2D;
            var _local_22:Number;
            var _local_23:Character;
            var _local_24:Number;
            var _local_25:Vector2D;
            var _local_26:Character;
            var _local_27:Number;
            if (this._characterInfo.characterId < 10)
            {
                return;
            };
            if (this._existCastTime > 0)
            {
                this._existCastTime = (this._existCastTime - _arg_1);
                if (this._existCastTime < 0)
                {
                    this._existCastTime = 0;
                };
            };
            var _local_2:Number = 5;
            var _local_3:Number = 1;
            if (this._characterInfo.walkSpeed > 0)
            {
                _local_3 = (150 / this._characterInfo.walkSpeed);
                _local_2 = (_local_2 * _local_3);
            };
            var _local_4:Boolean = ((this._timeOutTimer == null) ? false : this._timeOutTimer.running);
            var _local_5:Number = 0;
            var _local_6:Number = 0;
            var _local_7:Boolean = true;
            if (((!(this._characterInfo == null)) && (!(_local_4))))
            {
                if (((this._currentCharacterState == CharacterState.Idle) || (this._currentCharacterState == CharacterState.Move)))
                {
                    if (_local_7)
                    {
                        if (((this._currentCharacterState == CharacterState.Idle) || (this._currentCharacterState == CharacterState.Move)))
                        {
                            if ((((this._lastCharacterPosition.x == 0) && (!(this._lastCharacterPosition.x == this._characterInfo.coordinates.x))) || ((this._lastCharacterPosition.y == 0) && (!(this._lastCharacterPosition.y == this._characterInfo.coordinates.y)))))
                            {
                                this._lastCharacterPosition.x = this._characterInfo.coordinates.x;
                                this._lastCharacterPosition.y = this._characterInfo.coordinates.y;
                            };
                            if ((((!(this._characterInfo.coordinates.x == this._characterInfo.coordinates.x1)) && (!(this._characterInfo.coordinates.x1 == 0))) || ((!(this._characterInfo.coordinates.y == this._characterInfo.coordinates.y1)) && (!(this._characterInfo.coordinates.y1 == 0)))))
                            {
                                _local_15 = 0;
                                if (this._characterInfo.coordinates.isNeedFindPath)
                                {
                                    this.SearchPath();
                                    if (this._pathFinderData == null)
                                    {
                                        return;
                                    };
                                    _local_15 = this._pathFinderData.length;
                                    if (((this._currentNodeIndex == 0) && (_local_15 > 1)))
                                    {
                                        this._currentNodeIndex = 1;
                                    };
                                };
                                if (this._pathFinderData == null)
                                {
                                    return;
                                };
                                _local_15 = this._pathFinderData.length;
                                if (_local_15 < 1)
                                {
                                    return;
                                };
                                _local_16 = this._pathFinderData[this._currentNodeIndex];
                                _local_5 = (_local_16.x - this._lastCharacterPosition.x);
                                _local_6 = (_local_16.y - this._lastCharacterPosition.y);
                                _local_17 = Math.sqrt(((_local_5 * _local_5) + (_local_6 * _local_6)));
                                _local_18 = true;
                                if (_local_17 < 0.1)
                                {
                                    this._lastCharacterPosition.x = _local_16.x;
                                    this._lastCharacterPosition.y = _local_16.y;
                                    if ((this._currentNodeIndex + 1) == _local_15)
                                    {
                                        _local_18 = false;
                                        _local_5 = 0;
                                        _local_6 = 0;
                                        this._characterInfo.coordinates.isNeedFindPath = true;
                                    }
                                    else
                                    {
                                        this._currentNodeIndex++;
                                        _local_16 = this._pathFinderData[this._currentNodeIndex];
                                        _local_5 = (_local_16.x - this._lastCharacterPosition.x);
                                        _local_6 = (_local_16.y - this._lastCharacterPosition.y);
                                    };
                                };
                                if (_local_18)
                                {
                                    if (_local_5 > 0)
                                    {
                                        this._lastCharacterPosition.x = (this._lastCharacterPosition.x + (_local_2 * _arg_1));
                                        if (this._lastCharacterPosition.x > _local_16.x)
                                        {
                                            this._lastCharacterPosition.x = _local_16.x;
                                        };
                                    };
                                    if (_local_5 < 0)
                                    {
                                        this._lastCharacterPosition.x = (this._lastCharacterPosition.x - (_local_2 * _arg_1));
                                        if (this._lastCharacterPosition.x < _local_16.x)
                                        {
                                            this._lastCharacterPosition.x = _local_16.x;
                                        };
                                    };
                                    if (_local_5 < 0)
                                    {
                                        this._characterInfo.coordinates.x = int((this._lastCharacterPosition.x + 0.9));
                                    }
                                    else
                                    {
                                        this._characterInfo.coordinates.x = int(this._lastCharacterPosition.x);
                                    };
                                    if (_local_6 > 0)
                                    {
                                        this._lastCharacterPosition.y = (this._lastCharacterPosition.y + (_local_2 * _arg_1));
                                        if (this._lastCharacterPosition.y > _local_16.y)
                                        {
                                            this._lastCharacterPosition.y = _local_16.y;
                                        };
                                    };
                                    if (_local_6 < 0)
                                    {
                                        this._lastCharacterPosition.y = (this._lastCharacterPosition.y - (_local_2 * _arg_1));
                                        if (this._lastCharacterPosition.y < _local_16.y)
                                        {
                                            this._lastCharacterPosition.y = _local_16.y;
                                        };
                                    };
                                    if (_local_6 < 0)
                                    {
                                        this._characterInfo.coordinates.y = int((this._lastCharacterPosition.y + 0.9));
                                    }
                                    else
                                    {
                                        this._characterInfo.coordinates.y = int(this._lastCharacterPosition.y);
                                    };
                                };
                            }
                            else
                            {
                                this._lastCharacterPosition.x = this._characterInfo.coordinates.x;
                                this._lastCharacterPosition.y = this._characterInfo.coordinates.y;
                            };
                        };
                    }
                    else
                    {
                        if (((!(this._characterInfo.coordinates.x == this._characterInfo.coordinates.x1)) && (!(this._characterInfo.coordinates.x1 == 0))))
                        {
                            if (int(this._lastCharacterPosition.x) != this._characterInfo.coordinates.x)
                            {
                                if ((((int((this._lastCharacterPosition.x + 0.5)) < this._characterInfo.coordinates.x) && (int((this._lastCharacterPosition.x + 0.5)) < this._characterInfo.coordinates.x1)) || ((int(this._lastCharacterPosition.x) > this._characterInfo.coordinates.x) && (int(this._lastCharacterPosition.x) > this._characterInfo.coordinates.x1))))
                                {
                                    this._lastCharacterPosition.x = this._characterInfo.coordinates.x;
                                };
                            };
                            _local_5 = (Number(this._characterInfo.coordinates.x1) - this._lastCharacterPosition.x);
                            if (_local_5 > 0)
                            {
                                this._lastCharacterPosition.x = (this._lastCharacterPosition.x + (_local_2 * _arg_1));
                            };
                            if (_local_5 < 0)
                            {
                                this._lastCharacterPosition.x = (this._lastCharacterPosition.x - (_local_2 * _arg_1));
                            };
                            if ((((int((this._lastCharacterPosition.x + 0.5)) < this._characterInfo.coordinates.x) && (int((this._lastCharacterPosition.x + 0.5)) < this._characterInfo.coordinates.x1)) || ((int(this._lastCharacterPosition.x) > this._characterInfo.coordinates.x) && (int(this._lastCharacterPosition.x) > this._characterInfo.coordinates.x1))))
                            {
                                this._lastCharacterPosition.x = this._characterInfo.coordinates.x1;
                            };
                            if (_local_5 < 0)
                            {
                                this._characterInfo.coordinates.x = int((this._lastCharacterPosition.x + 0.9));
                            }
                            else
                            {
                                this._characterInfo.coordinates.x = int(this._lastCharacterPosition.x);
                            };
                        }
                        else
                        {
                            this._lastCharacterPosition.x = this._characterInfo.coordinates.x;
                        };
                        if (((!(this._characterInfo.coordinates.y == this._characterInfo.coordinates.y1)) && (!(this._characterInfo.coordinates.y1 == 0))))
                        {
                            if (int(this._lastCharacterPosition.y) != this._characterInfo.coordinates.y)
                            {
                                if ((((int((this._lastCharacterPosition.y + 0.5)) < this._characterInfo.coordinates.y) && (int((this._lastCharacterPosition.y + 0.5)) < this._characterInfo.coordinates.y1)) || ((int(this._lastCharacterPosition.y) > this._characterInfo.coordinates.y) && (int(this._lastCharacterPosition.y) > this._characterInfo.coordinates.y1))))
                                {
                                    this._lastCharacterPosition.y = this._characterInfo.coordinates.y;
                                };
                            };
                            _local_6 = (Number(this._characterInfo.coordinates.y1) - this._lastCharacterPosition.y);
                            if (_local_6 > 0)
                            {
                                this._lastCharacterPosition.y = (this._lastCharacterPosition.y + (_local_2 * _arg_1));
                            };
                            if (_local_6 < 0)
                            {
                                this._lastCharacterPosition.y = (this._lastCharacterPosition.y - (_local_2 * _arg_1));
                            };
                            if ((((int((this._lastCharacterPosition.y + 0.5)) < this._characterInfo.coordinates.y) && (int((this._lastCharacterPosition.y + 0.5)) < this._characterInfo.coordinates.y1)) || ((int(this._lastCharacterPosition.y) > this._characterInfo.coordinates.y) && (int(this._lastCharacterPosition.y) > this._characterInfo.coordinates.y1))))
                            {
                                this._lastCharacterPosition.y = this._characterInfo.coordinates.y1;
                            };
                            if (_local_6 < 0)
                            {
                                this._characterInfo.coordinates.y = int((this._lastCharacterPosition.y + 0.9));
                            }
                            else
                            {
                                this._characterInfo.coordinates.y = int(this._lastCharacterPosition.y);
                            };
                        }
                        else
                        {
                            this._lastCharacterPosition.y = this._characterInfo.coordinates.y;
                        };
                    };
                    if (this._isLocalPlayer)
                    {
                        if (CharacterStorage.Instance.AwayMapItemId != -1)
                        {
                            _local_19 = MapItemManager.Instance.GetItem(CharacterStorage.Instance.AwayMapItemId);
                            _local_20 = Vector2D.fromPoint(_local_19.InternalPosition);
                            _local_21 = Vector2D.fromPoint(this.Position).divide(CharacterStorage.CELL_SIZE);
                            _local_22 = Vector2D.distanceSquared(_local_21, _local_20);
                            if (_local_22 <= 4)
                            {
                                ClientApplication.Instance.LocalGameClient.SendTake(CharacterStorage.Instance.AwayMapItemId);
                                CharacterStorage.Instance.AwayMapItemId = -1;
                            };
                        };
                    };
                    this.Position.x = (this._lastCharacterPosition.x * CharacterStorage.CELL_SIZE);
                    this.Position.y = (this._lastCharacterPosition.y * CharacterStorage.CELL_SIZE);
                    _local_8 = "Idle";
                    _local_9 = this.GetRunName();
                    _local_10 = this.GetIdleName();
                    _local_11 = (_local_10 + "/Down");
                    if (_local_5 > 0)
                    {
                        if (_local_6 == 0)
                        {
                            _local_8 = "Run";
                            _local_11 = (_local_9 + "/Right");
                            this._lastMovementIdle = (_local_10 + "/Right");
                            this._characterInfo.coordinates.dir = 2;
                        }
                        else
                        {
                            if (_local_6 < 0)
                            {
                                _local_8 = "Run";
                                _local_11 = (_local_9 + "/DownRight");
                                this._lastMovementIdle = (_local_10 + "/DownRight");
                                this._characterInfo.coordinates.dir = 3;
                            }
                            else
                            {
                                _local_8 = "Run";
                                _local_11 = (_local_9 + "/RightUp");
                                this._lastMovementIdle = (_local_10 + "/RightUp");
                                this._characterInfo.coordinates.dir = 1;
                            };
                        };
                    }
                    else
                    {
                        if (_local_5 < 0)
                        {
                            if (_local_6 == 0)
                            {
                                _local_8 = "Run";
                                _local_11 = (_local_9 + "/Left");
                                this._lastMovementIdle = (_local_10 + "/Left");
                                this._characterInfo.coordinates.dir = 6;
                            }
                            else
                            {
                                if (_local_6 < 0)
                                {
                                    _local_8 = "Run";
                                    _local_11 = (_local_9 + "/LeftDown");
                                    this._lastMovementIdle = (_local_10 + "/LeftDown");
                                    this._characterInfo.coordinates.dir = 5;
                                }
                                else
                                {
                                    _local_8 = "Run";
                                    _local_11 = (_local_9 + "/UpLeft");
                                    this._lastMovementIdle = (_local_10 + "/UpLeft");
                                    this._characterInfo.coordinates.dir = 7;
                                };
                            };
                        }
                        else
                        {
                            if (_local_6 < 0)
                            {
                                _local_8 = "Run";
                                _local_11 = (_local_9 + "/Down");
                                this._lastMovementIdle = (_local_10 + "/Down");
                                this._characterInfo.coordinates.dir = 4;
                            }
                            else
                            {
                                if (_local_6 > 0)
                                {
                                    _local_8 = "Run";
                                    _local_11 = (_local_9 + "/Up");
                                    this._lastMovementIdle = (_local_10 + "/Up");
                                    this._characterInfo.coordinates.dir = 0;
                                };
                            };
                        };
                    };
                    if ((((this._isLocalPlayer) && (!(CharacterStorage.Instance.SkillCharacterId == -1))) && (CharacterStorage.Instance.SkillMode > 0)))
                    {
                        _local_23 = CharacterStorage.Instance.GetCharacterData(CharacterStorage.Instance.SkillCharacterId);
                        if (_local_23 != null)
                        {
                            _local_24 = CharacterStorage.Instance.GetCharacterDistanceSqr(_local_23, this);
                            if (_local_24 < CharacterStorage.Instance.SkillRangeSqr)
                            {
                                ClientApplication.Instance.BottomHUD.InventoryBarInstance.DoCooldownSkillSlots(CharacterStorage.Instance.SkillMode, 0, CharacterStorage.Instance.SkillPanelSlot);
                                ClientApplication.Instance.LocalGameClient.SendSkillUse(CharacterStorage.Instance.SkillMode, CharacterStorage.Instance.SkillLevel, CharacterStorage.Instance.SkillCharacterId);
                                CharacterStorage.Instance.SkillMode = 0;
                                CharacterStorage.Instance.SkillCharacterId = -1;
                            }
                            else
                            {
                                _local_25 = Vector2D.fromPoint(_local_23.Position).divide(CharacterStorage.CELL_SIZE);
                                ClientApplication.Instance.LocalGameClient.MoveTo(_local_25.x, _local_25.y);
                            };
                        }
                        else
                        {
                            CharacterStorage.Instance.SkillMode = 0;
                            CharacterStorage.Instance.SkillCharacterId = -1;
                        };
                    };
                    if ((((_local_5 == 0) && (_local_6 == 0)) && (this._isLocalPlayer)))
                    {
                        _local_26 = CharacterStorage.Instance.SelectedCharacter;
                        if (_local_26)
                        {
                            if (((!(_local_26.CharacterType == Character.CHARACTER_NPC)) && (_local_26.IsAutoAttacked)))
                            {
                                CharacterStorage.Instance.OnStartBaseAttack();
                            };
                        };
                    };
                    _local_12 = this.GetLeftHandAnimation(_local_8);
                    _local_13 = this.GetRightHandAnimation(_local_8);
                    if (_local_11 == (_local_10 + "/Down"))
                    {
                        this._animation.SetCurrentAnimationState(this._lastMovementIdle);
                    }
                    else
                    {
                        this._animation.SetCurrentAnimationState(_local_11);
                    };
                    _local_14 = (this._characterInfo.coordinates.dir >= 5);
                    this._animation.SetLeftHandDrawOrder(_local_14);
                    if (_local_12 != null)
                    {
                        this._animation.SetCurrentAnimationStateLH(_local_12);
                    };
                    if (_local_13 != null)
                    {
                        this._animation.SetCurrentAnimationStateRH(_local_13);
                    };
                    this._animation.Play();
                }
                else
                {
                    if (((this._currentCharacterState == CharacterState.Dead) && (this._characterType == CHARACTER_MONSTER)))
                    {
                        if (this._deadTimer < 5)
                        {
                            this._deadTimer = (this._deadTimer + _arg_1);
                            if (this._deadTimer >= 3)
                            {
                                this._animation.DrawShadow = false;
                                _local_27 = (1 - (Math.max((5 - this._deadTimer), 0) / 2));
                                this._animation.SetAlpha((1 - _local_27));
                            };
                        }
                        else
                        {
                            this._animation.SetAlpha(1);
                            CharacterStorage.Instance.RemoveCharacter(this);
                            this.Release();
                        };
                    };
                };
            };
            if (this._animation != null)
            {
                if (_local_4)
                {
                    this._animation.Update((_arg_1 * 0.35));
                }
                else
                {
                    this._animation.Update(_arg_1);
                };
            };
            this._effectFrameTimer = (this._effectFrameTimer + (_arg_1 * 10));
            while (this._effectFrameTimer >= 6)
            {
                this._effectFrameTimer = (this._effectFrameTimer - 6);
            };
        }

        public function TurnDead():void
        {
            if (this.IsDead)
            {
                return;
            };
            var _local_1:* = "Death/DownRight";
            this._animation.SetCurrentAnimationState(_local_1);
            this._animation.Stop();
            this._animation.Play(false);
            this._animation.Update(10);
            this._lastCharacterPosition.x = this._characterInfo.coordinates.x;
            this._lastCharacterPosition.y = this._characterInfo.coordinates.y;
            this.Position.x = (this._lastCharacterPosition.x * CharacterStorage.CELL_SIZE);
            this.Position.y = (this._lastCharacterPosition.y * CharacterStorage.CELL_SIZE);
            this._currentCharacterState = CharacterState.Dead;
        }

        public function TurnIdle():void
        {
            if (!this.IsDead)
            {
                return;
            };
            var _local_1:* = (this.GetIdleName() + "/Down");
            this._animation.SetCurrentAnimationState(_local_1);
            this._animation.Stop();
            this._animation.Play(false);
            this._animation.Update(10);
            this._lastCharacterPosition.x = this._characterInfo.coordinates.x;
            this._lastCharacterPosition.y = this._characterInfo.coordinates.y;
            this.Position.x = (this._lastCharacterPosition.x * CharacterStorage.CELL_SIZE);
            this.Position.y = (this._lastCharacterPosition.y * CharacterStorage.CELL_SIZE);
            this._currentCharacterState = CharacterState.Idle;
        }

        public function SetAdjustColor(_arg_1:Number, _arg_2:Number, _arg_3:Number, _arg_4:Number):void
        {
            if (this._animation != null)
            {
                this._animation.SetAdjustColor(_arg_1, _arg_2, _arg_3, _arg_4);
            };
        }

        public function get IsAutoAttacked():Boolean
        {
            return (this._isAutoAttacked);
        }

        public function set IsAutoAttacked(_arg_1:Boolean):void
        {
            this._isAutoAttacked = _arg_1;
        }


    }
}//package hbm.Game.Character

