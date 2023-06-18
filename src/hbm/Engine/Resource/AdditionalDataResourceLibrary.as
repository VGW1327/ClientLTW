


//hbm.Engine.Resource.AdditionalDataResourceLibrary

package hbm.Engine.Resource
{
    import flash.utils.Dictionary;
    import hbm.Application.ClientApplication;
    import flash.events.Event;
    import mx.core.BitmapAsset;
    import org.aswing.AttachIcon;

    public class AdditionalDataResourceLibrary extends ResourceLibrary 
    {

        private var _changelog:Object;
        private var _npc:Dictionary;
        private var _monsters:Dictionary;
        private var _maps:Dictionary;
        private var _quests:Object;
        private var _tutorials:Object;
        private var _giftInfo:Object;
        private var _giftDb:Object;
        private var _giftDb2:Object;
        private var _durabilityDb:Object;
        private var _announce:Dictionary;
        private var _gems:Object;
        private var _jobSkills:Object;
        private var _castles:Object;
        private var _ladders:Object;
        private var _ladderTypes:Object;
        private var _arrowsCraft:Object;
        private var _itemsCraft:Object;
        private var _advts:Object;
        private var _emotions:Object;
        private var _raceMsg:Object;
        private var _canSell:Object;
        private var _buffs:Object;
        private var _statusesC0:Dictionary;
        private var _statusesC1:Dictionary;
        private var _cashShop:Array;
        private var _jobArmorShop:Object;
        private var _premiumShop:Object;
        private var _kafraShop:Array;
        private var _worldMapObjects:Dictionary;
        private var _actions:Array;
        private var _cardCraftItems:Object;
        private var _cardCraft:Object;
        private var _nameGenerate:Object;
        private var _wall:Object;
        private var _roadAtlas:Object;
        private var _extensionRenderMaps:Object;
        private var _npcQuestsMap:Dictionary;
        private var _locationNpcMap:Dictionary;
        private var _subLocationNpcMap:Dictionary;
        private var _questNpcArray:Dictionary;
        private var _craftedItemsForSchemeMap:Dictionary;
        private var _schemesForCraftItemMap:Dictionary;
        private var _npcNameToIdMap:Dictionary;
        private var _animationsData:Object;
        private var _updatesData:Array;


        override public function GetLibraryFileName():String
        {
            return (ClientApplication.Instance.Config.GetFileURL("AdditionalData"));
        }

        override protected function OnResourceLoaded(_arg_1:Event):void
        {
            super.OnResourceLoaded(_arg_1);
        }

        public function GetChangelist():Object
        {
            if (this._changelog)
            {
                return (this._changelog["ChangeList"]);
            };
            return (null);
        }

        public function GetNpcDataFromId(_arg_1:String):Object
        {
            if (this._npc == null)
            {
                return (null);
            };
            return (this._npc[_arg_1]);
        }

        public function GetNpcDataFromName(_arg_1:String):Object
        {
            if (this._npc == null)
            {
                return (null);
            };
            var _local_2:String = this.GetNpcId(_arg_1);
            if (_local_2 == null)
            {
                return (null);
            };
            return (this._npc[_local_2]);
        }

        public function GetMonstersData(_arg_1:String):Object
        {
            if (this._monsters == null)
            {
                return (null);
            };
            return (this._monsters[_arg_1]);
        }

        public function GetMonstersDataById(_arg_1:int):Object
        {
            var _local_2:Object;
            if (this._monsters == null)
            {
                return (null);
            };
            for each (_local_2 in this._monsters)
            {
                if (_local_2["ID"] == _arg_1)
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function GetMapsData(_arg_1:String):Object
        {
            if (this._maps == null)
            {
                return (null);
            };
            var _local_2:String = _arg_1.replace(/(\w+)\.gat/i, "$1");
            return (this._maps[_local_2]);
        }

        public function GetQuestsData(_arg_1:int):Object
        {
            if (this._quests == null)
            {
                return (null);
            };
            return (this._quests["QuestInfo"][_arg_1]);
        }

        public function GetTutorialData(_arg_1:uint):Object
        {
            if (this._tutorials == null)
            {
                return (null);
            };
            return (this._tutorials["WindowInfo"][_arg_1]);
        }

        public function GetUpdatesData():Array
        {
            return (this._updatesData);
        }

        public function get GetQuests():Object
        {
            return (this._quests);
        }

        public function GetGiftInfo(_arg_1:uint):Object
        {
            if (this._giftInfo == null)
            {
                return (null);
            };
            if (this._giftInfo["GiftList"].length == 0)
            {
                return (null);
            };
            return (this._giftInfo["GiftList"][_arg_1]);
        }

        public function GetGiftDbData(_arg_1:int):Object
        {
            if (this._giftDb == null)
            {
                return (null);
            };
            return (this._giftDb[_arg_1]);
        }

        public function get GetGiftDb():Object
        {
            return (this._giftDb);
        }

        public function get GetGiftDb2():Object
        {
            return (this._giftDb2);
        }

        public function get GetDurabilityDb():Object
        {
            return (this._durabilityDb);
        }

        public function GetDurabilityData(_arg_1:int, _arg_2:int):Object
        {
            var _local_3:Object;
            for each (_local_3 in this._durabilityDb.PriceList)
            {
                if ((((_local_3) && (_local_3.Type == _arg_1)) && (_local_3.ColorType == _arg_2)))
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        public function GetWallLevelupData():Object
        {
            if (this._wall == null)
            {
                return (null);
            };
            return (this._wall["LevelUp"]);
        }

        public function GetWallInviteFriendData():Object
        {
            if (this._wall == null)
            {
                return (null);
            };
            return (this._wall["InviteFriend"]);
        }

        public function GetWallUpdatesData():Object
        {
            if (this._wall == null)
            {
                return (null);
            };
            return (this._wall["Updates"]);
        }

        public function GetRoadAtlasData():Object
        {
            return (this._roadAtlas);
        }

        public function GetExtensionRenderMaps():Object
        {
            return (this._extensionRenderMaps);
        }

        public function GetAnnounceData(_arg_1:String):Object
        {
            if (this._announce == null)
            {
                return (null);
            };
            return (this._announce[_arg_1]);
        }

        public function GetActionData(_arg_1:Number):Object
        {
            var _local_2:Object;
            if (((this._actions == null) || (_arg_1 <= 0)))
            {
                return (null);
            };
            if (this._actions.length == 0)
            {
                return (null);
            };
            for each (_local_2 in this._actions)
            {
                if (((_arg_1 >= _local_2["Start"]) && (_arg_1 < _local_2["End"])))
                {
                    return (_local_2);
                };
            };
            return (null);
        }

        public function get GetActions():Array
        {
            return (this._actions);
        }

        public function GetCashShopData(_arg_1:int):Object
        {
            if (this._cashShop == null)
            {
                return (null);
            };
            return (this._cashShop[_arg_1]);
        }

        public function get GetCashShop():Array
        {
            return (this._cashShop);
        }

        public function get JobArmorShop():Object
        {
            return (this._jobArmorShop);
        }

        public function GetPremiumShopData(_arg_1:int):Object
        {
            if (this._premiumShop == null)
            {
                return (null);
            };
            return (this._premiumShop[_arg_1]);
        }

        public function get GetPremiumShop():Object
        {
            return (this._premiumShop);
        }

        public function get GetKafraShop():Array
        {
            return (this._kafraShop);
        }

        public function GetAdvtsData(_arg_1:String):Object
        {
            if (this._advts == null)
            {
                return (null);
            };
            var _local_2:Array = this._advts[_arg_1];
            if (((_local_2) && (_local_2.length > 0)))
            {
                return (_local_2);
            };
            return (null);
        }

        public function GetCastlesData(_arg_1:String):Object
        {
            if (this._castles == null)
            {
                return (null);
            };
            return (this._castles[_arg_1]);
        }

        public function get GetCastles():Object
        {
            return (this._castles);
        }

        public function GetLadderData(_arg_1:int):Object
        {
            if (this._ladders == null)
            {
                return (null);
            };
            return (this._ladders[_arg_1]);
        }

        public function GetLadderTypeData(_arg_1:int):Object
        {
            if (this._ladderTypes == null)
            {
                return (null);
            };
            return (this._ladderTypes[_arg_1]);
        }

        public function GetGemsData(_arg_1:int):Object
        {
            if (this._gems == null)
            {
                return (null);
            };
            return (this._gems["GemInfo"][_arg_1]);
        }

        public function GetGems():Object
        {
            return (this._gems);
        }

        public function GetJobSkills(_arg_1:int):Object
        {
            if (this._jobSkills == null)
            {
                return (null);
            };
            return (this._jobSkills["JobSkillsInfo"][_arg_1]);
        }

        public function GetCardCraftItemData(_arg_1:int):Object
        {
            if (this._cardCraftItems == null)
            {
                return (null);
            };
            return (this._cardCraftItems["CraftItemInfo"][_arg_1]);
        }

        public function GetEmotionData(_arg_1:int):Object
        {
            if (this._emotions == null)
            {
                return (null);
            };
            return (this._emotions["EmotionList"][_arg_1]);
        }

        public function GetFractionMsg(_arg_1:int):String
        {
            if (this._raceMsg == null)
            {
                return (null);
            };
            var _local_2:Object = this._raceMsg["RaceMsgInfo"][_arg_1];
            if (_local_2 == null)
            {
                return (null);
            };
            var _local_3:Array = _local_2["MsgList"];
            if (((_local_3 == null) || (_local_3.length < 1)))
            {
                return (null);
            };
            var _local_4:int = int((Math.random() * _local_3.length));
            return (_local_3[_local_4]);
        }

        public function GetCanSellData(_arg_1:int):Object
        {
            if (this._canSell == null)
            {
                return (null);
            };
            return (this._canSell["SellInfo"][_arg_1]);
        }

        public function GetBitmap(_arg_1:String, _arg_2:String):BitmapAsset
        {
            if (!_arg_2)
            {
                return (null);
            };
            while (_arg_2.length < 3)
            {
                _arg_2 = ("0" + _arg_2);
            };
            var _local_3:String = (("AdditionalData_Item_" + _arg_1) + _arg_2);
            return (GetBitmapAsset(_local_3));
        }

        public function GetAttachIcon(_arg_1:String, _arg_2:String):AttachIcon
        {
            while (_arg_2.length < 3)
            {
                _arg_2 = ("0" + _arg_2);
            };
            var _local_3:String = (("AdditionalData_Item_" + _arg_1) + _arg_2);
            var _local_4:BitmapAsset = GetBitmapAsset(_local_3);
            if (_local_4 == null)
            {
                return (null);
            };
            return (new AttachIcon(_local_3));
        }

        public function GetEmotions():Object
        {
            return (this._emotions["EmotionList"]);
        }

        public function GetBuffData(_arg_1:int):Object
        {
            if (this._buffs == null)
            {
                return (null);
            };
            return (this._buffs["BuffList"][_arg_1]);
        }

        public function GetBuffs():Object
        {
            return (this._buffs["BuffList"]);
        }

        public function GetStatusData(_arg_1:int, _arg_2:String):Object
        {
            var _local_3:Dictionary = ((_arg_1) ? this._statusesC1 : this._statusesC0);
            if (_local_3 == null)
            {
                return (null);
            };
            return ((_local_3[_arg_2] != null) ? _local_3[_arg_2] : this._statusesC0[_arg_2]);
        }

        public function GetWorldMapObjectData(_arg_1:String):Object
        {
            if (this._worldMapObjects == null)
            {
                return (null);
            };
            return (this._worldMapObjects[_arg_1]);
        }

        public function GetWorldMapObjects():Dictionary
        {
            return (this._worldMapObjects);
        }

        public function GetArrowsCraftData(_arg_1:int):Object
        {
            if (this._arrowsCraft == null)
            {
                return (null);
            };
            return (this._arrowsCraft["ArrowInfo"][_arg_1]);
        }

        public function GetArrowsCraft():Object
        {
            return (this._arrowsCraft);
        }

        public function GetCardCraftData(_arg_1:int, _arg_2:int):Object
        {
            var _local_3:Object;
            if (this._cardCraft == null)
            {
                return (null);
            };
            for each (_local_3 in this._cardCraft["CardInfo"])
            {
                if (((_local_3.Source1 == _arg_1) && (_local_3.Source2 == _arg_2)))
                {
                    return (_local_3);
                };
            };
            return (null);
        }

        public function GetItemsCraftData(_arg_1:int):Object
        {
            if (this._itemsCraft == null)
            {
                return (null);
            };
            return (this._itemsCraft["ItemInfo"][_arg_1]);
        }

        public function GetNameGeneratorData():Object
        {
            return (GetJSON("AdditionalData_Data_NameGenerator"));
        }

        public function GetItemsCraft():Object
        {
            return (this._itemsCraft);
        }

        private function LoadChangelogData():void
        {
            this._changelog = GetJSON("Localization_Data_Changelog");
        }

        private function LoadNpcData():void
        {
            var _local_2:Object;
            var _local_3:String;
            var _local_1:Object = GetJSON("Localization_Data_Npc");
            this._npc = new Dictionary(true);
            for each (_local_2 in _local_1.NpcInfo)
            {
                _local_3 = _local_2["Id"];
                this._npc[_local_3] = _local_2;
            };
        }

        private function LoadMonstersData():void
        {
            var _local_1:String;
            var _local_2:Object;
            var _local_4:Object;
            var _local_5:Object;
            var _local_6:Object;
            var _local_8:Object;
            var _local_3:Object = GetJSON("AdditionalData_Data_Monsters");
            this._monsters = new Dictionary(true);
            for each (_local_4 in _local_3.MonstersInfo)
            {
                _local_1 = _local_4["kName"];
                this._monsters[_local_1] = _local_4;
                this._monsters[_local_1]["iName"] = null;
            };
            _local_5 = GetJSON("AdditionalData_Data_MonstersAdd");
            if (((!(_local_5 == null)) && (!(this._monsters == null))))
            {
                for each (_local_2 in _local_5.MonstersAddInfo)
                {
                    _local_1 = _local_2["kName"];
                    _local_6 = this._monsters[_local_1];
                    if (_local_6)
                    {
                        _local_6["DrawShadow"] = ((_local_2["DrawShadow"] != null) ? _local_2["DrawShadow"] : true);
                        _local_6["ShowName"] = ((_local_2["ShowName"] != null) ? _local_2["ShowName"] : true);
                        _local_6["NameColor"] = ((_local_2["NameColor"] != null) ? _local_2["NameColor"] : -1);
                    };
                };
            };
            var _local_7:ResourceLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            if (((!(_local_7 == null)) && (_local_7.IsLoaded)))
            {
                _local_8 = GetJSON("Localization_Data_MonstersName");
                if (((!(_local_8 == null)) && (!(this._monsters == null))))
                {
                    for each (_local_2 in _local_8.MonstersName)
                    {
                        _local_1 = _local_2["kName"];
                        _local_6 = this._monsters[_local_1];
                        if (_local_6)
                        {
                            _local_6["iName"] = _local_2["iName"];
                        };
                    };
                };
            };
        }

        private function LoadMapsData():void
        {
            var _local_2:Object;
            var _local_3:String;
            var _local_1:Object = GetJSON("Localization_Data_Maps");
            this._maps = new Dictionary(true);
            if (_local_1 == null)
            {
                return;
            };
            for each (_local_2 in _local_1.MapsInfo)
            {
                _local_3 = _local_2["ScriptName"];
                this._maps[_local_3] = _local_2;
            };
        }

        private function LoadQuestsData():void
        {
            this._quests = GetJSON("Localization_Data_Quests");
        }

        private function LoadTutorialsData():void
        {
            this._tutorials = GetJSON("Localization_Data_Tutorial");
        }

        private function LoadUpdatesData():void
        {
            var _local_1:Object = GetJSON("Localization_Data_Updates");
            this._updatesData = ((_local_1) ? _local_1.Updates : []);
        }

        private function LoadGiftInfoData():void
        {
            this._giftInfo = GetJSON("Localization_Data_Gifts");
        }

        private function LoadGiftDbData():void
        {
            var _local_1:Object = GetJSON("AdditionalData_Data_GiftDb");
            this._giftDb = _local_1.GiftDbInfo;
        }

        private function LoadGiftDb2Data():void
        {
            var _local_1:Object = GetJSON("AdditionalData_Data_GiftDb2");
            this._giftDb2 = _local_1.GiftDb2Info;
        }

        private function LoadDurabilityDbData():void
        {
            var _local_1:Object = GetJSON("AdditionalData_Data_DurabilityDb");
            this._durabilityDb = _local_1.DurabilityInfo;
        }

        private function LoadWallData():void
        {
            this._wall = GetJSON("AdditionalData_Data_Wall");
        }

        private function LoadRoadAtlas():void
        {
            var _local_1:Object = GetJSON("AdditionalData_Data_RoadAtlas");
            this._roadAtlas = _local_1["RoadAtlas"];
        }

        private function LoadExtensionRender():void
        {
            var _local_1:Object = GetJSON("AdditionalData_Data_ExtensionRender");
            this._extensionRenderMaps = _local_1["ExtensionRender"];
        }

        private function LoadAnnounceData():void
        {
            var _local_2:Object;
            var _local_3:String;
            var _local_1:Object = GetJSON("Localization_Data_Announce");
            this._announce = new Dictionary(true);
            for each (_local_2 in _local_1.MsgInfo)
            {
                _local_3 = _local_2["id"];
                this._announce[_local_3] = _local_2;
            };
        }

        private function LoadActionsData():void
        {
            var _local_2:Object;
            var _local_3:Object;
            var _local_4:Number;
            var _local_5:Number;
            var _local_1:Object = GetJSON("Localization_Data_Actions");
            this._actions = new Array();
            for each (_local_2 in _local_1.ActionList)
            {
                _local_3 = new Object();
                _local_4 = ClientApplication.Instance.ConvertDate(_local_2["StartDate"]);
                _local_5 = ClientApplication.Instance.ConvertDate(_local_2["EndDate"]);
                if (!((_local_4 < 0) || (_local_5 < 0)))
                {
                    _local_3["Height"] = ((_local_2["Height"]) ? _local_2["Height"] : 10);
                    _local_3["Title"] = ((_local_2["Title"]) ? _local_2["Title"] : "");
                    _local_3["Description"] = ((_local_2["Description"]) ? _local_2["Description"] : "");
                    _local_3["Start"] = _local_4;
                    _local_3["End"] = _local_5;
                    _local_3["Icon"] = _local_2["Icon"];
                    _local_3["CashShop"] = _local_2["CashShop"];
                    this._actions.push(_local_3);
                };
            };
        }

        private function LoadAdvtsData():void
        {
            this._advts = GetJSON("Localization_Data_Advt");
        }

        private function LoadCastlesData():void
        {
            var _local_2:Object;
            var _local_3:String;
            var _local_1:Object = GetJSON("Localization_Data_Castles");
            this._castles = new Dictionary(true);
            for each (_local_2 in _local_1.CastleList)
            {
                _local_3 = _local_2["Name"];
                this._castles[_local_3] = _local_2;
            };
        }

        private function LoadLaddersData():void
        {
            var _local_2:Object;
            var _local_3:int;
            var _local_1:Object = GetJSON("Localization_Data_Ladders");
            this._ladders = new Dictionary(true);
            for each (_local_2 in _local_1.LadderList)
            {
                _local_3 = _local_2["Id"];
                this._ladders[_local_3] = _local_2;
            };
        }

        private function LoadLadderTypesData():void
        {
            var _local_2:Object;
            var _local_3:int;
            var _local_1:Object = GetJSON("Localization_Data_LaddersTypes");
            this._ladderTypes = new Dictionary(true);
            for each (_local_2 in _local_1.LadderType)
            {
                _local_3 = _local_2["Type"];
                this._ladderTypes[_local_3] = _local_2;
            };
        }

        private function LoadGemsData():void
        {
            this._gems = GetJSON("Localization_Data_Gems");
        }

        private function LoadJobSkillsData():void
        {
            this._jobSkills = GetJSON("Localization_Data_JobSkills");
        }

        private function LoadCardCraftItemsData():void
        {
            this._cardCraftItems = GetJSON("AdditionalData_Data_CardCraftItems");
        }

        private function LoadEmotionsData():void
        {
            this._emotions = GetJSON("Localization_Data_Emotions");
        }

        private function LoadRaceMsgData():void
        {
            this._raceMsg = GetJSON("Localization_Data_RaceMsg");
        }

        private function LoadCanSellData():void
        {
            this._canSell = GetJSON("AdditionalData_Data_SellItems");
        }

        private function LoadBuffsData():void
        {
            this._buffs = GetJSON("Localization_Data_Buffs");
        }

        private function LoadStatusData():void
        {
            var _local_2:Object;
            var _local_3:int;
            var _local_4:String;
            var _local_1:Object = GetJSON("Localization_Data_Statuses");
            this._statusesC0 = new Dictionary(true);
            this._statusesC1 = new Dictionary(true);
            for each (_local_2 in _local_1.StatusList)
            {
                _local_3 = ((_local_2["ClothesColor"]) ? _local_2["ClothesColor"] : 0);
                _local_4 = _local_2["id"];
                if (_local_3)
                {
                    this._statusesC1[_local_4] = _local_2;
                }
                else
                {
                    this._statusesC0[_local_4] = _local_2;
                };
            };
        }

        private function LoadWorldMapObjectsData():void
        {
            var _local_2:Object;
            var _local_3:String;
            var _local_1:Object = GetJSON("Localization_Data_WorldMap");
            this._worldMapObjects = new Dictionary(true);
            for each (_local_2 in _local_1.MapObjectList)
            {
                _local_3 = _local_2["id"];
                this._worldMapObjects[_local_3] = _local_2;
            };
        }

        private function LoadCashShopData():void
        {
            var _local_1:Object = GetJSON("Localization_Data_CashShop");
            this._cashShop = _local_1.CashShopList;
            this._jobArmorShop = _local_1.Jobs;
        }

        private function LoadPremiumShopData():void
        {
            var _local_1:Object = GetJSON("AdditionalData_Data_PremiumShop");
            this._premiumShop = _local_1.PremiumShopInfo;
        }

        private function LoadKafraShopData():void
        {
            var _local_1:Object = GetJSON("Localization_Data_KafraShop");
            this._kafraShop = _local_1.KafraShopList;
        }

        private function LoadArrowsCraftData():void
        {
            this._arrowsCraft = GetJSON("AdditionalData_Data_ArrowsCraft");
        }

        private function LoadCardCraftData():void
        {
            this._cardCraft = GetJSON("AdditionalData_Data_CardCraft");
        }

        private function LoadItemsCraftData():void
        {
            this._itemsCraft = GetJSON("AdditionalData_Data_ItemsCraft");
        }

        private function InitNpcQuestsMap():void
        {
            var _local_1:Object;
            var _local_2:Array;
            var _local_3:Object;
            var _local_4:Array;
            var _local_5:String;
            var _local_6:Object;
            if (((this._npc == null) || (this._quests == null)))
            {
                return;
            };
            this._npcQuestsMap = new Dictionary(true);
            this._questNpcArray = new Dictionary(true);
            for each (_local_1 in this._npc)
            {
                _local_2 = new Array();
                for each (_local_3 in this._quests.QuestInfo)
                {
                    _local_4 = _local_3.NpcId;
                    if (_local_4 != null)
                    {
                        _local_5 = _local_3.ScriptName;
                        _local_5 = _local_5.replace("Q", "");
                        if (_local_4[0] == _local_1.Id)
                        {
                            _local_2.push(_local_5);
                        };
                        for each (_local_6 in _local_4)
                        {
                            if (!this._questNpcArray.hasOwnProperty(_local_6.toString()))
                            {
                                this._questNpcArray[_local_6] = _local_5;
                            };
                        };
                    };
                };
                if (_local_2.length > 0)
                {
                    this._npcQuestsMap[_local_1.Id] = _local_2;
                };
            };
        }

        public function GetQuestsIdArray(_arg_1:String):Array
        {
            if (this._npcQuestsMap == null)
            {
                return (null);
            };
            return (this._npcQuestsMap[_arg_1]);
        }

        public function IsQuestNpc(_arg_1:String):Boolean
        {
            if (this._npcQuestsMap == null)
            {
                return (false);
            };
            return (!(this._questNpcArray[_arg_1] == null));
        }

        private function InitLocationNpcMap():void
        {
            var _local_1:Object;
            var _local_2:String;
            var _local_3:Array;
            var _local_4:Array;
            var _local_5:Object;
            var _local_6:String;
            var _local_7:Array;
            var _local_8:String;
            if (((this._npc == null) || (this._maps == null)))
            {
                return;
            };
            this._locationNpcMap = new Dictionary(true);
            this._subLocationNpcMap = new Dictionary(true);
            for each (_local_1 in this._maps)
            {
                _local_2 = _local_1.ScriptName;
                _local_3 = new Array();
                _local_4 = new Array();
                for each (_local_5 in this._npc)
                {
                    _local_6 = _local_5.MapName;
                    _local_7 = _local_6.split(",");
                    if (_local_7.length == 1)
                    {
                        if (_local_7[0] == _local_2)
                        {
                            _local_3.push(_local_5.Id);
                        };
                    }
                    else
                    {
                        for each (_local_8 in _local_7)
                        {
                            if (_local_8 == _local_2)
                            {
                                _local_3.push(_local_5.Id);
                                break;
                            };
                        };
                    };
                    if (_local_5.MainMap == _local_2)
                    {
                        _local_4.push(_local_5.Id);
                    };
                };
                if (_local_3.length > 0)
                {
                    this._locationNpcMap[_local_2] = _local_3;
                };
                if (_local_4.length)
                {
                    this._subLocationNpcMap[_local_2] = _local_4;
                };
            };
        }

        public function GetNpcIdArray(_arg_1:String):Array
        {
            if (this._locationNpcMap == null)
            {
                return (null);
            };
            var _local_2:String = _arg_1.replace(/(\w+)\.gat/i, "$1");
            return (this._locationNpcMap[_local_2]);
        }

        public function GetSubNpcIdArray(_arg_1:String):Array
        {
            if (this._subLocationNpcMap == null)
            {
                return (null);
            };
            var _local_2:String = _arg_1.replace(/(\w+)\.gat/i, "$1");
            return (this._subLocationNpcMap[_local_2]);
        }

        private function InitNpcNameToIdMap():void
        {
            var _local_1:Object;
            if (this._npc == null)
            {
                return;
            };
            this._npcNameToIdMap = new Dictionary(true);
            for each (_local_1 in this._npc)
            {
                if (!this._npcNameToIdMap.hasOwnProperty(_local_1.ScriptName))
                {
                    this._npcNameToIdMap[_local_1.ScriptName] = _local_1.Id;
                };
            };
        }

        public function GetNpcId(_arg_1:String):String
        {
            if (this._npcNameToIdMap == null)
            {
                return (null);
            };
            return (this._npcNameToIdMap[_arg_1]);
        }

        private function InitCraftedItemsForSchemeMap():void
        {
            var _local_1:Object;
            var _local_2:int;
            var _local_3:Array;
            if (this._itemsCraft == null)
            {
                return;
            };
            this._craftedItemsForSchemeMap = new Dictionary(true);
            for (_local_1 in this._itemsCraft.ItemInfo)
            {
                _local_2 = this._itemsCraft.ItemInfo[_local_1].Scheme;
                if (!this._craftedItemsForSchemeMap.hasOwnProperty(_local_2.toString()))
                {
                    _local_3 = new Array();
                    _local_3.push(_local_1);
                    this._craftedItemsForSchemeMap[_local_2] = _local_3;
                }
                else
                {
                    this._craftedItemsForSchemeMap[_local_2].push(_local_1);
                };
            };
        }

        private function InitSchemesForCraftItemMap():void
        {
            var _local_1:Object;
            var _local_2:int;
            var _local_3:int;
            var _local_4:Array;
            var _local_5:Boolean;
            var _local_6:int;
            if (this._itemsCraft == null)
            {
                return;
            };
            this._schemesForCraftItemMap = new Dictionary(true);
            for (_local_1 in this._itemsCraft.ItemInfo)
            {
                _local_2 = this._itemsCraft.ItemInfo[_local_1].CraftItem;
                _local_3 = this._itemsCraft.ItemInfo[_local_1].Scheme;
                if (!this._schemesForCraftItemMap.hasOwnProperty(_local_2.toString()))
                {
                    _local_4 = new Array();
                    _local_4.push(_local_3);
                    this._schemesForCraftItemMap[_local_2] = _local_4;
                }
                else
                {
                    _local_5 = false;
                    for each (_local_6 in this._schemesForCraftItemMap[_local_2])
                    {
                        if (_local_6 == _local_3)
                        {
                            _local_5 = true;
                            break;
                        };
                    };
                    if (!_local_5)
                    {
                        this._schemesForCraftItemMap[_local_2].push(_local_3);
                    };
                };
            };
        }

        public function GetCraftedItemsForScheme(_arg_1:int):Array
        {
            if (this._craftedItemsForSchemeMap == null)
            {
                return (null);
            };
            return (this._craftedItemsForSchemeMap[_arg_1]);
        }

        public function GetSchemesForCraftedItem(_arg_1:int):Array
        {
            if (this._schemesForCraftItemMap == null)
            {
                return (null);
            };
            return (this._schemesForCraftItemMap[_arg_1]);
        }

        public function LoadLocalizedData():void
        {
            var _local_1:ResourceLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            if (((!(_local_1 == null)) && (_local_1.IsLoaded)))
            {
                this.LoadAnimationData();
                this.LoadChangelogData();
                this.LoadNpcData();
                this.LoadMapsData();
                this.LoadQuestsData();
                this.LoadTutorialsData();
                this.LoadUpdatesData();
                this.LoadAnnounceData();
                this.LoadGemsData();
                this.LoadJobSkillsData();
                this.LoadCastlesData();
                this.LoadGiftInfoData();
                this.LoadGiftDbData();
                this.LoadGiftDb2Data();
                this.LoadDurabilityDbData();
                this.LoadWallData();
                this.LoadRoadAtlas();
                this.LoadExtensionRender();
                this.LoadLaddersData();
                this.LoadLadderTypesData();
                this.LoadAdvtsData();
                this.LoadEmotionsData();
                this.LoadRaceMsgData();
                this.LoadBuffsData();
                this.LoadCashShopData();
                this.LoadPremiumShopData();
                this.LoadKafraShopData();
                this.LoadActionsData();
                this.LoadStatusData();
                this.LoadWorldMapObjectsData();
            };
            this.LoadMonstersData();
            this.LoadCardCraftItemsData();
            this.LoadArrowsCraftData();
            this.LoadCardCraftData();
            this.LoadItemsCraftData();
            this.LoadCanSellData();
            this.InitNpcQuestsMap();
            this.InitLocationNpcMap();
            this.InitNpcNameToIdMap();
            this.InitCraftedItemsForSchemeMap();
            this.InitSchemesForCraftItemMap();
        }

        public function GetAnimationDataFromId(_arg_1:uint):Object
        {
            if (this._animationsData == null)
            {
                return (null);
            };
            return (this._animationsData[_arg_1]);
        }

        private function LoadAnimationData():void
        {
            this._animationsData = GetJSON("AdditionalData_Data_AnimationData");
        }


    }
}//package hbm.Engine.Resource

