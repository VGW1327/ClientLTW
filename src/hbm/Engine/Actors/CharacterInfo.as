


//hbm.Engine.Actors.CharacterInfo

package hbm.Engine.Actors
{
    import hbm.Engine.Network.Packet.Coordinates;
    import flash.utils.Dictionary;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Network.TransmissionObject.TransmissionObject;

    public class CharacterInfo 
    {

        public static const SP_SPEED:int = 0;
        public static const SP_BASEEXP:int = 1;
        public static const SP_JOBEXP:int = 2;
        public static const SP_KARMA:int = 3;
        public static const SP_MANNER:int = 4;
        public static const SP_HP:int = 5;
        public static const SP_MAXHP:int = 6;
        public static const SP_SP:int = 7;
        public static const SP_MAXSP:int = 8;
        public static const SP_STATUSPOINT:int = 9;
        public static const SP_BASELEVEL:int = 11;
        public static const SP_SKILLPOINT:int = 12;
        public static const SP_STR:int = 13;
        public static const SP_AGI:int = 14;
        public static const SP_VIT:int = 15;
        public static const SP_INT:int = 16;
        public static const SP_DEX:int = 17;
        public static const SP_LUK:int = 18;
        public static const SP_MONEY:int = 20;
        public static const SP_NEXTBASEEXP:int = 22;
        public static const SP_NEXTJOBEXP:int = 23;
        public static const SP_WEIGHT:int = 24;
        public static const SP_MAXWEIGHT:int = 25;
        public static const SP_USTR:int = 32;
        public static const SP_UAGI:int = 33;
        public static const SP_UVIT:int = 34;
        public static const SP_UINT:int = 35;
        public static const SP_UDEX:int = 36;
        public static const SP_ULUK:int = 37;
        public static const SP_ATK1:int = 41;
        public static const SP_ATK2:int = 42;
        public static const SP_MATK1:int = 43;
        public static const SP_MATK2:int = 44;
        public static const SP_DEF1:int = 45;
        public static const SP_DEF2:int = 46;
        public static const SP_MDEF1:int = 47;
        public static const SP_MDEF2:int = 48;
        public static const SP_HIT:int = 49;
        public static const SP_FLEE1:int = 50;
        public static const SP_FLEE2:int = 51;
        public static const SP_CRITICAL:int = 52;
        public static const SP_ASPD:int = 53;
        public static const SP_JOBLEVEL:int = 55;
        public static const SP_KDEF:int = 61;
        public static const SP_OLDDEF:int = 62;
        public static const SP_DEATHFEAR:int = 63;
        public static const SP_BREAKRIB:int = 64;
        public static const SP_ARENAPUNISH:int = 65;
        public static const SP_BREAKHEAD:int = 66;
        public static const SP_GMLEVEL:int = 67;
        public static const SP_CARTINFO:int = 99;
        public static const SP_BASE_ATK:int = 1014;
        public static const SP_PREMIUM:int = 2044;
        public static const LOOK_BASE:int = 0;
        public static const LOOK_HAIR:int = 1;
        public static const LOOK_WEAPON:int = 2;
        public static const LOOK_HEAD_BOTTOM:int = 3;
        public static const LOOK_HEAD_TOP:int = 4;
        public static const LOOK_HEAD_MID:int = 5;
        public static const LOOK_HAIR_COLOR:int = 6;
        public static const LOOK_CLOTHES_COLOR:int = 7;
        public static const LOOK_SHIELD:int = 8;
        public static const LOOK_SHOES:int = 9;
        public static const LOOK_WEAPON_REFINE:int = 10;
        public static const LOOK_SHIELD_REFINE:int = 11;
        public static const LOOK_SEX:int = 12;
        public static const RACE_HUMAN:uint = 1;
        public static const RACE_UNDEAD:uint = 2;
        public static const RACE_TURON:uint = 3;
        public static const RACE_ORC:uint = 4;
        public static const FRACTION_LIGHT:int = 0;
        public static const FRACTION_DARK:int = 2;

        private var _isStatusesLoaded:Boolean;
        private var _isNameLoaded:Boolean;
        private var _internalName:String;
        private var _needDraw:Boolean = true;
        private var _drawShadow:Boolean = true;
        private var _showName:Boolean = true;
        private var _autoHideName:Boolean = false;
        private var _nameColor:int = -1;
        private var _allowSelection:Boolean = true;
        private var _intravision:Boolean = false;
        private var _invisible:Boolean = false;
        private var _hided:Boolean = false;
        private var _isDead:int = 0;
        private var _partyName:String;
        private var _guildName:String;
        private var _isAllie:Boolean;
        private var _guildTitle:String;
        private var _lastBaseExp:int;
        private var _lastMoney:int;
        private var _lastGold:int;
        private var _slot:int;
        private var _characterId:uint;
        private var _baseExp:int;
        private var _nextBaseExp:int;
        private var _money:int;
        private var _jobExp:int;
        private var _nextJobExp:int;
        private var _jobLevel:int;
        private var _hp:int;
        private var _maxHp:int;
        private var _sp:int;
        private var _maxSp:int;
        private var _sex:int;
        private var _jobId:int;
        private var _hairStyle:int;
        private var _baseLevel:int;
        private var _hairColor:int;
        private var _clothesColor:int;
        private var _name:String;
        private var _viewShield:int;
        private var _viewWeapon:int;
        private var _viewHead:int;
        private var _viewShieldId:int;
        private var _viewWeaponId:int;
        private var _leftHandRefineLevel:int;
        private var _rightHandRefineLevel:int;
        private var _str:int;
        private var _agi:int;
        private var _vit:int;
        private var _int:int;
        private var _dex:int;
        private var _luk:int;
        private var _ustr:int;
        private var _uagi:int;
        private var _uvit:int;
        private var _uint:int;
        private var _udex:int;
        private var _uluk:int;
        private var _strBonus:int;
        private var _agiBonus:int;
        private var _vitBonus:int;
        private var _intBonus:int;
        private var _dexBonus:int;
        private var _lukBonus:int;
        private var _walkSpeed:Number = 0;
        private var _weight:Number;
        private var _weightMax:Number;
        private var _karma:int;
        private var _manner:uint;
        private var _lastManner:uint;
        private var _statusPoint:int;
        private var _skillPoint:int;
        private var _hit:int;
        private var _deathfear:uint;
        private var _breakrib:uint;
        private var _arenapunish:uint;
        private var _breakhead:uint;
        private var _flee1:int;
        private var _flee2:int;
        private var _aspd:int;
        private var _batk:int;
        private var _atk1:int;
        private var _atk2:int;
        private var _def1:int;
        private var _def2:int;
        private var _kdef:int;
        private var _olddef:int;
        private var _mdef1:int;
        private var _mdef2:int;
        private var _matkMax:int;
        private var _matkMin:int;
        private var _range:int;
        private var _critical:int;
        private var _cashPoints:int;
        private var _kafraPoints:int;
        private var _rename:int;
        private var _coordinates:Coordinates = new Coordinates();
        private var _items:Dictionary;
        private var _equipment:CharacterEquipment;
        private var _skills:Dictionary;
        private var _questStates:Dictionary;
        private var _guild:GuildInfo;
        private var _guildEmblem:int;
        private var _party:PartyInfo;
        private var _friends:FriendInfo;
        private var _ignore:IgnoreInfo;
        private var _hotkeys:HotKeys;
        private var _venderName:String;
        private var _pet:PetInfo;
        public var Support:Boolean;
        public var DisguiseId:int = 0;

        public function CharacterInfo()
        {
            this._isNameLoaded = false;
            this._isStatusesLoaded = false;
            this._internalName = "Unknown";
            this._equipment = new CharacterEquipment();
            this._hotkeys = new HotKeys(this);
            this._cashPoints = 0;
            this._kafraPoints = 0;
            this.Support = false;
        }

        public function Reset():void
        {
            this._items = new Dictionary(true);
        }

        public function get Rename():int
        {
            return (this._rename);
        }

        public function get Hotkeys():HotKeys
        {
            return (this._hotkeys);
        }

        public function get Equipment():CharacterEquipment
        {
            return (this._equipment);
        }

        public function RevalidateEquipment():void
        {
            var _local_2:ItemData;
            var _local_3:ItemData;
            var _local_1:ItemData = this._equipment.GetItemBySlotName(CharacterEquipment.SLOT_RIGHT_HAND);
            this._equipment.Clear();
            for each (_local_2 in this._items)
            {
                if (_local_2.Equip > 0)
                {
                    this._equipment.EquipItem(_local_2);
                };
            };
            _local_3 = this._equipment.GetItemBySlotName(CharacterEquipment.SLOT_RIGHT_HAND);
            if ((((((!(_local_1)) && (!(_local_3))) || ((_local_1) && (!(_local_3)))) || ((!(_local_1)) && (_local_3))) || (((_local_1) && (_local_3)) && (!(_local_1.NameId == _local_3.NameId)))))
            {
                ClientApplication.Instance.BottomHUD.InventoryBarInstance.LoadActionSlot();
            };
        }

        public function get Guild():GuildInfo
        {
            return (this._guild);
        }

        public function set Guild(_arg_1:GuildInfo):void
        {
            this._guild = _arg_1;
        }

        public function get Party():PartyInfo
        {
            return (this._party);
        }

        public function set Party(_arg_1:PartyInfo):void
        {
            this._party = _arg_1;
        }

        public function get Friends():FriendInfo
        {
            return (this._friends);
        }

        public function set Friends(_arg_1:FriendInfo):void
        {
            this._friends = _arg_1;
        }

        public function get Pet():PetInfo
        {
            if (this._pet == null)
            {
                this._pet = new PetInfo();
            };
            return (this._pet);
        }

        public function set Pet(_arg_1:PetInfo):void
        {
            this._pet = _arg_1;
        }

        public function get IgnoreList():IgnoreInfo
        {
            return (this._ignore);
        }

        public function set IgnoreList(_arg_1:IgnoreInfo):void
        {
            this._ignore = _arg_1;
        }

        public function get VenderName():String
        {
            return (this._venderName);
        }

        public function set VenderName(_arg_1:String):void
        {
            this._venderName = _arg_1;
        }

        public function get hairColor():int
        {
            return (this._hairColor);
        }

        public function set hairColor(_arg_1:int):void
        {
            this._hairColor = _arg_1;
        }

        public function get clothesColor():int
        {
            return (this._clothesColor);
        }

        public function set clothesColor(_arg_1:int):void
        {
            this._clothesColor = _arg_1;
        }

        public function DebugPrintInventory():void
        {
            var _local_1:ItemData;
            for each (_local_1 in this._items)
            {
                if (_local_1 != null)
                {
                    _local_1.PrintDebugInfo();
                };
            };
        }

        public function ReadFromStream():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 108)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.BufferPosition;
            this._characterId = TransmissionObject.Instance.ReadInt32();
            this._baseExp = TransmissionObject.Instance.ReadInt32();
            this._money = TransmissionObject.Instance.ReadInt32();
            this._jobExp = TransmissionObject.Instance.ReadInt32();
            this._jobLevel = TransmissionObject.Instance.ReadInt16();
            TransmissionObject.Instance.BufferPosition = (_local_2 + 42);
            this._hp = TransmissionObject.Instance.ReadInt16();
            this._maxHp = TransmissionObject.Instance.ReadInt16();
            this._sp = TransmissionObject.Instance.ReadInt16();
            this._maxSp = TransmissionObject.Instance.ReadInt16();
            TransmissionObject.Instance.BufferPosition = (_local_2 + 52);
            this._jobId = TransmissionObject.Instance.ReadInt16();
            var _local_3:int = TransmissionObject.Instance.ReadInt16();
            this._hairStyle = (_local_3 & 0x7FFF);
            this._sex = ((_local_3 & 0x8000) >> 15);
            TransmissionObject.Instance.BufferPosition = (_local_2 + 58);
            this._baseLevel = TransmissionObject.Instance.ReadInt16();
            TransmissionObject.Instance.BufferPosition = (_local_2 + 62);
            TransmissionObject.Instance.ReadInt16();
            TransmissionObject.Instance.BufferPosition = (_local_2 + 66);
            TransmissionObject.Instance.ReadInt16();
            TransmissionObject.Instance.ReadInt16();
            this._hairColor = TransmissionObject.Instance.ReadInt16();
            this._clothesColor = TransmissionObject.Instance.ReadInt16();
            this._name = TransmissionObject.Instance.ReadString(24);
            TransmissionObject.Instance.BufferPosition = (_local_2 + 98);
            this._str = TransmissionObject.Instance.ReadUInt8();
            this._agi = TransmissionObject.Instance.ReadUInt8();
            this._vit = TransmissionObject.Instance.ReadUInt8();
            this._int = TransmissionObject.Instance.ReadUInt8();
            this._dex = TransmissionObject.Instance.ReadUInt8();
            this._luk = TransmissionObject.Instance.ReadUInt8();
            this._slot = TransmissionObject.Instance.ReadInt16();
            this._rename = TransmissionObject.Instance.ReadUInt16();
            this._isStatusesLoaded = true;
            this._isNameLoaded = true;
            this._internalName = this._name;
			trace("ReadFromStream_local_2: " + _local_2);
			trace("this._characterId: " + this._characterId); // ID - персонажа, возможно они одинаковы.. в одном акке. вычесляются по логинид
			trace("this._baseExp: " + this._baseExp); 
			trace("this._money: " + this._money); //Кол-во серебра
			trace("this._jobExp: " + this._jobExp); //Кол-во опыта професии
			trace("this._jobLevel: " + this._jobLevel); //Уровень професии
			trace("this._hp: " + this._hp); //Кол-во жизни
			trace("this._maxHp: " + this._maxHp); //Мак-ое кол-во жизни
			trace("this._sp: " + this._sp); //Кол-во маны
			trace("this._maxSp: " + this._maxSp); //Мак-ое кол-во маны
			trace("this._jobId: " + this._jobId); //Профессия персонажа
			trace("this._local_3: " + _local_3); //Некие данные для hairStyle, sex
			trace("this._hairStyle: " + this._hairStyle); // Что - то 
			trace("this._sex: " + this._sex); //Пол персонажа -1=М, 0=Ж
			trace("this._baseLevel: " + this._baseLevel); //Базовый уровень
			trace("this._hairColor: " + this._hairColor); // Что - то (мб свет перса равно где то от 1 до 6)
			trace("this._clothesColor: " + this._clothesColor); //Скин перса или же расса
			trace("this._name: " + this._name); //Никнейм
			trace("this._str: " + this._str); //Сила
			trace("this._agi: " + this._agi); //Ловскость
			trace("this._vit: " + this._vit); //Стойкость
			trace("this._int: " + this._int); //Интелект
			trace("this._dex: " + this._dex); //Мастерство
			trace("this._luk: " + this._luk); //Удача
			trace("this._slot: " + this._slot); //Слот персонажа, начало 0... максимум 14
			trace("this._rename: " + this._rename); // Переименование персонажа 0=Разрешено, естественно 1=Запрещено.
            return (true);
        }

        public function get slot():int
        {
            return (this._slot);
        }

        public function get characterId():uint
        {
            return (this._characterId);
        }

        public function set characterId(_arg_1:uint):void
        {
            this._characterId = _arg_1;
        }

        public function get walkSpeed():Number
        {
            return (this._walkSpeed);
        }

        public function set walkSpeed(_arg_1:Number):void
        {
            this._walkSpeed = _arg_1;
        }

        public function get weight():Number
        {
            return (this._weight);
        }

        public function set weight(_arg_1:Number):void
        {
            this._weight = _arg_1;
        }

        public function get weightMax():Number
        {
            return (this._weightMax);
        }

        public function set weightMax(_arg_1:Number):void
        {
            this._weightMax = _arg_1;
        }

        public function get coordinates():Coordinates
        {
            return (this._coordinates);
        }

        public function get str():int
        {
            return (this._str);
        }

        public function set str(_arg_1:int):void
        {
            this._str = _arg_1;
        }

        public function get strBonus():int
        {
            return (this._strBonus);
        }

        public function set strBonus(_arg_1:int):void
        {
            this._strBonus = _arg_1;
        }

        public function get name():String
        {
            if (this._name != null)
            {
                return (this._name);
            };
            return (this._characterId.toString());
        }

        public function set name(_arg_1:String):void
        {
            this._name = _arg_1.substr(0, 24);
            this._internalName = this._name;
        }

        public function get hp():int
        {
            return (this._hp);
        }

        public function set hp(_arg_1:int):void
        {
            this._hp = _arg_1;
        }

        public function get maxHp():int
        {
            return (this._maxHp);
        }

        public function set maxHp(_arg_1:int):void
        {
            this._maxHp = _arg_1;
        }

        public function get sp():int
        {
            return (this._sp);
        }

        public function set sp(_arg_1:int):void
        {
            this._sp = _arg_1;
        }

        public function get maxSp():int
        {
            return (this._maxSp);
        }

        public function set maxSp(_arg_1:int):void
        {
            this._maxSp = _arg_1;
        }

        public function get baseLevel():int
        {
            return (this._baseLevel);
        }

        public function set baseLevel(_arg_1:int):void
        {
            this._baseLevel = _arg_1;
        }

        public function get jobLevel():int
        {
            return (this._jobLevel);
        }

        public function set jobLevel(_arg_1:int):void
        {
            this._jobLevel = _arg_1;
        }

        public function get karma():int
        {
            return (this._karma);
        }

        public function set karma(_arg_1:int):void
        {
            this._karma = _arg_1;
        }

        public function get lastManner():uint
        {
            return (this._lastManner);
        }

        public function get manner():uint
        {
            return (this._manner);
        }

        public function set manner(_arg_1:uint):void
        {
            this._lastManner = this._manner;
            this._manner = _arg_1;
        }

        public function get deathfear():uint
        {
            return (this._deathfear);
        }

        public function set deathfear(_arg_1:uint):void
        {
            this._deathfear = _arg_1;
        }

        public function get breakrib():uint
        {
            return (this._breakrib);
        }

        public function set breakrib(_arg_1:uint):void
        {
            this._breakrib = _arg_1;
        }

        public function get breakhead():uint
        {
            return (this._breakhead);
        }

        public function set breakhead(_arg_1:uint):void
        {
            this._breakhead = _arg_1;
        }

        public function get arenapunish():uint
        {
            return (this._arenapunish);
        }

        public function set arenapunish(_arg_1:uint):void
        {
            this._arenapunish = _arg_1;
        }

        public function get statusPoint():int
        {
            return (this._statusPoint);
        }

        public function set statusPoint(_arg_1:int):void
        {
            this._statusPoint = _arg_1;
        }

        public function get skillPoint():int
        {
            return (this._skillPoint);
        }

        public function set skillPoint(_arg_1:int):void
        {
            this._skillPoint = _arg_1;
        }

        public function get hit():int
        {
            return (this._hit);
        }

        public function set hit(_arg_1:int):void
        {
            this._hit = _arg_1;
        }

        public function get flee1():int
        {
            return (this._flee1);
        }

        public function set flee1(_arg_1:int):void
        {
            this._flee1 = _arg_1;
        }

        public function get flee2():int
        {
            return (this._flee2);
        }

        public function set flee2(_arg_1:int):void
        {
            this._flee2 = _arg_1;
        }

        public function get aspd():int
        {
            return (this._aspd);
        }

        public function set aspd(_arg_1:int):void
        {
            this._aspd = _arg_1;
        }

        public function get batk():int
        {
            return (this._batk);
        }

        public function set batk(_arg_1:int):void
        {
            this._batk = _arg_1;
        }

        public function get atk1():int
        {
            return (this._atk1);
        }

        public function set atk1(_arg_1:int):void
        {
            this._atk1 = _arg_1;
        }

        public function get def1():int
        {
            return (this._def1);
        }

        public function set def1(_arg_1:int):void
        {
            this._def1 = _arg_1;
        }

        public function get kdef():int
        {
            return (this._kdef);
        }

        public function set kdef(_arg_1:int):void
        {
            this._kdef = _arg_1;
        }

        public function get olddef():int
        {
            return (this._olddef);
        }

        public function set olddef(_arg_1:int):void
        {
            this._olddef = _arg_1;
        }

        public function get mdef1():int
        {
            return (this._mdef1);
        }

        public function set mdef1(_arg_1:int):void
        {
            this._mdef1 = _arg_1;
        }

        public function get mdef2():int
        {
            return (this._mdef2);
        }

        public function set mdef2(_arg_1:int):void
        {
            this._mdef2 = _arg_1;
        }

        public function get atk2():int
        {
            return (this._atk2);
        }

        public function set atk2(_arg_1:int):void
        {
            this._atk2 = _arg_1;
        }

        public function get def2():int
        {
            return (this._def2);
        }

        public function set def2(_arg_1:int):void
        {
            this._def2 = _arg_1;
        }

        public function get critical():int
        {
            return (this._critical);
        }

        public function set critical(_arg_1:int):void
        {
            this._critical = _arg_1;
        }

        public function get matkMax():int
        {
            return (this._matkMax);
        }

        public function set matkMax(_arg_1:int):void
        {
            this._matkMax = _arg_1;
        }

        public function get matkMin():int
        {
            return (this._matkMin);
        }

        public function set matkMin(_arg_1:int):void
        {
            this._matkMin = _arg_1;
        }

        public function get money():int
        {
            return (this._money);
        }

        public function set money(_arg_1:int):void
        {
            this._money = _arg_1;
        }

        public function get baseExp():int
        {
            return (this._baseExp);
        }

        public function set baseExp(_arg_1:int):void
        {
            this._baseExp = _arg_1;
        }

        public function get jobExp():int
        {
            return (this._jobExp);
        }

        public function set jobExp(_arg_1:int):void
        {
            this._jobExp = _arg_1;
        }

        public function get nextJobExp():int
        {
            return (this._nextJobExp);
        }

        public function set nextJobExp(_arg_1:int):void
        {
            this._nextJobExp = _arg_1;
        }

        public function get nextBaseExp():int
        {
            return (this._nextBaseExp);
        }

        public function set nextBaseExp(_arg_1:int):void
        {
            this._nextBaseExp = _arg_1;
        }

        public function get agi():int
        {
            return (this._agi);
        }

        public function set agi(_arg_1:int):void
        {
            this._agi = _arg_1;
        }

        public function get vit():int
        {
            return (this._vit);
        }

        public function set vit(_arg_1:int):void
        {
            this._vit = _arg_1;
        }

        public function get intl():int
        {
            return (this._int);
        }

        public function set intl(_arg_1:int):void
        {
            this._int = _arg_1;
        }

        public function get dex():int
        {
            return (this._dex);
        }

        public function set dex(_arg_1:int):void
        {
            this._dex = _arg_1;
        }

        public function get luk():int
        {
            return (this._luk);
        }

        public function set luk(_arg_1:int):void
        {
            this._luk = _arg_1;
        }

        public function get range():int
        {
            return (this._range);
        }

        public function set range(_arg_1:int):void
        {
            this._range = _arg_1;
        }

        public function get uagi():int
        {
            return (this._uagi);
        }

        public function set uagi(_arg_1:int):void
        {
            this._uagi = _arg_1;
        }

        public function get uintl():int
        {
            return (this._uint);
        }

        public function set uintl(_arg_1:int):void
        {
            this._uint = _arg_1;
        }

        public function get udex():int
        {
            return (this._udex);
        }

        public function set udex(_arg_1:int):void
        {
            this._udex = _arg_1;
        }

        public function get ustr():int
        {
            return (this._ustr);
        }

        public function set ustr(_arg_1:int):void
        {
            this._ustr = _arg_1;
        }

        public function get uluk():int
        {
            return (this._uluk);
        }

        public function set uluk(_arg_1:int):void
        {
            this._uluk = _arg_1;
        }

        public function get uvit():int
        {
            return (this._uvit);
        }

        public function set uvit(_arg_1:int):void
        {
            this._uvit = _arg_1;
        }

        public function get intBonus():int
        {
            return (this._intBonus);
        }

        public function set intBonus(_arg_1:int):void
        {
            this._intBonus = _arg_1;
        }

        public function get vitBonus():int
        {
            return (this._vitBonus);
        }

        public function set vitBonus(_arg_1:int):void
        {
            this._vitBonus = _arg_1;
        }

        public function get agiBonus():int
        {
            return (this._agiBonus);
        }

        public function set agiBonus(_arg_1:int):void
        {
            this._agiBonus = _arg_1;
        }

        public function get lukBonus():int
        {
            return (this._lukBonus);
        }

        public function set lukBonus(_arg_1:int):void
        {
            this._lukBonus = _arg_1;
        }

        public function get dexBonus():int
        {
            return (this._dexBonus);
        }

        public function set dexBonus(_arg_1:int):void
        {
            this._dexBonus = _arg_1;
        }

        public function get Items():Dictionary
        {
            if (this._items == null)
            {
                this._items = new Dictionary(true);
            };
            return (this._items);
        }

        public function get ItemsCount():int
        {
            var _local_2:ItemData;
            var _local_1:int;
            if (this._items == null)
            {
                this._items = new Dictionary(true);
            };
            for each (_local_2 in this._items)
            {
                _local_1++;
            };
            return (_local_1);
        }

        public function GetItemByName(_arg_1:int):ItemData
        {
            var _local_2:ItemData;
            for each (_local_2 in this._items)
            {
                if (_local_2.NameId == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function GetItemIdListByNames(_arg_1:int, _arg_2:int):Array
        {
            var _local_4:ItemData;
            var _local_3:Array = new Array();
            for each (_local_4 in this._items)
            {
                if (((_local_4.NameId >= _arg_1) && (_local_4.NameId <= _arg_2)))
                {
                    _local_3.push(_local_4.NameId);
                };
            };
            return ((_local_3.length > 0) ? _local_3 : null);
        }

        public function GetAmountOfItemByName(_arg_1:int):int
        {
            var _local_3:ItemData;
            var _local_2:int;
            for each (_local_3 in this._items)
            {
                if (_local_3.NameId == _arg_1)
                {
                    _local_2++;
                };
            };
            return (_local_2);
        }

        public function get QuestStates():Dictionary
        {
            if (this._questStates == null)
            {
                this._questStates = new Dictionary(true);
            };
            return (this._questStates);
        }

        public function set QuestStates(_arg_1:Dictionary):void
        {
            this._questStates = _arg_1;
        }

        public function GetQuestCount():int
        {
            var _local_2:Object;
            var _local_3:int;
            var _local_1:int;
            for (_local_2 in this.QuestStates)
            {
                _local_3 = this._questStates[_local_2];
                if (!((_local_2 == 254) && (_local_3 == 1)))
                {
                    if (((_local_3 > 0) && (_local_3 < 100)))
                    {
                        _local_1++;
                    };
                };
            };
            return (_local_1);
        }

        public function get Skills():Dictionary
        {
            if (this._skills == null)
            {
                this._skills = new Dictionary(true);
            };
            return (this._skills);
        }

        public function get jobId():int
        {
            return (this._jobId);
        }

        public function set jobId(_arg_1:int):void
        {
            this._jobId = _arg_1;
        }

        public function get sex():int
        {
            return (this._sex);
        }

        public function set sex(_arg_1:int):void
        {
            this._sex = _arg_1;
        }

        public function get isNameLoaded():Boolean
        {
            return (this._isNameLoaded);
        }

        public function set isNameLoaded(_arg_1:Boolean):void
        {
            this._isNameLoaded = _arg_1;
        }

        public function get isStatusesLoaded():Boolean
        {
            return (this._isStatusesLoaded);
        }

        public function set isStatusesLoaded(_arg_1:Boolean):void
        {
            this._isStatusesLoaded = _arg_1;
        }

        public function get internalName():String
        {
            return (this._internalName);
        }

        public function set internalName(_arg_1:String):void
        {
            this._internalName = _arg_1;
        }

        public function get needDraw():Boolean
        {
            return (this._needDraw);
        }

        public function set needDraw(_arg_1:Boolean):void
        {
            this._needDraw = _arg_1;
        }

        public function get drawShadow():Boolean
        {
            return (this._drawShadow);
        }

        public function set drawShadow(_arg_1:Boolean):void
        {
            this._drawShadow = _arg_1;
        }

        public function get showName():Boolean
        {
            return (this._showName);
        }

        public function set showName(_arg_1:Boolean):void
        {
            this._showName = _arg_1;
        }

        public function get autoHideName():Boolean
        {
            return (this._autoHideName);
        }

        public function set autoHideName(_arg_1:Boolean):void
        {
            this._autoHideName = _arg_1;
        }

        public function get nameColor():int
        {
            return (this._nameColor);
        }

        public function set nameColor(_arg_1:int):void
        {
            this._nameColor = _arg_1;
        }

        public function get allowSelection():Boolean
        {
            return (this._allowSelection);
        }

        public function set allowSelection(_arg_1:Boolean):void
        {
            this._allowSelection = _arg_1;
        }

        public function get intravision():Boolean
        {
            return (this._intravision);
        }

        public function set intravision(_arg_1:Boolean):void
        {
            this._intravision = _arg_1;
        }

        public function get invisible():Boolean
        {
            return (this._invisible);
        }

        public function set invisible(_arg_1:Boolean):void
        {
            this._invisible = _arg_1;
        }

        public function get hided():Boolean
        {
            return (this._hided);
        }

        public function set hided(_arg_1:Boolean):void
        {
            this._hided = _arg_1;
        }

        public function get viewWeapon():int
        {
            return (this._viewWeapon);
        }

        public function set viewWeapon(_arg_1:int):void
        {
            this._viewWeapon = _arg_1;
        }

        public function get viewWeaponId():int
        {
            return (this._viewWeaponId);
        }

        public function set viewWeaponId(_arg_1:int):void
        {
            this._viewWeaponId = _arg_1;
        }

        public function get viewShield():int
        {
            return (this._viewShield);
        }

        public function set viewShield(_arg_1:int):void
        {
            this._viewShield = _arg_1;
        }

        public function get viewShieldId():int
        {
            return (this._viewShieldId);
        }

        public function set viewShieldId(_arg_1:int):void
        {
            this._viewShieldId = _arg_1;
        }

        public function get viewHead():int
        {
            return (this._viewHead);
        }

        public function set viewHead(_arg_1:int):void
        {
            this._viewHead = _arg_1;
        }

        public function set Items(_arg_1:Dictionary):void
        {
            this._items = _arg_1;
        }

        public function get partyName():String
        {
            return (this._partyName);
        }

        public function get guildName():String
        {
            return (this._guildName);
        }

        public function get isAllie():Boolean
        {
            return (this._isAllie);
        }

        public function get guildTitle():String
        {
            return (this._guildTitle);
        }

        public function set partyName(_arg_1:String):void
        {
            this._partyName = _arg_1;
        }

        public function set guildName(_arg_1:String):void
        {
            this._guildName = _arg_1;
        }

        public function set isAllie(_arg_1:Boolean):void
        {
            this._isAllie = _arg_1;
        }

        public function set guildTitle(_arg_1:String):void
        {
            this._guildTitle = _arg_1;
        }

        public function get lastBaseExp():int
        {
            return (this._lastBaseExp);
        }

        public function set lastBaseExp(_arg_1:int):void
        {
            this._lastBaseExp = _arg_1;
        }

        public function get cashPoints():int
        {
            return (this._cashPoints);
        }

        public function set cashPoints(_arg_1:int):void
        {
            if (((_arg_1 >= 0) && (_arg_1 < 10000000)))
            {
                this._cashPoints = _arg_1;
            };
        }

        public function get kafraPoints():int
        {
            return (this._kafraPoints);
        }

        public function set kafraPoints(_arg_1:int):void
        {
            this._kafraPoints = _arg_1;
        }

        public function get isDead():int
        {
            return (this._isDead);
        }

        public function set isDead(_arg_1:int):void
        {
            this._isDead = _arg_1;
        }

        public function get guildEmblem():int
        {
            return (this._guildEmblem);
        }

        public function set guildEmblem(_arg_1:int):void
        {
            this._guildEmblem = _arg_1;
        }

        public function get leftHandRefineLevel():int
        {
            return (this._leftHandRefineLevel);
        }

        public function set leftHandRefineLevel(_arg_1:int):void
        {
            this._leftHandRefineLevel = _arg_1;
        }

        public function get rightHandRefineLevel():int
        {
            return (this._rightHandRefineLevel);
        }

        public function set rightHandRefineLevel(_arg_1:int):void
        {
            this._rightHandRefineLevel = _arg_1;
        }

        public function get lastMoney():int
        {
            return (this._lastMoney);
        }

        public function set lastMoney(_arg_1:int):void
        {
            this._lastMoney = _arg_1;
        }

        public function get lastGold():int
        {
            return (this._lastGold);
        }

        public function set lastGold(_arg_1:int):void
        {
            this._lastGold = _arg_1;
        }


    }
}//package hbm.Engine.Actors

