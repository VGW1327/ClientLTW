


//hbm.Game.GUI.Inventory.InventoryDnd

package hbm.Game.GUI.Inventory
{
    import org.aswing.dnd.DragListener;
    import org.aswing.event.DragAndDropEvent;
    import org.aswing.Component;
    import hbm.Game.GUI.DndTargets;
    import org.aswing.dnd.DragManager;
    import org.aswing.dnd.RejectedMotion;
    import hbm.Game.GUI.CharacterStats.InventoryStatsItem;
    import hbm.Game.GUI.Refine.InventoryRefineItem;
    import hbm.Game.GUI.Refine.InventoryGemItem;
    import hbm.Game.GUI.Runes.InventoryUpgradeItem;
    import hbm.Game.GUI.Runes.InventoryUpgradeRuneItem;
    import hbm.Game.GUI.CashShop.Stash.InventoryCraftItem;
    import hbm.Game.GUI.CashShop.Stash.InventoryCraftRuneItem;
    import hbm.Game.GUI.CashShop.Stash.InventoryVioletSellItem;
    import hbm.Game.GUI.Trade.InventoryTradeItem;
    import hbm.Application.ClientApplication;
    import org.aswing.JPanel;
    import hbm.Engine.Actors.HotKeys;
    import hbm.Game.GUI.CharacterStats.CharacterStatsItemSlot;
    import hbm.Engine.Actors.CharacterEquipment;
    import hbm.Game.GUI.Refine.RefineItemSlot;
    import hbm.Game.GUI.Refine.GemSlot;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.Runes.UpgradeItemSlot;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.GUI.Runes.RuneSlot;
    import hbm.Game.GUI.CashShop.Stash.CraftItemSlot;
    import hbm.Game.GUI.CashShop.Stash.VioletSellItemSlot;
    import hbm.Game.GUI.*;

    public class InventoryDnd implements DragListener 
    {


        public function onDragStart(_arg_1:DragAndDropEvent):void
        {
        }

        public function onDragEnter(_arg_1:DragAndDropEvent):void
        {
        }

        public function onDragOverring(_arg_1:DragAndDropEvent):void
        {
        }

        public function onDragExit(_arg_1:DragAndDropEvent):void
        {
        }

        public function onDragDrop(_arg_1:DragAndDropEvent):void
        {
            var _local_2:Component;
            var _local_3:Component;
            _local_2 = _arg_1.getTargetComponent();
            _local_3 = _arg_1.getDragInitiator();
            var _local_4:int = _local_3.getClientProperty(DndTargets.DND_TYPE);
            var _local_5:int = ((_local_2) ? _local_2.getClientProperty(DndTargets.DND_TYPE, DndTargets.NOTHING) : DndTargets.NOTHING);
            if (_local_4 == DndTargets.INVENTORY_ITEM)
            {
                switch (_local_5)
                {
                    case DndTargets.INVENTORY_BAR_SLOT:
                        this.ItemDroppedOnBar(_local_3, _local_2);
                        break;
                    case DndTargets.INVENTORY_STATS_SLOT:
                        this.ItemDroppedOnStatsSlot(_local_3, _local_2);
                        break;
                    case DndTargets.STORAGE_PANEL:
                        this.ItemDroppedOnStorage(_local_3);
                        break;
                    case DndTargets.CART_PANEL:
                        this.ItemDroppedOnCart(_local_3);
                        break;
                    case DndTargets.REFINE_ITEM_SLOT:
                        this.ItemDroppedOnRefineSlot(_local_3, _local_2);
                        break;
                    case DndTargets.REFINE_GEM_SLOT:
                        this.ItemDroppedOnGemSlot(_local_3, _local_2);
                        break;
                    case DndTargets.UPGRADE_ITEM_SLOT:
                        this.ItemDroppedOnUpgradeSlot(_local_3, _local_2);
                        break;
                    case DndTargets.UPGRADE_RUNE_SLOT:
                        this.ItemDroppedOnRuneSlot(_local_3, _local_2);
                        break;
                    case DndTargets.CRAFT_ITEM_SLOT:
                        this.ItemDroppedOnCraftItemSlot(_local_3, _local_2);
                        break;
                    case DndTargets.CRAFT_RUNE_SLOT:
                        this.ItemDroppedOnRuneCraftSlot(_local_3, _local_2);
                        break;
                    case DndTargets.VIOLET_SELL_ITEM_SLOT:
                        this.ItemDroppedOnVioletSellSlot(_local_3, _local_2);
                        break;
                    case DndTargets.SAFE_TRADE_PANEL:
                        this.ItemDroppedSafeTradePanel(_local_3, _local_2);
                        break;
                    case DndTargets.NOTHING:
                        DragManager.setDropMotion(new RejectedMotion());
                        break;
                };
            }
            else
            {
                if (((_local_4 == DndTargets.EQUIPED_ITEM) || (_local_3 is InventoryStatsItem)))
                {
                    this.RemoveEquipedItem(_local_3);
                }
                else
                {
                    if ((_local_3 is InventoryRefineItem))
                    {
                        this.RemoveRefineItem();
                    }
                    else
                    {
                        if ((_local_3 is InventoryGemItem))
                        {
                            this.RemoveGemItem();
                        }
                        else
                        {
                            if ((_local_3 is InventoryUpgradeItem))
                            {
                                this.RemoveUpgradeItem();
                            }
                            else
                            {
                                if ((_local_3 is InventoryUpgradeRuneItem))
                                {
                                    this.RemoveUpgradeRuneItem((_local_3 as InventoryUpgradeRuneItem));
                                }
                                else
                                {
                                    if ((_local_3 is InventoryCraftItem))
                                    {
                                        this.RemoveCraftItem();
                                    }
                                    else
                                    {
                                        if ((_local_3 is InventoryCraftRuneItem))
                                        {
                                            this.RemoveCraftRuneItem((_local_3 as InventoryCraftRuneItem));
                                        }
                                        else
                                        {
                                            if ((_local_3 is InventoryVioletSellItem))
                                            {
                                                this.RemoveVioletSellItem((_local_3 as InventoryVioletSellItem));
                                            }
                                            else
                                            {
                                                if (((_local_4 == DndTargets.SAFE_TRADE_PANEL) && (_local_3 is InventoryTradeItem)))
                                                {
                                                    this.RemoveTradeItem((_local_3 as InventoryTradeItem));
                                                }
                                                else
                                                {
                                                    if (_local_4 == DndTargets.INVENTORY_SLOT_ITEM)
                                                    {
                                                        if (!ClientApplication.Instance.BottomHUD.IsLocked)
                                                        {
                                                            this.RemoveBarItem(_local_3);
                                                        }
                                                        else
                                                        {
                                                            DragManager.setDropMotion(new RejectedMotion());
                                                        };
                                                    }
                                                    else
                                                    {
                                                        if (((_local_4 == DndTargets.STORAGE_ITEM) && (_local_5 == DndTargets.INVENTORY_PANEL)))
                                                        {
                                                            this.ItemDroppedFromStorage(_local_3);
                                                        }
                                                        else
                                                        {
                                                            if (((_local_4 == DndTargets.CART_ITEM) && (_local_5 == DndTargets.INVENTORY_PANEL)))
                                                            {
                                                                this.ItemDroppedFromCart(_local_3);
                                                            }
                                                            else
                                                            {
                                                                DragManager.setDropMotion(new RejectedMotion());
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
        }

        private function ItemDroppedOnBar(_arg_1:Component, _arg_2:Component):void
        {
            var _local_5:int;
            var _local_3:JPanel = JPanel(_arg_2);
            var _local_4:InventoryItem = InventoryItem(_arg_1);
            if (_local_4.Item.TypeEquip == 0)
            {
                _local_5 = _local_3.getClientProperty(DndTargets.DND_INDEX);
                ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys.SetHotKey(_local_5, HotKeys.HOTKEY_ITEM, _local_4.Item.NameId, 0);
                ClientApplication.Instance.LocalGameClient.SendHotkey(_local_5, HotKeys.HOTKEY_ITEM, _local_4.Item.NameId, 0);
                ClientApplication.Instance.RevalidateInventoryBar();
            }
            else
            {
                DragManager.setDropMotion(new RejectedMotion());
            };
        }

        private function ItemDroppedOnStatsSlot(_arg_1:Component, _arg_2:Component):void
        {
            var _local_3:CharacterStatsItemSlot;
            _local_3 = CharacterStatsItemSlot(_arg_2);
            var _local_4:InventoryItem = InventoryItem(_arg_1);
            var _local_5:int = ((_local_3.SlotId == CharacterEquipment.SLOT_ARROWS) ? CharacterEquipment.MASK_ARROWS : (1 << _local_3.SlotId));
            _local_4.EquipItem(_local_5);
        }

        private function ItemDroppedOnRefineSlot(_arg_1:Component, _arg_2:Component):void
        {
            var _local_5:int;
            var _local_3:RefineItemSlot = RefineItemSlot(_arg_2);
            var _local_4:InventoryItem = InventoryItem(_arg_1);
            if (_local_4.Item.Identified)
            {
                _local_5 = _local_4.ServerItemDescription["refineable"];
                if (_local_5 == 1)
                {
                    _local_3.SetItem(_local_4.Item);
                    _local_3.Revalidate();
                    ClientApplication.Instance.RevalidateRefineWindow();
                }
                else
                {
                    DragManager.setDropMotion(new RejectedMotion());
                };
            }
            else
            {
                DragManager.setDropMotion(new RejectedMotion());
            };
        }

        private function ItemDroppedOnGemSlot(_arg_1:Component, _arg_2:Component):void
        {
            var _local_4:InventoryItem;
            var _local_3:GemSlot = GemSlot(_arg_2);
            _local_4 = InventoryItem(_arg_1);
            var _local_5:ItemData = _local_4.Item;
            if ((((_local_5.NameId >= 0x5D5D) && (_local_5.NameId <= 23909)) || ((_local_5.NameId >= 23950) && (_local_5.NameId <= 23999))))
            {
                _local_3.SetItem(_local_4.Item);
                _local_3.Revalidate();
                ClientApplication.Instance.RevalidateRefineWindow();
            }
            else
            {
                DragManager.setDropMotion(new RejectedMotion());
            };
        }

        private function ItemDroppedOnUpgradeSlot(_arg_1:Component, _arg_2:Component):void
        {
            var _local_4:InventoryItem;
            var _local_7:int;
            var _local_3:UpgradeItemSlot = UpgradeItemSlot(_arg_2);
            _local_4 = InventoryItem(_arg_1);
            var _local_5:int = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerFraction();
            var _local_6:int = ((_local_4.Item.Attr & ItemData.ITEM_ATTRIBUTE_FRACTION) ? CharacterInfo.FRACTION_DARK : CharacterInfo.FRACTION_LIGHT);
            if (((_local_4.Item.Identified) && (_local_5 == _local_6)))
            {
                _local_7 = _local_4.ServerItemDescription["slots"];
                if (_local_7 >= 1)
                {
                    ClientApplication.Instance.RevalidateUpgradeWindow(true);
                    _local_3.SetItem(_local_4.Item);
                    _local_3.Revalidate();
                    ClientApplication.Instance.RevalidateUpgradeWindow();
                }
                else
                {
                    DragManager.setDropMotion(new RejectedMotion());
                };
            }
            else
            {
                DragManager.setDropMotion(new RejectedMotion());
            };
        }

        private function ItemDroppedOnRuneSlot(_arg_1:Component, _arg_2:Component):void
        {
            var _local_4:InventoryItem;
            var _local_3:RuneSlot = RuneSlot(_arg_2);
            _local_4 = InventoryItem(_arg_1);
            var _local_5:ItemData = _local_4.Item;
            if (((_local_5.Type == ItemData.IT_CARD) && (_local_3.SlotType == 0)))
            {
                _local_3.SetItem(_local_4.Item);
                _local_3.Revalidate();
                ClientApplication.Instance.RevalidateUpgradeWindow();
            }
            else
            {
                DragManager.setDropMotion(new RejectedMotion());
            };
        }

        private function ItemDroppedOnCraftItemSlot(_arg_1:Component, _arg_2:Component):void
        {
            var _local_4:InventoryItem;
            var _local_3:CraftItemSlot = CraftItemSlot(_arg_2);
            _local_4 = InventoryItem(_arg_1);
            var _local_5:ItemData = _local_4.Item;
            if (((_local_5.NameId >= 23930) && (_local_5.NameId <= 23939)))
            {
                _local_3.SetItem(_local_4.Item);
                _local_3.Revalidate();
                ClientApplication.Instance.RevalidateCraftRuneWindow();
            }
            else
            {
                DragManager.setDropMotion(new RejectedMotion());
            };
        }

        private function ItemDroppedOnRuneCraftSlot(_arg_1:Component, _arg_2:Component):void
        {
            var _local_3:InventoryItem;
            _local_3 = InventoryItem(_arg_1);
            var _local_4:ItemData = _local_3.Item;
            if (((_local_4.Type == ItemData.IT_CARD) && (_local_4.Amount > 1)))
            {
                ClientApplication.Instance.RevalidateCraftRuneWindow(false, false, _local_3.Item);
            }
            else
            {
                DragManager.setDropMotion(new RejectedMotion());
            };
        }

        private function ItemDroppedOnVioletSellSlot(_arg_1:Component, _arg_2:Component):void
        {
            var _local_3:VioletSellItemSlot = VioletSellItemSlot(_arg_2);
            var _local_4:InventoryItem = InventoryItem(_arg_1);
            if (_local_4.Item.Identified)
            {
                if (_local_3.CheckItem(_local_4.Item))
                {
                    _local_3.SetItem(_local_4.Item);
                    _local_3.Revalidate();
                    ClientApplication.Instance.RevalidateVioletSellWindow();
                }
                else
                {
                    DragManager.setDropMotion(new RejectedMotion());
                };
            }
            else
            {
                DragManager.setDropMotion(new RejectedMotion());
            };
        }

        private function ItemDroppedSafeTradePanel(_arg_1:Component, _arg_2:Component):void
        {
            var _local_3:InventoryItem = InventoryItem(_arg_1);
            if (ClientApplication.Instance.CheckSellItem(_local_3.Item))
            {
                ClientApplication.Instance.LocalGameClient.SendTradeAddItem(_local_3.Item.Id, _local_3.Item.Amount);
            }
            else
            {
                DragManager.setDropMotion(new RejectedMotion());
            };
        }

        private function ItemDroppedOnStorage(_arg_1:Component):void
        {
            var _local_2:InventoryItem = InventoryItem(_arg_1);
            ClientApplication.Instance.LocalGameClient.SendStorageAdd(_local_2.Item.Id, 1);
        }

        private function ItemDroppedOnCart(_arg_1:Component):void
        {
            var _local_2:InventoryItem;
            if (ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerIsTrader())
            {
                _local_2 = InventoryItem(_arg_1);
                ClientApplication.Instance.LocalGameClient.SendCartAdd(_local_2.Item.Id, 1);
            }
            else
            {
                DragManager.setDropMotion(new RejectedMotion());
            };
        }

        private function ItemDroppedFromCart(_arg_1:Component):void
        {
            var _local_2:InventoryItem = InventoryItem(_arg_1);
            ClientApplication.Instance.LocalGameClient.SendCartGet(_local_2.Item.Id, 1);
        }

        private function ItemDroppedFromStorage(_arg_1:Component):void
        {
            var _local_2:InventoryItem = InventoryItem(_arg_1);
            ClientApplication.Instance.LocalGameClient.SendStorageGet(_local_2.Item.Id, 1);
        }

        private function RemoveEquipedItem(_arg_1:Component):void
        {
            var _local_2:InventoryItem = InventoryItem(_arg_1);
            ClientApplication.Instance.LocalGameClient.SendUnequipItem(_local_2.Item);
        }

        private function RemoveRefineItem():void
        {
            ClientApplication.Instance.RevalidateRefineWindow(true, false);
        }

        private function RemoveGemItem():void
        {
            ClientApplication.Instance.RevalidateRefineWindow(false, true);
        }

        private function RemoveUpgradeItem():void
        {
            ClientApplication.Instance.RevalidateUpgradeWindow(true);
        }

        private function RemoveUpgradeRuneItem(_arg_1:InventoryUpgradeRuneItem):void
        {
            ClientApplication.Instance.RevalidateUpgradeWindow(false, _arg_1.Item);
        }

        private function RemoveCraftItem():void
        {
            ClientApplication.Instance.RevalidateCraftRuneWindow(true);
        }

        private function RemoveCraftRuneItem(_arg_1:InventoryCraftRuneItem):void
        {
            ClientApplication.Instance.RevalidateCraftRuneWindow(false, true);
        }

        private function RemoveVioletSellItem(_arg_1:InventoryVioletSellItem):void
        {
            ClientApplication.Instance.RevalidateVioletSellWindow(_arg_1);
        }

        private function RemoveTradeItem(_arg_1:InventoryItem):void
        {
            ClientApplication.Instance.LocalGameClient.SendTradeDelItem(_arg_1.Item.Id, _arg_1.Item.Amount);
        }

        private function RemoveBarItem(_arg_1:Component):void
        {
            var _local_2:InventoryItem;
            var _local_4:int;
            _local_2 = InventoryItem(_arg_1);
            var _local_3:JPanel = _local_2.getClientProperty(DndTargets.DND_SLOT);
            if (_local_3 != null)
            {
                _local_4 = _local_3.getClientProperty(DndTargets.DND_INDEX);
                ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Hotkeys.RemoveHotKey(_local_4);
                ClientApplication.Instance.LocalGameClient.SendHotkey(_local_4, 0, 0, 0);
                ClientApplication.Instance.RevalidateInventoryBar();
            };
        }


    }
}//package hbm.Game.GUI.Inventory

