


//hbm.Game.GUI.TopBar

package hbm.Game.GUI
{
    import flash.display.Sprite;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.geom.Point;
    import mx.core.BitmapAsset;
    import hbm.Game.GUI.QuestBook.QuestsPanelController;
    import hbm.Game.GUI.Tutorial.TutorialPanel;
    import flash.display.Bitmap;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Renderer.RenderSystem;
    import flash.events.MouseEvent;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Application.Social.SocialFriends;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import flash.display.InteractiveObject;
    import hbm.Engine.Actors.CharacterInfo;
    import flash.events.Event;
    import hbm.Game.Utility.CharacterMenu;
    import hbm.Game.Character.CharacterStorage;
    import flash.utils.getDefinitionByName;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import org.aswing.event.AWEvent;
    import hbm.Game.Statistic.StatisticManager;
    import hbm.Engine.Actors.PetInfo;
    import hbm.Engine.Actors.GuildInfo;
    import hbm.Engine.Actors.PartyInfo;
    import hbm.Engine.Actors.GuildMember;
    import hbm.Engine.Actors.PartyMember;

    public class TopBar extends Sprite 
    {

        public static const TIME_TO_UPDATE_ARENA:int = 1000;

        private const MINI_MAP_UPDATE_TIME:int = 2000;

        private var _bitmapDataCash:BitmapData;
        private var _currentMapWithNPC:DisplayObject;
        private var _graphicsName:String;
        private var _mapId:String;
        private var _magicNumber:Number;
        private var _position:Point;
        private var _lastFrameTickTime:int = 0;
        private var _topHUD:TopHUD;
        private var _currentIconRef:String;
        private var _currentIcon:DisplayObject;
        private var _currentPetIconId:int;
        private var _currentPetIcon:BitmapAsset;
        private var _toolTips:Array;
        public var _arenaPanel:FLHeroes;
        private var _arenaTime:Number = 0;
        private var _timeToUpdateArena:uint = 0;
        private var _actionPanelController:ActionPanelController;
        private var _questsPanel:QuestsPanelController;
        private var _tutorialPanel:TutorialPanel;
        private var _pointPartyLeaderBitmap:Bitmap;
        private var _pointGuildMemberBitmap:Bitmap;
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _itemLibrary:ItemsResourceLibrary;

        public function TopBar()
        {
            x = (RenderSystem.Instance.ScreenWidth / 2);
            y = 0;
            this._topHUD = new TopHUD();
            tabEnabled = false;
            tabChildren = false;
            this._tutorialPanel = new TutorialPanel();
            this._arenaPanel = new FLHeroes();
            this._topHUD._characterStatusWindow._cloudButton.addEventListener(MouseEvent.CLICK, this.OnOpenCloud, false, 0, true);
            this._topHUD._characterStatusWindow._buffButton.addEventListener(MouseEvent.CLICK, this.OnBuff, false, 0, true);
            this._topHUD._characterStatusWindow._hpButton.addEventListener(MouseEvent.CLICK, this.OnRestoreHp, false, 0, true);
            this._topHUD._characterStatusWindow._manaButton.addEventListener(MouseEvent.CLICK, this.OnRestoreSp, false, 0, true);
            this._topHUD._characterStatusWindow._smallAvatar.addEventListener(MouseEvent.CLICK, this.OnStatusWindow, false, 0, true);
            this._topHUD._selectedActorInfo._level.addEventListener(MouseEvent.CLICK, this.OnLevelClicked, false, 0, true);
            this._topHUD._petStatusWindow._foodButton.addEventListener(MouseEvent.CLICK, this.OnPetFeed, false, 0, true);
            this._topHUD._petStatusWindow._takeButton.addEventListener(MouseEvent.CLICK, this.OnPetTake, false, 0, true);
            this._topHUD._mapPanel._minimapButton.addEventListener(MouseEvent.CLICK, this.OnMinimapButtonPressed, false, 0, true);
            this._topHUD._mapPanel._topMap.addEventListener(MouseEvent.CLICK, this.OnMinimapButtonPressed, false, 0, true);
            this._topHUD._mapPanel._topMap.buttonMode = true;
            this._topHUD._mapPanel._portalButton.addEventListener(MouseEvent.CLICK, this.OnPortalButtonPressed, false, 0, true);
            this._topHUD._mapPanel._npcButton.addEventListener(MouseEvent.CLICK, this.OnNPCButtonPressed, false, 0, true);
            this._topHUD._mapPanel._witchButton.addEventListener(MouseEvent.CLICK, this.OnWitchButtonPressed, false, 0, true);
            addChild(this._topHUD);
            if (x != 400)
            {
                this._topHUD._characterStatusWindow.x = (this._topHUD._characterStatusWindow.x + (400 - x));
                this._topHUD._questsButton.x = (this._topHUD._questsButton.x + (400 - x));
                this._topHUD._questsNotifyButton.x = (this._topHUD._questsNotifyButton.x + (400 - x));
            };
            this._arenaPanel.y = 60;
            this._arenaPanel.x = (-(this._arenaPanel.width) / 2);
            addChild(this._arenaPanel);
            this._toolTips = new Array();
            this.AddToolTip(this._topHUD._characterStatusWindow._cloudButton, ClientApplication.Instance.GetPopupText(267), 105, 10);
            this.AddToolTip(this._topHUD._characterStatusWindow._characterName, ClientApplication.Instance.GetPopupText(3), 105, 10);
            this.AddToolTip(this._topHUD._characterStatusWindow._healthDetail, ClientApplication.Instance.GetPopupText(6), 250, 40);
            this.AddToolTip(this._topHUD._characterStatusWindow._manaDetail, ClientApplication.Instance.GetPopupText(7), 220, 40);
            this.AddToolTip(this._topHUD._characterStatusWindow._buffButton, ClientApplication.Instance.GetPopupText(171), 150, 20);
            this.AddToolTip(this._topHUD._characterStatusWindow._manaButton, ClientApplication.Instance.GetPopupText(173), 190, 20);
            this.AddToolTip(this._topHUD._characterStatusWindow._hpButton, ClientApplication.Instance.GetPopupText(172), 210, 20);
            this.AddToolTip(this._topHUD._petStatusWindow._foodButton, ClientApplication.Instance.GetPopupText(99), 250, 40);
            this.AddToolTip(this._topHUD._petStatusWindow._takeButton, ClientApplication.Instance.GetPopupText(98), 250, 40);
            this.AddToolTip(this._topHUD._petStatusWindow._hungryDetail, ClientApplication.Instance.GetPopupText(103), 250, 65);
            this.AddToolTip(this._topHUD._petStatusWindow._intimacyDetail, ClientApplication.Instance.GetPopupText(102), 250, 40);
            this.AddToolTip(this._topHUD._petStatusWindow._petName, ClientApplication.Instance.GetPopupText(100), 160, 20);
            this.AddToolTip(this._topHUD._mapPanel._helpButton, ClientApplication.Instance.GetPopupText(16), 250, 40);
            this.AddToolTip(this._topHUD._mapPanel._settingsButton, ClientApplication.Instance.GetPopupText(15), 250, 40);
            this.AddToolTip(this._topHUD._mapPanel._fullscreenButton, ClientApplication.Instance.GetPopupText(253), 200, 30);
            this.AddToolTip(this._topHUD._questsButton, ClientApplication.Instance.GetPopupText(26), 220, 50);
            this.AddToolTip(this._topHUD._questsNotifyButton, ClientApplication.Instance.GetPopupText(26), 220, 50);
            this.AddToolTip(this._topHUD._mapPanel._timeLabel, ClientApplication.Instance.GetPopupText(243), 150, 10);
            this.AddToolTip(this._arenaPanel._button, ClientApplication.Instance.GetPopupText(242), 250, 235);
            this.AddToolTip(this._topHUD._mapPanel._topMap, ClientApplication.Instance.GetPopupText(20), 250, 40);
            this.AddToolTip(this._topHUD._mapPanel._worldmapButton, ClientApplication.Instance.GetPopupText(175), 150, 30);
            this.AddToolTip(this._topHUD._mapPanel._portalButton, ClientApplication.Instance.GetPopupText(237), 250, 60);
            this.AddToolTip(this._topHUD._mapPanel._minimapButton, ClientApplication.Instance.GetPopupText(238), 250, 40);
            this.AddToolTip(this._topHUD._mapPanel._worldmapButton, ClientApplication.Instance.GetPopupText(175), 250, 40);
            this.AddToolTip(this._topHUD._mapPanel._guideButton, ClientApplication.Instance.GetPopupText(239), 170, 40);
            this.AddToolTip(this._topHUD._mapPanel._pritonButton, ClientApplication.Instance.GetPopupText(281), 170, 40);
            this.AddToolTip(this._topHUD._characterStatusWindow._elfCounter, ClientApplication.Instance.GetPopupText(265), 250, 40);
            this.AddToolTip(this._topHUD._mapPanel._npcButton, ClientApplication.Instance.GetPopupText(286), 185, 40);
            this.AddToolTip(this._topHUD._mapPanel._witchButton, ClientApplication.Instance.GetPopupText(287), 185, 40);
            this._topHUD._selectedActorInfo.visible = false;
            this._topHUD._petStatusWindow.visible = false;
            this._topHUD._petStatusWindow._renameButton.visible = false;
            this._arenaPanel.visible = false;
            this._topHUD._characterStatusWindow._advancedButton.visible = false;
            this._topHUD._characterStatusWindow._topButton.visible = false;
            this._topHUD._selectedActorInfo._equipButton.visible = false;
            this._topHUD._questsNotifyButton.visible = false;
            this._topHUD._characterStatusWindow._elfCounter.visible = false;
            this._topHUD._characterStatusWindow._elfCounter.gotoAndStop(0);
            this._topHUD._actionPanel.visible = false;
            this._position = new Point(0, 0);
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._itemLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            this.InitPanels();
        }

        private function OnNPCButtonPressed(_arg_1:MouseEvent):void
        {
            ClientApplication.Instance.OpenNPCLocationWindow();
        }

        private function OnWitchButtonPressed(_arg_1:MouseEvent):void
        {
            ClientApplication.Instance.OpenWitchWindow();
        }

        private function OnOpenCloud(_arg_1:MouseEvent):void
        {
            var _local_2:SocialFriends = ClientApplication.Instance.GetSocialFriends();
            if (_local_2)
            {
                _local_2.ShowCloudWindow();
            };
        }

        public function GetTutorialPanel():TutorialPanel
        {
            return (this._tutorialPanel);
        }

        public function get QuestsPanel():QuestsPanelController
        {
            return (this._questsPanel);
        }

        public function GetSelectedActorInfo():SelectedActorInfoNew
        {
            return (this._topHUD._selectedActorInfo);
        }

        protected function AddToolTip(_arg_1:InteractiveObject, _arg_2:String, _arg_3:int=-1, _arg_4:int=-1):void
        {
            var _local_5:CustomToolTip = new CustomToolTip(_arg_1, _arg_2, _arg_3, _arg_4);
            this._toolTips.push(_local_5);
        }

        public function SetHealth(_arg_1:int, _arg_2:int):void
        {
            if (_arg_2 > 0)
            {
                this._topHUD._characterStatusWindow._healthBar._progressMask.scaleX = (_arg_1 / _arg_2);
            };
            this._topHUD._characterStatusWindow._healthDetail.text = ((_arg_1.toString() + "/") + _arg_2.toString());
            this._topHUD._characterStatusWindow._hpButton.visible = (!(_arg_1 == _arg_2));
        }

        public function SetMana(_arg_1:int, _arg_2:int):void
        {
            if (_arg_2 > 0)
            {
                this._topHUD._characterStatusWindow._manaBar._progressMask.scaleX = (_arg_1 / _arg_2);
            };
            this._topHUD._characterStatusWindow._manaDetail.text = ((_arg_1.toString() + "/") + _arg_2.toString());
            this._topHUD._characterStatusWindow._manaButton.visible = (!(_arg_1 == _arg_2));
        }

        public function SetNameAndLevel(_arg_1:CharacterInfo):void
        {
            this._topHUD._characterStatusWindow._characterName.text = _arg_1.name;
        }

        private function OnStatusWindow(_arg_1:Event):void
        {
            ClientApplication.Instance.ShowLevelWindow();
        }

        private function OnLevelClicked(_arg_1:Event):void
        {
            var _local_3:uint;
            var _local_2:String = this._topHUD._selectedActorInfo._characterId.text;
            if (_local_2 != "")
            {
                _local_3 = uint(_local_2);
                CharacterMenu.ShowUserMenu(_local_3);
            };
        }

        public function RevalidateAvatar():void
        {
            var classIcon:Class;
            var classIconRef:String = CharacterStorage.Instance.LocalPlayerIconSmall;
            if (classIconRef != null)
            {
                if (classIconRef === this._currentIconRef)
                {
                    return;
                };
                this._currentIconRef = classIconRef;
                if (this._currentIcon != null)
                {
                    this._topHUD._characterStatusWindow._smallAvatar.removeChild(this._currentIcon);
                    this._currentIcon = null;
                };
                try
                {
                    classIcon = (getDefinitionByName(classIconRef) as Class);
                    this._currentIcon = new (classIcon)();
                    this._currentIcon.x = 1;
                    this._currentIcon.y = 1;
                    this._topHUD._characterStatusWindow._smallAvatar.addChild(this._currentIcon);
                }
                catch(e:ReferenceError)
                {
                    _currentIconRef = null;
                };
            };
        }

        public function RevalidatePetAvatar(_arg_1:int):void
        {
            if (!this._itemLibrary)
            {
                this._itemLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            };
            if (_arg_1 > 0)
            {
                if (_arg_1 == this._currentPetIconId)
                {
                    return;
                };
                this._currentPetIconId = _arg_1;
                if (this._currentPetIcon != null)
                {
                    this._topHUD._petStatusWindow._smallAvatar._image.removeChild(this._currentPetIcon);
                    this._currentPetIcon = null;
                };
                this._currentPetIcon = this._itemLibrary.GetItemBitmapAsset(_arg_1);
                this._currentPetIcon.scaleX = 1.5;
                this._currentPetIcon.scaleY = 1.5;
                this._currentPetIcon.smoothing = true;
                this._currentPetIcon.x = (-(this._currentPetIcon.width) / 2);
                this._currentPetIcon.y = (-(this._currentPetIcon.height) / 2);
                this._topHUD._petStatusWindow._smallAvatar._image.addChild(this._currentPetIcon);
            };
        }

        public function get GetTopHUD():TopHUD
        {
            return (this._topHUD);
        }

        private function OnBuff(_arg_1:MouseEvent):void
        {
            ClientApplication.Instance.ShowBuffWindow();
        }

        private function OnSkipTutorialClick(ewt:AWEvent):void
        {
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.QUEST_BOOK_BUTTON_CANCEL_TUTORIAL, ClientApplication.Localization.QUEST_BOOK_CANCEL_TUTORIAL_MESSAGE, function OnQusetCancelAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    ClientApplication.Instance.LocalGameClient.SendRemoteNPCClick("ToSkipTutorial");
                };
            }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)), "", "", ClientApplication.Localization.QUEST_BOOK_BUTTON_CANCEL_TUTORIAL_YES, ClientApplication.Localization.QUEST_BOOK_BUTTON_CANCEL_TUTORIAL_NO);
        }

        private function OnNextTutorialClick(ewt:AWEvent):void
        {
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.QUEST_BOOK_BUTTON_CANCEL_TUTORIAL_STEP, ClientApplication.Localization.QUEST_BOOK_CANCEL_TUTORIAL_STEP_MESSAGE, function OnQusetCancelAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    ClientApplication.Instance.LocalGameClient.SendRemoteNPCClick("SkipTutorialStep");
                };
            }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)), "", "", ClientApplication.Localization.QUEST_BOOK_BUTTON_CANCEL_TUTORIAL_STEP_YES, ClientApplication.Localization.QUEST_BOOK_BUTTON_CANCEL_TUTORIAL_STEP_NO);
        }

        private function OnRestoreHp(ewt:MouseEvent):void
        {
            var/*const*/ priceInCols:Number = NaN;
            var player:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            if (player.hp < player.maxHp)
            {
                priceInCols = 10;
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ((ClientApplication.Localization.CASH_RESTORE_HP_MESSAGE + " ") + priceInCols), function OnOperationAccepted (_arg_1:int):void
                {
                    if (_arg_1 == JOptionPane.YES)
                    {
                        ClientApplication.Instance.LocalGameClient.SendChatMessage("@cashrestorehp");
                        StatisticManager.Instance.SendEvent("GoldRestoreHP");
                    };
                }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.CASH_RESTORE_HP_LIMIT, null, null, true, new AttachIcon("AchtungIcon")));
            };
        }

        private function OnRestoreSp(ewt:MouseEvent):void
        {
            var/*const*/ priceInCols:Number = NaN;
            var player:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            if (player.sp < player.maxSp)
            {
                priceInCols = 10;
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ((ClientApplication.Localization.CASH_RESTORE_SP_MESSAGE + " ") + priceInCols), function OnOperationAccepted (_arg_1:int):void
                {
                    if (_arg_1 == JOptionPane.YES)
                    {
                        ClientApplication.Instance.LocalGameClient.SendChatMessage("@cashrestoresp");
                        StatisticManager.Instance.SendEvent("GoldRestoreMP");
                    };
                }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.CASH_RESTORE_SP_LIMIT, null, null, true, new AttachIcon("AchtungIcon")));
            };
        }

        public function RevalidatePositions():void
        {
            var _local_1:int = int((RenderSystem.Instance.ScreenWidth / 2));
            this._topHUD._characterStatusWindow.x = (-(_local_1) + 7);
            this._topHUD._questsButton.x = -(_local_1);
            this._topHUD._questsNotifyButton.x = -(_local_1);
            this._topHUD._petStatusWindow.x = (-(_local_1) + 5);
            this._topHUD._mapPanel.x = _local_1;
        }

        public function InitArena():void
        {
            this._arenaPanel.visible = true;
            this._arenaTime = 60;
            this._arenaPanel._text2.text = "00:59";
        }

        public function UpdateArenaData(_arg_1:int):void
        {
            if (!this._arenaPanel.visible)
            {
                return;
            };
            if ((_arg_1 - this._timeToUpdateArena) < TIME_TO_UPDATE_ARENA)
            {
                return;
            };
            this._timeToUpdateArena = _arg_1;
            if (this._arenaTime == 0)
            {
                return;
            };
            this._arenaTime = (this._arenaTime - 1);
            this._arenaPanel._text2.text = ("00:" + ((this._arenaTime > 9) ? this._arenaTime : ("0" + this._arenaTime)));
        }

        public function RevalidatePet():void
        {
            var _local_1:PetInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Pet;
            this._topHUD._petStatusWindow.visible = (_local_1.Id > 0);
            this._topHUD._petStatusWindow._petName.text = ((_local_1.Name) ? _local_1.Name : "");
            this._topHUD._petStatusWindow._hungryBar._progressMask.scaleX = (_local_1.Hungry / 100);
            this._topHUD._petStatusWindow._hungryDetail.text = ((_local_1.Hungry + "/") + 100);
            this._topHUD._petStatusWindow._intimacyBar._progressMask.scaleX = (_local_1.Intimacy / 1000);
            this._topHUD._petStatusWindow._intimacyDetail.text = ((_local_1.Intimacy + "/") + 1000);
            if (((_local_1.Intimacy <= 0) || (_local_1.Incuvate == 1)))
            {
                this._topHUD._petStatusWindow.visible = false;
            };
            if (((_local_1.EggId > 0) && (this._topHUD._petStatusWindow.visible)))
            {
                this.RevalidatePetAvatar(_local_1.EggId);
            };
        }

        private function OnPetTake(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendPetReturnToEgg();
        }

        private function OnPetFeed(_arg_1:Event):void
        {
            ClientApplication.Instance.LocalGameClient.SendPetFeed();
        }

        public function UpdateServerTime(_arg_1:String):void
        {
            this._topHUD._mapPanel._timeLabel.text = _arg_1;
        }

        private function OnMinimapButtonPressed(_arg_1:Event):void
        {
            ClientApplication.Instance.OpenMiniMap(this._currentMapWithNPC, this._magicNumber);
        }

        private function OnPortalButtonPressed(evt:Event):void
        {
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.STONE_PORTAL_MESSAGE, function OnAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    ClientApplication.Instance.LocalGameClient.SendRemoteNPCClick("SPWarperKey");
                };
            }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
        }

        public function SetMapParameters(_arg_1:Object):void
        {
            var _local_2:String = _arg_1["Name"];
            var _local_3:String = _arg_1["ScriptName"];
            var _local_4:String = _arg_1["GraphicsName"];
            var _local_5:Number = Number(_arg_1["MagicNumber"]);
            this._topHUD._mapPanel._mapName.text = _local_2;
            this._graphicsName = _local_4;
            this._mapId = _local_3;
            this._magicNumber = _local_5;
        }

        public function InitializeMiniMap():void
        {
            var miniMap:Class;
            var pointBitmapData:BitmapData;
            var pointNpcBitmap:Bitmap;
            var pointChestBitmap:Bitmap;
            var pointPortalBitmap:Bitmap;
            var pointShopBitmap:Bitmap;
            var whoopBitmap:Bitmap;
            var questionBitmap:Bitmap;
            var npcIdArray:Object;
            var player:CharacterInfo;
            var guild:GuildInfo;
            var party:PartyInfo;
            var bitmapData:BitmapData;
            var npcId:String;
            var npcInfo:Object;
            var questStatus:int;
            var member:GuildMember;
            var partyMember:PartyMember;
            if (this._currentMapWithNPC != null)
            {
                this._topHUD._mapPanel._topMap._mapPicture.removeChild(this._currentMapWithNPC);
            };
            try
            {
                miniMap = (getDefinitionByName((this._graphicsName + "_MiniMap")) as Class);
                this._currentMapWithNPC = new (miniMap)();
                pointBitmapData = null;
                if (this._dataLibrary == null)
                {
                    this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
                };
                pointNpcBitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_PointNpc");
                pointChestBitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_PointChest");
                pointPortalBitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_PointPortal");
                pointShopBitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_PointShop");
                whoopBitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_WhoopSmall");
                questionBitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_QuestionSmall");
                npcIdArray = this._dataLibrary.GetNpcIdArray(this._mapId);
                if (((!(npcIdArray == null)) && (npcIdArray.length > 0)))
                {
                    bitmapData = (this._currentMapWithNPC as Bitmap).bitmapData;
                    for each (npcId in npcIdArray)
                    {
                        npcInfo = this._dataLibrary.GetNpcDataFromId(npcId);
                        if (((!(npcInfo == null)) && ((npcInfo.PositionX >= 0) || (npcInfo.PositionY >= 0))))
                        {
                            switch (npcInfo.Type)
                            {
                                case 0:
                                    questStatus = CharacterStorage.Instance.LocalPlayerCharacter.GetQuestStatus(npcInfo.Id);
                                    if (questStatus == 2)
                                    {
                                        pointBitmapData = questionBitmap.bitmapData;
                                    }
                                    else
                                    {
                                        if (questStatus == 1)
                                        {
                                            pointBitmapData = whoopBitmap.bitmapData;
                                        }
                                        else
                                        {
                                            pointBitmapData = pointNpcBitmap.bitmapData;
                                        };
                                    };
                                    break;
                                case 1:
                                case 2:
                                case 3:
                                    pointBitmapData = pointShopBitmap.bitmapData;
                                    break;
                                case 10:
                                    pointBitmapData = pointPortalBitmap.bitmapData;
                                    break;
                                case 15:
                                    pointBitmapData = pointChestBitmap.bitmapData;
                                    break;
                            };
                            if (pointBitmapData != null)
                            {
                                this._position.x = ((npcInfo.PositionX * this._magicNumber) - (pointBitmapData.width / 2));
                                this._position.y = ((this._currentMapWithNPC.height - (npcInfo.PositionY * this._magicNumber)) - (pointBitmapData.height / 2));
                                bitmapData.copyPixels(pointBitmapData, pointBitmapData.rect, this._position, pointBitmapData, pointBitmapData.rect.topLeft, true);
                            };
                        };
                    };
                };
                this._bitmapDataCash = (this._currentMapWithNPC as Bitmap).bitmapData.clone();
                player = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                guild = ((player) ? player.Guild : null);
                party = ((player) ? player.Party : null);
                if (guild != null)
                {
                    for each (member in guild.members)
                    {
                        member.coordinates = null;
                    };
                };
                if (party != null)
                {
                    for each (partyMember in party.PartyMembers)
                    {
                        if (partyMember.Leader)
                        {
                            this._position.x = -1;
                            this._position.y = -1;
                            break;
                        };
                    };
                };
                this._topHUD._mapPanel._topMap._mapPicture.addChild(this._currentMapWithNPC);
                if (ClientApplication.Instance.MiniMapWindowInstance)
                {
                    ClientApplication.Instance.MiniMapWindowInstance.SetMap(this._currentMapWithNPC, this._magicNumber, this._topHUD._mapPanel._mapName.text);
                };
            }
            catch(e:ReferenceError)
            {
            };
        }

        public function RevalidateMiniMap(_arg_1:int):void
        {
            var _local_2:Bitmap;
            var _local_3:BitmapData;
            var _local_4:CharacterInfo;
            var _local_5:GuildInfo;
            var _local_6:PartyInfo;
            var _local_7:GuildMember;
            var _local_8:PartyMember;
            var _local_9:PartyMember;
            if (this._currentMapWithNPC != null)
            {
                if ((_arg_1 - this._lastFrameTickTime) < this.MINI_MAP_UPDATE_TIME)
                {
                    return;
                };
                this._lastFrameTickTime = _arg_1;
                this._topHUD._mapPanel._topMap._mapPicture.removeChild(this._currentMapWithNPC);
                _local_2 = (this._currentMapWithNPC as Bitmap);
                _local_2.bitmapData = this._bitmapDataCash.clone();
                _local_3 = null;
                if (((this._pointPartyLeaderBitmap == null) || (this._pointGuildMemberBitmap == null)))
                {
                    if (this._dataLibrary == null)
                    {
                        this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
                    };
                    if (this._pointPartyLeaderBitmap == null)
                    {
                        this._pointPartyLeaderBitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_PointPartyLeader");
                    };
                    if (this._pointGuildMemberBitmap == null)
                    {
                        this._pointGuildMemberBitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_PointGuildMember");
                    };
                };
                _local_4 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                _local_5 = ((_local_4) ? _local_4.Guild : null);
                _local_6 = ((_local_4) ? _local_4.Party : null);
                if (_local_5 != null)
                {
                    _local_3 = this._pointGuildMemberBitmap.bitmapData;
                    if (_local_3 != null)
                    {
                        for each (_local_7 in _local_5.members)
                        {
                            if (_local_7.coordinates != null)
                            {
                                if (_local_6 != null)
                                {
                                    _local_8 = _local_6.PartyMembers[_local_7.accountId];
                                    if (_local_8 != null) continue;
                                };
                                this._position.x = ((_local_7.coordinates.x * this._magicNumber) - (_local_3.width / 2));
                                this._position.y = ((this._currentMapWithNPC.height - (_local_7.coordinates.y * this._magicNumber)) - (_local_3.height / 2));
                                _local_2.bitmapData.copyPixels(_local_3, _local_3.rect, this._position, _local_3, _local_3.rect.topLeft, true);
                            };
                        };
                    };
                };
                if (_local_6 != null)
                {
                    _local_3 = this._pointPartyLeaderBitmap.bitmapData;
                    if (_local_3 != null)
                    {
                        for each (_local_9 in _local_6.PartyMembers)
                        {
                            if (((_local_9.X >= 0) && (_local_9.Y >= 0)))
                            {
                                this._position.x = ((_local_9.X * this._magicNumber) - (_local_3.width / 2));
                                this._position.y = ((this._currentMapWithNPC.height - (_local_9.Y * this._magicNumber)) - (_local_3.height / 2));
                                _local_2.bitmapData.copyPixels(_local_3, _local_3.rect, this._position, _local_3, _local_3.rect.topLeft, true);
                                break;
                            };
                        };
                    };
                };
                this._topHUD._mapPanel._topMap._mapPicture.addChild(this._currentMapWithNPC);
                if (ClientApplication.Instance.MiniMapWindowInstance)
                {
                    ClientApplication.Instance.MiniMapWindowInstance.SetMap(this._currentMapWithNPC, this._magicNumber, this._topHUD._mapPanel._mapName.text);
                };
            };
        }

        public function RevalidateMapPosition():void
        {
            var _local_1:Point;
            var _local_2:Number;
            var _local_3:Number;
            var _local_4:CharacterInfo;
            if (this._currentMapWithNPC != null)
            {
                _local_1 = CharacterStorage.Instance.LocalPlayerCharacter.Position;
                _local_2 = ((this._currentMapWithNPC.width * _local_1.x) / RenderSystem.Instance.MainCamera.MaxWidth);
                _local_3 = ((this._currentMapWithNPC.height * _local_1.y) / RenderSystem.Instance.MainCamera.MaxHeight);
                this._currentMapWithNPC.x = -(_local_2);
                this._currentMapWithNPC.y = -(this._currentMapWithNPC.height - _local_3);
                _local_4 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                if (_local_4)
                {
                    this._topHUD._mapPanel._topMap._mapPointer.rotation = (_local_4.coordinates.dir * 45);
                };
            };
        }

        private function InitPanels():void
        {
            this._actionPanelController = new ActionPanelController(this._topHUD._actionPanel);
            this._questsPanel = new QuestsPanelController();
        }

        public function UpdateElfCounter(_arg_1:int):void
        {
            var _local_2:int;
            this._topHUD._characterStatusWindow._elfCounter.visible = false;
            this._topHUD._characterStatusWindow._elfCounter._text.text = _arg_1.toString();
            if (_arg_1 > 1000)
            {
                _local_2 = 6;
            }
            else
            {
                if (_arg_1 > 800)
                {
                    _local_2 = 5;
                }
                else
                {
                    if (_arg_1 > 600)
                    {
                        _local_2 = 4;
                    }
                    else
                    {
                        if (_arg_1 > 400)
                        {
                            _local_2 = 3;
                        }
                        else
                        {
                            if (_arg_1 > 200)
                            {
                                _local_2 = 2;
                            }
                            else
                            {
                                if (_arg_1 > 100)
                                {
                                    _local_2 = 1;
                                };
                            };
                        };
                    };
                };
            };
            this._topHUD._characterStatusWindow._elfCounter.gotoAndStop(_local_2);
        }

        public function BlinkQuestButton(_arg_1:Boolean):void
        {
            this._topHUD._questsButton.visible = (!(_arg_1));
            this._topHUD._questsNotifyButton.visible = _arg_1;
        }


    }
}//package hbm.Game.GUI

