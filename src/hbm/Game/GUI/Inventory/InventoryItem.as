


//hbm.Game.GUI.Inventory.InventoryItem

package hbm.Game.GUI.Inventory
{
    import org.aswing.JLabelButton;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Engine.Actors.ItemData;
    import org.aswing.JPopupMenu;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.event.DragAndDropEvent;
    import flash.events.MouseEvent;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.CharacterEquipment;
    import hbm.Engine.Actors.Actors;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.filters.ColorMatrixFilter;
    import org.aswing.AttachIcon;
    import flash.display.DisplayObject;
    import mx.core.BitmapAsset;
    import hbm.Engine.Actors.StorageData;
    import hbm.Game.GUI.Tutorial.HelpManager;
    import flash.events.Event;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import hbm.Application.GoogleAnalyticsClient;
    import hbm.Game.Utility.HtmlText;
    import hbm.Engine.Renderer.RenderSystem;
    import org.aswing.dnd.DragManager;

    public class InventoryItem extends JLabelButton 
    {

        private static var _toolTip:CustomToolTip;

        protected var _item:ItemData;
        private var _menu:JPopupMenu;
        protected var _itemsLibrary:ItemsResourceLibrary;

        public function InventoryItem(_arg_1:ItemData)
        {
            this._item = _arg_1;
            this._itemsLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            setIcon(this.Icon);
            setDragEnabled(true);
            addEventListener(DragAndDropEvent.DRAG_RECOGNIZED, this.OnStartDrag, false, 0, true);
            addEventListener(MouseEvent.CLICK, this.OnInventoryButtonPressed, false, 0, true);
            addEventListener(MouseEvent.ROLL_OVER, this.OnMouseOver, false, 100, true);
        }

        public static function DisposeTooltip():void
        {
            if (_toolTip != null)
            {
                _toolTip.Dispose();
                _toolTip = null;
            };
        }


        public function Revalidate():void
        {
            var _local_2:InventoryItemToolTip;
            DisposeTooltip();
            var _local_1:String = ((this.Item.Amount > 1) ? (" x" + this.Item.Amount.toString()) : "");
            if (this.Item.NameId == 1)
            {
                setToolTipText(ClientApplication.Localization.INVENTORY_ITEM_FIST);
            }
            else
            {
                _local_2 = new InventoryItemToolTip(this);
                if (_local_2.IsCustomToolTip)
                {
                    _toolTip = new CustomToolTip(this, _local_2, (_local_2.getWidth() - 10), _local_2.getHeight());
                }
                else
                {
                    setToolTipText(((this.Name + " ") + _local_1));
                };
            };
        }

        public function get Name():String
        {
            var _local_3:Boolean;
            var _local_4:Boolean;
            var _local_5:uint;
            var _local_6:uint;
            var _local_7:uint;
            var _local_8:String;
            var _local_9:int;
            var _local_1:String = this._itemsLibrary.GetItemFullName(this._item.NameId);
            var _local_2:int;
            if (this._item.Cards != null)
            {
                _local_3 = (this._item.Cards[0] == 0xFF);
                _local_4 = (this._item.Cards[0] == 254);
                if (((_local_3) || (_local_4)))
                {
                    _local_5 = (this._item.Cards[2] & 0xFFFF);
                    _local_6 = this._item.Cards[3];
                    _local_7 = (_local_5 | (_local_6 << 16));
                    _local_8 = ClientApplication.Instance.LocalGameClient.CharIdToNameList[_local_7];
                    if (!_local_8)
                    {
                        ClientApplication.Instance.LocalGameClient.SendSolveCharName(_local_7);
                        ClientApplication.Instance.LocalGameClient.CharIdToNameList[_local_7] = "";
                    }
                    else
                    {
                        _local_1 = (_local_1 + ((' "' + _local_8) + '"'));
                    };
                    if (this._item.Cards[1] > 0)
                    {
                        _local_1 = (_local_1 + " [1]");
                    };
                }
                else
                {
                    _local_9 = 0;
                    while (((_local_9 < this._item.Cards.length) && (_local_9 < 4)))
                    {
                        if (this._item.Cards[_local_9] > 0)
                        {
                            _local_2++;
                        };
                        _local_9++;
                    };
                    if (_local_2 > 0)
                    {
                        _local_1 = (_local_1 + ((" [" + _local_2.toString()) + "]"));
                    };
                };
            };
            return (_local_1);
        }

        public function GetChatLinkName(_arg_1:Boolean=true):String
        {
            var _local_2:* = ((("[" + this.Refined) + this.Name) + "]");
            if (_arg_1)
            {
                return (((("<font color='" + this.ServerItemDescription["title_color"]) + "'>") + _local_2) + "</font>");
            };
            return (_local_2);
        }

        public function get ServerItemDescription():Object
        {
            return (this._itemsLibrary.GetServerDescriptionObject(this._item.NameId));
        }

        public function get Refined():String
        {
            var _local_3:Boolean;
            var _local_1:* = "";
            var _local_2:Object = this.ServerItemDescription;
            if (_local_2)
            {
                _local_3 = (_local_2["refineable"] == 1);
                _local_1 = (((_local_3) && (this._item.Upgrade > 0)) ? (("+" + this._item.Upgrade) + " ") : "");
            };
            return (_local_1);
        }

        public function get PremiumRefined():String
        {
            var _local_3:Boolean;
            var _local_4:uint;
            var _local_1:* = "";
            var _local_2:Object = this.ServerItemDescription;
            if (_local_2)
            {
                _local_3 = (_local_2["refineable"] == 1);
                _local_4 = ClientApplication.Instance.LocalGameClient.PremiumType;
                if (((_local_4 > 0) && (_local_3)))
                {
                    if (((this._item.Type == ItemData.IT_WEAPON) && (this._item.TypeEquip & (CharacterEquipment.MASK_LEFT_HAND | CharacterEquipment.MASK_RIGHT_HAND))))
                    {
                        _local_1 = (_local_1 + (("<font color='#2CD62C'><b>" + ((_local_4 == 1) ? "+2" : "+5")) + "</b></font> "));
                    }
                    else
                    {
                        if (((this._item.Type == ItemData.IT_ARMOR) && (!(this._item.TypeEquip & CharacterEquipment.MASK_HEAD_MID))))
                        {
                            _local_1 = (_local_1 + ((_local_4 > 1) ? (("<font color='#2CD62C'><b>" + "+1") + "</b></font> ") : ""));
                        };
                    };
                };
            };
            return (_local_1);
        }

        public function get CanAuctionSet():Boolean
        {
            var _local_1:Object;
            var _local_4:Actors;
            var _local_5:int;
            var _local_6:int;
            _local_1 = this._itemsLibrary.GetItemTradeMask(this._item.NameId);
            var _local_2:int = ((_local_1 != null) ? int(_local_1) : 0);
            var _local_3:* = (!((_local_2 & 0x0100) == 0));
            if (((_local_3) && ((this._item.Type == ItemData.IT_WEAPON) || (this._item.Type == ItemData.IT_ARMOR))))
            {
                _local_4 = ClientApplication.Instance.LocalGameClient.ActorList;
                _local_5 = _local_4.GetPlayerFraction();
                _local_6 = ((this._item.Attr & ItemData.ITEM_ATTRIBUTE_FRACTION) ? CharacterInfo.FRACTION_DARK : CharacterInfo.FRACTION_LIGHT);
                _local_3 = (_local_5 == _local_6);
            };
            return (_local_3);
        }

        public function get CanSellItem():int
        {
            var _local_1:AdditionalDataResourceLibrary;
            _local_1 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_2:Object = _local_1.GetCanSellData(this._item.NameId);
            return ((_local_2 != null) ? int(_local_2) : 0);
        }

        public function get IsSoulBondedItem():Boolean
        {
            var _local_1:ItemsResourceLibrary;
            var _local_2:Object;
            _local_1 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            _local_2 = _local_1.GetItemTradeMask(this._item.NameId);
            var _local_3:int = ((_local_2 != null) ? int(_local_2) : 0);
            return (!((_local_3 & 0x80) == 0));
        }

        public function get Icon():AttachIcon
        {
            var _local_3:Boolean;
            var _local_4:Bitmap;
            var _local_5:String;
            var _local_6:Bitmap;
            var _local_7:BitmapData;
            var _local_8:Rectangle;
            var _local_9:Point;
            var _local_10:ColorMatrixFilter;
            var _local_11:Array;
            var _local_1:AttachIcon = this._itemsLibrary.GetItemAttachIcon(this._item.NameId);
            var _local_2:DisplayObject = _local_1.getAsset();
            if (this._item.Identified == 0)
            {
                _local_2.alpha = 0.2;
            }
            else
            {
                if (((this._item.Type == ItemData.IT_ARMOR) || (this._item.Type == ItemData.IT_WEAPON)))
                {
                    _local_3 = (((this._item.Origin == ItemData.CASH) || (this._item.Origin == ItemData.ZENY)) || (this._item.Origin == ItemData.KAFRA));
                    if (!_local_3)
                    {
                        _local_4 = (_local_1.getAsset() as BitmapAsset);
                        _local_5 = ((this._item.Attr & ItemData.ITEM_ATTRIBUTE_FRACTION) ? "AdditionalData_Item_OrcIcon" : "AdditionalData_Item_HumanIcon");
                        _local_6 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetBitmapAsset(_local_5);
                        _local_7 = _local_6.bitmapData;
                        _local_8 = new Rectangle(0, 0, _local_7.width, _local_7.height);
                        _local_9 = new Point(0, 0);
                        _local_4.bitmapData.copyPixels(_local_7, _local_8, _local_9, _local_7, _local_9, true);
                    };
                    if (this.GetDurability() == 0.01)
                    {
                        _local_11 = [0.6, 0, 0, 0, 0, 0, 0.1, 0, 0, 0, 0, 0, 0.1, 0, 0, 0, 0, 0, 1, 0];
                        _local_10 = new ColorMatrixFilter(_local_11);
                        _local_2.filters = [_local_10];
                    };
                };
            };
            return (_local_1);
        }

        public function get Item():ItemData
        {
            return (this._item);
        }

        public function get Type():String
        {
            return (ClientApplication.Localization.ITEMS_TYPE[this._item.Type]);
        }

        protected function OnInventoryButtonPressed(_arg_1:Event):void
        {
            var _local_2:Object;
            var _local_3:int;
            if (!ClientApplication.Instance.limitClick)
            {
                return;
            };
            this._menu = new JPopupMenu();
            if (this._item.Origin != ItemData.QUEST)
            {
                if (ClientApplication.Instance.IsTradeWindowActive)
                {
                    if (this._item.Origin == ItemData.CART)
                    {
                        this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_GETFROMCART).addActionListener(this.OnGetFromCartItem, 0, true);
                        if (this._item.Amount > 1)
                        {
                            this._menu.addMenuItem(((ClientApplication.Localization.INVENTORY_POPUP_GETFROMCART + " ") + ClientApplication.Localization.INVENTORY_POPUP_ALL)).addActionListener(this.OnGetAllFromCart, 0, true);
                        };
                    }
                    else
                    {
                        if ((((this._item.Equip == 0) || (this._item.Type == ItemData.IT_AMMO)) || (this._item.Type == ItemData.IT_SOULSHOT)))
                        {
                            this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_PUTTOTRADE).addActionListener(this.OnPutToTradeItem, 0, true);
                            if (this._item.Amount > 1)
                            {
                                this._menu.addMenuItem(((ClientApplication.Localization.INVENTORY_POPUP_PUTTOTRADE + " ") + ClientApplication.Localization.INVENTORY_POPUP_ALL)).addActionListener(this.OnPutAllToTrade, 0, true);
                            };
                        };
                    };
                    if (((this.IsSoulBondedItem) && (!((this._item.Attr & ItemData.ITEM_ATTRIBUTE_SOULBOND) == 0))))
                    {
                        this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_UNSOULBOND1).addActionListener(this.OnUnsoulbondItemGold, 0, true);
                        this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_UNSOULBOND2).addActionListener(this.OnUnsoulbondItemSilver, 0, true);
                    };
                }
                else
                {
                    if (ClientApplication.Instance.IsCartWindowActive)
                    {
                        if (this._item.Origin == ItemData.CART)
                        {
                            this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_GETFROMCART).addActionListener(this.OnGetFromCartItem, 0, true);
                            if (this._item.Amount > 1)
                            {
                                this._menu.addMenuItem(((ClientApplication.Localization.INVENTORY_POPUP_GETFROMCART + " ") + ClientApplication.Localization.INVENTORY_POPUP_ALL)).addActionListener(this.OnGetAllFromCart, 0, true);
                            };
                        }
                        else
                        {
                            if (ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerIsTrader())
                            {
                                this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_PUTTOCART).addActionListener(this.OnPutToCartItem, 0, true);
                                if (this._item.Amount > 1)
                                {
                                    this._menu.addMenuItem(((ClientApplication.Localization.INVENTORY_POPUP_PUTTOCART + " ") + ClientApplication.Localization.INVENTORY_POPUP_ALL)).addActionListener(this.OnPutAllToCart, 0, true);
                                };
                            };
                        };
                    }
                    else
                    {
                        if (ClientApplication.Instance.LocalGameClient.Storage.State == StorageData.STATE_OPENED)
                        {
                            if (this._item.Origin == ItemData.STORAGE)
                            {
                                this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_GETFROMSTORAGE).addActionListener(this.OnGetFromStorageItem, 0, true);
                                if (this._item.Amount > 1)
                                {
                                    this._menu.addMenuItem(((ClientApplication.Localization.INVENTORY_POPUP_GETFROMSTORAGE + " ") + ClientApplication.Localization.INVENTORY_POPUP_ALL)).addActionListener(this.OnGetAllFromStorage, 0, true);
                                };
                            }
                            else
                            {
                                this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_PUTTOSTORAGE).addActionListener(this.OnPutToStorageItem, 0, true);
                                if (this._item.Amount > 1)
                                {
                                    this._menu.addMenuItem(((ClientApplication.Localization.INVENTORY_POPUP_PUTTOSTORAGE + " ") + ClientApplication.Localization.INVENTORY_POPUP_ALL)).addActionListener(this.OnPutAllToStorage, 0, true);
                                };
                            };
                        }
                        else
                        {
                            if (this._item.Price == 0)
                            {
                                if (this._item.Equip > 0)
                                {
                                    this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_UNEQUIP).addActionListener(this.OnUnequipItem, 0, true);
                                }
                                else
                                {
                                    if (this._item.Identified)
                                    {
                                        if (this._item.TypeEquip > 0)
                                        {
                                            this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_EQUIP).addActionListener(this.OnEquipItem, 0, true);
                                        }
                                        else
                                        {
                                            if (this._item.Type != ItemData.IT_CARD)
                                            {
                                                this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_USE).addActionListener(this.OnUseItem, 0, true);
                                            };
                                        };
                                    };
                                };
                                if (((this._item.Identified) && (this._item.TypeEquip > 0)))
                                {
                                    _local_2 = this.ServerItemDescription;
                                    if (_local_2)
                                    {
                                        _local_3 = _local_2["refineable"];
                                        if (_local_3 == 1)
                                        {
                                            this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_REFINE).addActionListener(this.OnRefineItem, 0, true);
                                        };
                                    };
                                    if (((this._item.Type == ItemData.IT_WEAPON) || (this._item.Type == ItemData.IT_ARMOR)))
                                    {
                                        this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_UPGRADE).addActionListener(this.OnUpgradeItem, 0, true);
                                    };
                                };
                                if (((this._item.Identified) && (this.CanAuctionSet)))
                                {
                                    this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_AUCTION).addActionListener(this.OnSetToAuction, 0, true);
                                };
                                if (((this.IsSoulBondedItem) && (!((this._item.Attr & ItemData.ITEM_ATTRIBUTE_SOULBOND) == 0))))
                                {
                                    this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_UNSOULBOND1).addActionListener(this.OnUnsoulbondItemGold, 0, true);
                                    this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_UNSOULBOND2).addActionListener(this.OnUnsoulbondItemSilver, 0, true);
                                };
                                if ((this._item.Attr & ItemData.ITEM_ATTRIBUTE_RENT) != 0)
                                {
                                    this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_EXTEND_RENT).addActionListener(this.OnExtendRentItem, 0, true);
                                }
                                else
                                {
                                    if ((this._item.Attr & ItemData.ITEM_ATTRIBUTE_KAFRA) != 0)
                                    {
                                        this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_EXTEND_RENT).addActionListener(this.OnExtendKafraItem, 0, true);
                                    };
                                };
                                if (this.CanSellItem != 1)
                                {
                                    if (this._item.Amount > 1)
                                    {
                                        this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_QUICKSELL).addActionListener(this.OnQuickSellItem, 0, true);
                                    }
                                    else
                                    {
                                        this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_SELL).addActionListener(this.OnQuickSellItem, 0, true);
                                    };
                                };
                                if (this._item.Equip <= 0)
                                {
                                    this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_DROP).addActionListener(this.OnDropItem, 0, true);
                                };
                            }
                            else
                            {
                                if (this._item.Price > 0)
                                {
                                    this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_BUY).addActionListener(this.OnBuyItem, 0, true);
                                }
                                else
                                {
                                    this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_SELL).addActionListener(this.OnSellItem, 0, true);
                                };
                            };
                        };
                    };
                };
            };
            this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_INFO).addActionListener(this.OnViewInfo, 0, true);
            if (!ClientApplication.Instance.ChatHUD.IsChatHided)
            {
                this._menu.addMenuItem(ClientApplication.Localization.INVENTORY_POPUP_COPY_TO_CHAT).addActionListener(this.OnAddToChatLink, 0, true);
            };
            this._menu.show(null, (stage.mouseX - 10), (stage.mouseY - 10));
            HelpManager.Instance.ShowMenuItem(this._item.NameId, this._menu);
            ClientApplication.Instance.limitClick = false;
        }

        private function OnAddToChatLink(_arg_1:Event):void
        {
            ClientApplication.Instance.ChatHUD.GetLeftBar.SendItemLink(this);
        }

        private function OnGetFromCartItem(_arg_1:Event):void
        {
            this.GetFromCartItem(1);
        }

        public function GetFromCartItem(_arg_1:int=1):void
        {
            ClientApplication.Instance.CloseUpgradeWindow();
            ClientApplication.Instance.LocalGameClient.SendCartGet(this._item.Id, _arg_1);
            DisposeTooltip();
        }

        private function OnGetAllFromCart(_arg_1:Event):void
        {
            ClientApplication.Instance.CloseUpgradeWindow();
            ClientApplication.Instance.LocalGameClient.SendCartGet(this._item.Id, this._item.Amount);
            DisposeTooltip();
        }

        private function OnPutToCartItem(_arg_1:Event):void
        {
            this.PutToCartItem(1);
        }

        public function PutToCartItem(_arg_1:int=1):void
        {
            ClientApplication.Instance.CloseUpgradeWindow();
            ClientApplication.Instance.LocalGameClient.SendCartAdd(this._item.Id, _arg_1);
            DisposeTooltip();
        }

        private function OnPutAllToCart(_arg_1:Event):void
        {
            ClientApplication.Instance.CloseUpgradeWindow();
            ClientApplication.Instance.LocalGameClient.SendCartAdd(this._item.Id, this._item.Amount);
            DisposeTooltip();
        }

        private function OnPutToTradeItem(_arg_1:Event):void
        {
            this.PutToTradeItem(1);
        }

        public function PutToTradeItem(_arg_1:int=1):void
        {
            ClientApplication.Instance.CloseUpgradeWindow();
            if (ClientApplication.Instance.CheckSellItem(this._item))
            {
                ClientApplication.Instance.LocalGameClient.SendTradeAddItem(this._item.Id, _arg_1);
            };
        }

        private function OnPutAllToTrade(_arg_1:Event):void
        {
            ClientApplication.Instance.CloseUpgradeWindow();
            if (ClientApplication.Instance.CheckSellItem(this._item))
            {
                ClientApplication.Instance.LocalGameClient.SendTradeAddItem(this._item.Id, this._item.Amount);
            };
        }

        private function OnGetFromStorageItem(_arg_1:Event):void
        {
            this.GetFromStorageItem(1);
        }

        public function GetFromStorageItem(_arg_1:int=1):void
        {
            ClientApplication.Instance.CloseUpgradeWindow();
            ClientApplication.Instance.LocalGameClient.SendStorageGet(this._item.Id, _arg_1);
            DisposeTooltip();
        }

        private function OnGetAllFromStorage(_arg_1:Event):void
        {
            ClientApplication.Instance.CloseUpgradeWindow();
            ClientApplication.Instance.LocalGameClient.SendStorageGet(this._item.Id, this._item.Amount);
            DisposeTooltip();
        }

        private function OnPutToStorageItem(_arg_1:Event):void
        {
            this.PutToStorageItem(1);
        }

        public function PutToStorageItem(_arg_1:int=1):void
        {
            ClientApplication.Instance.CloseUpgradeWindow();
            ClientApplication.Instance.LocalGameClient.SendStorageAdd(this._item.Id, _arg_1);
            DisposeTooltip();
        }

        private function OnPutAllToStorage(_arg_1:Event):void
        {
            ClientApplication.Instance.CloseUpgradeWindow();
            ClientApplication.Instance.LocalGameClient.SendStorageAdd(this._item.Id, this._item.Amount);
            DisposeTooltip();
        }

        private function OnUnequipItem(_arg_1:Event):void
        {
            this.UnequipItem();
        }

        public function UnequipItem():void
        {
            ClientApplication.Instance.LocalGameClient.SendUnequipItem(this._item);
            DisposeTooltip();
        }

        private function OnEquipItem(_arg_1:Event):void
        {
            this.EquipItem();
        }

        public function EquipItem(slotMask:int=-1):void
        {
            var actors:Actors;
            ClientApplication.Instance.CloseUpgradeWindow();
            actors = ClientApplication.Instance.LocalGameClient.ActorList;
            var playerFraction:int = actors.GetPlayerFraction();
            var itemFraction:int = ((this._item.Attr & ItemData.ITEM_ATTRIBUTE_FRACTION) ? CharacterInfo.FRACTION_DARK : CharacterInfo.FRACTION_LIGHT);
            if ((((!(playerFraction == itemFraction)) && (!(this._item.Type == ItemData.IT_AMMO))) && (!(this._item.Type == ItemData.IT_SOULSHOT))))
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ((ClientApplication.Localization.INVENTORY_CANT_EQUIP_TITLE + "\n") + ClientApplication.Localization.INVENTORY_CANT_EQUIP_RACE), null, null, true, new AttachIcon("AchtungIcon")));
                return;
            };
            if ((((this._item.Attr & ItemData.ITEM_ATTRIBUTE_SOULBOND) == 0) && (this.IsSoulBondedItem)))
            {
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.INVENTORY_SOULBONDED_ITEM, function OnSoulBondAccepted (_arg_1:int):void
                {
                    if (_arg_1 == JOptionPane.YES)
                    {
                        ClientApplication.Instance.LocalGameClient.SendEquipItem(_item, ((slotMask >= 0) ? slotMask : _item.TypeEquip));
                        DisposeTooltip();
                    };
                }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            }
            else
            {
                ClientApplication.Instance.LocalGameClient.SendEquipItem(this._item, ((slotMask >= 0) ? slotMask : this._item.TypeEquip));
                DisposeTooltip();
            };
        }

        private function OnDropItem(_arg_1:Event):void
        {
            this.DropItem(1);
        }

        public function DropItem(_arg_1:int=1):void
        {
            ClientApplication.Instance.CloseUpgradeWindow();
            ClientApplication.Instance.LocalGameClient.SendItemDrop(this._item, _arg_1);
            DisposeTooltip();
        }

        private function OnRefineItem(_arg_1:Event):void
        {
            this.RefineItem();
        }

        public function RefineItem():void
        {
            ClientApplication.Instance.ShowRefineWindow();
            ClientApplication.Instance.RevalidateRefineWindow(false, false, this._item);
        }

        private function OnUpgradeItem(_arg_1:Event):void
        {
            this.UpgradeItem();
        }

        public function UpgradeItem():void
        {
            ClientApplication.Instance.ShowUpgradeWindow();
            ClientApplication.Instance.RevalidateUpgradeWindow(false, null, this._item);
        }

        private function OnUnsoulbondItemGold(_arg_1:Event):void
        {
            this.UnsoulbondItemInternal(true);
        }

        private function OnUnsoulbondItemSilver(_arg_1:Event):void
        {
            this.UnsoulbondItemInternal(false);
        }

        private function UnsoulbondItemInternal(isGold:Boolean):void
        {
            var msg:String;
            ClientApplication.Instance.CloseUpgradeWindow();
            var price:int;
            var colorType:int = this._itemsLibrary.GetItemColorType(this._item.NameId);
            switch (colorType)
            {
                case ItemData.ICT_GREEN:
                    price = ((isGold) ? 25 : 100000);
                    break;
                case ItemData.ICT_BLUE:
                    price = ((isGold) ? 50 : 250000);
                    break;
                case ItemData.ICT_VIOLET:
                case ItemData.ICT_RED:
                case ItemData.ICT_SILVER:
                    price = ((isGold) ? 75 : 750000);
                    break;
                case ItemData.ICT_ORANGE:
                case ItemData.ICT_GOLD:
                case ItemData.ICT_VIP:
                case ItemData.ICT_VIP2:
                case ItemData.ICT_INDIGO:
                    price = ((isGold) ? 150 : 1500000);
                    break;
                case ItemData.ICT_GRAY:
                case ItemData.ICT_KAFRA:
                    price = 0;
                    break;
            };
            if (price > 0)
            {
                if (isGold)
                {
                    msg = ((ClientApplication.Localization.INVENTORY_ITEM_UNSOULBOND_GOLD_MESSAGE + "") + price);
                }
                else
                {
                    msg = ((ClientApplication.Localization.INVENTORY_ITEM_UNSOULBOND_SILVER_MESSAGE + "") + price);
                };
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, msg, function OnAccepted (_arg_1:int):void
                {
                    if (_arg_1 == JOptionPane.YES)
                    {
                        if (_item.Equip > 0)
                        {
                            ClientApplication.Instance.LocalGameClient.SendUnequipItem(_item);
                        };
                        ClientApplication.Instance.LocalGameClient.SendUnsoulbondItem(_item.Id, isGold);
                    };
                }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            };
        }

        private function OnExtendRentItem(_arg_1:Event):void
        {
            this.ExtendRentItem();
        }

        public function ExtendRentItem():void
        {
            var msg:String;
            ClientApplication.Instance.CloseUpgradeWindow();
            var price:int = 10;
            if (price > 0)
            {
                msg = ((ClientApplication.Localization.INVENTORY_ITEM_EXTEND_RENT_MESSAGE + "") + price);
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, msg, function OnAccepted (_arg_1:int):void
                {
                    if (_arg_1 == JOptionPane.YES)
                    {
                        ClientApplication.Instance.LocalGameClient.SendExtendRentItem(_item.Id);
                    };
                }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            };
        }

        private function OnExtendKafraItem(_arg_1:Event):void
        {
            this.ExtendKafraItem();
        }

        public function ExtendKafraItem():void
        {
            var msg:String;
            ClientApplication.Instance.CloseUpgradeWindow();
            var itemDescription:Object = this.ServerItemDescription;
            var price:int = ((itemDescription) ? itemDescription["price_buy"] : 0);
            if (price > 0)
            {
                price = int((price / 2));
                msg = ((ClientApplication.Localization.INVENTORY_ITEM_EXTEND_KAFRA_MESSAGE + "") + price);
                new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, msg, function OnAccepted (_arg_1:int):void
                {
                    if (_arg_1 == JOptionPane.YES)
                    {
                        ClientApplication.Instance.LocalGameClient.SendExtendKafraItem(_item.Id);
                    };
                }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
            };
        }

        private function OnBuyItem(_arg_1:Event):void
        {
            this.BuyItem(1);
        }

        public function BuyItem(_arg_1:int=1):void
        {
            switch (this._item.Origin)
            {
                case ItemData.VENDER:
                    ClientApplication.Instance.LocalGameClient.SendVenderBuy(this._item.Id, _arg_1);
                    break;
                case ItemData.CASH:
                case ItemData.ZENY:
                    ClientApplication.Instance.LocalGameClient.SendCashShopBuy(0, this._item.NameId, _arg_1);
                    GoogleAnalyticsClient.Instance.trackIngame(((("cash_shop/" + this._item.NameId) + "/") + _arg_1));
                    break;
                case ItemData.KAFRA:
                    ClientApplication.Instance.LocalGameClient.SendCashShopBuy(1, this._item.NameId, _arg_1);
                    GoogleAnalyticsClient.Instance.trackIngame(((("kafra_shop/" + this._item.NameId) + "/") + _arg_1));
                    break;
                default:
                    ClientApplication.Instance.LocalGameClient.SendBuyItem(this._item.NameId, _arg_1);
            };
            DisposeTooltip();
        }

        private function OnSellItem(_arg_1:Event):void
        {
            this.SellItem(1);
        }

        public function SellItem(amount:int=1):void
        {
            ClientApplication.Instance.CloseUpgradeWindow();
            switch (this.CanSellItem)
            {
                case 0:
                    ClientApplication.Instance.LocalGameClient.SendSellItem(this._item.Id, amount);
                    DisposeTooltip();
                    return;
                case 1:
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.ERR_SELL_ITEM, null, null, true, new AttachIcon("AchtungIcon")));
                    return;
                case 2:
                    new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ClientApplication.Localization.INVENTORY_ITEM_SELL_MESSAGE, function OnAccepted (_arg_1:int):void
                    {
                        if (_arg_1 == JOptionPane.YES)
                        {
                            ClientApplication.Instance.LocalGameClient.SendSellItem(_item.Id, amount);
                            DisposeTooltip();
                        };
                    }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
                    return;
            };
        }

        private function OnUseItem(_arg_1:Event):void
        {
            this.UseItem();
        }

        public function UseItem():void
        {
            var _local_1:CharacterInfo = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            var _local_2:int = this._item.NameId;
            if (this._item.Type == ItemData.IT_CARD)
            {
                ClientApplication.Instance.ShowUpgradeWindow();
                ClientApplication.Instance.RevalidateUpgradeWindow(true, null);
            }
            else
            {
                if (this._item.Type == ItemData.IT_PETEGG)
                {
                    ClientApplication.Instance.LocalGameClient.SendPetHatch(this._item.Id);
                }
                else
                {
                    if ((((_local_2 >= 0x5D5D) && (_local_2 <= 23909)) || ((_local_2 >= 23950) && (_local_2 <= 23999))))
                    {
                        ClientApplication.Instance.ShowRefineWindow();
                        ClientApplication.Instance.RevalidateRefineWindow(false, false, null, this._item);
                    }
                    else
                    {
                        if (ClientApplication.Instance.BottomHUD.InventoryBarInstance.CheckCooldownItem(_local_2))
                        {
                            ClientApplication.Instance.BottomHUD.InventoryBarInstance.DoCooldownItemSlots(_local_2);
                            ClientApplication.Instance.LocalGameClient.SendItemUse(this._item.Id, _local_1.characterId);
                            HelpManager.Instance.UseItem(_local_2);
                        };
                    };
                };
            };
            if ((((_local_2 >= 24112) && (_local_2 <= 24114)) || (_local_2 == 24120)))
            {
                ClientApplication.Instance._currentCraftItemId = _local_2;
            };
        }

        private function OnQuickSellItem(_arg_1:Event):void
        {
            this.QuickSellItem();
        }

        public function QuickSellItem():void
        {
            ClientApplication.Instance.CloseUpgradeWindow();
            var price:int = this.PriceSell;
            var message:String = HtmlText.GetText(ClientApplication.Localization.INVENTORY_ITEM_QUICKSELL_MESSAGE, ((this.Item.Amount > 1) ? ((this.Name + " x") + this.Item.Amount) : this.Name));
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.DLG_WARNING, ((message + " ") + (price * this._item.Amount)), function OnAccepted (_arg_1:int):void
            {
                if (_arg_1 == JOptionPane.YES)
                {
                    ClientApplication.Instance.LocalGameClient.SendAutoSellItem(_item.Id);
                    DisposeTooltip();
                };
            }, null, true, new AttachIcon("AchtungIcon"), (JOptionPane.YES + JOptionPane.NO)));
        }

        protected function OnViewInfo(_arg_1:Event):void
        {
            this.Action(this);
        }

        public function Action(_arg_1:InventoryItem):void
        {
            var _local_2:InventoryItemPopup;
            _local_2 = new InventoryItemPopup(((_arg_1.Item.Identified == 1) ? _arg_1.Name : ClientApplication.Localization.UNKNOWN_ITEM), _arg_1);
            var _local_3:int = Math.min(ClientApplication.Instance.stage.mouseX, (RenderSystem.Instance.ScreenWidth - _local_2.getWidth()));
            var _local_4:int = Math.min(ClientApplication.Instance.stage.mouseY, (RenderSystem.Instance.ScreenHeight - _local_2.getHeight()));
            _local_2.setLocationXY(_local_3, _local_4);
            _local_2.show();
        }

        public function get PriceBuy():int
        {
            var _local_2:Boolean;
            var _local_3:Boolean;
            var _local_1:Object = this.ServerItemDescription;
            _local_2 = (this._item.Origin == ItemData.CASH);
            _local_3 = (this._item.Origin == ItemData.KAFRA);
            var _local_4:int = (((((this._item.Origin == ItemData.VENDER) || (this._item.Origin == ItemData.NPCSHOP)) || (_local_2)) || (_local_3)) ? this._item.Price : ((_local_1) ? int(_local_1["price_buy"]) : 0));
            return (_local_4);
        }

        public function get PriceSell():int
        {
            var _local_2:Boolean;
            var _local_3:Boolean;
            var _local_1:Object = this.ServerItemDescription;
            _local_2 = (this._item.Origin == ItemData.CASH);
            _local_3 = (this._item.Origin == ItemData.KAFRA);
            var _local_4:int = (((((this._item.Origin == ItemData.VENDER) || (this._item.Origin == ItemData.NPCSHOP)) || (_local_2)) || (_local_3)) ? this._item.Price : ((_local_1) ? int(_local_1["price_buy"]) : 0));
            var _local_5:int = ((_local_1) ? int(_local_1["price_sell"]) : 0);
            if (_local_5 == 0)
            {
                _local_5 = (((_local_2) || (_local_3)) ? (_local_4 * 100) : int((_local_4 / 2)));
            };
            return (_local_5);
        }

        public function get ColorType():int
        {
            return (this._itemsLibrary.GetItemColorType(this._item.NameId));
        }

        public function GetMaxDurability(_arg_1:Boolean=false):Number
        {
            var _local_4:int;
            var _local_2:Object = this.ServerItemDescription;
            var _local_3:int = ((_local_2) ? int(_local_2["type"]) : 0);
            if (((_local_3 == ItemData.IT_ARMOR) || (_local_3 == ItemData.IT_WEAPON)))
            {
                _local_4 = this._itemsLibrary.GetItemMaxDurability(this._item.NameId);
                if ((((this._item.Cards[4] & 0x300000) > 0) || (_local_4 == 0)))
                {
                    return (0);
                };
                if (((!(_arg_1)) && ((this._item.Cards[4] == 0) || ((this._item.Cards[4] & 0x100000) > 0))))
                {
                    return (100);
                };
                return (_local_4 / 100);
            };
            return (0);
        }

        public function GetDurability(_arg_1:int=-1):Number
        {
            var _local_2:Number = -1;
            if (_arg_1 < 0)
            {
                _arg_1 = this.GetMaxDurability();
            };
            if (_arg_1 > 0)
            {
                if (this._item.Cards[4] == 0)
                {
                    _local_2 = 100;
                }
                else
                {
                    _local_2 = ((this._item.Cards[4] & 0x0FFFFF) / 100);
                };
                if (_local_2 > _arg_1)
                {
                    _local_2 = _arg_1;
                };
            }
            else
            {
                _local_2 = -1;
            };
            return (_local_2);
        }

        public function GetDurabilityText(_arg_1:Number=-1, _arg_2:Number=-1):String
        {
            var _local_5:String;
            var _local_6:Number;
            var _local_3:Number = ((_arg_2 > 0) ? _arg_2 : this.GetMaxDurability());
            var _local_4:Number = ((_arg_1 > 0) ? _arg_1 : this.GetDurability(_local_3));
            if (_local_4 == 0.01)
            {
                _local_5 = "FF0000";
            }
            else
            {
                _local_6 = ((_local_4 * 100) / _local_3);
                if (_local_6 <= 25)
                {
                    _local_5 = "FF8000";
                }
                else
                {
                    if (_local_6 <= 50)
                    {
                        _local_5 = "FFFF00";
                    }
                    else
                    {
                        _local_5 = "00FF00";
                    };
                };
            };
            return (((((("<font color='#" + _local_5) + "'>") + ((_local_4 == 0.01) ? 0 : Math.ceil(_local_4))) + " / ") + int(_local_3)) + "</font>");
        }

        public function GetRepairPrice(_arg_1:Boolean):int
        {
            var _local_4:AdditionalDataResourceLibrary;
            var _local_2:Number = this.GetMaxDurability();
            if (_local_2 <= 0)
            {
                return (-1);
            };
            var _local_3:Number = this.GetDurability(_local_2);
            _local_4 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            var _local_5:Object = _local_4.GetDurabilityData(this._item.Type, this.ColorType);
            if (_local_5 == null)
            {
                return (-1);
            };
            var _local_6:int = ((_arg_1) ? _local_5.PriceGold : _local_5.PriceSilver);
            if (_local_3 == 0)
            {
                return (_local_6);
            };
            var _local_7:Number = (100 - ((_local_3 * 100) / _local_2));
            _local_6 = int(Math.max(1, int(((_local_6 * _local_7) / 100))));
            return (_local_6);
        }

        protected function OnStartDrag(_arg_1:DragAndDropEvent):void
        {
            DragManager.startDrag(_arg_1.getDragInitiator(), null, null, new InventoryDnd());
        }

        private function OnSetToAuction(_arg_1:Event):void
        {
            ClientApplication.Instance.ThisMethodIsDisabled();
        }

        private function OnMouseOver(_arg_1:MouseEvent):void
        {
            this.Revalidate();
        }


    }
}//package hbm.Game.GUI.Inventory

