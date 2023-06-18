


//hbm.Game.GUI.CashShop.Stash.CraftRunePanel

package hbm.Game.GUI.CashShop.Stash
{
    import org.aswing.JPanel;
    import hbm.Game.GUI.Tools.CustomButton;
    import org.aswing.JLabel;
    import hbm.Engine.Resource.AdditionalDataResourceLibrary;
    import hbm.Engine.Resource.LocalizationResourceLibrary;
    import hbm.Engine.Resource.ItemsResourceLibrary;
    import flash.display.Bitmap;
    import org.aswing.SoftBoxLayout;
    import org.aswing.border.EmptyBorder;
    import org.aswing.Insets;
    import org.aswing.EmptyLayout;
    import hbm.Engine.Resource.ResourceManager;
    import org.aswing.AssetBackground;
    import org.aswing.geom.IntPoint;
    import org.aswing.geom.IntDimension;
    import hbm.Application.ClientApplication;
    import org.aswing.AssetIcon;
    import hbm.Game.GUI.Tools.CustomToolTip;
    import hbm.Engine.Actors.ItemData;
    import flash.events.Event;

    public class CraftRunePanel extends JPanel 
    {

        private var _itemSlot:CraftItemSlot;
        private var _rune1Slot:CraftRuneSlot;
        private var _rune2Slot:CraftRuneSlot;
        private var _resultSlot:CraftRuneSlot;
        private var _buttonCreate:CustomButton;
        private var _itemDesc:JLabel;
        private var _dataLibrary:AdditionalDataResourceLibrary;
        private var _localizationLibrary:LocalizationResourceLibrary;
        private var _itemsLibrary:ItemsResourceLibrary;
        private var _runeTreeLeft:JPanel = null;
        private var _runeTreeRight:JPanel = null;
        private var _runeTreeLeftOnAsset:Bitmap = null;
        private var _runeTreeRightOn1Asset:Bitmap = null;
        private var _runeTreeRightOn2Asset:Bitmap = null;
        private var _runeTreeLeftOffAsset:Bitmap = null;
        private var _runeTreeRightOffAsset:Bitmap = null;
        private var _buttonCreatIcon:Bitmap = null;
        private var _buttonCreatIconActive:Bitmap = null;
        private var _runesInSlots:Array = new Array(false, false);
        private var _itemInSlot:Boolean = false;

        public function CraftRunePanel()
        {
            this.InitUI();
            this.Revalidate();
        }

        protected function InitUI():void
        {
            setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 2, SoftBoxLayout.CENTER));
            setBorder(new EmptyBorder(null, new Insets(0, 0, 0, 0)));
            var _local_1:JPanel = new JPanel(new EmptyLayout());
            this._localizationLibrary = LocalizationResourceLibrary(ResourceManager.Instance.Library("Localization"));
            this._dataLibrary = AdditionalDataResourceLibrary(ResourceManager.Instance.Library("AdditionalData"));
            this._itemsLibrary = ItemsResourceLibrary(ResourceManager.Instance.Library("Items"));
            this._runeTreeLeftOnAsset = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_Stash_RunesTreeLeftOn");
            this._runeTreeLeftOffAsset = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_Stash_RunesTreeLeftOff");
            this._runeTreeRightOn1Asset = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_Stash_RunesTreeRightOn1");
            this._runeTreeRightOn2Asset = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_Stash_RunesTreeRightOn2");
            this._runeTreeRightOffAsset = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_Stash_RunesTreeRightOff");
            var _local_2:Bitmap = this._dataLibrary.GetBitmapAsset("AdditionalData_Item_Stash_Runes");
            if (_local_2)
            {
                _local_1.setBackgroundDecorator(new AssetBackground(_local_2));
                _local_1.setPreferredHeight(_local_2.height);
                _local_1.setPreferredWidth(_local_2.width);
                _local_1.setMaximumHeight(_local_2.height);
                _local_1.setMaximumWidth(_local_2.width);
            };
            this._runeTreeLeft = new JPanel();
            this._runeTreeLeft.setLocationXY((83 + 30), 50);
            this._runeTreeLeft.setBackgroundDecorator(new AssetBackground(this._runeTreeLeftOffAsset));
            this._runeTreeLeft.setSizeWH(this._runeTreeLeftOffAsset.width, this._runeTreeLeftOffAsset.height);
            this._runeTreeRight = new JPanel();
            this._runeTreeRight.setLocationXY((230 + 30), 50);
            this._runeTreeRight.setSizeWH(this._runeTreeRightOffAsset.width, this._runeTreeRightOffAsset.height);
            this._runeTreeRight.setBackgroundDecorator(new AssetBackground(this._runeTreeRightOffAsset));
            this._rune1Slot = new CraftRuneSlot(0);
            this._rune1Slot.Revalidate();
            this._rune1Slot.setLocation(new IntPoint((111 + 30), 60));
            this._rune2Slot = new CraftRuneSlot(1);
            this._rune2Slot.Revalidate();
            this._rune2Slot.setLocation(new IntPoint((111 + 30), 104));
            this._itemSlot = new CraftItemSlot();
            this._itemSlot.Revalidate();
            this._itemSlot.setLocation(new IntPoint((252 + 30), 83));
            this._itemDesc = new JLabel("", null, JLabel.CENTER);
            this._itemDesc.setSize(new IntDimension(300, 20));
            this._itemDesc.setLocation(new IntPoint((115 + 35), 136));
            this._resultSlot = new CraftRuneSlot(2);
            this._resultSlot.Revalidate();
            this._resultSlot.setLocation(new IntPoint((389 + 30), 83));
            this._resultSlot.setDropTrigger(false);
            this._buttonCreate = new CustomButton(ClientApplication.Localization.CRAFTCARD_CREATE_BUTTON);
            this._buttonCreatIcon = this._dataLibrary.GetBitmapAsset("Localization_Item_Stash_CraftButton");
            this._buttonCreatIconActive = this._dataLibrary.GetBitmapAsset("Localization_Item_Stash_CraftButtonActive");
            this._buttonCreate.setSize(new IntDimension(this._buttonCreatIcon.width, this._buttonCreatIcon.height));
            this._buttonCreate.setLocation(new IntPoint((210 + 30), 168));
            this._buttonCreate.setBackgroundDecorator(null);
            this._buttonCreate.setIcon(new AssetIcon(this._buttonCreatIcon));
            this._buttonCreate.setRollOverIcon(new AssetIcon(this._dataLibrary.GetBitmapAsset("Localization_Item_Stash_CraftButtonOver")));
            this._buttonCreate.setPressedIcon(new AssetIcon(this._dataLibrary.GetBitmapAsset("Localization_Item_Stash_CraftButtonPressed")));
            var _local_3:CustomToolTip = new CustomToolTip(this._buttonCreate, ClientApplication.Instance.GetPopupText(199), 250, 30);
            this._buttonCreate.addActionListener(this.OnCreate, 0, true);
            _local_1.append(this._runeTreeLeft);
            _local_1.append(this._runeTreeRight);
            _local_1.append(this._itemSlot);
            _local_1.append(this._rune1Slot);
            _local_1.append(this._rune2Slot);
            _local_1.append(this._resultSlot);
            _local_1.append(this._itemDesc);
            _local_1.append(this._buttonCreate);
            var _local_4:JLabel = new JLabel(ClientApplication.Localization.CRAFTCARD_WINDOW_TITLE, null);
            _local_1.append(_local_4);
            _local_4.setLocationXY((220 + 30), 10);
            _local_4.setSizeWH(100, 25);
            append(_local_1);
            addEventListener(SlotEvent.SLOT_EVENT, this.OnSlotEvent, false, 0, true);
        }

        public function Revalidate():void
        {
            var _local_1:Object;
            var _local_2:Object;
            var _local_3:ItemData;
            var _local_4:Object;
            this._itemDesc.setText("");
            if ((((this._rune1Slot.Item) && (this._rune1Slot.Item.Item.Type == ItemData.IT_CARD)) && (this._rune1Slot.Item.Item.Amount > 1)))
            {
                this._rune2Slot.SetItem(this._rune1Slot.Item.Item);
                this._rune2Slot.Revalidate();
            };
            if ((((this._rune2Slot.Item) && (this._rune2Slot.Item.Item.Type == ItemData.IT_CARD)) && (this._rune2Slot.Item.Item.Amount > 1)))
            {
                this._rune1Slot.SetItem(this._rune2Slot.Item.Item);
                this._rune1Slot.Revalidate();
            };
            if (((this._itemSlot.Item) && (this._itemSlot.Item.Item.Amount >= 1)))
            {
                _local_1 = this._dataLibrary.GetCardCraftItemData(this._itemSlot.Item.Item.NameId);
                if (_local_1)
                {
                    this._itemDesc.setText((((ClientApplication.Localization.CRAFTCARD_CREATE_PERCENT + ": ") + _local_1.Percent) + "%"));
                };
            };
            if ((((this._rune1Slot.Item) && (this._rune2Slot.Item)) && (this._itemSlot.Item)))
            {
                _local_2 = this._dataLibrary.GetCardCraftData(this._rune1Slot.Item.Item.NameId, this._rune2Slot.Item.Item.NameId);
                if (_local_2)
                {
                    _local_3 = new ItemData();
                    _local_3.Amount = 1;
                    _local_3.NameId = _local_2.Result;
                    _local_3.Identified = 1;
                    _local_3.Origin = ItemData.QUEST;
                    _local_4 = this._itemsLibrary.GetServerDescriptionObject(_local_3.NameId);
                    _local_3.Type = _local_4["type"];
                    this._resultSlot.SetItem(_local_3);
                    this._resultSlot.Revalidate();
                    this._resultSlot.Item.setDragEnabled(false);
                    this._buttonCreate.setEnabled(true);
                }
                else
                {
                    this._itemDesc.setText(ClientApplication.Localization.CRAFTCARD_CREATE_FAIL);
                };
            }
            else
            {
                this._resultSlot.SetItem(null);
                this._resultSlot.Revalidate();
                this._buttonCreate.setEnabled(false);
            };
        }

        public function ClearCraftItemSlot():void
        {
            this._itemSlot.SetItem(null);
            this._itemSlot.Revalidate();
            this._itemDesc.setText("");
        }

        public function SetCraftRuneSlot(_arg_1:ItemData):void
        {
            this._rune1Slot.SetItem(_arg_1);
            this._rune1Slot.Revalidate();
            this._rune2Slot.SetItem(_arg_1);
            this._rune2Slot.Revalidate();
        }

        public function ClearRuneCraftSlots():void
        {
            this._rune1Slot.SetItem(null);
            this._rune1Slot.Revalidate();
            this._rune2Slot.SetItem(null);
            this._rune2Slot.Revalidate();
        }

        private function OnCreate(_arg_1:Event):void
        {
            if ((((this._itemSlot.Item) && (this._rune1Slot.Item)) && (this._rune2Slot.Item)))
            {
                ClientApplication.Instance.LocalGameClient.SendCraftCard(this._rune1Slot.Item.Item.NameId, this._itemSlot.Item.Item.NameId);
            };
        }

        private function OnSlotEvent(_arg_1:SlotEvent):void
        {
            var _local_2:Boolean;
            var _local_3:int;
            if (_arg_1.slotIndex >= this._runesInSlots.length)
            {
                return;
            };
            if (_arg_1.slotType == SlotEvent.CRAFT_RUNE)
            {
                this._runesInSlots[_arg_1.slotIndex] = _arg_1.itemInSlot;
                _local_2 = true;
                _local_3 = 0;
                while (_local_3 < this._runesInSlots.length)
                {
                    if (!this._runesInSlots[_local_3])
                    {
                        _local_2 = false;
                        break;
                    };
                    _local_3++;
                };
                if (_local_2)
                {
                    this._runeTreeLeft.setBackgroundDecorator(new AssetBackground(this._runeTreeLeftOnAsset));
                }
                else
                {
                    this._runeTreeLeft.setBackgroundDecorator(new AssetBackground(this._runeTreeLeftOffAsset));
                };
            }
            else
            {
                if (_arg_1.slotType == SlotEvent.CRAFT_ITEM)
                {
                    this._itemInSlot = _arg_1.itemInSlot;
                    if (this._itemInSlot)
                    {
                        this._runeTreeRight.setBackgroundDecorator(new AssetBackground(this._runeTreeRightOn1Asset));
                        this._runeTreeRight.setSizeWH(this._runeTreeRightOn1Asset.width, this._runeTreeRightOn1Asset.height);
                    }
                    else
                    {
                        this._runeTreeRight.setBackgroundDecorator(new AssetBackground(this._runeTreeRightOffAsset));
                        this._runeTreeRight.setSizeWH(this._runeTreeRightOffAsset.width, this._runeTreeRightOffAsset.height);
                    };
                };
            };
            if (((_local_2) && (this._itemInSlot)))
            {
                this._runeTreeRight.setBackgroundDecorator(new AssetBackground(this._runeTreeRightOn2Asset));
                this._runeTreeRight.setSizeWH(this._runeTreeRightOn2Asset.width, this._runeTreeRightOn2Asset.height);
                this._buttonCreate.setIcon(new AssetIcon(this._buttonCreatIconActive));
            }
            else
            {
                this._buttonCreate.setIcon(new AssetIcon(this._buttonCreatIcon));
            };
            _arg_1.stopPropagation();
        }


    }
}//package hbm.Game.GUI.CashShop.Stash

