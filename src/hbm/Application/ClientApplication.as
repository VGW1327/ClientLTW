package hbm.Application
{
    import flash.display.Sprite;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import br.com.stimuli.loading.BulkLoader;
    import flash.display.Bitmap;
    import flash.utils.Timer;
    import hbm.Game.Renderer.FogObject;
    import hbm.Game.Renderer.Background;
    import hbm.Game.Renderer.MovePointerObject;
    import flash.text.TextField;
    import hbm.Game.Utility.FpsCalculator;
    import hbm.Game.GUI.LoadingScreen;
    import hbm.Game.GUI.LoadingAdditionalData;
    import hbm.Game.GUI.ConnectingToServer;
    import hbm.Game.GUI.Dialogs.LoginPromptWindow;
    import hbm.Game.GUI.MovingPerspective;
    import hbm.Game.GUI.Dialogs.ChooseWorldDialog;
    import hbm.Game.GUI.CharacterCreation.CharacterListWindow;
    import hbm.Game.GUI.CharacterCreation.NewCharacterCreateWindow;
    import hbm.Game.GUI.CharacterCreation.CharacterRenameDialog;
    import hbm.Engine.Network.Client.Client;
    import hbm.Game.GUI.TopBar;
    import hbm.Game.GUI.BottomBar;
    import hbm.Game.GUI.NewChat.ChatBar;
    import hbm.Game.GUI.PartyList.PartyController;
    import hbm.Game.GUI.Skills.SkillWindow;
    import hbm.Game.GUI.Skills.AdvancedSkillWindow;
    import hbm.Game.GUI.Emotion.EmotionWindow;
    import hbm.Game.GUI.Guild.EmblemWindow;
    import hbm.Game.GUI.Buffs.BuffWindow;
    import hbm.Game.GUI.Book.BookWindow;
    import hbm.Game.GUI.CharacterInventory.CharacterInventoryWindow;
    import hbm.Game.GUI.Guild.GuildWindow;
    import hbm.Game.GUI.Friends.FriendsWindow;
    import hbm.Game.GUI.Skills.GuildSkillWindow;
    import hbm.Game.GUI.Dialogs.SettingsWindow;
    import hbm.Game.GUI.Craft.ProduceListDialog;
    import hbm.Game.GUI.Store.StoreWindow;
    import hbm.Game.GUI.Storage.StorageWindow;
    import hbm.Game.GUI.Cart.CartWindow;
    import hbm.Game.GUI.Vender.ShopWindow;
    import hbm.Game.GUI.CashShopNew.StashAuctionWindow;
    import hbm.Game.GUI.PremiumShop.PremiumShopWindow;
    import hbm.Game.GUI.CashShop.KafraShopWindow;
    import hbm.Game.GUI.QuestBook.QuestsWindow;
    import hbm.Game.GUI.Gifts.WitchWindow;
    import hbm.Game.GUI.LevelUp.LevelUpWindow;
    import hbm.Game.GUI.Dialogs.PartnerWindow;
    import hbm.Game.GUI.Refine.RefineWindow;
    import hbm.Game.GUI.Runes.UpgradeWindow;
    import hbm.Game.GUI.ChangelogWindow;
    import hbm.Game.GUI.Castles.CastlesWindow;
    import hbm.Game.GUI.Ladders.LaddersWindow;
    import hbm.Game.GUI.WorldMap.WorldMapWindow;
    import hbm.Game.GUI.MiniMap.MiniMapWindow;
    import hbm.Game.GUI.LevelInfo.LevelWindow;
    import hbm.Game.GUI.Trade.TradeWindow;
    import hbm.Game.GUI.PremiumPack.PremiumPackWindow;
    import hbm.Game.GUI.PremiumPack.PremiumPackChestWindow;
    import hbm.Game.GUI.CashShopNew.NewBuyCashWindow;
    import hbm.Game.GUI.Repair.RepairWindow;
    import hbm.Game.GUI.CashShopNew.Auction.Controller.AuctionController;
    import hbm.Game.GUI.IngameMail.Controller.MailController;
    import hbm.Game.GUI.Dialogs.ErrorDialog;
    import hbm.Game.GUI.NPCDialog.NPCDialog;
    import hbm.Game.GUI.NPCDialog.NPCLocationWindow;
    import hbm.Game.GUI.Dialogs.RespawnDialog;
    import hbm.Application.Social.SocialPanelController;
    import hbm.Engine.Utility.MemoryController;
    import hbm.Engine.Actors.ItemData;
    import flash.events.Event;
    import flash.external.ExternalInterface;
    import com.junkbyte.console.Cc;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import org.aswing.AsWingManager;
    import org.aswing.UIManager;
    import hbm.Game.GUI.DarknessLnF;
    import org.aswing.FocusManager;
    import flash.display.DisplayObjectContainer;
    import hbm.Game.GUI.CharacterStats.CharacterStatsButtonEvent;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import hbm.Engine.Renderer.RenderSystem;
    import hbm.Game.Character.CharacterStorage;
    import hbm.Game.Renderer.BattleLogManager;
    import hbm.Application.Social.SocialFriends;
    import flash.display.DisplayObject;
    import flash.display.StageDisplayState;
    import hbm.Engine.Network.Events.ClientEvent;
    import flash.net.navigateToURL;
    import flash.net.URLRequest;
    import hbm.Game.Statistic.StatisticManager;
    import hbm.Game.GUI.WorldDescription;
    import flash.system.Security;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Resource.SkillsResourceLibrary;
    import flash.events.MouseEvent;
    import flash.events.KeyboardEvent;
    import com.hbm.socialpanel.SocialPane;
    import com.hbm.socialmodule.utils.Utilities;
    import com.hbm.socialmodule.data.SocialNetworkState;
    import flash.events.ErrorEvent;
    import com.hbm.socialmodule.connection.ResponseEvent;
    import hbm.Engine.Network.TransmissionObject.TransmissionObject;
    import hbm.Engine.Network.Events.ClientError;
    import hbm.Engine.Network.Events.ChatMessage;
    import hbm.Engine.Network.Events.NpcTalkEvent;
    import hbm.Engine.Network.Events.StoreEvent;
    import hbm.Engine.Network.Events.DisplayNpcImage;
    import hbm.Engine.Network.Events.Cutin2Event;
    import hbm.Engine.Network.Events.Cutin3Event;
    import hbm.Engine.Network.Events.NpcStoreDealEvent;
    import hbm.Engine.Network.Events.CharacterEvent;
    import hbm.Engine.Network.Events.ArrowsListEvent;
    import hbm.Engine.Network.Events.ProduceListEvent;
    import hbm.Engine.Network.Events.ActorStatsEvent;
    import hbm.Engine.Network.Events.StorageEvent;
    import hbm.Engine.Network.Events.CartEvent;
    import hbm.Engine.Network.Events.GuildEvent;
    import hbm.Engine.Network.Events.PartyEvent;
    import hbm.Engine.Network.Events.DuelEvent;
    import hbm.Engine.Network.Events.TradeEvent;
    import hbm.Engine.Network.Events.FriendEvent;
    import hbm.Engine.Network.Events.IgnoreEvent;
    import hbm.Engine.Network.Events.ActorDisplayEvent;
    import hbm.Engine.Network.Events.ItemAddedEvent;
    import hbm.Engine.Network.Events.UpdateCashEvent;
    import hbm.Engine.Network.Events.UpdatePremiumEvent;
    import hbm.Engine.Network.Events.UpdateQuestsEvent;
    import hbm.Engine.Network.Events.GiftItemEvent;
    import hbm.Engine.Network.Events.UpdateRouletteCashEvent;
    import hbm.Engine.Network.Events.RefineResultEvent;
    import hbm.Engine.Network.Events.ProduceResultEvent;
    import hbm.Engine.Network.Events.UpgradeResultEvent;
    import hbm.Engine.Network.Events.CraftCardResultEvent;
    import hbm.Engine.Network.Events.CastlesInfoEvent;
    import hbm.Engine.Network.Events.LaddersInfoEvent;
    import hbm.Engine.Network.Events.MapOnlineInfoEvent;
    import hbm.Engine.Network.Events.SoundEffectEvent;
    import hbm.Engine.Network.Events.FloorItemEvent;
    import hbm.Engine.Network.Events.PremiumPackEvent;
    import hbm.Engine.Network.Events.ActorViewIdEvent;
    import hbm.Engine.Network.Events.DurabilityEvent;
    import hbm.Engine.Network.Events.InstanceEvent;
    import hbm.Engine.Actors.GuildInfo;
    import hbm.Game.GUI.Gifts.DailyGiftWindow;
    import hbm.Game.GUI.CashShopNew.PrimaryAlertPane;
    import hbm.Game.Music.Music;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.Renderer.CharacterAnimation;
    import hbm.Engine.Actors.HotKeys;
    import hbm.Game.GUI.CharacterCreation.CharacterCreateEvent;
    import flash.events.TimerEvent;
    import hbm.Game.GUI.CashShop.Stash.InventoryVioletSellItem;
    import br.com.stimuli.loading.BulkProgressEvent;
    import flash.utils.clearTimeout;
    import hbm.Engine.Renderer.ExtensionRender;
    import hbm.Game.Utility.HtmlText;
    import flash.text.TextFieldAutoSize;
    import hbm.Game.Logic.GameLogic;
    import flash.utils.setTimeout;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import org.aswing.JPopupMenu;
    import hbm.Game.GUI.Dialogs.MessageToGameMasters;
    import org.aswing.event.AWEvent;
    import hbm.Game.GUI.Inventory.InventoryItem;
    import hbm.Game.Renderer.StatusManager;
    import hbm.Engine.Network.Events.ActorActiveStatusEvent;
    import hbm.Game.GUI.Update.UpdateWindow;
    import hbm.Game.Character.Character;
    import hbm.Game.GUI.Tutorial.WelcomeWindow;
    import hbm.Game.GUI.Tutorial.TutorialPanel;
    import hbm.Game.GUI.Inventory.InventoryStoreItem;
    import hbm.Game.GUI.Inventory.InventoryItemPopup;
    import hbm.Game.GUI.NewChat.LeftChatBar;
    import hbm.Game.GUI.Craft.ArrowsListDialog;
    import hbm.Game.Utility.CharacterMenu;
    import flash.utils.getTimer;
    import flash.ui.Keyboard;
    import hbm.Engine.Actors.Actors;
    import hbm.Game.GUI.NewChat.InteractiveText;
    import hbm.Game.GUI.NewChat.NewChatChannel;
    import hbm.Game.GUI.CharacterCreation.CharacterListEvent;
    import hbm.Engine.Network.Client.ClientState;
    import hbm.Engine.Actors.StorageData;
    import flash.geom.Rectangle;
	
	[Frame(factoryClass = "hbm.Application.PreloadFactory")]

    public class ClientApplication extends Sprite 
    {

        public static var platform:int = ClientConfig.WEB;//1
        public static var languageId:int = 0;
        public static var flashVars:Object = {};
        public static var Localization:Object;
        public static var Popups:Object;
        public static var serverAddress:String = "";
        public static var serverPort:int = 9600;
        public static var hostAddress:String = "";
        public static var gameServerName:String = "darkness01";
        public static var gameServerId:int = 0;
        public static var lastLogin:String = "";
        public static var lastPassword:String = "";
        public static var inviteUserId:String = "";
        public static const TIME_TO_SEND_WELCOME_CHAT_MESSAGE:int = ((1000 * 60) * 20);//1200000
        public static const OPEN_WINDOW_UPDATE_TIME:int = 1000;
        public static const TIME_TO_UPDATE_GUI:int = 250;
        private static var _singleton:ClientApplication;
        public static var openTutorialAfterLevelup:int = -1;
        public static var openLevelupAfterTutorial:int = -1;
        public static var stageWidth:int;
        public static var stageHeight:int;
        public static var fromPortal:int = 0;
        public static var serverList:Boolean = false;
        public static var friendRef:String = null;
        public static var socialPanelVisible:Boolean = false;
        public static var gift2Counter:int = 0;
        public static var alldurability:int = 0;
        private static var _one_show_dlg:Boolean = false;

        private const _gameStageHeight:int = 0x0300;
        private const SILVER_TAB_ID:String = "54";

        private var _config:ClientConfig;
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _dataLoader:BulkLoader;
        private var _backBufferBitmap:Bitmap;
        private var _fakeLoadingTimer:Timer = null;
        private var _finalProgressTimer:Timer = null;
        public var timeOnServer:uint = 0;
        public var timeOnServerInited:Boolean = false;
        public var users:uint = 0;
        private var _gameStageWidth:int;
        private var _lastFrameTickTime:uint;
        private var _openFrameTickTime:uint;
        private var _lastFrameTime:Number = 0.01;
        private var _timeToSendUpdate:uint;
        private var _serverTimeString:String = "";
        private var _timeToSendWelcomeChatMessage:uint = 0;
        private var _timeToUpdateGui:uint = 0;
        private var _timeToClick:uint = 0;
        private var _limitClick:Boolean = true;
        private var _fogObject:FogObject;
        private var _background:Background;
        private var _movePointerObject:MovePointerObject;
        private var _isFirstUpdate:Boolean = true;
        private var _criticalError:Boolean = false;
        private var _fpsTextField:TextField = new TextField();
        private var _fpsCalculator:FpsCalculator = new FpsCalculator();
        private var _loadingWindow:LoadingScreen;
        private var _loadingBackground:Sprite;
        private var _loadingAdditionalData:LoadingAdditionalData;
        private var _connectingToServer:ConnectingToServer;
        private var _loginPrompt:LoginPromptWindow;
        private var _loginScreenBG:MovingPerspective;
        private var _chooseWorldDialog:ChooseWorldDialog;
        private var _newName:String = "";
        private var _charactersListWindow:CharacterListWindow;
        private var _characterCreate:NewCharacterCreateWindow;
        private var _characterRenameDialog:CharacterRenameDialog;
        private var _loadAnaloguesOfId:String = "";
        private var _gameClient:Client;
        private var _isShiftPressed:Boolean;
        private var _isCtrlPressed:Boolean;
        private var _topHUD:TopBar;
        private var _bottomHUD:BottomBar;
        private var _chatHUD:ChatBar;
        private var _partyController:PartyController;
        private var _skills:SkillWindow;
        private var _skillsAdvanced:AdvancedSkillWindow;
        private var _emotionWindow:EmotionWindow;
        private var _emblemWindow:EmblemWindow;
        private var _buffWindow:BuffWindow;
        private var _buffWindowNeedShow:Boolean = false;
        private var _bookWindow:BookWindow;
        private var _characterInventory:CharacterInventoryWindow;
        private var _guildWindow:GuildWindow;
        private var _friendsWindow:FriendsWindow;
        private var _guildSkillsWindow:GuildSkillWindow;
        private var _settingsWindow:SettingsWindow;
        private var _produceDialog:ProduceListDialog;
        private var _storeWindow:StoreWindow;
        private var _storageWindow:StorageWindow;
        private var _cartWindow:CartWindow;
        private var _shopWindow:ShopWindow;
        private var _stashAuctionWindow:StashAuctionWindow;
        private var _premiumShopWindow:PremiumShopWindow;
        private var _kafraShopWindow:KafraShopWindow;
        private var _questsWindow:QuestsWindow;
        private var _witchWindow:WitchWindow;
        private var _levelupWindow:LevelUpWindow;
        private var _partnerWindow:PartnerWindow;
        private var _refineWindow:RefineWindow;
        private var _upgradeWindow:UpgradeWindow;
        private var _changelogWindow:ChangelogWindow;
        private var _castlesWindow:CastlesWindow;
        private var _laddersWindow:LaddersWindow;
        private var _worldmapWindow:WorldMapWindow;
        private var _minimapWindow:MiniMapWindow;
        private var _levelWindow:LevelWindow;
        private var _tradeWindow:TradeWindow;
        private var _premiumPackWindow:PremiumPackWindow;
        private var _premiumPackChestWindow:PremiumPackChestWindow;
        private var _buyCahsWindow:NewBuyCashWindow;
        private var _repairWindow:RepairWindow;
        private var _auction:AuctionController;
        private var _mail:MailController;
        private var _isBulkAllLoaded:Boolean = false;
        private var _isBackgroundLoaded:Boolean = false;
        private var _errorDialog:ErrorDialog;
        private var _npcTalkDialog:NPCDialog;
        private var _npcLocationWindow:NPCLocationWindow;
        private var _respawnDialog:RespawnDialog;
        private var _isDieOnGvG:Boolean = false;
        public var isDieOnLadder:Boolean = false;
        private var _respawnTimer:Timer;
        private var _currentQuestsCount:int;
        private var _characterSlotId:int = 0;
        private var _shortcutsEnabled:Boolean = true;
        private var _currentMapId:String;
        private var _lastMapId:String;
        private var _mapMusicIdle:String;
        private var _mapMusicBattle:String;
        private var _socialWindow:SocialPanelController;
        private var _socialWindowAdded:Boolean = false;
        public var _currentCraftItemId:int;
        public var _tradingMode:Boolean = false;
        public var _currentSlotId:int;
        private var _memoryController:MemoryController;
        private var _currentBannerItem:ItemData;
        private var _lastRenderWidth:int = 0;
        private var _lastRenderHeight:int = 0;

        public function ClientApplication()
        {
            addEventListener(Event.ADDED_TO_STAGE, this.Init, false, 0, true);
        }

        public static function get Instance():ClientApplication
        {
            return (_singleton);
        }

        public static function addExternalEventListener(_arg_1:String, _arg_2:Function, _arg_3:String):void
        {
            var _local_4:String;
            var _local_5:String;
            try
            {
                ExternalInterface.addCallback(_arg_3, _arg_2);
                _local_4 = (((("document.getElementsByName('" + ExternalInterface.objectID) + "')[0].") + _arg_3) + "()");
                _local_5 = (((((("function(){" + _arg_1) + "= function(){if (") + _local_4) + ") return ") + _local_4) + "};}");
                ExternalInterface.call(_local_5);
            }
            catch(catchObject:Error)
            {
            };
        }


        private function Init(_arg_1:Event):void
        {
            var _local_2:int;
            _singleton = this;
            Cc.startOnStage(stage, "showmethemoney");
            Cc.listenUncaughtErrors(this.loaderInfo);
            this._memoryController = new MemoryController((60 * 1000), ((0x0400 * 0x0400) * 16), ((0x0400 * 0x0400) * 0x0200), ((0x0400 * 0x0400) * 0x0400), ((5 * 60) * 1000), 2, null, null);
            stage.frameRate = 60;
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            this._isShiftPressed = false;
            this._isCtrlPressed = false;
            AsWingManager.setRoot(this);
            UIManager.setLookAndFeel(new DarknessLnF());
            FocusManager.getManager(stage).setTraversalEnabled(false);
            fromPortal = (((!(flashVars == null)) && (!(flashVars["from_portal"] == null))) ? int(flashVars["from_portal"]) : 0);
            serverList = ((!(flashVars == null)) && (!(flashVars["server_list"] == null)));
            if (((!(flashVars == null)) && (!(flashVars["type"] == null))))
            {
                _local_2 = flashVars["type"];
                if (platform == ClientConfig.WEB)
                {
                    if (_local_2 != ClientConfig.DEBUG)
                    {
                        platform = _local_2;
                    };
                }
                else
                {
                    if (platform == ClientConfig.DEBUG)
                    {
                        if (((((((_local_2 == ClientConfig.VKONTAKTE_TEST) || (_local_2 == ClientConfig.ODNOKLASSNIKI_TEST)) || (_local_2 == ClientConfig.MAILRU_TEST)) || (_local_2 == ClientConfig.FOTOSTRANA_TEST)) || (_local_2 == ClientConfig.WEB_TEST)) || (_local_2 == ClientConfig.FACEBOOK_TEST)))
                        {
                            platform = _local_2;
                        };
                    };
                };
            };
            if (((fromPortal) && (!(flashVars["from"] == null))))
            {
                friendRef = flashVars["from"];
            };
            this.InitConfig();
            stageWidth = stage.stageWidth;
            stageHeight = stage.stageHeight;
            this._loadingBackground = new BackgroundWindow();
            this.InitLoadingBackground();
            addChild(this._loadingBackground);
            this._loginScreenBG = new MovingPerspective(this);
            this._loginScreenBG.Show();
            this._loginPrompt = new LoginPromptWindow();
            this._loginPrompt.addEventListener(LoginPromptWindow.ON_LOGIN_PRESSED, this.OnLoginPressed, false, 0, true);
            var _local_3:DisplayObjectContainer = AsWingManager.getRoot();
            this._chooseWorldDialog = new ChooseWorldDialog();
            this.ParseConfigFile();
            this._topHUD = new TopBar();
            this._bottomHUD = new BottomBar();
            this._chatHUD = new ChatBar();
            this._skills = new SkillWindow();
            this._skillsAdvanced = new AdvancedSkillWindow();
            this._emotionWindow = new EmotionWindow();
            this._buffWindow = new BuffWindow();
            this._characterInventory = new CharacterInventoryWindow(_local_3);
            this._characterInventory.GetStatsPanel().addEventListener(CharacterStatsButtonEvent.ON_STAT_INCREASED, this.OnStatIncreased, false, 0, true);
            this._guildSkillsWindow = new GuildSkillWindow();
            this._friendsWindow = new FriendsWindow();
            this._settingsWindow = new SettingsWindow();
            this._gameClient = new Client();
            this._mail = new MailController();
            this.SubscribeNetworkEvents();
            switch (this._config.CurrentPlatformId)
            {
                case ClientConfig.VKONTAKTE:
                case ClientConfig.MAILRU:
                case ClientConfig.ODNOKLASSNIKI:
                case ClientConfig.WEB:
                case ClientConfig.FOTOSTRANA:
                case ClientConfig.FACEBOOK:
                case ClientConfig.WEB_TEST:
                case ClientConfig.VKONTAKTE_TEST:
                case ClientConfig.ODNOKLASSNIKI_TEST:
                case ClientConfig.MAILRU_TEST:
                case ClientConfig.FOTOSTRANA_TEST:
                case ClientConfig.FACEBOOK_TEST:
                    this._socialWindow = new SocialPanelController(loaderInfo);
                    if (this._socialWindow.SocialPanel != null)
                    {
                        if (((!(this._config.CurrentPlatformId == ClientConfig.WEB)) && (!(this._config.CurrentPlatformId == ClientConfig.WEB_TEST))))
                        {
                            if (this._socialWindow.SocialPanel.Data.NetworkApi.GetExternalVars().isAppInstalled)
                            {
                                if (!this._socialWindow.SocialPanel.Data.NetworkApi.GetAccessSettings().FriendListAccess())
                                {
                                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.SOCIAL_FRIEND_LIST_ACCESS_TITLE, ClientApplication.Localization.SOCIAL_FRIEND_LIST_ACCESS_MESSAGE, null, null, true, new AttachIcon("AchtungIcon")));
                                };
                            }
                            else
                            {
                                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.SOCIAL_APP_INSTALL_TITLE, ClientApplication.Localization.SOCIAL_APP_INSTALL_MESSAGE, null, null, true, new AttachIcon("StopIcon")));
                            };
                            this._socialWindow.SocialPanel.Data.Login.SendRequest();
                        };
                    };
            };
            GoogleAnalyticsClient.Instance.trackPageview("/initialization");
            addEventListener(Event.ENTER_FRAME, this.OnFrameUpdate);
            RenderSystem.Instance.AddRenderObject(CharacterStorage.Instance);
            RenderSystem.Instance.AddRenderObject(BattleLogManager.Instance);
            addExternalEventListener(" window.onbeforeunload", this.RequestUnloadConfirmation, "unloadConfirmation");
            stage.addEventListener(Event.RESIZE, this.StageResize, false, 0, true);
            this.StageResize(null);
        }

        public function GetSocialFriends():SocialFriends
        {
            if (!this._socialWindow)
            {
                return (null);
            };
            return (this._socialWindow.GetSocialFriends());
        }

        public function ShowLevelWindow():void
        {
            if (this._levelWindow == null)
            {
                this._levelWindow = new LevelWindow();
            };
            if (this._levelWindow.isShowing())
            {
                this._levelWindow.dispose();
            }
            else
            {
                this._levelWindow.RevalidateInfo();
                this._levelWindow.show();
            };
        }

        public function ShowTestWindow():void
        {
        }

        public function RevalidateLevelWindow():void
        {
            if (this._levelWindow != null)
            {
                this._levelWindow.RevalidateInfo();
            };
            this._chatHUD.GetRightBar.RevalidateUsers(this._gameClient.ActorList);
        }

        private function StageResize(_arg_1:Event):void
        {
            var _local_6:DisplayObject;
            if (((stage.stageWidth < 1) || (stage.stageHeight < 1)))
            {
                return;
            };
            stageWidth = stage.stageWidth;
            stageHeight = stage.stageHeight;
            var _local_2:int = stageWidth;
            var _local_3:int = stageHeight;
            if ((((stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE) || (stage.displayState == StageDisplayState.FULL_SCREEN)) || (fromPortal)))
            {
                _local_3 = stageHeight;
            }
            else
            {
                switch (this._config.CurrentPlatformId)
                {
                    case ClientConfig.DEBUG:
                    case ClientConfig.TEST:
                    case ClientConfig.WEB:
                    case ClientConfig.WEB_TEST:
                    case ClientConfig.VKONTAKTE:
                    case ClientConfig.VKONTAKTE_TEST:
                    case ClientConfig.MAILRU:
                    case ClientConfig.MAILRU_TEST:
                    case ClientConfig.FACEBOOK:
                    case ClientConfig.FACEBOOK_TEST:
                    case ClientConfig.ODNOKLASSNIKI:
                    case ClientConfig.ODNOKLASSNIKI_TEST:
                    case ClientConfig.FOTOSTRANA:
                    case ClientConfig.FOTOSTRANA_TEST:
                        _local_3 = stageHeight;
                        break;
                };
            };
            if (this._socialWindowAdded)
            {
                socialPanelVisible = (!(stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE));
                this._socialWindow.SocialPanel.visible = socialPanelVisible;
            };
            if (_local_3 < 600)
            {
                _local_3 = 600;
            };
            if (_local_2 < 800)
            {
                _local_2 = 800;
            };
            if (((!(this._lastRenderWidth == _local_2)) || (!(this._lastRenderHeight == _local_3))))
            {
                RenderSystem.Instance.UpdateScreenSize(stageWidth, stageHeight, _local_2, _local_3);
                if (this._backBufferBitmap != null)
                {
                    this._backBufferBitmap.bitmapData = RenderSystem.Instance.BackBuffer;
                };
            };
            this._lastRenderWidth = _local_2;
            this._lastRenderHeight = _local_3;
            var _local_4:int = int((_local_2 / 2));
            var _local_5:int = int((_local_3 / 2));
            this._topHUD.x = _local_4;
            this._topHUD.RevalidatePositions();
            if (((this._loginScreenBG) && (this.contains(this._loginScreenBG))))
            {
                this._loginScreenBG.UpdatePosition();
            };
            if (((this._loginPrompt) && (this._loginPrompt.IsShowing())))
            {
                this._loginPrompt.Center();
            };
            if (((this._loadingBackground) && (this.contains(this._loadingBackground))))
            {
                this.InitLoadingBackground();
            };
            if (((this._loadingAdditionalData) && (this._loadingAdditionalData.isShowing())))
            {
                this._loadingAdditionalData.Center();
            };
            if (((this._connectingToServer) && (this._connectingToServer.isShowing())))
            {
                this._connectingToServer.Center();
            };
            if (((this._chooseWorldDialog) && (this._chooseWorldDialog.isShowing())))
            {
                this._chooseWorldDialog.Center();
            };
            if (((this._charactersListWindow) && (this.contains(this._charactersListWindow))))
            {
                this._charactersListWindow.x = (_local_4 - 403);
                this._charactersListWindow.y = ((socialPanelVisible) ? 0 : (_local_5 - 384));
            };
            if (((this._characterCreate) && (this.contains(this._characterCreate))))
            {
                this._characterCreate.x = (_local_4 - 403);
                this._characterCreate.y = ((socialPanelVisible) ? 0 : (_local_5 - 384));
            };
            this._bottomHUD.x = _local_4;
            this._bottomHUD.y = _local_3;
            this._bottomHUD.RevalidatePositions();
            this._chatHUD.x = 0;
            this._chatHUD.y = 0;
            this._chatHUD.RevalidatePositions();
            if (this._emotionWindow.isShowing())
            {
                this.CloseEmotionWindow();
                this.ShowEmotionWindow();
            };
            this._fpsTextField.x = 2;
            if (this._partyController)
            {
                _local_6 = this.PartyList.GetUIComponent();
                _local_6.x = (RenderSystem.Instance.ScreenWidth - 150);
                _local_6.y = (this._chatHUD.GetRightHUD._partyInfoPanel.y + 30);
            };
        }

        private function RequestUnloadConfirmation():Boolean
        {
            if (this._gameClient != null)
            {
                this.StoreGameSessionInfo();
                this._gameClient.SendQuit();
            };
            return (false);
        }

        public function get IsShiftPressed():Boolean
        {
            return (this._isShiftPressed);
        }

        public function get IsCtrlPressed():Boolean
        {
            return (this._isCtrlPressed);
        }

        public function ReloadPage(_arg_1:Boolean):void
        {
            var _local_2:ClientEvent;
            GoogleAnalyticsClient.Instance.trackPageview("/reload");
            if (_arg_1)
            {
                if (this._config.GetAppURL)
                {
                    navigateToURL(new URLRequest(this._config.GetAppURL));
                }
                else
                {
                    if (ExternalInterface.available)
                    {
                        ExternalInterface.call("history.go", 0);
                    };
                };
            }
            else
            {
                _local_2 = new ClientEvent(ClientEvent.ON_PLAYER_DETACHED);
                _local_2.flag = 1;
                this.OnPlayerDetached(_local_2);
            };
        }

        public function CriticalError(_arg_1:String=null):void
        {
            var _local_2:String;
            if (!this._criticalError)
            {
                _local_2 = "/critical_error";
                if (((!(_arg_1 == null)) && (!(_arg_1 == ""))))
                {
                    _local_2 = (_local_2 + ("/" + _arg_1));
                };
                GoogleAnalyticsClient.Instance.trackPageview(_local_2);
                this._criticalError = true;
                if (((this._errorDialog == null) || (!(this._errorDialog.isShowing()))))
                {
                    this.ShowError(Localization.ERR_CRITICAL_ERROR_MESSAGE);
                };
            };
        }
		
		public function CriticalError2(_arg_1:String=null):void
        {
            var _local_2:String;
            if (!this._criticalError)
            {
                _local_2 = "/critical_error";
                if (((!(_arg_1 == null)) && (!(_arg_1 == ""))))
                {
                    _local_2 = (_local_2 + ("/" + _arg_1));
                };
                GoogleAnalyticsClient.Instance.trackPageview(_local_2);
                this._criticalError = true;
                if (((this._errorDialog == null) || (!(this._errorDialog.isShowing()))))
                {
                    this.ShowError(Localization.ERR_CRITICAL_ERROR_MESSAGE + 2);
                };
            };
        }

        public function get Config():ClientConfig
        {
            return (this._config);
        }

        public function get GameStageWidth():int
        {
            return (this._gameStageWidth);
        }

        public function get GameStageHeight():int
        {
            return (this._gameStageHeight);
        }

        private function InitConfig():void
        {
            var _local_1:Object;
            var _local_2:ClientConfig;
            if (this._config == null)
            {
                this._config = new ClientConfig(platform);
                _local_1 = this._config.GetPlatformStatistic;
                if (_local_1)
                {
                    StatisticManager.Instance.InitAPI(_local_1.app_id, _local_1.token);
                };
            };
            if (fromPortal)
            {
                _local_2 = new ClientConfig(ClientConfig.WEB);
                this._gameStageWidth = _local_2.GetPlatformResolution["width"];
            }
            else
            {
                this._gameStageWidth = this._config.GetPlatformResolution["width"];
            };
        }

        private function ParseConfigFile():void
        {
            var _local_1:Object;
            this.InitConfig();
            for each (_local_1 in this._config.LoginServers)
            {
                this._chooseWorldDialog.AddWorld(_local_1["address"], _local_1["port"], _local_1["name"], _local_1["description"], _local_1["game"], _local_1["gameId"]);
            };
            this._chooseWorldDialog.addEventListener(ChooseWorldDialog.WORLD_CHOOSED, this.OnWorldSelected, false, 0, true);
            this._chooseWorldDialog.show();
        }

        private function OnWorldSelected(_arg_1:Event):void
        {
            var _local_2:WorldDescription = this._chooseWorldDialog.GetSelectedWorld();
            serverAddress = _local_2.Address;
            serverPort = _local_2.Port;
            Security.loadPolicyFile((("xmlsocket://" + serverAddress) + ":843"));
            hostAddress = (("http://" + serverAddress) + "/Darkness");
            gameServerName = _local_2.Game;
            gameServerId = _local_2.GameId;
            this._config.SelectLoginServer(gameServerName);
            ResourceManager.Instance.RegisterLibrary(new LocalizationResourceLibrary(), "Localization");
            ResourceManager.Instance.RegisterLibrary(new ItemsResourceLibrary(), "Items");
            ResourceManager.Instance.RegisterLibrary(new SkillsResourceLibrary(), "Skills");
            ResourceManager.Instance.RegisterLibrary(new AdditionalDataResourceLibrary(), "AdditionalData");
            ResourceManager.Instance.Library("Localization").LoadResourceLibrary();
            ResourceManager.Instance.Library("Items").LoadResourceLibrary();
            ResourceManager.Instance.Library("Skills").LoadResourceLibrary();
            ResourceManager.Instance.Library("AdditionalData").LoadResourceLibrary();
            this._loadingAdditionalData = new LoadingAdditionalData();
            this._loadingAdditionalData.addEventListener(LoadingAdditionalData.ON_RESOURCES_LOADED, this.OnAdditionalDataLoaded, false, 0, true);
            this._loadingAdditionalData.show();
        }

        private function OnAdditionalDataLoaded(_arg_1:Event):void
        {
            var _local_2:String;
            var _local_3:String;
            var _local_4:String;
            var _local_5:String;
            var _local_6:String;
            AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).LoadLocalizedData();
            ItemsResourceLibrary(ResourceManager.Instance.Library("Items")).LoadLocalizedData();
            SkillsResourceLibrary(ResourceManager.Instance.Library("Skills")).LoadLocalizedData();
            this._loadingAdditionalData.removeEventListener(LoadingAdditionalData.ON_RESOURCES_LOADED, this.OnAdditionalDataLoaded);
            this._loadingAdditionalData = null;
            switch (this._config.CurrentPlatformId)
            {
                case ClientConfig.VKONTAKTE:
                case ClientConfig.MAILRU:
                case ClientConfig.ODNOKLASSNIKI:
                case ClientConfig.FOTOSTRANA:
                case ClientConfig.FACEBOOK:
                case ClientConfig.WEB:
                case ClientConfig.WEB_TEST:
                case ClientConfig.VKONTAKTE_TEST:
                case ClientConfig.ODNOKLASSNIKI_TEST:
                case ClientConfig.FOTOSTRANA_TEST:
                case ClientConfig.MAILRU_TEST:
                case ClientConfig.FACEBOOK_TEST:
                    if (this._socialWindow != null)
                    {
                        try
                        {
                            _local_4 = this._socialWindow.SocialPanel.Data.NetworkApi.GetExternalVars().viewerId;
                            switch (this._config.CurrentPlatformId)
                            {
                                case ClientConfig.VKONTAKTE:
                                case ClientConfig.VKONTAKTE_TEST:
                                    _local_5 = "vk";
                                    break;
                                case ClientConfig.MAILRU:
                                case ClientConfig.MAILRU_TEST:
                                    _local_5 = "mm";
                                    break;
                                case ClientConfig.ODNOKLASSNIKI:
                                case ClientConfig.ODNOKLASSNIKI_TEST:
                                    _local_5 = "ok";
                                    lastLogin = (_local_5 + _local_4);
                                    _local_6 = (((!(flashVars == null)) && (!(flashVars["auth_sig_const"] == null))) ? flashVars["auth_sig_const"] : null);
                                    if (_local_6)
                                    {
                                        this.OKAuthkeyLogin(_local_6);
                                    }
                                    else
                                    {
                                        this._socialWindow.SocialPanel.Data.GetAuthkey.SendRequest(this._socialWindow.SocialPanel.Data.GamePassword);
                                    };
                                    return;
                                case ClientConfig.FACEBOOK:
                                case ClientConfig.FACEBOOK_TEST:
                                    _local_5 = "fb";
                                    break;
                                case ClientConfig.FOTOSTRANA:
                                case ClientConfig.FOTOSTRANA_TEST:
                                    _local_5 = "fs";
                                    break;
                                case ClientConfig.WEB:
                                case ClientConfig.WEB_TEST:
                                default:
                                    _local_5 = "wb";
                            };
                            _local_2 = (_local_5 + _local_4);
                            _local_3 = this._socialWindow.SocialPanel.Data.GamePassword;
                        }
                        catch(e:*)
                        {
                        };
                        if ((((this._config.CurrentPlatformId == ClientConfig.WEB) || (this._config.CurrentPlatformId == ClientConfig.WEB_TEST)) && ((_local_2 == null) || (_local_3 == null))))
                        {
                            this.CriticalError2(("socialpane/" + "/namepasserror"));
                        }
                        else
                        {
                            _local_3 = _local_3.substr(0, 16);
                            this._connectingToServer = new ConnectingToServer();
                            this._connectingToServer.show();
                            this.LocalGameClient.ConnectLoginServer(_local_2, _local_3, serverAddress, int(serverPort));
                            lastLogin = _local_2;
                            lastPassword = _local_3;
                        };
                    };
                    return;
                case ClientConfig.STANDALONE:
                case ClientConfig.DEBUG:
                case ClientConfig.TEST:
                default:
                    this._loginPrompt.Show();
            };
        }

        public function OKAuthkeyLogin(_arg_1:String):void
        {
            _arg_1 = _arg_1.substr(0, 16);
            this._connectingToServer = new ConnectingToServer();
            this._connectingToServer.show();
            this.LocalGameClient.ConnectLoginServer(lastLogin, _arg_1, serverAddress, int(serverPort));
            lastPassword = _arg_1;
        }

        public function ShowError(_arg_1:String, _arg_2:Boolean=true):void
        {
            this._errorDialog = new ErrorDialog(_arg_1, 430, 90, _arg_2);
            this._errorDialog.Show();
        }

        public function get LocalGameClient():Client
        {
            return (this._gameClient);
        }

        private function RegisterInput():void
        {
            stage.addEventListener(MouseEvent.CLICK, this.OnMouseClick, false, 0, true);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.OnMouseMove, false, 0, true);
            stage.addEventListener(KeyboardEvent.KEY_UP, this.OnKeyUpEvent, false, 0, true);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.OnKeyDownEvent, false, 0, true);
        }

        private function UnregisterInput():void
        {
            stage.removeEventListener(MouseEvent.CLICK, this.OnMouseClick);
            stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.OnMouseMove);
            stage.removeEventListener(KeyboardEvent.KEY_UP, this.OnKeyUpEvent);
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, this.OnKeyDownEvent);
        }

        private function OnLoginPressed(evt:Event):void
        {
            var hash:String;
            var socialPane:SocialPane;
            if (this._config.CurrentPlatformId == ClientConfig.STANDALONE)
            {
                hash = Utilities.B64Sha512(this._loginPrompt.password);
                socialPane = new SocialPane({
                    "login":this._loginPrompt.email,
                    "auth_key":hash
                }, SocialNetworkState.WEB_API, this._config.GetSocialServerURL, this._config.GetAppPrivateKey, this._gameStageWidth, true);
                socialPane.Data.addEventListener(ErrorEvent.ERROR, function (_arg_1:Event):void
                {
                    CriticalError(("socialpane/" + _arg_1.type));
                });
                socialPane.Data.Login.addEventListener(Event.COMPLETE, function (_arg_1:ResponseEvent):void
                {
                    socialPane.Data.UserServerInfo.SendRequest();
                });
                socialPane.Data.UserServerInfo.addEventListener(Event.COMPLETE, function (_arg_1:ResponseEvent):void
                {
                    var _local_2:String = _arg_1.data["displayName"];
                    var _local_3:String = ("wb" + _arg_1.data["tahoeId"]);
                    var _local_4:String = _arg_1.data["tahoeph"];
                    _local_4 = _local_4.substr(0, 16);
                    _loginPrompt.Dispose();
                    LocalGameClient.ConnectLoginServer(_local_3, _local_4, serverAddress, int(serverPort));
                    lastLogin = _local_3;
                    lastPassword = _local_4;
                });
                socialPane.Data.Login.SendRequest();
            }
            else
            {
                this.LocalGameClient.ConnectLoginServer(this._loginPrompt.email, this._loginPrompt.password, serverAddress, int(serverPort));
                lastLogin = this._loginPrompt.email;
                lastPassword = this._loginPrompt.password;
            };
        }

        private function SubscribeNetworkEvents():void
        {
            TransmissionObject.Instance.addEventListener(TransmissionObject.ON_EXCEPTION, this.OnException, false, 0, true);
            TransmissionObject.Instance.addEventListener(TransmissionObject.ON_CONNECT_ERROR, this.OnConnectError, false, 0, true);
            this._gameClient.addEventListener(ClientError.ON_CLIENT_ERROR, this.OnClientError, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_ACCOUNT_DOESNT_EXIST, this.OnAccountDoesntExist, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_PASSWORD_ERROR, this.OnPasswordError, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_CHARSERVER_INVITATION, this.OnCharServerInvitation, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_CHARACTERS_RECEIVED, this.OnCharacterReceived, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_CHARACTER_CREATION_SUCCESSFUL, this.OnCharacterCreationSuccessful, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_CHARACTERS_DOSENT_EXIST, this.OnCharacterDoesntExist, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_CHARACTER_NAME_DUPLICATE, this.OnCharacterNameDuplicate, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_CHARACTER_NAME_DENIED, this.OnCharacterNameDenied, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_CHARACTER_CHECK_NAME_SUCCESSFUL, this.OnCharacterCheckNameSuccessful, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_CHARACTER_CHECK_NAME_FAILED, this.OnCharacterCheckNameFailed, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_CHARACTER_RENAME_REQUEST_ACCEPTED, this.OnCharacterRenameAccepted, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_CHARACTER_RENAME_REQUEST_REJECTED, this.OnCharacterRenameFailed, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_CHARACTER_RENAME_SUCCESSFUL, this.OnCharacterRenameSuccessful, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_CHARACTER_RENAME_ALREADY_CHANGED, this.OnCharacterRenameAlreadyChanged, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_CHARACTER_RENAME_FAILED, this.OnCharacterRenameFailed, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_PLAYER_DETACHED, this.OnPlayerDetached, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_MAPSERVER_INVITATION, this.OnMapServerInvitation, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_ENTERED_MAP, this.OnEnteredMap, false, 0, true);
            this._gameClient.addEventListener(ClientEvent.ON_PLAYER_RESPAWNED, this.OnPlayerRespawned, false, 0, true);
            this._gameClient.addEventListener(ChatMessage.ON_BROADCAST_MESSAGE, this.OnReceivedBroadcastMessage, false, 0, true);
            this._gameClient.addEventListener(ChatMessage.ON_PUBLIC_MESSAGE, this.OnReceivedPublicMessage, false, 0, true);
            this._gameClient.addEventListener(ChatMessage.ON_PARTY_MESSAGE, this.OnReceivedPartyMessage, false, 0, true);
            this._gameClient.addEventListener(ChatMessage.ON_GUILD_MESSAGE, this.OnReceivedGuildMessage, false, 0, true);
            this._gameClient.addEventListener(ChatMessage.ON_PRIVATE_MESSAGE, this.OnReceivedPrivateMessage, false, 0, true);
            this._gameClient.addEventListener(ChatMessage.ON_EMOTION, this.OnReceivedEmotion, false, 0, true);
            this._gameClient.addEventListener(ChatMessage.ON_PET_EMOTION, this.OnReceivedPetEmotion, false, 0, true);
            this._gameClient.addEventListener(NpcTalkEvent.ON_NPC_TALK, this.OnNpcTalk, false, 0, true);
            this._gameClient.addEventListener(NpcTalkEvent.ON_NPC_TALK_CONTINUE, this.OnNpcTalkContinue, false, 0, true);
            this._gameClient.addEventListener(NpcTalkEvent.ON_NPC_RESPONSES, this.OnNpcTalkResponses, false, 0, true);
            this._gameClient.addEventListener(NpcTalkEvent.ON_NPC_INPUT_STRING, this.OnNpcInput, false, 0, true);
            this._gameClient.addEventListener(NpcTalkEvent.ON_NPC_INPUT_NUMBER, this.OnNpcInput, false, 0, true);
            this._gameClient.addEventListener(NpcTalkEvent.ON_NPC_TALK_CLOSE, this.OnNpcTalkClose, false, 0, true);
            this._gameClient.addEventListener(StoreEvent.ON_NPC_STORE_BEGIN, this.OnNpcStoreBegin, false, 0, true);
            this._gameClient.addEventListener(StoreEvent.ON_NPC_BUY_LIST, this.OnNpcBuyList, false, 0, true);
            this._gameClient.addEventListener(DisplayNpcImage.ON_HIDE_NPC_IMAGE, this.OnNpcHide, false, 0, true);
            this._gameClient.addEventListener(DisplayNpcImage.ON_HIDE_AND_CLEAN_NPC_IMAGE, this.OnNpcHideAndClean, false, 0, true);
            this._gameClient.addEventListener(Cutin2Event.ON_CUTIN2_COMMAND, this.OnCutin2, false, 0, true);
            this._gameClient.addEventListener(Cutin3Event.ON_CUTIN3_COMMAND, this.OnCutin3, false, 0, true);
            this._gameClient.addEventListener(NpcStoreDealEvent.ON_PLAYER_BUY, this.OnPlayerBuy, false, 0, true);
            this._gameClient.addEventListener(NpcStoreDealEvent.ON_PLAYER_SELL, this.OnPlayerSell, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_STATS_CHANGED, this.OnPlayerStatsChanged, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_MANNER_UPDATED, this.OnPlayerMannerChanged, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_STATS_NOT_ENOUGH, this.OnStatsIsNotEnough, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_ITEMS_CHANGED, this.OnPlayerItemsChanged, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_ITEM_EQUIPPED, this.OnPlayerItemEquipped, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_CANT_EQUIP_ITEM, this.OnPlayerCantEquipItem, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_CANT_USE_ITEM, this.OnPlayerCantUseItem, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_SKILLS_CHANGED, this.OnPlayerSkillsChanged, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_SKILL_POINTS_CHANGED, this.OnPlayerSkillPointsChanged, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_SKILL_CHANGED, this.OnPlayerSkillChanged, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_GUILD_SKILLS_CHANGED, this.OnGuildSkillsChanged, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_HOTKEYS_RECEIVED, this.OnPlayerHotkeysReceived, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_SKILL_USE_FAILED, this.OnPlayerSkillFailed, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_PET_UPDATED, this.OnPetUpdated, false, 0, true);
            this._gameClient.addEventListener(CharacterEvent.ON_PET_FOOD_RESULT, this.OnPetFoodResult, false, 0, true);
            this._gameClient.addEventListener(ArrowsListEvent.ON_ARROWS_LIST, this.OnArrowsList, false, 0, true);
            this._gameClient.addEventListener(ProduceListEvent.ON_PRODUCE_LIST, this.OnProduceList, false, 0, true);
            this._gameClient.addEventListener(ActorStatsEvent.ON_LEVEL_UP, this.OnLevelUpReceived, false, 0, true);
            this._gameClient.addEventListener(ActorStatsEvent.ON_JOB_LEVEL_UP, this.OnJobLevelUpReceived, false, 0, true);
            this._gameClient.addEventListener(ActorStatsEvent.ON_REFINE_FAILED, this.OnRefineResultReceived, false, 0, true);
            this._gameClient.addEventListener(ActorStatsEvent.ON_REFINE_SUCCESS, this.OnRefineResultReceived, false, 0, true);
            this._gameClient.addEventListener(StorageEvent.ON_STORAGE_OPENED, this.OnStorageOpened, false, 0, true);
            this._gameClient.addEventListener(StorageEvent.ON_STORAGE_UPDATED, this.OnStorageUpdated, false, 0, true);
            this._gameClient.addEventListener(StorageEvent.ON_STORAGE_CLOSED, this.OnStorageClosed, false, 0, true);
            this._gameClient.addEventListener(CartEvent.ON_CART_UPDATED, this.OnCartUpdated, false, 0, true);
            this._gameClient.addEventListener(CartEvent.ON_CART_STATUS_UPDATED, this.OnCartStatusUpdated, false, 0, true);
            this._gameClient.addEventListener(StoreEvent.ON_VENDER_BUY_LIST, this.OnVenderBuyList, false, 0, true);
            this._gameClient.addEventListener(StoreEvent.ON_VENDER_CLOSED, this.OnVenderClosed, false, 0, true);
            this._gameClient.addEventListener(StoreEvent.ON_VENDER_STARTED, this.OnVenderStarted, false, 0, true);
            this._gameClient.addEventListener(StoreEvent.ON_VENDER_OPENED, this.OnVenderOpened, false, 0, true);
            this._gameClient.addEventListener(StoreEvent.ON_CASH_BUY_LIST, this.OnCashStoreBuyList, false, 0, true);
            this._gameClient.addEventListener(StoreEvent.ON_CASH_BUY_RESULT, this.OnCashStoreBuyResult, false, 0, true);
            this._gameClient.addEventListener(StoreEvent.ON_PREMIUM_BUY_LIST, this.OnPremiumBuyList, false, 0, true);
            this._gameClient.addEventListener(StoreEvent.ON_PREMIUM_BUY_RESULT, this.OnPremiumBuyResult, false, 0, true);
            this._gameClient.addEventListener(GuildEvent.ON_GUILD_CREATION_MESSAGE, this.OnGuildCreationMessage, false, 0, true);
            this._gameClient.addEventListener(GuildEvent.ON_GUILD_UPDATED, this.OnGuildUpdated, false, 0, true);
            this._gameClient.addEventListener(GuildEvent.ON_GUILD_JOIN_REQUEST, this.OnPlayerInvitedToGuild, false, 0, true);
            this._gameClient.addEventListener(GuildEvent.ON_GUILD_LEAVE_MESSAGE, this.OnActorLeaveGuild, false, 0, true);
            this._gameClient.addEventListener(GuildEvent.ON_GUILD_ALLY_REQUEST, this.OnGuildAllyRequest, false, 0, true);
            this._gameClient.addEventListener(PartyEvent.ON_PARTY_JOIN_REQUEST, this.OnPartyJoinRequest, false, 0, true);
            this._gameClient.addEventListener(PartyEvent.ON_PARTY_MEMBER_JOINED, this.OnPartyMemberJoined, false, 0, true);
            this._gameClient.addEventListener(PartyEvent.ON_PARTY_UPDATED, this.OnPartyUpdated, false, 0, true);
            this._gameClient.addEventListener(PartyEvent.ON_PARTY_LEAVE, this.OnPartyLeave, false, 0, true);
            this._gameClient.addEventListener(PartyEvent.ON_PARTY_CREATION_RESULT, this.OnPartyCreationResult, false, 0, true);
            this._gameClient.addEventListener(DuelEvent.ON_DUEL_JOIN_REQUEST, this.OnDuelJoinRequest, false, 0, true);
            this._gameClient.addEventListener(TradeEvent.ON_TRADE_REQUEST, this.OnTradeJoinRequest, false, 0, true);
            this._gameClient.addEventListener(TradeEvent.ON_TRADE_START_REPLY, this.OnTradeStartReply, false, 0, true);
            this._gameClient.addEventListener(TradeEvent.ON_TRADE_ITEM_OK, this.OnTradeItemOk, false, 0, true);
            this._gameClient.addEventListener(TradeEvent.ON_TRADE_ADD_ITEM, this.OnTradeAddItem, false, 0, true);
            this._gameClient.addEventListener(TradeEvent.ON_TRADE_ITEM_CANCEL, this.OnTradeItemCancel, false, 0, true);
            this._gameClient.addEventListener(TradeEvent.ON_TRADE_DELETE_ITEM, this.OnTradeDeleteItem, false, 0, true);
            this._gameClient.addEventListener(TradeEvent.ON_TRADE_ADD_ZENY, this.OnTradeAddZeny, false, 0, true);
            this._gameClient.addEventListener(TradeEvent.ON_TRADE_DEAL_LOCKED, this.OnTradeDealLocked, false, 0, true);
            this._gameClient.addEventListener(TradeEvent.ON_TRADE_COMPLITED, this.OnTradeComplited, false, 0, true);
            this._gameClient.addEventListener(FriendEvent.ON_FRIENDS_UPDATED, this.OnFriendsUpdated, false, 0, true);
            this._gameClient.addEventListener(FriendEvent.ON_FRIENDS_RESULT, this.OnFriendsResult, false, 0, true);
            this._gameClient.addEventListener(FriendEvent.ON_FRIEND_MEMBER_ADD_REQUEST, this.OnFriendsMemberAddRequest, false, 0, true);
            this._gameClient.addEventListener(IgnoreEvent.ON_IGNORELIST_UPDATED, this.OnIgnoreListUpdated, false, 0, true);
            this._gameClient.addEventListener(IgnoreEvent.ON_IGNORE_RESULT, this.OnIgnoreResult, false, 0, true);
            this._gameClient.addEventListener(IgnoreEvent.ON_IGNOREALL_RESULT, this.OnIgnoreAllresult, false, 0, true);
            this._gameClient.addEventListener(ActorDisplayEvent.ON_ACTOR_NAME_UPDATED, this.OnActorDisplayEvent, false, 0, true);
            this._gameClient.addEventListener(ActorDisplayEvent.ON_ACTOR_DISAPPEAR, this.OnActorDisplayEvent, false, 0, true);
            this._gameClient.addEventListener(ActorDisplayEvent.ON_ACTOR_DISAPPEAR, this.OnPlayerDied, false, 0, true);
            this._gameClient.addEventListener(ActorDisplayEvent.ON_ACTOR_RESURRECTED, this.OnPlayerResurrected, false, 0, true);
            this._gameClient.addEventListener(ItemAddedEvent.ON_ITEM_ADDED, this.OnItemAdded, false, 0, true);
            this._gameClient.addEventListener(UpdateCashEvent.ON_CASH_UPDATED, this.OnCashUpdated, false, 0, true);
            this._gameClient.addEventListener(UpdatePremiumEvent.ON_PREMIUM_UPDATED, this.OnPremiumUpdated, false, 0, true);
            this._gameClient.addEventListener(UpdateQuestsEvent.ON_QUESTS_UPDATED, this.OnQuestsUpdated, false, 0, true);
            this._settingsWindow.addEventListener(SettingsWindow.ON_SETTINGS_APPLIED, this.OnChangeSettings, false, 0, true);
            this._gameClient.addEventListener(GiftItemEvent.ON_GIFT_ITEM, this.OnGiftItemReceived, false, 0, true);
            this._gameClient.addEventListener(UpdateRouletteCashEvent.ON_ROULETTE_CASH_UPDATED, this.OnRouletteCashUpdated, false, 0, true);
            this._gameClient.addEventListener(RefineResultEvent.ON_REFINE_RESPONSE, this.OnRefineResponse, false, 0, true);
            this._gameClient.addEventListener(RefineResultEvent.ON_REFINE_ITEM_UPDATE, this.OnRefineItemUpdate, false, 0, true);
            this._gameClient.addEventListener(ProduceResultEvent.ON_PRODUCE_RESULT, this.OnProduceResult, false, 0, true);
            this._gameClient.addEventListener(UpgradeResultEvent.ON_UPGRADE_RESULT, this.OnUpgradeResult, false, 0, true);
            this._gameClient.addEventListener(CraftCardResultEvent.ON_CRAFTCARD_RESULT, this.OnCraftCardResult, false, 0, true);
            this._gameClient.addEventListener(CastlesInfoEvent.ON_CASTLES_INFO_UPDATED, this.OnCastlesInfoUpdated, false, 0, true);
            this._gameClient.addEventListener(LaddersInfoEvent.ON_LADDERS_INFO_UPDATED, this.OnLaddersInfoUpdated, false, 0, true);
            this._gameClient.addEventListener(MapOnlineInfoEvent.ON_MAP_ONLINE_INFO_UPDATED, this.OnMapOnlineInfoUpdated, false, 0, true);
            this._gameClient.addEventListener(SoundEffectEvent.ON_SOUND_EFFECT, this.OnSoundEffectRecived, false, 0, true);
            this._gameClient.addEventListener(FloorItemEvent.ON_FLOOR_ITEM_OVERWEIGHT, this.OnFloorItemOverweight, false, 0, true);
            this._gameClient.addEventListener(PremiumPackEvent.ON_PREMIUM_PACK, this.OnPremiumPackResult, false, 0, true);
            this._gameClient.addEventListener(ActorViewIdEvent.ON_ACTOR_VIEWID_UPDATE, this.OnActorViewIdEvent, false, 0, true);
            this._gameClient.addEventListener(DurabilityEvent.ON_REPAIR_LIST, this.OnRepairListResponse, false, 0, true);
            this._gameClient.addEventListener(DurabilityEvent.ON_REPAIR_TOTAL_PRICE, this.OnRepairTotalPriceResponse, false, 0, true);
            this._gameClient.addEventListener(DurabilityEvent.ON_REPAIR_ITEM, this.OnRepairItemResponse, false, 0, true);
            this._gameClient.addEventListener(DurabilityEvent.ON_LOW_DURABILITY, this.OnLowDurabilityResponse, false, 0, true);
            this._gameClient.addEventListener(InstanceEvent.ON_INSTANCE_UPDATE_MAP, this.OnInstanceUpdateMap, false, 0, true);
            this._gameClient.addEventListener(InstanceEvent.ON_INSTANCE_JOIN, this.OnInstanceJoin, false, 0, true);
            this._gameClient.addEventListener(InstanceEvent.ON_INSTANCE_LEAVE, this.OnInstanceLeave, false, 0, true);
            this._gameClient.addEventListener(InstanceEvent.ON_INSTANCE_TIMEOUT, this.OnInstanceTimeout, false, 0, true);
            this._gameClient.addEventListener(InstanceEvent.ON_INSTANCE_ERROR, this.OnInstanceError, false, 0, true);
        }

        public function ShowEmotionWindow():void
        {
            if (this._emotionWindow.isShowing())
            {
                this._emotionWindow.dispose();
            }
            else
            {
                if (this.LocalGameClient.ActorList.GetPlayer().jobId == 0)
                {
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.NO_JOB_EMOTION_MESSAGE, null, null, true, new AttachIcon("AchtungIcon"), JOptionPane.OK));
                }
                else
                {
                    this._emotionWindow.show();
                    this._emotionWindow.setLocationXY(20, ((RenderSystem.Instance.ScreenHeight - 166) - this._emotionWindow.height));
                };
            };
        }

        public function CloseEmotionWindow():void
        {
            this._emotionWindow.dispose();
        }

        public function ShowEmblemWindow():void
        {
            var _local_1:GuildInfo = this.LocalGameClient.ActorList.GetPlayer().Guild;
            if (((_local_1) && (_local_1.IsGuildMaster)))
            {
                if (this._emblemWindow == null)
                {
                    this._emblemWindow = new EmblemWindow();
                    this._emblemWindow.Revalidate();
                };
                this._emblemWindow.show();
            };
        }

        public function CloseEmblemWindow():void
        {
            if (this._emblemWindow)
            {
                this._emblemWindow.dispose();
            };
        }

        public function CloseProduceWindow():void
        {
            if (this._produceDialog)
            {
                if (this._produceDialog.isShowing())
                {
                    this._produceDialog.dispose();
                };
                this._produceDialog = null;
            };
        }

        public function ShowBuffWindow():void
        {
            if (!this._buffWindow)
            {
                return;
            };
            if (this._buffWindow.isShowing())
            {
                this._buffWindow.dispose();
            }
            else
            {
                this._buffWindow.show();
            };
        }

        public function get BuffWindowInstance():BuffWindow
        {
            return (this._buffWindow);
        }

        public function ShowBookWindow():void
        {
            if (this._bookWindow == null)
            {
                this._bookWindow = new BookWindow();
            };
            if (this._bookWindow.isShowing())
            {
                this._bookWindow.dispose();
            }
            else
            {
                this._bookWindow.show();
            };
        }

        private function OnGiftItemReceived(_arg_1:GiftItemEvent):void
        {
            var _local_2:DailyGiftWindow = new DailyGiftWindow(_arg_1.PremiumType, _arg_1.Day);
            _local_2.ShowWithAnimation();
        }

        private function OnRouletteCashUpdated(_arg_1:UpdateRouletteCashEvent):void
        {
            var _local_2:String;
            if (_arg_1.Result == 1)
            {
                _local_2 = ClientApplication.Localization.ROULETTE_RESULT_WIN;
            }
            else
            {
                _local_2 = ClientApplication.Localization.ROULETTE_RESULT_LOSE;
            };
            new PrimaryAlertPane(null, _local_2, this.OnRouletteResultWindowClosed);
        }

        private function OnRouletteResultWindowClosed(_arg_1:int):void
        {
        }

        private function OnRefineResponse(_arg_1:RefineResultEvent):void
        {
            var _local_2:String;
            if (_arg_1.Result == 0)
            {
                _local_2 = ClientApplication.Localization.REFINE_WINDOW_RESULT_WIN;
            }
            else
            {
                _local_2 = ClientApplication.Localization.REFINE_WINDOW_RESULT_LOSE_1;
                switch (_arg_1.Result)
                {
                    case 1:
                        _local_2 = (_local_2 + ("\n" + ClientApplication.Localization.REFINE_WINDOW_RESULT_LOSE_3));
                        break;
                    case 2:
                        _local_2 = (_local_2 + ("\n" + ClientApplication.Localization.REFINE_WINDOW_RESULT_LOSE_2));
                        break;
                    case 3:
                        _local_2 = (_local_2 + ("\n" + ClientApplication.Localization.REFINE_WINDOW_RESULT_LOSE_4));
                        break;
                };
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.REFINE_WINDOW_RESULT_TITLE, _local_2, null, null, true, new AttachIcon("AchtungIcon"), JOptionPane.OK));
        }

        private function OnRefineItemUpdate(_arg_1:RefineResultEvent):void
        {
            if (((this._refineWindow) && (this._refineWindow.isShowing())))
            {
                if (((this._characterInventory) && (this._characterInventory.isShowing())))
                {
                    this._characterInventory.RevalidateItems(false, _arg_1.Item);
                };
            };
        }

        private function OnProduceResult(_arg_1:ProduceResultEvent):void
        {
            var _local_2:String;
            this.CloseProduceWindow();
            if (_arg_1.Result == 0)
            {
                _local_2 = ClientApplication.Localization.PRODUCE_WINDOW_RESULT_WIN1;
            }
            else
            {
                if (_arg_1.Result == 1)
                {
                    _local_2 = ClientApplication.Localization.PRODUCE_WINDOW_RESULT_LOSE1;
                }
                else
                {
                    if (_arg_1.Result == 2)
                    {
                        _local_2 = ClientApplication.Localization.PRODUCE_WINDOW_RESULT_WIN2;
                    }
                    else
                    {
                        if (_arg_1.Result == 3)
                        {
                            _local_2 = ClientApplication.Localization.PRODUCE_WINDOW_RESULT_LOSE2;
                        }
                        else
                        {
                            return;
                        };
                    };
                };
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.PRODUCE_WINDOW_RESULT_TITLE, _local_2, this.OnProduceWindowClosed, null, true, new AttachIcon("AchtungIcon"), JOptionPane.OK));
        }

        public function OnProduceWindowClosed(_arg_1:int):void
        {
            this.CloseProduceWindow();
        }

        private function OnUpgradeResult(_arg_1:UpgradeResultEvent):void
        {
            var _local_2:String;
            var _local_3:Boolean;
            switch (_arg_1.Result)
            {
                case 0:
                    if (_arg_1.Type == 0)
                    {
                        _local_2 = ClientApplication.Localization.UPGRADE_WINDOW_RESULT_INSERT_WIN;
                    }
                    else
                    {
                        _local_2 = ClientApplication.Localization.UPGRADE_WINDOW_RESULT_EXTRACT_WIN;
                    };
                    break;
                case 2:
                    _local_2 = ClientApplication.Localization.UPGRADE_WINDOW_RESULT_LOSE;
                    _local_3 = true;
                    break;
                case 3:
                    _local_2 = ClientApplication.Localization.UPGRADE_WINDOW_NO_GOLD_ERROR;
                    break;
                case 4:
                    _local_2 = ClientApplication.Localization.UPGRADE_WINDOW_NO_SILVER_ERROR;
                    break;
                case 5:
                    _local_2 = ClientApplication.Localization.STORE_RESULTS[3];
                    break;
                default:
                    _local_2 = ClientApplication.Localization.UPGRADE_WINDOW_RESULT_ERROR;
            };
            ClientApplication.Instance.RevalidateUpgradeWindow(_local_3);
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.UPGRADE_WINDOW_RESULT_TITLE, _local_2, null, null, true, new AttachIcon("AchtungIcon"), JOptionPane.OK));
        }

        private function OnCraftCardResult(_arg_1:CraftCardResultEvent):void
        {
            var _local_2:String;
            switch (_arg_1.Result)
            {
                case 0:
                    _local_2 = ClientApplication.Localization.CRAFTCARD_WINDOW_RESULT_SUCCESS;
                    break;
                case 1:
                    _local_2 = ClientApplication.Localization.CRAFT_CARD_WINDOW_RESULT_FAIL;
                    break;
                case 2:
                    _local_2 = ClientApplication.Localization.CRAFT_CARD_WINDOW_RESULT_FAIL_SAFE;
                    break;
                default:
                    _local_2 = ClientApplication.Localization.CRAFT_CARD_WINDOW_RESULT_ERROR;
            };
            ClientApplication.Instance.RevalidateCraftRuneWindow(true, true);
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.CRAFTCARD_WINDOW_RESULT_TITLE, _local_2, null, null, true, new AttachIcon("AchtungIcon"), JOptionPane.OK));
        }

        private function OnCastlesInfoUpdated(_arg_1:CastlesInfoEvent):void
        {
            if (this._castlesWindow == null)
            {
                this._castlesWindow = new CastlesWindow();
            };
            this._castlesWindow.LoadCastles(_arg_1.Castles);
            this._castlesWindow.show();
        }

        private function OnLaddersInfoUpdated(_arg_1:LaddersInfoEvent):void
        {
            if (this._laddersWindow == null)
            {
                this._laddersWindow = new LaddersWindow();
            };
            this._laddersWindow.LoadLadders(_arg_1.Ladders);
            this._laddersWindow.show();
        }

        private function OnMapOnlineInfoUpdated(_arg_1:MapOnlineInfoEvent):void
        {
            var _local_2:Object = this._dataLibrary.GetMapsData(_arg_1.Mapname);
            if (_local_2)
            {
                _local_2["online"] = _arg_1.Online;
            };
        }

        public function OpenWorldMap():void
        {
            if (this._worldmapWindow == null)
            {
                this._worldmapWindow = new WorldMapWindow();
                this._worldmapWindow.OnShowSound = Music.MapSound;
            };
            if (ClientApplication.Instance.GameSettings.IsPlaySoundsEnabled)
            {
            };
            if (this._worldmapWindow.isShowing())
            {
                this._worldmapWindow.dispose();
            }
            else
            {
                this._worldmapWindow.show();
            };
        }

        public function OpenMiniMap(_arg_1:DisplayObject, _arg_2:Number):void
        {
            var _local_3:String;
            if (((this._minimapWindow == null) || (!(this._minimapWindow.isShowing()))))
            {
                _local_3 = this._topHUD.GetTopHUD._mapPanel._mapName.text;
                this._minimapWindow = new MiniMapWindow(_arg_1, _arg_2, _local_3);
                this._minimapWindow.OnShowSound = Music.MapSound;
                this._minimapWindow.OnDisposeSound = Music.MapSound;
                this._minimapWindow.show();
            }
            else
            {
                this._minimapWindow.dispose();
                this._minimapWindow = null;
            };
        }

        public function get MiniMapWindowInstance():MiniMapWindow
        {
            return (this._minimapWindow);
        }

        public function OpenFriendsWindow():void
        {
            var _local_1:CharacterInfo = this.LocalGameClient.ActorList.GetPlayer();
            if (this._friendsWindow == null)
            {
                this._friendsWindow = new FriendsWindow();
            };
            if (this._friendsWindow.isShowing())
            {
                this._friendsWindow.dispose();
            }
            else
            {
                if (_local_1.Friends != null)
                {
                    this._friendsWindow.Revalidate();
                };
                this._friendsWindow.show();
            };
        }

        private function OnItemAdded(_arg_1:ItemAddedEvent):void
        {
            var _local_2:ItemData;
            var _local_4:ItemsResourceLibrary;
            var _local_5:String;
            _local_2 = _arg_1.Item;
            var _local_3:int = _local_2.NameId;
            switch (_local_3)
            {
                case 24215:
                case 24216:
                case 24217:
                case 24112:
                case 24113:
                case 24114:
                case 24120:
                case 30072:
                case 31115:
                case 31116:
                case 31117:
                    return;
                default:
                    _local_4 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
                    _local_5 = _local_4.GetItemFullName(_local_2.NameId);
                    this._chatHUD.GetLeftBar.PublicChannel.AddMessage(((Localization.INVENTORY_ITEM_ADDED + " ") + _local_5));
            };
        }

        private function OnChangeSettings(_arg_1:Event):void
        {
            var _local_2:Object;
            var _local_3:int;
            this._fpsTextField.visible = this._settingsWindow.IsFPSEnabled;
            RenderSystem.Instance.IsDrawBloom = this._settingsWindow.IsHighQualityEnabled;
            Music.Instance.MusicEnabled = this._settingsWindow.IsPlayMusicEnabled;
            Music.Instance.SoundsEnabled = this._settingsWindow.IsPlaySoundsEnabled;
            if (this._settingsWindow.IsPlayMusicEnabled)
            {
                Music.Instance.LoadLocationMusic(this._mapMusicIdle, this._mapMusicBattle);
                if (CharacterStorage.Instance.PvPMode == 3)
                {
                    Music.Instance.PlayBattle();
                }
                else
                {
                    Music.Instance.PlayIdle();
                };
            }
            else
            {
                Music.Instance.StopCurrentMusic();
            };
            if (this._settingsWindow.IsPlaySoundsEnabled)
            {
                Music.Instance.LoadSound(Music.LevelupSound);
                Music.Instance.LoadSound(Music.ClickSound);
                Music.Instance.LoadSound(Music.MenuZoomInSound);
                Music.Instance.LoadSound(Music.MenuZoomOutSound);
                Music.Instance.LoadSound(Music.MapSound);
                for each (_local_2 in Music.ScriptSounds)
                {
                    Music.Instance.LoadSound(_local_2);
                };
            };
            CharacterStorage.Instance.IsEnableAutoAttack = this._settingsWindow.IsAutoAttackEnabled;
            CharacterStorage.Instance.IsEnableObjectsGlow = (!(this._settingsWindow.IsObjectsGlowDisabled));
            CharacterStorage.Instance.IsEnableBlinking = (!(this._settingsWindow.IsBlinkingDisabled));
            CharacterStorage.Instance.IsShowGWDamage = this._settingsWindow.IsShowGWDAmageEnabled;
            CharacterStorage.Instance.IsShowGuildNotice = (!(this._settingsWindow.IsGuildNoticeDisabled));
            CharacterStorage.Instance.IsEnableSkillAnimation = (!(this._settingsWindow.IsSkillAnimationDisabled));
            CharacterStorage.Instance.IsEnableChatHiding = (!(this._settingsWindow.IsChatHidingDisabled));
            CharacterAnimation.ReleaseTimerTimeout = ((this._settingsWindow.IsReleaseTimerEnabled) ? 20000 : 60000);
            if (_arg_1 != null)
            {
                _local_3 = this._settingsWindow.CurrentSettings;
                this.LocalGameClient.ActorList.GetPlayer().Hotkeys.SetSettings(_local_3);
                this.LocalGameClient.SendHotkey((HotKeys.MAX_HOTKEYS - 1), HotKeys.HOTKEY_SETTINGS, _local_3, 0);
            };
        }

        private function OnClientError(_arg_1:ClientError):void
        {
            if (((this._errorDialog) && (this._errorDialog.isShowing())))
            {
                this._errorDialog.Dispose();
            };
            this.ShowError(_arg_1.Message, false);
        }

        private function OnException(_arg_1:Event):void
        {
            this.CriticalError(("exception/" + _arg_1.type));
        }

        private function OnConnectError(evt:Event):void
        {
            var result:Function;
            result = function (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.OK)
                {
                };
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(Localization.ERR_CONNECTION_ERROR_TITLE, Localization.ERR_CONNECTION_ERROR_MESSAGE, result, null, true, new AttachIcon("StopIcon"), JOptionPane.OK));
        }

        private function OnPasswordError(_arg_1:ClientEvent):void
        {
            if (platform == ClientConfig.DEBUG)
            {
                this.ShowError(Localization.ERR_PASSWORD_ERROR, true);
            }
            else
            {
                this.ReloadPage(true);
            };
        }

        private function OnAccountDoesntExist(_arg_1:ClientEvent):void
        {
            if (this._connectingToServer != null)
            {
                this._connectingToServer.dispose();
                this._connectingToServer = null;
            };
            if (((this._loginPrompt) && (this._loginPrompt.IsShowing())))
            {
                this._loginPrompt.Dispose();
            };
            this.ShowCharacterCreateWindow(true);
        }

        private function OnAccountAndCharacterConfirmed(_arg_1:CharacterCreateEvent):void
        {
            GoogleAnalyticsClient.Instance.trackPageview((("/" + gameServerName) + "/new_account_confirmed"));
            StatisticManager.Instance.InstallApplication();
            this._gameClient.CreateAccount(_arg_1.GenderSuffix);
        }

        private function OnAccountAndCheckCharacterName(_arg_1:CharacterCreateEvent):void
        {
            GoogleAnalyticsClient.Instance.trackPageview((("/" + gameServerName) + "/new_account_confirmed"));
            this._gameClient.CreateAccount(_arg_1.GenderSuffix);
        }

        private function CreateLoader():void
        {
            if (this._loginScreenBG)
            {
                this._loginScreenBG.Dispose();
                this._loginScreenBG = null;
            };
            if (((this._loginPrompt) && (this._loginPrompt.IsShowing())))
            {
                this._loginPrompt.Dispose();
            };
            if (this._connectingToServer != null)
            {
                this._connectingToServer.dispose();
                this._connectingToServer = null;
            };
            if (this._loadingWindow != null)
            {
                this._loadingWindow.Dispose();
            };
            this._loadingWindow = new LoadingScreen(this, this._gameStageWidth, this._gameStageHeight);
            if (((this._loadingBackground) && (!(this.contains(this._loadingBackground)))))
            {
                this.InitLoadingBackground();
                addChild(this._loadingBackground);
            };
            this._loadingWindow.x = ((stageWidth / 2) - (this._loadingWindow.width / 2));
            this._loadingWindow.y = ((RenderSystem.Instance.ScreenHeight / 2) - (this._loadingWindow.height / 2));
            this._loadingWindow.Show();
            if (this._dataLoader == null)
            {
                this._dataLoader = new BulkLoader("main-site");
                this._dataLoader.logLevel = BulkLoader.LOG_SILENT;
                this._dataLoader.addEventListener(BulkLoader.COMPLETE, this.OnAllItemsLoaded, false, -1, true);
                this._dataLoader.addEventListener(BulkLoader.PROGRESS, this.OnAllItemsProgress, false, 0, true);
            };
            CharacterStorage.Instance.LoadGraphics();
            var _local_1:Boolean = this.LoadBackground();
            if (this._isFirstUpdate)
            {
                this.FirstUpdate();
                this._isFirstUpdate = false;
            };
            this._isBulkAllLoaded = false;
            this._isBackgroundLoaded = false;
            if (_local_1)
            {
                this._isBulkAllLoaded = true;
                if (this._fakeLoadingTimer == null)
                {
                    this._fakeLoadingTimer = new Timer(1000, 1);
                    this._fakeLoadingTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.OnAllItemsLoaded);
                };
                this._fakeLoadingTimer.reset();
                this._fakeLoadingTimer.start();
            };
        }

        public function get GameSettings():SettingsWindow
        {
            return (this._settingsWindow);
        }

        public function RevalidateGUI():void
        {
            this._topHUD.RevalidateAvatar();
            if (!this._partyController)
            {
                this._partyController = new PartyController();
            };
        }

        public function RevalidateInventoryBar():void
        {
            this._bottomHUD.InventoryBarInstance.LoadHotKeys();
        }

        public function RevalidateRefineWindow(_arg_1:Boolean=false, _arg_2:Boolean=false, _arg_3:ItemData=null, _arg_4:ItemData=null):void
        {
            if (_arg_1)
            {
                this._refineWindow.ClearRefineSlot();
            };
            if (_arg_2)
            {
                this._refineWindow.ClearGemSlot();
            };
            if (_arg_3)
            {
                this._refineWindow.SetRefineSlot(_arg_3);
            };
            if (_arg_4)
            {
                this._refineWindow.SetGemSlot(_arg_4);
            };
            this._refineWindow.Revalidate(false);
        }

        public function RevalidateUpgradeWindow(_arg_1:Boolean=false, _arg_2:ItemData=null, _arg_3:ItemData=null):void
        {
            if (_arg_1)
            {
                this._upgradeWindow.ClearUpgradeSlot();
            };
            if (_arg_2)
            {
                this._upgradeWindow.ClearRuneSlot(_arg_2);
            };
            if (_arg_3)
            {
                if (_arg_3.Equip > 0)
                {
                    this.LocalGameClient.SendUnequipItem(_arg_3);
                };
                this._upgradeWindow.SetUpgradeSlot(_arg_3);
            };
            this._upgradeWindow.Revalidate();
        }

        public function RevalidateCraftRuneWindow(_arg_1:Boolean=false, _arg_2:Boolean=false, _arg_3:ItemData=null):void
        {
            if (((this._stashAuctionWindow) && (this._stashAuctionWindow.isShowing())))
            {
                this._stashAuctionWindow.RevalidateCraftRunePanel(_arg_1, _arg_2, _arg_3);
            };
        }

        public function RevalidateVioletSellWindow(_arg_1:InventoryVioletSellItem=null):void
        {
            if (((this._stashAuctionWindow) && (this._stashAuctionWindow.isShowing())))
            {
                if (_arg_1)
                {
                    this._stashAuctionWindow.ClearVioletSellSlot(_arg_1);
                };
                this._stashAuctionWindow.RevalidateVioletSellPanel();
            };
        }

        public function ShowCart():void
        {
            if (this._cartWindow == null)
            {
                this._cartWindow = new CartWindow();
            }
            else
            {
                this._cartWindow.VenderClose();
            };
            if (((this._stashAuctionWindow) && (this._stashAuctionWindow.isShowing())))
            {
                this._stashAuctionWindow.dispose();
                this._stashAuctionWindow = null;
            };
            if (((this._shopWindow) && (this._shopWindow.isShowing())))
            {
                this._shopWindow.dispose();
                this._shopWindow = null;
            };
            if (((this._storeWindow) && (this._storeWindow.isShowing())))
            {
                this._storeWindow.dispose();
                this._storeWindow = null;
            };
            if (((this._storageWindow) && (this._storageWindow.isShowing())))
            {
                this._storageWindow.dispose();
                this._storageWindow = null;
            };
            this._cartWindow.show();
        }

        public function LoadBackground():Boolean
        {
            var _local_3:String;
            var _local_4:Boolean;
            if (this._background == null)
            {
                this._background = new Background();
                RenderSystem.Instance.AddRenderObject(this._background);
            };
            if (this._fogObject == null)
            {
                this._fogObject = new FogObject();
                RenderSystem.Instance.AddRenderObject(this._fogObject);
            };
            if (this._movePointerObject == null)
            {
                this._movePointerObject = new MovePointerObject();
                RenderSystem.Instance.AddRenderObject(this._movePointerObject);
            };
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_1:Object = this._dataLibrary.GetMapsData(this.LocalGameClient.MapName);
            var _local_2:String = ((("/" + gameServerName) + "/maps/") + this.LocalGameClient.MapName);
            GoogleAnalyticsClient.Instance.trackPageview(_local_2);
            if (_local_1 != null)
            {
                _local_3 = _local_1["ScriptName"];
                this._mapMusicIdle = _local_1["MusicIdle"];
                this._mapMusicBattle = _local_1["MusicBattle"];
                this.isDieOnLadder = ((_local_1["Arena"]) ? (_local_1["Arena"] == 1) : false);
                this._lastMapId = this._currentMapId;
                this._currentMapId = _local_3;
                this._topHUD.SetMapParameters(_local_1);
                this._topHUD.GetTopHUD._mapPanel._guideButton.visible = false;
                this._chatHUD.GetRightHUD._partyInfoPanel.visible = false;
                _local_4 = this._background.LoadLocationData(_local_1);
                return (_local_4);
            };
            this.ShowError(((ClientApplication.Localization.ERR_UNKNOWN_MAP_DESCRIPTION + " ") + this.LocalGameClient.MapName));
            return (false);
        }

        public function OnBackgroundLoaded():void
        {
            this._isBackgroundLoaded = true;
            this.OnAllItemsLoaded(null);
        }

        private function OnAllItemsLoaded(_arg_1:Event):void
        {
            var _local_2:TimerEvent = (_arg_1 as TimerEvent);
            var _local_3:BulkProgressEvent = (_arg_1 as BulkProgressEvent);
            if (_local_3)
            {
                this._isBulkAllLoaded = true;
            };
            if (this._finalProgressTimer == null)
            {
                this._finalProgressTimer = new Timer(1000, 1);
                this._finalProgressTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.OnAllItemsLoaded);
            };
            if (((!(_local_2 == null)) && (_local_2.target == this._fakeLoadingTimer)))
            {
                this._background.LoadLocationDataInternal();
                this._loadingWindow.UpdateProgress(1, 1);
                this._finalProgressTimer.reset();
                this._finalProgressTimer.start();
                return;
            };
            var _local_4:Boolean = ((_local_2 == null) && (!(this._isBackgroundLoaded)));
            var _local_5:Boolean = ((_local_2 == null) ? false : (!(_local_2.target == this._finalProgressTimer)));
            if (((_local_4) || (_local_5)))
            {
                this._loadingWindow.UpdateProgress(1, 1);
                this._finalProgressTimer.reset();
                this._finalProgressTimer.start();
                return;
            };
            if (((!(this._isBackgroundLoaded)) || (!(this._isBulkAllLoaded))))
            {
                return;
            };
            if (this._finalProgressTimer == null)
            {
                return;
            };
            if (this._finalProgressTimer.running)
            {
                return;
            };
            stage.frameRate = 50;
            this._gameClient.SendMapLoaded();
            this._emotionWindow.Revalidate();
            this._buffWindow.Revalidate();
            this.EnteringGameProcess();
        }

        public function GetIndexForArrowMap():int
        {
            if (((this._chatHUD) && (this._chatHUD.parent)))
            {
                return (getChildIndex(this._chatHUD));
            };
            return (0);
        }

        private function EnteringGameProcess():void
        {
            var timerId:uint;
            var result:Function;
            result = function ():void
            {
                clearTimeout(timerId);
                var _local_1:SocialFriends = GetSocialFriends();
                if (_local_1)
                {
                    _local_1.InitFriends(friendRef);
                };
                friendRef = null;
            };
            if (this._loadingWindow != null)
            {
                this._loadingWindow.Dispose();
            };
            if (((this._loadingBackground) && (this.contains(this._loadingBackground))))
            {
                removeChild(this._loadingBackground);
            };
            if (this._backBufferBitmap != null)
            {
                if (this.contains(this._backBufferBitmap))
                {
                    removeChild(this._backBufferBitmap);
                };
                this._backBufferBitmap = null;
            };
            this._backBufferBitmap = new Bitmap(RenderSystem.Instance.BackBuffer);
            this._backBufferBitmap.bitmapData.fillRect(this._backBufferBitmap.bitmapData.rect, 4294506744);
            addChild(this._backBufferBitmap);
            ExtensionRender.Instance.Enable(true);
            addChild(ExtensionRender.Instance.RenderContainer);
            ExtensionRender.Instance.ChangeMap();
            this._fpsTextField.y = 1;
            this._fpsTextField.x = 2;
            this._fpsTextField.htmlText = HtmlText.update("Fps: 0", false, 12, HtmlText.fontName, "#000000");
            this._fpsTextField.border = true;
            this._fpsTextField.background = true;
            this._fpsTextField.backgroundColor = 0xFFCC00;
            this._fpsTextField.autoSize = TextFieldAutoSize.LEFT;
            this._fpsTextField.selectable = false;
            GameLogic.Instance.OnChangeMap();
            this.RegisterInput();
            addChild(this._topHUD);
            addChild(this._chatHUD);
            addChild(this._bottomHUD);
            this._chatHUD.InitializeChatPanels();
            this._topHUD.InitializeMiniMap();
            this._bottomHUD.GetBottomHUD._characterButton.addEventListener(MouseEvent.CLICK, this.OnCharacterButtonPressed, false, 0, true);
            this._bottomHUD.GetBottomHUD._characterNotifyButton.addEventListener(MouseEvent.CLICK, this.OnCharacterButtonPressed, false, 0, true);
            this._bottomHUD.GetBottomHUD._skillsButton.addEventListener(MouseEvent.CLICK, this.OnSkillsButtonPressed, false, 0, true);
            this._bottomHUD.GetBottomHUD._skillsNotifyButton.addEventListener(MouseEvent.CLICK, this.OnSkillsButtonPressed, false, 0, true);
            this._bottomHUD.GetBottomHUD._guildButton.addEventListener(MouseEvent.CLICK, this.OnGuildButtonPressed, false, 0, true);
            this._bottomHUD.GetBottomHUD._premiumShopButton.addEventListener(MouseEvent.CLICK, this.OnPremiumShopButtonPressed, false, 0, true);
            this._bottomHUD.GetBottomHUD._laddersButton.addEventListener(MouseEvent.CLICK, this.OnLaddersButtonPressed, false, 0, true);
            this._bottomHUD.GetBottomHUD._friendsButton.addEventListener(MouseEvent.CLICK, this.OnSocialButtonPressed, false, 0, true);
            this._topHUD.GetTopHUD._mapPanel._worldmapButton.addEventListener(MouseEvent.CLICK, this.OnMapButtonPressed, false, 0, true);
            this._topHUD.GetTopHUD._questsButton.addEventListener(MouseEvent.CLICK, this.OnQuestsButtonPressed, false, 0, true);
            this._topHUD.GetTopHUD._questsNotifyButton.addEventListener(MouseEvent.CLICK, this.OnQuestsButtonPressed, false, 0, true);
            this._bottomHUD.GetBottomHUD._silverPanel._silverButton.addEventListener(MouseEvent.CLICK, this.OnSilverButtonPressed, false, 0, true);
            this._bottomHUD.GetBottomHUD._goldPanel._goldButton.addEventListener(MouseEvent.CLICK, this.OnGoldButtonPressed, false, 0, true);
            this._bottomHUD.GetBottomHUD._goldPanel._goldNotifyButton.addEventListener(MouseEvent.CLICK, this.OnGoldButtonPressed, false, 0, true);
            this._bottomHUD.GetBottomHUD._mailButton.addEventListener(MouseEvent.CLICK, this.OnMailButtonPressed, false, 0, true);
            this._bottomHUD.GetBottomHUD._mailNotifyButton.addEventListener(MouseEvent.CLICK, this.OnMailButtonPressed, false, 0, true);
            this._bottomHUD.GetBottomHUD._auctionButton.addEventListener(MouseEvent.CLICK, this.OnAuctionButtonPressed, false, 0, true);
            this._topHUD.GetTopHUD._mapPanel._guideButton.addEventListener(MouseEvent.CLICK, this.OnGuideButtonPressed, false, 0, true);
            this._topHUD.GetTopHUD._mapPanel._helpButton.addEventListener(MouseEvent.CLICK, this.OnHelpButtonPressed, false, 0, true);
            this._topHUD.GetTopHUD._mapPanel._settingsButton.addEventListener(MouseEvent.CLICK, this.OnSettingsButtonPressed, false, 0, true);
            this._topHUD.GetTopHUD._mapPanel._fullscreenButton.addEventListener(MouseEvent.CLICK, this.OnFullScreenButtonPressed, false, 0, true);
            this._topHUD.GetTopHUD._mapPanel._pritonButton.addEventListener(MouseEvent.CLICK, this.OnPritonButtonPressed, false, 0, true);
            this._topHUD._arenaPanel._button.addEventListener(MouseEvent.CLICK, this.OnArenaButtonPressed, false, 0, true);
            if (this._buffWindowNeedShow)
            {
                this._buffWindow.show();
                this._buffWindowNeedShow = false;
            };
            this._chatHUD.GetRightBar.RevalidateUsers(this.LocalGameClient.ActorList);
            this.RevalidateDurabilityEquipment();
            this.LocalGameClient.SendUpdateCash();
            this.LocalGameClient.SendUpdateQuests();
            addChild(this._fpsTextField);
            var partyListPanel:DisplayObject = this.PartyList.GetUIComponent();
            partyListPanel.x = (RenderSystem.Instance.ScreenWidth - 150);
            partyListPanel.y = (this._chatHUD.GetRightHUD._partyInfoPanel.y + 30);
            addChild(partyListPanel);
            this.OnChangeSettings(null);
            timerId = setTimeout(result, 5000);
            this.TopHUD.QuestsPanel.dispose();
            this.TopHUD.QuestsPanel.Update();
            HelpManager.Instance.GetRoadAtlas().Update();
        }

        public function get StashAuction():StashAuctionWindow
        {
            return (this._stashAuctionWindow);
        }

        public function get PremiumShop():PremiumShopWindow
        {
            return (this._premiumShopWindow);
        }

        public function get KafraShop():KafraShopWindow
        {
            return (this._kafraShopWindow);
        }

        private function OnLaddersButtonPressed(_arg_1:MouseEvent):void
        {
            this.ThisMethodIsDisabled();
        }

        private function OnSettingsButtonPressed(_arg_1:MouseEvent):void
        {
            if (this._settingsWindow.isShowing())
            {
                this._settingsWindow.dispose();
            }
            else
            {
                this._settingsWindow.show();
            };
        }

        private function OnHelpButtonPressed(_arg_1:MouseEvent):void
        {
            var _local_2:JPopupMenu = new JPopupMenu();
            if (((this._config.CurrentPlatformId == ClientConfig.WEB) || (this._config.CurrentPlatformId == ClientConfig.STANDALONE)))
            {
                _local_2.addMenuItem(ClientApplication.Localization.TOPBAR_MENU_SITE_PAGE).addActionListener(this.OnGroupPage, 0, true);
            };
            _local_2.addMenuItem(ClientApplication.Localization.TOPBAR_MENU_BOOK).addActionListener(this.OnBook, 0, true);
            _local_2.addMenuItem(ClientApplication.Localization.TOPBAR_MENU_CASTLES).addActionListener(this.OnCastlesInfo, 0, true);
            _local_2.addMenuItem(ClientApplication.Localization.TOPBAR_MENU_MESSAGE_TO_GM).addActionListener(this.OnSendMessageToMasters, 0, true);
            _local_2.addMenuItem(ClientApplication.Localization.TOPBAR_MENU_LOGOUT).addActionListener(this.OnLogout, 0, true);
            _local_2.addMenuItem(ClientApplication.Localization.TOPBAR_MENU_CHANGELOG).addActionListener(this.OnChangelog, 0, true);
            _local_2.show(null, stage.mouseX, stage.mouseY);
        }

        private function OnFullScreenButtonPressed(_arg_1:MouseEvent):void
        {
            HelpManager.Instance.FullScreenPressed();
            if (stage.displayState == StageDisplayState.NORMAL)
            {
                stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
            }
            else
            {
                stage.displayState = StageDisplayState.NORMAL;
            };
            this.StageResize(null);
        }

        private function OnMapButtonPressed(_arg_1:MouseEvent):void
        {
            this.OpenWorldMap();
        }

        private function OnMailButtonPressed(_arg_1:Event):void
        {
            this.MailInstance.OpenMailList();
        }

        private function OnAuctionButtonPressed(_arg_1:Event):void
        {
            this.ThisMethodIsDisabled();
        }

        private function OnPritonButtonPressed(_arg_1:Event):void
        {
            this.ShowPritonWindow();
        }

        private function OnQuestsButtonPressed(_arg_1:MouseEvent):void
        {
            this.ShowQuestsWindow();
        }

        private function OnSocialButtonPressed(_arg_1:MouseEvent):void
        {
            this.OpenFriendsWindow();
        }

        private function OnPremiumShopButtonPressed(_arg_1:MouseEvent):void
        {
            this.OpenCashShop();
        }

        private function OnSilverButtonPressed(_arg_1:Event):void
        {
            this.ThisMethodIsDisabled();
            this._buyCahsWindow = ((this._buyCahsWindow) || (new NewBuyCashWindow()));
            if (!this._buyCahsWindow.isShowing())
            {
                this._buyCahsWindow.ShowBuyCash(NewBuyCashWindow.SILVER_PANEL);
            };
        }

        private function OnGoldButtonPressed(_arg_1:Event):void
        {
            this.OpenPayDialog();
            this._bottomHUD.BlinkGold(false);
        }

        private function OnSendMessageToMasters(_arg_1:Event):void
        {
            var _local_3:MessageToGameMasters;
            var _local_2:CharacterInfo = this.LocalGameClient.ActorList.GetPlayer();
            if (_local_2.manner > 0)
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(Localization.DLG_WARNING, Localization.MUTE_SETTED, null, null, true, new AttachIcon("AchtungIcon")));
            }
            else
            {
                _local_3 = new MessageToGameMasters();
                _local_3.show();
            };
        }

        private function OnGuideButtonPressed(_arg_1:MouseEvent):void
        {
            this.LocalGameClient.SendRemoteNPCClick("GuideUniversal");
        }

        private function OnCloudButtonPressed(_arg_1:MouseEvent):void
        {
            this.LocalGameClient.SendRemoteNPCClick("FairyKey");
        }

        private function OnArenaButtonPressed(_arg_1:MouseEvent):void
        {
            this.LocalGameClient.SendRemoteNPCClick("ArenaKey");
            this._topHUD._arenaPanel.visible = false;
        }

        private function OnBaseDocumentation(_arg_1:AWEvent):void
        {
            GoogleAnalyticsClient.Instance.trackPageview("/documentation/base");
            switch (this._config.CurrentPlatformId)
            {
                case ClientConfig.VKONTAKTE:
                case ClientConfig.VKONTAKTE_TEST:
                    navigateToURL(new URLRequest("http://vk.com/page-18990411_28703758"));
                    return;
                case ClientConfig.MAILRU:
                case ClientConfig.MAILRU_TEST:
                    navigateToURL(new URLRequest((this._config.GetAppGroupURL + "/19C985A8D2AA90DC.html")));
                    return;
                case ClientConfig.WEB:
                case ClientConfig.WEB_TEST:
                case ClientConfig.STANDALONE:
                    navigateToURL(new URLRequest((this._config.GetAppGroupURL + "/library/kbase/#content")));
                    return;
                case ClientConfig.ODNOKLASSNIKI:
                case ClientConfig.ODNOKLASSNIKI_TEST:
                    navigateToURL(new URLRequest((this._config.GetAppGroupURL + "/topic/202394258045")));
                    return;
                default:
                    this.ThisMethodIsDisabled();
            };
        }

        private function OnQuestDocumentation(_arg_1:AWEvent):void
        {
            GoogleAnalyticsClient.Instance.trackPageview("/documentation/quests");
            switch (this._config.CurrentPlatformId)
            {
                case ClientConfig.VKONTAKTE:
                case ClientConfig.VKONTAKTE_TEST:
                    navigateToURL(new URLRequest("http://vk.com/page-18990411_28703836"));
                    return;
                case ClientConfig.MAILRU:
                case ClientConfig.MAILRU_TEST:
                    navigateToURL(new URLRequest((this._config.GetAppGroupURL + "/23FBCF48CB06E568.html")));
                    return;
                case ClientConfig.WEB:
                case ClientConfig.WEB_TEST:
                case ClientConfig.STANDALONE:
                    navigateToURL(new URLRequest((this._config.GetAppGroupURL + "/library/kbase/quests.php#content")));
                    return;
                case ClientConfig.ODNOKLASSNIKI:
                case ClientConfig.ODNOKLASSNIKI_TEST:
                    navigateToURL(new URLRequest((this._config.GetAppGroupURL + "/topic/202865186685")));
                    return;
                default:
                    this.ThisMethodIsDisabled();
            };
        }

        private function OnGroupPage(_arg_1:AWEvent):void
        {
            var _local_2:ClientConfig;
            GoogleAnalyticsClient.Instance.trackPageview("/group_page");
            switch (this._config.CurrentPlatformId)
            {
                case ClientConfig.VKONTAKTE:
                case ClientConfig.VKONTAKTE_TEST:
                case ClientConfig.MAILRU:
                case ClientConfig.MAILRU_TEST:
                case ClientConfig.WEB:
                case ClientConfig.WEB_TEST:
                case ClientConfig.ODNOKLASSNIKI:
                case ClientConfig.ODNOKLASSNIKI_TEST:
                case ClientConfig.STANDALONE:
                case ClientConfig.DEBUG:
                case ClientConfig.TEST:
                case ClientConfig.FOTOSTRANA:
                case ClientConfig.FOTOSTRANA_TEST:
                case ClientConfig.FACEBOOK:
                case ClientConfig.FACEBOOK_TEST:
                    if (fromPortal)
                    {
                        _local_2 = new ClientConfig(ClientConfig.WEB);
                        navigateToURL(new URLRequest(_local_2.GetAppGroupURL));
                    }
                    else
                    {
                        navigateToURL(new URLRequest(this._config.GetAppGroupURL));
                    };
                    return;
                default:
                    this.ThisMethodIsDisabled();
            };
        }

        private function OnAllItemsProgress(_arg_1:BulkProgressEvent):void
        {
            this._loadingWindow.UpdateProgress(_arg_1.itemsLoaded, _arg_1.itemsTotal);
        }

        public function IsLoading():Boolean
        {
            return (!(this._loadingWindow.parent == null));
        }

        private function OnActorDisplayEvent(_arg_1:ActorDisplayEvent):void
        {
            if (!((_arg_1.Character.characterId - 110000000) >= 1000))
            {
                this._chatHUD.GetRightBar.RevalidateUsers(this._gameClient.ActorList);
            };
        }

        private function OnActorViewIdEvent(_arg_1:ActorViewIdEvent):void
        {
            var _local_2:ItemsResourceLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            _arg_1.Character.viewWeaponId = _local_2.GetItemView(_arg_1.Character.viewWeapon);
            _arg_1.Character.viewShieldId = _local_2.GetItemView(_arg_1.Character.viewShield);
        }

        private function OnRepairListResponse(_arg_1:DurabilityEvent):void
        {
            if (this._repairWindow)
            {
                this._repairWindow.dispose();
            };
            this._repairWindow = new RepairWindow(_arg_1.Currency, _arg_1.RepairList, _arg_1.TotalPrice);
        }

        private function OnRepairTotalPriceResponse(_arg_1:DurabilityEvent):void
        {
            if (((this._repairWindow) && (this._repairWindow.isShowing())))
            {
                this._repairWindow.UpdateTotalRepairPrice(_arg_1.TotalPrice);
            };
        }

        private function OnRepairItemResponse(_arg_1:DurabilityEvent):void
        {
            if (((this._repairWindow) && (this._repairWindow.isShowing())))
            {
                this._repairWindow.RepairItem(_arg_1.Item);
            };
            this.RevalidateDurabilityEquipment();
        }

        private function OnLowDurabilityResponse(_arg_1:DurabilityEvent):void
        {
            var _local_2:int;
            var _local_3:Number = ((_arg_1.Durability * 100) / _arg_1.MaxDurability);
            if (_local_3 <= 5)
            {
                _local_2 = 2;
            }
            else
            {
                if (_local_3 <= 30)
                {
                    _local_2 = 1;
                };
            };
            if (((_local_2 > 0) && (!(alldurability == _local_2))))
            {
                this.RevalidateDurabilityEquipment();
            };
        }

        public function RevalidateDurabilityEquipment():void
        {
            var _local_2:InventoryItem;
            var _local_3:ItemData;
            var _local_4:Number;
            var _local_5:Number;
            var _local_6:Number;
            var _local_1:CharacterInfo = this.LocalGameClient.ActorList.GetPlayer();
            alldurability = 0;
            for each (_local_3 in _local_1.Items)
            {
                if (((_local_3.Equip > 0) && ((_local_3.Type == ItemData.IT_ARMOR) || (_local_3.Type == ItemData.IT_WEAPON))))
                {
                    _local_2 = new InventoryItem(_local_3);
                    _local_4 = _local_2.GetMaxDurability();
                    if (_local_4 > 0)
                    {
                        _local_5 = _local_2.GetDurability(_local_4);
                        _local_6 = ((_local_5 * 100) / _local_4);
                        if (_local_6 <= 5)
                        {
                            alldurability = 2;
                        }
                        else
                        {
                            if (((_local_6 <= 30) && (alldurability < 2)))
                            {
                                alldurability = 1;
                            };
                        };
                    };
                };
            };
            if (alldurability == 1)
            {
                StatusManager.Instance.OnStatusItem(_local_1.clothesColor, ActorActiveStatusEvent.SI_DURABILITY30, 0);
                StatusManager.Instance.OffStatusItem(ActorActiveStatusEvent.SI_DURABILITY5);
            }
            else
            {
                if (alldurability == 2)
                {
                    StatusManager.Instance.OnStatusItem(_local_1.clothesColor, ActorActiveStatusEvent.SI_DURABILITY5, 0);
                    StatusManager.Instance.OffStatusItem(ActorActiveStatusEvent.SI_DURABILITY30);
                }
                else
                {
                    StatusManager.Instance.OffStatusItem(ActorActiveStatusEvent.SI_DURABILITY5);
                    StatusManager.Instance.OffStatusItem(ActorActiveStatusEvent.SI_DURABILITY30);
                };
            };
        }

        private function OnApplicationClosed(_arg_1:Event):void
        {
            this._gameClient.SendQuit();
        }

        private function OnUserReportError(_arg_1:AWEvent):void
        {
            var _local_2:ClientConfig;
            if (((((!(fromPortal)) && (!(this._socialWindow == null))) && (!(this._socialWindow.SocialPanel == null))) && (this._socialWindow.SocialPanel.Data.loggedIn)))
            {
                this._socialWindow.SocialPanel.ShowSupportWindow();
            }
            else
            {
                if (fromPortal)
                {
                    _local_2 = new ClientConfig(ClientConfig.WEB);
                    navigateToURL(new URLRequest((_local_2.GetAppGroupURL + "/support/#content")));
                }
                else
                {
                    if (((this._config.CurrentPlatformId == ClientConfig.WEB) || (this._config.CurrentPlatformId == ClientConfig.STANDALONE)))
                    {
                        navigateToURL(new URLRequest((this._config.GetAppGroupURL + "/support/#content")));
                    };
                };
            };
        }

        private function OnChangelog(_arg_1:AWEvent):void
        {
            new UpdateWindow();
        }

        private function OnLogout(_arg_1:AWEvent):void
        {
            this._gameClient.SendQuitToCharSelect();
        }

        private function OnBook(_arg_1:AWEvent):void
        {
            this.ShowBookWindow();
        }

        private function OnCastlesInfo(_arg_1:AWEvent):void
        {
            this._gameClient.SendGetCastlesInfoEx();
        }

        public function CreateDuel(_arg_1:int):void
        {
            GoogleAnalyticsClient.Instance.trackPageview((("/" + gameServerName) + "/duel/create"));
            this.SetShortcutsEnabled(true);
            if (_arg_1 > 1)
            {
                this.LocalGameClient.SendDuelCreate(_arg_1);
                return;
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_DUEL_NAME_ERROR_TITLE, ClientApplication.Localization.DLG_DUEL_NAME_ERROR_MSG, null, null, true, new AttachIcon("AchtungIcon")));
        }

        private function FirstUpdate():void
        {
        }

        private function OnMouseClick(_arg_1:MouseEvent):void
        {
            if (((!(_arg_1.target == this)) && (!(_arg_1.target == this.ChatHUD.GetNotificationChat()))))
            {
                return;
            };
            if (!this._limitClick)
            {
                return;
            };
            CharacterStorage.Instance.OnMouseClick(_arg_1);
            this._limitClick = false;
        }

        private function OnMouseMove(_arg_1:MouseEvent):void
        {
            if (((!(_arg_1.target == this)) && (!(_arg_1.target == this.ChatHUD.GetNotificationChat()))))
            {
                return;
            };
            CharacterStorage.Instance.OnMouseMove(_arg_1);
        }

        private function OnCharacterButtonPressed(_arg_1:MouseEvent):void
        {
            if (this.IsPlayerTalkingWithNPC)
            {
                return;
            };
            if (this._characterInventory.isShowing())
            {
                this._characterInventory.dispose();
            }
            else
            {
                this._characterInventory.RevalidateEquipment();
                this._characterInventory.RevalidateItems();
                this._characterInventory.show();
            };
        }

        private function OnStatIncreased(_arg_1:CharacterStatsButtonEvent):void
        {
            this._gameClient.SendAddStatPoints(_arg_1.Stat, 1);
            HelpManager.Instance.AddStatPressed();
        }

        private function OnSkillsButtonPressed(_arg_1:MouseEvent):void
        {
            var _local_3:SkillsResourceLibrary;
            if (this.IsPlayerTalkingWithNPC)
            {
                return;
            };
            var _local_2:CharacterInfo = this.LocalGameClient.ActorList.GetPlayer();
            if (_local_2.jobId == 0)
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.NO_JOB_TITLE, ClientApplication.Localization.NO_JOB_MESSAGE, null, null, true, new AttachIcon("AchtungIcon")));
            }
            else
            {
                if (this._skills.isShowing())
                {
                    this._skills.dispose();
                    return;
                };
                if (this._skillsAdvanced.isShowing())
                {
                    this._skillsAdvanced.dispose();
                    return;
                };
                _local_3 = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
                if (((_local_3) && (_local_3.JobIsAdvanced(_local_2.jobId))))
                {
                    this._skillsAdvanced.RevalidateSkills(_local_2.clothesColor, _local_2.jobId);
                    this._skillsAdvanced.show();
                }
                else
                {
                    this._skills.RevalidateSkills(_local_2.clothesColor, _local_2.jobId);
                    this._skills.show();
                };
            };
        }

        public function ShowSkillsWindow():void
        {
            var _local_1:CharacterInfo = this.LocalGameClient.ActorList.GetPlayer();
            var _local_2:SkillsResourceLibrary = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
            if (((_local_2) && (_local_2.JobIsAdvanced(_local_1.jobId))))
            {
                if (!this._skillsAdvanced)
                {
                    this._skillsAdvanced = new AdvancedSkillWindow();
                };
                this._skillsAdvanced.show();
            }
            else
            {
                if (!this._skills)
                {
                    this._skills = new SkillWindow();
                };
                this._skills.show();
            };
        }

        private function OnGuildButtonPressed(_arg_1:MouseEvent):void
        {
            var _local_3:String;
            if (this.IsPlayerTalkingWithNPC)
            {
                return;
            };
            var _local_2:CharacterInfo = this.LocalGameClient.ActorList.GetPlayer();
            if (_local_2.Guild != null)
            {
                if (this._guildWindow == null)
                {
                    this._guildWindow = new GuildWindow();
                };
                if (this._guildWindow.isShowing())
                {
                    this._guildWindow.dispose();
                }
                else
                {
                    this.LocalGameClient.SendGuildRequestInfo(0);
                    if (_local_2.Guild.IsGuildMaster)
                    {
                        this.LocalGameClient.SendGuildRequestInfo(3);
                    };
                    this._guildWindow.show();
                };
            }
            else
            {
                this.SetShortcutsEnabled(false);
                if (Character.IsBabyClass(_local_2.jobId))
                {
                    if (_local_2.clothesColor > 0)
                    {
                        _local_3 = Localization.DLG_GUILD_NAME_MSG_TURON;
                    }
                    else
                    {
                        _local_3 = Localization.DLG_GUILD_NAME_MSG_ORC;
                    };
                }
                else
                {
                    if (_local_2.clothesColor > 0)
                    {
                        _local_3 = Localization.DLG_GUILD_NAME_MSG_UNDEAD;
                    }
                    else
                    {
                        _local_3 = Localization.DLG_GUILD_NAME_MSG_HUMAN;
                    };
                };
                new CustomOptionPane(JOptionPane.showInputDialog(Localization.DLG_GUILD_NAME_TITLE, _local_3, this.OnCreateGuild));
            };
        }

        public function ShowGuildSkillsWindow():void
        {
            var _local_1:CharacterInfo = this.LocalGameClient.ActorList.GetPlayer();
            if (_local_1.Guild != null)
            {
                if (_local_1.Guild.IsGuildMaster)
                {
                    if (this._guildSkillsWindow.isShowing())
                    {
                        this._guildSkillsWindow.dispose();
                    }
                    else
                    {
                        this._guildSkillsWindow.RevalidateSkills(_local_1.clothesColor, 1000);
                        this.LocalGameClient.SendGuildRequestInfo(3);
                        this._guildSkillsWindow.show();
                    };
                };
            };
        }

        private function OnCreateGuild(_arg_1:String):void
        {
            var _local_2:RegExp;
            this.SetShortcutsEnabled(true);
            if (_arg_1 == null)
            {
                return;
            };
            _local_2 = new RegExp(ClientApplication.Localization.GUILD_NAME_PATTERN);
            var _local_3:Array = _arg_1.match(_local_2);
            if (((_local_3) && (_local_3[0] === _arg_1)))
            {
                this.LocalGameClient.SendGuildCreate(_arg_1);
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_GUILD_NAME_ERROR_TITLE, ClientApplication.Localization.DLG_GUILD_NAME_ERROR_MSG, null, null, true, new AttachIcon("AchtungIcon")));
            };
        }

        private function get storageWindow():StorageWindow
        {
            if (this._storageWindow == null)
            {
                this._storageWindow = new StorageWindow();
            };
            return (this._storageWindow);
        }

        private function OnStorageOpened(_arg_1:StorageEvent):void
        {
            this.storageWindow.RevalidateStatusBar();
            if (((this._stashAuctionWindow) && (this._stashAuctionWindow.isShowing())))
            {
                this._stashAuctionWindow.dispose();
                this._stashAuctionWindow = null;
            };
            if (((this._premiumShopWindow) && (this._premiumShopWindow.isShowing())))
            {
                this._premiumShopWindow.dispose();
                this._premiumShopWindow = null;
            };
            if (((this._shopWindow) && (this._shopWindow.isShowing())))
            {
                this._shopWindow.dispose();
                this._shopWindow = null;
            };
            if (((this._storeWindow) && (this._storeWindow.isShowing())))
            {
                this._storeWindow.dispose();
                this._storeWindow = null;
            };
            if (this._cartWindow)
            {
                this._cartWindow.VenderClose();
                if (this._cartWindow.isShowing())
                {
                    this._cartWindow.dispose();
                    this._cartWindow = null;
                };
            };
            this.storageWindow.show();
        }

        private function OnStorageUpdated(_arg_1:StorageEvent):void
        {
            this.storageWindow.RevalidateItems();
        }

        private function OnStorageClosed(_arg_1:StorageEvent):void
        {
            if (this._storageWindow)
            {
                this._storageWindow.dispose();
                this._storageWindow = null;
            };
        }

        public function get IsCartWindowActive():Boolean
        {
            if (this._cartWindow == null)
            {
                return (false);
            };
            return (this._cartWindow.isShowing());
        }

        private function OnCartUpdated(_arg_1:CartEvent):void
        {
            if (this._cartWindow != null)
            {
                this._cartWindow.RevalidateItems();
            };
        }

        private function OnCartStatusUpdated(_arg_1:CartEvent):void
        {
            if (this._cartWindow != null)
            {
                this._cartWindow.RevalidateStatusBar();
            };
        }

        private function OnNpcTalk(_arg_1:NpcTalkEvent):void
        {
            if (((!(this._npcTalkDialog == null)) && (!(this._npcTalkDialog.NPCId == _arg_1.CharacterId))))
            {
                this._npcTalkDialog.dispose();
                this._npcTalkDialog = null;
            };
            if (this._npcTalkDialog == null)
            {
                this._npcTalkDialog = new NPCDialog(_arg_1.CharacterId);
                this._npcTalkDialog.addEventListener(NPCDialog.ON_NEXT_PRESSED, this.OnNpcTalkNextPressed, false, 0, true);
                this._npcTalkDialog.addEventListener(NPCDialog.ON_NPC_DIALOG_CANCELED, this.OnNpcAnswerCancel, false, 0, true);
                this._npcTalkDialog.addEventListener(NPCDialog.ON_NPC_DIALOG_ALL_CANCELED, this.OnNpcAnswerCancel, false, 0, true);
            };
            if (((this._npcLocationWindow) && (this._npcLocationWindow.isShowing())))
            {
                this._npcLocationWindow.dispose();
            };
            this._npcTalkDialog.AddTextMessage(_arg_1.Message);
        }

        public function OpenNPCLocationWindow():void
        {
            this._npcLocationWindow = ((this._npcLocationWindow) || (new NPCLocationWindow()));
            if (this._npcLocationWindow.isShowing())
            {
                this._npcLocationWindow.dispose();
            }
            else
            {
                this._npcLocationWindow.show();
            };
        }

        private function OnNpcHide(_arg_1:DisplayNpcImage):void
        {
            if (this._npcTalkDialog)
            {
                this._gameClient.SendTalkCancel(this._npcTalkDialog.NPCId);
                this._npcTalkDialog.ClearTextMessage();
                this._npcTalkDialog.CloseWithAnimation();
            };
        }

        private function OnNpcHideAndClean(_arg_1:DisplayNpcImage):void
        {
            if (this._npcTalkDialog)
            {
                this._gameClient.SendTalkCancel(this._npcTalkDialog.NPCId);
                this._npcTalkDialog.CloseWithAnimation();
                this._npcTalkDialog = null;
            };
        }

        private function OnNpcTalkContinue(_arg_1:NpcTalkEvent):void
        {
            if (this._npcTalkDialog != null)
            {
                this._npcTalkDialog.EnableAnswerPanel(false);
                this._npcTalkDialog.ShowWithAnimation();
            };
        }

        private function OnNpcTalkClose(_arg_1:NpcTalkEvent):void
        {
            if (this._npcTalkDialog != null)
            {
                this._npcTalkDialog.EnableTalkPanel(true);
                this._npcTalkDialog.EnableAnswerPanel(false);
                this._npcTalkDialog.ShowWithAnimation();
            };
            this.LocalGameClient.SendUpdateQuests();
        }

        private function OnNpcTalkNextPressed(_arg_1:Event):void
        {
            this._npcTalkDialog.EnableTalkPanel(false);
            this._gameClient.SendTalkContinue(this._npcTalkDialog.NPCId);
        }

        private function OnNpcTalkResponses(_arg_1:NpcTalkEvent):void
        {
            if (this._npcTalkDialog != null)
            {
                this._npcTalkDialog.EnableTalkPanel(false);
                this._npcTalkDialog.EnableAnswerPanel(true);
                this._npcTalkDialog.SetAnswers(_arg_1.Answers);
                this._npcTalkDialog.ShowWithAnimation();
                this._npcTalkDialog.addEventListener(NPCDialog.ON_NPC_TALK_OK_PRESSED, this.OnNpcAnswerOk, false, 0, true);
            };
        }

        private function OnNpcInput(_arg_1:NpcTalkEvent):void
        {
            this.SetShortcutsEnabled(false);
            this._npcTalkDialog.EnableAnswerPanel(true);
            if (_arg_1.type == NpcTalkEvent.ON_NPC_INPUT_STRING)
            {
                this._npcTalkDialog.InputValue(false);
            }
            else
            {
                if (_arg_1.type == NpcTalkEvent.ON_NPC_INPUT_NUMBER)
                {
                    this._npcTalkDialog.InputValue(true);
                };
            };
            this._npcTalkDialog.addEventListener(NPCDialog.ON_NPC_TALK_INPUT_PRESSED, this.OnNpcInputEntered, false, 0, true);
            this._npcTalkDialog.addEventListener(NPCDialog.ON_NPC_TALK_INPUT_CANCELED, this.OnNpcAnswerCancel, false, 0, true);
        }

        private function OnNpcInputEntered(_arg_1:Event):void
        {
            var _local_2:int;
            var _local_3:String;
            if (this._npcTalkDialog)
            {
                this.SetShortcutsEnabled(true);
                if (this._npcTalkDialog.IsNumberInput)
                {
                    _local_2 = this._npcTalkDialog.GetInputNumber();
                    this._gameClient.SendTalkNumber(this._npcTalkDialog.NPCId, _local_2);
                }
                else
                {
                    _local_3 = this._npcTalkDialog.GetInputString();
                    if (_local_3 != null)
                    {
                        this._gameClient.SendTalkText(this._npcTalkDialog.NPCId, HtmlText.fixReservedSymbols(_local_3));
                    }
                    else
                    {
                        this._gameClient.SendTalkCancel2(this._npcTalkDialog.NPCId);
                    };
                };
            };
        }

        private function OnNpcAnswerOk(_arg_1:Event):void
        {
            var _local_2:int = this._npcTalkDialog.GetSelectedIndex();
            this._gameClient.SendTalkResponse(this._npcTalkDialog.NPCId, _local_2);
        }

        private function OnNpcAnswerCancel(_arg_1:Event):void
        {
            if (_arg_1.type == NPCDialog.ON_NPC_DIALOG_CANCELED)
            {
                this._gameClient.SendTalkCancel(this._npcTalkDialog.NPCId);
            }
            else
            {
                if (_arg_1.type == NPCDialog.ON_NPC_TALK_INPUT_CANCELED)
                {
                    if (this._npcTalkDialog)
                    {
                        this.SetShortcutsEnabled(true);
                        if (this._npcTalkDialog.IsNumberInput)
                        {
                            this._gameClient.SendTalkNumber(this._npcTalkDialog.NPCId, -1);
                        }
                        else
                        {
                            this._gameClient.SendTalkCancel2(this._npcTalkDialog.NPCId);
                        };
                    };
                }
                else
                {
                    if (_arg_1.type == NPCDialog.ON_NPC_DIALOG_ALL_CANCELED)
                    {
                        this._gameClient.SendTalkCancel(this._npcTalkDialog.NPCId);
                    };
                };
            };
        }

        public function get IsBusyMode():Boolean
        {
            return ((((!(this._npcTalkDialog == null)) && (this._npcTalkDialog.isShowing())) || ((!(this._shopWindow == null)) && (this._shopWindow.isShowing()))) || ((!(this._storeWindow == null)) && (this._storeWindow.isShowing())));
        }

        private function OnCutin2(_arg_1:Cutin2Event):void
        {
            var _local_2:CharacterInfo;
            var _local_3:int;
            var _local_4:Boolean;
            var _local_5:String;
            var _local_6:WelcomeWindow;
            switch (_arg_1.Command)
            {
                case Cutin2Event.COMMAND_DISPLAY_WELCOME_IMAGE:
                    _local_2 = this.LocalGameClient.ActorList.GetPlayer();
                    _local_3 = Character.GetFraction(_local_2.jobId, _local_2.clothesColor);
                    _local_4 = Character.IsBabyClass(_local_2.jobId);
                    _local_5 = ((_local_3) ? ((_local_4) ? "O" : "U") : ((_local_4) ? "T" : "H"));
                    _local_6 = new WelcomeWindow(_local_5);
                    _local_6.show();
                    return;
                case Cutin2Event.COMMAND_SHOW_GUIDE_BUTTON:
                    this._topHUD.GetTopHUD._mapPanel._guideButton.visible = true;
                    return;
                case Cutin2Event.COMMAND_SHOW_ARENA_BUTTON:
                    this._topHUD.InitArena();
                    return;
                case Cutin2Event.COMMAND_HIDE_ARENA_BUTTON:
                    this._topHUD._arenaPanel.visible = false;
                    return;
                case Cutin2Event.COMMAND_SHOW_CLOUD_BUTTON:
                    return;
                case Cutin2Event.COMMAND_OPEN_CART:
                    ClientApplication.Instance.ShowCart();
                    return;
                case Cutin2Event.COMMAND_OPEN_NEWS:
                    new UpdateWindow();
                    return;
            };
        }

        private function OnCutin3(_arg_1:Cutin3Event):void
        {
            var _local_2:Array;
            var _local_3:String;
            var _local_4:String;
            var _local_5:String;
            var _local_6:Number;
            switch (_arg_1.Command)
            {
                case Cutin3Event.COMMAND_UPDATE_QUESTS:
                    this._gameClient.SendUpdateQuests();
                    return;
                case Cutin3Event.COMMAND_SHOW_QUEST_ACCEPT:
                    if (this._npcTalkDialog)
                    {
                        this._npcTalkDialog.SelectStateDialog(NPCDialog.STATE_NPC_QUEST_ACCEPT, int(_arg_1.Value));
                    };
                    return;
                case Cutin3Event.COMMAND_SHOW_QUEST_REWARD:
                    if (this._npcTalkDialog)
                    {
                        this._npcTalkDialog.SelectStateDialog(NPCDialog.STATE_NPC_QUEST_REWARD, int(_arg_1.Value));
                    };
                    return;
                case Cutin3Event.COMMAND_LOAD_ICON_TUTORIAL:
                    ClientApplication.Instance.TopHUD.GetTutorialPanel().SetTutorial(int(_arg_1.Value), TutorialPanel.LOAD_TUTORIAL);
                    return;
                case Cutin3Event.COMMAND_ACCEPT_ICON_TUTORIAL:
                    ClientApplication.Instance.TopHUD.GetTutorialPanel().SetTutorial(int(_arg_1.Value), TutorialPanel.ACCEPT_TUTORIAL);
                    return;
                case Cutin3Event.COMMAND_DELETE_ICON_TUTORIAL:
                    ClientApplication.Instance.TopHUD.GetTutorialPanel().SetTutorial(int(_arg_1.Value), TutorialPanel.CLEAR_TUTORIAL);
                    return;
                case Cutin3Event.COMMAND_SHOW_TUTORIAL_WINDOW:
                    if (((!(this._levelupWindow == null)) && (this._levelupWindow.isShowing())))
                    {
                        openTutorialAfterLevelup = int(_arg_1.Value);
                    }
                    else
                    {
                        ClientApplication.Instance.TopHUD.GetTutorialPanel().ShowTutorialWindow(int(_arg_1.Value));
                    };
                    return;
                case Cutin3Event.COMMAND_SHOW_ARROW_TUTORIAL:
                    HelpManager.Instance.ShowHelper(int(_arg_1.Value));
                    return;
                case Cutin3Event.COMMAND_SHOW_MOVE_TO_POINT:
                    _local_2 = _arg_1.Value.split(",");
                    if (_local_2.length > 1)
                    {
                        HelpManager.Instance.ShowHelper(HelpManager.MOVE_TO_MAP_POINT_HELPER, {
                            "x":(_local_2[0] * CharacterStorage.CELL_SIZE),
                            "y":(RenderSystem.Instance.MainCamera.MaxHeight - (_local_2[1] * CharacterStorage.CELL_SIZE))
                        });
                    };
                    return;
                case Cutin3Event.COMMAND_CLOSE_ALL_WINDOW:
                    ClientApplication.Instance.CloseAllWindows();
                    return;
                case Cutin3Event.COMMAND_SEND_STATISTIC:
                    _local_2 = _arg_1.Value.split(":");
                    if (_local_2.length > 1)
                    {
                        _local_3 = _local_2[0];
                        _local_4 = _local_2[1];
                        StatisticManager.Instance.SendEventValue(_local_3, _local_4);
                    }
                    else
                    {
                        StatisticManager.Instance.SendEvent(_arg_1.Value);
                    };
                    return;
                case Cutin3Event.COMMAND_SEND_STATISTIC_NUM:
                    _local_2 = _arg_1.Value.split(":");
                    if (_local_2.length > 1)
                    {
                        _local_5 = _local_2[0];
                        _local_6 = parseInt(_local_2[1]);
                        StatisticManager.Instance.SendEventNum(_local_5, _local_6);
                    }
                    else
                    {
                        StatisticManager.Instance.SendEvent(_arg_1.Value);
                    };
                    return;
                case Cutin3Event.COMMAND_SHOW_ARROW_PARAM_TUTORIAL:
                    _local_2 = _arg_1.Value.split(",");
                    if (_local_2.length > 1)
                    {
                        HelpManager.Instance.ShowHelper(_local_2[0], _local_2);
                    };
                    return;
                case Cutin3Event.COMMAND_SHOW_LEVELUP_WINDOW:
                    if (((!(ClientApplication.Instance.TopHUD.GetTutorialPanel().GetTutorialWindow() == null)) && (ClientApplication.Instance.TopHUD.GetTutorialPanel().GetTutorialWindow().isShowing())))
                    {
                        openLevelupAfterTutorial = int(_arg_1.Value);
                    }
                    else
                    {
                        ClientApplication.Instance.ShowLevelUpWindow(int(_arg_1.Value));
                    };
                    return;
                case Cutin3Event.COMMAND_GIFT2_COUNTER:
                    gift2Counter = int(_arg_1.Value);
                    return;
            };
        }

        private function OnNpcStoreBegin(_arg_1:StoreEvent):void
        {
            this._gameClient.SendGetStoreList();
            if (((_arg_1.IsNewStore) && (!(this._storeWindow == null))))
            {
                this._storeWindow.dispose();
                this._storeWindow = null;
            };
            this._storeWindow = ((this._storeWindow) || (new StoreWindow()));
            if (!this._storeWindow.isShowing())
            {
                this._storeWindow.show();
            };
        }

        private function OnNpcBuyList(_arg_1:StoreEvent):void
        {
            if (this._storeWindow != null)
            {
                if (((this._premiumShopWindow) && (this._premiumShopWindow.isShowing())))
                {
                    this._premiumShopWindow.dispose();
                    this._premiumShopWindow = null;
                };
                if (this._cartWindow)
                {
                    this._cartWindow.VenderClose();
                    if (this._cartWindow.isShowing())
                    {
                        this._cartWindow.dispose();
                        this._cartWindow = null;
                    };
                };
                if (((this._shopWindow) && (this._shopWindow.isShowing())))
                {
                    this._shopWindow.dispose();
                    this._shopWindow = null;
                };
                this._storeWindow.LoadBuyItems(_arg_1.Items);
                this._storeWindow.LoadSellItems(this._gameClient.ActorList.GetPlayer());
                if (!this._storeWindow.isShowing())
                {
                    this._storeWindow.show();
                };
            };
        }

        private function OnVenderBuyList(_arg_1:StoreEvent):void
        {
            if (this._shopWindow == null)
            {
                this._shopWindow = new ShopWindow();
            };
            this._shopWindow.LoadBuyItems(_arg_1.Items);
            this._shopWindow.LoadSellItems(this._gameClient.ActorList.GetPlayer());
            if (((this._premiumShopWindow) && (this._premiumShopWindow.isShowing())))
            {
                this._premiumShopWindow.dispose();
                this._premiumShopWindow = null;
            };
            if (((this._storageWindow) && (this._storageWindow.isShowing())))
            {
                this._storageWindow.dispose();
                this._storageWindow = null;
            };
            if (((this._storeWindow) && (this._storeWindow.isShowing())))
            {
                this._storeWindow.dispose();
                this._storeWindow = null;
            };
            if (this._cartWindow)
            {
                this._cartWindow.VenderClose();
                if (this._cartWindow.isShowing())
                {
                    this._cartWindow.dispose();
                    this._cartWindow = null;
                };
            };
            this._shopWindow.show();
        }

        private function OnVenderClosed(_arg_1:StoreEvent):void
        {
            if (this._shopWindow != null)
            {
                if (this._shopWindow.isShowing())
                {
                    this._shopWindow.dispose();
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.ERR_CRITICAL_ERROR_TITLE, ClientApplication.Localization.ERR_VENDER_CLOSED, null, null, true, new AttachIcon("AchtungIcon")));
                };
                this._shopWindow = null;
            };
        }

        private function OnVenderOpened(_arg_1:StoreEvent):void
        {
            if (this._characterInventory != null)
            {
                this._characterInventory.OpenVenderShop();
            };
        }

        private function OnVenderStarted(_arg_1:StoreEvent):void
        {
            if (this._cartWindow != null)
            {
                this._cartWindow.VenderCreate();
            };
        }

        public function CloseVenderShop():void
        {
            var _local_1:Boolean;
            if (this._shopWindow)
            {
                _local_1 = this._shopWindow.isShowing();
            };
            if (_local_1)
            {
                this._shopWindow.dispose();
                this._shopWindow = null;
            };
        }

        public function SetAnaloguesId(_arg_1:String):void
        {
            this._loadAnaloguesOfId = _arg_1;
        }

        public function ShowAuctionWindow():void
        {
            if (((this._stashAuctionWindow) && (this._stashAuctionWindow.isShowing())))
            {
                this._stashAuctionWindow.dispose();
                this._stashAuctionWindow = null;
            }
            else
            {
                if (this._stashAuctionWindow == null)
                {
                    this._stashAuctionWindow = new StashAuctionWindow();
                };
                this._stashAuctionWindow.ChangePanelToAuction();
                this._stashAuctionWindow.show();
            };
        }

        public function ShowPritonWindow():void
        {
            if (((this._stashAuctionWindow) && (this._stashAuctionWindow.isShowing())))
            {
                this._stashAuctionWindow.dispose();
                this._stashAuctionWindow = null;
            }
            else
            {
                if (this._stashAuctionWindow == null)
                {
                    this._stashAuctionWindow = new StashAuctionWindow();
                };
                this._stashAuctionWindow.ChangePanelToStash();
                this._stashAuctionWindow.show();
            };
        }

        private function OnCashStoreBuyList(_arg_1:StoreEvent):void
        {
            var _local_2:InventoryStoreItem;
            var _local_3:InventoryItemPopup;
            var _local_4:int;
            var _local_5:int;
            if (_arg_1.ShopType != ItemData.CASHSHOP)
            {
                if (this._kafraShopWindow == null)
                {
                    this._kafraShopWindow = new KafraShopWindow();
                };
                this._kafraShopWindow.LoadBuyItems(_arg_1.Items);
                this._kafraShopWindow.show();
            };
            if (((this._storeWindow) && (this._storeWindow.isShowing())))
            {
                this._storeWindow.dispose();
                this._storeWindow = null;
            };
            if (this._cartWindow)
            {
                this._cartWindow.VenderClose();
                if (this._cartWindow.isShowing())
                {
                    this._cartWindow.dispose();
                    this._cartWindow = null;
                };
            };
            if (((this._storageWindow) && (this._storageWindow.isShowing())))
            {
                this._storageWindow.dispose();
                this._storageWindow = null;
            };
            if (((this._shopWindow) && (this._shopWindow.isShowing())))
            {
                this._shopWindow.dispose();
                this._shopWindow = null;
            };
            this._bottomHUD.SetGoldLabel(this.LocalGameClient.ActorList.GetPlayer().cashPoints);
            if (this._currentBannerItem != null)
            {
                _local_2 = new InventoryStoreItem(this._currentBannerItem);
                _local_3 = new InventoryItemPopup(((this._currentBannerItem.Identified == 1) ? _local_2.Name : ClientApplication.Localization.UNKNOWN_ITEM), _local_2);
                _local_4 = Math.min(stage.mouseX, (RenderSystem.Instance.ScreenWidth - _local_3.getWidth()));
                _local_5 = Math.min(stage.mouseY, (RenderSystem.Instance.ScreenHeight - _local_3.getHeight()));
                _local_3.setLocationXY(_local_4, _local_5);
                _local_3.show();
                this._currentBannerItem = null;
            };
        }

        private function OnPremiumBuyList(_arg_1:StoreEvent):void
        {
            this._premiumShopWindow = ((this._premiumShopWindow) || (new PremiumShopWindow()));
            this._premiumShopWindow.ShowPremiumShop(_arg_1.ShopType);
            if (this._loadAnaloguesOfId)
            {
                this._premiumShopWindow.loadAnalogues(this._loadAnaloguesOfId);
                this._loadAnaloguesOfId = null;
            };
        }

        public function TypePrivateMessageTemplate(_arg_1:String):void
        {
            this._chatHUD.GetLeftBar.PrivateChannel.TypeMessageTemplate(_arg_1);
            this._chatHUD.GetLeftBar.SetFocus(LeftChatBar.PRIVATE_CHANNEL);
        }

        public function OpenPayDialog(_arg_1:uint=1):void
        {
            if (!this.Config.IsPaymentsEnabled)
            {
                this.ThisMethodIsDisabled();
            }
            else
            {
                if (fromPortal == 1)
                {
                    this.BuyMoneyRequest(0);
                    new CustomOptionPane(JOptionPane.showMessageDialog(Localization.DLG_WARNING, Localization.BUY_DIALOG_WEB_REDIRECT_MESSAGE, null, null, true, new AttachIcon("ColIcon")));
                }
                else
                {
                    this._buyCahsWindow = ((this._buyCahsWindow) || (new NewBuyCashWindow()));
                    if (!this._buyCahsWindow.isShowing())
                    {
                        this._buyCahsWindow.ShowBuyCash(_arg_1);
                    };
                };
            };
        }

        public function BuyMoneyRequest(_arg_1:Number):void
        {
            var _local_2:ClientConfig;
            var _local_3:String;
            var _local_4:int;
            if (((((this._config.CurrentPlatformId == ClientConfig.WEB) || (this._config.CurrentPlatformId == ClientConfig.WEB_TEST)) || (this._config.CurrentPlatformId == ClientConfig.STANDALONE)) || (fromPortal)))
            {
                if (stage.displayState != StageDisplayState.NORMAL)
                {
                    this.OnFullScreenButtonPressed(null);
                };
                _local_4 = (this.LocalGameClient.CurrentCharId | (gameServerId << 30));
                if (fromPortal == 1)
                {
                    _local_2 = new ClientConfig(ClientConfig.WEB);
                    navigateToURL(new URLRequest(((_local_2.GetAppGroupURL + "/payment/?id=") + _local_4)));
                }
                else
                {
                    if (fromPortal == 2)
                    {
                        ExternalInterface.call("showPaymentDialog", _arg_1, _local_4);
                    }
                    else
                    {
                        navigateToURL(new URLRequest(((this._config.GetAppGroupURL + "/payment/?id=") + _local_4)));
                    };
                };
                return;
            };
            if (((!(this._socialWindow == null)) && (!(this._socialWindow.SocialPanel == null))))
            {
                if (this._socialWindow.SocialPanel.Data.loggedIn)
                {
                    _local_3 = "";
                    _local_4 = 0;
                    if (stage.displayState != StageDisplayState.NORMAL)
                    {
                        this.OnFullScreenButtonPressed(null);
                    };
                    switch (this._config.CurrentPlatformId)
                    {
                        case ClientConfig.VKONTAKTE:
                        case ClientConfig.VKONTAKTE_TEST:
                        case ClientConfig.ODNOKLASSNIKI:
                        case ClientConfig.ODNOKLASSNIKI_TEST:
                        case ClientConfig.FACEBOOK:
                        case ClientConfig.FACEBOOK_TEST:
                        case ClientConfig.MAILRU:
                        case ClientConfig.MAILRU_TEST:
                            _local_3 = ClientApplication.Localization.BUY_DIALOG_BASE_AMOUNT_GOLD;
                            _local_4 = (this.LocalGameClient.CurrentCharId | (gameServerId << 30));
                            if (((this._config.CurrentPlatformId == ClientConfig.MAILRU) || (this._config.CurrentPlatformId == ClientConfig.MAILRU_TEST)))
                            {
                                _arg_1 = (_arg_1 * 100);
                            };
                            this._socialWindow.SocialPanel.Data.SpendMoney.SendRequest(_arg_1, _local_3, _local_4);
                            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_BUY_MONEY_TITLE, ClientApplication.Localization.DLG_BUY_MONEY_MESSAGE, null, null, true, new AttachIcon("AchtungIcon")));
                            break;
                        case ClientConfig.FOTOSTRANA:
                        case ClientConfig.FOTOSTRANA_TEST:
                            _local_3 = (this.LocalGameClient.CurrentCharId | (gameServerId << 30)).toString();
                            this._socialWindow.SocialPanel.Data.SpendMoney.SendRequest(_arg_1, _local_3, _local_4);
                            break;
                    };
                }
                else
                {
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.ERR_CRITICAL_ERROR_TITLE, ClientApplication.Localization.ERR_PAYMENT_SERVER, null, null, true, new AttachIcon("StopIcon")));
                };
            };
        }

        public function ReOpenCashShop(delay:uint=1000):void
        {
            var timerId:uint;
            var Reopen:Function;
            if (((this._premiumShopWindow) && (this._premiumShopWindow.isShowing())))
            {
                Reopen = function ():void
                {
                    _premiumShopWindow.dispose();
                    _premiumShopWindow = null;
                    OpenCashShop();
                    clearTimeout(timerId);
                };
                timerId = setTimeout(Reopen, delay);
            };
        }

        public function OpenCashShop(_arg_1:ItemData=null):void
        {
            var _local_2:uint;
            var _local_3:Object;
            var _local_4:uint;
            var _local_5:Number;
            var _local_6:Object;
            if (!this.timeOnServerInited)
            {
                return;
            };
            this._currentBannerItem = _arg_1;
            if (((this._premiumShopWindow) && (this._premiumShopWindow.isShowing())))
            {
                this._premiumShopWindow.dispose();
                this._premiumShopWindow = null;
            }
            else
            {
                _local_2 = (this._lastFrameTickTime - this._openFrameTickTime);
                if (((_local_2) && (_local_2 < (OPEN_WINDOW_UPDATE_TIME * 3))))
                {
                    return;
                };
                if (this.IsTradeWindowActive)
                {
                    return;
                };
                _local_3 = this._dataLibrary.GetMapsData(this.LocalGameClient.MapName);
                if (((_local_3) && (_local_3["LockCashShop"] == 1)))
                {
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.CASH_SHOP_LOCK, null, null, true, new AttachIcon("StopIcon")));
                    return;
                };
                this._openFrameTickTime = this._lastFrameTickTime;
                GoogleAnalyticsClient.Instance.trackIngame("cash_shop");
                _local_4 = ItemData.CASHSHOP;
                if (this._dataLibrary)
                {
                    _local_5 = (ClientApplication.Instance.timeOnServer * 1000);
                    _local_6 = this._dataLibrary.GetActionData(_local_5);
                    if (((_local_6) && (_local_6.CashShop > 0)))
                    {
                        _local_4 = _local_6.CashShop;
                    };
                };
                this.LocalGameClient.SendOpenPremiumShop(_local_4);
            };
        }

        public function OpenKafraShop(_arg_1:ItemData=null):void
        {
            var _local_2:uint;
            if (!this.timeOnServerInited)
            {
                return;
            };
            this._currentBannerItem = _arg_1;
            if (((this._kafraShopWindow) && (this._kafraShopWindow.isShowing())))
            {
                this._kafraShopWindow.dispose();
                this._kafraShopWindow = null;
            }
            else
            {
                _local_2 = (this._lastFrameTickTime - this._openFrameTickTime);
                if (((_local_2) && (_local_2 < (OPEN_WINDOW_UPDATE_TIME * 3))))
                {
                    return;
                };
                this._openFrameTickTime = this._lastFrameTickTime;
                GoogleAnalyticsClient.Instance.trackIngame("kafra_shop");
                this.LocalGameClient.SendOpenKafraShop();
            };
        }

        private function OnCashStoreBuyResult(_arg_1:StoreEvent):void
        {
            var _local_3:int;
            var _local_2:CharacterInfo = this.LocalGameClient.ActorList.GetPlayer();
            switch (_arg_1.Result)
            {
                case 3:
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.CASH_SHOP_ERR_OVERWEIGHT, null, null, true, new AttachIcon("StopIcon")));
                    break;
                case 6:
                    this.OpenPayDialog();
                    break;
                case 0:
                case 8:
                    _local_3 = ((_arg_1.Result == 8) ? 1 : 0);
                    if (((this._stashAuctionWindow) && (this._stashAuctionWindow.isShowing())))
                    {
                        this._stashAuctionWindow.UpdateColsAmount(_local_2.cashPoints);
                    };
                    if (((this._premiumShopWindow) && (this._premiumShopWindow.isShowing())))
                    {
                        this._premiumShopWindow.UpdateGoldAmount(_local_2.cashPoints);
                    };
                    if (((this._laddersWindow) && (this._laddersWindow.isShowing())))
                    {
                        this._laddersWindow.UpdateKafraAmount(_local_2.kafraPoints);
                    };
                    if (((this._kafraShopWindow) && (this._kafraShopWindow.isShowing())))
                    {
                        this._kafraShopWindow.UpdateColsAmount(_local_2.kafraPoints);
                    };
                    if (((this._characterInventory == null) || ((!(this._characterInventory.isShowing())) && (_local_3 == ItemData.CASHSHOP))))
                    {
                        this._bottomHUD.BlinkCharacterStats(true);
                    };
                    break;
                default:
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.CASH_SHOP_ERR_BUY_NOT_POSSIBLE, null, null, true, new AttachIcon("StopIcon")));
            };
            this._bottomHUD.SetGoldLabel(_local_2.cashPoints);
        }

        private function OnPremiumBuyResult(_arg_1:StoreEvent):void
        {
            var _local_2:CharacterInfo = this.LocalGameClient.ActorList.GetPlayer();
            switch (_arg_1.Result)
            {
                case 3:
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.CASH_SHOP_ERR_OVERWEIGHT, null, null, true, new AttachIcon("StopIcon")));
                    break;
                case 6:
                    this.OpenPayDialog();
                    break;
                case 0:
                case 8:
                    if (((this._premiumShopWindow) && (this._premiumShopWindow.isShowing())))
                    {
                        this._premiumShopWindow.UpdateGoldAmount(_local_2.cashPoints);
                        this._premiumShopWindow.UpdateSilverAmount(_local_2.money);
                    };
                    break;
                default:
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.CASH_SHOP_ERR_BUY_NOT_POSSIBLE, null, null, true, new AttachIcon("StopIcon")));
            };
            this._bottomHUD.SetGoldLabel(_local_2.cashPoints);
            this._bottomHUD.SetMoneyLabel(_local_2.money);
        }

        private function OnQuestsUpdated(_arg_1:UpdateQuestsEvent):void
        {
            var _local_3:CharacterInfo;
            var _local_6:int;
            var _local_2:Boolean;
            if (this._questsWindow)
            {
                this._questsWindow.Revalidate();
                _local_2 = this._questsWindow.isShowing();
            };
            _local_3 = this.LocalGameClient.ActorList.GetPlayer();
            var _local_4:int = _local_3.GetQuestCount();
            if ((((_local_4 > 0) && (!(_local_2))) && (!(_local_4 == this._currentQuestsCount))))
            {
                this._topHUD.BlinkQuestButton(true);
            };
            CharacterStorage.Instance.UpdateNpcQuestInfo();
            this._topHUD.InitializeMiniMap();
            this.TopHUD.QuestsPanel.Update();
            var _local_5:int = HelpManager.Instance.GetRoadAtlas().QuestId;
            if (_local_5)
            {
                _local_6 = _local_3.QuestStates[_local_5];
                if (_local_6 == 100)
                {
                    HelpManager.Instance.GetRoadAtlas().Reset();
                };
            };
        }

        private function OnPlayerBuy(_arg_1:NpcStoreDealEvent):void
        {
            if (_arg_1.Reason != 0)
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.STORE_ERROR_TITLE, ClientApplication.Localization.STORE_RESULTS[_arg_1.Reason], null, null, true, new AttachIcon("StopIcon")));
            };
        }

        private function OnPlayerSell(_arg_1:NpcStoreDealEvent):void
        {
            if (_arg_1.Reason != 0)
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.STORE_ERROR_TITLE, ClientApplication.Localization.STORE_RESULTS[4], null, null, true, new AttachIcon("StopIcon")));
            };
        }

        private function OnFloorItemOverweight(_arg_1:FloorItemEvent):void
        {
            var _local_2:CharacterInfo = this.LocalGameClient.ActorList.GetPlayer();
            var _local_3:int = ((_arg_1.OverWeight) ? 2 : 3);
            new CustomOptionPane(JOptionPane.showMessageDialog(Localization.INVENTORY_FULL_TITLE, Localization.STORE_RESULTS[_local_3], null, null, true, new AttachIcon("AchtungIcon")));
        }

        private function OnPlayerItemsChanged(_arg_1:CharacterEvent):void
        {
            if (((this._characterInventory) && (this._characterInventory.isShowing())))
            {
                this._characterInventory.RevalidateItems(false, _arg_1.Item);
            };
            this._bottomHUD.RevalidateItems(null, _arg_1.Item);
            if (((this._refineWindow) && (this._refineWindow.isShowing())))
            {
                this._refineWindow.Revalidate(true);
            };
            if (((this._upgradeWindow) && (this._upgradeWindow.isShowing())))
            {
                this._upgradeWindow.Revalidate();
            };
            if (((this._stashAuctionWindow) && (this._stashAuctionWindow.isShowing())))
            {
                this._stashAuctionWindow.RevalidateVioletSellPanel();
                this._stashAuctionWindow.RevalidateCraftRunePanel();
            };
            if (this._shopWindow != null)
            {
                this.LocalGameClient.SendVenderConnect(this.LocalGameClient.VenderId);
            };
        }

        private function OnPlayerItemEquipped(_arg_1:CharacterEvent):void
        {
            this._characterInventory.RevalidateEquipment();
            if (((this._refineWindow) && (this._refineWindow.isShowing())))
            {
                this._refineWindow.Revalidate(false);
            };
            if (((this._upgradeWindow) && (this._upgradeWindow.isShowing())))
            {
                this._upgradeWindow.Revalidate();
            };
            if (((this._stashAuctionWindow) && (this._stashAuctionWindow.isShowing())))
            {
                this._stashAuctionWindow.RevalidateVioletSellPanel();
                this._stashAuctionWindow.RevalidateCraftRunePanel();
            };
            this.RevalidateDurabilityEquipment();
        }

        private function OnPlayerCantEquipItem(_arg_1:CharacterEvent):void
        {
            var _local_2:* = (ClientApplication.Localization.INVENTORY_CANT_EQUIP_TITLE + "\n");
            switch (_arg_1.Result)
            {
                case 3:
                    _local_2 = (_local_2 + ClientApplication.Localization.INVENTORY_CANT_EQUIP_RACE);
                    break;
                case 4:
                    _local_2 = (_local_2 + ClientApplication.Localization.INVENTORY_CANT_EQUIP_BUFF);
                    break;
                case 5:
                    _local_2 = (_local_2 + ClientApplication.Localization.INVENTORY_CANT_EQUIP_DURABILITY);
                    break;
                case 6:
                    _local_2 = (_local_2 + ClientApplication.Localization.INVENTORY_CANT_EQUIP_BASELEVEL);
                    break;
                case 7:
                    _local_2 = (_local_2 + ClientApplication.Localization.INVENTORY_CANT_EQUIP_RESTRICTION);
                    break;
                case 8:
                    _local_2 = (_local_2 + ClientApplication.Localization.INVENTORY_CANT_EQUIP_JOB);
                    break;
                case 0:
                case 1:
                case 2:
                default:
                    _local_2 = (_local_2 + ClientApplication.Localization.INVENTORY_CANT_EQUIP);
            };
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, _local_2, null, null, true, new AttachIcon("AchtungIcon")));
        }

        private function OnPlayerCantUseItem(_arg_1:CharacterEvent):void
        {
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.ERR_CRITICAL_ERROR_TITLE, ClientApplication.Localization.INVENTORY_CANT_USE, null, null, true, new AttachIcon("AchtungIcon")));
        }

        private function OnStatsIsNotEnough(_arg_1:Event):void
        {
            var _local_2:AchtungIcon;
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_ERROR_TITLE, ClientApplication.Localization.DLG_NOT_ENOUGH_POINTS_MESSAGE, null, null, true, new AttachIcon("AchtungIcon")));
        }

        private function OnPlayerAmmunitionEmpty(_arg_1:CharacterEvent):void
        {
            var _local_2:String = HtmlText.fixTags(((ClientApplication.Localization.DLG_WARNING + "> ") + ClientApplication.Localization.DLG_NOT_ENOUGH_AMMUNITION_TITLE));
            this._chatHUD.GetLeftBar.PublicChannel.AddMessage(_local_2);
        }

        private function OnGuildCreationMessage(_arg_1:GuildEvent):void
        {
            var _local_2:String = ClientApplication.Localization.GUILD_CREATION_STATUS[_arg_1.Result];
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.GUILD_CREATION_TITLE, _local_2, null, null, true, new AttachIcon("AchtungIcon")));
        }

        private function OnGuildUpdated(_arg_1:GuildEvent):void
        {
            if (this._guildWindow == null)
            {
                this._guildWindow = new GuildWindow();
            };
            this._guildWindow.Revalidate();
        }

        private function OnPlayerMannerChanged(_arg_1:CharacterEvent):void
        {
            var _local_2:CharacterInfo = _arg_1.Player;
            if (_local_2)
            {
                CharacterStorage.Instance.OnActorChangeManner(_local_2, _arg_1.Result);
            };
        }

        private function OnPlayerStatsChanged(_arg_1:Event):void
        {
            var _local_2:CharacterInfo = this._gameClient.ActorList.GetPlayer();
            this._bottomHUD.SetExpProgress(_local_2.baseLevel, _local_2.baseExp, _local_2.nextBaseExp);
            this._bottomHUD.SetJobProgress(_local_2.jobLevel, _local_2.jobExp, _local_2.nextJobExp);
            if (_local_2.baseLevel != 0)
            {
                this._bottomHUD.SetBaseLevel(_local_2.baseLevel);
            };
            if (_local_2.jobLevel != 0)
            {
                this._bottomHUD.SetJobLevel(_local_2.jobLevel);
            };
            this._bottomHUD.SetMoneyLabel(_local_2.money);
            if (((this._premiumShopWindow) && (this._premiumShopWindow.isShowing())))
            {
                this._premiumShopWindow.UpdateSilverAmount(_local_2.money);
            };
            this._topHUD.SetHealth(_local_2.hp, _local_2.maxHp);
            this._topHUD.SetMana(_local_2.sp, _local_2.maxSp);
            this._topHUD.SetNameAndLevel(_local_2);
            this._topHUD.RevalidateAvatar();
            this._characterInventory.RevalidateStats(_local_2);
            if (this._skills)
            {
                this._skills.RevalidateStats(_local_2);
            };
            CharacterStorage.Instance.OnExpChanged();
            CharacterStorage.Instance.OnMoneyChanged();
            this._characterInventory.RevalidateItems(true);
        }

        private function OnCashUpdated(_arg_1:UpdateCashEvent):void
        {
            var _local_2:CharacterInfo = this._gameClient.ActorList.GetPlayer();
            this._bottomHUD.SetGoldLabel(_local_2.cashPoints);
            if (((this._stashAuctionWindow) && (this._stashAuctionWindow.isShowing())))
            {
                this._stashAuctionWindow.UpdateColsAmount(_local_2.cashPoints);
            };
            if (((this._premiumShopWindow) && (this._premiumShopWindow.isShowing())))
            {
                this._premiumShopWindow.UpdateGoldAmount(_local_2.cashPoints);
            };
            if (((this._laddersWindow) && (this._laddersWindow.isShowing())))
            {
                this._laddersWindow.UpdateKafraAmount(_local_2.kafraPoints);
            };
            if (((this._kafraShopWindow) && (this._kafraShopWindow.isShowing())))
            {
                this._kafraShopWindow.UpdateColsAmount(_local_2.kafraPoints);
            };
            CharacterStorage.Instance.OnGoldChanged();
        }

        private function OnPremiumUpdated(_arg_1:UpdatePremiumEvent):void
        {
            if (this._levelWindow)
            {
                this._levelWindow.RevalidateInfo();
            };
            if (this._emotionWindow)
            {
                this._emotionWindow.Revalidate();
            };
            if (this._characterInventory)
            {
                this._characterInventory.RevalidateEquipment();
            };
        }

        private function OnPlayerSkillsChanged(_arg_1:CharacterEvent):void
        {
            var _local_2:CharacterInfo = this._gameClient.ActorList.GetPlayer();
            this._topHUD.SetHealth(_local_2.hp, _local_2.maxHp);
            this._topHUD.SetMana(_local_2.sp, _local_2.maxSp);
            this._characterInventory.RevalidateStats(_local_2);
            var _local_3:SkillsResourceLibrary = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
            if (((_local_3) && (_local_3.JobIsAdvanced(_local_2.jobId))))
            {
                this._skillsAdvanced.RevalidateSkills(_local_2.clothesColor, _local_2.jobId);
            }
            else
            {
                this._skills.RevalidateSkills(_local_2.clothesColor, _local_2.jobId);
            };
            this._bottomHUD.RevalidateItems();
        }

        private function OnPlayerSkillPointsChanged(_arg_1:CharacterEvent):void
        {
            var _local_2:CharacterInfo = this._gameClient.ActorList.GetPlayer();
            var _local_3:SkillsResourceLibrary = SkillsResourceLibrary(ResourceManager.Instance.Library("Skills"));
            if (((_local_3) && (_local_3.JobIsAdvanced(_local_2.jobId))))
            {
                this._skillsAdvanced.UpdateSkillPoints(_arg_1.Player.skillPoint);
            }
            else
            {
                this._skills.UpdateSkillPoints(_arg_1.Player.skillPoint);
            };
        }

        private function OnPlayerSkillChanged(_arg_1:CharacterEvent):void
        {
            this._bottomHUD.RevalidateItems(_arg_1.Info);
        }

        private function OnGuildSkillsChanged(_arg_1:CharacterEvent):void
        {
            var _local_2:CharacterInfo = this.LocalGameClient.ActorList.GetPlayer();
            this._guildSkillsWindow.RevalidateSkills(_local_2.clothesColor, 1000);
        }

        private function OnPlayerSkillFailed(_arg_1:CharacterEvent):void
        {
            if (_arg_1.Result == 41)
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.INVENTORY_CART_DIALOG_TITLE1, ClientApplication.Localization.INVENTORY_CART_DIALOG_MESSAGE1, null, null, true, new AttachIcon("StopIcon")));
            };
        }

        private function OnPetUpdated(_arg_1:CharacterEvent):void
        {
            this._topHUD.RevalidatePet();
        }

        private function OnPetFoodResult(_arg_1:CharacterEvent):void
        {
            var _local_2:String;
            if (_arg_1.Result == 0)
            {
                _local_2 = ClientApplication.Localization.PET_FOOD_NEED;
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, _local_2, null, null, true, new AttachIcon("AchtungIcon"), JOptionPane.OK));
            };
        }

        private function OnArrowsList(_arg_1:ArrowsListEvent):void
        {
            var _local_3:ArrowsListDialog;
            var _local_2:Array = _arg_1.List;
            if (((!(_local_2 == null)) && (_local_2.length > 0)))
            {
                _local_3 = new ArrowsListDialog(_arg_1.List);
                _local_3.show();
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_NOT_ENOUGH_AMMUNITION_TITLE, ClientApplication.Localization.DLG_CANT_CREATE_ARROW_MESSAGE, null, null, true, new AttachIcon("AchtungIcon"), JOptionPane.OK));
            };
        }

        private function OnProduceList(_arg_1:ProduceListEvent):void
        {
            var _local_4:int;
            var _local_5:Array;
            var _local_6:ItemData;
            this.CloseProduceWindow();
            var _local_2:Object = this._dataLibrary.GetSchemesForCraftedItem(this._currentCraftItemId);
            var _local_3:Array = new Array();
            for each (_local_4 in _local_2)
            {
                _local_6 = CharacterStorage.Instance.LocalPlayerCharacter.LocalCharacterInfo.GetItemByName(_local_4);
                if (_local_6)
                {
                    _local_3.push(_local_4);
                };
            };
            _local_5 = _arg_1.List;
            if (_local_3.length > 0)
            {
                this._produceDialog = new ProduceListDialog(_local_3, _local_5, this._currentCraftItemId);
                this._produceDialog.show();
            }
            else
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_NOT_ENOUGH_AMMUNITION_TITLE, ClientApplication.Localization.DLG_CANT_CREATE_ITEM_MESSAGE, null, null, true, new AttachIcon("AchtungIcon"), JOptionPane.OK));
            };
        }

        private function OnPlayerHotkeysReceived(_arg_1:CharacterEvent):void
        {
            var _local_2:HotKeys;
            this._bottomHUD.InventoryBarInstance.LoadHotKeys();
            _local_2 = this.LocalGameClient.ActorList.GetPlayer().Hotkeys;
            var _local_3:int = _local_2.GetSettings();
            if (_local_3 != HotKeys.HOTKEY_EMPTY)
            {
                this._settingsWindow.CurrentSettings = _local_3;
            };
        }

        private function OnActorLeaveGuild(_arg_1:GuildEvent):void
        {
            var _local_2:String = HtmlText.fixTags((((((((("> " + ClientApplication.Localization.GUILD_PLAYER_LEAVE_PART1) + " ") + _arg_1.Name) + " ") + ClientApplication.Localization.GUILD_PLAYER_LEAVE_PART2) + "\n> '") + _arg_1.Info) + "'"));
            this._chatHUD.GetLeftBar.GuildChannel.AddMessage(_local_2);
        }

        private function OnPlayerInvitedToGuild(evt:GuildEvent):void
        {
            var msg:String = (((ClientApplication.Localization.GUILD_PLAYER_INVITE_MESSAGE + " '") + evt.Name) + "'");
            this.ShowRequestDlg(ClientApplication.Localization.GUILD_PLAYER_INVITE_TITLE, msg, function OnPlayerInvitedToGuildAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    LocalGameClient.SendGuildJoin(evt.GuildId, 1);
                }
                else
                {
                    LocalGameClient.SendGuildJoin(evt.GuildId, 0);
                };
            });
        }

        private function OnGuildAllyRequest(evt:GuildEvent):void
        {
            var msg:String = (((ClientApplication.Localization.GUILD_ALLY_INVITE_MESSAGE + " '") + evt.Name) + "'");
            this.ShowRequestDlg(ClientApplication.Localization.GUILD_ALLY_INVITE_TITLE, msg, function OnPlayerInvitedToAllyAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    LocalGameClient.SendGuildAlly(evt.GuildId, 1);
                }
                else
                {
                    LocalGameClient.SendGuildAlly(evt.GuildId, 0);
                };
            });
        }

        private function OnPartyJoinRequest(evt:PartyEvent):void
        {
            var msg:String = ((((Localization.PARTY_PLAYER_REFUSE_PART1 + " '") + evt.PartyName) + "' ") + Localization.PARTY_PLAYER_REFUSE_PART2_3);
            this.ShowRequestDlg(ClientApplication.Localization.PARTY_INVITE_TITLE, msg, function OnPlayerInvitedToPartyAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    LocalGameClient.SendPartyJoin(evt.CurrentPartyId, 1);
                }
                else
                {
                    LocalGameClient.SendPartyJoin(evt.CurrentPartyId, 0);
                };
            });
        }

        private function OnDuelJoinRequest(evt:DuelEvent):void
        {
            var msg:String = ((((ClientApplication.Localization.DUEL_INVITE_MESSAGE_PART1 + " '") + evt.CharacterName) + "' ") + ClientApplication.Localization.DUEL_INVITE_MESSAGE_PART2);
            this.ShowRequestDlg(ClientApplication.Localization.DUEL_INVITE_TITLE, msg, function OnPlayerInvitedToDuelAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    LocalGameClient.SendDuelAccept();
                }
                else
                {
                    LocalGameClient.SendDuelReject();
                };
            });
        }

        private function OnTradeJoinRequest(evt:TradeEvent):void
        {
            var msg:String = ((((ClientApplication.Localization.TRADE_INVITE_MESSAGE_PART1 + " '") + evt.CharacterName) + "' ") + ClientApplication.Localization.TRADE_INVITE_MESSAGE_PART2);
            this.ShowRequestDlg(ClientApplication.Localization.TRADE_INVITE_TITLE, msg, function OnPlayerInvitedToTradeAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    LocalGameClient.SendTradeAck(3);
                }
                else
                {
                    LocalGameClient.SendTradeAck(4);
                };
            });
        }

        private function ShowRequestDlg(title:String, msg:String, fnResult:Function, timeWait:uint=20):void
        {
            var panel:CustomOptionPane;
            var timerId:uint;
            var OnResult:Function;
            OnResult = function (_arg_1:int=8):void
            {
                clearTimeout(timerId);
                panel.dispose();
                _one_show_dlg = false;
                fnResult(_arg_1);
            };
            if (_one_show_dlg)
            {
                (fnResult(JOptionPane.NO));
                return;
            };
            panel = new CustomOptionPane(JOptionPane.showMessageDialog(title, msg, OnResult, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            _one_show_dlg = true;
            timerId = setTimeout(OnResult, (timeWait * 1000));
        }

        public function ShowTradeWindow(_arg_1:int):void
        {
            if (((this._tradeWindow) && (this._tradeWindow.isShowing())))
            {
                this._tradeWindow.dispose();
            };
            this._characterInventory.setLocationXY((((ClientApplication.stageWidth / 2) - 305) - 30), ((0x0300 - 230) / 2));
            if (!this._characterInventory.isShowing())
            {
                this._characterInventory.RevalidateItems();
                this._characterInventory.show();
            };
            if (((this._stashAuctionWindow) && (this._stashAuctionWindow.isShowing())))
            {
                this._stashAuctionWindow.dispose();
                this._stashAuctionWindow = null;
            };
            if (((this._premiumShopWindow) && (this._premiumShopWindow.isShowing())))
            {
                this._premiumShopWindow.dispose();
                this._premiumShopWindow = null;
            };
            this._tradeWindow = new TradeWindow(_arg_1);
            this._tradeWindow.show();
        }

        public function get IsTradeWindowActive():Boolean
        {
            if (this._tradeWindow == null)
            {
                return (false);
            };
            return (this._tradeWindow.isShowing());
        }

        public function CheckSellItem(_arg_1:ItemData):Boolean
        {
            if (((this._tradeWindow) && (this._tradeWindow.isShowing())))
            {
                return (this._tradeWindow.CheckSellItem(_arg_1));
            };
            return (false);
        }

        private function OnTradeStartReply(_arg_1:TradeEvent):void
        {
            var _local_2:* = "";
            switch (_arg_1.Result)
            {
                case 0:
                case 1:
                case 2:
                case 6:
                case 7:
                    _local_2 = ClientApplication.Localization.TRADE_START_REPLY[_arg_1.Result];
                    break;
                case 4:
                    _local_2 = ClientApplication.Localization.TRADE_START_REPLY[_arg_1.Result];
                    if (((!(this._tradeWindow == null)) && (this._tradeWindow.isShowing())))
                    {
                        this._tradeWindow.Close();
                    };
                    break;
                case 3:
                case 5:
                    _local_2 = ClientApplication.Localization.TRADE_START_REPLY[3];
                    this.ShowTradeWindow(_arg_1.CharacterId);
                    break;
            };
            if (_local_2 != "")
            {
                this._chatHUD.GetLeftBar.PrivateChannel.AddMessage(HtmlText.fixTags(_local_2));
            };
        }

        private function OnTradeItemOk(_arg_1:TradeEvent):void
        {
            if (((!(this._tradeWindow == null)) && (this._tradeWindow.isShowing())))
            {
                if (_arg_1.Result == 0)
                {
                    this._tradeWindow.LoadSellItem(_arg_1.Item);
                };
            };
        }

        private function OnTradeAddItem(_arg_1:TradeEvent):void
        {
            if (((!(this._tradeWindow == null)) && (this._tradeWindow.isShowing())))
            {
                if (_arg_1.Item)
                {
                    this._tradeWindow.LoadBuyItem(_arg_1.Item);
                };
            };
        }

        private function OnTradeItemCancel(_arg_1:TradeEvent):void
        {
            if (((!(this._tradeWindow == null)) && (this._tradeWindow.isShowing())))
            {
                if (((_arg_1.Result == 0) && (_arg_1.Item)))
                {
                    this._tradeWindow.RemoveSellItem(_arg_1.Item);
                };
            };
        }

        private function OnTradeDeleteItem(_arg_1:TradeEvent):void
        {
            if (((!(this._tradeWindow == null)) && (this._tradeWindow.isShowing())))
            {
                if (_arg_1.Item)
                {
                    this._tradeWindow.RemoveBuyItem(_arg_1.Item);
                };
            };
        }

        private function OnTradeAddZeny(_arg_1:TradeEvent):void
        {
            if (((!(this._tradeWindow == null)) && (this._tradeWindow.isShowing())))
            {
                this._tradeWindow.LoadZeny(_arg_1.Result);
            };
        }

        private function OnTradeDealLocked(_arg_1:TradeEvent):void
        {
            if (((!(this._tradeWindow == null)) && (this._tradeWindow.isShowing())))
            {
                if (_arg_1.Result)
                {
                    this._tradeWindow.LockOtherSidePanel();
                }
                else
                {
                    this._tradeWindow.LockPlayerSidePanel();
                };
            };
        }

        private function OnTradeComplited(_arg_1:TradeEvent):void
        {
            if (((!(this._tradeWindow == null)) && (this._tradeWindow.isShowing())))
            {
                this._tradeWindow.Close();
            };
        }

        private function OnPartyMemberJoined(_arg_1:PartyEvent):void
        {
            var _local_2:* = "";
            switch (_arg_1.Result)
            {
                case 0:
                    _local_2 = ((((("> " + Localization.PARTY_PLAYER_REFUSE_PART1) + " '") + _arg_1.CharacterName) + "' ") + Localization.PARTY_PLAYER_REFUSE_PART2_2);
                    break;
                case 1:
                    _local_2 = ((((("> " + Localization.PARTY_PLAYER_REFUSE_PART1) + " '") + _arg_1.CharacterName) + "' ") + Localization.PARTY_PLAYER_REFUSE_PART2_1);
                    break;
                case 2:
                    _local_2 = (((("> " + Localization.PARTY_PLAYER_ADDED) + " '") + _arg_1.CharacterName) + "'.");
                    break;
                case 3:
                    _local_2 = ("> " + Localization.ERR_PARTY_COMPLETED);
                    break;
                case 4:
                    _local_2 = ((((("> " + Localization.PARTY_PLAYER_EXIST_PART1) + " '") + _arg_1.CharacterName) + "' ") + ClientApplication.Localization.PARTY_PLAYER_EXIST_PART2);
                    break;
                case 5:
                    _local_2 = ("> " + Localization.PARTY_RESULT_NOT_LEADER);
                    break;
                case 6:
                    _local_2 = ("> " + Localization.PARTY_RESULT_NOT_FOUND);
                    break;
            };
            if (_local_2 != "")
            {
                this._chatHUD.GetLeftBar.PartyChannel.AddMessage(HtmlText.fixTags(_local_2));
            };
        }

        private function OnPartyUpdated(_arg_1:PartyEvent):void
        {
            this._chatHUD.RevalidatePartyPanel();
        }

        private function OnPartyLeave(_arg_1:PartyEvent):void
        {
            var _local_2:String = HtmlText.fixTags(((((("> " + ClientApplication.Localization.PARTY_PLAYER_REFUSE_PART1) + " '") + _arg_1.CharacterName) + "' ") + ClientApplication.Localization.PARTY_PLAYER_LEAVE));
            this._chatHUD.GetLeftBar.PartyChannel.AddMessage(_local_2);
            this._chatHUD.RevalidatePartyPanel();
        }

        private function OnPartyCreationResult(_arg_1:PartyEvent):void
        {
            var _local_2:* = "";
            switch (_arg_1.Result)
            {
                case 0:
                    _local_2 = ("> " + Localization.PARTY_RESULT_CREATED);
                    this._chatHUD.GetLeftBar.PartyChannel.AddMessage(HtmlText.fixTags(_local_2));
                    CharacterMenu.ValidatePartyCreate();
                    this._chatHUD.RevalidatePartyPanel();
                    return;
                case 1:
                    _local_2 = Localization.PARTY_RESULT_EXISTS;
                    break;
                case 2:
                    _local_2 = Localization.PARTY_RESULT_REFUSE;
                    break;
            };
            if (_local_2 != "")
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, _local_2, null, null, true, new AttachIcon("AchtungIcon")));
            };
        }

        private function OnFriendsResult(_arg_1:FriendEvent):void
        {
            var _local_2:* = "";
            switch (_arg_1.Result)
            {
                case 0:
                    _local_2 = (((("> " + ClientApplication.Localization.FRIEND_ADDED_MESSAGE) + " '") + _arg_1.CharacterName) + "'");
                    this._friendsWindow.Revalidate();
                    break;
                case 1:
                    _local_2 = ((((("> " + ClientApplication.Localization.FRIEND_INVITE_MESSAGE_PART1) + " '") + _arg_1.CharacterName) + "' ") + ClientApplication.Localization.FRIEND_INVITE_MESSAGE2);
                    break;
                case 2:
                    _local_2 = ("> " + ClientApplication.Localization.FRIEND_INVITE_MESSAGE3);
                    break;
                case 3:
                    _local_2 = ((((("> " + ClientApplication.Localization.FRIEND_INVITE_MESSAGE4_PART1) + " '") + _arg_1.CharacterName) + "' ") + ClientApplication.Localization.FRIEND_INVITE_MESSAGE4_PART2);
                    break;
            };
            if (_local_2 != "")
            {
                this._chatHUD.GetLeftBar.PrivateChannel.AddMessage(HtmlText.fixTags(_local_2));
            };
        }

        private function OnFriendsUpdated(_arg_1:FriendEvent):void
        {
            this._friendsWindow.Revalidate();
        }

        private function OnFriendsMemberAddRequest(_arg_1:FriendEvent):void
        {
            var _local_2:String = ((((ClientApplication.Localization.FRIEND_INVITE_MESSAGE_PART1 + " '") + _arg_1.CharacterName) + "' ") + ClientApplication.Localization.FRIEND_INVITE_MESSAGE_PART2);
            FriendEvent.CurrentAccountId = _arg_1.AccountId;
            FriendEvent.CurrentCharacterId = _arg_1.CharacterId;
            this.ShowRequestDlg(ClientApplication.Localization.FRIEND_INVITE_TITLE, _local_2, this.OnPlayerInvitedToFriendAccepted);
        }

        private function OnPlayerInvitedToFriendAccepted(_arg_1:int):void
        {
            if (_arg_1 == JOptionPane.YES)
            {
                this.LocalGameClient.SendFriendAccept(FriendEvent.CurrentAccountId, FriendEvent.CurrentCharacterId);
            }
            else
            {
                this.LocalGameClient.SendFriendReject(FriendEvent.CurrentAccountId, FriendEvent.CurrentCharacterId);
            };
        }

        private function OnIgnoreListUpdated(_arg_1:IgnoreEvent):void
        {
            this._friendsWindow.RevalidateIgnoreList();
        }

        private function OnIgnoreResult(_arg_1:IgnoreEvent):void
        {
            var _local_2:* = "";
            switch (_arg_1.Type)
            {
                case 0:
                    if (_arg_1.Result == 0)
                    {
                        _local_2 = ("> " + ClientApplication.Localization.IGNORE_ADDED_MESSAGE);
                    }
                    else
                    {
                        if (_arg_1.Result == 1)
                        {
                            _local_2 = ("> " + ClientApplication.Localization.IGNORE_FAIL_ADD_MESSAGE);
                        }
                        else
                        {
                            if (_arg_1.Result == 2)
                            {
                                _local_2 = ("> " + ClientApplication.Localization.IGNORE_FAIL_ADD_MESSAGE2);
                            };
                        };
                    };
                    break;
                case 1:
                    if (_arg_1.Result == 0)
                    {
                        _local_2 = ("> " + ClientApplication.Localization.IGNORE_REMOVED_MESSAGE);
                    }
                    else
                    {
                        _local_2 = ("> " + ClientApplication.Localization.IGNORE_FAIL_REMOVE_MESSAGE);
                    };
                    break;
            };
            this._friendsWindow.RevalidateIgnoreList();
            if (_local_2 != "")
            {
                this._chatHUD.GetLeftBar.PrivateChannel.AddMessage(HtmlText.fixTags(_local_2));
            };
        }

        private function OnIgnoreAllresult(_arg_1:IgnoreEvent):void
        {
        }

        private function OnPlayerInvitedToGuildAccepted(_arg_1:int, _arg_2:GuildEvent):void
        {
            if (_arg_1 == JOptionPane.YES)
            {
                this.LocalGameClient.SendGuildJoin(_arg_2.GuildId, 1);
            }
            else
            {
                this.LocalGameClient.SendGuildJoin(_arg_2.GuildId, 0);
            };
        }

        private function OnPlayerInvitedToAllyAccepted(_arg_1:int, _arg_2:GuildEvent):void
        {
            if (_arg_1 == JOptionPane.YES)
            {
                this.LocalGameClient.SendGuildAlly(_arg_2.GuildId, 1);
            }
            else
            {
                this.LocalGameClient.SendGuildJoin(_arg_2.GuildId, 0);
            };
        }

        public function StoreGameSessionInfo():void
        {
            if ((((!(this._socialWindow == null)) && (!(this._socialWindow.SocialPanel == null))) && (this._socialWindow.SocialPanel.Data.loggedIn)))
            {
                this._socialWindow.SocialPanel.Data.SendGameSession.SendRequest(getTimer(), "");
            };
        }

        private function OnLevelUpReceived(_arg_1:ActorStatsEvent):void
        {
            var _local_2:CharacterInfo = this.LocalGameClient.ActorList.GetPlayer();
            CharacterStorage.Instance.OnActorLevelUp(_arg_1);
            if (_local_2.characterId != _arg_1.Actor.characterId)
            {
                return;
            };
            if (this._settingsWindow.IsPlaySoundsEnabled)
            {
                Music.Instance.PlaySound(Music.LevelupSound);
            };
            this._bottomHUD.BlinkCharacterStats(true);
            if (this._config.IsPaymentsEnabled)
            {
                this._bottomHUD.BlinkGold(true);
            };
            if (_local_2.baseLevel == 20)
            {
                GoogleAnalyticsClient.Instance.trackPageview((("/" + gameServerName) + "/level20"));
            };
        }

        private function OnJobLevelUpReceived(_arg_1:ActorStatsEvent):void
        {
            CharacterStorage.Instance.OnActorJobLevelUp(_arg_1);
            var _local_2:CharacterInfo = this.LocalGameClient.ActorList.GetPlayer();
            if (_local_2.characterId != _arg_1.Actor.characterId)
            {
                return;
            };
            if (_local_2.jobId == 0)
            {
                if (_local_2.jobLevel > 9)
                {
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_JOB_LEVELUP_TITLE, ClientApplication.Localization.DLG_JOB_LEVELUP_MESSAGE, null, null, true, new AttachIcon("AchtungIcon")));
                };
            }
            else
            {
                this._bottomHUD.BlinkCharacterSkills(true);
                if (!((this._levelWindow) && (this._levelWindow.isShowing())))
                {
                    this._bottomHUD.BlinkerJobButton.Start();
                };
            };
        }

        private function OnRefineResultReceived(_arg_1:ActorStatsEvent):void
        {
            if (this._refineWindow != null)
            {
                this._refineWindow.Complete();
            };
            CharacterStorage.Instance.OnActorRefineResult(_arg_1);
        }

        private function OnPlayerDied(_arg_1:ActorDisplayEvent):void
        {
            var _local_2:int;
            if (((_arg_1.Action == ActorDisplayEvent.DIED) && (_arg_1.Character == this._gameClient.ActorList.GetPlayer())))
            {
                _local_2 = _arg_1.Character.hp;
                if (_local_2 > 0)
                {
                    return;
                };
                if (!this._tradingMode)
                {
                    this._isDieOnGvG = (CharacterStorage.Instance.PvPMode == 3);
                    if (!this.isDieOnLadder)
                    {
                        if (this._respawnDialog == null)
                        {
                            this._respawnDialog = new RespawnDialog(this._isDieOnGvG);
                        };
                        this._respawnDialog.addEventListener(RespawnDialog.ON_RESPAWN_CONFIRMED, this.OnRespawnConfirmed, false, 0, true);
                        if (!this._isDieOnGvG)
                        {
                            this.SetShortcutsEnabled(false);
                            this._respawnDialog.Show();
                        };
                    };
                }
                else
                {
                    this._cartWindow.VenderClose();
                    this._gameClient.SendRespawn();
                    this.CloseAllWindows();
                };
            };
        }

        private function OnRespawnConfirmed(_arg_1:Event):void
        {
            this._respawnDialog = null;
            if (!this._isDieOnGvG)
            {
                this.SetShortcutsEnabled(true);
                this._gameClient.SendRespawn();
            };
        }

        public function get BottomHUD():BottomBar
        {
            return (this._bottomHUD);
        }

        public function get TopHUD():TopBar
        {
            return (this._topHUD);
        }

        public function get ChatHUD():ChatBar
        {
            return (this._chatHUD);
        }

        public function SetShortcutsEnabled(_arg_1:Boolean):void
        {
            this._shortcutsEnabled = _arg_1;
        }

        private function OnKeyUpEvent(_arg_1:KeyboardEvent):void
        {
            this._isShiftPressed = _arg_1.shiftKey;
            this._isCtrlPressed = _arg_1.ctrlKey;
        }

        private function OnKeyDownEvent(_arg_1:KeyboardEvent):void
        {
            this._isShiftPressed = _arg_1.shiftKey;
            this._isCtrlPressed = _arg_1.ctrlKey;
            if (!this._shortcutsEnabled)
            {
                return;
            };
            if (((!(this._socialWindow == null)) && (!(this._socialWindow.SocialPanel == null))))
            {
                if (this._socialWindow.SocialPanel.isSupportWindowShowing)
                {
                    return;
                };
            };
            if (((this._stashAuctionWindow) && (this._stashAuctionWindow.isShowing())))
            {
                return;
            };
            if (((this._premiumShopWindow) && (this._premiumShopWindow.isShowing())))
            {
                return;
            };
            if (!_arg_1.altKey)
            {
                if (this._chatHUD.GetLeftBar.IsFocused())
                {
                    if (_arg_1.keyCode == Keyboard.ENTER)
                    {
                        this._chatHUD.GetLeftBar.RemoveFocus();
                    };
                    return;
                };
                switch (_arg_1.keyCode)
                {
                    case Keyboard.F2:
                        CharacterStorage.Instance.UpdateNextTarget();
                        return;
                    case Keyboard.ESCAPE:
                    case Keyboard.BACKQUOTE:
                        CharacterStorage.Instance.SelectCharacter(null, true);
                        if (CharacterStorage.Instance.LocalPlayerCharacter.isCasting)
                        {
                            this.LocalGameClient.SendSkillCastCancel();
                        };
                        if (CharacterStorage.Instance.SkillMode > 0)
                        {
                            CharacterStorage.Instance.SkillMode = 0;
                        };
                        return;
                    case Keyboard.ENTER:
                        this._chatHUD.GetLeftBar.SetFocus();
                        return;
                    case Keyboard.NUMBER_1:
                    case Keyboard.SPACE:
                        if (this._bottomHUD.InventoryBarInstance.DoCooldownSlot())
                        {
                            CharacterStorage.Instance.OnStartBaseAttack();
                        };
                        return;
                    case Keyboard.NUMBER_2:
                    case Keyboard.NUMBER_3:
                    case Keyboard.NUMBER_4:
                    case Keyboard.NUMBER_5:
                    case Keyboard.NUMBER_6:
                    case Keyboard.NUMBER_7:
                    case Keyboard.NUMBER_8:
                    case Keyboard.NUMBER_9:
                        this._bottomHUD.InventoryBarInstance.UseHotkey((_arg_1.keyCode - 50));
                        return;
                    case Keyboard.NUMBER_0:
                        this._bottomHUD.InventoryBarInstance.UseHotkey(8);
                        return;
                    case Keyboard.MINUS:
                        this._bottomHUD.InventoryBarInstance.UseHotkey(9);
                        return;
                    case Keyboard.EQUAL:
                        this._bottomHUD.InventoryBarInstance.UseHotkey(10);
                        return;
                    case Keyboard.Q:
                        this.ShowQuestsWindow();
                        return;
                    case Keyboard.P:
                        this.OnCharacterButtonPressed(null);
                        return;
                };
            };
        }

        public function ShowQuestsWindow(_arg_1:uint=0):void
        {
            var _local_2:CharacterInfo;
            if (this.IsPlayerTalkingWithNPC)
            {
                return;
            };
            this._questsWindow = ((this._questsWindow) || (new QuestsWindow()));
            if (this._questsWindow.isShowing())
            {
                this._questsWindow.CloseWithAnimation();
            }
            else
            {
                this._gameClient.SendUpdateQuests();
                this._questsWindow.ShowQuestWindow(_arg_1);
                _local_2 = this.LocalGameClient.ActorList.GetPlayer();
                this._currentQuestsCount = _local_2.GetQuestCount();
            };
        }

        public function ShowLevelUpWindow(_arg_1:int):void
        {
            if (this._levelupWindow != null)
            {
                this._levelupWindow.dispose();
                this._levelupWindow = null;
            };
            this._levelupWindow = new LevelUpWindow(_arg_1);
            this._levelupWindow.show();
        }

        public function ShowPartnerWindow():void
        {
            if (this._partnerWindow != null)
            {
                this._partnerWindow.dispose();
                this._partnerWindow = null;
            };
            this._partnerWindow = new PartnerWindow();
            this._partnerWindow.show();
        }

        public function CloseUpgradeWindow():void
        {
            if (((this._upgradeWindow) && (this._upgradeWindow.isShowing())))
            {
                this._upgradeWindow.dispose();
            };
        }

        public function ShowRefineWindow():void
        {
            if (this._refineWindow == null)
            {
                this._refineWindow = new RefineWindow();
            };
            if (!this._refineWindow.isShowing())
            {
                this._refineWindow.show();
            };
            if (((this._upgradeWindow) && (this._upgradeWindow.isShowing())))
            {
                this._upgradeWindow.dispose();
            };
        }

        public function ShowUpgradeWindow():void
        {
            if (this._upgradeWindow == null)
            {
                this._upgradeWindow = new UpgradeWindow();
            };
            if (!this._upgradeWindow.isShowing())
            {
                this._upgradeWindow.show();
            };
            if (((this._refineWindow) && (this._refineWindow.isShowing())))
            {
                this._refineWindow.dispose();
            };
        }

        private function FractionConvert(_arg_1:int, _arg_2:int, _arg_3:String, _arg_4:Boolean=false):String
        {
            var _local_5:Actors = this._gameClient.ActorList;
            if ((((_arg_2 <= 0) || (_arg_4)) || (_local_5.GetPlayer().Support)))
            {
                return (_arg_3);
            };
            if (((this.LocalGameClient.PremiumType > 0) || (_arg_1 > 1)))
            {
                return (_arg_3);
            };
            _arg_2--;
            var _local_6:int = _local_5.GetPlayerFraction();
            if (_local_6 == _arg_2)
            {
                return (_arg_3);
            };
            var _local_7:String = this._dataLibrary.GetFractionMsg(((_arg_2 > 0) ? 1 : 0));
            return ((_local_7 != null) ? _local_7 : _arg_3);
        }

        private function OnReceivedBroadcastMessage(_arg_1:ChatMessage):void
        {
            var _local_4:Object;
            var _local_5:Array;
            var _local_6:InteractiveText;
            var _local_7:Array;
            var _local_8:String;
            var _local_2:int = _arg_1.Race;
            var _local_3:String = HtmlText.fixTags(_arg_1.Message);
            if (_local_3.charAt(0) == "^")
            {
                _local_4 = this._dataLibrary.GetAnnounceData(_local_3.replace("^", ""));
                if (((_local_4) && (_local_4.message)))
                {
                    _local_5 = _local_4.message.split("%link%");
                    if (_local_5.length == 2)
                    {
                        _local_6 = new InteractiveText((NewChatChannel.WIDTH_CHAT - 30));
                        _local_6.AddText(HtmlText.update(_local_5[0], false, 12, HtmlText.fontName, "#ccfe20"));
                        _local_6.AddLinkText(HtmlText.update(_local_4.linkname, false, 12, HtmlText.fontName, "#e7ff93"), this.GotToAppGroupPage, _local_4.link);
                        _local_6.AddText(HtmlText.update(_local_5[1], false, 12, HtmlText.fontName, "#ccfe20"));
                        this._chatHUD.GetLeftBar.PublicChannel.AddNotification(_local_6);
                        return;
                    };
                };
            };
            if (_local_2 > 0)
            {
                _local_7 = _local_3.split(": ");
                if (_local_7.length >= 2)
                {
                    _local_8 = _local_7[0];
                    _local_3 = ((_local_8 + ": ") + this.FractionConvert(-1, _local_2, _local_3.replace((_local_7[0] + ": "), ""), _arg_1.IsGM));
                }
                else
                {
                    _local_3 = this.FractionConvert(_arg_1.PremiumType, _local_2, _local_3, _arg_1.IsGM);
                };
            };
            _local_3 = HtmlText.Localize(_local_3);
            _local_3 = HtmlText.update(_local_3, false, 12, HtmlText.fontName, _arg_1.Color);
            this._chatHUD.GetLeftBar.PublicChannel.AddMessage(_local_3);
        }

        private function OnReceivedPublicMessage(_arg_1:ChatMessage):void
        {
            var _local_7:String;
            var _local_8:String;
            var _local_9:Array;
            var _local_10:NewChatChannel;
            var _local_11:Boolean;
            var _local_12:Boolean;
            var _local_13:String;
            var _local_14:String;
            var _local_2:int = _arg_1.SenderLevel;
            var _local_3:int = _arg_1.PremiumType;
            var _local_4:int = _arg_1.Race;
            var _local_5:String = HtmlText.fixTags(_arg_1.Message);
            var _local_6:int = LeftChatBar.PUBLIC_CHANNEL;
            if (_local_2 > 0)
            {
                _local_7 = null;
                _local_8 = _local_5;
                _local_9 = _local_5.split(" : ");
                if (_local_9.length >= 2)
                {
                    _local_7 = _local_9[0];
                    _local_11 = ((_arg_1.IsGM) || (_local_7.indexOf("-") >= 0));
                    _local_12 = (_local_2 == 99);
                    if (_local_11)
                    {
                        _local_7 = HtmlText.update((((_local_7 + " [") + _local_2) + "]"), true, 12, HtmlText.fontName, "#33FF33");
                    }
                    else
                    {
                        _local_14 = ((_local_3 > 0) ? ((_local_3 == 2) ? "#FFD700" : "#C662FF") : ((_local_12) ? "#FFF36C" : "#DDDDE4"));
                        _local_7 = (HtmlText.update(_local_7, _local_12, 12, HtmlText.fontName, _local_14) + HtmlText.update(((" [" + _local_2) + "]"), _local_12, 12, HtmlText.fontName, _local_14));
                    };
                    _local_5 = _local_5.replace((_local_9[0] + " : "), "");
                    if (_local_5.indexOf("/") == 0)
                    {
                        if (_local_5.indexOf("/t") == 0)
                        {
                            _local_6 = LeftChatBar.TRADE_CHANNEL;
                            _local_5 = _local_5.replace("/t ", "");
                        };
                    };
                    _local_13 = this.FractionConvert(_local_3, _local_4, _local_5, _arg_1.IsGM);
                };
                _local_10 = this._chatHUD.GetLeftBar.PublicChannel;
                if (_local_6 == LeftChatBar.TRADE_CHANNEL)
                {
                    _local_10 = this._chatHUD.GetLeftBar.TradeChannel;
                };
                if (_local_7)
                {
                    _local_8 = _local_10.AddCharacterMessage(_arg_1.CharacterId, _local_9[0], _local_7, (": " + _local_13));
                }
                else
                {
                    _local_8 = _local_10.AddMessage(_local_8);
                };
                _arg_1.Message = ((_local_7) ? (_local_9[0] + _local_8) : _local_8);
            }
            else
            {
                this._chatHUD.GetLeftBar.PublicChannel.AddMessage(_local_5);
            };
            if (_local_6 == LeftChatBar.PUBLIC_CHANNEL)
            {
                CharacterStorage.Instance.OnReceivedPublicMessage(_arg_1);
            };
        }

        private function OnReceivedGuildMessage(_arg_1:ChatMessage):void
        {
            var _local_2:String = _arg_1.Author;
            var _local_3:* = "";
            if (_local_2 != null)
            {
                _local_3 = HtmlText.update((_local_2 + ": "), false, 12, HtmlText.fontName, "#FFFFFF");
            };
            _local_3 = (_local_3 + HtmlText.update(HtmlText.fixTags(_arg_1.Message), false, 12, HtmlText.fontName, _arg_1.Color));
            this._chatHUD.GetLeftBar.GuildChannel.AddMessage(_local_3);
            CharacterStorage.Instance.OnReceivedGuildMessage(_arg_1);
        }

        private function OnReceivedPartyMessage(_arg_1:ChatMessage):void
        {
            var _local_2:String = _arg_1.Author;
            var _local_3:* = "";
            if (_local_2 != null)
            {
                _local_3 = HtmlText.update((_local_2 + ": "), false, 12, HtmlText.fontName, "#FFFFFF");
            };
            _local_3 = (_local_3 + HtmlText.update(HtmlText.fixTags(_arg_1.Message), false, 12, HtmlText.fontName, _arg_1.Color));
            this._chatHUD.GetLeftBar.PartyChannel.AddMessage(_local_3);
            CharacterStorage.Instance.OnReceivedPartyMessage(_arg_1);
        }

        private function OnReceivedPrivateMessage(_arg_1:ChatMessage):void
        {
            var _local_2:String = this.FractionConvert(_arg_1.PremiumType, _arg_1.Race, HtmlText.fixTags(_arg_1.Message), _arg_1.IsGM);
            this._chatHUD.GetLeftBar.PrivateChannel.AddMessageFrom(_arg_1.Author, _local_2);
            CharacterStorage.Instance.OnReceivedPrivateMessage(_arg_1);
        }

        public function SetChatEnabled(_arg_1:Boolean):void
        {
            this._chatHUD.SetChatEnabled(_arg_1);
        }

        private function OnReceivedMuteMessage(_arg_1:ChatMessage):void
        {
        }

        private function OnReceivedEmotion(_arg_1:ChatMessage):void
        {
            var _local_2:int = int(_arg_1.Message);
            if (_local_2 <= 0)
            {
                return;
            };
            if (((_arg_1.SenderLevel > 0) && (_local_2 > 100)))
            {
                this._chatHUD.GetLeftBar.PublicChannel.AddEmotion(_local_2, _arg_1.Author, _arg_1.SenderLevel);
            };
            CharacterStorage.Instance.OnReceivedEmotion(_arg_1);
        }

        private function OnReceivedPetEmotion(_arg_1:ChatMessage):void
        {
            var _local_2:int = int(_arg_1.Message);
            if (_local_2 < 800)
            {
                return;
            };
            this._chatHUD.GetLeftBar.PublicChannel.AddPetEmotion(_local_2, _arg_1.Author);
            CharacterStorage.Instance.OnReceivedEmotion(_arg_1);
        }

        private function OnCharServerInvitation(_arg_1:ClientEvent):void
        {
            this._gameClient.Disconnect();
            this._gameClient.ConnectCharServer();
        }

        private function OnCharacterReceived(_arg_1:ClientEvent):void
        {
            if (this._loginScreenBG)
            {
                this._loginScreenBG.Hide();
            };
            this._charactersListWindow = new CharacterListWindow(this, this.LocalGameClient.CharactersList);
            this._charactersListWindow.addEventListener(CharacterListEvent.ON_ACTION, this.OnCharacterListAction, false, 0, true);
            this._charactersListWindow.addEventListener(CharacterListEvent.ON_RENAME, this.OnCharacterListRename, false, 0, true);
            this._charactersListWindow.x = ((stage.stageWidth / 2) - 403);
            this._charactersListWindow.y = ((socialPanelVisible) ? 0 : ((stage.stageHeight / 2) - 384));
            this._charactersListWindow.Show();
            if (((this._loginPrompt) && (this._loginPrompt.IsShowing())))
            {
                this._loginPrompt.Dispose();
            };
        }

        private function OnCharacterCreationSuccessful(_arg_1:ClientEvent):void
        {
            if (_arg_1.slot == 0)
            {
                GoogleAnalyticsClient.Instance.trackPageview((("/" + gameServerName) + "/new_account_created"));
                StatisticManager.Instance.SendEvent("tut02_CreatChar");
            };
            this._characterCreate.Dispose();
            this.LocalGameClient.SendCharLogin(this._characterSlotId);
        }

        private function OnCharacterListAction(_arg_1:CharacterListEvent):void
        {
            this._characterSlotId = _arg_1.SlotId;
            if (this._charactersListWindow != null)
            {
                this._charactersListWindow.Dispose();
            };
            if (this.LocalGameClient.CharactersList[this._characterSlotId] == null)
            {
                this.ShowCharacterCreateWindow(false);
            }
            else
            {
                this.LocalGameClient.SendCharLogin(this._characterSlotId);
            };
        }

        private function OnCharacterListRename(_arg_1:CharacterListEvent):void
        {
            this._characterSlotId = _arg_1.SlotId;
            this._characterRenameDialog = new CharacterRenameDialog();
            this._characterRenameDialog.addEventListener(CharacterCreateEvent.ON_CHARACTER_RENAME_CONFIRMED, this.OnUserAskedForRenameCharacter);
            this._characterRenameDialog.show();
        }

        private function OnUserAskedForRenameCharacter(_arg_1:CharacterCreateEvent):void
        {
            this._newName = _arg_1.Name;
            this.LocalGameClient.SendCharRenameRequest(this._characterSlotId, this._newName);
        }

        private function OnCharacterDoesntExist(_arg_1:ClientEvent):void
        {
            if (this._characterCreate != null)
            {
                if (this._characterCreate.IsActiveCheckingName)
                {
                    this._characterCreate.ActiveCheckingName(true, false);
                    this.LocalGameClient.SendCheckCharacterName(this._characterCreate.GetName());
                }
                else
                {
                    this.SendCreateCharacter(this._characterCreate.ClothesColor, this._characterCreate.ServerJobId);
                };
            }
            else
            {
                this.ShowCharacterCreateWindow(false);
            };
        }

        private function OnCharacterNameDuplicate(_arg_1:ClientEvent):void
        {
            if (this._characterCreate)
            {
                if (this._characterCreate.newCharacter)
                {
                    this._characterCreate.removeEventListener(CharacterCreateEvent.ON_CHARACTER_CONFIRMED, this.OnAccountAndCharacterConfirmed, false);
                    this._characterCreate.addEventListener(CharacterCreateEvent.ON_CHARACTER_CONFIRMED, this.OnCharacterConfirmed, false, 0, true);
                };
            };
            this._characterCreate.ActiveCheckingName(false, true);
        }

        private function OnCharacterNameDenied(_arg_1:ClientEvent):void
        {
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.ERR_WRONG_CHARACTER_NAME_TITLE, ClientApplication.Localization.ERR_WRONG_CHARACTER_NAME, null, null, true, new AttachIcon("StopIcon")));
        }

        private function OnCharacterRenameAccepted(_arg_1:ClientEvent):void
        {
            this.LocalGameClient.SendCharRenameConfirmRequest(this._characterSlotId);
        }

        private function OnCharacterRenameFailed(_arg_1:ClientEvent):void
        {
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.ERR_CHARACTER_NAME_ALREADY_EXISTS_TITLE, ClientApplication.Localization.ERR_CHARACTER_NAME_ALREADY_EXISTS, this.OnCharacterRenameFailedCallback, null, true, new AttachIcon("StopIcon")));
        }

        private function OnCharacterRenameAlreadyChanged(_arg_1:ClientEvent):void
        {
            new CustomOptionPane(JOptionPane.showMessageDialog(Localization.ERR_CRITICAL_ERROR_TITLE, Localization.ERR_CHARACTER_RENAME_ALREADY, this.OnCharacterRenameFailedCallback, null, true, new AttachIcon("StopIcon")));
        }

        private function OnCharacterRenameFailedCallback(_arg_1:int):void
        {
        }

        private function OnCharacterRenameSuccessful(_arg_1:ClientEvent):void
        {
            this._charactersListWindow.Dispose();
            this.LocalGameClient.CharactersList[this._characterSlotId].name = this._newName;
            this.LocalGameClient.SendCharLogin(this._characterSlotId);
        }

        private function OnCharacterCheckNameSuccessful(_arg_1:ClientEvent):void
        {
            if (this._characterCreate != null)
            {
                if (this._characterCreate.newCharacter)
                {
                    this._characterCreate.removeEventListener(CharacterCreateEvent.ON_CHARACTER_CHECK_NAME, this.OnAccountAndCheckCharacterName, false);
                    this._characterCreate.addEventListener(CharacterCreateEvent.ON_CHARACTER_CHECK_NAME, this.OnCheckCharacterName, false, 0, true);
                    this._characterCreate.removeEventListener(CharacterCreateEvent.ON_CHARACTER_CONFIRMED, this.OnAccountAndCharacterConfirmed, false);
                    this._characterCreate.addEventListener(CharacterCreateEvent.ON_CHARACTER_CONFIRMED, this.OnCharacterConfirmed, false, 0, true);
                };
                this._characterCreate.ActiveCheckingName(true, true);
            };
        }

        private function OnCharacterCheckNameFailed(_arg_1:ClientEvent):void
        {
            if (this._characterCreate != null)
            {
                if (this._characterCreate.newCharacter)
                {
                    this._characterCreate.removeEventListener(CharacterCreateEvent.ON_CHARACTER_CHECK_NAME, this.OnAccountAndCheckCharacterName, false);
                    this._characterCreate.addEventListener(CharacterCreateEvent.ON_CHARACTER_CHECK_NAME, this.OnCheckCharacterName, false, 0, true);
                    this._characterCreate.removeEventListener(CharacterCreateEvent.ON_CHARACTER_CONFIRMED, this.OnAccountAndCharacterConfirmed, false);
                    this._characterCreate.addEventListener(CharacterCreateEvent.ON_CHARACTER_CONFIRMED, this.OnCharacterConfirmed, false, 0, true);
                };
                this._characterCreate.ActiveCheckingName(false, true);
            };
        }

        private function ShowCharacterCreateWindow(_arg_1:Boolean):void
        {
            if (((this._loginPrompt) && (this._loginPrompt.IsShowing())))
            {
                this._loginPrompt.Dispose();
            };
            if (this._characterCreate == null)
            {
                this._characterCreate = new NewCharacterCreateWindow(this, ((_arg_1) || (this._characterSlotId == 0)));
                if (_arg_1)
                {
                    this._characterCreate.addEventListener(CharacterCreateEvent.ON_CHARACTER_CHECK_NAME, this.OnAccountAndCheckCharacterName, false, 0, true);
                    this._characterCreate.addEventListener(CharacterCreateEvent.ON_CHARACTER_CONFIRMED, this.OnAccountAndCharacterConfirmed, false, 0, true);
                }
                else
                {
                    this._characterCreate.addEventListener(CharacterCreateEvent.ON_CHARACTER_CHECK_NAME, this.OnCheckCharacterName, false, 0, true);
                    this._characterCreate.addEventListener(CharacterCreateEvent.ON_CHARACTER_CONFIRMED, this.OnCharacterConfirmed, false, 0, true);
                };
            };
            if (this._characterSlotId == 0)
            {
                StatisticManager.Instance.SendEvent("tut01_CharCreatScreen");
            };
            this._characterCreate.x = ((stage.stageWidth / 2) - 403);
            this._characterCreate.y = ((socialPanelVisible) ? 0 : ((stage.stageHeight / 2) - 384));
            this._characterCreate.Show();
        }

        public function IsFirstCharacter():Boolean
        {
            return (this._characterSlotId == 0);
        }

        private function OnCharacterConfirmed(_arg_1:CharacterCreateEvent):void
        {
            this.SendCreateCharacter(_arg_1.ClothesColor, _arg_1.JobId);
        }

        private function SendCreateCharacter(_arg_1:int, _arg_2:int):void
        {
            this.LocalGameClient.SendCharacterCreate(this._characterSlotId, this._characterCreate.GetName(), this._characterCreate.IsMale, _arg_2, _arg_1, 5, 5, 5, 5, 5, 5, 0, 0);
        }

        private function OnCheckCharacterName(_arg_1:CharacterCreateEvent):void
        {
            this.LocalGameClient.SendCheckCharacterName(this._characterCreate.GetName());
        }

        private function OnMapServerInvitation(_arg_1:ClientEvent):void
        {
            this._gameClient.Disconnect();
            this._gameClient.ConnectMapServer();
        }

        public function OnPlayerRespawned(_arg_1:ClientEvent):void
        {
            CharacterStorage.Instance.OnChangeMap();
            this.CloseAllWindows();
        }

        public function OnPlayerResurrected(_arg_1:ActorDisplayEvent):void
        {
            if (((!(this._respawnDialog == null)) && (this._respawnDialog.IsShowing)))
            {
                this.SetShortcutsEnabled(true);
                this._respawnDialog.Dispose();
            };
        }

        private function OnEnteredMap(_arg_1:ClientEvent):void
        {
            HelpManager.Instance.ResetHelper();
            this.CreateLoader();
            this._timeToSendUpdate = (this._lastFrameTickTime + 5000);
            this.CloseAllWindows();
            ClientApplication.Instance.ChatHUD.GetLeftBar.StartAutoHideChat();
        }

        private function OnMapMessageEnd(_arg_1:Event):void
        {
        }

        private function OnPlayerDetached(_arg_1:ClientEvent):void
        {
            var _local_5:CharacterInfo;
            ClientApplication.Instance.TopHUD.GetTutorialPanel().SetTutorial(0, TutorialPanel.CLEAR_TUTORIAL);
            this.TopHUD.QuestsPanel.dispose();
            HelpManager.Instance.GetRoadAtlas().Reset();
            HelpManager.Instance.ResetHelper();
            this.StoreGameSessionInfo();
            if (((this._backBufferBitmap) && (this.contains(this._backBufferBitmap))))
            {
                removeChild(this._backBufferBitmap);
            };
            if (((this._topHUD) && (this.contains(this._topHUD))))
            {
                removeChild(this._topHUD);
            };
            if (((this._bottomHUD) && (this.contains(this._bottomHUD))))
            {
                removeChild(this._bottomHUD);
            };
            if (((this._chatHUD) && (this.contains(this._chatHUD))))
            {
                this._chatHUD.GetLeftBar.ClearAllChannels();
                this._chatHUD.GetLeftBar.SetFocus(LeftChatBar.PUBLIC_CHANNEL);
                ClientApplication.Instance.SetChatEnabled(true);
                removeChild(this._chatHUD);
            };
            var _local_2:DisplayObject = this.PartyList.GetUIComponent();
            if (((_local_2) && (this.contains(_local_2))))
            {
                removeChild(_local_2);
            };
            if (((this._fpsTextField) && (this.contains(this._fpsTextField))))
            {
                removeChild(this._fpsTextField);
            };
            this.CloseAllWindows();
            if (this._levelWindow)
            {
                this._levelWindow = null;
            };
            var _local_3:Actors = this.LocalGameClient.ActorList;
            var _local_4:CharacterInfo = _local_3.GetPlayer();
            if (_local_4)
            {
                if (_local_4.Party != null)
                {
                    _local_4.Party = null;
                };
                this.PartyList.UpdatePartyList();
                for each (_local_5 in _local_3.actors)
                {
                    if (_local_5 != null)
                    {
                        _local_3.RemoveActor(_local_5.characterId);
                    };
                };
                delete _local_3.actors[_local_4.characterId];
                this._chatHUD.GetRightBar.RevalidateUsers(_local_3);
                StatusManager.Instance.Clear();
            };
            this.UnregisterInput();
            this._gameClient.Disconnect();
            if (((this._loadingBackground) && (!(this.contains(this._loadingBackground)))))
            {
                this.InitLoadingBackground();
                addChild(this._loadingBackground);
            };
            if (this._loginScreenBG)
            {
                this._loginScreenBG.Hide();
            };
            if (((this._loginPrompt) && (this._loginPrompt.IsShowing())))
            {
                this._loginPrompt.Dispose();
            };
            if (this._connectingToServer != null)
            {
                this._connectingToServer.dispose();
                this._connectingToServer = null;
            };
            if (_arg_1.flag == 0)
            {
                removeEventListener(Event.ENTER_FRAME, this.OnFrameUpdate);
                RenderSystem.Instance.ClearRenderObjects();
                if (this._loginScreenBG == null)
                {
                    this._loginScreenBG = new MovingPerspective(this);
                };
                this._loginScreenBG.Show();
                new CustomOptionPane(JOptionPane.showMessageDialog("", Localization.DLG_PLAYER_DETACHED_MESSAGE, null, null, true));
            }
            else
            {
                this._gameClient.ResetState();
                this.StageResize(null);
                this._criticalError = false;
                if (_arg_1.flag == 1)
                {
                    this._chooseWorldDialog.show();
                }
                else
                {
                    this.LocalGameClient.ConnectLoginServer(lastLogin, lastPassword, serverAddress, int(serverPort));
                };
            };
        }

        public function OnInstanceUpdateMap(_arg_1:InstanceEvent):void
        {
            GameLogic.Instance.OnChangeMap();
        }

        public function OnInstanceJoin(_arg_1:InstanceEvent):void
        {
        }

        public function OnInstanceLeave(_arg_1:InstanceEvent):void
        {
        }

        public function OnInstanceError(_arg_1:InstanceEvent):void
        {
        }

        public function OnInstanceTimeout(_arg_1:InstanceEvent):void
        {
        }

        private function OnSoundEffectRecived(_arg_1:SoundEffectEvent):void
        {
            if (this._settingsWindow.IsPlaySoundsEnabled)
            {
                Music.Instance.PlaySound(Music.ScriptSounds[_arg_1.Name]);
            };
        }

        private function OnPremiumPackResult(_arg_1:PremiumPackEvent):void
        {
            switch (_arg_1.Type)
            {
                case 0:
                    if (_arg_1.Count == 2)
                    {
                        if (this._premiumPackChestWindow == null)
                        {
                            this._premiumPackChestWindow = new PremiumPackChestWindow(true);
                        };
                        this._premiumPackChestWindow.LoadItems(_arg_1.Items);
                        this._premiumPackChestWindow.show();
                    }
                    else
                    {
                        if (this._premiumPackWindow)
                        {
                            this._premiumPackWindow.dispose();
                        };
                        this._premiumPackWindow = new PremiumPackWindow(0, true);
                        this._premiumPackWindow.LoadItems(_arg_1.Items);
                        this._premiumPackWindow.show();
                    };
                    return;
                case 1:
                    if (this._premiumPackWindow)
                    {
                        this._premiumPackWindow.dispose();
                    };
                    this._premiumPackWindow = new PremiumPackWindow(1, true);
                    this._premiumPackWindow.LoadItems(_arg_1.Items);
                    this._premiumPackWindow.show();
                    return;
                case 2:
                    this.GetSocialFriends().UpdateRewardVisitWindow(_arg_1.Items);
                    return;
            };
        }

        public function OpenWitchWindow():void
        {
            this._witchWindow = ((this._witchWindow) || (new WitchWindow()));
            if (this._witchWindow.isShowing())
            {
                this._witchWindow.dispose();
            }
            else
            {
                this._witchWindow.show();
            };
        }

        public function ThisMethodIsDisabled():void
        {
            new CustomOptionPane(JOptionPane.showMessageDialog("", ClientApplication.Localization.METHOD_IS_DISABLED_TEXT, null, null, true, new AttachIcon("AchtungIcon")));
        }

        private function UpdateNetworkClient(_arg_1:uint):void
        {
            if (this._gameClient != null)
            {
                if (((this._gameClient.State >= ClientState.LOADING_MAP) && (this._timeToSendUpdate < this._lastFrameTickTime)))
                {
                    this._gameClient.SendSync();
                    this._gameClient.SendSync2();
                    this._timeToSendUpdate = (this._lastFrameTickTime + 3000);
                    this.UpdateServerTime();
                };
            };
        }

        public function UpdateServerTime():void
        {
            var _local_1:Date = new Date();
            _local_1.setTime((this.timeOnServer * 1000));
            var _local_2:int = (_local_1.getUTCHours() + 3);
            if (_local_2 >= 24)
            {
                _local_2 = (_local_2 - 24);
            };
            var _local_3:uint = _local_1.getUTCMinutes();
            this._serverTimeString = ((((_local_2 < 10) ? ("0" + _local_2) : _local_2.toString()) + ":") + ((_local_3 < 10) ? ("0" + _local_3) : _local_3.toString()));
            this._topHUD.UpdateServerTime(this._serverTimeString);
        }

        public function UpdateElfCounter():void
        {
            this._topHUD.UpdateElfCounter(this.users);
        }

        public function get ServerTimeString():String
        {
            return ((this.timeOnServerInited) ? this._serverTimeString : "");
        }

        public function UpdateWelcomeChatMessage(_arg_1:uint):void
        {
            var _local_2:String;
            var _local_3:InteractiveText;
            var _local_4:ClientConfig;
            if (this._config.GetAppGroupURL != null)
            {
                if ((_arg_1 - this._timeToSendWelcomeChatMessage) < TIME_TO_SEND_WELCOME_CHAT_MESSAGE)
                {
                    return;
                };
                this._timeToSendWelcomeChatMessage = _arg_1;
                _local_2 = ClientApplication.Localization.WELCOME_MESSAGE;
                _local_3 = new InteractiveText((NewChatChannel.WIDTH_CHAT - 30));
                if (((((this._config.CurrentPlatformId == ClientConfig.WEB) || (this._config.CurrentPlatformId == ClientConfig.WEB_TEST)) || (this._config.CurrentPlatformId == ClientConfig.STANDALONE)) || (fromPortal)))
                {
                    _local_4 = new ClientConfig(ClientConfig.WEB);
                    _local_2 = (_local_2 + ((" " + ClientApplication.Localization.APP_SITE_MESSAGE) + " "));
                    _local_3.AddText(HtmlText.update(_local_2, false, 12, HtmlText.fontName, "#FFFFFF"));
                    _local_3.AddLinkText(HtmlText.update((("<u>" + _local_4.GetAppGroupURL) + "</u>"), false, 12, HtmlText.fontName, "#FFFFFF"), this.GotToAppGroupPage, _local_4.GetAppGroupURL);
                }
                else
                {
                    _local_2 = (_local_2 + ((" " + ClientApplication.Localization.APP_GROUP_MESSAGE) + " "));
                    _local_3.AddText(HtmlText.update(_local_2, false, 12, HtmlText.fontName, "#FFFFFF"));
                };
                this._chatHUD.GetLeftBar.PublicChannel.AddNotification(_local_3);
            };
        }

        private function GotToAppGroupPage(_arg_1:String):void
        {
            navigateToURL(new URLRequest(_arg_1));
        }

        private function OnFrameUpdate(_arg_1:Event):void
        {
            var _local_2:uint = getTimer();
            this._lastFrameTime = (Number((_local_2 - this._lastFrameTickTime)) / 1000);
            this._lastFrameTickTime = _local_2;
            this.UpdateNetworkClient(this._lastFrameTickTime);
            RenderSystem.Instance.Update(this._lastFrameTime);
            ExtensionRender.Instance.Update();
            GameLogic.Instance.Update(this._lastFrameTime);
            this._fpsCalculator.Update(this._lastFrameTickTime);
            if (((this._topHUD) && (this.contains(this._topHUD))))
            {
                this._topHUD.RevalidateMiniMap(this._lastFrameTickTime);
                this._topHUD.RevalidateMapPosition();
            };
            if (((this._worldmapWindow) && (this._worldmapWindow.isShowing())))
            {
                this._worldmapWindow.Update(this._lastFrameTickTime);
            };
            this.UpdateWelcomeChatMessage(this._lastFrameTickTime);
            if (((this._topHUD) && (this.contains(this._topHUD))))
            {
                this._topHUD.UpdateArenaData(this._lastFrameTickTime);
            };
            if ((this._lastFrameTickTime - this._timeToClick) >= 250)
            {
                this._limitClick = true;
                this._timeToClick = this._lastFrameTickTime;
            };
            if ((this._lastFrameTickTime - this._timeToUpdateGui) >= TIME_TO_UPDATE_GUI)
            {
                StatusManager.Instance.Update(this._lastFrameTickTime);
                if (((this._bottomHUD) && (this.contains(this._bottomHUD))))
                {
                    this._bottomHUD.InventoryBarInstance.Update(this._lastFrameTickTime);
                };
                if (this._buffWindow)
                {
                    this._buffWindow.BuffPanelInstance.Update(this._lastFrameTickTime);
                };
                this._fpsTextField.htmlText = HtmlText.update(("Fps: " + this._fpsCalculator.Fps), false, 12, HtmlText.fontName, "#000000");
                this._timeToUpdateGui = this._lastFrameTickTime;
            };
        }

        public function CloseAllWindows():void
        {
            this._topHUD.GetTopHUD._petStatusWindow.visible = false;
            this._topHUD.GetSelectedActorInfo().visible = false;
            if (((this._characterInventory) && (this._characterInventory.isShowing())))
            {
                this._characterInventory.dispose();
            };
            if (((this._levelWindow) && (this._levelWindow.isShowing())))
            {
                this._levelWindow.dispose();
            };
            if (((this._worldmapWindow) && (this._worldmapWindow.isShowing())))
            {
                this._worldmapWindow.dispose();
            };
            if (((this._minimapWindow) && (this._minimapWindow.isShowing())))
            {
                this._minimapWindow.dispose();
            };
            if (((this._skills) && (this._skills.isShowing())))
            {
                this._skills.dispose();
            };
            if (((this._skillsAdvanced) && (this._skillsAdvanced.isShowing())))
            {
                this._skillsAdvanced.dispose();
            };
            if (((this._guildSkillsWindow) && (this._guildSkillsWindow.isShowing())))
            {
                this._guildSkillsWindow.dispose();
            };
            if (((this._settingsWindow) && (this._settingsWindow.isShowing())))
            {
                this._settingsWindow.dispose();
            };
            if (((this._guildWindow) && (this._guildWindow.isShowing())))
            {
                this._guildWindow.dispose();
            };
            if (((this._friendsWindow) && (this._friendsWindow.isShowing())))
            {
                this._friendsWindow.dispose();
            };
            if (((this._storeWindow) && (this._storeWindow.isShowing())))
            {
                this._storeWindow.dispose();
                this._storeWindow = null;
            };
            if (this._cartWindow)
            {
                this._cartWindow.VenderClose();
                if (this._cartWindow.isShowing())
                {
                    this._cartWindow.dispose();
                    this._cartWindow = null;
                };
            };
            if (((this._storageWindow) && (this._storageWindow.isShowing())))
            {
                this._storageWindow.dispose();
                this._storageWindow = null;
                this.LocalGameClient.Storage.State = StorageData.STATE_CLOSED;
                this.LocalGameClient.Storage = null;
            };
            if (((this._shopWindow) && (this._shopWindow.isShowing())))
            {
                this._shopWindow.dispose();
                this._shopWindow = null;
            };
            if (((this._questsWindow) && (this._questsWindow.isShowing())))
            {
                this._questsWindow.dispose();
                this._questsWindow = null;
            };
            if (((this._refineWindow) && (this._refineWindow.isShowing())))
            {
                this._refineWindow.dispose();
                this._refineWindow = null;
            };
            if (((this._upgradeWindow) && (this._upgradeWindow.isShowing())))
            {
                this._upgradeWindow.dispose();
                this._upgradeWindow = null;
            };
            if (((this._stashAuctionWindow) && (this._stashAuctionWindow.isShowing())))
            {
                this._stashAuctionWindow.dispose();
                this._stashAuctionWindow = null;
            };
            if (((this._premiumShopWindow) && (this._premiumShopWindow.isShowing())))
            {
                this._premiumShopWindow.dispose();
                this._premiumShopWindow = null;
            };
            if (this._npcTalkDialog != null)
            {
                this._npcTalkDialog.dispose();
                this._npcTalkDialog = null;
            };
            if (this._npcLocationWindow)
            {
                this._npcLocationWindow.dispose();
                this._npcLocationWindow = null;
            };
            if (((!(this._buffWindow == null)) && (this._buffWindow.isShowing())))
            {
                this._buffWindow.dispose();
                this._buffWindowNeedShow = true;
            };
            if (this._castlesWindow != null)
            {
                this._castlesWindow.dispose();
                this._castlesWindow = null;
            };
            if (this._laddersWindow != null)
            {
                this._laddersWindow.dispose();
                this._laddersWindow = null;
            };
            if (this._witchWindow != null)
            {
                this._witchWindow.dispose();
                this._witchWindow = null;
            };
            if (this._bookWindow != null)
            {
                this._bookWindow.dispose();
                this._bookWindow = null;
            };
            if (((!(this._buyCahsWindow == null)) && (this._buyCahsWindow.isShowing())))
            {
                this._buyCahsWindow.dispose();
            };
            this._topHUD._arenaPanel.visible = false;
        }

        public function GetSkillsWindow():SkillWindow
        {
            return (this._skills);
        }

        public function GetNPCTalkWindow():NPCDialog
        {
            return (this._npcTalkDialog);
        }

        public function GetQuestWindow():QuestsWindow
        {
            return (this._questsWindow);
        }

        public function GetNPCStoreWindow():StoreWindow
        {
            return (this._storeWindow);
        }

        public function GetCharacterInventoryWindow():CharacterInventoryWindow
        {
            return (this._characterInventory);
        }

        public function ValidateTutorialText(_arg_1:String):String
        {
            var _local_2:int;
            var _local_3:String;
            var _local_4:int;
            var _local_5:String;
            if (_arg_1.indexOf("%BaseLevel%") >= 0)
            {
                _local_2 = this.LocalGameClient.ActorList.GetPlayer().baseLevel;
                _local_3 = (_local_2 + " ");
                if (_local_2 == 1)
                {
                    _local_3 = (_local_3 + ClientApplication.Localization.TUTORIAL_WINDOW_STRINGS1[0]);
                }
                else
                {
                    if (((_local_2 > 1) && (_local_2 < 5)))
                    {
                        _local_3 = (_local_3 + ClientApplication.Localization.TUTORIAL_WINDOW_STRINGS1[1]);
                    }
                    else
                    {
                        _local_3 = (_local_3 + ClientApplication.Localization.TUTORIAL_WINDOW_STRINGS1[2]);
                    };
                };
                _arg_1 = _arg_1.replace("%BaseLevel%", _local_3);
            };
            if (_arg_1.indexOf("%JobName%") >= 0)
            {
                _local_4 = this.LocalGameClient.ActorList.GetPlayer().jobId;
                _local_5 = ClientApplication.Localization.TUTORIAL_WINDOW_STRINGS2[_local_4];
                _arg_1 = _arg_1.replace("%JobName%", _local_5);
            };
            return (_arg_1);
        }

        public function get CurrentMapId():String
        {
            return (this._currentMapId);
        }

        public function ConvertDate(_arg_1:String):Number
        {
            var _local_8:Array;
            if (_arg_1 == null)
            {
                return (-1);
            };
            var _local_2:uint;
            var _local_3:uint;
            var _local_4:Array = _arg_1.split(" ");
            if (_local_4.length == 2)
            {
                _arg_1 = _local_4[0];
                _local_8 = _local_4[1].split(":");
                if (_local_8.length == 2)
                {
                    _local_2 = int(_local_8[0]);
                    _local_3 = int(_local_8[1]);
                };
            };
            var _local_5:Array = _arg_1.split(".", 3);
            if (((_local_5 == null) || (!(_local_5.length == 3))))
            {
                return (-1);
            };
            var _local_6:int = int(_local_5[1]);
            _local_6 = ((_local_6 > 0) ? (_local_6 - 1) : 0);
            var _local_7:int = int(_local_5[2]);
            return (new Date(int(_local_5[0]), _local_6, _local_7, _local_2, _local_3, 0, 0).getTime());
        }

        public function GetPopupText(_arg_1:int, _arg_2:Object=null, _arg_3:Object=null, _arg_4:Object=null):String
        {
            var _local_6:String;
            if (Popups == null)
            {
                return (null);
            };
            var _local_5:Object = Popups[_arg_1];
            if (_local_5 != null)
            {
                _local_6 = _local_5.description;
                if (_arg_2 != null)
                {
                    _local_6 = _local_6.replace("%val1%", _arg_2.toString());
                };
                if (_arg_3 != null)
                {
                    _local_6 = _local_6.replace("%val2%", _arg_3.toString());
                };
                if (_arg_4 != null)
                {
                    _local_6 = _local_6.replace("%val3%", _arg_4.toString());
                };
                return (_local_6);
            };
            return (null);
        }

        public function get AuctionInstance():AuctionController
        {
            if (this._auction == null)
            {
                this._auction = new AuctionController();
            };
            return (this._auction);
        }

        public function get MailInstance():MailController
        {
            if (this._mail == null)
            {
                this._mail = new MailController();
            };
            return (this._mail);
        }

        public function get LeftChatBarInstance():LeftChatBar
        {
            return (this._chatHUD.GetLeftBar);
        }

        public function get IsPlayerTalkingWithNPC():Boolean
        {
            return ((this._npcTalkDialog) && (this._npcTalkDialog.isShowing()));
        }

        public function get IsChatHided():Boolean
        {
            return (this._chatHUD.IsChatHided);
        }

        public function get limitClick():Boolean
        {
            return (this._limitClick);
        }

        public function get PartyList():PartyController
        {
            if (!this._partyController)
            {
                this._partyController = new PartyController();
            };
            return (this._partyController);
        }

        public function set limitClick(_arg_1:Boolean):void
        {
            this._limitClick = _arg_1;
        }

        private function InitLoadingBackground():void
        {
            this._loadingBackground.scrollRect = new Rectangle((-(stageWidth) / 2), (-(RenderSystem.Instance.ScreenHeight) / 2), stageWidth, RenderSystem.Instance.ScreenHeight);
            this._loadingBackground.x = 0;
            this._loadingBackground.y = 0;
        }

        public function WallPost(_arg_1:String, _arg_2:String, _arg_3:String):void
        {
            var _local_4:Boolean;
            var _local_5:Boolean;
            var _local_6:Object;
            if (fromPortal > 0)
            {
                ExternalInterface.call("addShare", _arg_2, ClientApplication.Localization.REFERAL_DIALOG_EMAIL_TITLE_WALL, _arg_1, _arg_3);
            }
            else
            {
                if (((!(this._socialWindow == null)) && (!(this._socialWindow.SocialPanel == null))))
                {
                    _local_4 = this._socialWindow.SocialPanel.Data.NetworkApi.GetExternalVars().isAppInstalled;
                    _local_5 = this._socialWindow.SocialPanel.Data.NetworkApi.GetAccessSettings().WallAccess();
                    if (!_local_5)
                    {
                        this._socialWindow.SocialPanel.Data.NetworkApi.CallSettingsBox();
                    };
                    if (((_local_4) && (_local_5)))
                    {
                        _local_6 = {
                            "image":_arg_2,
                            "message":_arg_1,
                            "url":_arg_3
                        };
                        this._socialWindow.SocialPanel.Data.NetworkApi.WallPost(_local_6);
                    };
                };
            };
        }


    }
}