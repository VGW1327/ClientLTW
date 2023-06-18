


//hbm.Game.GUI.Inventory.InventoryItemPopup

package hbm.Game.GUI.Inventory
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JAdjuster;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.AsWingManager;
    import org.aswing.JPanel;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.PaddedValue;
    import org.aswing.JTextArea;
    import hbm.Engine.Actors.Actors;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import org.aswing.JLabel;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.SoftBoxLayout;
    import org.aswing.geom.IntDimension;
    import org.aswing.JScrollPane;
    import __AS3__.vec.Vector;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.Utility.ItemTextConvert;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Engine.Actors.CharacterEquipment;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.FlowLayout;
    import hbm.Engine.Actors.StorageData;
    import org.aswing.BorderLayout;
    import flash.events.Event;
    import hbm.Game.GUI.Tools.CustomOptionPane;
    import org.aswing.JOptionPane;
    import org.aswing.AttachIcon;
    import hbm.Game.GUI.PremiumShop.PremiumShopWindow;
    import hbm.Game.GUI.*;

    public class InventoryItemPopup extends CustomWindow 
    {

        private const _width:int = 430;
        private const _height:int = 300;

        private var _inventoryItem:InventoryItem;
        private var _amountAdjuster:JAdjuster;
        private var _buttonBuyItem:CustomButton;

        public function InventoryItemPopup(_arg_1:String, _arg_2:InventoryItem)
        {
            var _local_4:Object;
            var _local_3:* = (_arg_2.Item.Identified == 1);
            _local_4 = _arg_2.ServerItemDescription;
            var _local_5:int = ((_local_4) ? _local_4["slots"] : 0);
            var _local_6:int = this._width;
            if (((_local_3) && (_local_5 > 0)))
            {
                _local_6 = (this._width + 60);
            };
            super(AsWingManager.getRoot(), _arg_1, true, _local_6, this._height, true);
            this._inventoryItem = _arg_2;
            this.InitUI();
            pack();
        }

        private function InitUI():void
        {
            var _local_4:JPanel;
            var _local_6:Object;
            var _local_7:ItemData;
            var _local_21:String;
            var _local_25:PaddedValue;
            var _local_27:PaddedValue;
            var _local_29:Boolean;
            var _local_37:PaddedValue;
            var _local_39:PaddedValue;
            var _local_47:String;
            var _local_48:JTextArea;
            var _local_49:Actors;
            var _local_50:int;
            var _local_51:String;
            var _local_52:JTextArea;
            var _local_53:int;
            var _local_54:int;
            var _local_55:String;
            var _local_56:String;
            var _local_57:ItemsResourceLibrary;
            var _local_58:Boolean;
            var _local_59:Array;
            var _local_60:JTextArea;
            var _local_61:JPanel;
            var _local_62:int;
            var _local_63:JPanel;
            var _local_64:CardItemSlot;
            var _local_65:int;
            var _local_66:ItemData;
            var _local_67:Object;
            var _local_68:JLabel;
            var _local_69:CustomButton;
            var _local_70:CustomToolTip;
            var _local_71:CustomButton;
            var _local_72:CustomToolTip;
            var _local_73:CustomButton;
            var _local_74:CustomToolTip;
            var _local_75:CustomButton;
            var _local_76:CustomToolTip;
            var _local_77:CustomButton;
            var _local_78:CustomToolTip;
            var _local_79:CustomButton;
            var _local_80:CustomToolTip;
            var _local_81:CustomButton;
            var _local_82:CustomToolTip;
            var _local_83:CustomButton;
            var _local_84:CustomToolTip;
            var _local_85:CustomButton;
            var _local_86:CustomToolTip;
            var _local_87:CustomButton;
            var _local_88:CustomToolTip;
            var _local_89:CustomButton;
            var _local_90:CustomToolTip;
            var _local_91:CustomButton;
            var _local_92:CustomToolTip;
            var _local_93:CustomButton;
            var _local_94:CustomToolTip;
            var _local_95:CustomButton;
            var _local_96:CustomToolTip;
            var _local_97:CustomButton;
            var _local_98:CustomToolTip;
            var _local_99:CustomButton;
            var _local_100:CustomToolTip;
            var _local_101:int;
            var _local_102:CustomToolTip;
            var _local_103:CustomButton;
            var _local_104:CustomToolTip;
            var _local_1:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4));
            var _local_3:JLabel = new JLabel("", this._inventoryItem.Icon);
            _local_3.setBorder(_local_1);
            _local_3.setPreferredSize(new IntDimension(54, 64));
            _local_2.append(_local_3);
            _local_4 = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4, SoftBoxLayout.TOP));
            _local_4.setPreferredWidth(352);
            _local_4.setMaximumWidth(352);
            var _local_5:JScrollPane = new JScrollPane(_local_4);
            _local_5.setPreferredWidth(375);
            _local_5.setBorder(_local_1);
            _local_6 = this._inventoryItem.ServerItemDescription;
            _local_7 = this._inventoryItem.Item;
            var _local_8:* = (_local_7.Identified == 1);
            var _local_9:Boolean = ((_local_6) && (_local_6["refineable"] == 1));
            var _local_10:String = (this._inventoryItem.Refined + this._inventoryItem.PremiumRefined);
            var _local_11:Vector.<int> = _local_7.Cards;
            var _local_12:* = "";
            if (_local_6)
            {
                _local_12 = (_local_12 + (("<font color='" + _local_6["title_color"]) + "'><b>"));
            };
            _local_12 = (_local_12 + (_local_10 + this._inventoryItem.Name));
            if (_local_7.Amount > 1)
            {
                if ((((((!(_local_7.Origin == ItemData.CASH)) && (!(_local_7.Origin == ItemData.ZENY))) && (!(_local_7.Origin == ItemData.KAFRA))) && (!(_local_7.Origin == ItemData.VENDER))) && (!(_local_7.Origin == ItemData.NPCSHOP))))
                {
                    _local_12 = (_local_12 + ((" " + " x") + _local_7.Amount));
                };
            };
            if (_local_6)
            {
                _local_12 = (_local_12 + "</b></font>");
            };
            var _local_13:String = ((_local_8) ? _local_12 : ((ClientApplication.Localization.INVENTORY_POPUP_SEEMS + "\n") + _local_12));
            var _local_14:JTextArea = new JTextArea();
            _local_14.setHtmlText(_local_13);
            _local_14.setEditable(false);
            _local_14.setBackgroundDecorator(null);
            _local_14.getTextField().selectable = false;
            var _local_15:int = ((_local_6) ? _local_6["slots"] : 0);
            var _local_16:Boolean = ((!(_local_11 == null)) && (_local_11[0] == 0xFF));
            var _local_17:Boolean = this._inventoryItem.IsSoulBondedItem;
            _local_4.append(_local_14);
            if (_local_17)
            {
                _local_48 = new JTextArea();
                if ((_local_7.Attr & ItemData.ITEM_ATTRIBUTE_SOULBOND) == 0)
                {
                    _local_47 = (("<font color='#00FF00'>" + ClientApplication.Localization.INVENTORY_POPUP_NOT_SOULBONDED_ITEM) + "</font>");
                }
                else
                {
                    _local_47 = (("<font color='#FF0000'>" + ClientApplication.Localization.INVENTORY_POPUP_SOULBONDED_ITEM) + "</font>");
                };
                _local_48.setHtmlText(_local_47);
                _local_48.setEditable(false);
                _local_48.setBackgroundDecorator(null);
                _local_48.getTextField().selectable = false;
                _local_4.append(_local_48);
            };
            var _local_18:int = ((_local_7.Attr & ItemData.ITEM_ATTRIBUTE_FRACTION) ? CharacterInfo.FRACTION_DARK : CharacterInfo.FRACTION_LIGHT);
            if (((_local_7.Type == ItemData.IT_ARMOR) || (_local_7.Type == ItemData.IT_WEAPON)))
            {
                _local_49 = ClientApplication.Instance.LocalGameClient.ActorList;
                _local_50 = _local_49.GetPlayerFraction();
                _local_51 = ((ClientApplication.Localization.INVENTORY_POPUP_FRACTION + " ") + ((_local_18) ? ClientApplication.Localization.FRACTION_DARK : ClientApplication.Localization.FRACTION_LIGHT));
                _local_52 = new JTextArea();
                if (_local_50 != _local_18)
                {
                    _local_51 = (("<font color='#FF0000'>" + _local_51) + "</font>");
                };
                _local_52.setHtmlText(_local_51);
                _local_52.setEditable(false);
                _local_52.setBackgroundDecorator(null);
                _local_52.getTextField().selectable = false;
                _local_4.append(_local_52);
            };
            if (((_local_8) && (_local_6)))
            {
                _local_53 = int(_local_6["equip_jobs"]);
                _local_54 = int(_local_6["equip_upper"]);
                _local_55 = _local_6["Description"];
                _local_56 = ItemTextConvert.GetJobsText(((_local_7.Amount > 1) ? -1 : _local_18), _local_53, _local_54, _local_7.Origin);
                if (_local_56.length > 0)
                {
                    _local_55 = (_local_55 + ((("\n\n" + ClientApplication.Localization.INVENTORY_POPUP_JOBS) + " ") + _local_56));
                };
                _local_57 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
                if (_local_7.TypeEquip == 0)
                {
                    _local_7.TypeEquip = _local_57.GetItemTypeEquip(_local_7.NameId);
                };
                if (_local_7.TypeEquip > 0)
                {
                    _local_58 = (_local_7.Type == ItemData.IT_CARD);
                    _local_59 = CharacterEquipment.GetEquipSlots(_local_7.TypeEquip, _local_58);
                    _local_55 = (_local_55 + ("\n\n" + ItemTextConvert.GetEquipmentText(_local_59, _local_58)));
                };
                if (_local_55 != null)
                {
                    _local_60 = new JTextArea();
                    _local_60.setHtmlText(ItemTextConvert.ValidateDescriptionText(_local_55, _local_6));
                    _local_60.setEditable(false);
                    _local_60.getTextField().selectable = false;
                    if (((!(_local_6)) || (!(_local_6["title_color"]))))
                    {
                        _local_60.setWordWrap(true);
                    };
                    _local_60.setBackgroundDecorator(null);
                    _local_4.append(_local_60);
                };
            };
            _local_2.append(_local_5);
            if (_local_8)
            {
                if (_local_15 > 0)
                {
                    _local_61 = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
                    _local_61.setBorder(new EmptyBorder(null, new Insets(0, 6, 0, 0)));
                    _local_61.setPreferredWidth(50);
                    _local_62 = 0;
                    while (_local_62 < _local_15)
                    {
                        _local_64 = new CardItemSlot();
                        if (_local_11 != null)
                        {
                            _local_65 = ((_local_16) ? _local_11[1] : _local_11[_local_62]);
                            if (_local_65 != 0)
                            {
                                _local_66 = new ItemData();
                                _local_67 = _local_57.GetServerDescriptionObject(_local_65);
                                _local_66.Amount = 1;
                                _local_66.NameId = _local_65;
                                _local_66.Identified = 1;
                                _local_66.Origin = ItemData.QUEST;
                                _local_66.Type = ((_local_67) ? _local_67["type"] : 0);
                                _local_66.Attr = _local_7.Attr;
                                _local_64.SetItem(_local_66);
                                _local_61.append(_local_64);
                            };
                        };
                        _local_61.append(_local_64);
                        if (_local_16) break;
                        _local_62++;
                    };
                    _local_63 = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
                    _local_63.setBorder(_local_1);
                    _local_63.append(new JLabel(ClientApplication.Localization.INVENTORY_POPUP_SLOTS));
                    _local_63.append(_local_61);
                    _local_2.append(_local_63);
                };
            };
            var _local_19:String = (((_local_8) && (_local_6)) ? _local_6["attack"] : "?");
            var _local_20:String = (((_local_8) && (_local_6)) ? _local_6["defence"] : "?");
            if (((_local_8) && (_local_6)))
            {
                _local_21 = Number((int(_local_6["weight"]) / 1000)).toString();
            }
            else
            {
                _local_21 = "?";
            };
            var _local_22:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            _local_22.setBorder(_local_1);
            var _local_23:int = (((_local_8) && (_local_15 > 0)) ? 175 : 152);
            var _local_24:String = (((_local_8) && (_local_6)) ? _local_6["equip_level"] : "?");
            _local_25 = new PaddedValue(ClientApplication.Localization.INVENTORY_POPUP_MIN_LEVEL, _local_24, _local_23);
            _local_22.append(_local_25);
            var _local_26:CustomToolTip = new CustomToolTip(_local_25, ClientApplication.Instance.GetPopupText(110), 250, 20);
            _local_27 = new PaddedValue(ClientApplication.Localization.INVENTORY_POPUP_WEIGHT, _local_21, _local_23);
            _local_22.append(_local_27);
            var _local_28:CustomToolTip = new CustomToolTip(_local_27, ClientApplication.Instance.GetPopupText(113), 100, 10);
            _local_29 = (_local_7.Origin == ItemData.CASH);
            var _local_30:* = (_local_7.Origin == ItemData.KAFRA);
            var _local_31:int = ((_local_29) ? 1 : ((_local_30) ? 2 : 0));
            var _local_32:int = (((((_local_7.Origin == ItemData.VENDER) || (_local_7.Origin == ItemData.NPCSHOP)) || (_local_29)) || (_local_30)) ? _local_7.Price : ((_local_6) ? int(_local_6["price_buy"]) : 0));
            var _local_33:int = ((_local_6) ? int(_local_6["price_sell"]) : 0);
            if (_local_33 == 0)
            {
                _local_33 = (((_local_29) || (_local_30)) ? (_local_32 * 100) : int((_local_32 / 2)));
            };
            var _local_34:String = _local_32.toString();
            var _local_35:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            _local_35.setBorder(_local_1);
            var _local_36:int = (((_local_8) && (_local_15 > 0)) ? 201 : 165);
            _local_37 = new PaddedValue(ClientApplication.Localization.INVENTORY_POPUP_PRICE_BUY, _local_34, (_local_36 - 32), 67, _local_31);
            _local_35.append(_local_37);
            var _local_38:CustomToolTip = new CustomToolTip(_local_37, ClientApplication.Instance.GetPopupText(111), 200, 20);
            _local_39 = new PaddedValue(ClientApplication.Localization.INVENTORY_POPUP_PRICE_SELL, _local_33.toString(), (_local_36 - 26), 67, 0);
            _local_35.append(_local_39);
            var _local_40:CustomToolTip = new CustomToolTip(_local_39, ClientApplication.Instance.GetPopupText(112), 250, 20);
            var _local_41:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4));
            _local_41.setBorder(new EmptyBorder(null, new Insets(4, 0, 0, 0)));
            _local_41.append(_local_22);
            _local_41.append(_local_35);
            var _local_42:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 4));
            if (_local_7.Origin != ItemData.QUEST)
            {
                _local_68 = new JLabel(ClientApplication.Localization.INVENTORY_POPUP_AMOUNT);
                if (ClientApplication.Instance.IsTradeWindowActive)
                {
                    if (_local_7.Amount > 1)
                    {
                        this._amountAdjuster = new JAdjuster(3);
                        this._amountAdjuster.setEditable(false);
                        this._amountAdjuster.setValues(1, 1, 1, (_local_7.Amount + 1));
                        _local_42.append(_local_68);
                        _local_42.append(this._amountAdjuster);
                    };
                    if (_local_7.Origin == ItemData.CART)
                    {
                        _local_69 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_GETFROMCART);
                        _local_70 = new CustomToolTip(_local_69, ClientApplication.Instance.GetPopupText(129), 175, 10);
                        _local_69.addActionListener(this.OnGetFromCart, 0, true);
                        _local_42.append(_local_69);
                    }
                    else
                    {
                        _local_71 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_PUTTOTRADE);
                        _local_72 = new CustomToolTip(_local_71, ClientApplication.Instance.GetPopupText(130), 190, 10);
                        _local_71.addActionListener(this.OnPutToTrade, 0, true);
                        _local_42.append(_local_71);
                    };
                }
                else
                {
                    if (ClientApplication.Instance.IsCartWindowActive)
                    {
                        if (_local_7.Amount > 1)
                        {
                            this._amountAdjuster = new JAdjuster(3);
                            this._amountAdjuster.setEditable(false);
                            this._amountAdjuster.setValues(1, 1, 1, (_local_7.Amount + 1));
                            _local_42.append(_local_68);
                            _local_42.append(this._amountAdjuster);
                        };
                        if (_local_7.Origin == ItemData.CART)
                        {
                            _local_73 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_GETFROMCART);
                            _local_74 = new CustomToolTip(_local_73, ClientApplication.Instance.GetPopupText(129), 175, 10);
                            _local_73.addActionListener(this.OnGetFromCart, 0, true);
                            _local_42.append(_local_73);
                        }
                        else
                        {
                            if (ClientApplication.Instance.LocalGameClient.ActorList.GetPlayerIsTrader())
                            {
                                _local_75 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_PUTTOCART);
                                _local_76 = new CustomToolTip(_local_75, ClientApplication.Instance.GetPopupText(130), 190, 10);
                                _local_75.addActionListener(this.OnPutToCart, 0, true);
                                _local_42.append(_local_75);
                            };
                        };
                    }
                    else
                    {
                        if (ClientApplication.Instance.LocalGameClient.Storage.State == StorageData.STATE_OPENED)
                        {
                            if (_local_7.Amount > 1)
                            {
                                this._amountAdjuster = new JAdjuster(3);
                                this._amountAdjuster.setEditable(false);
                                this._amountAdjuster.setValues(1, 1, 1, (_local_7.Amount + 1));
                                _local_42.append(_local_68);
                                _local_42.append(this._amountAdjuster);
                            };
                            if (_local_7.Origin == ItemData.STORAGE)
                            {
                                _local_77 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_GETFROMSTORAGE);
                                _local_78 = new CustomToolTip(_local_77, ClientApplication.Instance.GetPopupText(131), 190, 10);
                                _local_77.addActionListener(this.OnGetFromStorage, 0, true);
                                _local_42.append(_local_77);
                            }
                            else
                            {
                                _local_79 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_PUTTOSTORAGE);
                                _local_80 = new CustomToolTip(_local_79, ClientApplication.Instance.GetPopupText(132), 190, 10);
                                _local_79.addActionListener(this.OnPutToStorage, 0, true);
                                _local_42.append(_local_79);
                            };
                        }
                        else
                        {
                            if (_local_7.Price == 0)
                            {
                                if (_local_7.Equip > 0)
                                {
                                    _local_81 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_UNEQUIP);
                                    _local_82 = new CustomToolTip(_local_81, ClientApplication.Instance.GetPopupText(133), 200, 20);
                                    _local_81.addActionListener(this.OnUnequipItem, 0, true);
                                    _local_42.append(_local_81);
                                }
                                else
                                {
                                    _local_83 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_DROP);
                                    _local_84 = new CustomToolTip(_local_83, ClientApplication.Instance.GetPopupText(134), 250, 20);
                                    _local_83.addActionListener(this.OnDropItem, 0, true);
                                    _local_42.append(_local_83);
                                    if (_local_8)
                                    {
                                        if (_local_7.TypeEquip > 0)
                                        {
                                            _local_85 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_EQUIP);
                                            _local_86 = new CustomToolTip(_local_85, ClientApplication.Instance.GetPopupText(135), 240, 20);
                                            _local_85.addActionListener(this.OnEquipItem, 0, true);
                                            _local_42.append(_local_85);
                                        }
                                        else
                                        {
                                            _local_87 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_USE);
                                            _local_88 = new CustomToolTip(_local_87, ClientApplication.Instance.GetPopupText(136), 190, 10);
                                            _local_87.addActionListener(this.OnUseItem, 0, true);
                                            _local_42.append(_local_87);
                                        };
                                    }
                                    else
                                    {
                                        _local_89 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_IDENTIFY);
                                        _local_90 = new CustomToolTip(_local_89, ClientApplication.Instance.GetPopupText(137), 250, 20);
                                        _local_89.addActionListener(this.OnIdentifyItem, 0, true);
                                        _local_42.append(_local_89);
                                    };
                                };
                                if ((((_local_8) && (_local_6)) && (_local_7.TypeEquip > 0)))
                                {
                                    if (_local_9 == 1)
                                    {
                                        _local_91 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_REFINE);
                                        _local_92 = new CustomToolTip(_local_91, ClientApplication.Instance.GetPopupText(138), 210, 40);
                                        _local_91.addActionListener(this.OnRefineItem, 0, true);
                                        _local_42.append(_local_91);
                                    };
                                    if (((_local_7.Type == ItemData.IT_WEAPON) || (_local_7.Type == ItemData.IT_ARMOR)))
                                    {
                                        _local_93 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_UPGRADE);
                                        _local_94 = new CustomToolTip(_local_93, ClientApplication.Instance.GetPopupText(193), 210, 40);
                                        _local_93.addActionListener(this.OnUpgradeItem, 0, true);
                                        _local_42.append(_local_93);
                                    };
                                };
                                if ((_local_7.Attr & ItemData.ITEM_ATTRIBUTE_RENT) != 0)
                                {
                                    _local_95 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_EXTEND_RENT);
                                    _local_96 = new CustomToolTip(_local_95, ClientApplication.Instance.GetPopupText(209), 210, 40);
                                    _local_95.addActionListener(this.OnExtendRentItem, 0, true);
                                    _local_42.append(_local_95);
                                }
                                else
                                {
                                    if ((_local_7.Attr & ItemData.ITEM_ATTRIBUTE_KAFRA) != 0)
                                    {
                                        _local_97 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_EXTEND_RENT);
                                        _local_98 = new CustomToolTip(_local_97, ClientApplication.Instance.GetPopupText(209), 210, 40);
                                        _local_97.addActionListener(this.OnExtendKafraItem, 0, true);
                                        _local_42.append(_local_97);
                                    };
                                };
                                if (_local_7.Type == ItemData.IT_ETC)
                                {
                                    _local_99 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_QUICKSELL);
                                    _local_100 = new CustomToolTip(_local_99, ClientApplication.Instance.GetPopupText(140), 245, 20);
                                    _local_99.addActionListener(this.OnQuickSellItem, 0, true);
                                    _local_42.append(_local_99);
                                };
                            }
                            else
                            {
                                if ((((((!(_local_7.TypeEquip == 0)) && (!(_local_7.Type == ItemData.IT_CARD))) && (!(_local_7.Type == ItemData.IT_AMMO))) && (!(_local_7.Type == ItemData.IT_SOULSHOT))) || (_local_7.Type == ItemData.IT_PETEGG)))
                                {
                                    _local_101 = 1;
                                }
                                else
                                {
                                    _local_101 = _local_7.Amount;
                                };
                                if (_local_101 > 1)
                                {
                                    this._amountAdjuster = new JAdjuster(3);
                                    this._amountAdjuster.setEditable(false);
                                    this._amountAdjuster.setValues(1, 1, 1, (_local_101 + 1));
                                    _local_42.append(_local_68);
                                    _local_42.append(this._amountAdjuster);
                                };
                                if (_local_7.Price > 0)
                                {
                                    this._buttonBuyItem = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_BUY);
                                    _local_102 = new CustomToolTip(this._buttonBuyItem, ClientApplication.Instance.GetPopupText(139), 200, 20);
                                    this._buttonBuyItem.addActionListener(this.OnBuyItem, 0, true);
                                    _local_42.append(this._buttonBuyItem);
                                }
                                else
                                {
                                    _local_103 = new CustomButton(ClientApplication.Localization.INVENTORY_POPUP_SELL);
                                    _local_104 = new CustomToolTip(_local_103, ClientApplication.Instance.GetPopupText(140), 245, 20);
                                    _local_103.addActionListener(this.OnSellItem, 0, true);
                                    _local_42.append(_local_103);
                                };
                            };
                        };
                    };
                };
            };
            var _local_43:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
            var _local_44:JPanel = new JPanel(new BorderLayout());
            _local_44.setBorder(new EmptyBorder(null, new Insets(4, 0, 0, 0)));
            _local_44.append(_local_42, BorderLayout.WEST);
            _local_44.append(_local_43, BorderLayout.EAST);
            var _local_45:JPanel = new JPanel(new BorderLayout());
            _local_45.setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            _local_45.append(_local_2, BorderLayout.CENTER);
            _local_45.append(_local_41, BorderLayout.PAGE_END);
            var _local_46:JPanel = new JPanel(new BorderLayout());
            _local_46.setBorder(new EmptyBorder(null, new Insets(6, 4, 2, 4)));
            _local_46.append(_local_45, BorderLayout.CENTER);
            _local_46.append(_local_44, BorderLayout.PAGE_END);
            MainPanel.append(_local_46, BorderLayout.CENTER);
        }

        private function OnClose(_arg_1:Event):void
        {
            this.Dispose();
        }

        private function OnDropItem(_arg_1:Event):void
        {
            this.Dispose();
            var _local_2:int = ((this._amountAdjuster) ? this._amountAdjuster.getValue() : 1);
            this._inventoryItem.DropItem(_local_2);
        }

        private function OnUnequipItem(_arg_1:Event):void
        {
            this.Dispose();
            this._inventoryItem.UnequipItem();
        }

        private function OnUseItem(_arg_1:Event):void
        {
            this.Dispose();
            this._inventoryItem.UseItem();
        }

        private function OnQuickSellItem(_arg_1:Event):void
        {
            this.Dispose();
            this._inventoryItem.QuickSellItem();
        }

        private function OnIdentifyItem(_arg_1:Event):void
        {
            this.Dispose();
            new CustomOptionPane(JOptionPane.showMessageDialog(ClientApplication.Localization.INVENTORY_POPUP_IDENTIFY_TITLE, ClientApplication.Localization.INVENTORY_POPUP_IDENTIFY_MESSAGE, null, null, true, new AttachIcon("AchtungIcon")));
        }

        private function OnRefineItem(_arg_1:Event):void
        {
            this.Dispose();
            this._inventoryItem.RefineItem();
        }

        private function OnUpgradeItem(_arg_1:Event):void
        {
            this.Dispose();
            this._inventoryItem.UpgradeItem();
        }

        private function OnExtendRentItem(_arg_1:Event):void
        {
            this.Dispose();
            this._inventoryItem.ExtendRentItem();
        }

        private function OnExtendKafraItem(_arg_1:Event):void
        {
            this.Dispose();
            this._inventoryItem.ExtendKafraItem();
        }

        private function OnBuyItem(_arg_1:Event):void
        {
            this.Dispose();
            var _local_2:int = ((this._amountAdjuster) ? this._amountAdjuster.getValue() : 1);
            this._inventoryItem.BuyItem(_local_2);
        }

        private function OnSellItem(_arg_1:Event):void
        {
            this.Dispose();
            var _local_2:int = ((this._amountAdjuster) ? this._amountAdjuster.getValue() : 1);
            this._inventoryItem.SellItem(_local_2);
        }

        private function OnGetFromCart(_arg_1:Event):void
        {
            this.Dispose();
            var _local_2:int = ((this._amountAdjuster) ? this._amountAdjuster.getValue() : 1);
            this._inventoryItem.GetFromCartItem(_local_2);
        }

        private function OnPutToCart(_arg_1:Event):void
        {
            this.Dispose();
            var _local_2:int = ((this._amountAdjuster) ? this._amountAdjuster.getValue() : 1);
            this._inventoryItem.PutToCartItem(_local_2);
        }

        private function OnPutToTrade(_arg_1:Event):void
        {
            this.Dispose();
            var _local_2:int = ((this._amountAdjuster) ? this._amountAdjuster.getValue() : 1);
            this._inventoryItem.PutToTradeItem(_local_2);
        }

        private function OnGetFromStorage(_arg_1:Event):void
        {
            this.Dispose();
            var _local_2:int = ((this._amountAdjuster) ? this._amountAdjuster.getValue() : 1);
            this._inventoryItem.GetFromStorageItem(_local_2);
        }

        private function OnPutToStorage(_arg_1:Event):void
        {
            this.Dispose();
            var _local_2:int = ((this._amountAdjuster) ? this._amountAdjuster.getValue() : 1);
            this._inventoryItem.PutToStorageItem(_local_2);
        }

        private function OnEquipItem(_arg_1:Event):void
        {
            this.Dispose();
            this._inventoryItem.EquipItem();
        }

        private function OnAnaloguesButton(_arg_1:Event):void
        {
            this.Dispose();
            var _local_2:PremiumShopWindow = ClientApplication.Instance.PremiumShop;
            if (((_local_2 == null) || (!(_local_2.isShowing()))))
            {
                ClientApplication.Instance.OpenCashShop();
            };
        }

        private function Dispose():void
        {
            dispose();
        }

        private function Dumb(_arg_1:Event):void
        {
            ClientApplication.Instance.ThisMethodIsDisabled();
        }


    }
}//package hbm.Game.GUI.Inventory

