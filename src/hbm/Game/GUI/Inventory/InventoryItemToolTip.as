


//hbm.Game.GUI.Inventory.InventoryItemToolTip

package hbm.Game.GUI.Inventory
{
    import org.aswing.JPanel;
    import org.aswing.BorderLayout;
    import hbm.Engine.Actors.ItemData;
    import org.aswing.JTextArea;
    import hbm.Game.GUI.PaddedValue;
    import org.aswing.SoftBoxLayout;
    import hbm.Application.ClientApplication;
    import hbm.Engine.Actors.Actors;
    import hbm.Engine.Actors.CharacterInfo;
    import hbm.Game.Utility.ItemTextConvert;
    import hbm.Engine.Actors.CharacterEquipment;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;

    public class InventoryItemToolTip extends JPanel 
    {

        private var _inventoryItem:InventoryItem;
        private var _isCustomToolTip:Boolean = false;

        public function InventoryItemToolTip(_arg_1:InventoryItem)
        {
            super(new BorderLayout());
            this._inventoryItem = _arg_1;
            this.InitUI();
            pack();
        }

        private function InitUI():void
        {
            var _local_5:ItemData;
            var _local_20:String;
            var _local_21:JTextArea;
            var _local_22:int;
            var _local_23:String;
            var _local_24:JTextArea;
            var _local_25:String;
            var _local_26:int;
            var _local_27:int;
            var _local_28:String;
            var _local_29:int;
            var _local_30:JTextArea;
            var _local_31:Boolean;
            var _local_32:Array;
            var _local_33:Boolean;
            var _local_34:Boolean;
            var _local_35:int;
            var _local_36:int;
            var _local_37:PaddedValue;
            var _local_1:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            _local_1.setPreferredWidth(350);
            var _local_2:Number = 0;
            var _local_3:Object = this._inventoryItem.ServerItemDescription;
            if (((!(_local_3)) || (!(_local_3["title_color"]))))
            {
                return;
            };
            var _local_4:Actors = ClientApplication.Instance.LocalGameClient.ActorList;
            this._isCustomToolTip = true;
            _local_5 = this._inventoryItem.Item;
            var _local_6:* = (_local_5.Identified == 1);
            var _local_7:Boolean = ((_local_3) && (_local_3["refineable"] == 1));
            var _local_8:String = (this._inventoryItem.Refined + this._inventoryItem.PremiumRefined);
            var _local_9:* = "";
            var _local_10:Boolean = (((_local_5.Origin == ItemData.CASH) || (_local_5.Origin == ItemData.ZENY)) || (_local_5.Origin == ItemData.KAFRA));
            if (_local_3)
            {
                _local_9 = (_local_9 + (("<font color='" + _local_3["title_color"]) + "'><b>"));
            };
            _local_9 = (_local_9 + (_local_8 + this._inventoryItem.Name));
            if (_local_5.Amount > 1)
            {
                if ((((!(_local_10)) && (!(_local_5.Origin == ItemData.VENDER))) && (!(_local_5.Origin == ItemData.NPCSHOP))))
                {
                    _local_9 = (_local_9 + ((" " + " x") + _local_5.Amount));
                };
            };
            if (_local_3)
            {
                _local_9 = (_local_9 + "</b></font>");
            };
            var _local_11:String = ((_local_6) ? _local_9 : ((ClientApplication.Localization.INVENTORY_POPUP_SEEMS + "\n") + _local_9));
            var _local_12:JTextArea = new JTextArea();
            _local_12.setHtmlText(_local_11);
            _local_12.setEditable(false);
            _local_12.setBackgroundDecorator(null);
            _local_12.getTextField().selectable = false;
            _local_1.append(_local_12);
            _local_2 = _local_12.getTextField().textWidth;
            var _local_13:Boolean = this._inventoryItem.IsSoulBondedItem;
            if (((_local_13) && (!(_local_10))))
            {
                _local_21 = new JTextArea();
                if ((_local_5.Attr & ItemData.ITEM_ATTRIBUTE_SOULBOND) == 0)
                {
                    _local_20 = (("<font color='#00FF00'>" + ClientApplication.Localization.INVENTORY_POPUP_NOT_SOULBONDED_ITEM) + "</font>");
                }
                else
                {
                    _local_20 = (("<font color='#FF0000'>" + ClientApplication.Localization.INVENTORY_POPUP_SOULBONDED_ITEM) + "</font>");
                };
                _local_21.setHtmlText(_local_20);
                _local_21.setEditable(false);
                _local_21.setBackgroundDecorator(null);
                _local_21.getTextField().selectable = false;
                _local_1.append(_local_21);
                _local_2 = Math.max(_local_21.getTextField().textWidth, _local_2);
            };
            var _local_14:int = ((_local_5.Attr & ItemData.ITEM_ATTRIBUTE_FRACTION) ? CharacterInfo.FRACTION_DARK : CharacterInfo.FRACTION_LIGHT);
            if ((((_local_5.Type == ItemData.IT_ARMOR) || (_local_5.Type == ItemData.IT_WEAPON)) && (!(_local_10))))
            {
                _local_22 = _local_4.GetPlayerFraction();
                _local_23 = ((ClientApplication.Localization.INVENTORY_POPUP_FRACTION + " ") + ((_local_14) ? ClientApplication.Localization.FRACTION_DARK : ClientApplication.Localization.FRACTION_LIGHT));
                _local_24 = new JTextArea();
                if (_local_22 != _local_14)
                {
                    _local_23 = (("<font color='#FF0000'>" + _local_23) + "</font>");
                };
                _local_24.setHtmlText(_local_23);
                _local_24.setEditable(false);
                _local_24.setBackgroundDecorator(null);
                _local_24.getTextField().selectable = false;
                _local_1.append(_local_24);
                _local_2 = Math.max(_local_24.getTextField().textWidth, _local_2);
            };
            var _local_15:String = ((ClientApplication.Localization.INVENTORY_POPUP_MIN_LEVEL2 + " ") + (((_local_6) && (_local_3)) ? _local_3["equip_level"] : "?"));
            var _local_16:int = int((((_local_6) && (_local_3)) ? _local_3["equip_level"] : -1));
            var _local_17:JTextArea = new JTextArea();
            var _local_18:int = _local_4.GetPlayer().baseLevel;
            if (((_local_16 > 0) && (_local_18 < _local_16)))
            {
                _local_15 = (("<font color='#FF0000'>" + _local_15) + "</font>");
            };
            _local_17.setHtmlText(_local_15);
            _local_17.setEditable(false);
            _local_17.setBackgroundDecorator(null);
            _local_17.getTextField().selectable = false;
            _local_1.append(_local_17);
            _local_2 = Math.max(_local_17.getTextField().textWidth, _local_2);
            if (((_local_6) && (_local_3)))
            {
                _local_25 = _local_3["Description"];
                if (_local_25 != null)
                {
                    _local_26 = int(_local_3["equip_jobs"]);
                    _local_27 = int(_local_3["equip_upper"]);
                    _local_28 = ItemTextConvert.GetJobsText(((_local_5.Amount > 1) ? -1 : _local_14), _local_26, _local_27, _local_5.Origin);
                    if (_local_28.length > 0)
                    {
                        _local_25 = (_local_25 + ((("\n\n" + ClientApplication.Localization.INVENTORY_POPUP_JOBS) + " ") + _local_28));
                    };
                    _local_29 = int(_local_3["equip_locations"]);
                    if (_local_29 > 0)
                    {
                        _local_31 = (int(_local_3["type"]) == 6);
                        _local_32 = CharacterEquipment.GetEquipSlots(_local_29, _local_31);
                        _local_25 = (_local_25 + ("\n\n" + ItemTextConvert.GetEquipmentText(_local_32, _local_31)));
                    };
                    _local_30 = new JTextArea();
                    _local_30.setHtmlText(ItemTextConvert.ValidateDescriptionText(_local_25, _local_3));
                    _local_30.setEditable(false);
                    _local_30.setBackgroundDecorator(null);
                    _local_30.getTextField().selectable = false;
                    _local_30.getTextField().width = _local_2;
                    _local_1.append(_local_30);
                    _local_2 = Math.max(_local_30.getTextField().textWidth, _local_2);
                };
            };
            if (!_local_10)
            {
                _local_33 = (_local_5.Origin == ItemData.CASH);
                _local_34 = (_local_5.Origin == ItemData.KAFRA);
                _local_35 = (((((_local_5.Origin == ItemData.VENDER) || (_local_5.Origin == ItemData.NPCSHOP)) || (_local_33)) || (_local_34)) ? _local_5.Price : ((_local_3) ? int(_local_3["price_buy"]) : 0));
                _local_36 = ((_local_3) ? int(_local_3["price_sell"]) : 0);
                if (_local_36 == 0)
                {
                    _local_36 = (((_local_33) || (_local_34)) ? (_local_35 * 100) : int((_local_35 / 2)));
                };
                _local_37 = new PaddedValue(ClientApplication.Localization.INVENTORY_POPUP_PRICE_SELL, _local_36.toString(), -1, -1, 0, 0xFFFFFF, 12, true);
                _local_37.setBorder(new EmptyBorder(null, new Insets(0, 3, 0, 0)));
                _local_1.append(_local_37);
            };
            var _local_19:JPanel = new JPanel(new BorderLayout());
            _local_19.setBorder(new EmptyBorder(null, new Insets(6, 4, 2, 4)));
            _local_19.append(_local_1, BorderLayout.CENTER);
            append(_local_19, BorderLayout.CENTER);
            _local_1.setPreferredWidth(Math.min((_local_2 + 10), 350));
        }

        public function get IsCustomToolTip():Boolean
        {
            return (this._isCustomToolTip);
        }


    }
}//package hbm.Game.GUI.Inventory

