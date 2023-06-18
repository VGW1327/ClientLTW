


//hbm.Game.GUI.Refine.RefineWindow

package hbm.Game.GUI.Refine
{
    import hbm.Game.GUI.Tools.CustomWindow;
    import org.aswing.JTextArea;
    import hbm.Game.GUI.Tools.CustomButton;
    import hbm.Application.ClientApplication;
    import org.aswing.JPanel;
    import org.aswing.BorderLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.LineBorder;
    import org.aswing.ASColor;
    import org.aswing.JScrollPane;
    import org.aswing.FlowLayout;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import org.aswing.JLabel;
    import hbm.Engine.Actors.ItemData;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.ResourceManager;
    import flash.events.Event;

    public class RefineWindow extends CustomWindow 
    {

        private const _width:int = 350;
        private const _height:int = 260;

        private var _itemSlot:RefineItemSlot;
        private var _itemDescriptionText:JTextArea;
        private var _gemSlot:GemSlot;
        private var _gemsDescriptionText:JTextArea;
        private var _buttonRefine:CustomButton;
        private var _maxRefine:int = 10;
        private var _blockUpgrade:Boolean = false;

        public function RefineWindow()
        {
            super(null, ClientApplication.Localization.REFINE_WINDOW_TITLE, false, this._width, this._height, true);
            this.InitUI();
            this.Revalidate(false);
            pack();
            setLocationXY(((ClientApplication.stageWidth - this._width) / 2), ((0x0300 - this._height) / 2));
        }

        private function InitUI():void
        {
            var _local_1:JPanel = new JPanel(new BorderLayout());
            _local_1.setBorder(new EmptyBorder(null, new Insets(12, 6, 4, 4)));
            var _local_2:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4, SoftBoxLayout.TOP));
            var _local_3:LineBorder = new LineBorder(null, new ASColor(16767612), 1, 4);
            var _local_4:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 8));
            this._itemSlot = new RefineItemSlot();
            this._itemSlot.Revalidate();
            _local_4.append(this._itemSlot);
            var _local_5:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            _local_5.setBorder(_local_3);
            _local_5.setPreferredWidth(300);
            this._itemDescriptionText = new JTextArea(ClientApplication.Localization.REFINE_WINDOW_ITEM_SLOT_HINT);
            this._itemDescriptionText.setEditable(false);
            this._itemDescriptionText.setWordWrap(true);
            this._itemDescriptionText.setBackgroundDecorator(null);
            this._itemDescriptionText.getTextField().selectable = false;
            var _local_6:JScrollPane = new JScrollPane(this._itemDescriptionText);
            _local_6.setPreferredHeight(80);
            _local_5.append(_local_6);
            _local_4.append(_local_5);
            var _local_7:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 8));
            this._gemSlot = new GemSlot();
            this._gemSlot.Revalidate();
            _local_7.append(this._gemSlot);
            var _local_8:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
            _local_8.setBorder(_local_3);
            _local_8.setPreferredWidth(300);
            this._gemsDescriptionText = new JTextArea(ClientApplication.Localization.REFINE_WINDOW_GEMS_MESSAGE);
            this._gemsDescriptionText.setEditable(false);
            this._gemsDescriptionText.setWordWrap(true);
            this._gemsDescriptionText.setBackgroundDecorator(null);
            this._gemsDescriptionText.getTextField().selectable = false;
            var _local_9:JScrollPane = new JScrollPane(this._gemsDescriptionText);
            _local_9.setPreferredHeight(90);
            _local_8.append(_local_9);
            _local_7.append(_local_8);
            var _local_10:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
            var _local_11:CustomButton = new CustomButton(ClientApplication.Localization.BUTTON_CLOSE);
            this._buttonRefine = new CustomButton(ClientApplication.Localization.REFINE_WINDOW_REFINE_BUTTON);
            var _local_12:CustomToolTip = new CustomToolTip(this._buttonRefine, ClientApplication.Instance.GetPopupText(138), 140, 10);
            this._buttonRefine.addActionListener(this.OnRefine, 0, true);
            _local_11.setToolTipText(ClientApplication.Instance.GetPopupText(2));
            _local_11.addActionListener(this.OnClose, 0, true);
            _local_10.append(this._buttonRefine);
            _local_10.append(_local_11);
            setDefaultButton(_local_11);
            _local_2.append(_local_4);
            _local_2.append(new JLabel(ClientApplication.Localization.REFINE_WINDOW_REFINE_ITEM_MESSAGE, null, JLabel.LEFT));
            _local_2.append(_local_7);
            _local_1.append(_local_2, BorderLayout.CENTER);
            _local_1.append(_local_10, BorderLayout.PAGE_END);
            MainPanel.append(_local_1, BorderLayout.CENTER);
            addEventListener(CustomWindow.CUSTOM_WINDOW_CLOSED, this.OnClose, false, 0, true);
        }

        public function Revalidate(_arg_1:Boolean):void
        {
            var _local_2:ItemData;
            var _local_3:Object;
            var _local_4:int;
            var _local_5:ItemData;
            var _local_6:Object;
            var _local_7:int;
            var _local_8:Boolean;
            var _local_9:String;
            var _local_10:String;
            var _local_11:int;
            var _local_12:int;
            var _local_13:int;
            var _local_14:Object;
            var _local_15:int;
            this._blockUpgrade = false;
            if (this._gemSlot.Item)
            {
                if (_arg_1)
                {
                    this._gemSlot.Item.Revalidate();
                };
                _local_2 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().GetItemByName(this._gemSlot.Item.Item.NameId);
                if (_local_2)
                {
                    _local_3 = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData")).GetGemsData(this._gemSlot.Item.Item.NameId);
                    if (_local_3)
                    {
                        if (((_local_3["Description2"]) && (this._itemSlot.Item)))
                        {
                            _local_4 = this._itemSlot.Item.ColorType;
                            switch (_local_4)
                            {
                                case ItemData.ICT_ORANGE:
                                case ItemData.ICT_GOLD:
                                case ItemData.ICT_VIP:
                                case ItemData.ICT_VIP2:
                                case ItemData.ICT_INDIGO:
                                    switch (this._gemSlot.Item.Item.NameId)
                                    {
                                        case 0x5D5D:
                                        case 23906:
                                            this._blockUpgrade = true;
                                            break;
                                        case 23903:
                                        case 23907:
                                            if (this._itemSlot.Item.Item.Upgrade > 0)
                                            {
                                                this._blockUpgrade = true;
                                            };
                                            break;
                                    };
                                    break;
                            };
                        };
                        if (this._blockUpgrade)
                        {
                            this._gemsDescriptionText.setHtmlText(_local_3["Description2"]);
                        }
                        else
                        {
                            this._gemsDescriptionText.setHtmlText(_local_3["Description"]);
                        };
                    };
                }
                else
                {
                    this.ClearGemSlot();
                    this._gemsDescriptionText.setHtmlText(ClientApplication.Localization.REFINE_WINDOW_GEMS_MESSAGE);
                };
            }
            else
            {
                this._gemsDescriptionText.setHtmlText(ClientApplication.Localization.REFINE_WINDOW_GEMS_MESSAGE);
            };
            if (this._itemSlot.Item)
            {
                if (_arg_1)
                {
                    this._itemSlot.Item.Revalidate();
                };
                _local_5 = ClientApplication.Instance.LocalGameClient.ActorList.GetPlayer().Items[this._itemSlot.Item.Item.Id];
                _local_6 = this._itemSlot.Item.ServerItemDescription;
                if (_local_5)
                {
                    _local_7 = this._itemSlot.Item.Item.Upgrade;
                    _local_8 = ((_local_6) && (_local_6["refineable"] == 1));
                    _local_9 = (this._itemSlot.Item.Refined + this._itemSlot.Item.PremiumRefined);
                    _local_10 = (_local_9 + this._itemSlot.Item.Name);
                    _local_11 = this._itemSlot.Item.Item.Type;
                    this._maxRefine = ((_local_11 == ItemData.IT_WEAPON) ? 20 : 10);
                    if (_local_7 < this._maxRefine)
                    {
                        _local_10 = (_local_10 + ((("\n" + ClientApplication.Localization.REFINE_WINDOW_ITEM_DESCRIPTION1) + " +") + (_local_7 + 1)));
                        if (_local_11 == ItemData.IT_WEAPON)
                        {
                            _local_12 = _local_6["weapon_level"];
                            if (_local_12)
                            {
                                _local_13 = 0;
                                switch (_local_12)
                                {
                                    case 1:
                                        _local_13 = 2;
                                        break;
                                    case 2:
                                        _local_13 = 5;
                                        break;
                                    case 3:
                                        _local_13 = 10;
                                        break;
                                    case 4:
                                        _local_13 = 20;
                                        break;
                                };
                                if (((_local_13 > 0) && (!(this._itemSlot.Item.Item.TypeEquip == 1))))
                                {
                                    _local_10 = (_local_10 + ((((("\n" + ClientApplication.Localization.REFINE_WINDOW_ITEM_DESCRIPTION4) + " ") + ClientApplication.Localization.STAT_ATK) + " +") + _local_13));
                                };
                            };
                        }
                        else
                        {
                            _local_10 = (_local_10 + (((("\n" + ClientApplication.Localization.REFINE_WINDOW_ITEM_DESCRIPTION4) + " ") + ClientApplication.Localization.STAT_DEF) + " +1"));
                        };
                        if (this._gemSlot.Item)
                        {
                            if (_local_3)
                            {
                                _local_14 = ((_local_11 == ItemData.IT_WEAPON) ? _local_3["PercentListWeapon"] : _local_3["PercentListArmor"]);
                                _local_15 = _local_14[_local_7];
                                _local_10 = (_local_10 + (((("\n" + ClientApplication.Localization.REFINE_WINDOW_ITEM_DESCRIPTION3) + " ") + _local_15) + "%"));
                            };
                        }
                        else
                        {
                            _local_10 = (_local_10 + ("\n" + ClientApplication.Localization.REFINE_WINDOW_ITEM_DESCRIPTION2));
                        };
                    };
                    this._itemDescriptionText.setHtmlText(_local_10);
                }
                else
                {
                    this.ClearRefineSlot();
                    this._itemDescriptionText.setHtmlText(ClientApplication.Localization.REFINE_WINDOW_ITEM_SLOT_HINT);
                };
            }
            else
            {
                this._itemDescriptionText.setHtmlText(ClientApplication.Localization.REFINE_WINDOW_ITEM_SLOT_HINT);
            };
            if (this._buttonRefine != null)
            {
                this._buttonRefine.setEnabled(((((!(this._blockUpgrade)) && (this._itemSlot.Item)) && (this._gemSlot.Item)) && (this._itemSlot.Item.Item.Upgrade < this._maxRefine)));
            };
        }

        public function ClearRefineSlot():void
        {
            this._itemSlot.SetItem(null);
            this._itemSlot.Revalidate();
        }

        public function SetRefineSlot(_arg_1:ItemData):void
        {
            this._itemSlot.SetItem(_arg_1);
            this._itemSlot.Revalidate();
        }

        public function SetGemSlot(_arg_1:ItemData):void
        {
            this._gemSlot.SetItem(_arg_1);
            this._gemSlot.Revalidate();
        }

        public function ClearGemSlot():void
        {
            this._gemSlot.SetItem(null);
            this._gemSlot.Revalidate();
        }

        private function OnClose(_arg_1:Event):void
        {
            this.ClearRefineSlot();
            this.ClearGemSlot();
            dispose();
        }

        private function OnRefine(_arg_1:Event):void
        {
            if (((this._itemSlot.Item) && (this._gemSlot.Item)))
            {
                this._buttonRefine.setEnabled(false);
                ClientApplication.Instance.LocalGameClient.SendImprove(this._itemSlot.Item.Item.Id, this._gemSlot.Item.Item.Id);
            };
        }

        public function Complete():void
        {
            this._buttonRefine.setEnabled(((((!(this._blockUpgrade)) && (this._itemSlot.Item)) && (this._gemSlot.Item)) && (this._itemSlot.Item.Item.Upgrade < this._maxRefine)));
        }


    }
}//package hbm.Game.GUI.Refine

