


//hbm.Game.GUI.Craft.ArrowItemPanel

package hbm.Game.GUI.Craft
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Inventory.InventoryStoreItem;
    import org.aswing.JLabel;
    import hbm.Game.GUI.Tools.CustomWindow;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import hbm.Engine.Actors.CharacterInfo;
    import org.aswing.JScrollPane;
    import hbm.Engine.Actors.ItemData;
    import hbm.Game.GUI.Inventory.InventoryItem;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import hbm.Application.ClientApplication;
    import org.aswing.SoftBoxLayout;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import hbm.Game.Character.Character;
    import org.aswing.BorderLayout;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.event.AWEvent;

    public class ArrowItemPanel extends JPanel 
    {

        private var _item:InventoryStoreItem;
        private var _quantityLabel:JLabel;
        private var _descriptionLabel:JLabel;
        private var _parent:CustomWindow;

        public function ArrowItemPanel(_arg_1:ItemData, _arg_2:CustomWindow)
        {
            var _local_14:Object;
            var _local_15:ItemsResourceLibrary;
            var _local_16:JLabel;
            var _local_17:CharacterInfo;
            var _local_18:int;
            var _local_19:int;
            var _local_20:JPanel;
            var _local_21:JScrollPane;
            var _local_22:Object;
            var _local_23:int;
            var _local_24:Object;
            var _local_25:ItemData;
            var _local_26:InventoryItem;
            var _local_27:JLabel;
            var _local_28:JLabel;
            var _local_29:JPanel;
            var _local_30:JPanel;
            super();
            this._parent = _arg_2;
            this._item = new InventoryStoreItem(_arg_1);
            var _local_3:LineBorder = new LineBorder(null, new ASColor(4280421), 1, 4);
            var _local_4:EmptyBorder = new EmptyBorder(null, new Insets(4, 0, 0, 0));
            setBorder(_local_4);
            setPreferredWidth(455);
            setPreferredHeight(160);
            var _local_5:String = ((this._item.Item.Identified == 1) ? this._item.Name : (this._item.Name + "?"));
            this._descriptionLabel = new JLabel(_local_5, null, JLabel.LEFT);
            this._descriptionLabel.setPreferredWidth(180);
            this._descriptionLabel.setMaximumWidth(180);
            this._quantityLabel = new JLabel(((this._item.Item.Amount + " ") + ClientApplication.Localization.CRAFT_WINDOW_QUANTITY), null, JLabel.LEFT);
            var _local_6:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0));
            _local_6.append(this._descriptionLabel);
            _local_6.append(this._quantityLabel);
            var _local_7:Object = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetArrowsCraftData(this._item.Item.NameId);
            var _local_8:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            _local_8.setBorder(_local_3);
            if (_local_7)
            {
                _local_14 = _local_7["RewardItemList"];
                _local_15 = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
                _local_16 = new JLabel(ClientApplication.Localization.CRAFT_WINDOW_RESULT, null, JLabel.LEFT);
                _local_8.append(_local_16);
                _local_17 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer();
                _local_18 = Character.GetFraction(_local_17.jobId, _local_17.clothesColor);
                _local_19 = ((_local_18 == CharacterInfo.FRACTION_DARK) ? ItemData.ITEM_ATTRIBUTE_FRACTION : 0);
                _local_20 = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0));
                _local_21 = new JScrollPane(_local_20, JScrollPane.SCROLLBAR_AS_NEEDED, JScrollPane.SCROLLBAR_NEVER);
                _local_21.setPreferredHeight(90);
                _local_21.setPreferredWidth(200);
                _local_21.setBorder(_local_4);
                for each (_local_22 in _local_14)
                {
                    _local_23 = _local_22.Item;
                    _local_24 = _local_15.GetServerDescriptionObject(_local_23);
                    _local_25 = new ItemData();
                    _local_25.Amount = _local_22.Count;
                    _local_25.NameId = _local_23;
                    _local_25.Identified = 1;
                    _local_25.Attr = _local_19;
                    _local_25.Origin = ItemData.QUEST;
                    _local_25.Type = _local_24["type"];
                    _local_26 = new InventoryItem(_local_25);
                    _local_27 = new JLabel(_local_26.Name, null, JLabel.LEFT);
                    _local_27.setPreferredWidth(180);
                    _local_27.setMaximumWidth(180);
                    _local_28 = new JLabel(((_local_25.Amount + " ") + ClientApplication.Localization.CRAFT_WINDOW_QUANTITY), null, JLabel.LEFT);
                    _local_29 = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0));
                    _local_29.append(_local_27);
                    _local_29.append(_local_28);
                    _local_30 = new JPanel(new BorderLayout());
                    _local_30.setBorder(_local_4);
                    _local_30.append(_local_26, BorderLayout.WEST);
                    _local_30.append(_local_29, BorderLayout.CENTER);
                    _local_20.append(_local_30);
                };
                _local_8.append(_local_21);
            };
            var _local_9:CustomButton = new CustomButton(ClientApplication.Localization.CRAFT_WINDOW_USE_BUTTON);
            _local_9.addActionListener(this.OnUsePressed, 0, true);
            var _local_10:JPanel = new JPanel(new BorderLayout());
            _local_10.setBorder(_local_4);
            _local_10.append(this._item, BorderLayout.WEST);
            _local_10.append(_local_6, BorderLayout.CENTER);
            var _local_11:JLabel = new JLabel(ClientApplication.Localization.CRAFT_WINDOW_ITEM, null, JLabel.LEFT);
            var _local_12:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS));
            _local_12.setBorder(_local_3);
            _local_12.append(_local_11);
            _local_12.append(_local_10);
            var _local_13:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 4));
            _local_13.setBorder(_local_4);
            _local_13.append(_local_12);
            _local_13.append(_local_8);
            append(_local_13, BorderLayout.NORTH);
            append(_local_9, BorderLayout.PAGE_END);
            pack();
        }

        public function get Item():InventoryStoreItem
        {
            return (this._item);
        }

        private function OnUsePressed(_arg_1:AWEvent):void
        {
            ClientApplication.Instance.LocalGameClient.SendArrowSelect(this._item.Item);
            this._parent.dispose();
        }


    }
}//package hbm.Game.GUI.Craft

