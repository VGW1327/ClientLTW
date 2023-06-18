


//hbm.Game.GUI.Craft.ProduceItemPanel

package hbm.Game.GUI.Craft
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Inventory.InventoryStoreItem;
    import hbm.Game.GUI.Tools.CustomWindow;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Actors.CharacterInfo;
    import org.aswing.JLabel;
    import org.aswing.JScrollPane;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.Inventory.InventoryItem;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Application.ClientApplication;
    import hbm.Game.Character.Character;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.SoftBoxLayout;
    import hbm.Game.Character.CharacterStorage;
    import org.aswing.BorderLayout;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.event.AWEvent;

    public class ProduceItemPanel extends JPanel 
    {

        private var _item:InventoryStoreItem;
        private var _parent:CustomWindow;

        public function ProduceItemPanel(_arg_1:int, _arg_2:Array, _arg_3:int, _arg_4:CustomWindow)
        {
            var _local_5:ItemsResourceLibrary;
            var _local_8:CharacterInfo;
            var _local_9:int;
            var _local_25:JLabel;
            var _local_26:JLabel;
            var _local_27:JPanel;
            var _local_28:JScrollPane;
            var _local_29:Object;
            var _local_30:int;
            var _local_31:Object;
            var _local_32:ItemData;
            var _local_33:InventoryItem;
            var _local_34:JLabel;
            var _local_35:ItemData;
            var _local_36:int;
            var _local_37:JLabel;
            var _local_38:JPanel;
            var _local_39:JPanel;
            super();
            this._parent = _arg_4;
            _local_5 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            var _local_6:Object = _local_5.GetServerDescriptionObject(_arg_1);
            var _local_7:ItemData = new ItemData();
            _local_8 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
            _local_9 = Character.GetFraction(_local_8.jobId, _local_8.clothesColor);
            var _local_10:int = ((_local_9 == CharacterInfo.FRACTION_DARK) ? ItemData.ITEM_ATTRIBUTE_FRACTION : 0);
            _local_7.Amount = 1;
            _local_7.NameId = _arg_1;
            _local_7.Identified = 1;
            _local_7.Attr = _local_10;
            _local_7.Origin = ItemData.QUEST;
            _local_7.Type = _local_6["type"];
            var _local_11:int = _local_6["weapon_level"];
            _arg_3 = (_arg_3 - ((_local_11 > 1) ? (_local_11 * 10) : 0));
            this._item = new InventoryStoreItem(_local_7);
            var _local_12:LineBorder = new LineBorder(null, new ASColor(4280421), 1, 4);
            var _local_13:EmptyBorder = new EmptyBorder(null, new Insets(4, 0, 0, 0));
            setBorder(_local_13);
            setPreferredWidth(485);
            setPreferredHeight(200);
            var _local_14:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0));
            var _local_15:String = ((this._item.Item.Identified == 1) ? this._item.Name : (this._item.Name + "?"));
            var _local_16:JLabel = new JLabel(_local_15, null, JLabel.LEFT);
            _local_16.setPreferredWidth(210);
            _local_16.setMaximumWidth(210);
            _local_14.append(_local_16);
            if (this._item.Item.Amount > 1)
            {
                _local_25 = new JLabel(((this._item.Item.Amount + " ") + ClientApplication.Localization.CRAFT_WINDOW_QUANTITY), null, JLabel.LEFT);
                _local_14.append(_local_25);
            };
            var _local_17:JLabel = new JLabel((((ClientApplication.Localization.CRAFT_WINDOW_PERCENT + " ") + _arg_3) + "%"), null, JLabel.LEFT);
            _local_14.append(_local_17);
            var _local_18:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            _local_18.setBorder(_local_12);
            var _local_19:Boolean;
            if (((_arg_2) && (_arg_2.length > 0)))
            {
                _local_19 = true;
                _local_26 = new JLabel(ClientApplication.Localization.CRAFT_WINDOW_REQUARED, null, JLabel.LEFT);
                _local_18.append(_local_26);
                _local_27 = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0));
                _local_28 = new JScrollPane(_local_27, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_NEVER);
                _local_28.setPreferredHeight(130);
                _local_28.setPreferredWidth(210);
                _local_28.setBorder(_local_13);
                for each (_local_29 in _arg_2)
                {
                    _local_30 = _local_29.Item;
                    _local_31 = _local_5.GetServerDescriptionObject(_local_30);
                    _local_32 = new ItemData();
                    _local_32.Amount = _local_29.Count;
                    _local_32.NameId = _local_30;
                    _local_32.Identified = 1;
                    _local_32.Attr = _local_10;
                    _local_32.Origin = ItemData.QUEST;
                    _local_32.Type = _local_31["type"];
                    _local_33 = new InventoryItem(_local_32);
                    _local_34 = new JLabel(_local_33.Name, null, JLabel.LEFT);
                    _local_34.setPreferredWidth(210);
                    _local_34.setMaximumWidth(210);
                    _local_35 = CharacterStorage.Instance.LocalPlayerCharacter.LocalCharacterInfo.GetItemByName(_local_30);
                    _local_36 = ((_local_35) ? _local_35.Amount : 0);
                    if (_local_36 < _local_29.Count)
                    {
                        _local_19 = false;
                    };
                    _local_37 = new JLabel(((_local_36 + " / ") + _local_32.Amount), null, JLabel.LEFT);
                    _local_38 = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0));
                    _local_38.append(_local_34);
                    _local_38.append(_local_37);
                    _local_39 = new JPanel(new BorderLayout());
                    _local_39.setBorder(_local_13);
                    _local_39.append(_local_33, BorderLayout.WEST);
                    _local_39.append(_local_38, BorderLayout.CENTER);
                    _local_27.append(_local_39);
                };
                _local_18.append(_local_28);
            };
            var _local_20:CustomButton = new CustomButton(ClientApplication.Localization.CRAFT_WINDOW_USE_BUTTON);
            _local_20.setEnabled(_local_19);
            _local_20.addActionListener(this.OnUsePressed, 0, true);
            var _local_21:JPanel = new JPanel(new BorderLayout());
            _local_21.setBorder(_local_13);
            _local_21.append(this._item, BorderLayout.WEST);
            _local_21.append(_local_14, BorderLayout.CENTER);
            var _local_22:JLabel = new JLabel(ClientApplication.Localization.CRAFT_WINDOW_RESULT, null, JLabel.LEFT);
            var _local_23:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            _local_23.setBorder(_local_12);
            _local_23.append(_local_22);
            _local_23.append(_local_21);
            var _local_24:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4));
            _local_24.setBorder(_local_13);
            _local_24.append(_local_23);
            _local_24.append(_local_18);
            append(_local_24, BorderLayout.NORTH);
            append(_local_20, BorderLayout.PAGE_END);
            pack();
        }

        public function get Item():InventoryStoreItem
        {
            return (this._item);
        }

        private function OnUsePressed(_arg_1:AWEvent):void
        {
            ClientApplication.Instance.LocalGameClient.SendProduceMix(this._item.Item);
        }


    }
}//package hbm.Game.GUI.Craft

