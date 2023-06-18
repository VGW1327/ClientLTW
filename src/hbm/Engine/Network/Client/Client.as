package hbm.Engine.Network.Client
{
    import flash.events.EventDispatcher;
    import flash.utils.Dictionary;
    import hbm.Engine.Actors.Actors;
    import hbm.Engine.Actors.Guilds;
    import hbm.Engine.Actors.StorageData;
    import hbm.Engine.Actors.CartData;
    import hbm.Engine.Actors.CharacterEquipment2;
    import hbm.Engine.Actors.PartyMember;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Network.TransmissionObject.TransmissionObject;
    import hbm.Engine.Network.Events.ClientEvent;
    import hbm.Engine.Actors.CharacterInfo;
    import flash.utils.ByteArray;
    import flash.utils.Endian;
    import flash.utils.getTimer;
    import hbm.Engine.Network.Events.ClientError;
    import hbm.Game.Statistic.StatisticManager;
    import hbm.Engine.Network.Events.InstanceEvent;
    import hbm.Engine.Network.Events.ChatMessage;
    import hbm.Engine.Network.Events.Cutin2Event;
    import hbm.Engine.Network.Events.DisplayNpcImage;
    import hbm.Engine.Network.Events.Cutin3Event;
    import hbm.Engine.Actors.GuildInfo;
    import hbm.Engine.Network.Events.GuildEvent;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Network.Events.PremiumPackEvent;
    import hbm.Engine.Network.Events.StoreEvent;
    import hbm.Engine.Network.Events.NpcStoreDealEvent;
    import hbm.Engine.Network.Events.TradeEvent;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Network.Events.CharacterEvent;
    import hbm.Engine.Network.Events.StorageEvent;
    import hbm.Engine.Network.Events.NpcTalkEvent;
    import hbm.Engine.Network.Events.PartyEvent;
    import hbm.Engine.Network.Events.ArrowsListEvent;
    import hbm.Engine.Network.Events.ProduceListEvent;
    import hbm.Engine.Network.Events.ProduceResultEvent;
    import hbm.Engine.Network.Events.ActorDisplayEvent;
    import hbm.Engine.Network.Events.ActorStatsEvent;
    import hbm.Engine.Actors.CharacterEquipment;
    import hbm.Engine.Network.Events.ActorViewIdEvent;
    import hbm.Engine.Network.Events.SoundEffectEvent;
    import hbm.Engine.Network.Events.FloorItemEvent;
    import hbm.Engine.Network.Events.SkillPosEffectEvent;
    import hbm.Engine.Network.Events.ItemAddedEvent;
    import hbm.Engine.Network.Events.CartEvent;
    import hbm.Engine.Network.Events.UpgradeResultEvent;
    import hbm.Engine.Network.Events.CraftCardResultEvent;
    import hbm.Engine.Network.Events.ActorChangeStatusEvent;
    import hbm.Engine.Network.Events.RefineResultEvent;
    import hbm.Engine.Network.Events.DurabilityEvent;
    import hbm.Engine.Actors.GuildAllies;
    import hbm.Engine.Network.Events.ActorActiveStatusEvent;
    import hbm.Engine.Actors.SkillData;
    import hbm.Engine.Network.Events.SkillHealEvent;
    import hbm.Engine.Network.Events.SkillCastEvent;
    import hbm.Engine.Network.Events.ActorHpUpdateEvent;
    import hbm.Engine.Network.Events.SkillUseEvent;
    import hbm.Engine.Network.Events.SkillUnitEvent;
    import hbm.Engine.Renderer.Rabbitgedon;
    import hbm.Engine.Network.Events.SkillUnitClearEvent;
    import hbm.Engine.Network.Events.SkillCastNoDamage;
    import hbm.Engine.Network.Events.UpdateCashEvent;
    import hbm.Engine.Network.Events.UpdatePremiumEvent;
    import hbm.Engine.Network.Events.UpdateQuestsEvent;
    import hbm.Engine.Network.Events.GiftItemEvent;
    import hbm.Engine.Network.Events.UpdateRouletteCashEvent;
    import hbm.Engine.Network.Events.CastlesInfoEvent;
    import hbm.Engine.Actors.CastleInfo;
    import hbm.Engine.Network.Events.LaddersInfoEvent;
    import hbm.Engine.Actors.LadderInfo;
    import hbm.Engine.Network.Events.MapOnlineInfoEvent;
    import hbm.Engine.Actors.HotKeys;
    import hbm.Engine.Network.Packet.Coordinates;
    import hbm.Engine.Network.Events.ActorActionEvent;
    import hbm.Engine.Actors.PartyInfo;
    import hbm.Engine.Network.Events.DuelEvent;
    import hbm.Game.Utility.HtmlText;
    import hbm.Engine.Actors.GuildMember;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Engine.Actors.FriendMember;
    import hbm.Engine.Actors.FriendInfo;
    import hbm.Engine.Network.Events.FriendEvent;
    import hbm.Engine.Network.Events.IgnoreEvent;
    import hbm.Engine.Actors.IgnoreInfo;
    import hbm.Engine.Network.Events.PvPModeEvent;
    import hbm.Engine.Network.Events.MailEvent;
    import hbm.Engine.Actors.MailHeaderData;
    import hbm.Engine.Network.Events.AuctionEvent;
    import hbm.Engine.Actors.AuctionLot;
    import hbm.Engine.Network.Events.BuyCahsEvent;
    import hbm.Engine.Network.Events.AccountFriendsEvent;
    import hbm.Engine.Network.Events.FriendVisitEvent;
    import hbm.Engine.Network.Events.FarmEvent;
    import hbm.Engine.Actors.ItemList;
    import flash.events.Event;
    import __AS3__.vec.*;

    public class Client extends EventDispatcher 
    {
        private var _host:String;
        private var _port:int;
        private var _userEmail:String;
        private var _userPassword:String;
        private var _genderSuffix:String = null;
        private var _handlers:Dictionary;
        private var _loginId1:uint;
        private var _loginId2:uint;
        private var _loginAccountId:uint;
        private var _sex_old:int = 1;
        private var _numSlots:uint;
        private var _premiumType:uint;
        private var _premiumUntil:uint;
        private var _hbmVersion:uint;
        private var _charServers:Array;
        private var _characters:Dictionary;
        private var _actors:Actors = new Actors();
        private var _guilds:Guilds = new Guilds();
        private var _storage:StorageData;
        private var _cart:CartData;
        private var _equips:CharacterEquipment2;
        private var _characterNumber:uint;
        private var _charIdToName:Dictionary;
        private var _state:int = 0;
        private var _nextShouldBeAnAccountID:Boolean = false;
        private var _initialSync:Boolean = true;
        private var _mapCharId:int;
        private var _mapName:String;
        private var _mapInstanceId:int;
        private var _mapServerIp:String;
        private var _mapServerPort:int;
        private var _pvpMode:int;
        private var _npcStoreId:int = -1;
        private var _venderId:int = -1;
        private var _partyMember:PartyMember;
        private var _safeTradeAmount:int = -1;

        public function Client()
        {
            this._handlers = new Dictionary(true);
            this._handlers[105] = this.ReceivedAccountServerInfo;//Login_server
            this._handlers[106] = this.ReceivedLoginError;//Login_server
            this._handlers[107] = this.ReceivedCharacters;//Char_server
            this._handlers[108] = this.ReceivedCharacterServerLoginError;//
            this._handlers[109] = this.ReceivedCharacterCreationSuccesful;//Login_Server and Char_Server
            this._handlers[110] = this.ReceivedCharacterCreationFailed;//Login_Server and Char_Server
            this._handlers[113] = this.ReceivedCharacterIDAndMap;//Login_Server and Char_Server
            this._handlers[115] = this.ReceivedMapLoaded;//Login_Server and Char_Server
            this._handlers[120] = this.ReceivedNpcIdleDisplay;//Вызов порталов и НПС... учитываем координаты
            this._handlers[124] = this.ReceivedNpcSpawnDisplay;//
            this._handlers[127] = this.ReceivedSync;//Map_Server некое время
            this._handlers[128] = this.ReceivedActorDisappeared;//Map_Server после выхода из игры убрать данные о персе
            this._handlers[129] = this.ReceivedAccountErrors;//
            this._handlers[134] = this.ReceivedActorDisplayMoves;//
            this._handlers[135] = this.ReceivedPlayerMoves;//
            this._handlers[136] = this.ReceivedActorMovementInterrupted;//
            this._handlers[138] = this.ReceivedActorAction;//
            this._handlers[141] = this.ReceivedPublicMessage;//
            this._handlers[142] = this.ReceivedSelfMessage;//
            this._handlers[145] = this.ReceivedMapChange;//Инстансы.. возможно слив перса
            this._handlers[149] = this.ReceivedActorName;//загрузка ника
            this._handlers[151] = this.ReceivedPrivateMessage;//
            this._handlers[152] = this.ReceivedPrivateMessageStatus;//
            this._handlers[154] = this.ReceivedGmMessage;//
            this._handlers[156] = this.ReceivedActorLookAt;//
            this._handlers[157] = this.ReceivedAreaCharItem;//
            this._handlers[158] = this.ReceivedItemAppeared;//Появился шмот на земле
            this._handlers[160] = this.ReceivedItemAdded;//Получить шмот
            this._handlers[161] = this.ReceivedItemDisappeared;//Пропал шмот на земле
            this._handlers[164] = this.ReceivedInventoryItemsNonStackable;//Шмот в инвентаре(только для оружии и брони)
            this._handlers[166] = this.ReceivedStorageItemsNonStackable;//Шмот в хране(только для оружии и брони)
            this._handlers[168] = this.ReceivedInventoryItemUse;//Неподходящая шмотка, уровень или еще что то
            this._handlers[170] = this.ReceivedInventoryItemEquipped;//Одеть шмот из инвентаря
            this._handlers[172] = this.ReceivedInventoryItemUnEquipped;//Снять шмот с персонажа
            this._handlers[175] = this.ReceivedInventoryItemRemoved;//Удалить убрать шмот
            this._handlers[176] = this.ReceivedStatInfo;//подгрузить статы (обновить статы), логика игры
            this._handlers[177] = this.ReceivedStatInfo;//то же что 176 хандлерс
            this._handlers[179] = this.ReceivedCharSelectOk;//Кнопка сменить персонажа
            this._handlers[180] = this.ReceivedNpcTalk;//
            this._handlers[181] = this.ReceivedNpcTalkContinue;//
            this._handlers[182] = this.ReceivedNpcTalkClose;//
            this._handlers[183] = this.ReceivedNpcTalkResponses;//
            this._handlers[188] = this.ReceivedStatsAdded;//прокачать статы(кнопка +)
            this._handlers[189] = this.ReceivedStatsInitial;//Загрузить статы при входе игры
            this._handlers[190] = this.ReceivedStatsPointsNeeded;//
            this._handlers[192] = this.ReceivedEmotionsOld;//
            this._handlers[196] = this.ReceivedNpcStoreBegin;//
            this._handlers[198] = this.ReceivedNpcStoreBuyList;//
            this._handlers[202] = this.ReceivedBuyStatus;//
            this._handlers[203] = this.ReceivedSellStatus;//
            this._handlers[205] = this.ReceivedGMKickAck;//
            this._handlers[209] = this.ReceivedPMIgnoreResult;//
            this._handlers[210] = this.ReceivedPMIgnoreAllResult;//
            this._handlers[212] = this.ReceivedPMIgnoreList;//
            this._handlers[233] = this.ReceivedTradeAddItem;//
            this._handlers[234] = this.ReceivedTradeItemOk;//
            this._handlers[236] = this.ReceivedTradeDealLock;//
            this._handlers[238] = this.ReceivedTradeCancelled;//
            this._handlers[240] = this.ReceivedTradeCompleted;//
            this._handlers[242] = this.ReceivedStorageOpened;//
            this._handlers[244] = this.ReceivedStorageItemAddedF4;//
            this._handlers[246] = this.ReceivedStorageItemsRemoved;//
            this._handlers[248] = this.ReceivedStorageClosed;//
            this._handlers[250] = this.ReceivedPartyOrganizeResult;//
            this._handlers[251] = this.ReceivedPartyInfo;//
            this._handlers[254] = this.ReceivedPartyInvite;//
            this._handlers[257] = this.ReceivedPartyOptions;//
            this._handlers[261] = this.ReceivedPartyLeave;//
            this._handlers[262] = this.ReceivedPartyHp;//
            this._handlers[263] = this.ReceivedPartyLeaderPosition;//
            this._handlers[265] = this.ReceivedPartyMessage;//
            this._handlers[266] = this.ReceivedMVPItem;//
            this._handlers[267] = this.ReceivedMVPExp;//
            this._handlers[268] = this.ReceivedMVPEffect;//
            this._handlers[270] = this.ReceivedSkillUpdate;//
            this._handlers[271] = this.ReceivedSkillList;//
            this._handlers[272] = this.ReceivedSkillFail;//
            this._handlers[279] = this.ReceivedSkillPosEffect;//
            this._handlers[282] = this.ReceivedSkillUsedNoDamage;//
            this._handlers[284] = this.ReceivedSkillWarpPoint;//
            this._handlers[287] = this.ReceivedSkillUnit;//
            this._handlers[288] = this.ReceivedClearCharSkillUnit;//
            this._handlers[289] = this.ReceivedCartInfo;//
            this._handlers[290] = this.ReceivedCartItemsNonStackable;//
            this._handlers[293] = this.ReceivedCartItemsRemoved;//
            this._handlers[301] = this.ReceivedVendingOpen;//
            this._handlers[305] = this.ReceivedVenderAppeared;//
            this._handlers[306] = this.ReceivedVenderLost;//
            this._handlers[307] = this.ReceivedVenderItemList;//
            this._handlers[309] = this.ReceivedVenderBuyFail;//
            this._handlers[310] = this.ReceivedVendingStarted;//
            this._handlers[311] = this.ReceivedVendingReport;//
            this._handlers[313] = this.ReceivedMoveToAttack;//
            this._handlers[314] = this.ReceivedAttackRange;//
            this._handlers[315] = this.ReceivedAmmunitionEmpty;//
            this._handlers[316] = this.ReceivedArrowEquipped;//
            this._handlers[317] = this.ReceivedSkillHeal;//
            this._handlers[318] = this.ReceivedSkillCasting;//
            this._handlers[321] = this.ReceivedStatInfo2;//
            this._handlers[322] = this.ReceivedScriptInput;//
            this._handlers[328] = this.ReceivedResurrection;//
            this._handlers[330] = this.ReceivedMannerMessage;//
            this._handlers[331] = this.ReceivedGMSilence;//
            this._handlers[332] = this.ReceivedGuildAllianceInfo;//
            this._handlers[334] = this.ReceivedGuildMasterOrNot;//
            this._handlers[338] = this.ReceivedGuildEmblem;//
            this._handlers[340] = this.ReceivedGuildMemberList;//
            this._handlers[342] = this.ReceivedGuildMemberPositionChanged;//
            this._handlers[346] = this.ReceivedGuildLeaveMessage;//
            this._handlers[348] = this.ReceivedGuildKickMessage;//
            this._handlers[354] = this.ReceivedGuildSkillList;//
            this._handlers[358] = this.ReceivedGuildMembersTitleList;//
            this._handlers[359] = this.ReceivedGuildCreationStatus;//
            this._handlers[361] = this.ReceivedGuildInviteAck;//
            this._handlers[362] = this.ReceivedGuildRequest;//
            this._handlers[364] = this.ReceivedGuildName;//
            this._handlers[365] = this.ReceivedGuildMemberLogin;//
            this._handlers[367] = this.ReceivedGuildNotice;//
            this._handlers[369] = this.ReceivedGuildAllyRequest;//
            this._handlers[371] = this.ReceivedGuildAllyReply;//
            this._handlers[372] = this.ReceivedGuildRankChanged;//
            this._handlers[375] = this.ReceivedIdentifyList;//
            this._handlers[377] = this.ReceivedItemIdentified;//
            this._handlers[381] = this.ReceivedInsertCardResult;//
            this._handlers[383] = this.ReceivedGuildChat;//
            this._handlers[388] = this.ReceivedGuildAllyBreaked;//
            this._handlers[392] = this.ReceivedItemUpdate;//
            this._handlers[395] = this.ReceivedQuitGame;//
            this._handlers[397] = this.ReceivedSkillProduceCreateList;//
            this._handlers[399] = this.ReceivedSkillProduceEffect;//
            this._handlers[402] = this.ReceivedChangeMapCell;//
            this._handlers[404] = this.ReceivedSolvedActorName;//
            this._handlers[405] = this.ReceivedActorNameUpdate;//
            this._handlers[406] = this.ReceivedActorStatusActive;//
            this._handlers[409] = this.ReceivedPvpMode;//
            this._handlers[410] = this.ReceivedPvpRank;//
            this._handlers[411] = this.ReceivedMiscEffect;//
            this._handlers[418] = this.ReceivedPetStatus;//
            this._handlers[419] = this.ReceivedPetFood;//
            this._handlers[420] = this.ReceivedPetData;//
            this._handlers[422] = this.ReceivedPetList;//
            this._handlers[426] = this.ReceivedPetEmotion;//
            this._handlers[427] = this.ReceivedActorsManners;//
            this._handlers[428] = this.ReceivedSetupTrap;//
            this._handlers[429] = this.ReceivedArrowCreateList;//
            this._handlers[435] = this.ReceivedDisplayNpcImage;//
            this._handlers[436] = this.ReceivedGuildEmblemArea;//
            this._handlers[438] = this.ReceivedGuildInfo;//
            this._handlers[441] = this.ReceivedCastCanceled;//
            this._handlers[451] = this.ReceivedLocalBroadcast;//
            this._handlers[452] = this.ReceivedStorageItemAdded;//
            this._handlers[453] = this.ReceivedCartItemAdded;//
            this._handlers[456] = this.ReceivedActorItemUsed;//
            this._handlers[457] = this.ReceivedGraffiti;//
            this._handlers[463] = this.ReceivedDevotion;//
            this._handlers[467] = this.ReceivedSoundEffect;//
            this._handlers[468] = this.ReceivedNpcInputRequest;//
            this._handlers[471] = this.ReceivedPlayerEquipment;//
            this._handlers[478] = this.ReceivedSkillUse;//
            this._handlers[489] = this.ReceivedPartyMemberInfo;//
            this._handlers[491] = this.ReceivedGuildLocator;//
            this._handlers[494] = this.ReceivedInventoryItemsStackable;//прочее и использемые в инвентаре
            this._handlers[495] = this.ReceivedCartItemsStackable;//
            this._handlers[496] = this.ReceivedStorageItemsStackable;//прочее и используемые в хране
            this._handlers[499] = this.ReceivedEffect;//
            this._handlers[500] = this.ReceivedTradeRequest;//
            this._handlers[501] = this.ReceivedTradeStartReply;//
            this._handlers[511] = this.ReceivedSlide;//
            this._handlers[513] = this.ReceivedFriendsList;//
            this._handlers[518] = this.ReceivedFriendOnline;//
            this._handlers[519] = this.ReceivedFriendAddRequest;//
            this._handlers[521] = this.ReceivedFriendRequestAck;//
            this._handlers[522] = this.ReceivedFriendRemoved;//
            this._handlers[528] = this.ReceivedPVPInfo;//
            this._handlers[547] = this.ReceivedWeaponUpgrade;//
            this._handlers[553] = this.ReceivedActorChangeStatus;//
            this._handlers[554] = this.ReceivedActorIdleDisplay;//
            this._handlers[555] = this.ReceivedActorSpawnDisplay;//
            this._handlers[556] = this.ReceivedActorWalkingDisplay;//
            this._handlers[576] = this.ReceivedMailInboxData;//
            this._handlers[578] = this.ReceivedMailMessageBody;//
            this._handlers[581] = this.ReceivedMailAttachmentResult;//
            this._handlers[585] = this.ReceivedMailSendAck;//
            this._handlers[586] = this.ReceivedMailNew;//
            this._handlers[592] = this.ReceivedAuctionMessage;//
            this._handlers[594] = this.ReceivedAuctionResults;//
            this._handlers[597] = this.ReceivedMailAttachment;//
            this._handlers[598] = this.ReceivedAuctionSetItemAck;//
            this._handlers[599] = this.ReceivedMailDeleteResult;//
            this._handlers[608] = this.ReceivedMailWindow;//
            this._handlers[628] = this.ReceivedMailReturn;//
            this._handlers[643] = this.ReceivedMapLoginAccepted;//
            this._handlers[647] = this.ReceivedCashshopOpened;//
            this._handlers[649] = this.ReceivedCashshopOperation;//
            this._handlers[654] = this.ReceivedCharRenameResult;//
            this._handlers[656] = this.ReceivedCharRenameConfirmResult;//
            this._handlers[697] = this.ReceivedHotKeys;//
            this._handlers[709] = this.ReceivedPartyInvitationResult;//
            this._handlers[730] = this.ReceivedEquipCheckBox;//
            this._handlers[727] = this.ReceivedViewPlayerEquip;//
            this._handlers[729] = this.ReceivedEquipTickAck;//
            this._handlers[657] = this.ReceivedViewPlayerEquipFail;//
            this._handlers[1024] = this.ReceivedUpdateCash;//
            this._handlers[1025] = this.ReceivedUpdateQuests;//
            this._handlers[1026] = this.ReceivedGift;//
            this._handlers[1027] = this.ReceivedRouletteResult;//
            this._handlers[1028] = this.ReceivedActorHpUpdate;//
            this._handlers[1029] = this.ReceivedRefineResponse;//
            this._handlers[1031] = this.ReceivedCastlesInfo;//
            this._handlers[1035] = this.ReceivedMapOnlineInfo;//Инфо об онлайне в картах
            this._handlers[1038] = this.ReceivedSoulShotEquipped;//
            this._handlers[1040] = this.ReceivedRemoveCardResult;//
            this._handlers[1043] = this.ReceivedCraftCardResult;//
            this._handlers[1050] = this.ReceivedLaddersInfo;//
            this._handlers[1057] = this.ReceivedDuelInvite;//
            this._handlers[1059] = this.ReceivedTimeSync;//
            this._handlers[1060] = this.ReceivedSkillMatrix;//
            this._handlers[1066] = this.ReceivedGuildAnnounce;//
            this._handlers[1068] = this.ReceivedCastlesInfoEx;
            this._handlers[1069] = this.ReceivedCutin2;//Картинку добро пожаловать, Запуск и скрыти Герой дня, Открыть прилавок, Открыть новости.
            this._handlers[1071] = this.ReceivedPremiumPackItem;//
            this._handlers[1073] = this.ReceivedEmotions;//
            this._handlers[1074] = this.ReceivedCutin3;//...
            this._handlers[1076] = this.ReceivedGuildList;//
            this._handlers[1077] = this.ReceivedUpdatePremium;//
            this._handlers[1082] = this.ReceivedSelfMessage2;//
            this._handlers[1083] = this.ReceivedTradeItemCancel;//
            this._handlers[1085] = this.ReceivedTradeDeleteItem;//
            this._handlers[1088] = this.ReceivedInstanceJoin;//
            this._handlers[1089] = this.ReceivedInstanceTimeout;//
            this._handlers[1090] = this.ReceivedInstanceError;//
            this._handlers[1091] = this.ReceivedInstanceLeave;//
            this._handlers[1094] = this.ReceivedBuyZenyList;//
            this._handlers[1097] = this.ReceivedAccountFriendsList;//
            this._handlers[1106] = this.ReceivedVisitFriend;//
            this._handlers[1108] = this.ReceivedCustomFarmList;//
            this._handlers[1110] = this.ReceivedUpdateCustomFarm;//
            this._handlers[1112] = this.ReceivedPremiumshopOperation;//
            this._handlers[1114] = this.ReceivedPremiumshopOpened;//
            this._handlers[1117] = this.ReceivedItemDurability;//
            this._handlers[1119] = this.ReceivedRepairList;//
            this._handlers[1122] = this.ReceivedRepairTotalPrice;//
            this.SubscribeEvents();
        }

        public function get CurrentCharId():int
        {
            return _mapCharId;
        }

        public function get CurrentLoginId():uint
        {
            return _loginAccountId;
        }

        public function get ActorList():Actors
        {
            return _actors;
        }

        public function get NumCharactersSlots():uint
        {
            return _numSlots;
        }

        public function get PremiumType():uint
        {
            if (_premiumType == 0)
                return 0;
            else if ((_premiumUntil * 1000) > new Date().getTime())
                return _premiumType;
            return _premiumType;
        }

        public function get PremiumUntil():uint
        {
            return _premiumUntil;
        }

        public function get PremiumUntilStr():String
        {
            var time_1:int = _premiumUntil - int(new Date().getTime() / 1000);
			var _local_3:int = int(time_1 / 3600);
            if (time_1 <= 0)
            {
                return ClientApplication.Localization.PREMIUM_UNTIL_VALUE_NOTHING;//нет
            }
            else if (_local_3 <= 24)
            {
                return _local_3 + " " + ClientApplication.Localization.TIME_HOURS;//ч.
            }
            return Math.ceil(_local_3 / 24) + " " + ClientApplication.Localization.TIME_DAYS;//д.
        }

        public function get ServerVersion():uint
        {
            return _hbmVersion;
        }

        public function get State():int
        {
            return _state;
        }

        public function get Equips():CharacterEquipment2
        {
            if (_equips == null)
            {
                _equips = new CharacterEquipment2();
            }
            return _equips;
        }

        public function set Equips(_arg_1:CharacterEquipment2):void
        {
            _equips = _arg_1;
        }

        public function get Storage():StorageData
        {
            if (_storage == null)
            {
                _storage = new StorageData();
            }
            return _storage;
        }

        public function set Storage(_arg_1:StorageData):void
        {
            _storage = _arg_1;
        }

        public function get Cart():CartData
        {
            return _cart;
        }

        public function set Cart(_arg_1:CartData):void
        {
            _cart = _arg_1;
        }

        public function get VenderId():int
        {
            return _venderId;
        }

        public function get CharactersList():Dictionary
        {
            return _characters;
        }

        public function get CharIdToNameList():Dictionary
        {
            if (_charIdToName == null)
            {
                _charIdToName = new Dictionary(true);
            };
            return _charIdToName;
        }

        private function SocketConnect(_arg_1:String, _arg_2:int):int
        {
            this._host = _arg_1;
            this._port = _arg_2;
            TransmissionObject.Instance.Connect(this._host, this._port);
            return 0;
			trace("SocketConnect= " + _arg_1, _arg_2);
        }

        public function Disconnect():void
        {
            TransmissionObject.Instance.Close();
        }

        public function ResetState():void
        {
            _state = ClientState.CONNECTED_TO_ACCOUNT;
        }

        private function SubscribeEvents():void
        {
			trace("SubscribeEvents");
            TransmissionObject.Instance.addEventListener(TransmissionObject.ON_CONNECTED, OnConnectedHandler);
            TransmissionObject.Instance.addEventListener(TransmissionObject.ON_DATAREADY, OnDataReadyHandler);
        }

        private function UnsubscribeEvents():void
        {
			trace("UnsubscribeEvents");
            TransmissionObject.Instance.removeEventListener(TransmissionObject.ON_CONNECTED, OnConnectedHandler);
            TransmissionObject.Instance.removeEventListener(TransmissionObject.ON_DATAREADY, OnDataReadyHandler);
        }

        public function ConnectLoginServer(_arg_1:String, _arg_2:String, _arg_3:String, _arg_4:int):int
        {
			trace("ConnectLoginServer: UserEmail=" + _arg_1 + " UserPassword=" + _arg_2 + " _state=" + ClientState.CONNECTED_TO_ACCOUNT + " SocketConnect=" + _arg_3 + ":" + _arg_4);
            this._state = ClientState.CONNECTED_TO_ACCOUNT;
            this.UserEmail = _arg_1;
            this.UserPassword = _arg_2;
            return (this.SocketConnect(_arg_3, _arg_4));
        }

        public function CreateAccount(_arg_1:String):int
        {
			trace("CreateAccount");
            this._genderSuffix = _arg_1;
            return (this.SocketConnect(this._host, this._port));
			trace("CreateAccount = genderSuffix: " + _arg_1);
			trace("CreateAccount = SocketConnect: " + this.SocketConnect(this._host, this._port));
        }

        public function ConnectCharServer():int
        {
			trace("ConnectCharServer");
            var _local_1:CharServerInfo = (this._charServers[0] as CharServerInfo);
            this._state = ClientState.CONNECTED_TO_CHARSERVER;
            return (this.SocketConnect(_local_1.ipAddress, _local_1.port));
        }

        public function ConnectMapServer():int
        {
			trace("ConnectMapServer");
            this._state = ClientState.CONNECTED_TO_MAPSERVER;
            return (this.SocketConnect(this._mapServerIp, this._mapServerPort));
        }

        private function ReceivedCharacterIDAndMap():Boolean
        {
			trace("ReceivedCharacterIDAndMap");
            var _local_1:int;
            this._mapCharId = TransmissionObject.Instance.ReadInt32();
            this._mapName = TransmissionObject.Instance.ReadString(16);
            if ((_local_1 = this._mapName.indexOf("#")) > 0)
            {
                this._mapInstanceId = int(this._mapName.substring(0, _local_1));
                this._mapName = this._mapName.substr((_local_1 + 1));
            }
            else
            {
                this._mapInstanceId = 0;
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt8();
            var _local_3:int = TransmissionObject.Instance.ReadUInt8();
            var _local_4:int = TransmissionObject.Instance.ReadUInt8();
            var _local_5:int = TransmissionObject.Instance.ReadUInt8();
            this._mapServerPort = TransmissionObject.Instance.ReadInt16();
            this._mapServerIp = ((((((_local_2 + ".") + _local_3) + ".") + _local_4) + ".") + _local_5);
            this._state = ClientState.CONNECTING_TO_MAPSERVER;
            dispatchEvent(new ClientEvent(ClientEvent.ON_MAPSERVER_INVITATION));
            return (true);
        }

        private function ReceivedMapLoginAccepted():Boolean
        {
			trace("ReceivedMapLoginAccepted");
            if (TransmissionObject.Instance.BytesAvailable < 4)
            {
                return (false);
            };
            var _local_1:uint = TransmissionObject.Instance.ReadUInt32();
			trace("ReceivedMapLoginAccepted_local_1: " + _local_1);
            var _local_2:CharacterInfo = (this._characters[this._characterNumber] as CharacterInfo);
            _local_2.characterId = _local_1;
            this._actors.AddActor(_local_1, _local_2);
            this._actors.playerID = _local_1;
            this._state = ClientState.LOGGED_ON_MAPSERVER;
            return (true);
        }

        private function SendGameLogin():void
        {
			trace("SendGameLogin");
            TransmissionObject.Instance.WriteUInt16(101);
            TransmissionObject.Instance.WriteUInt32(this._loginAccountId);
            TransmissionObject.Instance.WriteUInt32(this._loginId1);
            TransmissionObject.Instance.WriteUInt32(this._loginId2);
            TransmissionObject.Instance.WriteUInt16(0);
            TransmissionObject.Instance.WriteUInt8(this._sex_old);
			trace("SendGameLogin: " + this._loginAccountId + this._loginId1 + this._loginId2 + this._sex_old);
            TransmissionObject.Instance.Flush();
            this._nextShouldBeAnAccountID = true;
        }

        public function SendCharLogin(_arg_1:uint):void
        {
			trace("SendCharLogin");
            this._state = ClientState.CHARACTER_CHOOSED;
            this._characterNumber = _arg_1;
            var _local_2:CharacterInfo = (this._characters[this._characterNumber] as CharacterInfo);
            TransmissionObject.Instance.WriteUInt16(102);
            TransmissionObject.Instance.WriteUInt8(_local_2.slot);
            TransmissionObject.Instance.Flush();
        }

        private function SendAccountServerLogin():void
        {
			trace("SendAccountServerLogin");
            var _local_1:ByteArray = new ByteArray();
            _local_1.endian = Endian.LITTLE_ENDIAN;
            var _local_2:int;
            while (_local_2 < 55)
            {
                _local_1.writeByte(0);
                _local_2++;
            };
            _local_1.position = 0;
            _local_1.writeShort(100);// вот та сотка(в пакете первая)
            _local_1.writeInt(20);// двасатка (для чего хз.. мб проверка)
            var _local_3:String = this._userEmail; 
            if (this._genderSuffix)
            {
                _local_3 = (_local_3 + this._genderSuffix);
            };
            _local_1.writeUTFBytes(_local_3); // E-mail
            _local_1.position = 30;
            _local_1.writeUTFBytes(this._userPassword); // Пароль
            _local_1.position = 55;
            _local_1.writeByte(0);
			trace("SendAccountServerLogin=" + _local_1);
            TransmissionObject.Instance.WriteBytes(_local_1);
            TransmissionObject.Instance.Flush();
        }

        private function SendMapLogin():void
        {
			trace("SendMapLogin");
            TransmissionObject.Instance.WriteUInt16(245);
            TransmissionObject.Instance.WriteUInt8(0xFF);
            TransmissionObject.Instance.WriteUInt8(0xFF);
            TransmissionObject.Instance.WriteUInt8(0xFF);
            TransmissionObject.Instance.WriteUInt32(this._loginAccountId);
            TransmissionObject.Instance.WriteUInt8(ClientApplication.languageId);
            TransmissionObject.Instance.WriteUInt8(0xFF);
            TransmissionObject.Instance.WriteUInt8(0xFF);
            TransmissionObject.Instance.WriteUInt8(0xFF);
            TransmissionObject.Instance.WriteUInt8(0xFF);
            TransmissionObject.Instance.WriteUInt32(this._mapCharId);
            TransmissionObject.Instance.WriteUInt8(0xFF);
            TransmissionObject.Instance.WriteUInt8(0xFF);
            TransmissionObject.Instance.WriteUInt32(this._loginId1);
            TransmissionObject.Instance.WriteUInt32(getTimer());
            TransmissionObject.Instance.WriteUInt8(this._sex_old);
            TransmissionObject.Instance.Flush();
        }

        public function SendMapLoaded():void
        {
			trace("SendMapLoaded");
            this._state = ClientState.LOADED_MAP;
            TransmissionObject.Instance.WriteUInt16(125);
            TransmissionObject.Instance.Flush();
        }

        private function ReceivedAccountErrors():Boolean
        {
            var _local_2:String;
            var _local_5:ClientEvent;
            var _local_1:uint = TransmissionObject.Instance.ReadUInt8();
            var _local_3:Boolean = true;
            switch (_local_1)
            {
                case 1:
                    _local_2 = ClientApplication.Localization.ERR_SERVER_CLOSED;
                    break;
                case 2:
                    _local_2 = ClientApplication.Localization.ERR_CHARACTER_OTHER_LOGIN;
                    _local_3 = false;
                    break;
                case 8:
                    _local_2 = ClientApplication.Localization.ERR_CHARACTER_ALLREADY_IN_GAME;
                    _local_3 = false;
                    break;
                case 15:
                    _local_5 = new ClientEvent(ClientEvent.ON_PLAYER_DETACHED);
                    _local_5.flag = 0;
                    dispatchEvent(_local_5);
                    return (true);
                default:
                    _local_2 = ((ClientApplication.Localization.ERR_SERVER_ERROR + " ") + _local_1);
            };
            TransmissionObject.Instance.Close();
            var _local_4:ClientError = new ClientError(_local_2, 0, _local_3);
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedLoginError():Boolean
        {
			trace("ReceivedLoginError");
            var _local_1:int = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 21)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt8();
            var _local_3:String = TransmissionObject.Instance.ReadString(20);
            var _local_4:* = "";
            var _local_5:ClientError;
            switch (_local_2)
            {
                case 0:
                    _local_4 = (_local_4 + ClientApplication.Localization.ERR_ACCOUNT_NOT_EXIST);
                    dispatchEvent(new ClientEvent(ClientEvent.ON_ACCOUNT_DOESNT_EXIST));
                    break;
                case 1:
                    dispatchEvent(new ClientEvent(ClientEvent.ON_PASSWORD_ERROR));
                    break;
                case 3:
                    _local_4 = (_local_4 + ClientApplication.Localization.ERR_PACKET_ERROR);
                    _local_5 = new ClientError(_local_4, this._state);
                    break;
                case 4:
                    _local_4 = (_local_4 + ClientApplication.Localization.ERR_ACCOUNT_BLOCKED);
                    _local_5 = new ClientError(_local_4, this._state);
                    break;
                case 5:
                    _local_4 = (_local_4 + ClientApplication.Localization.ERR_VERSION_MISMATCH);
                    _local_5 = new ClientError(_local_4, this._state);
                    break;
                case 6:
                    _local_4 = (_local_4 + ((ClientApplication.Localization.ERR_ACCOUNT_BLOCKED + " ") + _local_3));
                    _local_5 = new ClientError(_local_4, this._state);
                    break;
                default:
                    _local_4 = (_local_4 + (ClientApplication.Localization.ERR_REASON + _local_2));
                    _local_5 = new ClientError(_local_4, this._state);
            };
            if (_local_5)
            {
                dispatchEvent(_local_5);
            };
            return (true);
        }

        private function ReceivedCharacterServerLoginError():Boolean
        {
			trace("ReceivedCharacterServerLoginError: ERRORS");
            var _local_1:ClientError = new ClientError(ClientApplication.Localization.ERR_SERVER_CLOSED);
            dispatchEvent(_local_1);
            return (true);
        }

        private function ReceivedCharacterCreationFailed():Boolean
        {
			trace("ReceivedCharacterCreationFailed");
            var _local_3:String;
            var _local_1:int = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt8();
			trace("ReceivedCharacterCreationFailed_local_2 = " + _local_2);
            switch (_local_2)
            {
                case 0:
                    _local_3 = "The name you chose already exists.";
                    this._state = ClientState.CONNECTED_TO_ACCOUNT;
                    dispatchEvent(new ClientEvent(ClientEvent.ON_CHARACTER_NAME_DUPLICATE));
                    break;
                case 0xFF:
                    _local_3 = "Char creation denied.";
                    dispatchEvent(new ClientEvent(ClientEvent.ON_CHARACTER_NAME_DENIED));
                    break;
                case 1:
                    _local_3 = "You're underaged.";
                    break;
                case 2:
                    dispatchEvent(new ClientEvent(ClientEvent.ON_CHARACTER_CHECK_NAME_FAILED));
                    break;
                case 3:
                    dispatchEvent(new ClientEvent(ClientEvent.ON_CHARACTER_CHECK_NAME_SUCCESSFUL));
                    break;
                default:
                    _local_3 = ("The reason was: " + _local_2);
            };
            return (true);
        }

        private function ReceivedAccountServerInfo():Boolean
        {
			trace("ReceivedAccountServerInfo");
            var _local_6:CharServerInfo;
            var _local_7:Boolean;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            var _local_2:uint = (TransmissionObject.Instance.ReadUInt16() - 2);
            if (_local_1 < _local_2)
            {
                return (false);
            };
            var _local_3:* = (this._loginAccountId < 1);
            var _local_4:int = int(((_local_2 - 45) / 32));
            this._loginId1 = TransmissionObject.Instance.ReadUInt32();
            this._loginAccountId = TransmissionObject.Instance.ReadUInt32();
            this._loginId2 = TransmissionObject.Instance.ReadUInt32();
            this._numSlots = TransmissionObject.Instance.ReadUInt8();
            this._premiumType = TransmissionObject.Instance.ReadUInt8();
            this._premiumUntil = TransmissionObject.Instance.ReadUInt32();
            if (this._numSlots == 0)
            {
                this._numSlots = 2;
            };
            this._hbmVersion = TransmissionObject.Instance.ReadUInt32();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 20);
            this._sex_old = TransmissionObject.Instance.ReadUInt8();
            this._charServers = new Array();
            var _local_5:int;
            while (_local_5 < _local_4)
            {
                _local_6 = new CharServerInfo();
                _local_7 = _local_6.ReadFromStream();
                if (_local_7)
                {
                    this._charServers.push(_local_6);
                };
                _local_5++;
            };
            this._state = ClientState.CONNECTING_TO_CHARSERVER;
            if (_local_3)
            {
                StatisticManager.Instance.UserID = this._loginAccountId.toString();
                StatisticManager.Instance.VisitApplication();
            };
            dispatchEvent(new ClientEvent(ClientEvent.ON_CHARSERVER_INVITATION));
            return (true);
        }

        private function ReceivedCharacters():Boolean
        {
			trace("ReceivedCharacters");
            var _local_3:uint;
            var _local_4:ByteArray;
            var _local_5:int;
            var _local_6:int;
            var _local_7:CharacterInfo;
            var _local_8:Boolean;
            var _local_1:int = TransmissionObject.Instance.BytesAvailable;
			trace("ReceivedCharacters_local_1: " + _local_1);
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:int = (TransmissionObject.Instance.ReadInt16() - 4);
			trace("ReceivedCharacters_local_2: " + _local_2);
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < _local_2)
            {
                return (false);
            };
            if (_local_1 == 20)
            {
                _local_3 = TransmissionObject.Instance.BufferPosition;
                _local_4 = new ByteArray();
                TransmissionObject.Instance.ReadBytes(_local_4);
                TransmissionObject.Instance.BufferPosition = _local_3;
                TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 20);
                dispatchEvent(new ClientEvent(ClientEvent.ON_CHARACTERS_DOSENT_EXIST));
            }
            else
            {
                TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 20);
				trace("ReceivedCharacters_local_1: " + _local_1);
                _local_5 = int(((_local_1 - 20) / 108));
				trace("ReceivedCharacters_local_5: " + _local_5);
                if (this._characters == null)
                {
                    this._characters = new Dictionary(true);
                };
                _local_6 = 0;
                while (_local_6 < _local_5)
                {
                    _local_7 = new CharacterInfo();
                    _local_8 = _local_7.ReadFromStream();
                    if (_local_8)
                    {
                        this._characters[_local_7.slot] = _local_7;
                    };
                    _local_6++;
                };
                this._state = ClientState.CHOOSING_CHARACTER;
                dispatchEvent(new ClientEvent(ClientEvent.ON_CHARACTERS_RECEIVED));
            };
            return (true);
        }

        private function ReceivedCharacterCreationSuccesful():Boolean
        {
			trace("ReceivedCharacterCreationSuccesful");
            var _local_1:CharacterInfo;
            var _local_3:ClientEvent;
            _local_1 = new CharacterInfo();
            var _local_2:Boolean = _local_1.ReadFromStream();
            if (this._characters == null)
            {
                this._characters = new Dictionary(true);
            };
            if (_local_2)
            {
                this._characters[_local_1.slot] = _local_1;
                this._state = ClientState.CHARACTER_CHOOSED;
                _local_3 = new ClientEvent(ClientEvent.ON_CHARACTER_CREATION_SUCCESSFUL);
                _local_3.slot = _local_1.slot;
                dispatchEvent(_local_3);
            };
            return (_local_2);
        }

        private function ReceivedMapLoaded():Boolean
        {
			trace("ReceivedMapLoaded");
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
			trace("ReceivedMapLoaded_local_1: " + _local_1);
            if (_local_1 < 9)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt32();
			trace("ReceivedMapLoaded_local_2: " + _local_2);
            var _local_3:ByteArray = new ByteArray();
            TransmissionObject.Instance.ReadBytes(_local_3, 0, 3);
            TransmissionObject.Instance.ReadUInt16();
            var _local_4:CharacterInfo = this._actors.GetPlayer();
            _local_4.coordinates.SetEncoded3(_local_3);
            _local_4.coordinates.isNeedFindPath = false;
            this._state = ClientState.LOADING_MAP;
            dispatchEvent(new ClientEvent(ClientEvent.ON_ENTERED_MAP));
            return (true);
        }

        private function ReceivedMapChange():Boolean //Интансы.. возможно слив перса
        {
			trace("ReceivedMapChange");
            var _local_3:int;
            var _local_6:CharacterInfo;
            var _local_7:int;
            var _local_8:InstanceEvent;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
			trace("ReceivedMapChange_local_1: " + _local_1);
            if (_local_1 < 20)
            {
                return (false);
            };
            var _local_2:String = TransmissionObject.Instance.ReadString(16);
			trace("ReceivedMapChange_local_2: " + _local_2);
            var _local_4:int;
            if ((_local_3 = _local_2.indexOf("#")) > 0)
            {
                _local_4 = int(_local_2.substring(0, _local_3));
                _local_2 = _local_2.substr((_local_3 + 1));
            };
            var _local_5:CharacterInfo = this.ActorList.GetPlayer();
            _local_5.coordinates.x = TransmissionObject.Instance.ReadInt16();
			trace("ReceivedMapChange_local_5.coordinates.x: " + _local_5.coordinates.x);
            _local_5.coordinates.y = TransmissionObject.Instance.ReadInt16();
			trace("ReceivedMapChange_local_5.coordinates.y: " + _local_5.coordinates.y);
            _local_5.coordinates.x1 = _local_5.coordinates.x;
            _local_5.coordinates.y1 = _local_5.coordinates.y;
            _local_5.coordinates.isNeedFindPath = true;
            if (this._mapName != _local_2)
            {
                for each (_local_6 in this._actors.actors)
                {
                    if (_local_6 != null)
                    {
                        if (_local_6.characterId != _local_5.characterId)
                        {
                            _local_7 = _local_6.characterId;
                            this.ActorList.RemoveActor(_local_7);
                        };
                    };
                };
                this._mapName = _local_2;
                this._state = ClientState.LOADING_MAP;
                _local_5.Reset();
                this.Cart = null;
                this.Storage = null;
                dispatchEvent(new ClientEvent(ClientEvent.ON_ENTERED_MAP));
            }
            else
            {
                if (this._mapInstanceId != _local_4)
                {
                    this._mapInstanceId = _local_4;
                    _local_8 = new InstanceEvent(InstanceEvent.ON_INSTANCE_UPDATE_MAP);
                    _local_8.Flag = this._mapInstanceId;
                    dispatchEvent(_local_8);
                };
                this.SendMapLoaded();
                if (((_local_5.maxHp == 1) && (_local_5.hp == 0)))
                {
                    _local_5.hp = 1;
                };
                dispatchEvent(new ClientEvent(ClientEvent.ON_PLAYER_RESPAWNED));
            };
            return (true);
        }

        private function ReceivedSelfMessage():Boolean
        {
            var _local_3:String;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = (TransmissionObject.Instance.ReadUInt16() - 4);
            if (TransmissionObject.Instance.BytesAvailable < _local_2)
            {
                return (false);
            };
            _local_3 = TransmissionObject.Instance.ReadString(_local_2);
            var _local_4:ChatMessage = new ChatMessage( -1, this.ActorList.GetPlayer().baseLevel, this.PremiumType, this.ActorList.GetPlayer().characterId, ChatMessage.ON_PUBLIC_MESSAGE, _local_3);
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedSelfMessage2():Boolean
        {
            var _local_4:String;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = (TransmissionObject.Instance.ReadUInt16() - 4);
            if (TransmissionObject.Instance.BytesAvailable < _local_2)
            {
                return (false);
            };
            var _local_3:int = TransmissionObject.Instance.ReadUInt8();
            _local_4 = TransmissionObject.Instance.ReadString(_local_2);
            var _local_5:ChatMessage = new ChatMessage(-1, this.ActorList.GetPlayer().baseLevel, this.PremiumType, this.ActorList.GetPlayer().characterId, ChatMessage.ON_PUBLIC_MESSAGE, _local_4);
            _local_5.IsGM = (_local_3 > 0);
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedDisplayNpcImage():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 64)
            {
                return (false);
            };
            var _local_2:String = TransmissionObject.Instance.ReadString(64);
            var _local_3:int = TransmissionObject.Instance.ReadUInt8();
            var _local_4:* = "";
            switch (_local_3)
            {
                case DisplayNpcImage.SHOW_NPC_IMAGE:
                    dispatchEvent(new Cutin2Event(Cutin2Event.ON_CUTIN2_COMMAND, 0));
                    return (true);
                case DisplayNpcImage.HIDE_NPC_IMAGE:
                    _local_4 = DisplayNpcImage.ON_HIDE_NPC_IMAGE;
                    break;
                case DisplayNpcImage.HIDE_AND_CLEAN_NPC_IMAGE:
                    _local_4 = DisplayNpcImage.ON_HIDE_AND_CLEAN_NPC_IMAGE;
                    this.SendUpdateQuests();
                    break;
                default:
                    _local_4 = "NPC_IMAGE";
            };
            var _local_5:DisplayNpcImage = new DisplayNpcImage(_local_4, _local_2);
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedCutin2():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            if (_local_2 < 0)
            {
                return (true);
            };
            var _local_3:Cutin2Event = new Cutin2Event(Cutin2Event.ON_CUTIN2_COMMAND, _local_2);
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedCutin3():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 66)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            var _local_3:String = TransmissionObject.Instance.ReadString(64);
            if (_local_2 < 0)
            {
                return (true);
            };
            var _local_4:Cutin3Event = new Cutin3Event(Cutin3Event.ON_CUTIN3_COMMAND, _local_2, _local_3);
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedGuildList():Boolean
        {
            var _local_8:GuildInfo;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = (TransmissionObject.Instance.ReadUInt16() - 4);
            if (_local_2 > _local_1)
            {
                return (false);
            };
            var _local_3:uint = TransmissionObject.Instance.ReadUInt32();
            var _local_4:uint = TransmissionObject.Instance.ReadUInt32();
            var _local_5:Array = new Array();
            var _local_6:int;
            while (_local_6 < _local_4)
            {
                _local_8 = new GuildInfo();
                _local_8.Id = TransmissionObject.Instance.ReadUInt32();
                _local_8.Lv = TransmissionObject.Instance.ReadUInt16();
                _local_8.MembersConnected = TransmissionObject.Instance.ReadUInt32();
                _local_8.MaxMembers = TransmissionObject.Instance.ReadUInt32();
                _local_8.Exp = TransmissionObject.Instance.ReadUInt32();
                _local_8.Emblem = TransmissionObject.Instance.ReadUInt32();
                _local_8.Name = TransmissionObject.Instance.ReadString(24);
                _local_8.MasterName = TransmissionObject.Instance.ReadString(24);
                _local_5.push(_local_8);
                _local_6++;
            };
            var _local_7:GuildEvent = new GuildEvent(GuildEvent.ON_GUILD_LIST);
            _local_7.GuildList = _local_5;
            _local_7.Pages = _local_3;
            return (true);
        }

        private function ReceivedPremiumPackItem():Boolean
        {
            var _local_8:ItemData;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 5)
            {
                return (false);
            };
            var _local_2:int = (TransmissionObject.Instance.ReadUInt16() - 4);
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < _local_2)
            {
                return (false);
            };
            var _local_3:int = TransmissionObject.Instance.ReadInt8();
            var _local_4:int = int(((_local_2 - 1) / 4));
            var _local_5:Array = new Array();
            var _local_6:int;
            while (_local_6 < _local_4)
            {
                _local_8 = new ItemData();
                _local_8.Id = _local_6;
                _local_8.NameId = TransmissionObject.Instance.ReadUInt16();
                _local_8.Amount = TransmissionObject.Instance.ReadUInt16();
                _local_8.Identified = 1;
                _local_8.Origin = ItemData.QUEST;
                _local_8.Cards = new <int>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
                _local_5.push(_local_8);
                _local_6++;
            };
            var _local_7:PremiumPackEvent = new PremiumPackEvent(PremiumPackEvent.ON_PREMIUM_PACK, _local_3, _local_5, _local_4);
            dispatchEvent(_local_7);
            return (true);
        }

        private function ReceivedNpcStoreBegin():Boolean
        {
            var _local_2:int;
            var _local_4:Boolean;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadInt32();
            var _local_3:CharacterInfo = this._actors.GetActor(_local_2);
            _local_4 = (!(this._npcStoreId == _local_2));
            this._npcStoreId = _local_2;
            var _local_5:StoreEvent = new StoreEvent(StoreEvent.ON_NPC_STORE_BEGIN, -1, null, 0, _local_4);
            _local_5.CharacterID = _local_2;
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedNpcStoreBuyList():Boolean
        {
            var _local_9:ItemData;
            var _local_10:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = (TransmissionObject.Instance.ReadUInt16() - 2);
            if (_local_1 < _local_2)
            {
                return (false);
            };
            var _local_3:int = int(((_local_2 - 2) / 11));
            var _local_4:Array = new Array();
            var _local_5:int = ((this._actors) ? this._actors.GetPlayerFraction() : CharacterInfo.FRACTION_LIGHT);
            var _local_6:int = ((_local_5 == CharacterInfo.FRACTION_DARK) ? ItemData.ITEM_ATTRIBUTE_FRACTION : 0);
            var _local_7:int;
            while (_local_7 < _local_3)
            {
                _local_9 = new ItemData();
                _local_10 = TransmissionObject.Instance.ReadInt32();
                _local_9.Id = _local_7;
                _local_9.Price = TransmissionObject.Instance.ReadInt32();
                _local_9.Type = TransmissionObject.Instance.ReadUInt8();
                _local_9.NameId = TransmissionObject.Instance.ReadUInt16();
                _local_9.Attr = _local_6;
                _local_9.Identified = 1;
                _local_9.Amount = 20;
                _local_9.Origin = ItemData.NPCSHOP;
                _local_4.push(_local_9);
                _local_7++;
            };
            var _local_8:StoreEvent = new StoreEvent(StoreEvent.ON_NPC_BUY_LIST, -1, _local_4);
            dispatchEvent(_local_8);
            return (true);
        }

        private function ReceivedBuyStatus():Boolean
        {
            var _local_2:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt8();
            var _local_3:NpcStoreDealEvent = new NpcStoreDealEvent(NpcStoreDealEvent.ON_PLAYER_BUY, _local_2);
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedSellStatus():Boolean
        {
            var _local_2:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt8();
            var _local_3:NpcStoreDealEvent = new NpcStoreDealEvent(NpcStoreDealEvent.ON_PLAYER_SELL, _local_2);
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedGMKickAck():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt8();
            return (true);
        }

        private function ReceivedTradeRequest():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 30)
            {
                return (false);
            };
            var _local_2:String = TransmissionObject.Instance.ReadString(24);
            var _local_3:int = TransmissionObject.Instance.ReadUInt32();
            var _local_4:int = TransmissionObject.Instance.ReadUInt16();
            var _local_5:TradeEvent = new TradeEvent(TradeEvent.ON_TRADE_REQUEST);
            _local_5.CharacterId = _local_3;
            _local_5.CharacterName = _local_2;
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedTradeStartReply():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 7)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt8();
            var _local_3:int = TransmissionObject.Instance.ReadUInt32();
            var _local_4:int = TransmissionObject.Instance.ReadUInt16();
            var _local_5:TradeEvent = new TradeEvent(TradeEvent.ON_TRADE_START_REPLY);
            _local_5.CharacterId = _local_3;
            _local_5.Result = _local_2;
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedTradeAddItem():Boolean
        {
            var _local_5:TradeEvent;
            var _local_6:ItemsResourceLibrary;
            var _local_7:int;
            var _local_8:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 43)
            {
                return (false);
            };
            var _local_2:ItemData = new ItemData();
            var _local_3:int = TransmissionObject.Instance.ReadUInt32();
            var _local_4:int = TransmissionObject.Instance.ReadUInt16();
            if (_local_4 == 0)
            {
                _local_5 = new TradeEvent(TradeEvent.ON_TRADE_ADD_ZENY);
                _local_5.Result = _local_3;
                TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 37);
            }
            else
            {
                _local_2.Amount = _local_3;
                _local_2.NameId = _local_4;
                _local_2.Id = TransmissionObject.Instance.ReadUInt16();
                _local_2.Identified = TransmissionObject.Instance.ReadUInt8();
                _local_2.Attr = TransmissionObject.Instance.ReadUInt8();
                _local_2.Upgrade = TransmissionObject.Instance.ReadUInt8();
                _local_6 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
                _local_2.Type = _local_6.GetServerDescriptionObject(_local_2.NameId)["type"];
                _local_2.Cards = new Vector.<int>();
                _local_7 = 0;
                while (_local_7 < ItemData.MAX_SLOTS)
                {
                    _local_8 = ((_local_7 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                    _local_2.Cards.push(_local_8);
                    _local_7++;
                };
                _local_5 = new TradeEvent(TradeEvent.ON_TRADE_ADD_ITEM);
                _local_5.Item = _local_2;
            };
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedTradeItemOk():Boolean
        {
            var _local_5:CharacterInfo;
            var _local_6:ItemData;
            var _local_7:ItemData;
            var _local_8:int;
            var _local_9:Boolean;
            var _local_10:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 3)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt8();
            var _local_4:TradeEvent = new TradeEvent(TradeEvent.ON_TRADE_ITEM_OK);
            _local_4.Result = _local_3;
            if (_local_3 == 0)
            {
                _local_5 = this._actors.GetPlayer();
                _local_6 = _local_5.Items[_local_2];
                if (_local_6 != null)
                {
                    _local_7 = new ItemData();
                    _local_7.Id = _local_2;
                    _local_7.Amount = this._safeTradeAmount;
                    _local_7.NameId = _local_6.NameId;
                    _local_7.Identified = _local_6.Identified;
                    _local_7.Attr = _local_6.Attr;
                    _local_7.Upgrade = _local_6.Upgrade;
                    _local_7.Cards = new Vector.<int>();
                    _local_8 = 0;
                    while (_local_8 < ItemData.MAX_SLOTS)
                    {
                        _local_10 = _local_6.Cards[_local_8];
                        _local_7.Cards.push(_local_10);
                        _local_8++;
                    };
                    _local_7.TypeEquip = _local_6.TypeEquip;
                    _local_7.Type = _local_6.Type;
                    _local_4.Item = _local_7;
                    _local_6.Amount = (_local_6.Amount - this._safeTradeAmount);
                    if (_local_6.Amount <= 0)
                    {
                        _local_5.Items[_local_2] = null;
                        delete _local_5.Items[_local_2];
                    };
                    _local_5.RevalidateEquipment();
                    _local_9 = (_local_6.Amount > 0);
                    dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, _local_5, null, ((_local_9) ? _local_6 : null)));
                };
            };
            this._safeTradeAmount = -1;
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedTradeDeleteItem():Boolean
        {
            var _local_3:TradeEvent;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 3)
            {
                return (false);
            };
            var _local_2:ItemData = new ItemData();
            _local_2.Id = TransmissionObject.Instance.ReadUInt16();
            _local_2.Amount = TransmissionObject.Instance.ReadUInt32();
            _local_3 = new TradeEvent(TradeEvent.ON_TRADE_DELETE_ITEM);
            _local_3.Item = _local_2;
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedTradeItemCancel():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 5)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt16();
            var _local_4:int = TransmissionObject.Instance.ReadUInt8();
            var _local_5:TradeEvent = new TradeEvent(TradeEvent.ON_TRADE_ITEM_CANCEL);
            var _local_6:ItemData = new ItemData();
            _local_6.Id = _local_2;
            _local_6.Amount = _local_3;
            _local_5.Item = _local_6;
            _local_5.Result = _local_4;
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedTradeDealLock():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            var _local_2:TradeEvent = new TradeEvent(TradeEvent.ON_TRADE_DEAL_LOCKED);
            _local_2.Result = TransmissionObject.Instance.ReadUInt8();
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedTradeCancelled():Boolean
        {
            var _local_1:TradeEvent = new TradeEvent(TradeEvent.ON_TRADE_START_REPLY);
            _local_1.Result = 4;
            dispatchEvent(_local_1);
            return (true);
        }

        private function ReceivedTradeCompleted():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt8();
            var _local_3:TradeEvent = new TradeEvent(TradeEvent.ON_TRADE_COMPLITED);
            _local_3.Result = _local_2;
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedStorageOpened():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            this.Storage.Amount = TransmissionObject.Instance.ReadUInt16();
            this.Storage.MaxAmount = TransmissionObject.Instance.ReadUInt16();
            this.Storage.State = StorageData.STATE_OPENED;
            dispatchEvent(new StorageEvent(StorageEvent.ON_STORAGE_OPENED));
            return (true);
        }

        private function ReceivedStorageItemsRemoved():Boolean
        {
            var _local_2:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 6)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt32();
            var _local_4:ItemData = this.Storage.Storage[_local_2];
            _local_4.Amount = (_local_4.Amount - _local_3);
            if (_local_4.Amount <= 0)
            {
                delete this.Storage.Storage[_local_2];
            };
            dispatchEvent(new StorageEvent(StorageEvent.ON_STORAGE_UPDATED));
            return (true);
        }

        private function ReceivedStorageClosed():Boolean
        {
            this.Storage.State = StorageData.STATE_CLOSED;
            this.Storage.Storage = null;
            dispatchEvent(new StorageEvent(StorageEvent.ON_STORAGE_CLOSED));
            return (true);
        }

        private function ReceivedCharSelectOk():Boolean
        {
            var _local_3:ClientEvent;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadInt8();
            if (_local_2)
            {
                this._state = ClientState.CONNECTED_TO_ACCOUNT;
                _local_3 = new ClientEvent(ClientEvent.ON_PLAYER_DETACHED);
                _local_3.flag = 2;
                dispatchEvent(_local_3);
            };
            return (true);
        }

        private function ReceivedNpcTalk():Boolean
        {
			trace("ReceivedNpcTalk");
            var _local_3:int;
            var _local_4:String;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = (TransmissionObject.Instance.ReadUInt16() - 4);
            if (TransmissionObject.Instance.BytesAvailable < _local_2)
            {
				trace("ReceivedNpcTalk: false");
                return (false);
            };
            _local_3 = TransmissionObject.Instance.ReadInt32();
            _local_4 = TransmissionObject.Instance.ReadString((_local_2 - 4));
            var _local_5:CharacterInfo = this._actors.GetActor(_local_3);
            var _local_6:NpcTalkEvent = new NpcTalkEvent(NpcTalkEvent.ON_NPC_TALK, _local_3, _local_4);
            dispatchEvent(_local_6);
			trace("ReceivedNpcTalk: true");
            return (true);
        }

        private function ReceivedNpcTalkContinue():Boolean
        {
            var _local_2:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadInt32();
            var _local_3:CharacterInfo = this._actors.GetActor(_local_2);
            dispatchEvent(new NpcTalkEvent(NpcTalkEvent.ON_NPC_TALK_CONTINUE, _local_2));
            return (true);
        }

        private function ReceivedNpcTalkClose():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadInt32();
            dispatchEvent(new NpcTalkEvent(NpcTalkEvent.ON_NPC_TALK_CLOSE, _local_2));
            return (true);
        }

        private function ReceivedNpcTalkResponses():Boolean
        {
            var _local_3:int;
            var _local_4:String;
            var _local_8:String;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = (TransmissionObject.Instance.ReadUInt16() - 4);
            if (TransmissionObject.Instance.BytesAvailable < _local_2)
            {
                return (false);
            };
            _local_3 = TransmissionObject.Instance.ReadInt32();
            _local_4 = TransmissionObject.Instance.ReadString((_local_2 - 4));
            var _local_5:CharacterInfo = this._actors.GetActor(_local_3);
            var _local_6:Array = _local_4.split(":");
            var _local_7:int;
            for each (_local_8 in _local_6)
            {
                _local_7++;
            };
            dispatchEvent(new NpcTalkEvent(NpcTalkEvent.ON_NPC_RESPONSES, _local_3, null, _local_6));
            return (true);
        }

        private function ReceivedEmotionsOld():Boolean
        {
            var _local_2:uint;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 5)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            var _local_3:int = TransmissionObject.Instance.ReadUInt8();
            var _local_4:CharacterInfo = this._actors.GetActor(_local_2);
            dispatchEvent(new ChatMessage(-1, _local_4.baseLevel, 0, _local_2, ChatMessage.ON_EMOTION, _local_3.toString(), _local_4.name));
            return (true);
        }

        private function ReceivedEmotions():Boolean
        {
            var _local_2:uint;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 6)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            var _local_3:int = TransmissionObject.Instance.ReadUInt16();
            var _local_4:CharacterInfo = this._actors.GetActor(_local_2);
            dispatchEvent(new ChatMessage( -1, _local_4.baseLevel, 0, _local_2, ChatMessage.ON_EMOTION, _local_3.toString(), _local_4.name));
			trace("ReceivedEmotions:" + _local_4.baseLevel + " " + _local_3.toString() + " " + _local_4.name);
            return (true);
        }

        private function ReceivedStatsAdded():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt8();
            var _local_4:int = TransmissionObject.Instance.ReadUInt8();
            var _local_5:CharacterInfo = this.ActorList.GetPlayer();
            if (_local_3 == 0)
            {
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_STATS_NOT_ENOUGH));
                return (true);
            };
            switch (_local_2)
            {
                case 207:
                    dispatchEvent(new CharacterEvent(CharacterEvent.ON_STATS_NOT_ENOUGH));
                    break;
                case CharacterInfo.SP_STR:
                    _local_5.str = _local_4;
                    break;
                case CharacterInfo.SP_AGI:
                    _local_5.agi = _local_4;
                    break;
                case CharacterInfo.SP_VIT:
                    _local_5.vit = _local_4;
                    break;
                case CharacterInfo.SP_INT:
                    _local_5.intl = _local_4;
                    break;
                case CharacterInfo.SP_DEX:
                    _local_5.dex = _local_4;
                    break;
                case CharacterInfo.SP_LUK:
                    _local_5.luk = _local_4;
                    break;
            };
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_STATS_CHANGED));
            return (true);
        }

        private function ReceivedStatsPointsNeeded():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 5)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_3:uint = TransmissionObject.Instance.ReadUInt8();
            var _local_4:CharacterInfo = this._actors.GetPlayer();
            switch (_local_2)
            {
                case CharacterInfo.SP_USTR:
                    _local_4.ustr = _local_3;
                    break;
                case CharacterInfo.SP_UAGI:
                    _local_4.uagi = _local_3;
                    break;
                case CharacterInfo.SP_UVIT:
                    _local_4.uvit = _local_3;
                    break;
                case CharacterInfo.SP_UINT:
                    _local_4.uintl = _local_3;
                    break;
                case CharacterInfo.SP_UDEX:
                    _local_4.udex = _local_3;
                    break;
                case CharacterInfo.SP_ULUK:
                    _local_4.uluk = _local_3;
                    break;
            };
            return (true);
        }

        private function ReceivedStatInfo():Boolean
        {
            var _local_5:CharacterEvent;
            var _local_6:PartyEvent;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 6)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_3:uint = TransmissionObject.Instance.ReadUInt32();
            var _local_4:CharacterInfo = this._actors.GetPlayer();
            switch (_local_2)
            {
                case CharacterInfo.SP_SPEED:
                    _local_4.walkSpeed = _local_3;
                    break;
                case CharacterInfo.SP_HP:
                    _local_4.hp = _local_3;
                    break;
                case CharacterInfo.SP_MAXHP:
                    _local_4.maxHp = _local_3;
                    break;
                case CharacterInfo.SP_SP:
                    _local_4.sp = _local_3;
                    break;
                case CharacterInfo.SP_MAXSP:
                    _local_4.maxSp = _local_3;
                    break;
                case CharacterInfo.SP_JOBLEVEL:
                    _local_4.jobLevel = _local_3;
                    break;
                case CharacterInfo.SP_GMLEVEL:
                    _local_4.Support = (_local_3 > 0);
                    break;
                case CharacterInfo.SP_KARMA:
                    _local_4.karma = _local_3;
                    break;
                case CharacterInfo.SP_MANNER:
                    _local_4.manner = _local_3;
                    _local_5 = new CharacterEvent(CharacterEvent.ON_MANNER_UPDATED, _local_4);
                    _local_5.Result = _local_2;
                    dispatchEvent(_local_5);
                    return (true);
                case CharacterInfo.SP_DEATHFEAR:
                    _local_4.deathfear = _local_3;
                    _local_5 = new CharacterEvent(CharacterEvent.ON_MANNER_UPDATED, _local_4);
                    _local_5.Result = _local_2;
                    dispatchEvent(_local_5);
                    return (true);
                case CharacterInfo.SP_BREAKRIB:
                    _local_4.breakrib = _local_3;
                    _local_5 = new CharacterEvent(CharacterEvent.ON_MANNER_UPDATED, _local_4);
                    _local_5.Result = _local_2;
                    dispatchEvent(_local_5);
                    return (true);
                case CharacterInfo.SP_BREAKHEAD:
                    _local_4.breakhead = _local_3;
                    _local_5 = new CharacterEvent(CharacterEvent.ON_MANNER_UPDATED, _local_4);
                    _local_5.Result = _local_2;
                    dispatchEvent(_local_5);
                    return (true);
                case CharacterInfo.SP_ARENAPUNISH:
                    _local_4.arenapunish = _local_3;
                    _local_5 = new CharacterEvent(CharacterEvent.ON_MANNER_UPDATED, _local_4);
                    _local_5.Result = _local_2;
                    dispatchEvent(_local_5);
                    return (true);
                case CharacterInfo.SP_STATUSPOINT:
                    _local_4.statusPoint = _local_3;
                    break;
                case CharacterInfo.SP_SKILLPOINT:
                    _local_4.skillPoint = _local_3;
                    _local_5 = new CharacterEvent(CharacterEvent.ON_SKILL_POINTS_CHANGED, _local_4);
                    dispatchEvent(_local_5);
                    return (true);
                case CharacterInfo.SP_HIT:
                    _local_4.hit = _local_3;
                    break;
                case CharacterInfo.SP_FLEE1:
                    _local_4.flee1 = _local_3;
                    break;
                case CharacterInfo.SP_FLEE2:
                    _local_4.flee2 = _local_3;
                    break;
                case CharacterInfo.SP_BASELEVEL:
                    _local_4.baseLevel = _local_3;
                    break;
                case CharacterInfo.SP_ASPD:
                    _local_4.aspd = _local_3;
                    break;
                case CharacterInfo.SP_ATK1:
                    _local_4.atk1 = _local_3;
                    break;
                case CharacterInfo.SP_DEF1:
                    _local_4.def1 = _local_3;
                    break;
                case CharacterInfo.SP_KDEF:
                    _local_4.kdef = _local_3;
                    break;
                case CharacterInfo.SP_OLDDEF:
                    _local_4.olddef = _local_3;
                    break;
                case CharacterInfo.SP_MDEF1:
                    _local_4.mdef1 = _local_3;
                    break;
                case CharacterInfo.SP_MDEF2:
                    _local_4.mdef2 = _local_3;
                    break;
                case CharacterInfo.SP_ATK2:
                    _local_4.atk2 = _local_3;
                    break;
                case CharacterInfo.SP_DEF2:
                    _local_4.def2 = _local_3;
                    break;
                case CharacterInfo.SP_CRITICAL:
                    _local_4.critical = _local_3;
                    break;
                case CharacterInfo.SP_MATK1:
                    _local_4.matkMax = _local_3;
                    break;
                case CharacterInfo.SP_MATK2:
                    _local_4.matkMin = _local_3;
                    break;
                case CharacterInfo.SP_MONEY:
                    if (_local_4.money > 0)
                    {
                        _local_4.lastMoney = (_local_3 - _local_4.money);
                    };
                    _local_4.money = _local_3;
                    break;
                case CharacterInfo.SP_BASEEXP:
                    if (_local_4.baseExp > 0)
                    {
                        _local_4.lastBaseExp = (_local_3 - _local_4.baseExp);
                    };
                    _local_4.baseExp = _local_3;
                    break;
                case CharacterInfo.SP_JOBEXP:
                    _local_4.jobExp = _local_3;
                    break;
                case CharacterInfo.SP_NEXTBASEEXP:
                    _local_4.nextBaseExp = _local_3;
                    break;
                case CharacterInfo.SP_NEXTJOBEXP:
                    _local_4.nextJobExp = _local_3;
                    break;
                case CharacterInfo.SP_WEIGHT:
                    _local_4.weight = _local_3;
                    break;
                case CharacterInfo.SP_MAXWEIGHT:
                    _local_4.weightMax = _local_3;
                    break;
                case CharacterInfo.SP_BASE_ATK:
                    _local_4.batk = _local_3;
                    break;
            };
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_STATS_CHANGED));
            if ((((_local_2 == CharacterInfo.SP_HP) || (_local_2 == CharacterInfo.SP_MAXHP)) && (!(_local_4.Party == null))))
            {
                _local_6 = new PartyEvent(PartyEvent.ON_PARTY_HP_UPDATED);
                _local_6.CharacterId = _local_4.characterId;
                dispatchEvent(_local_6);
            };
            return (true);
        }

        private function ReceivedPetStatus():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < (24 + 9))
            {
                return (false);
            };
            var _local_2:CharacterInfo = this.ActorList.GetPlayer();
            _local_2.Pet.Name = TransmissionObject.Instance.ReadString(24);
            _local_2.Pet.Rename = TransmissionObject.Instance.ReadUInt8();
            _local_2.Pet.Level = TransmissionObject.Instance.ReadUInt16();
            _local_2.Pet.Hungry = TransmissionObject.Instance.ReadUInt16();
            _local_2.Pet.Intimacy = TransmissionObject.Instance.ReadUInt16();
            _local_2.Pet.EggId = TransmissionObject.Instance.ReadUInt16();
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_PET_UPDATED));
            return (true);
        }

        private function ReceivedPetFood():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 3)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt8();
            var _local_3:int = TransmissionObject.Instance.ReadUInt16();
            var _local_4:CharacterEvent = new CharacterEvent(CharacterEvent.ON_PET_FOOD_RESULT);
            _local_4.Result = _local_2;
            var _local_5:ItemData = new ItemData();
            _local_5.NameId = _local_3;
            _local_4.Item = _local_5;
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedPetData():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 9)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt8();
            var _local_3:int = TransmissionObject.Instance.ReadUInt32();
            var _local_4:int = TransmissionObject.Instance.ReadUInt32();
            var _local_5:CharacterInfo = this.ActorList.GetPlayer();
            switch (_local_2)
            {
                case 0:
                    _local_5.Pet.Id = _local_3;
                    this.SendPetGetInfo();
                    break;
                case 1:
                    _local_5.Pet.Intimacy = _local_4;
                    break;
                case 2:
                    _local_5.Pet.Hungry = _local_4;
                    break;
                case 3:
                    _local_5.Pet.AccessoryId = _local_4;
                    break;
                case 4:
                    _local_5.Pet.Performance = _local_4;
                    break;
                case 5:
                    _local_5.Pet.HairStyle = _local_4;
                    break;
                case 6:
                    _local_5.Pet.Incuvate = _local_4;
                    break;
            };
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_PET_UPDATED));
            return (true);
        }

        private function ReceivedPetList():Boolean
        {
            var _local_5:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:int = (TransmissionObject.Instance.ReadUInt16() - 2);
            if (_local_1 < _local_2)
            {
                return (false);
            };
            var _local_3:* = ((_local_2 - 2) >> 1);
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = TransmissionObject.Instance.ReadUInt16();
                _local_4++;
            };
            return (true);
        }

        private function ReceivedPetEmotion():Boolean
        {
            var _local_2:uint;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 8)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            var _local_3:int = TransmissionObject.Instance.ReadUInt32();
            var _local_4:CharacterInfo = this._actors.GetActor(_local_2);
            dispatchEvent(new ChatMessage(-1, -1, 0, _local_2, ChatMessage.ON_PET_EMOTION, _local_3.toString(), _local_4.internalName));
            return (true);
        }

        private function ReceivedActorsManners():Boolean
        {
            var _local_2:uint;
            var _local_6:CharacterEvent;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 10)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            var _local_3:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_4:uint = TransmissionObject.Instance.ReadUInt32();
            var _local_5:CharacterInfo = this._actors.GetActor(_local_2);
            if (_local_3 == CharacterInfo.SP_MANNER)
            {
                _local_5.manner = _local_4;
                _local_6 = new CharacterEvent(CharacterEvent.ON_MANNER_UPDATED, _local_5);
                _local_6.Result = CharacterInfo.SP_MANNER;
                dispatchEvent(_local_6);
            };
            return (true);
        }

        private function ReceivedSetupTrap():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt32();
            return (true);
        }

        private function ReceivedArrowCreateList():Boolean
        {
            var _local_7:int;
            var _local_8:ItemData;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:int = (TransmissionObject.Instance.ReadUInt16() - 4);
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_2 > _local_1)
            {
                return (false);
            };
            var _local_3:* = (_local_2 >> 1);
            var _local_4:CharacterInfo = this.ActorList.GetPlayer();
            var _local_5:Array = new Array();
            var _local_6:int;
            while (_local_6 < _local_3)
            {
                _local_7 = TransmissionObject.Instance.ReadUInt16();
                _local_8 = _local_4.GetItemByName(_local_7);
                _local_5.push(_local_8);
                _local_6++;
            };
            dispatchEvent(new ArrowsListEvent(_local_5));
            return (true);
        }

        private function ReceivedSkillProduceCreateList():Boolean
        {
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:uint;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt16();
            _local_2 = uint(((_local_2 / 8) - 1));
            var _local_3:Array = new Array();
            var _local_4:uint;
            while (_local_4 < _local_2)
            {
                _local_5 = TransmissionObject.Instance.ReadUInt16();
                _local_6 = TransmissionObject.Instance.ReadUInt16();
                _local_7 = TransmissionObject.Instance.ReadUInt32();
                _local_3.push(_local_5);
                _local_4++;
            };
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 6);
            dispatchEvent(new ProduceListEvent(_local_3));
            return (true);
        }

        private function ReceivedSkillProduceEffect():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_3:uint = TransmissionObject.Instance.ReadUInt16();
            dispatchEvent(new ProduceResultEvent(_local_3, _local_2));
            return (true);
        }

        private function ReceivedScriptInput():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt32();
            dispatchEvent(new NpcTalkEvent(NpcTalkEvent.ON_NPC_INPUT_NUMBER, _local_2));
            return (true);
        }

        private function ReceivedResurrection():Boolean
        {
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:CharacterInfo;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 6)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadUInt16();
            _local_4 = this._actors.GetActor(_local_2);
            _local_4.isDead = 0;
            var _local_5:ActorDisplayEvent = new ActorDisplayEvent(_local_4, ActorDisplayEvent.ON_ACTOR_RESURRECTED, _local_3);
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedStatInfo2():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 12)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt32();
            var _local_3:uint = TransmissionObject.Instance.ReadUInt32();
            var _local_4:uint = TransmissionObject.Instance.ReadUInt32();
            var _local_5:CharacterInfo = this._actors.GetPlayer();
            switch (_local_2)
            {
                case CharacterInfo.SP_STR:
                    _local_5.str = _local_3;
                    _local_5.strBonus = _local_4;
                    break;
                case CharacterInfo.SP_AGI:
                    _local_5.agi = _local_3;
                    _local_5.agiBonus = _local_4;
                    break;
                case CharacterInfo.SP_VIT:
                    _local_5.vit = _local_3;
                    _local_5.vitBonus = _local_4;
                    break;
                case CharacterInfo.SP_INT:
                    _local_5.intl = _local_3;
                    _local_5.intBonus = _local_4;
                    break;
                case CharacterInfo.SP_DEX:
                    _local_5.dex = _local_3;
                    _local_5.dexBonus = _local_4;
                    break;
                case CharacterInfo.SP_LUK:
                    _local_5.luk = _local_3;
                    _local_5.lukBonus = _local_4;
                    break;
                case CharacterInfo.SP_PREMIUM:
                    this._premiumType = _local_3;
                    this._premiumUntil = _local_4;
                    break;
                case CharacterInfo.SP_CARTINFO:
                    break;
            };
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_STATS_CHANGED));
            return (true);
        }

        private function ReceivedMiscEffect():Boolean
        {
            var _local_2:uint;
            var _local_4:String;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 8)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            var _local_3:uint = TransmissionObject.Instance.ReadUInt32();
            var _local_5:CharacterInfo = this.ActorList.GetActor(_local_2);
            switch (_local_3)
            {
                case 0:
                    _local_4 = ActorStatsEvent.ON_LEVEL_UP;
                    break;
                case 1:
                    _local_4 = ActorStatsEvent.ON_JOB_LEVEL_UP;
                    break;
                case 2:
                    _local_4 = ActorStatsEvent.ON_REFINE_FAILED;
                    break;
                case 3:
                    _local_4 = ActorStatsEvent.ON_REFINE_SUCCESS;
                    break;
            };
            if (_local_4)
            {
                dispatchEvent(new ActorStatsEvent(_local_4, _local_5, _local_3));
            };
            return (true);
        }

        private function ReceivedAttackRange():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            var _local_3:CharacterInfo = this._actors.GetPlayer();
            _local_3.range = _local_2;
            return (true);
        }

        private function ReceivedAmmunitionEmpty():Boolean
        {
            var _local_2:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            var _local_3:String = ClientApplication.Localization.DLG_NOT_ENOUGH_AMMUNITION_MESSAGES[_local_2];
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_AMMUNITION_EMPTY, null, _local_3));
            return (true);
        }

        private function ReceivedArrowEquipped():Boolean
        {
            var _local_2:int;
            var _local_3:CharacterInfo;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            _local_3 = this.ActorList.GetPlayer();
            var _local_4:ItemData = _local_3.Items[_local_2];
            if (_local_4 != null)
            {
                _local_4.Equip = CharacterEquipment.MASK_ARROWS;
                _local_3.RevalidateEquipment();
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, _local_3));
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEM_EQUIPPED, _local_3));
            };
            return (true);
        }

        private function ReceivedSoulShotEquipped():Boolean
        {
            var _local_2:int;
            var _local_3:CharacterInfo;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            _local_3 = this.ActorList.GetPlayer();
            var _local_4:ItemData = _local_3.Items[_local_2];
            if (_local_4 != null)
            {
                _local_4.Equip = CharacterEquipment.MASK_SOULSHOTS;
                _local_3.RevalidateEquipment();
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, _local_3));
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEM_EQUIPPED, _local_3));
            };
            return (true);
        }

        private function ReceivedPlayerEquipment():Boolean
        {
            var _local_2:uint;
            var _local_3:CharacterInfo;
            var _local_7:int;
            var _local_8:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 9)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this._actors.GetActor(_local_2);
            var _local_4:uint = TransmissionObject.Instance.ReadUInt8();
            var _local_5:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_6:uint = TransmissionObject.Instance.ReadUInt16();
            switch (_local_4)
            {
                case CharacterInfo.LOOK_BASE:
                    _local_3.jobId = _local_5;
                    dispatchEvent(new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_INFO_UPDATED));
                    break;
                case CharacterInfo.LOOK_WEAPON:
                    _local_7 = _local_3.viewWeapon;
                    _local_8 = _local_3.viewShield;
                    _local_3.viewWeapon = _local_5;
                    _local_3.viewShield = _local_6;
                    if (((!(_local_7 == _local_5)) || (!(_local_8 == _local_6))))
                    {
                        dispatchEvent(new ActorViewIdEvent(_local_3, ActorViewIdEvent.ON_ACTOR_VIEWID_UPDATE));
                    };
                    if (_local_3.characterId == this.ActorList.GetPlayer().characterId)
                    {
                        dispatchEvent(new CharacterEvent(CharacterEvent.ON_STATS_CHANGED));
                    };
                    break;
                case CharacterInfo.LOOK_HAIR_COLOR:
                    _local_3.hairColor = _local_5;
                    dispatchEvent(new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_HAIR_COLOR_CHANGED));
                    break;
                case CharacterInfo.LOOK_SEX:
                    _local_3.sex = _local_5;
                    dispatchEvent(new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_HAIR_COLOR_CHANGED));
                    break;
                case CharacterInfo.LOOK_CLOTHES_COLOR:
                    _local_3.clothesColor = _local_5;
                    dispatchEvent(new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_HAIR_COLOR_CHANGED));
                    break;
                case CharacterInfo.LOOK_WEAPON_REFINE:
                    _local_3.rightHandRefineLevel = _local_5;
                    _local_3.leftHandRefineLevel = _local_6;
                    dispatchEvent(new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_HAIR_COLOR_CHANGED));
                    break;
                default:
                    if (_local_3.characterId == this.ActorList.GetPlayer().characterId)
                    {
                        dispatchEvent(new CharacterEvent(CharacterEvent.ON_STATS_CHANGED));
                    };
            };
            return (true);
        }

        private function ReceivedCastCanceled():Boolean
        {
            var _local_2:uint;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            var _local_3:CharacterInfo = this.ActorList.GetActor(_local_2);
            dispatchEvent(new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_CAST_CANCELED));
            return (true);
        }

        private function ReceivedActorItemUsed():Boolean
        {
            var _local_8:ItemData;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 10)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt16();
            var _local_4:int = TransmissionObject.Instance.ReadUInt32();
            var _local_5:int = TransmissionObject.Instance.ReadUInt16();
            var _local_6:int = TransmissionObject.Instance.ReadInt8();
            var _local_7:CharacterInfo = this.ActorList.GetPlayer();
            if (_local_4 == _local_7.characterId)
            {
                _local_8 = _local_7.Items[_local_2];
                _local_8.Amount = _local_5;
                if (_local_8.Amount <= 0)
                {
                    _local_7.Items[_local_2] = null;
                    delete _local_7.Items[_local_2];
                };
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, null, null, _local_8));
            };
            return (true);
        }

        private function ReceivedDevotion():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 26)
            {
                return (false);
            };
            TransmissionObject.Instance.ReadInt32();
            TransmissionObject.Instance.ReadInt32();
            TransmissionObject.Instance.ReadInt32();
            TransmissionObject.Instance.ReadInt32();
            TransmissionObject.Instance.ReadInt32();
            TransmissionObject.Instance.ReadInt32();
            TransmissionObject.Instance.ReadInt16();
            return (true);
        }

        private function ReceivedSoundEffect():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 33)
            {
                return (false);
            };
            var _local_2:String = TransmissionObject.Instance.ReadString(24);
            var _local_3:uint = TransmissionObject.Instance.ReadUInt8();
            TransmissionObject.Instance.ReadUInt32();
            TransmissionObject.Instance.ReadUInt32();
            dispatchEvent(new SoundEffectEvent(SoundEffectEvent.ON_SOUND_EFFECT, _local_2, _local_3));
            return (true);
        }

        private function ReceivedNpcInputRequest():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt32();
            dispatchEvent(new NpcTalkEvent(NpcTalkEvent.ON_NPC_INPUT_STRING, _local_2));
            return (true);
        }

        private function ReceivedItemAppeared():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 15)
            {
                return (false);
            };
            var _local_2:FloorItemEvent = new FloorItemEvent(FloorItemEvent.ON_FLOOR_ITEM_APPEARED);
            _local_2.ItemId = TransmissionObject.Instance.ReadInt32();
            _local_2.NameId = TransmissionObject.Instance.ReadInt16();
            _local_2.IdentifyFlag = TransmissionObject.Instance.ReadUInt8();
            _local_2.PosX = TransmissionObject.Instance.ReadUInt16();
            _local_2.PosY = TransmissionObject.Instance.ReadUInt16();
            _local_2.SubX = TransmissionObject.Instance.ReadUInt8();
            _local_2.SubY = TransmissionObject.Instance.ReadUInt8();
            _local_2.Amount = TransmissionObject.Instance.ReadInt16();
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedAreaCharItem():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 15)
            {
                return (false);
            };
            var _local_2:FloorItemEvent = new FloorItemEvent(FloorItemEvent.ON_GET_AREA_CHAR_ITEM);
            _local_2.ItemId = TransmissionObject.Instance.ReadInt32();
            _local_2.NameId = TransmissionObject.Instance.ReadInt16();
            _local_2.IdentifyFlag = TransmissionObject.Instance.ReadUInt8();
            _local_2.PosX = TransmissionObject.Instance.ReadUInt16();
            _local_2.PosY = TransmissionObject.Instance.ReadUInt16();
            _local_2.Amount = TransmissionObject.Instance.ReadInt16();
            _local_2.SubX = TransmissionObject.Instance.ReadUInt8();
            _local_2.SubY = TransmissionObject.Instance.ReadUInt8();
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedSkillPosEffect():Boolean
        {
            var _local_3:CharacterInfo;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 16)
            {
                return (false);
            };
            var _local_2:SkillPosEffectEvent = new SkillPosEffectEvent();
            _local_2.SkillId = TransmissionObject.Instance.ReadInt16();
            _local_2.SourceId = TransmissionObject.Instance.ReadUInt32();
            _local_2.Value = TransmissionObject.Instance.ReadInt16();
            _local_2.X = TransmissionObject.Instance.ReadInt16();
            _local_2.Y = TransmissionObject.Instance.ReadInt16();
            _local_2.Tick = TransmissionObject.Instance.ReadInt32();
            if (_local_2.SkillId == 264)
            {
                _local_3 = this.ActorList.GetActor(_local_2.SourceId);
                if (_local_3)
                {
                    _local_3.coordinates.x = _local_2.X;
                    _local_3.coordinates.y = _local_2.Y;
                    _local_3.coordinates.x1 = _local_3.coordinates.x;
                    _local_3.coordinates.y1 = _local_3.coordinates.y;
                    _local_3.coordinates.isNeedFindPath = false;
                };
            };
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedItemDisappeared():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            var _local_2:FloorItemEvent = new FloorItemEvent(FloorItemEvent.ON_FLOOR_ITEM_DISAPPEARED);
            _local_2.ItemId = TransmissionObject.Instance.ReadInt32();
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedItemAdded():Boolean
        {
            var _local_2:CharacterInfo;
            var _local_8:int;
            var _local_9:ItemData;
            var _local_10:FloorItemEvent;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 45)
            {
                return (false);
            };
            _local_2 = this._actors.GetPlayer();
            var _local_3:Dictionary = _local_2.Items;
            var _local_4:int = TransmissionObject.Instance.ReadUInt16();
            var _local_5:ItemData = new ItemData();
            _local_5.Id = _local_4;
            _local_5.Amount = TransmissionObject.Instance.ReadUInt16();
            _local_5.NameId = TransmissionObject.Instance.ReadUInt16();
            _local_5.Identified = TransmissionObject.Instance.ReadUInt8();
            _local_5.Attr = TransmissionObject.Instance.ReadUInt8();
            _local_5.Upgrade = TransmissionObject.Instance.ReadUInt8();
            _local_5.Cards = new Vector.<int>();
            var _local_6:int;
            while (_local_6 < ItemData.MAX_SLOTS)
            {
                _local_8 = ((_local_6 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                _local_5.Cards.push(_local_8);
                _local_6++;
            };
            _local_5.TypeEquip = TransmissionObject.Instance.ReadUInt16();
            _local_5.Type = TransmissionObject.Instance.ReadUInt8();
            var _local_7:int = TransmissionObject.Instance.ReadUInt8();
            if (_local_7 == 0)
            {
                _local_9 = _local_3[_local_4];
                if (((!(_local_9 == null)) && (!(_local_9.NameId == _local_5.NameId))))
                {
                    _local_9 = _local_2.GetItemByName(_local_5.NameId);
                };
                if (_local_9 != null)
                {
                    if (((_local_5.TypeEquip == 0) || (_local_5.Type == ItemData.IT_SOULSHOT)))
                    {
                        _local_9.Amount = (_local_9.Amount + _local_5.Amount);
                    };
                }
                else
                {
                    if (_local_5.NameId != 3)
                    {
                        _local_3[_local_4] = _local_5;
                    };
                };
                _local_2.RevalidateEquipment();
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, _local_2));
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEM_EQUIPPED, _local_2));
                dispatchEvent(new ItemAddedEvent(_local_5));
            }
            else
            {
                if (((_local_7 == 4) || (_local_7 == 2)))
                {
                    _local_10 = new FloorItemEvent(FloorItemEvent.ON_FLOOR_ITEM_OVERWEIGHT);
                    _local_10.OverWeight = (_local_7 == 2);
                    dispatchEvent(_local_10);
                };
            };
            return (true);
        }

        private function ReceivedInventoryItemsNonStackable():Boolean
        {
            var _local_4:CharacterInfo;
            var _local_7:int;
            var _local_8:ItemData;
            var _local_9:int;
            var _local_10:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = (TransmissionObject.Instance.ReadUInt16() - 4);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            var _local_3:uint = uint((_local_2 / 44));
            _local_4 = this._actors.GetPlayer();
            var _local_5:Dictionary = _local_4.Items;
            var _local_6:int;
            while (_local_6 < _local_3)
            {
                _local_7 = TransmissionObject.Instance.ReadUInt16();
                _local_8 = _local_5[_local_7];
                if (_local_8 == null)
                {
                    _local_8 = (_local_5[_local_7] = new ItemData());
                };
                _local_8.Id = _local_7;
                _local_8.NameId = TransmissionObject.Instance.ReadUInt16();
                _local_8.Amount = 1;
                _local_8.Type = TransmissionObject.Instance.ReadUInt8();
                _local_8.Identified = TransmissionObject.Instance.ReadUInt8();
                _local_8.TypeEquip = TransmissionObject.Instance.ReadUInt16();
                _local_8.Equip = TransmissionObject.Instance.ReadUInt16();
                _local_8.Attr = TransmissionObject.Instance.ReadUInt8();
                _local_8.Upgrade = TransmissionObject.Instance.ReadUInt8();
                _local_8.Cards = new Vector.<int>();
                _local_9 = 0;
                while (_local_9 < ItemData.MAX_SLOTS)
                {
                    _local_10 = ((_local_9 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                    _local_8.Cards.push(_local_10);
                    _local_9++;
                };
                _local_6++;
            };
            _local_4.RevalidateEquipment();
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, _local_4));
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEM_EQUIPPED, _local_4));
            return (true);
        }

        private function ReceivedStorageItemsNonStackable():Boolean
        {
            var _local_5:int;
            var _local_6:ItemData;
            var _local_7:int;
            var _local_8:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = (TransmissionObject.Instance.ReadUInt16() - 4);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            var _local_3:uint = uint((_local_2 / 44));
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = TransmissionObject.Instance.ReadUInt16();
                _local_6 = this.Storage.Storage[_local_5];
                if (_local_6 == null)
                {
                    _local_6 = (this.Storage.Storage[_local_5] = new ItemData());
                };
                _local_6.Id = _local_5;
                _local_6.Origin = ItemData.STORAGE;
                _local_6.NameId = TransmissionObject.Instance.ReadUInt16();
                _local_6.Amount = 1;
                _local_6.Type = TransmissionObject.Instance.ReadUInt8();
                _local_6.Identified = TransmissionObject.Instance.ReadUInt8();
                _local_6.TypeEquip = TransmissionObject.Instance.ReadUInt16();
                _local_6.Equip = TransmissionObject.Instance.ReadUInt16();
                _local_6.Equip = 0;
                _local_6.Attr = TransmissionObject.Instance.ReadUInt8();
                _local_6.Upgrade = TransmissionObject.Instance.ReadUInt8();
                _local_6.Cards = new Vector.<int>();
                _local_7 = 0;
                while (_local_7 < ItemData.MAX_SLOTS)
                {
                    _local_8 = ((_local_7 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                    _local_6.Cards.push(_local_8);
                    _local_7++;
                };
                _local_4++;
            };
            dispatchEvent(new StorageEvent(StorageEvent.ON_STORAGE_UPDATED));
            return (true);
        }

        private function ReceivedInventoryItemsStackable():Boolean
        {
            var _local_4:CharacterInfo;
            var _local_7:int;
            var _local_8:int;
            var _local_9:ItemData;
            var _local_10:int;
            var _local_11:int;
            var _local_12:ItemData;
            var _local_13:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = (TransmissionObject.Instance.ReadUInt16() - 4);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            var _local_3:uint = uint((_local_2 / 42));
            _local_4 = this._actors.GetPlayer();
            var _local_5:Dictionary = _local_4.Items;
            var _local_6:int;
            while (_local_6 < _local_3)
            {
                _local_7 = TransmissionObject.Instance.ReadUInt16();
                _local_8 = TransmissionObject.Instance.ReadUInt16();
                _local_9 = _local_5[_local_7];
                if (_local_9 == null)
                {
                    _local_9 = (_local_5[_local_7] = new ItemData());
                    _local_12 = _local_4.GetItemByName(_local_8);
                    if (_local_12)
                    {
                        _local_5[_local_12.Id] = null;
                        delete _local_5[_local_12.Id];
                    };
                };
                _local_9.Id = _local_7;
                _local_9.NameId = _local_8;
                _local_9.Type = TransmissionObject.Instance.ReadUInt8();
                _local_10 = TransmissionObject.Instance.ReadUInt8();
                _local_9.Amount = TransmissionObject.Instance.ReadUInt16();
                _local_9.Identified = 1;
                _local_9.TypeEquip = TransmissionObject.Instance.ReadUInt16();
                _local_9.Cards = new Vector.<int>();
                _local_11 = 0;
                while (_local_11 < ItemData.MAX_SLOTS)
                {
                    _local_13 = ((_local_11 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                    _local_9.Cards.push(_local_13);
                    _local_11++;
                };
                _local_6++;
            };
            _local_4.RevalidateEquipment();
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, _local_4));
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEM_EQUIPPED, _local_4));
            return (true);
        }

        private function ReceivedCartItemsStackable():Boolean
        {
            var _local_5:int;
            var _local_6:ItemData;
            var _local_7:int;
            var _local_8:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = (TransmissionObject.Instance.ReadUInt16() - 4);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            var _local_3:uint = uint((_local_2 / 42));
            if (this.Cart == null)
            {
                this.Cart = new CartData();
            };
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = TransmissionObject.Instance.ReadUInt16();
                _local_6 = this.Cart.Cart[_local_5];
                if (_local_6 == null)
                {
                    _local_6 = (this.Cart.Cart[_local_5] = new ItemData());
                };
                _local_6.Id = _local_5;
                _local_6.Origin = ItemData.CART;
                _local_6.NameId = TransmissionObject.Instance.ReadUInt16();
                _local_6.Type = TransmissionObject.Instance.ReadUInt8();
                _local_6.Identified = TransmissionObject.Instance.ReadUInt8();
                _local_6.Amount = TransmissionObject.Instance.ReadUInt16();
                _local_6.TypeEquip = TransmissionObject.Instance.ReadUInt16();
                _local_6.Cards = new Vector.<int>();
                _local_7 = 0;
                while (_local_7 < ItemData.MAX_SLOTS)
                {
                    _local_8 = ((_local_7 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                    _local_6.Cards.push(_local_8);
                    _local_7++;
                };
                _local_4++;
            };
            dispatchEvent(new CartEvent(CartEvent.ON_CART_UPDATED));
            return (true);
        }

        private function ReceivedStorageItemsStackable():Boolean
        {
            var _local_5:int;
            var _local_6:ItemData;
            var _local_7:int;
            var _local_8:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = (TransmissionObject.Instance.ReadUInt16() - 4);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            var _local_3:uint = uint((_local_2 / 42));
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = TransmissionObject.Instance.ReadUInt16();
                _local_6 = this.Storage.Storage[_local_5];
                if (_local_6 == null)
                {
                    _local_6 = (this.Storage.Storage[_local_5] = new ItemData());
                };
                _local_6.Id = _local_5;
                _local_6.Origin = ItemData.STORAGE;
                _local_6.NameId = TransmissionObject.Instance.ReadUInt16();
                _local_6.Type = TransmissionObject.Instance.ReadUInt8();
                _local_6.Identified = TransmissionObject.Instance.ReadUInt8();
                _local_6.Amount = TransmissionObject.Instance.ReadUInt16();
                _local_6.TypeEquip = TransmissionObject.Instance.ReadUInt16();
                _local_6.Cards = new Vector.<int>();
                _local_7 = 0;
                while (_local_7 < ItemData.MAX_SLOTS)
                {
                    _local_8 = ((_local_7 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                    _local_6.Cards.push(_local_8);
                    _local_7++;
                };
                _local_4++;
            };
            dispatchEvent(new StorageEvent(StorageEvent.ON_STORAGE_UPDATED));
            return (true);
        }

        private function ReceivedInventoryItemRemoved():Boolean
        {
            var _local_2:int;
            var _local_4:CharacterInfo;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt16();
            _local_4 = this.ActorList.GetPlayer();
            var _local_5:ItemData = _local_4.Items[_local_2];
            if (_local_5 != null)
            {
                _local_5.Amount = (_local_5.Amount - _local_3);
                if (_local_5.Amount <= 0)
                {
                    _local_4.Items[_local_2] = null;
                    delete _local_4.Items[_local_2];
                };
                _local_4.RevalidateEquipment();
            };
            var _local_6:Boolean = ((!(_local_5 == null)) && (_local_5.Amount > 0));
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, this._actors.GetPlayer(), null, ((_local_6) ? _local_5 : null)));
            return (true);
        }

        private function ReceivedInventoryItemUse():Boolean
        {
            var _local_2:int;
            var _local_5:CharacterInfo;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 5)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt16();
            var _local_4:int = TransmissionObject.Instance.ReadInt8();
            _local_5 = this.ActorList.GetPlayer();
            var _local_6:ItemData = _local_5.Items[_local_2];
            if (((!(_local_6 == null)) && (_local_4)))
            {
                _local_6.Amount = (_local_6.Amount - _local_3);
                if (_local_6.Amount <= 0)
                {
                    _local_5.Items[_local_2] = null;
                    delete _local_5.Items[_local_2];
                };
                _local_5.RevalidateEquipment();
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, this._actors.GetPlayer()));
            }
            else
            {
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_CANT_USE_ITEM, _local_5));
            };
            return (true);
        }

        private function ReceivedInventoryItemEquipped():Boolean
        {
            var _local_2:int;
            var _local_5:CharacterInfo;
            var _local_7:CharacterEvent;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 5)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt16();
            var _local_4:int = TransmissionObject.Instance.ReadUInt8();
            _local_5 = this.ActorList.GetPlayer();
            var _local_6:ItemData = _local_5.Items[_local_2];
            if (((!(_local_6 == null)) && (_local_4)))
            {
                _local_6.Equip = _local_3;
                _local_5.RevalidateEquipment();
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, _local_5));
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEM_EQUIPPED, _local_5));
            }
            else
            {
                _local_7 = new CharacterEvent(CharacterEvent.ON_CANT_EQUIP_ITEM, _local_5, null, _local_6);
                _local_7.Result = _local_3;
                dispatchEvent(_local_7);
            };
            return (true);
        }

        private function ReceivedInventoryItemUnEquipped():Boolean
        {
            var _local_2:int;
            var _local_5:CharacterInfo;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 5)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt16();
            var _local_4:int = TransmissionObject.Instance.ReadUInt8();
            _local_5 = this.ActorList.GetPlayer();
            var _local_6:ItemData = _local_5.Items[_local_2];
            if (((!(_local_6 == null)) && (_local_4)))
            {
                _local_6.Equip = 0;
                _local_5.RevalidateEquipment();
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEM_EQUIPPED, _local_5));
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, _local_5));
            };
            return (true);
        }

        private function ReceivedStorageItemAddedF4():Boolean
        {
            var _local_4:ItemData;
            var _local_7:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 43)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt32();
            _local_4 = this.Storage.Storage[_local_2];
            if (_local_4 == null)
            {
                _local_4 = new ItemData();
                _local_4.Amount = _local_3;
            }
            else
            {
                _local_4.Amount = (_local_4.Amount + _local_3);
            };
            _local_4.Id = _local_2;
            _local_4.Origin = ItemData.STORAGE;
            _local_4.NameId = TransmissionObject.Instance.ReadUInt16();
            var _local_5:ItemsResourceLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            _local_4.Type = _local_5.GetServerDescriptionObject(_local_4.NameId)["type"];
            _local_4.Identified = TransmissionObject.Instance.ReadUInt8();
            _local_4.Attr = TransmissionObject.Instance.ReadUInt8();
            _local_4.Upgrade = TransmissionObject.Instance.ReadUInt8();
            _local_4.Cards = new Vector.<int>();
            var _local_6:int;
            while (_local_6 < ItemData.MAX_SLOTS)
            {
                _local_7 = ((_local_6 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                _local_4.Cards.push(_local_7);
                _local_6++;
            };
            this.Storage.Storage[_local_2] = _local_4;
            dispatchEvent(new StorageEvent(StorageEvent.ON_STORAGE_UPDATED));
            return (true);
        }

        private function ReceivedStorageItemAdded():Boolean
        {
            var _local_4:ItemData;
            var _local_6:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 44)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt32();
            _local_4 = this.Storage.Storage[_local_2];
            if (_local_4 == null)
            {
                _local_4 = new ItemData();
                _local_4.Amount = _local_3;
            }
            else
            {
                _local_4.Amount = (_local_4.Amount + _local_3);
            };
            _local_4.Id = _local_2;
            _local_4.Origin = ItemData.STORAGE;
            _local_4.NameId = TransmissionObject.Instance.ReadUInt16();
            _local_4.Type = TransmissionObject.Instance.ReadUInt8();
            _local_4.Identified = TransmissionObject.Instance.ReadUInt8();
            _local_4.Attr = TransmissionObject.Instance.ReadUInt8();
            _local_4.Upgrade = TransmissionObject.Instance.ReadUInt8();
            _local_4.Cards = new Vector.<int>();
            var _local_5:int;
            while (_local_5 < ItemData.MAX_SLOTS)
            {
                _local_6 = ((_local_5 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                _local_4.Cards.push(_local_6);
                _local_5++;
            };
            this.Storage.Storage[_local_2] = _local_4;
            dispatchEvent(new StorageEvent(StorageEvent.ON_STORAGE_UPDATED));
            return (true);
        }

        private function ReceivedCartItemAdded():Boolean
        {
            var _local_4:ItemData;
            var _local_6:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 44)
            {
                return (false);
            };
            if (this.Cart == null)
            {
                this.Cart = new CartData();
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt32();
            _local_4 = this.Cart.Cart[_local_2];
            if (_local_4 == null)
            {
                _local_4 = new ItemData();
                _local_4.Amount = _local_3;
            }
            else
            {
                _local_4.Amount = (_local_4.Amount + _local_3);
            };
            _local_4.Id = _local_2;
            _local_4.Origin = ItemData.CART;
            _local_4.NameId = TransmissionObject.Instance.ReadUInt16();
            _local_4.Type = TransmissionObject.Instance.ReadUInt8();
            _local_4.Identified = TransmissionObject.Instance.ReadUInt8();
            _local_4.Attr = TransmissionObject.Instance.ReadUInt8();
            _local_4.Upgrade = TransmissionObject.Instance.ReadUInt8();
            _local_4.Cards = new Vector.<int>();
            var _local_5:int;
            while (_local_5 < ItemData.MAX_SLOTS)
            {
                _local_6 = ((_local_5 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                _local_4.Cards.push(_local_6);
                _local_5++;
            };
            this.Cart.Cart[_local_2] = _local_4;
            dispatchEvent(new CartEvent(CartEvent.ON_CART_UPDATED));
            return (true);
        }

        private function ReceivedIdentifyList():Boolean
        {
            var _local_5:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = (TransmissionObject.Instance.ReadUInt16() - 4);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            var _local_3:uint = uint((_local_2 / 2));
            var _local_4:int;
            while (_local_4 < _local_3)
            {
                _local_5 = TransmissionObject.Instance.ReadUInt16();
                _local_4++;
            };
            return (true);
        }

        private function ReceivedItemIdentified():Boolean
        {
            var _local_2:int;
            var _local_3:CharacterInfo;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this.ActorList.GetPlayer();
            var _local_4:ItemData = _local_3.Items[_local_2];
            if (_local_4 != null)
            {
                _local_4.Identified = 1;
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, _local_3));
            };
            return (true);
        }

        private function ReceivedInsertCardResult():Boolean
        {
            var _local_2:int;
            var _local_5:CharacterInfo;
            var _local_7:ItemData;
            var _local_8:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt16();
            var _local_4:int = TransmissionObject.Instance.ReadUInt8();
            _local_5 = this.ActorList.GetPlayer();
            var _local_6:ItemData = _local_5.Items[_local_2];
            if (!_local_6)
            {
                return (true);
            };
            if (_local_4 == 0)
            {
                _local_7 = _local_5.Items[_local_3];
                _local_8 = ClientApplication.Instance._currentSlotId;
                if (_local_6.Cards)
                {
                    if ((((_local_8 >= 0) && (_local_8 < 4)) && (_local_6.Cards[_local_8] == 0)))
                    {
                        _local_6.Cards[_local_8] = _local_7.NameId;
                        dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, _local_5));
                    };
                };
                _local_7.Amount--;
                if (_local_7.Amount <= 0)
                {
                    _local_5.Items[_local_3] = null;
                    delete _local_5.Items[_local_3];
                    dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, _local_5));
                };
            };
            dispatchEvent(new UpgradeResultEvent(0, _local_6.NameId, _local_4));
            return (true);
        }

        private function ReceivedRemoveCardResult():Boolean
        {
            var _local_2:int;
            var _local_5:CharacterInfo;
            var _local_7:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt16();
            var _local_4:int = TransmissionObject.Instance.ReadUInt8();
            _local_5 = this.ActorList.GetPlayer();
            var _local_6:ItemData = _local_5.Items[_local_2];
            if (!_local_6)
            {
                return (true);
            };
            if (((_local_4 == 0) || (_local_4 == 2)))
            {
                if (_local_6.Cards)
                {
                    _local_7 = 0;
                    while (_local_7 < 4)
                    {
                        if (_local_6.Cards[_local_7] == _local_3)
                        {
                            _local_6.Cards[_local_7] = 0;
                            dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, _local_5));
                            break;
                        };
                        _local_7++;
                    };
                };
            };
            if (_local_4 == 2)
            {
                _local_5.Items[_local_2] = null;
                delete _local_5.Items[_local_2];
                dispatchEvent(new CharacterEvent(CharacterEvent.ON_ITEMS_CHANGED, _local_5));
            };
            dispatchEvent(new UpgradeResultEvent(1, _local_6.NameId, _local_4));
            return (true);
        }

        private function ReceivedCraftCardResult():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            dispatchEvent(new CraftCardResultEvent(_local_2));
            return (true);
        }

        private function ReceivedNpcIdleDisplay():Boolean
        {
			trace("ReceivedNpcIdleDisplay");
            var _local_2:uint;
            var _local_3:CharacterInfo;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 53)
            {
                return (false);
            };
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 1);
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this._actors.GetActor(_local_2);
            _local_3.walkSpeed = TransmissionObject.Instance.ReadUInt16();
            var _local_4:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_5:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_6:uint = TransmissionObject.Instance.ReadUInt16();
            _local_3.jobId = TransmissionObject.Instance.ReadUInt16();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + (2 * 9));
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 4);
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 7);
            _local_3.sex = TransmissionObject.Instance.ReadUInt8();
            var _local_7:ByteArray = new ByteArray();
            TransmissionObject.Instance.ReadBytes(_local_7, 0, 3);
            _local_3.coordinates.SetEncoded3(_local_7);
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            _local_3.isDead = TransmissionObject.Instance.ReadUInt8();
            _local_3.baseLevel = TransmissionObject.Instance.ReadUInt16();
            _local_3.isStatusesLoaded = true;
            var _local_8:ActorDisplayEvent = new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_INFO_UPDATED);
            _local_8.disguiseId = _local_3.jobId;
            _local_8.option = _local_6;
            _local_8.option1 = _local_4;
            _local_8.option2 = _local_5;
            _local_8.withOptions = true;
            dispatchEvent(_local_8);
			trace("_local_2" + _local_2);
			trace("_local_3.walkSpeed" + _local_3.walkSpeed);
			trace("_local_4" + _local_4);
			trace("_local_5" + _local_5);
			trace("_local_6" + _local_6);
			trace("_local_3.jobId" + _local_3.jobId);
			trace("_local_3.sex" + _local_3.sex);
			trace("_local_3.isDead" + _local_3.isDead);
			trace("_local_3.baseLevel" + _local_3.baseLevel);
            if (!_local_3.isNameLoaded)
            {
                this.SendGetPlayerName(_local_2);
            };
            return (true);
        }

        private function ReceivedNpcSpawnDisplay():Boolean
        {
            var _local_2:uint;
            var _local_3:CharacterInfo;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 40)
            {
                return (false);
            };
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 1);
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this._actors.GetActor(_local_2);
            _local_3.walkSpeed = TransmissionObject.Instance.ReadUInt16();
            var _local_4:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_5:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_6:uint = TransmissionObject.Instance.ReadUInt16();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            var _local_7:int = _local_3.viewWeapon;
            var _local_8:int = _local_3.viewShield;
            _local_3.viewWeapon = TransmissionObject.Instance.ReadUInt16();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            _local_3.jobId = TransmissionObject.Instance.ReadUInt16();
            _local_3.viewShield = TransmissionObject.Instance.ReadUInt16();
            if (((!(_local_7 == _local_3.viewWeapon)) || (!(_local_8 == _local_3.viewShield))))
            {
                dispatchEvent(new ActorViewIdEvent(_local_3, ActorViewIdEvent.ON_ACTOR_VIEWID_UPDATE));
            };
            _local_3.viewHead = TransmissionObject.Instance.ReadUInt16();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            _local_3.clothesColor = TransmissionObject.Instance.ReadUInt16();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            _local_3.karma = TransmissionObject.Instance.ReadUInt8();
            _local_3.sex = TransmissionObject.Instance.ReadUInt8();
            var _local_9:ByteArray = new ByteArray();
            TransmissionObject.Instance.ReadBytes(_local_9, 0, 3);
            _local_3.coordinates.SetEncoded3(_local_9);
            _local_3.baseLevel = TransmissionObject.Instance.ReadUInt16();
            _local_3.isStatusesLoaded = true;
            var _local_10:ActorDisplayEvent = new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_INFO_UPDATED);
            _local_10.disguiseId = _local_3.jobId;
            _local_10.option = _local_6;
            _local_10.option1 = _local_4;
            _local_10.option2 = _local_5;
            _local_10.withOptions = true;
            dispatchEvent(_local_10);
            if (!_local_3.isNameLoaded)
            {
                this.SendGetPlayerName(_local_2);
            };
            return (true);
        }

        private function ReceivedActorChangeStatus():Boolean
        {
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 13)
            {
                return (false);
            };
            var _local_2:ActorChangeStatusEvent = new ActorChangeStatusEvent();
            _local_2.characterId = TransmissionObject.Instance.ReadUInt32();
            _local_2.option1 = TransmissionObject.Instance.ReadUInt16();
            _local_2.option2 = TransmissionObject.Instance.ReadUInt16();
            _local_2.option = TransmissionObject.Instance.ReadUInt32();
            _local_2.isPk = TransmissionObject.Instance.ReadUInt8();
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedActorIdleDisplay():Boolean
        {
			trace("ReceivedActorIdleDisplay");
            var _local_2:uint;
            var _local_3:CharacterInfo;
            var _local_7:int;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
			trace("ReceivedActorIdleDisplay_local_1: " + _local_1);
            if (_local_1 < 56)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this._actors.GetActor(_local_2);
            _local_3.walkSpeed = TransmissionObject.Instance.ReadUInt16();
            var _local_4:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_5:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_6:uint = TransmissionObject.Instance.ReadUInt32();
            _local_3.jobId = TransmissionObject.Instance.ReadUInt16();
            _local_7 = TransmissionObject.Instance.ReadUInt16();
            var _local_8:* = (_local_7 & 0xFF);
            _local_3.rightHandRefineLevel = ((_local_7 >> 12) & 0x0F);
            _local_3.leftHandRefineLevel = ((_local_7 >> 8) & 0x0F);
            var _local_9:int = _local_3.viewWeapon;
            var _local_10:int = _local_3.viewShield;
            _local_3.viewWeapon = TransmissionObject.Instance.ReadUInt16();
            _local_3.viewShield = TransmissionObject.Instance.ReadUInt16();
            if (((!(_local_9 == _local_3.viewWeapon)) || (!(_local_10 == _local_3.viewShield))))
            {
                dispatchEvent(new ActorViewIdEvent(_local_3, ActorViewIdEvent.ON_ACTOR_VIEWID_UPDATE));
            };
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            _local_3.viewHead = TransmissionObject.Instance.ReadUInt16();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            _local_3.hairColor = TransmissionObject.Instance.ReadUInt16();
            _local_3.clothesColor = TransmissionObject.Instance.ReadUInt16();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 4);
            _local_3.guildEmblem = TransmissionObject.Instance.ReadUInt16();
            _local_3.manner = TransmissionObject.Instance.ReadUInt16();
            var _local_11:uint = TransmissionObject.Instance.ReadUInt32();
            _local_3.karma = TransmissionObject.Instance.ReadUInt8();
            _local_3.sex = TransmissionObject.Instance.ReadUInt8();
            var _local_12:ByteArray = new ByteArray();
            TransmissionObject.Instance.ReadBytes(_local_12, 0, 3);
            _local_3.coordinates.SetEncoded3(_local_12);
            _local_3.Support = (TransmissionObject.Instance.ReadUInt8() > 0);
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 1);
            _local_3.isDead = TransmissionObject.Instance.ReadUInt8();
            _local_3.baseLevel = TransmissionObject.Instance.ReadUInt16();
            _local_3.isStatusesLoaded = true;
            var _local_13:ActorDisplayEvent = new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_INFO_UPDATED);
            _local_13.disguiseId = _local_3.jobId;
            _local_13.option = _local_6;
            _local_13.option1 = _local_4;
            _local_13.option2 = _local_5;
            _local_13.option3 = _local_11;
            _local_13.withOptions = true;
            dispatchEvent(_local_13);
            var _local_14:CharacterEvent = new CharacterEvent(CharacterEvent.ON_MANNER_UPDATED, _local_3);
            _local_14.Result = CharacterInfo.SP_MANNER;
            dispatchEvent(_local_14);
            var _local_15:ActorChangeStatusEvent = new ActorChangeStatusEvent();
            _local_15.characterId = _local_2;
            _local_15.option1 = _local_4;
            _local_15.option2 = _local_5;
            _local_15.option = _local_6;
            dispatchEvent(_local_15);
            if (!_local_3.isNameLoaded)
            {
                this.SendGetPlayerName(_local_2);
            };
            return (true);
        }

        private function ReceivedActorSpawnDisplay():Boolean
        {
            var _local_2:uint;
            var _local_3:CharacterInfo;
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:uint;
            var _local_12:ByteArray;
            var _local_13:ActorDisplayEvent;
            var _local_14:CharacterEvent;
            var _local_1:uint = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 55)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this._actors.GetActor(_local_2);
            _local_3.walkSpeed = TransmissionObject.Instance.ReadUInt16();
            _local_4 = TransmissionObject.Instance.ReadUInt16();
            _local_5 = TransmissionObject.Instance.ReadUInt16();
            _local_6 = TransmissionObject.Instance.ReadUInt32();
            _local_3.jobId = TransmissionObject.Instance.ReadUInt16();
            _local_7 = TransmissionObject.Instance.ReadUInt16();
            var _local_8:* = (_local_7 & 0xFF);
            _local_3.rightHandRefineLevel = ((_local_7 >> 12) & 0x0F);
            _local_3.leftHandRefineLevel = ((_local_7 >> 8) & 0x0F);
            _local_9 = _local_3.viewWeapon;
            _local_10 = _local_3.viewShield;
            _local_3.viewWeapon = TransmissionObject.Instance.ReadUInt16();
            _local_3.viewShield = TransmissionObject.Instance.ReadUInt16();
            if (((!(_local_9 == _local_3.viewWeapon)) || (!(_local_10 == _local_3.viewShield))))
            {
                dispatchEvent(new ActorViewIdEvent(_local_3, ActorViewIdEvent.ON_ACTOR_VIEWID_UPDATE));
            };
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            _local_3.viewHead = TransmissionObject.Instance.ReadUInt16();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            _local_3.hairColor = TransmissionObject.Instance.ReadUInt16();
            _local_3.clothesColor = TransmissionObject.Instance.ReadUInt16();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 4);
            _local_3.guildEmblem = TransmissionObject.Instance.ReadUInt16();
            _local_3.manner = TransmissionObject.Instance.ReadUInt16();
            _local_11 = TransmissionObject.Instance.ReadUInt32();
            _local_3.karma = TransmissionObject.Instance.ReadUInt8();
            _local_3.sex = TransmissionObject.Instance.ReadUInt8();
            _local_12 = new ByteArray();
            TransmissionObject.Instance.ReadBytes(_local_12, 0, 3);
            _local_3.coordinates.SetEncoded3(_local_12);
            _local_3.Support = (TransmissionObject.Instance.ReadUInt8() > 0);
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 1);
            _local_3.baseLevel = TransmissionObject.Instance.ReadUInt16();
            _local_3.isStatusesLoaded = true;
            _local_13 = new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_INFO_UPDATED);
            _local_13.disguiseId = _local_3.jobId;
            _local_13.option = _local_6;
            _local_13.option1 = _local_4;
            _local_13.option2 = _local_5;
            _local_13.option3 = _local_11;
            _local_13.withOptions = true;
            dispatchEvent(_local_13);
            _local_14 = new CharacterEvent(CharacterEvent.ON_MANNER_UPDATED, _local_3);
            _local_14.Result = CharacterInfo.SP_MANNER;
            dispatchEvent(_local_14);
            if (!_local_3.isNameLoaded)
            {
                this.SendGetPlayerName(_local_2);
            };
            return (true);
        }

        private function ReceivedActorWalkingDisplay():Boolean
        {
			trace("ReceivedActorWalkingDisplay");
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:CharacterInfo;
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:int;
            var _local_9:int;
            var _local_10:int;
            var _local_11:uint;
            var _local_12:ByteArray;
            var _local_13:ActorDisplayEvent;
            var _local_14:CharacterEvent;
            var _local_15:ActorChangeStatusEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 62)
            {
                return (false);
            };
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 1);
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this._actors.GetActor(_local_2);
            _local_3.walkSpeed = TransmissionObject.Instance.ReadUInt16();
            _local_4 = TransmissionObject.Instance.ReadUInt16();
            _local_5 = TransmissionObject.Instance.ReadUInt16();
            _local_6 = TransmissionObject.Instance.ReadUInt32();
            _local_3.jobId = TransmissionObject.Instance.ReadUInt16();
            _local_7 = TransmissionObject.Instance.ReadUInt16();
            var _local_8:* = (_local_7 & 0xFF);
            _local_3.rightHandRefineLevel = ((_local_7 >> 12) & 0x0F);
            _local_3.leftHandRefineLevel = ((_local_7 >> 8) & 0x0F);
            _local_9 = _local_3.viewWeapon;
            _local_10 = _local_3.viewShield;
            _local_3.viewWeapon = TransmissionObject.Instance.ReadUInt16();
            _local_3.viewShield = TransmissionObject.Instance.ReadUInt16();
            if (((!(_local_9 == _local_3.viewWeapon)) || (!(_local_10 == _local_3.viewShield))))
            {
                dispatchEvent(new ActorViewIdEvent(_local_3, ActorViewIdEvent.ON_ACTOR_VIEWID_UPDATE));
            };
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 4);
            _local_3.viewHead = TransmissionObject.Instance.ReadUInt16();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            _local_3.hairColor = TransmissionObject.Instance.ReadUInt16();
            _local_3.clothesColor = TransmissionObject.Instance.ReadUInt16();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 4);
            _local_3.guildEmblem = TransmissionObject.Instance.ReadUInt16();
            _local_3.manner = TransmissionObject.Instance.ReadUInt16();
            _local_11 = TransmissionObject.Instance.ReadUInt32();
            _local_3.karma = TransmissionObject.Instance.ReadUInt8();
            _local_3.sex = TransmissionObject.Instance.ReadUInt8();
            _local_12 = new ByteArray();
            TransmissionObject.Instance.ReadBytes(_local_12, 0, 6);
            _local_3.coordinates.SetEncoded6(_local_12);
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            _local_3.baseLevel = TransmissionObject.Instance.ReadUInt16();
            _local_3.isStatusesLoaded = true;
            _local_3.coordinates.isNeedFindPath = true;
            _local_13 = new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_INFO_UPDATED);
            _local_13.disguiseId = _local_3.jobId;
            _local_13.option = _local_6;
            _local_13.option1 = _local_4;
            _local_13.option2 = _local_5;
            _local_13.option3 = _local_11;
            _local_13.withOptions = true;
            dispatchEvent(_local_13);
            _local_14 = new CharacterEvent(CharacterEvent.ON_MANNER_UPDATED, _local_3);
            _local_14.Result = CharacterInfo.SP_MANNER;
            dispatchEvent(_local_14);
            _local_15 = new ActorChangeStatusEvent();
            _local_15.characterId = _local_2;
            _local_15.option1 = _local_4;
            _local_15.option2 = _local_5;
            _local_15.option = _local_6;
            dispatchEvent(_local_15);
			trace("ReceivedActorWalkingDisplay_local_1: " + _local_1);
			trace("ReceivedActorWalkingDisplay_local_2: " + _local_2);
			trace("ReceivedActorWalkingDisplay_local_3.walkSpeed: " + _local_3.walkSpeed);
			trace("ReceivedActorWalkingDisplay_local_4: " + _local_4);
			trace("ReceivedActorWalkingDisplay_local_5: " + _local_5);
			trace("ReceivedActorWalkingDisplay_local_6: " + _local_6);
			trace("ReceivedActorWalkingDisplay_local_3.jobId: " + _local_3.jobId);
			trace("ReceivedActorWalkingDisplay_local_7: " + _local_7);
			trace("ReceivedActorWalkingDisplay_local_3.viewWeapon: " + _local_3.viewWeapon);
			trace("ReceivedActorWalkingDisplay_local_3.viewShield: " + _local_3.viewShield);
			trace("ReceivedActorWalkingDisplay_local_3.viewHead: " + _local_3.viewHead);
			trace("ReceivedActorWalkingDisplay_local_3.hairColor: " + _local_3.hairColor);
			trace("ReceivedActorWalkingDisplay_local_3.clothesColor: " + _local_3.clothesColor);
			trace("ReceivedActorWalkingDisplay_local_3.guildEmblem: " + _local_3.guildEmblem);
			trace("ReceivedActorWalkingDisplay_local_3.manner: " + _local_3.manner);
			trace("ReceivedActorWalkingDisplay_local_11: " + _local_11);
			trace("ReceivedActorWalkingDisplay_local_3.karma: " + _local_3.karma);
			trace("ReceivedActorWalkingDisplay_local_3.sex: " + _local_3.sex);
			trace("ReceivedActorWalkingDisplay_local_3.baseLevel: " + _local_3.baseLevel);
            if (!_local_3.isNameLoaded)
            {
                this.SendGetPlayerName(_local_2);
            };
            return (true);
        }

        private function ReceivedActorDisappeared():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:CharacterInfo;
            var _local_5:ActorDisplayEvent;
            var _local_6:CharacterInfo;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 5)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadUInt8();
            _local_4 = this._actors.GetActor(_local_2);
            if (_local_3 == 1)
            {
                _local_6 = this._actors.GetPlayer();
                if (((!(_local_6.jobId == 8)) && (!(_local_6.jobId == 4032))))
                {
                    this._actors.RemoveActor(_local_2);
                };
            }
            else
            {
                this._actors.RemoveActor(_local_2);
            };
            _local_5 = new ActorDisplayEvent(_local_4, ActorDisplayEvent.ON_ACTOR_DISAPPEAR, _local_3);
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedActorName():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:CharacterInfo;
            var _local_4:ActorDisplayEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < (4 + 24))
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this._actors.GetActor(_local_2);
            _local_3.name = TransmissionObject.Instance.ReadString(24);
            _local_3.isNameLoaded = true;
            _local_4 = new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_NAME_UPDATED);
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedQuitGame():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            return (true);
        }

        private function ReceivedItemUpdate():Boolean
        {
            var _local_1:uint;
            var _local_3:int;
            var _local_4:int;
            var _local_5:CharacterInfo;
            var _local_6:ItemData;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 6)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            _local_3 = TransmissionObject.Instance.ReadUInt16();
            _local_4 = TransmissionObject.Instance.ReadUInt16();
            _local_5 = this.ActorList.GetPlayer();
            _local_6 = _local_5.Items[_local_3];
            if (_local_6)
            {
                _local_6.Upgrade = _local_4;
            };
            dispatchEvent(new RefineResultEvent(RefineResultEvent.ON_REFINE_ITEM_UPDATE, ((_local_6) ? 1 : 0), _local_4, _local_6));
            return (true);
        }

        private function ReceivedItemDurability():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:CharacterInfo;
            var _local_6:ItemData;
            var _local_7:int;
            var _local_8:DurabilityEvent;
            var _local_9:DurabilityEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 6)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            _local_4 = TransmissionObject.Instance.ReadUInt32();
            _local_5 = this.ActorList.GetPlayer();
            _local_6 = _local_5.Items[_local_2];
            if (_local_6)
            {
                _local_6.Cards[4] = _local_3;
            };
            _local_7 = (_local_3 & 0x0FFFFF);
            if (_local_7 == _local_4)
            {
                _local_8 = new DurabilityEvent(DurabilityEvent.ON_REPAIR_ITEM);
                _local_8.Item = _local_6;
                dispatchEvent(_local_8);
            }
            else
            {
                if (((_local_7 * 100) / _local_4) <= 30)
                {
                    _local_9 = new DurabilityEvent(DurabilityEvent.ON_LOW_DURABILITY);
                    _local_9.Durability = _local_7;
                    _local_9.MaxDurability = _local_4;
                    dispatchEvent(_local_9);
                };
            };
            return (true);
        }

        private function ReceivedRepairList():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:CharacterInfo;
            var _local_7:Array;
            var _local_8:int;
            var _local_9:DurabilityEvent;
            var _local_10:int;
            var _local_11:int;
            var _local_12:ItemData;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            _local_3 = TransmissionObject.Instance.ReadUInt8();
            _local_4 = TransmissionObject.Instance.ReadUInt32();
            _local_5 = uint(((_local_2 - 5) / 4));
            _local_6 = this.ActorList.GetPlayer();
            _local_7 = new Array();
            _local_8 = 0;
            while (_local_8 < _local_5)
            {
                _local_10 = TransmissionObject.Instance.ReadUInt16();
                _local_11 = TransmissionObject.Instance.ReadUInt16();
                _local_12 = _local_6.Items[_local_10];
                if (((_local_12) && (_local_12.NameId == _local_11)))
                {
                    _local_7.push(_local_12);
                };
                _local_8++;
            };
            _local_9 = new DurabilityEvent(DurabilityEvent.ON_REPAIR_LIST);
            _local_9.Currency = _local_3;
            _local_9.RepairList = _local_7;
            _local_9.TotalPrice = _local_4;
            dispatchEvent(_local_9);
            return (true);
        }

        private function ReceivedRepairTotalPrice():Boolean
        {
            var _local_1:uint;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:DurabilityEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = (TransmissionObject.Instance.ReadUInt16() - 4);
            _local_3 = TransmissionObject.Instance.ReadUInt8();
            _local_4 = TransmissionObject.Instance.ReadUInt32();
            _local_5 = new DurabilityEvent(DurabilityEvent.ON_REPAIR_TOTAL_PRICE);
            _local_5.Currency = _local_3;
            _local_5.TotalPrice = _local_4;
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedChangeMapCell():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 22)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_3:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_4:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_5:String = TransmissionObject.Instance.ReadString(16);
            return (true);
        }

        private function ReceivedSolvedActorName():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:String;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < (4 + 24))
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadString(24);
            if (this._charIdToName == null)
            {
                this._charIdToName = new Dictionary(true);
            };
            this._charIdToName[_local_2] = _local_3;
            return (true);
        }

        private function ReceivedActorNameUpdate():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:CharacterInfo;
            var _local_4:String;
            var _local_5:String;
            var _local_6:String;
            var _local_7:ActorDisplayEvent;
            var _local_8:CharacterInfo;
            var _local_9:GuildAllies;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < (4 + (24 * 4)))
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this._actors.GetActor(_local_2);
            _local_3.isNameLoaded = true;
            _local_3.name = TransmissionObject.Instance.ReadString(24);
            _local_4 = TransmissionObject.Instance.ReadString(24);
            _local_5 = TransmissionObject.Instance.ReadString(24);
            _local_6 = TransmissionObject.Instance.ReadString(24);
            _local_3.guildName = ((_local_5.length > 0) ? _local_5 : null);
            _local_3.guildTitle = ((_local_6.length > 0) ? _local_6 : null);
            _local_3.partyName = ((_local_4.length > 0) ? _local_4 : null);
            _local_3.isAllie = false;
            if (!_local_3.Support)
            {
                if (_local_3.guildName == null)
                {
                    _local_3.Guild = null;
                    _local_3.guildEmblem = 0;
                }
                else
                {
                    _local_8 = this._actors.GetPlayer();
                    if (_local_8.guildName != null)
                    {
                        if (_local_8.guildName == _local_3.guildName)
                        {
                            _local_3.isAllie = true;
                        }
                        else
                        {
                            if (_local_8.Guild.Allies != null)
                            {
                                for each (_local_9 in _local_8.Guild.Allies)
                                {
                                    if (_local_9.Name == _local_3.guildName)
                                    {
                                        _local_3.isAllie = true;
                                        break;
                                    };
                                };
                            };
                        };
                    };
                };
            };
            _local_7 = new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_NAME_UPDATED);
            dispatchEvent(_local_7);
            return (true);
        }

        private function ReceivedActorStatusActive():Boolean
        {
            var _local_1:uint;
            var _local_2:ActorActiveStatusEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 7)
            {
                return (false);
            };
            _local_2 = new ActorActiveStatusEvent();
            _local_2.statusType = TransmissionObject.Instance.ReadUInt16();
            _local_2.characterId = TransmissionObject.Instance.ReadUInt32();
            _local_2.flag = TransmissionObject.Instance.ReadUInt8();
            _local_2.duration = TransmissionObject.Instance.ReadUInt32();
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedGuildSkillList():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:Dictionary;
            var _local_4:int;
            var _local_5:GuildInfo;
            var _local_6:uint;
            var _local_7:int;
            var _local_8:int;
            var _local_9:SkillData;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            _local_3 = this.ActorList.GetPlayer().Skills;
            _local_4 = TransmissionObject.Instance.ReadUInt16();
            _local_5 = this.ActorList.GetPlayer().Guild;
            if (_local_5 != null)
            {
                _local_5.SkillPoints = _local_4;
            };
            _local_6 = uint(((_local_2 - 2) / 37));
            _local_7 = 0;
            while (_local_7 < _local_6)
            {
                _local_8 = TransmissionObject.Instance.ReadUInt16();
                _local_9 = new SkillData();
                _local_3[_local_8] = _local_9;
                _local_9.Id = _local_8;
                _local_9.Info = TransmissionObject.Instance.ReadUInt16();
                TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
                _local_9.Lv = TransmissionObject.Instance.ReadUInt16();
                _local_9.Sp = TransmissionObject.Instance.ReadUInt16();
                _local_9.Range = TransmissionObject.Instance.ReadUInt16();
                _local_9.Name = TransmissionObject.Instance.ReadString(24);
                _local_9.SkillTree = TransmissionObject.Instance.ReadUInt8();
                _local_7++;
            };
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_GUILD_SKILLS_CHANGED));
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_HOTKEYS_RECEIVED));
            return (true);
        }

        private function ReceivedSkillList():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:Dictionary;
            var _local_4:uint;
            var _local_5:int;
            var _local_6:int;
            var _local_7:SkillData;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            _local_3 = this.ActorList.GetPlayer().Skills;
            _local_4 = uint((_local_2 / 37));
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_6 = TransmissionObject.Instance.ReadUInt16();
                _local_7 = new SkillData();
                _local_3[_local_6] = _local_7;
                _local_7.Id = _local_6;
                _local_7.Info = TransmissionObject.Instance.ReadUInt16();
                TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
                _local_7.Lv = TransmissionObject.Instance.ReadUInt16();
                _local_7.Sp = TransmissionObject.Instance.ReadUInt16();
                _local_7.Range = TransmissionObject.Instance.ReadUInt16();
                _local_7.Name = TransmissionObject.Instance.ReadString(24);
                _local_7.SkillTree = TransmissionObject.Instance.ReadUInt8();
                _local_5++;
            };
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_SKILLS_CHANGED));
            return (true);
        }

        private function ReceivedSkillFail():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:String;
            var _local_6:CharacterEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 8)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 1);
            _local_4 = TransmissionObject.Instance.ReadUInt8();
            switch (_local_2)
            {
                case 1:
                    _local_5 = (((ClientApplication.Localization.SKILL_FAIL_REASONS[0] + " ") + ClientApplication.Localization.SKILL_FAIL_BTYPE_MESSAGES[_local_3]) + ".");
                    break;
                case 27:
                    _local_5 = ClientApplication.Localization.SKILL_FAIL_REASONS[1];
                    break;
                case 41:
                    _local_5 = ClientApplication.Localization.INVENTORY_CART_DIALOG_MESSAGE1;
                    break;
                case 50:
                    _local_5 = ClientApplication.Localization.SKILL_FAIL_REASONS[2];
                    break;
                case 52:
                    _local_5 = ClientApplication.Localization.SKILL_FAIL_REASONS[3];
                    break;
                case 54:
                    _local_5 = ClientApplication.Localization.SKILL_FAIL_REASONS[3];
                    break;
                default:
                    _local_5 = ClientApplication.Localization.SKILL_FAIL_REASONS[4];
            };
            _local_5 = (_local_5 + (((("\n" + ClientApplication.Localization.SKILL_FAIL_REASONS[5]) + " ") + ClientApplication.Localization.SKILL_FAIL_TYPE_MESSAGES[_local_4]) + "."));
            _local_6 = new CharacterEvent(CharacterEvent.ON_SKILL_USE_FAILED, this.ActorList.GetPlayer(), _local_5);
            _local_6.Result = _local_2;
            dispatchEvent(_local_6);
            return (true);
        }

        private function ReceivedSkillUpdate():Boolean
        {
            var _local_1:uint;
            var _local_2:Dictionary;
            var _local_3:int;
            var _local_4:SkillData;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 9)
            {
                return (false);
            };
            _local_2 = this.ActorList.GetPlayer().Skills;
            _local_3 = TransmissionObject.Instance.ReadUInt16();
            _local_4 = _local_2[_local_3];
            if (_local_4 != null)
            {
                _local_4.Lv = TransmissionObject.Instance.ReadUInt16();
                _local_4.Sp = TransmissionObject.Instance.ReadUInt16();
                _local_4.Range = TransmissionObject.Instance.ReadUInt16();
                TransmissionObject.Instance.ReadUInt8();
            }
            else
            {
                TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 7);
            };
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_SKILL_CHANGED, null, _local_3.toString()));
            return (true);
        }

        private function ReceivedSkillHeal():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadInt16();
            _local_3 = TransmissionObject.Instance.ReadInt16();
            dispatchEvent(new SkillHealEvent(_local_2, _local_3));
            return (true);
        }

        private function ReceivedSkillCasting():Boolean
        {
            var _local_1:uint;
            var _local_2:SkillCastEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 22)
            {
                return (false);
            };
            _local_2 = new SkillCastEvent();
            _local_2.SourceId = TransmissionObject.Instance.ReadUInt32();
            _local_2.TargetId = TransmissionObject.Instance.ReadInt32();
            _local_2.TargetX = TransmissionObject.Instance.ReadInt16();
            _local_2.TargetY = TransmissionObject.Instance.ReadInt16();
            _local_2.SkillId = TransmissionObject.Instance.ReadInt16();
            _local_2.TypeId = TransmissionObject.Instance.ReadInt32();
            _local_2.CastTime = TransmissionObject.Instance.ReadInt32();
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedSlide():Boolean
        {
			trace("ReceivedSlide");
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:int;
            var _local_4:int;
            var _local_5:CharacterInfo;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
			trace("ReceivedSlide_local_1: " + _local_1);
            if (_local_1 < 8)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadInt16();
            _local_4 = TransmissionObject.Instance.ReadInt16();
            _local_5 = this.ActorList.GetActor(_local_2);
            if (_local_5 != null)
            {
                _local_5.coordinates.x1 = (_local_5.coordinates.x = _local_3);
                _local_5.coordinates.y1 = (_local_5.coordinates.y = _local_4);
                _local_5.coordinates.isNeedFindPath = false;
            };
            return (true);
        }

        private function ReceivedEffect():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 8)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt32();
            var _local_3:int = TransmissionObject.Instance.ReadInt32();
            return (true);
        }

        private function ReceivedPVPInfo():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 20)
            {
                return (false);
            };
            TransmissionObject.Instance.ReadInt32();
            TransmissionObject.Instance.ReadInt32();
            var _local_2:int = TransmissionObject.Instance.ReadInt32();
            var _local_3:int = TransmissionObject.Instance.ReadInt32();
            var _local_4:int = TransmissionObject.Instance.ReadInt32();
            return (true);
        }

        private function ReceivedActorHpUpdate():Boolean
        {
            var _local_1:uint;
            var _local_2:ActorHpUpdateEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 12)
            {
                return (false);
            };
            _local_2 = new ActorHpUpdateEvent();
            _local_2.CharacterId = TransmissionObject.Instance.ReadUInt32();
            _local_2.CurrentHP = TransmissionObject.Instance.ReadInt32();
            _local_2.MaximumHP = TransmissionObject.Instance.ReadInt32();
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedSkillUse():Boolean
        {
            var _local_1:uint;
            var _local_2:SkillUseEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 31)
            {
                return (false);
            };
            _local_2 = new SkillUseEvent();
            _local_2.skillId = TransmissionObject.Instance.ReadInt16();
            _local_2.srcId = TransmissionObject.Instance.ReadUInt32();
            _local_2.dstId = TransmissionObject.Instance.ReadUInt32();
            _local_2.tick = TransmissionObject.Instance.ReadInt32();
            _local_2.sdelay = TransmissionObject.Instance.ReadInt32();
            _local_2.ddelay = TransmissionObject.Instance.ReadInt32();
            _local_2.damage = TransmissionObject.Instance.ReadInt32();
            _local_2.skillLevel = TransmissionObject.Instance.ReadInt16();
            _local_2.div = TransmissionObject.Instance.ReadInt16();
            _local_2.skillType = TransmissionObject.Instance.ReadUInt8();
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedSkillUnit():Boolean
        {
            var _local_1:uint;
            var _local_2:SkillUnitEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 14)
            {
                return (false);
            };
            _local_2 = new SkillUnitEvent();
            _local_2.UnitId = TransmissionObject.Instance.ReadInt32();
            _local_2.GroupSourceCharacterId = TransmissionObject.Instance.ReadInt32();
            _local_2.X = TransmissionObject.Instance.ReadInt16();
            _local_2.Y = TransmissionObject.Instance.ReadInt16();
            _local_2.Flag = TransmissionObject.Instance.ReadUInt8();
            _local_2.Flag2 = TransmissionObject.Instance.ReadUInt8();
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedGraffiti():Boolean
        {
            var _local_1:uint;
            var _local_2:SkillUnitEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 14)
            {
                return (false);
            };
            _local_2 = new SkillUnitEvent();
            _local_2.UnitId = TransmissionObject.Instance.ReadInt32();
            _local_2.GroupSourceCharacterId = TransmissionObject.Instance.ReadInt32();
            _local_2.X = TransmissionObject.Instance.ReadInt16();
            _local_2.Y = TransmissionObject.Instance.ReadInt16();
            _local_2.Flag = TransmissionObject.Instance.ReadUInt8();
            _local_2.Flag2 = TransmissionObject.Instance.ReadUInt8();
            Rabbitgedon.RunRabbitgedon(_local_2.X, _local_2.Y, 20, 100, 0.2);
            return (true);
        }

        private function ReceivedClearCharSkillUnit():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadInt32();
            dispatchEvent(new SkillUnitClearEvent(_local_2));
            return (true);
        }

        private function ReceivedCartInfo():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 12)
            {
                return (false);
            };
            if (this._cart == null)
            {
                this._cart = new CartData();
            };
            this._cart.Amount = TransmissionObject.Instance.ReadUInt16();
            this._cart.MaxAmount = TransmissionObject.Instance.ReadUInt16();
            this._cart.Weight = TransmissionObject.Instance.ReadUInt32();
            this._cart.MaxWeight = TransmissionObject.Instance.ReadUInt32();
            dispatchEvent(new CartEvent(CartEvent.ON_CART_STATUS_UPDATED));
            return (true);
        }

        private function ReceivedCartItemsNonStackable():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:int;
            var _local_5:int;
            var _local_6:ItemData;
            var _local_7:int;
            var _local_8:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            if (this.Cart == null)
            {
                this.Cart = new CartData();
            };
            _local_3 = uint((_local_2 / 44));
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_5 = TransmissionObject.Instance.ReadUInt16();
                _local_6 = this.Cart.Cart[_local_5];
                if (_local_6 == null)
                {
                    _local_6 = (this.Cart.Cart[_local_5] = new ItemData());
                };
                _local_6.Id = _local_5;
                _local_6.Origin = ItemData.CART;
                _local_6.NameId = TransmissionObject.Instance.ReadUInt16();
                _local_6.Amount = 1;
                _local_6.Type = TransmissionObject.Instance.ReadUInt8();
                _local_6.Identified = TransmissionObject.Instance.ReadUInt8();
                _local_6.TypeEquip = TransmissionObject.Instance.ReadUInt16();
                _local_6.Equip = TransmissionObject.Instance.ReadUInt16();
                _local_6.Attr = TransmissionObject.Instance.ReadUInt8();
                _local_6.Upgrade = TransmissionObject.Instance.ReadUInt8();
                _local_6.Cards = new Vector.<int>();
                _local_7 = 0;
                while (_local_7 < ItemData.MAX_SLOTS)
                {
                    _local_8 = ((_local_7 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                    _local_6.Cards.push(_local_8);
                    _local_7++;
                };
                _local_4++;
            };
            dispatchEvent(new CartEvent(CartEvent.ON_CART_UPDATED));
            return (true);
        }

        private function ReceivedCartItemsRemoved():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:int;
            var _local_4:ItemData;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 6)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            if (this.Cart == null)
            {
                return (true);
            };
            _local_4 = this.Cart.Cart[_local_2];
            _local_4.Amount = (_local_4.Amount - _local_3);
            if (_local_4.Amount <= 0)
            {
                delete this.Cart.Cart[_local_2];
            };
            dispatchEvent(new CartEvent(CartEvent.ON_CART_UPDATED));
            return (true);
        }

        private function ReceivedVendingOpen():Boolean
        {
            var _local_1:uint;
            var _local_3:StoreEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt16();
            _local_3 = new StoreEvent(StoreEvent.ON_VENDER_OPENED);
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedVenderAppeared():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:String;
            var _local_4:CharacterInfo;
            var _local_5:ActorDisplayEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 84)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadString(80);
            _local_4 = this.ActorList.GetActor(_local_2);
            if (_local_4 != null)
            {
                _local_4.VenderName = _local_3;
            };
            _local_5 = new ActorDisplayEvent(_local_4, ActorDisplayEvent.ON_ACTOR_NAME_UPDATED);
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedVenderLost():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:CharacterInfo;
            var _local_4:ActorDisplayEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this.ActorList.GetActor(_local_2);
            if (_local_3 != null)
            {
                _local_3.VenderName = null;
            };
            _local_4 = new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_NAME_UPDATED);
            dispatchEvent(_local_4);
            if (_local_2 == this._venderId)
            {
                this._venderId = -1;
                dispatchEvent(new StoreEvent(StoreEvent.ON_VENDER_CLOSED, -1, null));
            };
            return (true);
        }

        private function ReceivedVenderItemList():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:int;
            var _local_4:Array;
            var _local_5:int;
            var _local_6:StoreEvent;
            var _local_7:ItemData;
            var _local_8:int;
            var _local_9:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if (_local_1 < _local_2)
            {
                return (false);
            };
            this._venderId = TransmissionObject.Instance.ReadUInt32();
            _local_3 = int(((_local_2 - 4) / 46));
            _local_4 = new Array();
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                _local_7 = new ItemData();
                _local_7.Price = TransmissionObject.Instance.ReadUInt32();
                _local_7.Amount = TransmissionObject.Instance.ReadUInt16();
                _local_7.Id = TransmissionObject.Instance.ReadUInt16();
                _local_7.Type = TransmissionObject.Instance.ReadUInt8();
                _local_7.NameId = TransmissionObject.Instance.ReadUInt16();
                _local_7.Identified = TransmissionObject.Instance.ReadUInt8();
                _local_7.Attr = TransmissionObject.Instance.ReadUInt8();
                _local_7.Upgrade = TransmissionObject.Instance.ReadUInt8();
                _local_7.Origin = ItemData.VENDER;
                _local_7.Cards = new Vector.<int>();
                _local_8 = 0;
                while (_local_8 < ItemData.MAX_SLOTS)
                {
                    _local_9 = ((_local_8 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                    _local_7.Cards.push(_local_9);
                    _local_8++;
                };
                _local_4.push(_local_7);
                _local_5++;
            };
            _local_6 = new StoreEvent(StoreEvent.ON_VENDER_BUY_LIST, -1, _local_4);
            dispatchEvent(_local_6);
            return (true);
        }

        private function ReceivedVenderBuyFail():Boolean
        {
            var _local_1:uint;
            var _local_4:int;
            var _local_5:NpcStoreDealEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 5)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt16();
            _local_4 = TransmissionObject.Instance.ReadUInt8();
            if (_local_4 == 4)
            {
                _local_4 = 5;
            };
            _local_5 = new NpcStoreDealEvent(NpcStoreDealEvent.ON_PLAYER_BUY, _local_4);
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedVendingStarted():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_4:uint;
            var _local_5:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            var _local_3:uint = TransmissionObject.Instance.ReadUInt32();
            _local_4 = uint((_local_2 / 46));
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 46);
                _local_5++;
            };
            dispatchEvent(new StoreEvent(StoreEvent.ON_VENDER_STARTED));
            return (true);
        }

        private function ReceivedVendingReport():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt16();
            return (true);
        }

        private function ReceivedSkillUsedNoDamage():Boolean
        {
            var _local_1:uint;
            var _local_2:SkillCastNoDamage;
            var _local_3:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 13)
            {
                return (false);
            };
            _local_2 = new SkillCastNoDamage();
            _local_2.SkillId = TransmissionObject.Instance.ReadInt16();
            _local_2.Heal = TransmissionObject.Instance.ReadInt16();
            _local_2.TargetId = TransmissionObject.Instance.ReadUInt32();
            _local_2.SourceId = TransmissionObject.Instance.ReadUInt32();
            _local_2.Fail = TransmissionObject.Instance.ReadUInt8();
            if (_local_2.Fail == 1)
            {
                _local_3 = 0;
                switch (_local_2.SkillId)
                {
                    case 50:
                        _local_3 = 304;
                        break;
                    case 211:
                        _local_3 = 305;
                        break;
                    case 215:
                        _local_3 = 303;
                        break;
                    case 216:
                        _local_3 = 301;
                        break;
                    case 217:
                        _local_3 = 302;
                        break;
                    case 218:
                        _local_3 = 300;
                        break;
                    case 548:
                        _local_3 = 306;
                        break;
                    case 1001:
                        _local_3 = 308;
                        break;
                };
                if (_local_3 > 0)
                {
                    dispatchEvent(new ChatMessage(-1, -1, 0, _local_2.TargetId, ChatMessage.ON_EMOTION, _local_3.toString(), null));
                };
            };
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedSkillWarpPoint():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 66)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadInt16();
            var _local_3:String = TransmissionObject.Instance.ReadString(16);
            var _local_4:String = TransmissionObject.Instance.ReadString(16);
            var _local_5:String = TransmissionObject.Instance.ReadString(16);
            var _local_6:String = TransmissionObject.Instance.ReadString(16);
            return (true);
        }

        private function ReceivedUpdateCash():Boolean
        {
			trace("ReceivedUpdateCash");
            var _local_1:uint;
            var _local_2:CharacterInfo;
            var _local_3:int;
            var _local_4:UpdateCashEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 8)
            {
                return (false);
            };
            _local_2 = this.ActorList.GetPlayer();
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            _local_2.kafraPoints = TransmissionObject.Instance.ReadUInt32();
            if (_local_2.cashPoints > 0)
            {
                _local_2.lastGold = (_local_3 - _local_2.cashPoints);
            };
            _local_2.cashPoints = _local_3;
            _local_4 = new UpdateCashEvent(_local_2.cashPoints, _local_2.kafraPoints);
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedUpdatePremium():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 6)
            {
                return (false);
            };
            this._premiumType = TransmissionObject.Instance.ReadUInt16();
            this._premiumUntil = TransmissionObject.Instance.ReadUInt32();
            dispatchEvent(new UpdatePremiumEvent());
            return (true);
        }

        private function ReceivedUpdateQuests():Boolean
        {
			trace("ReceivedUpdateQuests");
            var _local_1:uint;
            var _local_2:int;
            var _local_3:CharacterInfo;
            var _local_4:Dictionary;
            var _local_5:int;
            var _local_6:int;
            var _local_7:int;
            var _local_8:UpdateQuestsEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
			trace("ReceivedUpdateQuests_local_1: " + _local_1);
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            if (_local_1 < (2 + (3 * _local_2)))
            {
                return (false);
            };
			trace("ReceivedUpdateQuests_local_2: " + _local_2);
            _local_3 = this.ActorList.GetPlayer();
            _local_4 = new Dictionary(true);
            _local_5 = 0;
            _local_6 = 0;
            _local_7 = 0;
            while (_local_7 < _local_2)
            {
                _local_5 = TransmissionObject.Instance.ReadUInt16();
                _local_6 = TransmissionObject.Instance.ReadUInt8();
                _local_4[_local_5] = _local_6;
                _local_7++;
            };
            _local_3.QuestStates = _local_4;
            _local_8 = new UpdateQuestsEvent();
            dispatchEvent(_local_8);
            return (true);
        }

        private function ReceivedGift():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 8)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt8();
            _local_3 = TransmissionObject.Instance.ReadUInt8();
            _local_4 = TransmissionObject.Instance.ReadUInt32();
            _local_5 = TransmissionObject.Instance.ReadUInt16();
            dispatchEvent(new GiftItemEvent(_local_2, _local_3, _local_4, _local_5));
            return (true);
        }

        private function ReceivedEquipCheckBox():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            return (true);
        }

        private function ReceivedEquipTickAck():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 8)
            {
                return (false);
            };
            TransmissionObject.Instance.ReadUInt32();
            var _local_2:int = TransmissionObject.Instance.ReadUInt32();
            return (true);
        }

        private function ReceivedViewPlayerEquip():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:String;
            var _local_4:int;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:int;
            var _local_8:uint;
            var _local_9:int;
            var _local_10:int;
            var _local_11:ItemData;
            var _local_12:int;
            var _local_13:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            _local_3 = TransmissionObject.Instance.ReadString(24);
            _local_4 = TransmissionObject.Instance.ReadUInt16();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 2);
            _local_5 = TransmissionObject.Instance.ReadUInt16();
            _local_6 = TransmissionObject.Instance.ReadUInt16();
            _local_7 = TransmissionObject.Instance.ReadUInt8();
            _local_8 = uint(((_local_2 - 39) / 50));
            this.Equips.Amount = _local_8;
            this.Equips.Name = _local_3;
            this.Equips.JobId = _local_4;
            this.Equips.ClothesColor = _local_6;
            this.Equips.Gender = _local_7;
            this.Equips.HairColor = _local_5;
            this.Equips.Clear();
            _local_9 = 0;
            while (_local_9 < _local_8)
            {
                _local_10 = TransmissionObject.Instance.ReadUInt16();
                _local_11 = new ItemData();
                _local_11.Id = _local_10;
                _local_11.NameId = TransmissionObject.Instance.ReadUInt16();
                _local_11.Amount = 1;
                _local_11.Type = TransmissionObject.Instance.ReadUInt8();
                _local_11.Identified = TransmissionObject.Instance.ReadUInt8();
                _local_11.TypeEquip = TransmissionObject.Instance.ReadUInt16();
                _local_11.Equip = TransmissionObject.Instance.ReadUInt16();
                _local_11.Attr = TransmissionObject.Instance.ReadUInt8();
                _local_11.Upgrade = TransmissionObject.Instance.ReadUInt8();
                _local_11.Origin = ItemData.QUEST;
                _local_11.Cards = new Vector.<int>();
                _local_12 = 0;
                while (_local_12 < ItemData.MAX_SLOTS)
                {
                    _local_13 = ((_local_12 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                    _local_11.Cards.push(((_local_12 != 4) ? _local_13 : 0x300000));
                    _local_12++;
                };
                TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 6);
                if (_local_11.Equip > 0)
                {
                    this.Equips.EquipItem(_local_11);
                };
                _local_9++;
            };
            return (true);
        }

        private function ReceivedViewPlayerEquipFail():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            return (true);
        }

        private function ReceivedRouletteResult():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 5)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadInt32();
            _local_3 = TransmissionObject.Instance.ReadInt8();
            dispatchEvent(new UpdateRouletteCashEvent(_local_2, _local_3));
            return (true);
        }

        private function ReceivedRefineResponse():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 5)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadInt32();
            _local_3 = TransmissionObject.Instance.ReadInt8();
            dispatchEvent(new RefineResultEvent(RefineResultEvent.ON_REFINE_RESPONSE, _local_2, _local_3));
            return (true);
        }

        private function ReceivedCastlesInfo():Boolean
        {
			trace("ReceivedCastlesInfo");
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:Dictionary;
            var _local_5:int;
            var _local_6:CastlesInfoEvent;
            var _local_7:CastleInfo;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            _local_3 = uint((_local_2 / 64));
            _local_4 = new Dictionary(true);
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                _local_7 = new CastleInfo();
                _local_7.mapName = TransmissionObject.Instance.ReadString(12);
                _local_7.castleName = TransmissionObject.Instance.ReadString(24);
                _local_7.guildId = TransmissionObject.Instance.ReadUInt32();
                _local_7.guildName = TransmissionObject.Instance.ReadString(24);
                _local_4.push(_local_7);
                _local_5++;
            };
            _local_6 = new CastlesInfoEvent(CastlesInfoEvent.ON_CASTLES_INFO_UPDATED, _local_4);
            dispatchEvent(_local_6);
            return (true);
        }

        private function ReceivedCastlesInfoEx():Boolean
        {
			trace("ReceivedCastlesInfoEx");
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:uint;
            var _local_8:Dictionary;
            var _local_9:int;
            var _local_10:CastlesInfoEvent;
            var _local_11:CastleInfo;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
			trace("ReceivedCastlesInfoEx_local_1: " + _local_1);
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
			trace("ReceivedCastlesInfoEx_local_2: " + _local_2);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            _local_3 = TransmissionObject.Instance.ReadUInt8();
            _local_4 = TransmissionObject.Instance.ReadUInt8();
            _local_5 = TransmissionObject.Instance.ReadUInt8();
            _local_6 = TransmissionObject.Instance.ReadUInt8();
            _local_7 = uint(((_local_2 - 4) / 94));
			trace("ReceivedCastlesInfoEx_local_7: " + _local_7);
            _local_8 = new Dictionary(true);
            _local_9 = 0;
            while (_local_9 < _local_7)
            {
                _local_11 = new CastleInfo();
                _local_11.castleId = TransmissionObject.Instance.ReadUInt16();
                _local_11.castleName = TransmissionObject.Instance.ReadString(24);
                _local_11.mapName = TransmissionObject.Instance.ReadString(12);
                switch (_local_11.castleId)
                {
                    case 5:
                    case 6:
                    case 7:
                    case 9:
                    case 11:
                    case 12:
                        _local_11.woeDay = 1;
                        _local_11.woeStartHour = _local_4;
                        _local_11.woeEndHour = _local_6;
                        break;
                    case 0:
                    case 1:
                    case 2:
                    case 3:
                    case 4:
                    case 8:
                    case 10:
                        _local_11.woeDay = 0;
                        _local_11.woeStartHour = _local_3;
                        _local_11.woeEndHour = _local_5;
                        break;
                };
                _local_11.guildId = TransmissionObject.Instance.ReadUInt32();
                _local_11.fraction = TransmissionObject.Instance.ReadUInt8();
                _local_11.guildEmblemId = TransmissionObject.Instance.ReadUInt16();
                TransmissionObject.Instance.ReadUInt8();
                _local_11.guildName = TransmissionObject.Instance.ReadString(24);
                _local_11.guildMasterName = TransmissionObject.Instance.ReadString(24);
                _local_8[_local_11.castleId] = _local_11;
                _local_9++;
            };
            _local_10 = new CastlesInfoEvent(CastlesInfoEvent.ON_CASTLES_INFO_UPDATED, _local_8);
            dispatchEvent(_local_10);
            return (true);
        }

        private function ReceivedLaddersInfo():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:Array;
            var _local_5:int;
            var _local_6:LaddersInfoEvent;
            var _local_7:LadderInfo;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            _local_3 = uint((_local_2 / 29));
            _local_4 = new Array();
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                _local_7 = new LadderInfo();
                _local_7.ladderId = TransmissionObject.Instance.ReadUInt32();
                _local_7.mapName = TransmissionObject.Instance.ReadString(12);
                _local_7.maxSize = TransmissionObject.Instance.ReadUInt16();
                _local_7.side1 = TransmissionObject.Instance.ReadUInt16();
                _local_7.side2 = TransmissionObject.Instance.ReadUInt16();
                _local_7.type = TransmissionObject.Instance.ReadUInt8();
                _local_7.status = TransmissionObject.Instance.ReadUInt8();
                _local_7.level = TransmissionObject.Instance.ReadUInt8();
                _local_7.creationTime = TransmissionObject.Instance.ReadUInt32();
                _local_4.push(_local_7);
                _local_5++;
            };
            _local_6 = new LaddersInfoEvent(LaddersInfoEvent.ON_LADDERS_INFO_UPDATED, _local_4);
            dispatchEvent(_local_6);
            return (true);
        }

        private function ReceivedMapOnlineInfo():Boolean
        {
            var _local_1:uint;
            var _local_2:String;
            var _local_3:uint;
            var _local_4:MapOnlineInfoEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadString(12);
            _local_3 = TransmissionObject.Instance.ReadUInt16();
            _local_4 = new MapOnlineInfoEvent(MapOnlineInfoEvent.ON_MAP_ONLINE_INFO_UPDATED, _local_2, _local_3);
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedCashshopOpened():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:CharacterInfo;
            var _local_4:int;
            var _local_5:int;
            var _local_6:Array;
            var _local_7:int;
            var _local_8:int;
            var _local_9:int;
            var _local_10:StoreEvent;
            var _local_11:ItemData;
            var _local_12:int;
            var _local_13:int;
            var _local_14:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 13)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < _local_2)
            {
                return (false);
            };
            _local_3 = this.ActorList.GetPlayer();
            _local_3.cashPoints = TransmissionObject.Instance.ReadUInt32();
            _local_3.kafraPoints = TransmissionObject.Instance.ReadUInt32();
            _local_4 = TransmissionObject.Instance.ReadUInt8();
            _local_5 = int(((_local_2 - 9) / 11));
            _local_6 = new Array();
            _local_7 = ((this._actors) ? this._actors.GetPlayerFraction() : CharacterInfo.FRACTION_LIGHT);
            _local_8 = ((_local_7 == CharacterInfo.FRACTION_DARK) ? ItemData.ITEM_ATTRIBUTE_FRACTION : 0);
            _local_9 = 0;
            while (_local_9 < _local_5)
            {
                _local_11 = new ItemData();
                _local_11.Price = TransmissionObject.Instance.ReadUInt32();
                _local_12 = TransmissionObject.Instance.ReadUInt32();
                _local_11.Type = TransmissionObject.Instance.ReadUInt8();
                _local_11.Id = _local_9;
                _local_11.NameId = TransmissionObject.Instance.ReadUInt16();
                _local_11.Identified = 1;
                _local_11.Origin = ((_local_12 == 0) ? ((_local_4 == 0) ? ItemData.CASH : ItemData.KAFRA) : ItemData.ZENY);
                _local_11.Attr = _local_8;
                if ((((_local_11.Type == ItemData.IT_HEALING) || (_local_11.Type == ItemData.IT_USABLE)) || (_local_11.Type == ItemData.IT_ETC)))
                {
                    _local_11.Amount = 20;
                }
                else
                {
                    _local_11.Amount = 1;
                };
                _local_11.Cards = new Vector.<int>();
                _local_13 = 0;
                while (_local_13 < ItemData.MAX_SLOTS)
                {
                    _local_14 = 0;
                    _local_11.Cards.push(_local_14);
                    _local_13++;
                };
                _local_6.push(_local_11);
                _local_9++;
            };
            _local_10 = new StoreEvent(StoreEvent.ON_CASH_BUY_LIST, _local_4, _local_6);
            dispatchEvent(_local_10);
            return (true);
        }

        private function ReceivedCashshopOperation():Boolean
        {
            var _local_1:uint;
            var _local_2:CharacterInfo;
            var _local_3:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 10)
            {
                return (false);
            };
            _local_2 = this.ActorList.GetPlayer();
            _local_2.cashPoints = TransmissionObject.Instance.ReadUInt32();
            _local_2.kafraPoints = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadUInt16();
            dispatchEvent(new StoreEvent(StoreEvent.ON_CASH_BUY_RESULT, 0, null, _local_3));
            return (true);
        }

        private function ReceivedPremiumshopOpened():Boolean
        {
            var _local_1:uint;
            var _local_2:CharacterInfo;
            var _local_3:uint;
            var _local_4:StoreEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 13)
            {
                return (false);
            };
            _local_2 = this.ActorList.GetPlayer();
            _local_2.cashPoints = TransmissionObject.Instance.ReadUInt32();
            _local_2.kafraPoints = TransmissionObject.Instance.ReadUInt32();
            _local_2.money = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadUInt8();
            _local_4 = new StoreEvent(StoreEvent.ON_PREMIUM_BUY_LIST, _local_3);
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedPremiumshopOperation():Boolean
        {
            var _local_1:uint;
            var _local_2:CharacterInfo;
            var _local_3:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 13)
            {
                return (false);
            };
            _local_2 = this.ActorList.GetPlayer();
            _local_2.cashPoints = TransmissionObject.Instance.ReadUInt32();
            _local_2.kafraPoints = TransmissionObject.Instance.ReadUInt32();
            _local_2.money = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadUInt8();
            dispatchEvent(new StoreEvent(StoreEvent.ON_PREMIUM_BUY_RESULT, 0, null, _local_3));
            return (true);
        }

        private function ReceivedCharRenameResult():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            if (_local_2 == 1)
            {
                dispatchEvent(new ClientEvent(ClientEvent.ON_CHARACTER_RENAME_REQUEST_ACCEPTED));
            }
            else
            {
                dispatchEvent(new ClientEvent(ClientEvent.ON_CHARACTER_RENAME_REQUEST_REJECTED));
            };
            return (true);
        }

        private function ReceivedCharRenameConfirmResult():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:Array;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            _local_3 = [ClientEvent.ON_CHARACTER_RENAME_SUCCESSFUL, ClientEvent.ON_CHARACTER_RENAME_ALREADY_CHANGED, ClientEvent.ON_CHARACTER_RENAME_FAILED, ClientEvent.ON_CHARACTER_RENAME_FAILED, ClientEvent.ON_CHARACTER_RENAME_FAILED];
            dispatchEvent(new ClientEvent(_local_3[_local_2]));
            return (true);
        }

        private function ReceivedHotKeys():Boolean
        {
            var _local_1:uint;
            var _local_2:CharacterInfo;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < (HotKeys.MAX_HOTKEYS * 7))
            {
                return (false);
            };
            _local_2 = this.ActorList.GetPlayer();
            _local_3 = 0;
            while (_local_3 < HotKeys.MAX_HOTKEYS)
            {
                _local_4 = TransmissionObject.Instance.ReadUInt8();
                _local_5 = TransmissionObject.Instance.ReadUInt32();
                _local_6 = TransmissionObject.Instance.ReadUInt16();
                _local_2.Hotkeys.SetHotKey(_local_3, _local_4, _local_5, _local_6);
                _local_3++;
            };
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_HOTKEYS_RECEIVED));
            return (true);
        }

        private function ReceivedStatsInitial():Boolean
        {
			trace("ReceivedStatsInitial");
            var _local_1:uint;
            var _local_2:CharacterInfo;
            var _local_3:CharacterEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
			trace("ReceivedStatsInitial_local_1: " + _local_1);
            if (_local_1 < 42)
            {
                return (false);
            };
            _local_2 = this.ActorList.GetPlayer();
            _local_2.statusPoint = TransmissionObject.Instance.ReadInt16();
            _local_2.str = TransmissionObject.Instance.ReadUInt8();
            _local_2.ustr = TransmissionObject.Instance.ReadUInt8();
            _local_2.agi = TransmissionObject.Instance.ReadUInt8();
            _local_2.uagi = TransmissionObject.Instance.ReadUInt8();
            _local_2.vit = TransmissionObject.Instance.ReadUInt8();
            _local_2.uvit = TransmissionObject.Instance.ReadUInt8();
            _local_2.intl = TransmissionObject.Instance.ReadUInt8();
            _local_2.uintl = TransmissionObject.Instance.ReadUInt8();
            _local_2.dex = TransmissionObject.Instance.ReadUInt8();
            _local_2.udex = TransmissionObject.Instance.ReadUInt8();
            _local_2.luk = TransmissionObject.Instance.ReadUInt8();
            _local_2.uluk = TransmissionObject.Instance.ReadUInt8();
            _local_2.atk1 = TransmissionObject.Instance.ReadInt16();
            _local_2.atk2 = TransmissionObject.Instance.ReadInt16();
            _local_2.matkMax = TransmissionObject.Instance.ReadInt16();
            _local_2.matkMin = TransmissionObject.Instance.ReadInt16();
            _local_2.def1 = TransmissionObject.Instance.ReadInt16();
            _local_2.def2 = TransmissionObject.Instance.ReadInt16();
            _local_2.mdef1 = TransmissionObject.Instance.ReadInt16();
            _local_2.mdef2 = TransmissionObject.Instance.ReadInt16();
            _local_2.hit = TransmissionObject.Instance.ReadInt16();
            _local_2.flee1 = TransmissionObject.Instance.ReadInt16();
            _local_2.flee2 = TransmissionObject.Instance.ReadInt16();
            _local_2.critical = TransmissionObject.Instance.ReadInt16();
            _local_2.karma = TransmissionObject.Instance.ReadInt16();
            _local_2.manner = TransmissionObject.Instance.ReadUInt16();
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_STATS_CHANGED));
            _local_3 = new CharacterEvent(CharacterEvent.ON_MANNER_UPDATED, _local_2);
            _local_3.Result = CharacterInfo.SP_MANNER;
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedActorLookAt():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_4:uint;
            var _local_5:CharacterInfo;
            var _local_6:ActorDisplayEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < (((4 + 1) + 1) + 1))
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            var _local_3:uint = TransmissionObject.Instance.ReadUInt16();
            _local_4 = TransmissionObject.Instance.ReadUInt8();
            _local_5 = this._actors.GetActor(_local_2);
            _local_5.coordinates.dir = Coordinates.CONVERT_DIR_SERVER[_local_4];
            _local_6 = new ActorDisplayEvent(_local_5, ActorDisplayEvent.ON_ACTOR_UPDATE_DIR);
            dispatchEvent(_local_6);
            return (true);
        }

        private function ReceivedSync():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            ClientTime.Instance.ServerSync(_local_2);
            return (true);
        }

        private function ReceivedTimeSync():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 6)
            {
                return (false);
            };
            ClientApplication.Instance.timeOnServer = TransmissionObject.Instance.ReadUInt32();
            if (!ClientApplication.Instance.timeOnServerInited)
            {
                ClientApplication.Instance.UpdateServerTime();
            };
            ClientApplication.Instance.timeOnServerInited = true;
            ClientApplication.Instance.users = TransmissionObject.Instance.ReadUInt16();
            ClientApplication.Instance.UpdateElfCounter();
            return (true);
        }

        private function ReceivedSkillMatrix():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if ((_local_1 - 2) < _local_2)
            {
                return (false);
            };
            _local_3 = int((_local_2 / 4));
            _local_4 = 0;
            while (_local_4 < _local_3)
            {
                _local_5 = TransmissionObject.Instance.ReadUInt32();
                _local_4++;
            };
            return (true);
        }

        private function ReceivedPlayerMoves():Boolean
        {
			trace("ReceivedPlayerMoves");
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:ByteArray;
            var _local_4:CharacterInfo;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
			trace("ReceivedPlayerMoves_local_1: " + _local_1);
            if (_local_1 < 10)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = new ByteArray();
            TransmissionObject.Instance.ReadBytes(_local_3, 0, 6);
            _local_4 = this._actors.GetPlayer();
            _local_4.coordinates.SetEncoded6(_local_3);
            _local_4.coordinates.isNeedFindPath = true;
            _local_4.coordinates.syncTime = _local_2;
            return (true);
        }

        private function ReceivedActorDisplayMoves():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:ByteArray;
            var _local_4:CharacterInfo;
            var _local_5:uint;
            var _local_6:ActorDisplayEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 14)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = new ByteArray();
            TransmissionObject.Instance.ReadBytes(_local_3, 0, 6);
            _local_4 = this._actors.GetActor(_local_2);
            _local_4.coordinates.SetEncoded6(_local_3);
            _local_4.coordinates.isNeedFindPath = true;
            _local_5 = TransmissionObject.Instance.ReadUInt32();
            _local_4.coordinates.syncTime = _local_5;
            _local_6 = new ActorDisplayEvent(_local_4, ActorDisplayEvent.ON_ACTOR_MOVES);
            dispatchEvent(_local_6);
            if (!_local_4.isNameLoaded)
            {
                this.SendGetPlayerName(_local_2);
            };
            return (true);
        }

        private function ReceivedActorMovementInterrupted():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:CharacterInfo;
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:ActorDisplayEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 8)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this._actors.GetActor(_local_2);
            _local_4 = TransmissionObject.Instance.ReadUInt16();
            _local_5 = TransmissionObject.Instance.ReadUInt16();
            _local_3.coordinates.x = _local_4;
            _local_3.coordinates.x1 = _local_4;
            _local_3.coordinates.y = _local_5;
            _local_3.coordinates.y1 = _local_5;
            _local_3.coordinates.isNeedFindPath = false;
            _local_6 = new ActorDisplayEvent(_local_3, ActorDisplayEvent.ON_ACTOR_INTERRUPTED);
            dispatchEvent(_local_6);
            return (true);
        }

        private function ReceivedActorAction():Boolean
        {
            var _local_1:uint;
            var _local_2:ActorActionEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 27)
            {
                return (false);
            };
            _local_2 = new ActorActionEvent();
            _local_2.sourceID = TransmissionObject.Instance.ReadUInt32();
            _local_2.targetID = TransmissionObject.Instance.ReadInt32();
            _local_2.tick = TransmissionObject.Instance.ReadInt32();
            _local_2.sourceDelay = TransmissionObject.Instance.ReadInt32();
            _local_2.targetDelay = TransmissionObject.Instance.ReadInt32();
            _local_2.damage = TransmissionObject.Instance.ReadInt16();
            _local_2.div = TransmissionObject.Instance.ReadInt16();
            _local_2.actionType = TransmissionObject.Instance.ReadInt8();
            _local_2.damage2 = TransmissionObject.Instance.ReadInt16();
            dispatchEvent(_local_2);
            return (true);
        }

        protected function ReceivedMoveToAttack():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:CharacterInfo;
            var _local_4:CharacterInfo;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 14)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this._actors.GetActor(_local_2);
            _local_4 = this._actors.GetPlayer();
            _local_3.coordinates.x = TransmissionObject.Instance.ReadInt16();
            _local_3.coordinates.y = TransmissionObject.Instance.ReadInt16();
            _local_4.coordinates.x = TransmissionObject.Instance.ReadInt16();
            _local_4.coordinates.y = TransmissionObject.Instance.ReadInt16();
            _local_4.range = TransmissionObject.Instance.ReadInt16();
            return (true);
        }

        private function ReceivedPartyOrganizeResult():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:PartyEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt8();
            _local_3 = new PartyEvent(PartyEvent.ON_PARTY_CREATION_RESULT);
            _local_3.Result = _local_2;
            if (_local_2 == 0)
            {
                this.SendPartyChangeOption(1);
            };
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedPartyInvitationResult():Boolean
        {
            var _local_1:uint;
            var _local_2:PartyEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = new PartyEvent(PartyEvent.ON_PARTY_MEMBER_JOINED);
            _local_2.CharacterName = TransmissionObject.Instance.ReadString(24);
            _local_2.Result = TransmissionObject.Instance.ReadUInt32();
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedPartyInfo():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:CharacterInfo;
            var _local_4:int;
            var _local_5:int;
            var _local_6:PartyMember;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if (_local_2 > (_local_1 - 2))
            {
                return (false);
            };
            _local_3 = this.ActorList.GetPlayer();
            _local_3.Party = new PartyInfo();
            _local_3.Party.Name = TransmissionObject.Instance.ReadString(24);
            _local_4 = int(((_local_2 - 24) / 46));
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_6 = new PartyMember();
                _local_6.CharacterId = TransmissionObject.Instance.ReadUInt32();
                _local_6.Name = TransmissionObject.Instance.ReadString(24);
                _local_6.MapName = TransmissionObject.Instance.ReadString(16);
                _local_6.Leader = (TransmissionObject.Instance.ReadUInt8() == 0);
                _local_6.Online = (TransmissionObject.Instance.ReadUInt8() == 0);
                _local_3.Party.PartyMembers[_local_6.CharacterId] = _local_6;
                _local_5++;
            };
            dispatchEvent(new PartyEvent(PartyEvent.ON_PARTY_UPDATED));
            return (true);
        }

        private function ReceivedPartyInvite():Boolean
        {
            var _local_1:uint;
            var _local_2:PartyEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = new PartyEvent(PartyEvent.ON_PARTY_JOIN_REQUEST);
            _local_2.CurrentPartyId = TransmissionObject.Instance.ReadUInt32();
            _local_2.PartyName = TransmissionObject.Instance.ReadString(24);
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedPartyMemberInfo():Boolean
        {
            var _local_1:uint;
            var _local_2:CharacterInfo;
            var _local_3:int;
            var _local_4:PartyMember;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 79)
            {
                return (false);
            };
            _local_2 = this.ActorList.GetPlayer();
            if (_local_2.Party == null)
            {
                _local_2.Party = new PartyInfo();
            };
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            _local_4 = _local_2.Party.PartyMembers[_local_3];
            if (_local_4 == null)
            {
                _local_4 = new PartyMember();
                _local_4.CharacterId = _local_3;
                _local_2.Party.PartyMembers[_local_3] = _local_4;
            };
            _local_4.Leader = (TransmissionObject.Instance.ReadUInt32() == 0);
            _local_4.X = TransmissionObject.Instance.ReadUInt16();
            _local_4.Y = TransmissionObject.Instance.ReadUInt16();
            _local_4.Online = (TransmissionObject.Instance.ReadUInt8() == 0);
            var _local_5:String = TransmissionObject.Instance.ReadString(24);
            _local_4.Name = TransmissionObject.Instance.ReadString(24);
            var _local_6:String = TransmissionObject.Instance.ReadString(16);
            var _local_7:int = TransmissionObject.Instance.ReadUInt8();
            var _local_8:int = TransmissionObject.Instance.ReadUInt8();
            dispatchEvent(new PartyEvent(PartyEvent.ON_PARTY_UPDATED));
            return (true);
        }

        private function ReceivedPartyOptions():Boolean
        {
            var _local_1:uint;
            var _local_2:CharacterInfo;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = this.ActorList.GetPlayer();
            if (_local_2.Party == null)
            {
                _local_2.Party = new PartyInfo();
            };
            _local_2.Party.Options1 = TransmissionObject.Instance.ReadUInt16();
            _local_2.Party.Options2 = TransmissionObject.Instance.ReadUInt16();
            return (true);
        }

        private function ReceivedPartyLeave():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:String;
            var _local_5:CharacterInfo;
            var _local_6:PartyEvent;
            var _local_7:CharacterInfo;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 29)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadString(24);
            var _local_4:int = TransmissionObject.Instance.ReadUInt8();
            _local_5 = this.ActorList.GetPlayer();
            if (_local_5.Party == null)
            {
                return (true);
            };
            if (_local_5.characterId == _local_2)
            {
                _local_5.Party = null;
            }
            else
            {
                _local_7 = this.ActorList.actors[_local_2];
                if (_local_7 != null)
                {
                    _local_7.hp = 0;
                    _local_7.maxHp = 0;
                };
                delete _local_5.Party.PartyMembers[_local_2];
            };
            _local_6 = new PartyEvent(PartyEvent.ON_PARTY_LEAVE);
            _local_6.CharacterName = _local_3;
            dispatchEvent(_local_6);
            return (true);
        }

        private function ReceivedDuelInvite():Boolean //Создать дуэль кнопка
        {
            var _local_1:uint;
            var _local_2:DuelEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = new DuelEvent(DuelEvent.ON_DUEL_JOIN_REQUEST);
            _local_2.CharacterId = TransmissionObject.Instance.ReadUInt32();
            _local_2.CharacterName = TransmissionObject.Instance.ReadString(24);
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedPartyHp():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:int;
            var _local_4:int;
            var _local_5:CharacterInfo;
            var _local_6:PartyEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 8)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadUInt16();
            _local_4 = TransmissionObject.Instance.ReadUInt16();
            _local_5 = this.ActorList.GetActor(_local_2);
            _local_5.hp = _local_3;
            _local_5.maxHp = _local_4;
            _local_6 = new PartyEvent(PartyEvent.ON_PARTY_HP_UPDATED);
            _local_6.CharacterId = _local_2;
            dispatchEvent(_local_6);
            return (true);
        }

        private function ReceivedPartyLeaderPosition():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:PartyInfo;
            var _local_6:PartyMember;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 8)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadUInt16();
            _local_4 = TransmissionObject.Instance.ReadUInt16();
            if (this._partyMember == null)
            {
                this._partyMember = new PartyMember();
            };
            this._partyMember.CharacterId = _local_2;
            this._partyMember.X = _local_3;
            this._partyMember.Y = _local_4;
            _local_5 = this.ActorList.GetPlayer().Party;
            if (_local_5 != null)
            {
                _local_6 = _local_5.PartyMembers[_local_2];
                _local_6.X = _local_3;
                _local_6.Y = _local_4;
                _local_5.PartyMembers[_local_2] = _local_6;
            };
            return (true);
        }

        private function ReceivedPartyMessage():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:String;
            var _local_5:ChatMessage;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 8);
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < (_local_2 + 4))
            {
                return (false);
            };
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            _local_4 = TransmissionObject.Instance.ReadString(_local_2);
            _local_5 = new ChatMessage(-1, -1, -1, _local_3, ChatMessage.ON_PARTY_MESSAGE, _local_4, null, 204, 204, 228);
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedMVPItem():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt16();
            return (true);
        }

        private function ReceivedMVPExp():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt32();
            return (true);
        }

        private function ReceivedMVPEffect():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt32();
            return (true);
        }

        private function ReceivedPublicMessage():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:uint;
            var _local_6:int;
            var _local_7:uint;
            var _local_8:uint;
            var _local_9:String;
            var _local_10:int;
            var _local_11:String;
            var _local_12:String;
            var _local_13:ChatMessage;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 12);
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < (_local_2 + 4))
            {
                return (false);
            };
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            _local_4 = TransmissionObject.Instance.ReadUInt16();
            _local_5 = (_local_4 & 0xFF);
            _local_6 = ((_local_4 >> 8) & 0xFF);
            _local_7 = TransmissionObject.Instance.ReadUInt8();
            _local_8 = TransmissionObject.Instance.ReadUInt8();
            _local_9 = TransmissionObject.Instance.ReadString(_local_2);
            if (_local_3 >= 100000000)
            {
                _local_9 = HtmlText.Localize(_local_9);
            };
            _local_10 = _local_9.indexOf(": ");
            _local_11 = ((_local_10 > 0) ? _local_9.substr(0, (_local_10 - 1)) : "");
            _local_12 = ((_local_10 > 0) ? _local_9.substr((_local_10 + 2), 0x1000) : _local_9);
            _local_13 = new ChatMessage(_local_8, _local_5, _local_7, _local_3, ChatMessage.ON_PUBLIC_MESSAGE, ((_local_10 > 0) ? ((_local_11 + " : ") + _local_12) : _local_12));
            _local_13.IsGM = (_local_6 > 0);
            dispatchEvent(_local_13);
            return (true);
        }

        private function ReceivedPrivateMessageStatus():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:ChatMessage;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt8();
            if (_local_2 != 0)
            {
                _local_3 = new ChatMessage(-1, -1, -1, 0, ChatMessage.ON_PRIVATE_MESSAGE, ClientApplication.Localization.CHAT_PRIVATE_RESULT[_local_2], "");
                dispatchEvent(_local_3);
            };
            return (true);
        }

        private function ReceivedGmMessage():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:String;
            var _local_4:ChatMessage;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < _local_2)
            {
                return (false);
            };
            _local_3 = TransmissionObject.Instance.ReadString(_local_2);
            _local_4 = new ChatMessage(-1, -1, -1, 0, ChatMessage.ON_BROADCAST_MESSAGE, _local_3, null, 204, 204, 228);
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedPrivateMessage():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:String;
            var _local_8:String;
            var _local_9:ChatMessage;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < _local_2)
            {
                return (false);
            };
            _local_3 = TransmissionObject.Instance.ReadUInt8();
            _local_4 = (_local_3 & 0x0F);
            _local_5 = ((_local_3 >> 4) & 0x07);
            _local_6 = ((_local_3 >> 7) & 0x01);
            _local_7 = TransmissionObject.Instance.ReadString(24);
            _local_8 = TransmissionObject.Instance.ReadString(((_local_2 - 25) - 1));
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 1);
            _local_9 = new ChatMessage(_local_4, -1, _local_5, 0, ChatMessage.ON_PRIVATE_MESSAGE, _local_8, _local_7);
            _local_9.IsGM = (_local_6 > 0);
            dispatchEvent(_local_9);
            return (true);
        }

        private function ReceivedLocalBroadcast():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:String;
            var _local_8:ChatMessage;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < _local_2)
            {
                return (false);
            };
            _local_3 = TransmissionObject.Instance.ReadUInt8();
            _local_4 = TransmissionObject.Instance.ReadUInt8();
            _local_5 = TransmissionObject.Instance.ReadUInt8();
            TransmissionObject.Instance.ReadUInt8();
            _local_6 = TransmissionObject.Instance.ReadUInt16();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 6);
            _local_7 = TransmissionObject.Instance.ReadString((_local_2 - 12));
            _local_8 = new ChatMessage(_local_6, -1, -1, 0, ChatMessage.ON_BROADCAST_MESSAGE, _local_7, null, _local_5, _local_4, _local_3);
            dispatchEvent(_local_8);
            return (true);
        }

        private function ReceivedGuildChat():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:String;
            var _local_4:ChatMessage;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < _local_2)
            {
                return (false);
            };
            _local_3 = TransmissionObject.Instance.ReadString(_local_2);
            _local_4 = new ChatMessage(-1, -1, -1, 0, ChatMessage.ON_GUILD_MESSAGE, _local_3, null, 204, 204, 228);
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedGuildAllyBreaked():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 8)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt32();
            var _local_3:int = TransmissionObject.Instance.ReadUInt32();
            this.ActorList.GetPlayer().Guild.ClearAllies();
            this.SendGuildRequestInfo(0);
            return (true);
        }

        private function ReceivedGuildCreationStatus():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:GuildEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt8();
            _local_3 = new GuildEvent(GuildEvent.ON_GUILD_CREATION_MESSAGE);
            _local_3.Result = _local_2;
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedGuildInviteAck():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt8();
            return (true);
        }

        private function ReceivedGuildRequest():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:String;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 28)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadString(24);
            dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_JOIN_REQUEST, null, _local_2, _local_3));
            return (true);
        }

        private function ReceivedGuildMasterOrNot():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:GuildInfo;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this.ActorList.GetPlayer().Guild;
            if (_local_3 != null)
            {
                _local_3.IsGuildMaster = (_local_2 == 215);
                if (_local_3.IsGuildMaster)
                {
                    this.SendGuildRequestInfo(3);
                    this.SendGuildRankChange(0, 17, 10, ClientApplication.Localization.GUILD_POSITIONS[0].name);
                    this.SendGuildRankChange(19, 0, 10, ClientApplication.Localization.GUILD_POSITIONS[6].name);
                };
            };
            return (true);
        }

        private function ReceivedGuildEmblem():Boolean
        {
            var _local_1:uint;
            var _local_3:int;
            var _local_4:GuildInfo;
            var _local_5:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 10)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            _local_4 = this._guilds.GetGuild(_local_3);
            _local_5 = TransmissionObject.Instance.ReadUInt32();
            if (_local_5 == -2)
            {
                _local_4.GuildCash = TransmissionObject.Instance.ReadUInt32();
                dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_UPDATED));
            }
            else
            {
                _local_4.Emblem = _local_5;
            };
            return (true);
        }

        private function ReceivedGuildEmblemArea():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:int;
            var _local_4:int;
            var _local_5:CharacterInfo;
            var _local_6:GuildInfo;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 10)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            _local_4 = TransmissionObject.Instance.ReadUInt16();
            _local_5 = this._actors.GetActor(_local_2);
            _local_6 = this._guilds.GetGuild(_local_3);
            _local_5.guildEmblem = _local_4;
            _local_6.Emblem = _local_4;
            return (true);
        }

        private function ReceivedGuildAllianceInfo():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:int;
            var _local_4:GuildInfo;
            var _local_5:int;
            var _local_6:GuildAllies;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if (_local_2 > (_local_1 - 2))
            {
                return (false);
            };
            _local_3 = int((_local_2 / 32));
            _local_4 = this.ActorList.GetPlayer().Guild;
            _local_4.ClearAllies();
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                _local_6 = new GuildAllies();
                _local_6.Opposition = TransmissionObject.Instance.ReadUInt32();
                _local_6.GuildId = TransmissionObject.Instance.ReadUInt32();
                _local_6.Name = TransmissionObject.Instance.ReadString(24);
                _local_4.Allies[_local_6.GuildId] = _local_6;
                _local_5++;
            };
            dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_UPDATED));
            return (true);
        }

        private function ReceivedGuildInfo():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:GuildInfo;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 112)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this._guilds.GetGuild(_local_2);
            _local_3.Lv = TransmissionObject.Instance.ReadUInt32();
            _local_3.MembersConnected = TransmissionObject.Instance.ReadUInt32();
            _local_3.MaxMembers = TransmissionObject.Instance.ReadUInt32();
            _local_3.AverageLv = TransmissionObject.Instance.ReadUInt32();
            _local_3.Exp = TransmissionObject.Instance.ReadUInt32();
            _local_3.NextExp = TransmissionObject.Instance.ReadUInt32();
            _local_3.GuildCash = TransmissionObject.Instance.ReadUInt32();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 8);
            _local_3.Emblem = TransmissionObject.Instance.ReadUInt32();
            _local_3.Name = TransmissionObject.Instance.ReadString(24);
            _local_3.MasterName = TransmissionObject.Instance.ReadString(24);
            var _local_4:String = TransmissionObject.Instance.ReadString(20);
            dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_UPDATED));
            return (true);
        }

        private function ReceivedGuildName():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:GuildInfo;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < (17 + 24))
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = this._guilds.GetGuild(_local_2);
            _local_3.Emblem = TransmissionObject.Instance.ReadUInt32();
            _local_3.Mode = TransmissionObject.Instance.ReadUInt32();
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 5);
            _local_3.Name = TransmissionObject.Instance.ReadString(24);
            this.ActorList.GetPlayer().Guild = _local_3;
            this.ActorList.GetPlayer().guildName = _local_3.Name;
            this.ActorList.GetPlayer().guildEmblem = _local_3.Emblem;
            this.ActorList.GetPlayer().isAllie = false;
            dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_UPDATED));
            this.SendGuildCheckMaster();
            this.SendGuildRequestInfo(0);
            this.SendGuildRequestInfo(1);
            return (true);
        }

        private function ReceivedGuildMemberLogin():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:GuildInfo;
            var _local_6:GuildMember;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 12)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            _local_4 = TransmissionObject.Instance.ReadUInt32();
            _local_5 = this.ActorList.GetPlayer().Guild;
            if (_local_5 == null)
            {
                return (true);
            };
            for each (_local_6 in _local_5.members)
            {
                if (((_local_6.accountId == _local_2) && (_local_6.characterId == _local_3)))
                {
                    _local_6.online = _local_4;
                    break;
                };
            };
            dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_UPDATED));
            return (true);
        }

        private function ReceivedGuildNotice():Boolean
        {
            var _local_1:uint;
            var _local_3:String;
            var _local_4:GuildInfo;
            var _local_5:ChatMessage;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < (60 + 120))
            {
                return (false);
            };
            var _local_2:String = TransmissionObject.Instance.ReadString(60);
            _local_3 = TransmissionObject.Instance.ReadString(120);
            _local_4 = this.ActorList.GetPlayer().Guild;
            if (_local_4 == null)
            {
                return (true);
            };
            _local_4.News = _local_3;
            dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_UPDATED));
            _local_5 = new ChatMessage(-1, -1, -1, 0, ChatMessage.ON_GUILD_MESSAGE, _local_3, ClientApplication.Localization.CHAT_GUILD_NEWS, 204, 204, 228);
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedGuildAnnounce():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:int;
            var _local_5:int;
            var _local_6:int;
            var _local_7:String;
            var _local_8:ChatMessage;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 9);
            _local_3 = TransmissionObject.Instance.ReadUInt8();
            _local_4 = TransmissionObject.Instance.ReadUInt8();
            _local_5 = TransmissionObject.Instance.ReadUInt8();
            _local_6 = TransmissionObject.Instance.ReadUInt8();
            TransmissionObject.Instance.ReadUInt8();
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < _local_2)
            {
                return (false);
            };
            _local_7 = TransmissionObject.Instance.ReadString(_local_2);
            if (((CharacterStorage.Instance.IsShowGuildNotice) || (_local_3 > 0)))
            {
                _local_8 = new ChatMessage(-1, -1, -1, 0, ChatMessage.ON_GUILD_MESSAGE, _local_7, null, _local_6, _local_5, _local_4);
                dispatchEvent(_local_8);
            };
            return (true);
        }

        private function ReceivedGuildAllyRequest():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:String;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 28)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadString(24);
            dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_ALLY_REQUEST, null, _local_2, _local_3));
            return (true);
        }

        private function ReceivedGuildAllyReply():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt8();
            dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_UPDATED));
            return (true);
        }

        private function ReceivedGuildRankChanged():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 42)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            var _local_3:int = TransmissionObject.Instance.ReadUInt32();
            var _local_4:int = TransmissionObject.Instance.ReadUInt32();
            var _local_5:int = TransmissionObject.Instance.ReadUInt32();
            var _local_6:int = TransmissionObject.Instance.ReadUInt32();
            var _local_7:String = TransmissionObject.Instance.ReadString(24);
            return (true);
        }

        private function ReceivedGuildLeaveMessage():Boolean
        {
            var _local_1:uint;
            var _local_2:String;
            var _local_3:String;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 64)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadString(24);
            _local_3 = TransmissionObject.Instance.ReadString(40);
            dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_LEAVE_MESSAGE, null, 0, _local_2, _local_3));
            this.SendGuildRequestInfo(0);
            this.SendGuildRequestInfo(1);
            return (true);
        }

        private function ReceivedGuildKickMessage():Boolean
        {
            var _local_1:uint;
            var _local_2:String;
            var _local_3:String;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 64)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadString(24);
            _local_3 = TransmissionObject.Instance.ReadString(40);
            TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 24);
            dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_LEAVE_MESSAGE, null, 0, _local_2, _local_3));
            this.SendGuildRequestInfo(0);
            this.SendGuildRequestInfo(1);
            return (true);
        }

        private function ReceivedGuildMembersTitleList():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:GuildInfo;
            var _local_4:int;
            var _local_5:String;
            var _local_6:int;
            var _local_7:int;
            var _local_8:String;
            var _local_9:Object;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if (_local_2 > (_local_1 - 2))
            {
                return (false);
            };
            _local_3 = this.ActorList.GetPlayer().Guild;
            _local_4 = int((_local_2 / 28));
            _local_6 = 0;
            while (_local_6 < _local_4)
            {
                _local_7 = TransmissionObject.Instance.ReadUInt32();
                _local_8 = TransmissionObject.Instance.ReadString(24);
                if (_local_7 == 1)
                {
                    _local_5 = _local_8;
                };
                _local_9 = ClientApplication.Localization.GUILD_POSITIONS[_local_7];
                _local_3.AddTitle(_local_7, ((_local_9) ? _local_9.name : _local_8));
                _local_6++;
            };
            if (((!(_local_5 == ClientApplication.Localization.GUILD_POSITIONS[1]["name"])) && (_local_3.IsGuildMaster)))
            {
                this.SendGuildChangePositionInfo();
            };
            return (true);
        }

        private function ReceivedGuildMemberList():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:GuildInfo;
            var _local_4:int;
            var _local_5:int;
            var _local_6:GuildMember;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if (_local_2 > (_local_1 - 2))
            {
                return (false);
            };
            _local_3 = this.ActorList.GetPlayer().Guild;
            if (_local_3 == null)
            {
                TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + _local_2);
                dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_UPDATED));
                return (true);
            };
            _local_4 = int((_local_2 / 104));
            if (_local_4 > 0)
            {
                _local_3.ClearMembers();
                _local_5 = 0;
                while (_local_5 < _local_4)
                {
                    _local_6 = _local_3.GetMember(_local_5);
                    _local_6.accountId = TransmissionObject.Instance.ReadUInt32();
                    _local_6.characterId = TransmissionObject.Instance.ReadUInt32();
                    _local_6.hair = TransmissionObject.Instance.ReadUInt16();
                    _local_6.hairColor = TransmissionObject.Instance.ReadUInt16();
                    _local_6.gender = TransmissionObject.Instance.ReadUInt16();
                    _local_6.jobId = TransmissionObject.Instance.ReadUInt16();
                    _local_6.lv = TransmissionObject.Instance.ReadUInt16();
                    _local_6.baseExp = TransmissionObject.Instance.ReadUInt32();
                    _local_6.online = TransmissionObject.Instance.ReadUInt32();
                    _local_6.position = TransmissionObject.Instance.ReadUInt32();
                    _local_6.lastLogin = TransmissionObject.Instance.ReadUInt32();
                    TransmissionObject.Instance.BufferPosition = (TransmissionObject.Instance.BufferPosition + 46);
                    _local_6.name = TransmissionObject.Instance.ReadString(24);
                    _local_5++;
                };
            }
            else
            {
                this.ActorList.GetPlayer().Guild = null;
                this.ActorList.GetPlayer().guildName = null;
                this.ActorList.GetPlayer().isAllie = false;
                this.ActorList.GetPlayer().guildTitle = null;
                this.ActorList.GetPlayer().guildEmblem = 0;
            };
            dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_UPDATED));
            return (true);
        }

        private function ReceivedGuildMemberPositionChanged():Boolean
        {
            var _local_1:uint;
            var _local_3:int;
            var _local_4:int;
            var _local_5:int;
            var _local_6:GuildInfo;
            var _local_7:GuildMember;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 14)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt16();
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            _local_4 = TransmissionObject.Instance.ReadUInt32();
            _local_5 = TransmissionObject.Instance.ReadUInt32();
            _local_6 = this.ActorList.GetPlayer().Guild;
            _local_7 = _local_6.FindMemberByAccountAndId(_local_3, _local_4);
            if (_local_7 != null)
            {
                _local_7.position = _local_5;
            };
            dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_UPDATED));
            return (true);
        }

        private function ReceivedGuildLocator():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:GuildInfo;
            var _local_6:GuildMember;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 8)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadUInt16();
            _local_4 = TransmissionObject.Instance.ReadUInt16();
            _local_5 = this.ActorList.GetPlayer().Guild;
            if (_local_5 == null)
            {
                return (true);
            };
            for each (_local_6 in _local_5.members)
            {
                if (_local_6.accountId == _local_2)
                {
                    if (((_local_3 >= 0) && (_local_4 >= 0)))
                    {
                        _local_6.coordinates = new Coordinates();
                        _local_6.coordinates.x = _local_3;
                        _local_6.coordinates.y = _local_4;
                    }
                    else
                    {
                        _local_6.coordinates = null;
                    };
                    break;
                };
            };
            return (true);
        }

        private function ReceivedFriendsList():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:CharacterInfo;
            var _local_4:int;
            var _local_5:int;
            var _local_6:FriendMember;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if (_local_2 > (_local_1 - 2))
            {
                return (false);
            };
            _local_3 = this.ActorList.GetPlayer();
            _local_3.Friends = new FriendInfo();
            _local_4 = int((_local_2 / 32));
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_6 = new FriendMember();
                _local_6.AccountId = TransmissionObject.Instance.ReadUInt32();
                _local_6.CharacterId = TransmissionObject.Instance.ReadUInt32();
                _local_6.Name = TransmissionObject.Instance.ReadString(24);
                _local_6.Online = false;
                _local_3.Friends.friends[_local_6.CharacterId] = _local_6;
                _local_5++;
            };
            dispatchEvent(new FriendEvent(FriendEvent.ON_FRIENDS_UPDATED));
            return (true);
        }

        private function ReceivedFriendOnline():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:FriendInfo;
            var _local_6:FriendMember;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 9)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            _local_4 = TransmissionObject.Instance.ReadUInt8();
            _local_5 = this.ActorList.GetPlayer().Friends;
            if (_local_5 != null)
            {
                _local_6 = _local_5.GetFriend(_local_3);
                if (((!(_local_6 == null)) && (_local_6.AccountId == _local_2)))
                {
                    _local_6.Online = (_local_4 == 0);
                };
            };
            dispatchEvent(new FriendEvent(FriendEvent.ON_FRIENDS_UPDATED));
            return (true);
        }

        private function ReceivedFriendAddRequest():Boolean
        {
            var _local_1:uint;
            var _local_2:FriendEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 32)
            {
                return (false);
            };
            _local_2 = new FriendEvent(FriendEvent.ON_FRIEND_MEMBER_ADD_REQUEST);
            _local_2.AccountId = TransmissionObject.Instance.ReadUInt32();
            _local_2.CharacterId = TransmissionObject.Instance.ReadUInt32();
            _local_2.CharacterName = TransmissionObject.Instance.ReadString(24);
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedFriendRemoved():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:FriendInfo;
            var _local_5:FriendMember;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 8)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            _local_4 = this.ActorList.GetPlayer().Friends;
            if (_local_4 != null)
            {
                _local_5 = _local_4.GetFriend(_local_3);
                if (((!(_local_5 == null)) && (_local_5.AccountId == _local_2)))
                {
                    _local_4.RemoveFriend(_local_3);
                };
            };
            dispatchEvent(new FriendEvent(FriendEvent.ON_FRIENDS_UPDATED));
            return (true);
        }

        private function ReceivedFriendRequestAck():Boolean
        {
            var _local_1:uint;
            var _local_2:FriendEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = new FriendEvent(FriendEvent.ON_FRIENDS_RESULT);
            _local_2.Result = TransmissionObject.Instance.ReadUInt16();
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 >= 28)
            {
                _local_2.AccountId = TransmissionObject.Instance.ReadUInt16();
                TransmissionObject.Instance.ReadUInt16();
                _local_2.CharacterId = TransmissionObject.Instance.ReadUInt16();
                TransmissionObject.Instance.ReadUInt16();
                _local_2.CharacterName = TransmissionObject.Instance.ReadString(24);
            };
            dispatchEvent(_local_2);
            return (true);
        }

        private function ReceivedPMIgnoreResult():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:IgnoreEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt8();
            _local_3 = TransmissionObject.Instance.ReadUInt8();
            _local_4 = new IgnoreEvent(IgnoreEvent.ON_IGNORE_RESULT);
            _local_4.Type = _local_2;
            _local_4.Result = _local_3;
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedPMIgnoreAllResult():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:IgnoreEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt8();
            _local_3 = TransmissionObject.Instance.ReadUInt8();
            _local_4 = new IgnoreEvent(IgnoreEvent.ON_IGNOREALL_RESULT);
            _local_4.Type = _local_2;
            _local_4.Result = _local_3;
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedPMIgnoreList():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:CharacterInfo;
            var _local_4:int;
            var _local_5:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if (_local_2 > (_local_1 - 2))
            {
                return (false);
            };
            _local_3 = this.ActorList.GetPlayer();
            _local_3.IgnoreList = new IgnoreInfo();
            _local_4 = int((_local_2 / 24));
            _local_5 = 0;
            while (_local_5 < _local_4)
            {
                _local_3.IgnoreList.ignore[_local_5] = TransmissionObject.Instance.ReadString(24);
                _local_5++;
            };
            dispatchEvent(new IgnoreEvent(IgnoreEvent.ON_IGNORELIST_UPDATED));
            return (true);
        }

        private function ReceivedPvpRank():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_5:CharacterInfo;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 12)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadInt32();
            var _local_3:int = TransmissionObject.Instance.ReadInt32();
            var _local_4:int = TransmissionObject.Instance.ReadInt32();
            _local_5 = this.ActorList.GetActor(_local_2);
            if (((!(_local_5 == null)) && (!(_local_5.internalName == "Unknown"))))
            {
            };
            return (true);
        }

        private function ReceivedPvpMode():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            this._pvpMode = TransmissionObject.Instance.ReadInt16();
            dispatchEvent(new PvPModeEvent(this._pvpMode));
            return (true);
        }

        private function ReceivedWeaponUpgrade():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 6)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt32();
            var _local_3:int = TransmissionObject.Instance.ReadUInt16();
            return (true);
        }

        private function ReceivedMannerMessage():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:ChatMessage;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            if (_local_2 == 0)
            {
                _local_3 = new ChatMessage(-1, -1, -1, 0, ChatMessage.ON_BROADCAST_MESSAGE, ClientApplication.Localization.MUTE_MANNER_POINT_ALIGNED, null, 204, 204, 228);
                dispatchEvent(_local_3);
            };
            return (true);
        }

        private function ReceivedGMSilence():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            var _local_2:int = TransmissionObject.Instance.ReadUInt8();
            var _local_3:String = TransmissionObject.Instance.ReadString(24);
            return (true);
        }

        private function ReceivedMailInboxData():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:int;
            var _local_4:Array;
            var _local_5:int;
            var _local_6:MailEvent;
            var _local_7:MailHeaderData;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 2);
            if (_local_1 < _local_2)
            {
                return (false);
            };
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            _local_4 = new Array();
            _local_5 = 0;
            while (_local_5 < _local_3)
            {
                _local_7 = new MailHeaderData();
                _local_7.MailId = TransmissionObject.Instance.ReadUInt32();
                _local_7.Title = TransmissionObject.Instance.ReadString(40);
                _local_7.Status = TransmissionObject.Instance.ReadUInt8();
                _local_7.From = TransmissionObject.Instance.ReadString(24);
                _local_7.TimeStamp = TransmissionObject.Instance.ReadUInt32();
                _local_4.push(_local_7);
                _local_5++;
            };
            _local_6 = new MailEvent(MailEvent.ON_MAIL_LIST);
            _local_6.MailList = _local_4;
            dispatchEvent(_local_6);
            return (true);
        }

        private function ReceivedMailMessageBody():Boolean
        {
            var _local_1:uint;
            var _local_2:int;
            var _local_3:MailHeaderData;
            var _local_4:ItemData;
            var _local_5:int;
            var _local_6:uint;
            var _local_7:String;
            var _local_8:MailEvent;
            var _local_9:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 2);
            if (_local_1 < _local_2)
            {
                return (false);
            };
            _local_3 = new MailHeaderData();
            _local_3.MailId = TransmissionObject.Instance.ReadUInt32();
            _local_3.Title = TransmissionObject.Instance.ReadString(40);
            _local_3.From = TransmissionObject.Instance.ReadString(24);
            TransmissionObject.Instance.ReadUInt32();
            _local_3.Money = TransmissionObject.Instance.ReadUInt32();
            _local_4 = new ItemData();
            _local_4.Amount = TransmissionObject.Instance.ReadUInt32();
            _local_4.NameId = TransmissionObject.Instance.ReadUInt16();
            _local_4.Type = TransmissionObject.Instance.ReadUInt16();
            _local_4.Identified = TransmissionObject.Instance.ReadUInt8();
            _local_4.Attr = TransmissionObject.Instance.ReadUInt8();
            _local_4.Upgrade = TransmissionObject.Instance.ReadUInt8();
            _local_4.Cards = new Vector.<int>();
            _local_5 = 0;
            while (_local_5 < ItemData.MAX_SLOTS)
            {
                _local_9 = ((_local_5 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                _local_4.Cards.push(_local_9);
                _local_5++;
            };
            _local_6 = TransmissionObject.Instance.ReadUInt8();
            _local_7 = TransmissionObject.Instance.ReadString((_local_6 + 1));
            _local_8 = new MailEvent(MailEvent.ON_MAIL_READ);
            _local_8.Header = _local_3;
            _local_8.Item = _local_4;
            _local_8.Message = _local_7;
            dispatchEvent(_local_8);
            return (true);
        }

        private function ReceivedMailSendAck():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:MailEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt8();
            _local_3 = new MailEvent(MailEvent.ON_MAIL_SEND_RESULT);
            _local_3.Flag = _local_2;
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedMailAttachmentResult():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:MailEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt8();
            _local_3 = new MailEvent(MailEvent.ON_MAIL_GET_ATTACH_RESULT);
            _local_3.Flag = _local_2;
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedMailDeleteResult():Boolean
        {
            var _local_1:uint;
            var _local_3:uint;
            var _local_4:MailEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadUInt16();
            _local_4 = new MailEvent(MailEvent.ON_MAIL_DELETE_RESULT);
            _local_4.Flag = _local_3;
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedAuctionMessage():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:AuctionEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt8();
            _local_3 = new AuctionEvent(AuctionEvent.ON_AUCTION_MESSAGE);
            _local_3.Flag = _local_2;
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedAuctionResults():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:Array;
            var _local_6:CharacterInfo;
            var _local_7:int;
            var _local_8:AuctionEvent;
            var _local_9:uint;
            var _local_10:String;
            var _local_11:uint;
            var _local_12:uint;
            var _local_13:ItemData;
            var _local_14:int;
            var _local_15:uint;
            var _local_16:String;
            var _local_17:uint;
            var _local_18:AuctionLot;
            var _local_19:int;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = (TransmissionObject.Instance.ReadUInt16() - 4);
            if (_local_2 > _local_1)
            {
                return (false);
            };
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            _local_4 = TransmissionObject.Instance.ReadUInt32();
            _local_5 = new Array();
            _local_6 = this.ActorList.GetPlayer();
            _local_7 = 0;
            while (_local_7 < _local_4)
            {
                _local_9 = TransmissionObject.Instance.ReadUInt32();
                _local_10 = TransmissionObject.Instance.ReadString(24);
                _local_11 = TransmissionObject.Instance.ReadUInt16();
                _local_12 = TransmissionObject.Instance.ReadUInt16();
                TransmissionObject.Instance.ReadUInt16();
                _local_13 = new ItemData();
                _local_13.NameId = _local_11;
                _local_13.Amount = TransmissionObject.Instance.ReadUInt16();
                _local_13.Identified = TransmissionObject.Instance.ReadUInt8();
                _local_13.Attr = TransmissionObject.Instance.ReadUInt8();
                _local_13.Upgrade = TransmissionObject.Instance.ReadUInt8();
                _local_13.Cards = new Vector.<int>();
                _local_14 = 0;
                while (_local_14 < ItemData.MAX_SLOTS)
                {
                    _local_19 = ((_local_14 < 4) ? TransmissionObject.Instance.ReadInt16() : TransmissionObject.Instance.ReadInt32());
                    _local_13.Cards.push(_local_19);
                    _local_14++;
                };
                _local_13.Price = TransmissionObject.Instance.ReadUInt32();
                _local_15 = TransmissionObject.Instance.ReadUInt32();
                _local_16 = TransmissionObject.Instance.ReadString(24);
                _local_17 = TransmissionObject.Instance.ReadUInt32();
                _local_18 = new AuctionLot(_local_9, _local_13.Price, _local_15, _local_17, _local_13);
                _local_18.SellerName = _local_10;
                _local_18.AuctionType = _local_12;
                _local_18.BuyerName = _local_16;
                _local_18.SelfLot = (_local_6.name == _local_10);
                _local_5.push(_local_18);
                _local_7++;
            };
            _local_8 = new AuctionEvent(AuctionEvent.ON_AUCTION_LIST_RECEIVED);
            _local_8.AuctionList = _local_5;
            _local_8.Pages = _local_3;
            dispatchEvent(_local_8);
            return (true);
        }

        private function ReceivedMailAttachment():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 3)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt16();
            var _local_3:uint = TransmissionObject.Instance.ReadUInt8();
            return (true);
        }

        private function ReceivedAuctionSetItemAck():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:AuctionEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 3)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            _local_3 = TransmissionObject.Instance.ReadUInt8();
            _local_4 = new AuctionEvent(AuctionEvent.ON_AUCTION_ITEM_SET);
            _local_4.Flag = _local_3;
            _local_4.ItemID = _local_2;
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedMailWindow():Boolean
        {
            var _local_1:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt32();
            return (true);
        }

        private function ReceivedMailNew():Boolean
        {
            var _local_1:uint;
            var _local_2:MailHeaderData;
            var _local_3:MailEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = new MailHeaderData();
            _local_2.MailId = TransmissionObject.Instance.ReadUInt32();
            _local_2.From = TransmissionObject.Instance.ReadString(24);
            _local_2.Title = TransmissionObject.Instance.ReadString(40);
            _local_3 = new MailEvent(MailEvent.ON_MAIL_NEW);
            _local_3.Header = _local_2;
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedMailReturn():Boolean
        {
            var _local_1:uint;
            var _local_3:uint;
            var _local_4:MailEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 6)
            {
                return (false);
            };
            var _local_2:uint = TransmissionObject.Instance.ReadUInt32();
            _local_3 = TransmissionObject.Instance.ReadUInt16();
            _local_4 = new MailEvent(MailEvent.ON_MAIL_RETURN_RESULT);
            _local_4.Flag = _local_3;
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedInstanceJoin():Boolean
        {
            var _local_1:uint;
            var _local_2:String;
            var _local_3:uint;
            var _local_4:InstanceEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 63)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadString(61);
            _local_3 = TransmissionObject.Instance.ReadUInt16();
            _local_4 = new InstanceEvent(InstanceEvent.ON_INSTANCE_JOIN);
            _local_4.Name = _local_2;
            _local_4.Flag = _local_3;
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedInstanceTimeout():Boolean
        {
            var _local_1:uint;
            var _local_2:String;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:InstanceEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 69)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadString(61);
            _local_3 = TransmissionObject.Instance.ReadUInt32();
            _local_4 = TransmissionObject.Instance.ReadUInt32();
            _local_5 = new InstanceEvent(InstanceEvent.ON_INSTANCE_TIMEOUT);
            _local_5.Name = _local_2;
            _local_5.Progress = _local_3;
            _local_5.Idle = _local_4;
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedInstanceError():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:InstanceEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            _local_3 = new InstanceEvent(InstanceEvent.ON_INSTANCE_ERROR);
            _local_3.Flag = _local_2;
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedInstanceLeave():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:InstanceEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt32();
            _local_3 = new InstanceEvent(InstanceEvent.ON_INSTANCE_LEAVE);
            _local_3.Flag = _local_2;
            dispatchEvent(_local_3);
            return (true);
        }

        private function ReceivedBuyZenyList():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:Array;
            var _local_4:int;
            var _local_5:BuyCahsEvent;
            var _local_6:uint;
            var _local_7:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            _local_3 = [];
            _local_4 = 0;
            while (_local_4 < _local_2)
            {
                _local_6 = TransmissionObject.Instance.ReadUInt16();
                _local_7 = TransmissionObject.Instance.ReadUInt32();
                _local_3.push([_local_6, _local_7]);
                _local_4++;
            };
            _local_5 = new BuyCahsEvent(_local_3);
            dispatchEvent(_local_5);
            return (true);
        }

        private function ReceivedAccountFriendsList():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:String;
            var _local_4:AccountFriendsEvent;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 4)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            _local_3 = TransmissionObject.Instance.ReadString(_local_2);
            _local_4 = new AccountFriendsEvent(_local_3.split(","));
            dispatchEvent(_local_4);
            return (true);
        }

        private function ReceivedVisitFriend():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 2)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt16();
            dispatchEvent(new FriendVisitEvent((_local_2 & 0xFF00), (_local_2 & 0xFF)));
            return (true);
        }

        private function ReceivedUpdateCustomFarm():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt8();
            dispatchEvent(new FarmEvent(FarmEvent.ON_UPDATE_CUSTOM_FARM, _local_2));
            return (true);
        }

        private function ReceivedCustomFarmList():Boolean
        {
            var _local_1:uint;
            var _local_2:uint;
            var _local_3:Array;
            var _local_4:int;
            var _local_5:uint;
            var _local_6:uint;
            _local_1 = TransmissionObject.Instance.BytesAvailable;
            if (_local_1 < 1)
            {
                return (false);
            };
            _local_2 = TransmissionObject.Instance.ReadUInt8();
            _local_3 = [];
            _local_4 = 0;
            while (_local_4 < _local_2)
            {
                _local_5 = TransmissionObject.Instance.ReadUInt8();
                _local_6 = TransmissionObject.Instance.ReadUInt16();
                _local_3.push([_local_5, _local_6]);
                _local_4++;
            };
            dispatchEvent(new FarmEvent(FarmEvent.ON_UPDATE_CUSTOM_FARM_LIST, _local_3));
            return (true);
        }

        public function SendGetPlayerName(_arg_1:uint):void
        {
			trace("SendGetPlayerName");
            TransmissionObject.Instance.WriteUInt16(155);
            TransmissionObject.Instance.WriteUInt8(102);
            TransmissionObject.Instance.WriteUInt8(60);
            TransmissionObject.Instance.WriteUInt8(97);
            TransmissionObject.Instance.WriteUInt8(98);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendViewPlayerEquip(_arg_1:uint):void
        {
			trace("SendViewPlayerEquip");
            TransmissionObject.Instance.WriteUInt16(726);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendEquipTickBox(_arg_1:uint):void
        {
			trace("SendEquipTickBox");
            TransmissionObject.Instance.WriteUInt16(728);
            TransmissionObject.Instance.WriteUInt32(0);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendChatMessage(_arg_1:String):void
        {
			trace("SendChatMessage");
            var _local_2:CharacterInfo;
            var _local_3:String;
            var _local_4:int;
            TransmissionObject.Instance.WriteUInt16(159);
            _local_2 = this.ActorList.GetPlayer();
            _local_3 = ((_local_2.name + " : ") + _arg_1.substr(0, 254));
            _local_4 = (_local_3.length + 5);
            TransmissionObject.Instance.WriteUInt16(_local_4);
            TransmissionObject.Instance.WriteString(_local_3);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendFriendListAdd(_arg_1:String):void
        {
			trace("SendFriendListAdd");
            TransmissionObject.Instance.WriteUInt16(0x0202);
            TransmissionObject.Instance.WriteString(_arg_1, 24);
            TransmissionObject.Instance.Flush();
        }

        public function SendFriendAccept(_arg_1:int, _arg_2:int):void
        {
			trace("SendFriendAccept");
            this.SendFriendResponse(_arg_1, _arg_2, 1);
        }

        public function SendFriendReject(_arg_1:int, _arg_2:int):void
        {
			trace("SendFriendReject");
            this.SendFriendResponse(_arg_1, _arg_2, 0);
        }

        public function SendFriendRemove(_arg_1:int, _arg_2:int):void
        {
			trace("SendFriendRemove");
            TransmissionObject.Instance.WriteInt16(515);
            TransmissionObject.Instance.WriteInt32(_arg_1);
            TransmissionObject.Instance.WriteInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        private function SendFriendResponse(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
			trace("SendFriendResponse");
            TransmissionObject.Instance.WriteInt16(520);
            TransmissionObject.Instance.WriteInt32(_arg_1);
            TransmissionObject.Instance.WriteInt32(_arg_2);
            TransmissionObject.Instance.WriteInt32(_arg_3);
            TransmissionObject.Instance.Flush();
        }

        public function SendPMIgnore(_arg_1:String, _arg_2:int):void
        {
			trace("SendPMIgnore");
            TransmissionObject.Instance.WriteUInt16(207);
            TransmissionObject.Instance.WriteString(_arg_1, 24);
            TransmissionObject.Instance.WriteUInt8(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendPMIgnoreAll(_arg_1:int):void
        {
			trace("SendPMIgnoreAll");
            TransmissionObject.Instance.WriteUInt16(208);
            TransmissionObject.Instance.WriteInt8(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendGetPMIgnoreList():void
        {
			trace("SendGetPMIgnoreList");
            TransmissionObject.Instance.WriteUInt16(211);
            TransmissionObject.Instance.Flush();
        }

        public function SendVioletSell(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int, _arg_5:int):void
        {
			trace("SendVioletSell");
            TransmissionObject.Instance.WriteUInt16(1039);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.WriteUInt32(_arg_3);
            TransmissionObject.Instance.WriteUInt32(_arg_4);
            TransmissionObject.Instance.WriteUInt32(_arg_5);
            TransmissionObject.Instance.Flush();
        }

        public function SendCheckCharacterName(_arg_1:String):void
        {
			trace("SendCheckCharacterName");
            if (_arg_1.length > 24)
            {
                throw (new Error("Character name > 24"));
            };
            TransmissionObject.Instance.WriteUInt16(103);
            TransmissionObject.Instance.WriteString(_arg_1, 24);
            TransmissionObject.Instance.WriteInt8(0);
            TransmissionObject.Instance.WriteInt8(0);
            TransmissionObject.Instance.WriteInt8(0);
            TransmissionObject.Instance.WriteInt8(0);
            TransmissionObject.Instance.WriteInt8(0);
            TransmissionObject.Instance.WriteInt8(0);
            TransmissionObject.Instance.WriteInt8(0);
            TransmissionObject.Instance.WriteUInt16(0);
            TransmissionObject.Instance.WriteUInt16(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendCharacterCreate(_arg_1:int, _arg_2:String, _arg_3:Boolean, _arg_4:int, _arg_5:int, _arg_6:int, _arg_7:int, _arg_8:int, _arg_9:int, _arg_10:int, _arg_11:int, _arg_12:int, _arg_13:int):void
        {
			trace("SendCharacterCreate");
            var _local_14:int;
            var _local_15:int;
            if (_arg_2.length > 24)
            {
                throw (new Error("Character name > 24"));
            };
            if (((_arg_12 >= 24) || (_arg_13 >= 9)))
            {
                throw (new Error("Wrong hair colors"));
            };
            if ((((((_arg_6 + _arg_7) + _arg_8) + _arg_9) + _arg_10) + _arg_11) != (6 * 5))
            {
                throw (new Error("Too much stats"));
            };
            if (((((((((((((_arg_6 < 1) || (_arg_6 > 9)) || (_arg_7 < 1)) || (_arg_7 > 9)) || (_arg_8 < 1)) || (_arg_8 > 9)) || (_arg_9 < 1)) || (_arg_9 > 9)) || (_arg_10 < 1)) || (_arg_10 > 9)) || (_arg_11 < 1)) || (_arg_11 > 9)))
            {
                throw (new Error("Individual stats error"));
            };
            if ((((!((_arg_6 + _arg_9) == 10)) || (!((_arg_7 + _arg_11) == 10))) || (!((_arg_8 + _arg_10) == 10))))
            {
                throw (new Error("Pair mismatch"));
            };
            _local_14 = (((_arg_5 << 14) | (_arg_4 << 8)) | 0x00);
            _local_15 = ((((_arg_3) ? 1 : 0) << 15) | (_arg_12 & 0x7FFF));
            TransmissionObject.Instance.WriteUInt16(103);
            TransmissionObject.Instance.WriteString(_arg_2, 24);
            TransmissionObject.Instance.WriteInt8(_arg_6);
            TransmissionObject.Instance.WriteInt8(_arg_7);
            TransmissionObject.Instance.WriteInt8(_arg_8);
            TransmissionObject.Instance.WriteInt8(_arg_9);
            TransmissionObject.Instance.WriteInt8(_arg_10);
            TransmissionObject.Instance.WriteInt8(_arg_11);
            TransmissionObject.Instance.WriteInt8(_arg_1);
            TransmissionObject.Instance.WriteUInt16(_local_14);
            TransmissionObject.Instance.WriteUInt16(_local_15);
            TransmissionObject.Instance.Flush();
        }

        public function SendCharacterDelete(_arg_1:int, _arg_2:String):void
        {
			trace("SendCharacterDelete");
            if (_arg_2.length > 40)
            {
                throw (new Error("Email > 40"));
            };
            TransmissionObject.Instance.WriteUInt16(104);
            TransmissionObject.Instance.WriteString(_arg_2, 40);
            TransmissionObject.Instance.Flush();
        }

        public function SendSync():void
        {
            TransmissionObject.Instance.WriteUInt16(278);
            TransmissionObject.Instance.WriteUInt16(((this._initialSync) ? 14945 : 25185));
            TransmissionObject.Instance.WriteUInt32(getTimer());
            TransmissionObject.Instance.WriteUInt8(11);
            TransmissionObject.Instance.Flush();
            this._initialSync = false;
        }

        public function SendSync2():void
        {
            TransmissionObject.Instance.WriteUInt16(1058);
            TransmissionObject.Instance.Flush();
        }

        public function MoveTo(_arg_1:int, _arg_2:int):void
        {
			trace("MoveTo");
            var _local_3:Coordinates;
            var _local_4:CharacterInfo;
            _local_3 = new Coordinates();
            _local_3.x = _arg_1;
            _local_3.y = _arg_2;
            _local_4 = this._actors.GetPlayer();
            if (_local_4 != null)
            {
                _local_3.dir = _local_4.coordinates.dir;
                TransmissionObject.Instance.WriteUInt16(137);
                TransmissionObject.Instance.WriteUInt8(0);
                TransmissionObject.Instance.WriteBytes(_local_3.GetEncoded3());
                TransmissionObject.Instance.Flush();
            };
        }

        public function SendAttack(_arg_1:uint, _arg_2:uint=0):void
        {
			trace("SendAttack");
            TransmissionObject.Instance.WriteUInt16(133);
            TransmissionObject.Instance.WriteUInt16(0x6060);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt16(0x6464);
            TransmissionObject.Instance.WriteUInt8(62);
            TransmissionObject.Instance.WriteUInt8(99);
            TransmissionObject.Instance.WriteUInt8(103);
            TransmissionObject.Instance.WriteUInt8(55);
            TransmissionObject.Instance.WriteUInt8(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendTalkContinue(_arg_1:int):void
        {
			trace("SendTalkContinue");
            TransmissionObject.Instance.WriteUInt16(185);
            TransmissionObject.Instance.WriteInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendInsertCard(_arg_1:int, _arg_2:int):void
        {
			trace("SendInsertCard");
            TransmissionObject.Instance.WriteUInt16(380);
            TransmissionObject.Instance.WriteInt16(_arg_2);
            TransmissionObject.Instance.WriteInt16(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendRemoveCard(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
			trace("SendRemoveCard");
            TransmissionObject.Instance.WriteUInt16(1041);
            TransmissionObject.Instance.WriteInt16(_arg_2);
            TransmissionObject.Instance.WriteInt16(_arg_1);
            TransmissionObject.Instance.WriteInt8(_arg_3);
            TransmissionObject.Instance.Flush();
        }

        public function SendCraftCard(_arg_1:int, _arg_2:int):void
        {
			trace("SendCraftCard");
            TransmissionObject.Instance.WriteInt16(1042);
            TransmissionObject.Instance.WriteInt32(_arg_1);
            TransmissionObject.Instance.WriteInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendNPCClick(_arg_1:int):void
        {
			trace("SendNPCClick");
            TransmissionObject.Instance.WriteUInt16(144);
            TransmissionObject.Instance.WriteInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendRemoteNPCClick(_arg_1:String):void
        {
			trace("SendRemoteNPCClick");
            TransmissionObject.Instance.WriteUInt16(1032);
            TransmissionObject.Instance.WriteString(_arg_1, 24);
            TransmissionObject.Instance.Flush();
        }

        public function SendRemoteNPCEvent(_arg_1:String):void
        {
			trace("SendRemoteNPCEvent");
            TransmissionObject.Instance.WriteUInt16(1115);
            TransmissionObject.Instance.WriteString(_arg_1, 50);
            TransmissionObject.Instance.Flush();
        }

        public function SendTalkCancel(_arg_1:int):void
        {
			trace("SendTalkCancel");
            TransmissionObject.Instance.WriteUInt16(326);
            TransmissionObject.Instance.WriteInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendTalkCancel2(_arg_1:int):void
        {
			trace("SendTalkCancel2");
            this.SendTalkText(_arg_1, "NULL");
        }

        public function SendTalkResponse(_arg_1:int, _arg_2:int):void
        {
			trace("SendTalkResponse");
            TransmissionObject.Instance.WriteUInt16(184);
            TransmissionObject.Instance.WriteInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt8(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendTalkNumber(_arg_1:int, _arg_2:int):void
        {
			trace("SendTalkNumber");
            TransmissionObject.Instance.WriteUInt16(323);
            TransmissionObject.Instance.WriteInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendTalkText(_arg_1:int, _arg_2:String):void
        {
			trace("SendTalkText");
            var _local_3:int;
            if (_arg_2.length > 70)
            {
                _arg_2 = _arg_2.substr(0, 70);
            };
            TransmissionObject.Instance.WriteUInt16(469);
            _local_3 = (_arg_2.length + 9);
            TransmissionObject.Instance.WriteUInt16(_local_3);
            TransmissionObject.Instance.WriteInt32(_arg_1);
            TransmissionObject.Instance.WriteString(_arg_2);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendSolveCharName(_arg_1:int):void
        {
			trace("SendSolveCharName");
            TransmissionObject.Instance.WriteUInt16(162);
            TransmissionObject.Instance.WriteUInt32(0);
            TransmissionObject.Instance.WriteUInt32(0);
            TransmissionObject.Instance.WriteUInt16(0);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendQuit(_arg_1:Boolean=false):void
        {
			trace("SendQuit");
            if (!TransmissionObject.Instance.IsConnected)
            {
                return;
            };
            if (((!(_arg_1)) && (this._state < ClientState.CONNECTED_TO_MAPSERVER)))
            {
                return;
            };
            TransmissionObject.Instance.WriteUInt16(394);
            if (_arg_1)
            {
                TransmissionObject.Instance.WriteUInt16(1);
            }
            else
            {
                TransmissionObject.Instance.WriteUInt16(0);
            };
            TransmissionObject.Instance.Flush();
        }

        public function SendQuitToCharSelect():void
        {
			trace("SendQuitToCharSelect");
            if (!TransmissionObject.Instance.IsConnected)
            {
                return;
            };
            TransmissionObject.Instance.WriteUInt8(178);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.WriteUInt8(1);
            TransmissionObject.Instance.Flush();
        }

        public function SendRespawn():void
        {
			trace("SendRespawn");
            TransmissionObject.Instance.WriteUInt8(178);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendEmotionOld(_arg_1:int):void
        {
			trace("SendEmotionOld");
            TransmissionObject.Instance.WriteUInt16(191);
            TransmissionObject.Instance.WriteUInt8(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendEmotion(_arg_1:int):void
        {
			trace("SendEmotion");
            TransmissionObject.Instance.WriteUInt16(1072);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendItemUse(_arg_1:int, _arg_2:uint):void
        {
			trace("SendItemUse");
            TransmissionObject.Instance.WriteUInt32(0x36650072);
            TransmissionObject.Instance.WriteUInt8(101);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt16(14180);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendItemDrop(_arg_1:ItemData, _arg_2:int):void
        {
			trace("SendItemDrop");
            var _local_3:int;
            TransmissionObject.Instance.WriteUInt16(148);
            TransmissionObject.Instance.WriteUInt32(288645729);
            TransmissionObject.Instance.WriteUInt16(_arg_1.Id);
            TransmissionObject.Instance.WriteUInt16(25703);
            _local_3 = Math.min(_arg_2, _arg_1.Amount);
            TransmissionObject.Instance.WriteUInt16(_local_3);
            TransmissionObject.Instance.Flush();
        }

        public function SendItemTake(_arg_1:int):void
        {
			trace("SendItemTake");
            TransmissionObject.Instance.WriteUInt32(1616970003);
            TransmissionObject.Instance.WriteUInt8(59);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendItemIdentify(_arg_1:int):void
        {
			trace("SendItemIdentify");
            TransmissionObject.Instance.WriteUInt16(376);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendAddStatPoints(_arg_1:int, _arg_2:int):void
        {
			trace("SendAddStatPoints");
            TransmissionObject.Instance.WriteUInt16(187);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt8(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendImprove(_arg_1:int, _arg_2:int):void
        {
			trace("SendImprove");
            TransmissionObject.Instance.WriteUInt16(1037);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendEquipItem(_arg_1:ItemData, _arg_2:int):void
        {
			trace("SendEquipItem");
            TransmissionObject.Instance.WriteUInt16(169);
            TransmissionObject.Instance.WriteUInt16(_arg_1.Id);
            TransmissionObject.Instance.WriteUInt16(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendUnequipItem(_arg_1:ItemData):void
        {
			trace("SendUnequipItem");
            TransmissionObject.Instance.WriteUInt16(171);
            TransmissionObject.Instance.WriteUInt16(_arg_1.Id);
            TransmissionObject.Instance.Flush();
        }

        public function SendTake(_arg_1:int):void
        {
			trace("SendTake");
            TransmissionObject.Instance.WriteUInt32(1616970003);
            TransmissionObject.Instance.WriteUInt8(59);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendGetStoreList():void
        {
			trace("SendGetStoreList");
            TransmissionObject.Instance.WriteUInt16(197);
            TransmissionObject.Instance.WriteUInt32(this._npcStoreId);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendBuyItem(_arg_1:int, _arg_2:int):void
        {
			trace("SendBuyItem");
            TransmissionObject.Instance.WriteUInt32(524488);
            TransmissionObject.Instance.WriteUInt16(_arg_2);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.Flush();
            this.SendAttack(this._npcStoreId);
        }

        public function SendSellItem(_arg_1:int, _arg_2:int):void
        {
			trace("SendSellItem");
            TransmissionObject.Instance.WriteUInt32(524489);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt16(_arg_2);
            TransmissionObject.Instance.Flush();
            this.SendAttack(this._npcStoreId);
        }

        public function SendGetBuyZenyList():void
        {
			trace("SendGetBuyZenyList");
            TransmissionObject.Instance.WriteUInt16(1093);
            TransmissionObject.Instance.Flush();
        }

        public function SenBuyZeny(_arg_1:int):void
        {
			trace("SenBuyZeny");
            TransmissionObject.Instance.WriteUInt16(1095);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendSellItemList(_arg_1:Array):void
        {
			trace("SendSellItemList");
            var _local_2:int;
            var _local_3:ItemList;
            if (((_arg_1 == null) || (_arg_1.length < 1)))
            {
                return;
            };
            _local_2 = ((_arg_1.length * 4) + 4);
            TransmissionObject.Instance.WriteUInt16(201);
            TransmissionObject.Instance.WriteUInt16(_local_2);
            for each (_local_3 in _arg_1)
            {
                TransmissionObject.Instance.WriteUInt16(_local_3.Id);
                TransmissionObject.Instance.WriteUInt16(_local_3.Amount);
            };
            TransmissionObject.Instance.Flush();
            this.SendAttack(this._npcStoreId);
        }

        public function SendAutoSellItem(_arg_1:int):void
        {
			trace("SendAutoSellItem");
            TransmissionObject.Instance.WriteUInt16(1070);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendPartyOrganize(_arg_1:String):void
        {
			trace("SendPartyOrganize");
            TransmissionObject.Instance.WriteUInt16(488);
            TransmissionObject.Instance.WriteString(_arg_1, 24);
            TransmissionObject.Instance.WriteUInt8(1);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendPartyLeave():void
        {
			trace("SendPartyLeave");
            TransmissionObject.Instance.WriteUInt16(0x0100);
            TransmissionObject.Instance.Flush();
        }

        public function SendPartyKick(_arg_1:int, _arg_2:String):void
        {
			trace("SendPartyKick");
            TransmissionObject.Instance.WriteUInt16(259);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteString(_arg_2, 24);
            TransmissionObject.Instance.Flush();
        }

        public function SendPartyJoinRequest(_arg_1:int):void
        {
			trace("SendPartyJoinRequest");
            TransmissionObject.Instance.WriteUInt16(252);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendPartyJoin(_arg_1:int, _arg_2:int=1):void
        {
			trace("SendPartyJoin");
            TransmissionObject.Instance.WriteUInt16(0xFF);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendPartyChangeOption(_arg_1:int):void
        {
			trace("SendPartyChangeOption");
            TransmissionObject.Instance.WriteUInt16(258);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt16(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendPrivateMessage(_arg_1:String, _arg_2:String):void
        {
			trace("SendPrivateMessage");
            var _local_3:String;
            var _local_4:int;
            _local_3 = _arg_2.substr(0, 254);
            _local_4 = (_local_3.length + 29);
            TransmissionObject.Instance.WriteUInt16(150);
            TransmissionObject.Instance.WriteUInt16(_local_4);
            TransmissionObject.Instance.WriteString(_arg_1, 24);
            TransmissionObject.Instance.WriteString(_local_3);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildCreate(_arg_1:String):void
        {
			trace("SendGuildCreate");
            TransmissionObject.Instance.WriteUInt16(357);
            TransmissionObject.Instance.WriteUInt16(35661);
            TransmissionObject.Instance.WriteUInt16(1);
            TransmissionObject.Instance.WriteString(_arg_1, 24);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildCheckMaster():void
        {
			trace("SendGuildCheckMaster");
            TransmissionObject.Instance.WriteUInt16(333);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildJoin(_arg_1:int, _arg_2:int=1):void
        {
			trace("SendGuildJoin");
            TransmissionObject.Instance.WriteUInt16(363);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildJoinRequest(_arg_1:int):void
        {
			trace("SendGuildJoinRequest");
            var _local_2:CharacterInfo = this.ActorList.GetPlayer();
            TransmissionObject.Instance.WriteUInt16(360);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(this._loginAccountId);
            TransmissionObject.Instance.WriteUInt32(this._mapCharId);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildLeave(_arg_1:String):void
        {
			trace("SendGuildLeave");
            var _local_2:CharacterInfo;
            _local_2 = this.ActorList.GetPlayer();
            TransmissionObject.Instance.WriteUInt16(345);
            TransmissionObject.Instance.WriteUInt32(_local_2.Guild.Id);
            TransmissionObject.Instance.WriteUInt32(this._loginAccountId);
            TransmissionObject.Instance.WriteUInt32(this._mapCharId);
            TransmissionObject.Instance.WriteString(_arg_1, 40);
            TransmissionObject.Instance.Flush();
            this.ActorList.GetPlayer().Guild = null;
            this.ActorList.GetPlayer().guildName = null;
            this.ActorList.GetPlayer().isAllie = false;
            this.ActorList.GetPlayer().guildTitle = null;
            dispatchEvent(new GuildEvent(GuildEvent.ON_GUILD_UPDATED));
        }

        public function SendGuildMemberKick(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):void
        {
			trace("SendGuildMemberKick");
            TransmissionObject.Instance.WriteUInt16(347);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.WriteUInt32(_arg_3);
            TransmissionObject.Instance.WriteString(_arg_4, 40);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildCash(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
			trace("SendGuildCash");
            TransmissionObject.Instance.WriteUInt16(1081);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.WriteUInt32(_arg_3);
            TransmissionObject.Instance.WriteUInt32(_arg_4);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildChangeMemberPosition(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
			trace("SendGuildChangeMemberPosition");
            TransmissionObject.Instance.WriteUInt16(341);
            TransmissionObject.Instance.WriteUInt16(16);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.WriteUInt32(_arg_3);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildNotice(_arg_1:int, _arg_2:String, _arg_3:String):void
        {
			trace("SendGuildNotice");
            TransmissionObject.Instance.WriteUInt16(366);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteString(_arg_2, 60);
            TransmissionObject.Instance.WriteString(_arg_3, 120);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildRankChange(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:String):void
        {
			trace("SendGuildRankChange");
            TransmissionObject.Instance.WriteUInt16(353);
            TransmissionObject.Instance.WriteUInt16(44);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_3);
            TransmissionObject.Instance.WriteString(_arg_4, 24);
            TransmissionObject.Instance.Flush();
        }

        public function SendChangeGuildEmblemId(_arg_1:int):void
        {
			trace("SendChangeGuildEmblemId");
            TransmissionObject.Instance.WriteUInt16(1062);
            TransmissionObject.Instance.WriteInt16(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendCancelQuest(_arg_1:int):void
        {
			trace("SendCancelQuest");
            TransmissionObject.Instance.WriteUInt16(1033);
            TransmissionObject.Instance.WriteInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendSkillCastCancel():void
        {
			trace("SendSkillCastCancel");
            TransmissionObject.Instance.WriteUInt16(1044);
            TransmissionObject.Instance.Flush();
        }

        public function SendRoulette(_arg_1:int):void
        {
			trace("SendRoulette");
            TransmissionObject.Instance.WriteUInt16(1045);
            TransmissionObject.Instance.WriteInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendOpenCashShop(_arg_1:uint=0):void
        {
			trace("SendOpenCashShop");
            TransmissionObject.Instance.WriteUInt16(1046);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendOpenKafraShop():void
        {
			trace("SendOpenKafraShop");
            TransmissionObject.Instance.WriteUInt16(1046);
            TransmissionObject.Instance.WriteUInt32(ItemData.KAFRASHOP);
            TransmissionObject.Instance.Flush();
        }

        public function SendOpenPremiumShop(_arg_1:uint=0):void
        {
			trace("SendOpenPremiumShop");
            TransmissionObject.Instance.WriteUInt16(1113);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendOpenLadder():void
        {
			trace("SendOpenLadder");
            TransmissionObject.Instance.WriteUInt16(1047);
            TransmissionObject.Instance.Flush();
        }

        public function SendEnterLadder(_arg_1:int):void
        {
			trace("SendEnterLadder");
            TransmissionObject.Instance.WriteUInt16(1051);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendDuelCreate(_arg_1:int, _arg_2:String=""):void
        {
			trace("SendDuelCreate");
            TransmissionObject.Instance.WriteUInt16(1052);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteString(_arg_2, 24);
            TransmissionObject.Instance.Flush();
        }

        public function SendDuelInvite(_arg_1:String):void
        {
			trace("SendDuelInvite");
            TransmissionObject.Instance.WriteUInt16(1053);
            TransmissionObject.Instance.WriteString(_arg_1, 24);
            TransmissionObject.Instance.Flush();
        }

        public function SendDuelAccept():void
        {
			trace("SendDuelAccept");
            TransmissionObject.Instance.WriteUInt16(1054);
            TransmissionObject.Instance.Flush();
        }

        public function SendDuelReject():void
        {
			trace("SendDuelReject");
            TransmissionObject.Instance.WriteUInt16(1055);
            TransmissionObject.Instance.Flush();
        }

        public function SendDuelLeave():void
        {
			trace("SendDuelLeave");
            TransmissionObject.Instance.WriteUInt16(1056);
            TransmissionObject.Instance.Flush();
        }

        public function SendUpdateCash():void
        {
			trace("SendUpdateCash");
            TransmissionObject.Instance.WriteUInt16(1048);
            TransmissionObject.Instance.Flush();
        }

        public function SendUpdateQuests():void
        {
			trace("SendUpdateQuests");
            TransmissionObject.Instance.WriteUInt16(1049);
            TransmissionObject.Instance.Flush();
        }

        public function SendUpdatePayments():void
        {
			trace("SendUpdatePayments");
            TransmissionObject.Instance.WriteUInt16(1086);
            TransmissionObject.Instance.Flush();
        }

        public function SendUnsoulbondItem(_arg_1:int, _arg_2:Boolean):void
        {
			trace("SendUnsoulbondItem");
            TransmissionObject.Instance.WriteUInt16(1063);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt16(((_arg_2) ? 1 : 0));
            TransmissionObject.Instance.Flush();
        }

        public function SendExtendRentItem(_arg_1:int):void
        {
			trace("SendExtendRentItem");
            TransmissionObject.Instance.WriteUInt16(1064);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendExtendKafraItem(_arg_1:int):void
        {
			trace("SendExtendKafraItem");
            TransmissionObject.Instance.WriteUInt16(1065);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendCheckInviterId(_arg_1:String):void
        {
			trace("SendCheckInviterId");
            var _local_2:String;
            var _local_3:int;
            _local_2 = _arg_1.substr(0, 64);
            _local_3 = ((_local_2.length + 1) + 4);
            TransmissionObject.Instance.WriteInt16(1092);
            TransmissionObject.Instance.WriteInt16(_local_3);
            TransmissionObject.Instance.WriteString(_local_2);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendCheckVisit(_arg_1:String):void
        {
			trace("SendCheckVisit");
            var _local_2:int;
            _local_2 = ((_arg_1.length + 1) + 4);
            TransmissionObject.Instance.WriteInt16(1105);
            TransmissionObject.Instance.WriteInt16(_local_2);
            TransmissionObject.Instance.WriteString(_arg_1);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendVisitFriend(_arg_1:String):void
        {
			trace("SendVisitFriend");
            var _local_2:int;
            _local_2 = ((_arg_1.length + 1) + 4);
            TransmissionObject.Instance.WriteInt16(1104);
            TransmissionObject.Instance.WriteInt16(_local_2);
            TransmissionObject.Instance.WriteString(_arg_1);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendCheckFriendsId(_arg_1:uint, _arg_2:String, _arg_3:String):void
        {
			trace("SendCheckFriendsId");
            var _local_4:String;
            var _local_5:int;
            _local_4 = _arg_3.substr(0, 0x0400);
            _local_5 = ((_local_4.length + 1) + 38);
            TransmissionObject.Instance.WriteInt16(1096);
            TransmissionObject.Instance.WriteInt16(_local_5);
            TransmissionObject.Instance.WriteUInt8(_arg_1);
            TransmissionObject.Instance.WriteString(_arg_2, 32);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.WriteString(_local_4);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendGetCustomFarmList():void
        {
			trace("SendGetCustomFarmList");
            TransmissionObject.Instance.WriteInt16(1107);
            TransmissionObject.Instance.Flush();
        }

        public function SendBuyCustomFarm(_arg_1:uint):void
        {
			trace("SendBuyCustomFarm");
            TransmissionObject.Instance.WriteInt16(1109);
            TransmissionObject.Instance.WriteUInt8(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendGetGift2():void
        {
			trace("SendGetGift2");
            TransmissionObject.Instance.WriteInt16(1116);
            TransmissionObject.Instance.Flush();
        }

        public function SendGetRepairList(_arg_1:Boolean=false):void
        {
			trace("SendGetRepairList");
            TransmissionObject.Instance.WriteInt16(1118);
            TransmissionObject.Instance.WriteInt8(((_arg_1) ? 1 : 0));
            TransmissionObject.Instance.Flush();
        }

        public function SendRepairItem(_arg_1:uint):void
        {
			trace("SendRepairItem");
            TransmissionObject.Instance.WriteInt16(1120);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendRepairAllItems(_arg_1:int):void
        {
			trace("SendRepairAllItems");
            TransmissionObject.Instance.WriteInt16(1121);
            TransmissionObject.Instance.WriteUInt8(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildRequestInfo(_arg_1:int):void
        {
			trace("SendGuildRequestInfo");
            TransmissionObject.Instance.WriteUInt16(335);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildSetAlly(_arg_1:int):void
        {
			trace("SendGuildSetAlly");
            TransmissionObject.Instance.WriteUInt16(368);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(this._loginAccountId);
            TransmissionObject.Instance.WriteUInt32(this.ActorList.GetPlayer().characterId);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildAlly(_arg_1:int, _arg_2:int):void
        {
			trace("SendGuildAlly");
            TransmissionObject.Instance.WriteUInt16(370);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildBreakAlly(_arg_1:int, _arg_2:int):void
        {
			trace("SendGuildBreakAlly");
            TransmissionObject.Instance.WriteUInt16(387);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildBreak(_arg_1:String):void
        {
			trace("SendGuildBreak");
            TransmissionObject.Instance.WriteUInt16(349);
            TransmissionObject.Instance.WriteString(_arg_1, 40);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildChatMessage(_arg_1:String):void
        {
			trace("SendGuildChatMessage");
            var _local_2:String;
            var _local_3:int;
            _local_2 = ((this.ActorList.GetPlayer().name + " : ") + _arg_1.substr(0, 254));
            _local_3 = ((_local_2.length + 1) + 4);
            TransmissionObject.Instance.WriteInt16(382);
            TransmissionObject.Instance.WriteInt16(_local_3);
            TransmissionObject.Instance.WriteString(_local_2);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendPartyChatMessage(_arg_1:String):void
        {
			trace("SendPartyChatMessage");
            var _local_2:String;
            var _local_3:int;
            _local_2 = ((this.ActorList.GetPlayer().name + " : ") + _arg_1.substr(0, 254));
            _local_3 = ((_local_2.length + 1) + 4);
            TransmissionObject.Instance.WriteInt16(264);
            TransmissionObject.Instance.WriteInt16(_local_3);
            TransmissionObject.Instance.WriteString(_local_2);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendRequestMessage(_arg_1:String):void
        {
			trace("SendRequestMessage");
            var _local_2:String;
            var _local_3:int;
            _local_2 = _arg_1.substr(0, 254);
            _local_3 = (_local_2.length + 4);
            TransmissionObject.Instance.WriteInt16(1080);
            TransmissionObject.Instance.WriteInt16(_local_3);
            TransmissionObject.Instance.WriteString(_local_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendBroadcastMessage(_arg_1:String):void
        {
			trace("SendBroadcastMessage");
            var _local_2:String;
            var _local_3:int;
            _local_2 = _arg_1.substr(0, 254);
            _local_3 = (_local_2.length + 4);
            TransmissionObject.Instance.WriteInt16(1087);
            TransmissionObject.Instance.WriteInt16(_local_3);
            TransmissionObject.Instance.WriteString(_local_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendCloseVending():void
        {
			trace("SendCloseVending");
            TransmissionObject.Instance.WriteUInt16(302);
            TransmissionObject.Instance.Flush();
        }

        public function SendGetCastlesInfo():void
        {
			trace("SendGetCastlesInfo");
            TransmissionObject.Instance.WriteUInt16(1030);
            TransmissionObject.Instance.Flush();
        }

        public function SendGetCastlesInfoEx():void
        {
			trace("SendGetCastlesInfoEx");
            TransmissionObject.Instance.WriteUInt16(1067);
            TransmissionObject.Instance.Flush();
        }

        public function SendGetMapOnlineInfo(_arg_1:String):void
        {
			trace("SendGetMapOnlineInfo");
            TransmissionObject.Instance.WriteUInt16(1034);
            TransmissionObject.Instance.WriteString(_arg_1, 16);
            TransmissionObject.Instance.Flush();
        }

        public function SendGetPVPInfo():void
        {
			trace("SendGetPVPInfo");
            TransmissionObject.Instance.WriteUInt16(1036);
            TransmissionObject.Instance.Flush();
        }

        public function SendLook():void
        {
			trace("SendLook");
            var _local_1:CharacterInfo;
            var _local_2:int;
            _local_1 = this.ActorList.GetPlayer();
            _local_2 = _local_1.coordinates.dir;
            TransmissionObject.Instance.WriteUInt32(0x326200F3);
            TransmissionObject.Instance.WriteUInt16(13105);
            TransmissionObject.Instance.WriteUInt8(_local_2);
            TransmissionObject.Instance.WriteUInt32(0x33306000);
            TransmissionObject.Instance.WriteUInt16(0x3131);
            TransmissionObject.Instance.WriteUInt8(49);
            TransmissionObject.Instance.WriteUInt8(_local_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendAddSkillPoint(_arg_1:SkillData):void
        {
			trace("SendAddSkillPoint");
            TransmissionObject.Instance.WriteUInt16(274);
            TransmissionObject.Instance.WriteUInt16(_arg_1.Id);
            TransmissionObject.Instance.Flush();
        }

        public function SendSkillUse(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
			trace("SendSkillUse");
            TransmissionObject.Instance.WriteUInt32(1667498384);
            TransmissionObject.Instance.WriteUInt16(_arg_2);
            TransmissionObject.Instance.WriteUInt32(1734763874);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt32(1768450924);
            TransmissionObject.Instance.WriteUInt32(171732541);
            TransmissionObject.Instance.WriteUInt16(58261);
            TransmissionObject.Instance.WriteUInt32(_arg_3);
            TransmissionObject.Instance.Flush();
        }

        public function SendSkillUseOnLocation(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
			trace("SendSkillUseOnLocation");
            TransmissionObject.Instance.WriteUInt32(0x653700A7);
            TransmissionObject.Instance.WriteUInt16(24678);
            TransmissionObject.Instance.WriteUInt16(_arg_2);
            TransmissionObject.Instance.WriteUInt8(50);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt32(1752067391);
            TransmissionObject.Instance.WriteUInt32(208627773);
            TransmissionObject.Instance.WriteUInt32(1558549260);
            TransmissionObject.Instance.WriteUInt16(_arg_3);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.WriteUInt16(_arg_4);
            TransmissionObject.Instance.Flush();
        }

        public function SendHotkey(_arg_1:int, _arg_2:int, _arg_3:int, _arg_4:int):void
        {
			trace("SendHotkey");
            TransmissionObject.Instance.WriteUInt16(698);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt8(_arg_2);
            TransmissionObject.Instance.WriteUInt32(_arg_3);
            TransmissionObject.Instance.WriteUInt16(_arg_4);
            TransmissionObject.Instance.Flush();
        }

        public function SendCartAdd(_arg_1:int, _arg_2:int):void
        {
			trace("SendCartAdd");
            TransmissionObject.Instance.WriteUInt16(294);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendCartGet(_arg_1:int, _arg_2:int):void
        {
			trace("SendCartGet");
            TransmissionObject.Instance.WriteUInt16(295);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendStorageAdd(_arg_1:int, _arg_2:int):void
        {
			trace("SendStorageAdd");
            TransmissionObject.Instance.WriteUInt16(126);
            TransmissionObject.Instance.WriteUInt32(1698509877);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt8(48);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendStorageGet(_arg_1:int, _arg_2:int):void
        {
			trace("SendStorageGet");
            TransmissionObject.Instance.WriteUInt32(976945555);
            TransmissionObject.Instance.WriteUInt32(993749299);
            TransmissionObject.Instance.WriteUInt32(168442430);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt32(1732064309);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendTradeRequest(_arg_1:uint):void
        {
			trace("SendTradeRequest");
            TransmissionObject.Instance.WriteUInt16(228);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendTradeAck(_arg_1:uint):void
        {
			trace("SendTradeAck");
            TransmissionObject.Instance.WriteUInt16(230);
            TransmissionObject.Instance.WriteUInt8(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendTradeAddItem(_arg_1:uint, _arg_2:uint):void
        {
			trace("SendTradeAddItem");
            this._safeTradeAmount = _arg_2;
            TransmissionObject.Instance.WriteUInt16(232);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendTradeDelItem(_arg_1:uint, _arg_2:uint):void
        {
			trace("SendTradeDelItem");
            TransmissionObject.Instance.WriteUInt16(1084);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt16(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendTradeOk():void
        {
			trace("SendTradeOk");
            TransmissionObject.Instance.WriteUInt16(235);
            TransmissionObject.Instance.Flush();
        }

        public function SendTradeCancel():void
        {
			trace("SendTradeCancel");
            TransmissionObject.Instance.WriteUInt16(237);
            TransmissionObject.Instance.Flush();
        }

        public function SendTradeCommit():void
        {
			trace("SendTradeCommit");
            TransmissionObject.Instance.WriteUInt16(239);
            TransmissionObject.Instance.Flush();
        }

        public function SendStorageClose():void
        {
			trace("SendStorageClose");
            TransmissionObject.Instance.WriteUInt16(247);
            TransmissionObject.Instance.Flush();
        }

        public function SendAutoRevive():void
        {
			trace("SendAutoRevive");
            TransmissionObject.Instance.WriteUInt16(658);
            TransmissionObject.Instance.Flush();
        }

        public function SendVenderCreate(_arg_1:String, _arg_2:Array):void
        {
			trace("SendVenderCreate");
            var _local_3:int;
            var _local_4:Object;
            _local_3 = (85 + (8 * _arg_2.length));
            TransmissionObject.Instance.WriteUInt16(434);
            TransmissionObject.Instance.WriteUInt16(_local_3);
            TransmissionObject.Instance.WriteString(_arg_1, 80);
            TransmissionObject.Instance.WriteUInt8(1);
            for each (_local_4 in _arg_2)
            {
                TransmissionObject.Instance.WriteUInt16(_local_4["Id"]);
                TransmissionObject.Instance.WriteUInt16(_local_4["Amount"]);
                TransmissionObject.Instance.WriteUInt32(_local_4["Price"]);
            };
            TransmissionObject.Instance.Flush();
        }

        public function SendVenderStop():void
        {
			trace("SendVenderStop");
            TransmissionObject.Instance.WriteUInt16(302);
            TransmissionObject.Instance.Flush();
        }

        public function SendVenderConnect(_arg_1:uint):void
        {
			trace("SendVenderConnect");
            TransmissionObject.Instance.WriteUInt16(304);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendVenderBuy(_arg_1:int, _arg_2:int):void
        {
			trace("SendVenderBuy");
            TransmissionObject.Instance.WriteUInt32(786740);
            TransmissionObject.Instance.WriteUInt32(this._venderId);
            TransmissionObject.Instance.WriteUInt16(_arg_2);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendCashShopBuy(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
			trace("SendCashShopBuy");
            TransmissionObject.Instance.WriteUInt16(648);
            TransmissionObject.Instance.WriteUInt16(_arg_2);
            TransmissionObject.Instance.WriteUInt16(_arg_3);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendPremiumShopBuy(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
			trace("SendPremiumShopBuy");
            TransmissionObject.Instance.WriteUInt16(1111);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.WriteUInt16(_arg_3);
            TransmissionObject.Instance.Flush();
        }

        public function SendMailboxRefresh():void
        {
			trace("SendMailboxRefresh");
            TransmissionObject.Instance.WriteUInt16(575);
            TransmissionObject.Instance.Flush();
        }

        public function SendMailRead(_arg_1:uint):void
        {
			trace("SendMailRead");
            TransmissionObject.Instance.WriteUInt16(577);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendMailGetAttach(_arg_1:uint):void
        {
			trace("SendMailGetAttach");
            TransmissionObject.Instance.WriteUInt16(580);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendMailDelete(_arg_1:uint):void
        {
			trace("SendMailDelete");
            TransmissionObject.Instance.WriteUInt16(579);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendMailWindowOpen(_arg_1:int):void
        {
			trace("SendMailWindowOpen");
            TransmissionObject.Instance.WriteUInt16(582);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendMailSend(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
			trace("SendMailSend");
            var _local_4:int;
            _local_4 = (((((4 + 24) + 40) + 1) + _arg_3.length) + 1);
            TransmissionObject.Instance.WriteUInt16(584);
            TransmissionObject.Instance.WriteUInt16(_local_4);
            TransmissionObject.Instance.WriteString(_arg_1, 24);
            TransmissionObject.Instance.WriteString(_arg_2, 40);
            TransmissionObject.Instance.WriteUInt8(_arg_3.length);
            TransmissionObject.Instance.WriteString(_arg_3);
            TransmissionObject.Instance.WriteUInt8(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendMailReturn(_arg_1:uint):void
        {
			trace("SendMailReturn");
            var _local_2:int;
            TransmissionObject.Instance.WriteUInt16(627);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            _local_2 = 0;
            while (_local_2 < 24)
            {
                TransmissionObject.Instance.WriteUInt8(0);
                _local_2++;
            };
            TransmissionObject.Instance.Flush();
        }

        public function SendMailAttach(_arg_1:int, _arg_2:int):void
        {
			trace("SendMailAttach");
            TransmissionObject.Instance.WriteUInt16(583);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendAuctionSearch(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:int):void
        {
			trace("SendAuctionSearch");
            TransmissionObject.Instance.WriteUInt16(593);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.WriteString(_arg_3, 24);
            TransmissionObject.Instance.WriteUInt16(_arg_4);
            TransmissionObject.Instance.Flush();
        }

        public function SendAuctionRegister(_arg_1:int, _arg_2:int, _arg_3:int):void
        {
			trace("SendAuctionRegister");
            TransmissionObject.Instance.WriteUInt16(589);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.WriteUInt16(_arg_3);
            TransmissionObject.Instance.Flush();
        }

        public function SendAuctionSetItem(_arg_1:int):void
        {
			trace("SendAuctionSetItem");
            TransmissionObject.Instance.WriteUInt16(588);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.WriteUInt32(1);
            TransmissionObject.Instance.Flush();
        }

        public function SendAuctionCancelReg():void
        {
			trace("SendAuctionCancelReg");
            TransmissionObject.Instance.WriteUInt16(587);
            TransmissionObject.Instance.WriteUInt16(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendAuctionCancel(_arg_1:int):void
        {
			trace("SendAuctionCancel");
            TransmissionObject.Instance.WriteUInt16(590);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendAuctionBid(_arg_1:int, _arg_2:int):void
        {
			trace("SendAuctionBid");
            TransmissionObject.Instance.WriteUInt16(591);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt32(_arg_2);
            TransmissionObject.Instance.Flush();
        }

        public function SendAuctionBuySell(_arg_1:int):void
        {
			trace("SendAuctionBuySell");
            TransmissionObject.Instance.WriteUInt16(604);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendAuctionClose(_arg_1:int):void
        {
			trace("SendAuctionClose");
            TransmissionObject.Instance.WriteUInt16(605);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildChangePositionInfo():void
        {
			trace("SendGuildChangePositionInfo");
            var _local_1:int;
            var _local_2:Object;
            var _local_3:int;
            _local_1 = 0;
            for each (_local_2 in ClientApplication.Localization.GUILD_POSITIONS)
            {
                if (!((_local_2.id == 0) || (_local_2.name == "")))
                {
                    _local_1++;
                };
            };
            _local_3 = ((_local_1 * 40) + 4);
            TransmissionObject.Instance.WriteUInt16(353);
            TransmissionObject.Instance.WriteUInt16(_local_3);
            for each (_local_2 in ClientApplication.Localization.GUILD_POSITIONS)
            {
                if (!((_local_2.id == 0) || (_local_2.name == "")))
                {
                    TransmissionObject.Instance.WriteUInt32(_local_2["id"]);
                    TransmissionObject.Instance.WriteUInt32(_local_2["mask"]);
                    TransmissionObject.Instance.WriteUInt32(0);
                    TransmissionObject.Instance.WriteUInt32(10);
                    TransmissionObject.Instance.WriteString(_local_2["name"], 24);
                };
            };
            TransmissionObject.Instance.Flush();
            this.SendGuildRequestInfo(1);
        }

        public function SendCharRenameRequest(_arg_1:uint, _arg_2:String):void
        {
			trace("SendCharRenameRequest");
            var _local_3:CharacterInfo;
            _local_3 = (this._characters[_arg_1] as CharacterInfo);
            TransmissionObject.Instance.WriteUInt16(653);
            TransmissionObject.Instance.WriteUInt32(this._loginAccountId);
            TransmissionObject.Instance.WriteUInt32(_local_3.characterId);
            TransmissionObject.Instance.WriteString(_arg_2, 24);
            TransmissionObject.Instance.Flush();
        }

        public function SendCharRenameConfirmRequest(_arg_1:uint):void
        {
			trace("SendCharRenameConfirmRequest");
            var _local_2:CharacterInfo;
            _local_2 = (this._characters[_arg_1] as CharacterInfo);
            TransmissionObject.Instance.WriteUInt16(655);
            TransmissionObject.Instance.WriteUInt32(_local_2.characterId);
            TransmissionObject.Instance.Flush();
        }

        public function SendPetCapture(_arg_1:int):void
        {
			trace("SendPetCapture");
            TransmissionObject.Instance.WriteUInt16(415);
            TransmissionObject.Instance.WriteUInt32(_arg_1);
            TransmissionObject.Instance.WriteUInt16(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendPetFeed():void
        {
			trace("SendPetFeed");
            this.SendPetCommand(1);
        }

        public function SendPetGetInfo():void
        {
			trace("SendPetGetInfo");
            this.SendPetCommand(0);
        }

        public function SendPetHatch(_arg_1:int):void
        {
			trace("SendPetHatch");
            TransmissionObject.Instance.WriteUInt16(423);
            TransmissionObject.Instance.WriteUInt16(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendPetName(_arg_1:String):void
        {
			trace("SendPetName");
            TransmissionObject.Instance.WriteUInt16(421);
            TransmissionObject.Instance.WriteString(_arg_1, 24);
            TransmissionObject.Instance.Flush();
        }

        public function SendPetPerformance():void
        {
			trace("SendPetPerformance");
            this.SendPetCommand(2);
        }

        public function SendPetReturnToEgg():void
        {
			trace("SendPetReturnToEgg");
            var _local_1:CharacterInfo;
            this.SendPetCommand(3);
            _local_1 = this.ActorList.GetPlayer();
            _local_1.Pet.Id = -1;
            dispatchEvent(new CharacterEvent(CharacterEvent.ON_PET_UPDATED));
        }

        public function SendPetUnequipItem():void
        {
			trace("SendPetUnequipItem");
            this.SendPetCommand(4);
        }

        private function SendPetCommand(_arg_1:int):void
        {
			trace("SendPetCommand");
            TransmissionObject.Instance.WriteUInt8(161);
            TransmissionObject.Instance.WriteUInt8(1);
            TransmissionObject.Instance.WriteUInt8(_arg_1);
            TransmissionObject.Instance.Flush();
        }

        public function SendArrowSelect(_arg_1:ItemData=null):void
        {
			trace("SendArrowSelect");
            TransmissionObject.Instance.WriteUInt16(430);
            if (_arg_1 != null)
            {
                TransmissionObject.Instance.WriteUInt16(_arg_1.NameId);
            }
            else
            {
                TransmissionObject.Instance.WriteUInt16(0);
            };
            TransmissionObject.Instance.Flush();
        }

        public function SendProduceMix(_arg_1:ItemData=null):void
        {
			trace("SendProduceMix");
            TransmissionObject.Instance.WriteUInt16(398);
            if (_arg_1 != null)
            {
                TransmissionObject.Instance.WriteUInt16(_arg_1.NameId);
            }
            else
            {
                TransmissionObject.Instance.WriteUInt16(0);
            };
            TransmissionObject.Instance.WriteUInt16(0);
            TransmissionObject.Instance.WriteUInt16(0);
            TransmissionObject.Instance.WriteUInt16(0);
            TransmissionObject.Instance.Flush();
        }

        public function SendGuildRequestList(_arg_1:int):void
        {
			trace("SendGuildRequestList");
        }

        public function SendClearDeathFear():void
        {
			trace("SendClearDeathFear");
            TransmissionObject.Instance.WriteUInt16(1078);
            TransmissionObject.Instance.Flush();
        }

        public function SendClearArenaPunishment():void
        {
			trace("SendClearArenaPunishment");
            TransmissionObject.Instance.WriteUInt16(1079);
            TransmissionObject.Instance.Flush();
        }

        private function OnDataReadyHandler(_arg_1:Event):void
        {
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:int;
            var _local_5:uint;
            var _local_6:Function;
            var _local_7:int;
            var _local_8:uint;
            var _local_9:ByteArray;
            _local_2 = TransmissionObject.Instance.BytesAvailable;
            _local_3 = TransmissionObject.Instance.BufferPosition;
            _local_4 = ((this._nextShouldBeAnAccountID) ? 4 : 2);
            while (_local_2 >= _local_4)
            {
                if (this._nextShouldBeAnAccountID)
                {
                    this._nextShouldBeAnAccountID = false;
                    this._loginAccountId = TransmissionObject.Instance.ReadUInt32();
                }
                else
                {
                    _local_5 = TransmissionObject.Instance.ReadUInt16();
                    _local_6 = this._handlers[_local_5];
					if (_local_5 == 127 || _local_5 == 1059){}
					else
					{
						trace("OnDataReadyHandler_local_5= " + _local_5);
						trace("OnDataReadyHandler_local_6= " + _local_6);
					}
                    if (_local_6 != null)
                    {
                        if (!_local_6())
                        {
                            TransmissionObject.Instance.BufferPosition = _local_3;
                            break;
                        };
                    }
                    else
                    {
                        _local_7 = TransmissionObject.Instance.BytesAvailable;
                        if (_local_7 > 0)
                        {
                            _local_8 = TransmissionObject.Instance.BufferPosition;
                            _local_9 = new ByteArray();
                            TransmissionObject.Instance.ReadBytes(_local_9);
                            TransmissionObject.Instance.BufferPosition = _local_8;
                        };
                    };
                };
                _local_2 = TransmissionObject.Instance.BytesAvailable;
            };
            if (_local_2 == 0)
            {
                TransmissionObject.Instance.ClearBuffer();
            };
        }

        private function OnConnectedHandler(_arg_1:Event):void
        {
			trace("OnConnectedHandler");
            switch (this._state)
            {
                case ClientState.CONNECTED_TO_ACCOUNT:
                    this.SendAccountServerLogin();
                    return;
                case ClientState.CONNECTED_TO_CHARSERVER:
                    this.SendGameLogin();
                    return;
                case ClientState.CONNECTED_TO_MAPSERVER:
                    this.SendMapLogin();
                    return;
            };
        }

        public function get MapName():String
        {
            return (this._mapName);
        }

        public function get MapInstanceId():int
        {
            return (this._mapInstanceId);
        }

        public function get PvpMode():int
        {
            return (this._pvpMode);
        }

        public function DebugShowActors():void
        {
            this._actors.DebugPrint();
        }

        public function get UserEmail():String
        {
            return (this._userEmail);
        }

        public function set UserEmail(_arg_1:String):void
        {
            this._userEmail = _arg_1;
        }

        public function get UserPassword():String
        {
            return (this._userPassword);
        }

        public function set UserPassword(_arg_1:String):void
        {
            this._userPassword = _arg_1;
        }

        public function get SexOld():int
        {
            return (this._sex_old);
        }


    }
}